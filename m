Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6644FF829
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiDMNvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiDMNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:51:51 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF8DF34
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:49:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c9b8:20d3:ee2b:1cda])
        by andre.telenet-ops.be with bizsmtp
        id JDpP2700S2t8Arn01DpP2a; Wed, 13 Apr 2022 15:49:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nedN4-000Seb-Up; Wed, 13 Apr 2022 15:49:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nedN4-00AjDf-Fl; Wed, 13 Apr 2022 15:49:22 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] memory: renesas-rpc-if: Simplify single/double data register access
Date:   Wed, 13 Apr 2022 15:49:21 +0200
Message-Id: <c3b2a8d1a69f1b1e8d1a460148406cfb83e52eb4.1649857740.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For manual write and read, factor out the common access to the first
data register by keeping track of the current data pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
  - Add Tested-by, Reviewed-by,
  - Remove unneeded pointer post-increments from final dereferences.
---
 drivers/memory/renesas-rpc-if.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 019a0822bde0e413..ba9c526833c0f4da 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -488,7 +488,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 	case RPCIF_DATA_OUT:
 		while (pos < rpc->xferlen) {
 			u32 bytes_left = rpc->xferlen - pos;
-			u32 nbytes, data[2];
+			u32 nbytes, data[2], *p = data;
 
 			smcr = rpc->smcr | RPCIF_SMCR_SPIE;
 
@@ -502,15 +502,9 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			rpc->xfer_size = nbytes;
 
 			memcpy(data, rpc->buffer + pos, nbytes);
-			if (nbytes == 8) {
-				regmap_write(rpc->regmap, RPCIF_SMWDR1,
-					     data[0]);
-				regmap_write(rpc->regmap, RPCIF_SMWDR0,
-					     data[1]);
-			} else {
-				regmap_write(rpc->regmap, RPCIF_SMWDR0,
-					     data[0]);
-			}
+			if (nbytes == 8)
+				regmap_write(rpc->regmap, RPCIF_SMWDR1, *p++);
+			regmap_write(rpc->regmap, RPCIF_SMWDR0, *p);
 
 			regmap_write(rpc->regmap, RPCIF_SMCR, smcr);
 			ret = wait_msg_xfer_end(rpc);
@@ -552,7 +546,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 		}
 		while (pos < rpc->xferlen) {
 			u32 bytes_left = rpc->xferlen - pos;
-			u32 nbytes, data[2];
+			u32 nbytes, data[2], *p = data;
 
 			/* nbytes may only be 1, 2, 4, or 8 */
 			nbytes = bytes_left >= max ? max : (1 << ilog2(bytes_left));
@@ -569,15 +563,9 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			if (ret)
 				goto err_out;
 
-			if (nbytes == 8) {
-				regmap_read(rpc->regmap, RPCIF_SMRDR1,
-					    &data[0]);
-				regmap_read(rpc->regmap, RPCIF_SMRDR0,
-					    &data[1]);
-			} else {
-				regmap_read(rpc->regmap, RPCIF_SMRDR0,
-					    &data[0]);
-			}
+			if (nbytes == 8)
+				regmap_read(rpc->regmap, RPCIF_SMRDR1, p++);
+			regmap_read(rpc->regmap, RPCIF_SMRDR0, p);
 			memcpy(rpc->buffer + pos, data, nbytes);
 
 			pos += nbytes;
-- 
2.25.1

