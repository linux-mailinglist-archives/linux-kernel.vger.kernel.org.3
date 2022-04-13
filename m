Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82B85002D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiDMX7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiDMX7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09B55497
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B7B2B81D4F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 23:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636EBC385A6;
        Wed, 13 Apr 2022 23:57:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lhsUYB2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649894222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JwHV+Hu2gg38Lj8PLIs1tsW79OR6kKaN6QsMNgG3EKE=;
        b=lhsUYB2rebBqJmnZOr2D+TzV5c84l/2sgpnMH2iWxgGsfZCd80apK4BcMmS5yua+GxfFMt
        Wmkwjw72XRIcQn6/6B9DghYLAAXm02ORPJ7ZQ/Eg/9rByoC1tQwY6ldPf4IKwykfZn5pq5
        BMLlP+E4ac6YmHxFRrdMs9s8hrrNF+0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7ff42d16 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Apr 2022 23:57:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: use memmove instead of memcpy for remaining 32 bytes
Date:   Thu, 14 Apr 2022 01:56:49 +0200
Message-Id: <20220413235649.97640-1-Jason@zx2c4.com>
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

In order to immediately overwrite the old key on the stack, before
servicing a userspace request for bytes, we use the remaining 32 bytes
of block 0 as the key. This means moving indices 8,9,a,b,c,d,e,f ->
4,5,6,7,8,9,a,b. Since 4 < 8, for the kernel implementations of
memcpy(), this doesn't actually appear to be a problem in practice. But
relying on that characteristic seems a bit brittle. So let's change that
to a proper memmove(), which is the by-the-books way of handling
overlapping memory copies.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 6b01b2be9dd4..3a293f919af9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -333,7 +333,7 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 	chacha20_block(chacha_state, first_block);
 
 	memcpy(key, first_block, CHACHA_KEY_SIZE);
-	memcpy(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
+	memmove(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
 	memzero_explicit(first_block, sizeof(first_block));
 }
 
-- 
2.35.1

