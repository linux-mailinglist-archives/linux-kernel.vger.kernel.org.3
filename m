Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67822590D45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiHLISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:18:33 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5B6EA5C47;
        Fri, 12 Aug 2022 01:18:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 20EFC1E80D0E;
        Fri, 12 Aug 2022 16:16:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9IaXjR9GodCK; Fri, 12 Aug 2022 16:16:15 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: junming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6862D1E80CB7;
        Fri, 12 Aug 2022 16:16:15 +0800 (CST)
From:   shijm <junming@nfschina.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shi junming <junming@nfschina.com>
Subject: [PATCH] block: remove unnecessary (void *) conversions
Date:   Fri, 12 Aug 2022 16:18:23 +0800
Message-Id: <20220812081823.26716-1-junming@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shi junming <junming@nfschina.com>

void * is not necessary,remove unnecessary (void *) conversions.

Signed-off-by: Shi junming <junming@nfschina.com>
---
 block/blk-crypto-fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 7c854584b52b..586cce5b3cc9 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -516,7 +516,7 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 	f_ctx->crypt_iter = bio->bi_iter;
 	f_ctx->bi_private_orig = bio->bi_private;
 	f_ctx->bi_end_io_orig = bio->bi_end_io;
-	bio->bi_private = (void *)f_ctx;
+	bio->bi_private = f_ctx;
 	bio->bi_end_io = blk_crypto_fallback_decrypt_endio;
 	bio_crypt_free_ctx(bio);
 
-- 
2.18.2

