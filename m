Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F088C4AE73E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiBICqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiBIBTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:19:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9885EC061576;
        Tue,  8 Feb 2022 17:19:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59A80B81E2D;
        Wed,  9 Feb 2022 01:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC40C340EB;
        Wed,  9 Feb 2022 01:19:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O0ZcQX9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644369590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=muXktWPwK3DXgvGz5zZKW5xbimKtTXaNSyPW53UCMxA=;
        b=O0ZcQX9E98Ro83oI3AJua90Th0b6eTHZF8OPO6r+M38IeIA4iud6w0IeKwBG3jLWocZu4W
        z8uvvcj05qxGS/sn2fPdztXPfPrx50I5qeIt6wlgRyJzZqHyLdIIJ1FUEBVmibohgPwbXr
        X9WG9CLE/d2rec9DknY+ZB7MPq/JjBU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fca0fc21 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 01:19:49 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, linux@dominikbrodowski.net, ebiggers@kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 0/9] random: cleanups around per-cpu crng & rdrand
Date:   Wed,  9 Feb 2022 02:19:10 +0100
Message-Id: <20220209011919.493762-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tackles a few issues that are intermingled with each other:

- Using RDSEED when we can rather than using RDRAND.

- Making sure RDRAND/RDSEED input always goes through the mixer rather
  than being xor'd into our state directly, in part in order to prevent
  ridiculous hypothetical cpu backdoors, and in part because it makes it
  easier to model RDRAND/RDSEED as just another entropy input.

- Untangling the never ending headache that is kmalloc'd NUMA secondary
  CRNGs, and replacing these with leaner per-cpu ChaCha keys that don't
  have all the state troubles. There are other patches pending my review
  that take the current NUMA initialization code to yet another layer of
  complexity, sort of driving home the point to me that the current code
  is a can of worms. This patchset attempts a different direction there.

- Enforcing "fast key erasure" expansion always, and not relying on
  having a shared block counter that is bound to lead to troubles sooner
  or later.

- Nearly eliminating lock contention when several processes use the rng
  at the same time. WireGuard, for example, processes packets in
  parallel on all threads, and this packet processing requires frequent
  calls to get_random_bytes().

- Making sure we're never throwing away entropy from the irq handler,
  since fast key erasure means we're overwriting keys.

Because one design choice in here affects others, these issues are
tackled by this same patchset. It's roughly divided into "things with
RDSEED" and "things with struct crng", with the ordering of commits
being important.

Finally the series ends with a one-off patch removing an obsolete limit
on /dev/urandom, and making crng_slow_load() more robust.

v2 improves on v1 by adding the crng_{fast,slow}_load() improvements,
adding a lot of comments regarding fast key erasure, correcting other
comments, fixing the function signatures of two functions that return an
array, and fixing some basic logic flow in checking crng_ready().

Jason A. Donenfeld (9):
  random: use RDSEED instead of RDRAND in entropy extraction
  random: get rid of secondary crngs
  random: inline leaves of rand_initialize()
  random: ensure early RDSEED goes through mixer on init
  random: do not xor RDRAND when writing into /dev/random
  random: absorb fast pool into input pool after fast load
  random: use simpler fast key erasure flow on per-cpu keys
  random: use hash function for crng_slow_load()
  random: remove outdated INT_MAX >> 6 check in urandom_read()

 drivers/char/random.c | 699 ++++++++++++++++++------------------------
 1 file changed, 291 insertions(+), 408 deletions(-)

-- 
2.35.0
