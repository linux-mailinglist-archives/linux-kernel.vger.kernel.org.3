Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB45AD400
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiIENfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiIENfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:35:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966322295
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsY/IdH4GAzPp096gB1L844rFrv9BuWpY7He4caaoj6Vg7nAmM8FAaIKZ5gmzk5/f4QY9V0mIIKlmeFFj00ALE0eEiQQGeQZ0glrqzh2akYPWeYxpN396oHf4JMIGOno0vKvRMA9i3w7VQHTXflxDvM3NlGvF2BV8i71zbtxfW6JowBCJThrjNdqlz7lTDPjFv7cpxxHzGaf37k9/cMIbboDb07F4MHft9A47cCX7LFGFYhj/Tx7tl7kY5pKqlKgve9bVrRfoHIwDJJ45lP6CtdzlnueSHbG1rKiHQ7jQc8jfT2/rUoPHTv/njuEZqB7O4R/JTvl/VDPi6CZfpYMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcCLvgTpwkHq1/FO0qm84w6sR6hR0QNPu4jIAmnLxJw=;
 b=BiQ2n8IKlOf1l8b8ni5loIpkGgvM9mRpFnf2liE7IJgR3GU1UfYQPKtIWjMImdsj1Liw+gssSfZs0fKRtcVLyOK7OGYpfxR3flivCp5a9DWirErqwaLJwQud60D0L9+w9ttY1XXbZ03Ds905byqNxjWw0MP76jY7p+R710Bxr90W2Y6CKJAtn6W9AWxCrE9Pl6MeE2feGdz8kvlVYILAi5sg6/sXOf8f2f8qwTwp903SmCbOV8wzCrZBANGF6/c7H2AX+CcTkE+x9rv3vgdH8LsNlGx56PNE6vTVGearwBtsoSLb1ijLPDWy73BlhLWycOAYMof9nWu3weff3dcx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcCLvgTpwkHq1/FO0qm84w6sR6hR0QNPu4jIAmnLxJw=;
 b=oCR1cQxThsQKLxusaUYVq38XLPYAtDtInhJsw3VprTPVNrl5ugf9sgl3Qbknxs2n+gNiKJBrG0us/M2bAu0XTcWI1NHMScWH0N73vkA2LlAlyevwLKiGN1DEL/GSC9KH8xCu9+pe/q3jUr0mXh3cbd0duBb7jYXt9Xgqr9o8Tfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:35:01 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:35:01 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 6/8] KEYS: trusted: caam based black key
