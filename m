Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1B5AD409
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiIENfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiIENfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:35:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66594A823
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ5AC86Ywwn8Hf1T4PKaMc+Fw4ofq0mP8n1nsI1Y/2vD1hPhEesk69ZQABQ/qd2v4MliMajxn9/plpuVoFLBawzEHO+bb0ZJ3FhQ4PKIa8rqJGrfSFmK8YuJNkuEQWLrjzv8OVZeWkMJUp/Jy05D27Tqapn4rsE6kcHLUisAzIzOK2Y2osxbH4Ca2uiC8RQp69+KdN8P0gsDuUdbOsPoZ/qIVvw3CfpStseTseRzJrgxjN887yyNpk0IxD0+79RWDesTR7iOO57ILPVMFcWTG9NADCWRVLS4QdCsjcBSP5JfyQ26RUiRLEQTz60jxMRD8pY4JhIwquxf+/WLvMUfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6FQW9hNUjaVzqCmSWBiXp+ijFABj5QYHO3sceWPnqI=;
 b=MVJnLOOuCSIKEM8qdoDghaBjEQc818Lixi8FlDZOmZ0DauHIwdtmNS+G6XkBR0/jswp0kXQeQ6EMc+xOJsbXfjSGA7dRaGiVV0Fs7HjnHtjb1CYCZEymB+1tKYWyfKsgGpBOfVUz1d+AuBaBVxgF4klAT66xXi/aTwtsq4SN+MD8bobn+fwby7Ex0Zmhtz2VnMcXum7AG4lu5OazSyRT9ALqm6Xg/wZ9zMRg4rXaf0ey/7Pch9IuLKvQlhdeF88OU56zlIqBWIsdKNFi8LzgRnl9nQu4kquV1xpWFBXyzmfrfDvmshUPbdeAE111c/GvjFBpQUp+yHnv2LdLBVAnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6FQW9hNUjaVzqCmSWBiXp+ijFABj5QYHO3sceWPnqI=;
 b=jewVn4cBl5ae/UwtQgfo85bKnVhRS4uOT/RB5d+mT1uQQPXJjazqKBVpRxKYc55QZPfHngPbBJApITTA2dWHd4XnjHwxDL//Qx8s/UyV+Uio3PXpQhP5WJv3eL/DpWy0MUYFO44hdNEQIy36s5m+gMex3+9QXduhMrGnrgKko44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:35:04 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:35:04 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 7/8] caam alg: symmetric key ciphers are updated
