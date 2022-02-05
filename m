Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5CE4AA9D2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380311AbiBEQBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiBEQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA833C061348;
        Sat,  5 Feb 2022 08:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D581B80835;
        Sat,  5 Feb 2022 16:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADE7C340E8;
        Sat,  5 Feb 2022 16:01:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mMyY60rv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644076892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Ks2qbXC4SyzA3IA3jZHOmVL4Kh1ZcaIvlQa1ZmJj4s=;
        b=mMyY60rvtq6H1twnTrUgIwNwstZQBjmq+mkPGWpw+qT86JnKI5FnNxdBxfETMsASgrR9Gf
        1vF/li16WCjc9xFZfOl1nIJDudW6ZuPbMLLYrveQjnFV6jzjYg6/5/pp5QWfwTajbSSY40
        u1q8iZj8gZlF/Ji5g718U/vBYUprxEI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 483f047f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Feb 2022 16:01:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 0/5] random: use computational hash for entropy extraction, and related fixes
Date:   Sat,  5 Feb 2022 17:01:13 +0100
Message-Id: <20220205160118.252698-1-Jason@zx2c4.com>
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

The bulk of the motivation for this and description of crypto
vulnerabilities is in the first patch of this series. The following
three patches then fix up entropy accounting for the new model. The last
patch fixes a minor code safety issue.

This v3 fixes comments and commit message wording, simplifies a bit of
code in a cmpxchg loop, and adjusts semantics around the poll write
wakeup threshold.

Jason A. Donenfeld (5):
  random: use computational hash for entropy extraction
  random: simplify entropy debiting
  random: use linear min-entropy accumulation crediting
  random: always wake up entropy writers after extraction
  random: make credit_entropy_bits() always safe

 drivers/char/random.c         | 501 ++++++----------------------------
 include/trace/events/random.h |  30 +-
 2 files changed, 87 insertions(+), 444 deletions(-)

-- 
2.35.0