Date:   Mon,  5 Sep 2022 20:06:29 +0530
Message-Id: <20220905143631.2832-7-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3898c21e-45df-4ed9-5bdb-08da8f436f05
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMtBugOOwgSE4BglKUrfDniJAbSxwpt0IvBHHaaxJblTfqIA0qu0yyfS4ARB0khvGrvNQLuMv0m82t9tJEW7d4XH7slzkx2hE6iKUe7Ab08Q0gaTSXtFu4m1mtbcTV2fiSunjX/5hmU7juF3VRwYlB1rL/sBmIvVYq67viR4A2edUM3DJh0/qUopxPthW/Q8RNQUdbLFjnVdAoJUmuNJwuNGH2XrB3RCEQCJuqR54wFv+vt1kYkGEsiZMziYB5W3o9iRuK29GhQ9/k8N0iO+MCYlhqX3RW4M20Dz4aQr5Ok/dsmAh4WvKWQCJbGcHHchM6roOiDou2dCqAz6EisxIPJd3+O5KxYjNHUWq9NovuBnRoFkrQvJF0WSR2GyIFCiuJgGG5gppqj/FatbxEfyBAJ0KdogbIqNQIvYG8CjiOdrbE5iCoW3k721dEvY9LLDsHFYYqIIxuPA4LjXruX+eXnv+aBDOFPJ70sb7lin71KC/q3aS/9KCNLWaLPxeNoU+oMFn0hyKfeqPademXk2O+KCVvHrceFCaYu49zmOKTL7trokPlXXwIigrojSIRshPlcTUKf4Eg4rSspeqNDRb/z73BvDUdBmp/mGsxOB9kf6mNI3sVhsxJEe20FuFWXHWM7uuilWoWO12WhcQgE9+1LiepQUYLK1BP//lpA3T/zYWZuoqbxHPHhnhLacXTU8IgpSiRW86+yw55BGyxUaOSVlxZo1BV8Fvw+qNwOz/40wxiixu1Y3qlRMLdDKJS/6sxz+iP/GcpSZE7eYAbVdSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9kkCtj9mJvCxyhfWDlfuhyWT6bpMTni8Mqy2Hu2bCIs5G5dGiWk1LCKe7VE?=
 =?us-ascii?Q?HizPJCqUbJ8Y1TBJaEkZb0fUgVoZIMO0v/rxoLmgyNRmIc6Vw4xYsJVJbX3h?=
 =?us-ascii?Q?/PpI57C4QMKpwejf+BvGuzoPL9Hnc+xr+MMFOysS/C3aBxPLeZG6U1Sx1+/O?=
 =?us-ascii?Q?203r/pC6+SonsLdyzssQ36z4JyyHwPPOhoLwtj8zL/1h5X4jK2YlyfQ5bDhT?=
 =?us-ascii?Q?E3Zg2uqN3MrbJjfv1dLxTQff/Ftw3N/z0IXJl39vrJmna8rd1aHRsOmNfwlE?=
 =?us-ascii?Q?1Z1QZUvhBGE+7bpTd0Ve3TWI/XPYj96qw4/jZH6iz4NcjOsmVvdZlWGE+s9w?=
 =?us-ascii?Q?lyVGeGP+pPwg6xp8FHQu5db01A3Xp6pO1zFcpgTqx+JebtKGk75XHSfcVJi0?=
 =?us-ascii?Q?BPiguLA5zZ+MvSxVGz66oX1ti2vpzdoDEucBffpY50/rd5Hf7f3sxGXOtcgo?=
 =?us-ascii?Q?CK14QGCJGBzftRIfkWBWw1FmL++dBQlFeWf7ZWChegqMUAMILsDXp6XHqYRE?=
 =?us-ascii?Q?Bx5OXC/LVjVt5Ife0ZRQ/5f5laBkkra5l2hDilq0xviFVcgELJacB8mBtxvk?=
 =?us-ascii?Q?v7r3BrhfYk1/JGeOrdoMNZztT3FGOFdGy+sd5SCWptyaCkE6g2R5p7RVawqt?=
 =?us-ascii?Q?fFe6YNLd4gKp84sFP3hNQB1Mtv3K4QMwgXsLBjuCe8kPKsWy8lV2ABGYCLE7?=
 =?us-ascii?Q?MkigQIHLhesP4B2FY1To3J/XNXWfxJulkwNAye861Tq0NM9pkF8M1Eg0Mzxt?=
 =?us-ascii?Q?nCejbsrD7GBCc51CloqlasvB/XhNDI6mUE2zV8h+eb5nuk2MuH4DAfIP5ndI?=
 =?us-ascii?Q?TJKq4LKON/rmvi4l5l7+/sZpmNMyqmi0CXBJVJXiU/oifr4NZ+UHNYaBbwpf?=
 =?us-ascii?Q?uEtWZcaK8ccXJ7q+YH2GupAWydTp9ARJX8SjfzqmNRzshjexc8GTGgGh0Zzl?=
 =?us-ascii?Q?6+FOKoZp/DsZB85ZxfarTgZdzWQ18Jt+wNc6s/L3FnooMdkt7LRXMbgIJsUw?=
 =?us-ascii?Q?apdGcLAPTX4YjRbQzYmJnX8pzxDAKJ0sqDFF7Zj0kQjghO0FYMvafuDQfCmF?=
 =?us-ascii?Q?j1C8UM9homQPKWtf2TFkhv8ceBDAqm3l6JCy9l94DtO0B2kSs8nviv5MVgKy?=
 =?us-ascii?Q?sKJvFKvoUHf1dDM9yK/aRD080mRm5kMTkrqhPvjvOxBiiEEOJQOc/S76yolL?=
 =?us-ascii?Q?GlKG2XB+IiRaOziNymgaCy0FaFzHZNwltLXsyZ/WerfiftoL4c8eDBAB7kTP?=
 =?us-ascii?Q?MIkgGJv/NGlV1NEB+j7w/SxADSWcIRA3f/Urn9FhT9Rfh69C//CRAct2Oz4Q?=
 =?us-ascii?Q?h6176TVRlNQ/uKFC3+3rOvip2qQZSevV/75u77tzPZ/wSS9wWWGBf5L6IuXd?=
 =?us-ascii?Q?kS3OdNcBiuvV/BWSuqA7+yFLZHjrbR2CUF0EfTLUem9X4BwEst1j5xPp4m1H?=
 =?us-ascii?Q?HAxPyJrwLn0DUbvXT3kiokK+zIR1mYkQZkXJ8Z579A62uSLUEsn2nVIVOx6q?=
 =?us-ascii?Q?VjxLs/vnTSlM4JQsngvUDwyDynz4XWAAK96KlEq/ARDmKj1uC3hMBJbklgJl?=
 =?us-ascii?Q?fdRhvD3OQ/3ffTtWcr32AHjz4xbPiVhJU4ExSK/q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3898c21e-45df-4ed9-5bdb-08da8f436f05
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:35:01.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIlZhWEDGVzADgOUNSv9HDGi5DfW4YoNIuKwE7G4RhIbA6BYUZt/uCBLLy5lhOkHAiZ7YI7sJZ266/UL9vbojA==
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

