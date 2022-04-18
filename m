Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10302505E82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347706AbiDRT0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiDRT0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:26:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E035AAA;
        Mon, 18 Apr 2022 12:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3255DB81087;
        Mon, 18 Apr 2022 19:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B438C385A7;
        Mon, 18 Apr 2022 19:23:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YWhKShF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650309832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kk5hlUNze06DryeQuaofQpgsNTfzrxBS9XEEASBkC+8=;
        b=YWhKShF7p8awQ3uzhSIrx2dn8nevMa+R0XtdHQpd+TJz4A/xBjAx39Y92PZQ2nS/1+xRMB
        MNEKWm3/Q31g2wRdSqyJCFKLOoHJo6DI7App7pct3SyTtf5OSb80W/1MYvWiwvB74P7eIm
        ZHjop4RKrc0iOnWJkDOsFxGwaK+ZmvM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e3311f9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 18 Apr 2022 19:23:52 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] random: document crng_fast_key_erasure() destination possibility
Date:   Mon, 18 Apr 2022 21:23:44 +0200
Message-Id: <20220418192344.1510712-1-Jason@zx2c4.com>
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

This reverts 35a33ff3807d ("random: use memmove instead of memcpy for
remaining 32 bytes"), which was made on a totally bogus basis. The thing
it was worried about overlapping came from the stack, not from one of
its arguments, as Eric pointed out.

But the fact that this confusion even happened draws attention to the
fact that it's a bit non-obvious that the random_data parameter can
alias chacha_state, and in fact should do so when the caller can't rely
on the stack being cleared in a timely manner. So this commit documents
that.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3a293f919af9..87302e85759f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -318,6 +318,13 @@ static void crng_reseed(bool force)
  * the resultant ChaCha state to the user, along with the second
  * half of the block containing 32 bytes of random data that may
  * be used; random_data_len may not be greater than 32.
+ *
+ * The returned ChaCha state contains within it a copy of the old
+ * key value, at index 4, so that state should always be zeroed
+ * out immediately after using in order to maintain forward secrecy.
+ * If that state cannot be erased in a timely manner, then it is
+ * safer to set the random_data parameter to &chacha_state[4] so
+ * that this function overwrites it before returning.
  */
 static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 				  u32 chacha_state[CHACHA_STATE_WORDS],
@@ -333,7 +340,7 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 	chacha20_block(chacha_state, first_block);
 
 	memcpy(key, first_block, CHACHA_KEY_SIZE);
-	memmove(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
+	memcpy(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
 	memzero_explicit(first_block, sizeof(first_block));
 }
 
-- 
2.35.1

