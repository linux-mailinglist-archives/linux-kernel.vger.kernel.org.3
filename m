Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E4F5AFAB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIGDgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIGDgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:36:43 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFA488DEE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:36:33 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2873EYr7015668;
        Wed, 7 Sep 2022 11:14:34 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Sep
 2022 11:34:35 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] crypto: aspeed: fix format unexpected build warning
Date:   Wed, 7 Sep 2022 11:34:31 +0800
Message-ID: <20220907033431.402208-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2873EYr7015668
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following similar build warning when
enabling compile test:

aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
[-Wformat=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
v3: Use "%pad" to print dma_addr_t type.
v2: Use "%zu" format to print size_t.

 drivers/crypto/aspeed/aspeed-hace-hash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index 0a44ffc0e13b..5a8a3a611dd4 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -185,7 +185,7 @@ static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
 	remain = (rctx->total + rctx->bufcnt) % rctx->block_size;
 	length = rctx->total + rctx->bufcnt - remain;
 
-	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
+	AHASH_DBG(hace_dev, "%s:0x%x, %s:%zu, %s:0x%x, %s:0x%x\n",
 		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
 		  "length", length, "remain", remain);
 
@@ -324,8 +324,8 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
 	struct ahash_request *req = hash_engine->req;
 	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
 
-	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
-		  hash_engine->src_dma, hash_engine->digest_dma,
+	AHASH_DBG(hace_dev, "src_dma:%pad, digest_dma:%pad, length:%zu\n",
+		  &hash_engine->src_dma, &hash_engine->digest_dma,
 		  hash_engine->src_length);
 
 	rctx->cmd |= HASH_CMD_INT_ENABLE;
-- 
2.25.1