- CAAM supports two types of black keys:
  -- Plain key encrypted with ECB
  -- Plain key encrypted with CCM
  Note: Due to robustness, default encytption used for black key is CCM.

- A black key blob is generated, and added to trusted key payload.
  This is done as part of sealing operation, that was triggered as a result of:
  -- new key generation
  -- load key,

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/blob_gen.c | 132 +++++++++++++++++++++++++++++----
 drivers/crypto/caam/desc.h     |   8 +-
 include/soc/fsl/caam-blob.h    |  16 ++++
 3 files changed, 140 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 5164e62f9596..2354e3c6fc61 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "caam blob_gen: " fmt
 
 #include <linux/device.h>
+#include <keys/trusted-type.h>
 #include <soc/fsl/caam-blob.h>
 
 #include "compat.h"
@@ -74,8 +75,16 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
+	dma_addr_t dma_blk;
+	u8 *input = info->input;
+	u8 *blk_out;
+	size_t input_len = info->input_len;
 	u32 *desc;
 	int ret;
+	int hwbk_caam_ovhd = 0;
+
+	if (info->output_len < info->input_len + CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
 
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
@@ -83,11 +92,33 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	op |= OP_TYPE_ENCAP_PROTOCOL;
 	output_len = info->input_len + CAAM_BLOB_OVERHEAD;
 
+	if (info->is_hw_bound == 1) {
+		op |= OP_PCL_BLOB_BLACK;
+		if (priv->hbk_flags & HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			op |= OP_PCL_BLOB_EKT;
+			hwbk_caam_ovhd = CCM_OVERHEAD;
+		}
+
+		if ((input_len + hwbk_caam_ovhd) > MAX_KEY_SIZE)
+			return -EINVAL;
+
+		/* create copy of input buffer */
+		input = kzalloc(info->input_len, GFP_KERNEL | GFP_DMA);
+		if (!input)
+			return -ENOMEM;
+		memcpy(input, info->input, info->input_len);
+
+		/* create hw bound key on input buffer reference */
+		blk_out = info->input;
+
+		info->input_len = input_len + hwbk_caam_ovhd;
+	}
+
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
 
-	dma_in = dma_map_single(jrdev, info->input, info->input_len,
+	dma_in = dma_map_single(jrdev, input, input_len,
 				DMA_TO_DEVICE);
 	if (dma_mapping_error(jrdev, dma_in)) {
 		dev_err(jrdev, "unable to map input DMA buffer\n");
@@ -95,12 +126,26 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 		goto out_free;
 	}
 
+	if (info->is_hw_bound == 1) {
+		dma_blk = dma_map_single(jrdev, blk_out,
+					 input_len + hwbk_caam_ovhd,
+					 DMA_FROM_DEVICE);
+		if (dma_mapping_error(jrdev, dma_out)) {
+			dev_err(jrdev, "unable to map output DMA buffer\n");
+			ret = -ENOMEM;
+			goto out_unmap_in;
+		}
+	}
+
 	dma_out = dma_map_single(jrdev, info->output, output_len,
 				 DMA_FROM_DEVICE);
 	if (dma_mapping_error(jrdev, dma_out)) {
 		dev_err(jrdev, "unable to map output DMA buffer\n");
 		ret = -ENOMEM;
-		goto out_unmap_in;
+		if (info->is_hw_bound == 1)
+			goto out_unmap_blk;
+		else
+			goto out_unmap_in;
 	}
 
 	/*
@@ -112,15 +157,40 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	 */
 
 	init_job_desc(desc, 0);
+
+	if (info->is_hw_bound == 1) {
+		/*!1. key command used to load class 1 key register
+		 *    from input plain key.
+		 */
+		append_key(desc, dma_in, input_len,
+						CLASS_1 | KEY_DEST_CLASS_REG);
+
+		/*!2. Fifostore to store black key from class 1 key register. */
+		append_fifo_store(desc, dma_blk, input_len,
+				  LDST_CLASS_1_CCB | FIFOST_TYPE_KEY_CCM_JKEK);
+
+		append_jump(desc, JUMP_COND_NOP | 1);
+	}
+	/*!3. Load class 2 key with key modifier. */
 	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
 			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
-	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
+
+	/*!4. SEQ IN PTR Command. */
+	if (info->is_hw_bound == 1) {
+		append_seq_in_ptr_intlen(desc, dma_blk, input_len, 0);
+	} else {
+		append_seq_in_ptr_intlen(desc, dma_in, input_len, 0);
+	}
+
+	/*!5. SEQ OUT PTR Command. */
 	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+
+	/*!6. BlackBlob encapsulation PROTOCOL Command. */
 	append_operation(desc, op);
 
 	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 1, info->input,
-			     info->input_len, false);
+			     DUMP_PREFIX_ADDRESS, 16, 1, input,
+			     input_len + hwbk_caam_ovhd, false);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
 			     desc_bytes(desc), false);
