Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518EF4ADDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382081AbiBHPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiBHPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:53:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C10C061576;
        Tue,  8 Feb 2022 07:53:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFF24B81BB6;
        Tue,  8 Feb 2022 15:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8EBC004E1;
        Tue,  8 Feb 2022 15:53:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KgOaLJuX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644335630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7WdvsupJdgb02tFllxTDejawu9jJwAOqDkmQGoFjpDI=;
        b=KgOaLJuXsL9g/L6XrNjjCcFOymdPFv8E+EYQF/n1QlFMm5qqSbM7lkjuvNGDyzmTN2rjY/
        dtW4Fy4FJb2nkRatJKt9B366CooYFFFaQ8eI6IVI2/Se5h82bXG35HPQfeSlkMsBcyWaZM
        IgDvo7tAYp4oPuJvQDZhKeqf2Va57DA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24f34386 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Feb 2022 15:53:50 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v1 0/7] random: cleanups around per-cpu crng & rdrand
Date:   Tue,  8 Feb 2022 16:53:28 +0100
Message-Id: <20220208155335.378318-1-Jason@zx2c4.com>
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

Because one design choice in here affects others, these issues are
tackled by this same patchset. It's roughly divided into "things with
RDSEED" and "things with struct crng", with the ordering of commits
being important.

Finally the series ends with a one-off patch removing an obsolete limit
on /dev/urandom.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>

Jason A. Donenfeld (7):
  random: use RDSEED instead of RDRAND in entropy extraction
  random: get rid of secondary crngs
  random: inline leaves of rand_initialize()
  random: ensure early RDSEED goes through mixer on init
  random: do not xor RDRAND when writing into /dev/random
  random: use simpler fast key erasure flow on per-cpu keys
  random: remove outdated INT_MAX >> 6 check in urandom_read()

 drivers/char/random.c | 566 +++++++++++++++++-------------------------
 1 file changed, 231 insertions(+), 335 deletions(-)

-- 
2.35.0