Date:   Mon,  5 Sep 2022 20:06:30 +0530
Message-Id: <20220905143631.2832-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2efeaea3-1928-4f7c-2542-08da8f4370a4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUyd8wIkuOcXVIzFu/7UihEegU5Qpq1kvScwAzNAooOQoe55ABSUGNgeXdkPIrtoC/Bq/aiBIE5Ykd06PrrdZk59ntf1xUr5m/8vYcEOgwHKyCeAHx++O64ZzQmeeU6n9+1kvQV5PsNU24HdnTIveDANOEgz33vA8ZcJ0VIJSUCv/aU8w4AzpGozgvibYZFY3Z7IZFN24fNC4P/OROEcKFz42p2jf3aL1wzvcoBQqLMCrtzok3PPORg+LcQObfV5nRFz+S+mG2uHI2Gp14ZlwB0SccKEcdWQpRFTXJ9iGFt5h6spxvn33HyWQa1b0MxljVwtGhv2xTXQFOES6G0mJHZv2Mzk5yU9FIMCvW36jAWCTG7O3tRGsGbnOo3NCXi82+T1XpGYhI5996FaKI5jLH8DiJmxX5oXmFxNK8Nc7tX7XykQdCZSN28Ks0QMwdv4HoxlJfbdTA+f20tYNEZoHMxZ3YbZxJux6F8s/BYV/J5JPJrGVJNLUtZLQVO9rdn+M4w3FZDi5bexkDFaqRBecFJ4+1ScHAHDbFV+BLoV8/qxC7WfNj+rf+wN5l2nD7a+e/N2oGzD7dxDtPT6BAVt8b5NJyKmEghqR12hKNhggSEN3mY5I+DNk69pmgCLml/1qOmTjBWxEG46UyyzMM3fV1F85s+w2320cmii2R/jHS1eU0HY+lh7bMO34vY7UPWOeO5iJSfx/fwAL5wRR7n02iYf79jFKDOoMTKxBZCenTAk3l3gszDGnUwCEl/gdzHltMFjXMSe8aIEhRoU2IaA3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOm6J4A5mxHNHwLo6RhcrLl6c7w91SqU17vnpjq94ux7bhwo+fUa9ijYkz7m?=
 =?us-ascii?Q?h/k6U7LtwEF4TI2Xq7Sh0c+IXH1wIpk+3Q11ywH7MkrSCZfH8y3G2NNloyMG?=
 =?us-ascii?Q?2gNjduuB7lCTmnpsCegTkA4yl18td+grGiCr21bh/XHKUHE0+zgMgTIzYEqm?=
 =?us-ascii?Q?FmEHkvWm9X5+I650pLLsPPGvZh5/FmfN5AP9cFci2Vc209BNSsfAcFxYyJqU?=
 =?us-ascii?Q?qj4h1YWphPnKnhjVqkxyrbvrHmXg4cvZs5AO8VWtYYzvJonquagHNk4w/+n2?=
 =?us-ascii?Q?tUrdsJkaWG+AuRWGXMrBg5nyvfP+kYJiLYKBNRl69bSJHQP6sj3KOQJmyKey?=
 =?us-ascii?Q?f4nKxXcexN9AuPoIrEQZ7K21443/t6SNRoxiT3+oSFRzQg/FvtKGXUES7Bsg?=
 =?us-ascii?Q?LHd54tELEhSrxsAE2IFR95ZKfRFqX8q+yujX+59node07NWtOdjVfvFpU877?=
 =?us-ascii?Q?P+GQlMukBFFMOtO1OfBwtPNsTWJ0An3LHYiGmpczywF7tRH7dJlhkghgPIBB?=
 =?us-ascii?Q?5yeEzsO6kVu1tWOKNGHlH9vFN+ny+KXRE2VGmMn6pH+4T8yKpHsKLeDobN6x?=
 =?us-ascii?Q?33qSzrJA94I8zxe4BqBVANJ6QE8LmqVal4b0LVefcUCv4OmUx9Td7cBzfVDN?=
 =?us-ascii?Q?C+HNWukAYTQEF6E7sejSCVzHGZ/lWzL5DAUnHbQ8boBM5z2R4jKXE7RXO8lk?=
 =?us-ascii?Q?3KJeJqUV0Zdbnwr0ktI5i7P1PFlF3EwntMJzt9Smmj/LZtTxM0p0LwBCbquE?=
 =?us-ascii?Q?41c5lhwjQI0X5UpiOWQNBwy/O9DuojD1g1gA3QIioZWEiYZvOUcrO+5Rky6A?=
 =?us-ascii?Q?HCTBtmNnnILXf+SerTwJpn3KVQEQSwZKf1vmVrv7OtfdPeuh05KPUhsxJ0WS?=
 =?us-ascii?Q?erOdbHXO/uDJAFL/KRcpBeN+zMSl6wVnAi5kW3lxRspVF60hJKbIBr+1ayX0?=
 =?us-ascii?Q?AhxONIyjakn+tJ3Gjn7yV8qz9lUgl2C5Bss2HP3xrafMA9u0BrQBQbRXRLyM?=
 =?us-ascii?Q?0SHdalBdSAK89KwnqZMdvuXxtnyy/ER/7UEjtnjOlisIgC+SyzLvtlTaFnfU?=
 =?us-ascii?Q?OicXcnWxeAWDID2yM9LBkpfD4bNLXKC/7PcUVYXLi4PD4HMJB4N/SqPsVBRl?=
 =?us-ascii?Q?oY2ZkJxM09M79sWJtwAF2Gv6cSZYOnD0oPmnW0SklAvMuGCJ9Yw8KSVqOTda?=
 =?us-ascii?Q?DmOV/i9uALeiI5GT3wSq6cCgcYouu0tPUxLD4Ih+yK5hvuID9LvugeFaUnX7?=
 =?us-ascii?Q?QGd94iNbCgONVtyNY8uKchOSQ1U4QeOA/oDZF4Z5LmtL39hz5uxjIzfaqkvg?=
 =?us-ascii?Q?WLtCQwyLdTWIXC0XtCvCZxFCB4jGh6d7uiKflX0QZmExLfst9oCdsBDA/pDF?=
 =?us-ascii?Q?j9LlqJ/MpZqLGpwuSSPi8Wa5r3MFR0FTOXZmjLklK01GDKYKj6jB+95VC9++?=
 =?us-ascii?Q?oL+VND6aHuu5EAyeJuEmf3I4n0cY9hvK82XPKBVp+gWnxXfU58KQFhAXwFPA?=
 =?us-ascii?Q?cvMc1FC772/HHBflOPpp3JPXbWWW9rhDCBgMLgip/EEHPPNIDbbyl+lfAgQ5?=
 =?us-ascii?Q?HYZ3g3envpaj9rWT+bbIno13G3vsp4c4w3VqPYd2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efeaea3-1928-4f7c-2542-08da8f4370a4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:35:04.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0W6MeQrqP7BZRILmieH/2ZVOV/LlE/w9EdUiAEHmemRKzHXsC3aR/7AYcefVqy8zvW0bNDw3sF2m+kZMk6ISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to enable:
- To work both with black key and plain key.
- It is supported in context of symmetric key ciphers only.
- Based on as crypto layer's flag: tfm->is_hbk, handling for
  h/w bound key is done.
- Otherwise, work as previously.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/caamalg.c      | 37 ++++++++++++++++++++++++++++--
 drivers/crypto/caam/caamalg_desc.c |  8 ++++---
 drivers/crypto/caam/desc_constr.h  |  6 ++++-
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d3d8bb0a6990..2c96aecab627 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -3,7 +3,7 @@
  * caam - Freescale FSL CAAM support for crypto API
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2016-2019 NXP
+ * Copyright 2016-2022 NXP
  *
  * Based on talitos crypto API driver.
  *