@@ -136,15 +206,19 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
 				     output_len, false);
 	}
-
-	if (ret == 0)
+	if (ret == 0) {
 		info->output_len = output_len;
-
+	}
 	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
+out_unmap_blk:
+	if (info->is_hw_bound == 1) {
+		dma_unmap_single(jrdev, dma_blk, info->input_len, DMA_TO_DEVICE);
+	}
 out_unmap_in:
 	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
 out_free:
 	kfree(desc);
+	kfree(input);
 
 	return ret;
 }
@@ -168,13 +242,41 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
 	u32 *desc;
+	u8 *output = info->output;
 	int ret;
+	int hwbk_caam_ovhd = 0;
+
+	if (info->input_len < CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
 
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
 
 	op |= OP_TYPE_DECAP_PROTOCOL;
 	output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+	info->output_len = output_len;
+
+	if (info->is_hw_bound == 1) {
+		op |= OP_PCL_BLOB_BLACK;
+		if (priv->hbk_flags & HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			op |= OP_PCL_BLOB_EKT;
+			hwbk_caam_ovhd = CCM_OVERHEAD;
+		}
+
+		if ((output_len + hwbk_caam_ovhd) > MAX_KEY_SIZE)
+			return -EINVAL;
+
+		/* In case of HW Bound Key, lengths have different purpose:
+		 * -       output_len = HW encrypted key length.
+		 * - info->output_len = Length of HW Bound Key Payload
+		 *                     (Payload = Header + outlen)
+		 */
+		info->output_len = output_len + hwbk_caam_ovhd;
+
+		output_len += hwbk_caam_ovhd;
+
+		output = info->output;
+	}
 
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
@@ -188,7 +290,7 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		goto out_free;
 	}
 
