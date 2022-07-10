Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83F56CEF9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiGJMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:19:19 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A5B64
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:19:19 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AVu5o1GQSAym2AVu6od0Os; Sun, 10 Jul 2022 14:19:17 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 10 Jul 2022 14:19:17 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 1/3] crypto: octeontx2: Simplify bitmap declaration
Date:   Sun, 10 Jul 2022 14:19:12 +0200
Message-Id: <a9fa76b5091f1626fa19e8e5650a95d8b2257eda.1657455515.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'OTX2_CPT_ENGS_BITMASK_LEN' is only used to allocate a bitmap.

In order to simplify the code, remove OTX2_CPT_ENGS_BITMASK_LEN and use
DECLARE_BITMAP to declare the 'bits' bitmap.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h
index e69320a54b5d..7c503e44a286 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.h
@@ -26,8 +26,6 @@
 /* Maximum number of supported engines/cores on OcteonTX2/CN10K platform */
 #define OTX2_CPT_MAX_ENGINES        144
 
-#define OTX2_CPT_ENGS_BITMASK_LEN   BITS_TO_LONGS(OTX2_CPT_MAX_ENGINES)
-
 #define OTX2_CPT_UCODE_SZ           (64 * 1024)
 
 /* Microcode types */
@@ -48,7 +46,7 @@ enum otx2_cpt_ucode_type {
 };
 
 struct otx2_cpt_bitmap {
-	unsigned long bits[OTX2_CPT_ENGS_BITMASK_LEN];
+	DECLARE_BITMAP(bits, OTX2_CPT_MAX_ENGINES);
 	int size;
 };
 
-- 
2.34.1