@@ -59,6 +59,7 @@
 #include <crypto/engine.h>
 #include <crypto/xts.h>
 #include <asm/unaligned.h>
+#include <soc/fsl/caam-blob.h>
 
 /*
  * crypto alg
@@ -734,6 +735,7 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 		container_of(crypto_skcipher_alg(skcipher), typeof(*alg),
 			     skcipher);
 	struct device *jrdev = ctx->jrdev;
+	struct caam_drv_private *ctrlpriv;
 	unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 	u32 *desc;
 	const bool is_rfc3686 = alg->caam.rfc3686;
@@ -741,9 +743,26 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
+	/* Here keylen is actual key length */
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
 	ctx->cdata.key_inline = true;
+	/* Here real key len is plain key length */
+	ctx->cdata.key_real_len = keylen;
+	ctx->cdata.key_cmd_opt = 0;
+
+	/* check if the key is HBK */
+	if (skcipher->base.is_hbk) {
+		ctrlpriv = dev_get_drvdata(jrdev->parent);
+		ctx->cdata.key_cmd_opt |= KEY_ENC;
+
+		/* check if the HBK is CCM key */
+		if (ctrlpriv->blob_priv.hbk_flags
+				& HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			ctx->cdata.key_cmd_opt |= KEY_EKT;
+			ctx->cdata.key_real_len = keylen - CCM_OVERHEAD;
+		}
+	}
 
 	/* skcipher_encrypt shared descriptor */
 	desc = ctx->sh_desc_enc;
@@ -766,8 +785,22 @@ static int aes_skcipher_setkey(struct crypto_skcipher *skcipher,
 			       const u8 *key, unsigned int keylen)
 {
 	int err;
+	int overhead = 0;
+	struct caam_ctx *ctx;
+	struct device *jrdev;
+	struct caam_drv_private *ctrlpriv;
+
+	if (skcipher->base.is_hbk) {
+		ctx = crypto_skcipher_ctx(skcipher);
+		jrdev = ctx->jrdev;
+		ctrlpriv = dev_get_drvdata(jrdev->parent);
+		if (ctrlpriv->blob_priv.hbk_flags
+				& HWBK_FLAGS_CAAM_CCM_ALGO_MASK)
+			overhead += CCM_OVERHEAD;
+	}
+
+	err = aes_check_keylen((keylen - overhead));
 
-	err = aes_check_keylen(keylen);
 	if (err)
 		return err;
 
diff --git a/drivers/crypto/caam/caamalg_desc.c b/drivers/crypto/caam/caamalg_desc.c
index 7571e1ac913b..784acae8c9b7 100644
--- a/drivers/crypto/caam/caamalg_desc.c
+++ b/drivers/crypto/caam/caamalg_desc.c
@@ -2,7 +2,7 @@
 /*
  * Shared descriptors for aead, skcipher algorithms
  *
- * Copyright 2016-2019 NXP
+ * Copyright 2016-2022 NXP
  */
 
 #include "compat.h"
@@ -1391,7 +1391,8 @@ void cnstr_shdsc_skcipher_encap(u32 * const desc, struct alginfo *cdata,
 
 	/* Load class1 key only */
 	append_key_as_imm(desc, cdata->key_virt, cdata->keylen,
-			  cdata->keylen, CLASS_1 | KEY_DEST_CLASS_REG);
+			  cdata->key_real_len, CLASS_1 | KEY_DEST_CLASS_REG
+					       | cdata->key_cmd_opt);
 
 	/* Load nonce into CONTEXT1 reg */
 	if (is_rfc3686) {
@@ -1466,7 +1467,8 @@ void cnstr_shdsc_skcipher_decap(u32 * const desc, struct alginfo *cdata,
 
 	/* Load class1 key only */
 	append_key_as_imm(desc, cdata->key_virt, cdata->keylen,
-			  cdata->keylen, CLASS_1 | KEY_DEST_CLASS_REG);
+			  cdata->key_real_len, CLASS_1 | KEY_DEST_CLASS_REG
+					       | cdata->key_cmd_opt);
 
 	/* Load nonce into CONTEXT1 reg */
 	if (is_rfc3686) {
diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index 62ce6421bb3f..d652bdbf3f91 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -3,7 +3,7 @@
  * caam descriptor construction helper functions
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019-2022 NXP
  */
 
 #ifndef DESC_CONSTR_H
@@ -500,6 +500,8 @@ do { \
  * @key_virt: virtual address where algorithm key resides
  * @key_inline: true - key can be inlined in the descriptor; false - key is
  *              referenced by the descriptor
+ * @key_real_len: size of the key to be loaded by the CAAM
+ * @key_cmd_opt: optional parameters for KEY command
  */
 struct alginfo {
 	u32 algtype;
@@ -508,6 +510,8 @@ struct alginfo {
 	dma_addr_t key_dma;
 	const void *key_virt;
 	bool key_inline;
+	u32 key_real_len;
+	u32 key_cmd_opt;
 };
 
 /**
-- 
2.17.1