-	dma_out = dma_map_single(jrdev, info->output, output_len,
+	dma_out = dma_map_single(jrdev, output, output_len,
 				 DMA_FROM_DEVICE);
 	if (dma_mapping_error(jrdev, dma_out)) {
 		dev_err(jrdev, "unable to map output DMA buffer\n");
@@ -207,8 +309,8 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 	init_job_desc(desc, 0);
 	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
 			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
-	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
-	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+	append_seq_in_ptr(desc, dma_in, info->input_len, 0);
+	append_seq_out_ptr(desc, dma_out, output_len, 0);
 	append_operation(desc, op);
 
 	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
@@ -226,13 +328,10 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		wait_for_completion(&testres.completion);
 		ret = testres.err;
 		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
-				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
+				     DUMP_PREFIX_ADDRESS, 16, 1, output,
 				     output_len, false);
 	}
 
-	if (ret == 0)
-		info->output_len = output_len;
-
 	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
 out_unmap_in:
 	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
@@ -267,6 +366,9 @@ struct caam_blob_priv *caam_blob_gen_init(void)
 		return ERR_PTR(-ENODEV);
 	}
 
+	ctrlpriv->blob_priv.hbk_flags = HWBK_FLAGS_CAAM_CCM_ALGO_MASK;
+	ctrlpriv->blob_priv.jrdev = jrdev;
+
 	return &ctrlpriv->blob_priv;
 }
 EXPORT_SYMBOL(caam_blob_gen_init);
diff --git a/drivers/crypto/caam/desc.h b/drivers/crypto/caam/desc.h
index e13470901586..41b2d0226bdf 100644
--- a/drivers/crypto/caam/desc.h
+++ b/drivers/crypto/caam/desc.h
@@ -4,7 +4,7 @@
  * Definitions to support CAAM descriptor instruction generation
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018-2022 NXP
  */
 
 #ifndef DESC_H
@@ -403,6 +403,7 @@
 #define FIFOST_TYPE_PKHA_N	 (0x08 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_PKHA_A	 (0x0c << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_PKHA_B	 (0x0d << FIFOST_TYPE_SHIFT)
+#define FIFOST_TYPE_KEY_CCM_JKEK (0x14 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_AF_SBOX_JKEK (0x20 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_AF_SBOX_TKEK (0x21 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_PKHA_E_JKEK	 (0x22 << FIFOST_TYPE_SHIFT)
@@ -1001,6 +1002,11 @@
 #define OP_PCL_TLS12_AES_256_CBC_SHA384		 0xff63
 #define OP_PCL_TLS12_AES_256_CBC_SHA512		 0xff65
 
+/* Blob protocol protinfo bits */
+
+#define OP_PCL_BLOB_BLACK                        0x0004
+#define OP_PCL_BLOB_EKT                          0x0100
+
 /* For DTLS - OP_PCLID_DTLS */
 
 #define OP_PCL_DTLS_AES_128_CBC_SHA		 0x002f
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index 380b0bcb79dc..ae2c2a6c8c23 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -10,12 +10,26 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 
+#define HWBK_FLAGS_CAAM_CCM_ALGO_MASK   0x01
+
+/*
+ * CCM-Black Key will always be at least 12 bytes longer,
+ * since the encapsulation uses a 6-byte nonce and adds
+ * a 6-byte ICV. But first, the key is padded as necessary so
+ * that CCM-Black Key is a multiple of 8 bytes long.
+ */
+#define NONCE_SIZE 6
+#define ICV_SIZE 6
+#define CCM_OVERHEAD (NONCE_SIZE + ICV_SIZE)
 #define CAAM_BLOB_KEYMOD_LENGTH		16
 #define CAAM_BLOB_OVERHEAD		(32 + 16)
 #define CAAM_BLOB_MAX_LEN		4096
 
 struct caam_blob_priv {
 	struct device *jrdev;
+	/* Flags: whether generated trusted key, is ECB or CCM encrypted.*/
+	uint8_t hbk_flags;
+	uint8_t rsv[3];
 };
 
 
@@ -38,6 +52,8 @@ struct caam_blob_info {
 
 	const void *key_mod;
 	size_t key_mod_len;
+
+	const char is_hw_bound;
 };
 
 /**
-- 
2.17.1

