Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB24E35CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiCVAyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiCVAyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821601B79B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7596615C1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE94C340E8;
        Tue, 22 Mar 2022 00:53:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LaVEh2GN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647910387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UNqa91jv85g1W+RoXaL5qHyr70XERnNNsnCLvPt0CwM=;
        b=LaVEh2GNUF3W2I+UctON+bK+ZHwPklX8T89pfmDdDnElPruvFdH/Ieg0a/kGJoy+/rSrD0
        wQ12t+SSN+p+GX6IWclKI0VL8Gnhy13woXazIq7PMa9UzoRwY306nke4LVlcyCw1Vc0TM3
        QpEK1C2GiEhgOH8f/J1aLlNCEnY4PV0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 77ea47f6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 00:53:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: skip fast_init if hwrng provides large chunk of entropy
Date:   Mon, 21 Mar 2022 18:52:56 -0600
Message-Id: <20220322005256.3787-1-Jason@zx2c4.com>
MIME-Version: 1.0
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

At boot time, EFI calls add_bootloader_randomness(), which in turn calls
add_hwgenerator_randomness(). Currently add_hwgenerator_randomness()
feeds the first 64 bytes of randomness to the "fast init"
non-crypto-grade phase. But if add_hwgenerator_randomness() gets called
with more than POOL_MIN_BITS of entropy, there's no point in passing it
off to the "fast init" stage, since that's enough entropy to bootstrap
the real RNG. The "fast init" stage is just there to provide _something_
in the case where we don't have enough entropy to properly bootstrap the
RNG. But if we do have enough entropy to bootstrap the RNG, the current
logic doesn't serve a purpose. So, in the case where we're passed
greater than or equal to POOL_MIN_BITS of entropy, this commit makes us
skip the "fast init" phase.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0bdefada7453..78e0ed46a7cb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1118,7 +1118,7 @@ void rand_initialize_disk(struct gendisk *disk)
 void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
-	if (unlikely(crng_init == 0)) {
+	if (unlikely(crng_init == 0 && entropy < POOL_MIN_BITS)) {
 		size_t ret = crng_pre_init_inject(buffer, count, true);
 		mix_pool_bytes(buffer, ret);
 		count -= ret;
-- 
2.35.1

