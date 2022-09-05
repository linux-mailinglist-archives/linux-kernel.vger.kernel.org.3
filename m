Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C395AD3FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiIENfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiIENfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:35:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894AC399CF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGTRI7kdT+6cuoYRa8X1InwffGmI2XkZHvvcI2bY8rssAHZmPeg84HZd1m5c8HoCVMuTuTmeie3P/BJCZKtBZ18eeMKSbeWL0htHPgCv1eXIGdzf7qp56uIq9YI6Rb0GTINg2w0EBqVXSodcI61d9YV+GoR29UxbrZPeCpxjfI4+ujp8kZ8MB33Sm3ZgYIHeAFF+0ip/GTdPzJl5k4yliCg9JWc/9yUnVhUluBhIlGKRGJJaLY/sjWf5UC/KVpJ2wCXRyvzhbp4CGnEiV+OJaL1C9W0+hqJOoF+seJ6CG3/Twv8G8trAZqa7tfUESCP1fP6ATlFPAdCfoMcqS0UQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxIElYum3e9A7v8sdm6x798tL61g4LMWOYtHfaJWI4k=;
 b=U0U76ZTRz5+zmvvSFSX2TsrdMrYhmgcffwBbppSS8wBZa3jmoUj48cS+DO98BiPol11XtyOegLzOZ1OiIZSDJIvNNXUYEEWZx5c0OZ6Qc7EQhb+rS2Kgw1qKjcCBKTcBUAvQGd5JxpNn4+VHWIBtGxoo1E/H3VGJpE59NS+k/qEszHjJA3iq1j7ds3d1b8yEbtbjggEpaEt8DoV1PWCh0sZg9d5Eto1gwRnKJZ9olD4gtjaGHAgdBcAij91rH/9QLXFmp/TGj+ewgOkejNMo4NwkGBXfijv8kgu8Yf/ooBF85NVioBTtwYkJbheE83G7JlQH/joqFZ5RWmbq+0U9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxIElYum3e9A7v8sdm6x798tL61g4LMWOYtHfaJWI4k=;
 b=ld+nqomfJjbkCefEJpFCz0co21mgFdBO05sf8IPcOjceOqLdROZ8KnGYijoueJK94jyaqRMr6ghVoBKMtW7OLTk/FTRWS/spG5MAdc6PpjPES5q7Yu8sjtX542nIZpL38BmOgj9wCUkNe6dkp4DAkeZo5Dnbu7HFcHdB3+nbEtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:34:56 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:34:56 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 4/8] keys-trusted: re-factored caam based trusted key
Date:   Mon,  5 Sep 2022 20:06:27 +0530
Message-Id: <20220905143631.2832-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9510f8-f93a-4713-3a75-08da8f436bda
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/iuV0KALu06FiaDKRgryTfksdSAEi971qM94MFTVUMw/mt98LvPFhQEeV47NPQiOmoeK7nPBFYSJMWVlbHPBRgXasRkO7vFcqWbELALHQhWyGQGpm2aNgsL0lA60+AZYpzFNRVPB76Q2Di0v3KM5m97OttW/XZf32he16fr2EysYF98zuv5kyGyXLVy7/63naxfwhy6Mq/jf2IjelfASNwoVZK+3/y/svotE8MsGqXyIPOMpacOURfsuqL8lYMFgUGFfISXl5pYeWowZUMViWVh8pHzeSiglCzk8FKOM2WrhniMH+HuW2CZMzNTj1xAOW5eeH0v5Myewj9ILVxUmHHX+L4CIdsvrFKDgQIjaPwWUyIMCPAE+6Mbuy0DB7CRbXdQ0wpm3q+eAbv/fBMRADtJLd1H4V4XWyUa3fQJ+Z+NBgA2g6DOCZaczg9Ne2n2GLetjRr+ZfmlJwaTVTg99sFdK0WlTej0mit0F/OyidUd9bh0qs993Deeu38W7XrANh/mm/oj6x3QPuJHAQzUYBtO3F1sENJPHyNmqx6+zJuXcG7uzXu444Kts/9ZY4qw1GA1wnuf9LePP86yaS9g6tQbNhFLGT9MQOX5yMVePKID5/+GxzFFDrWPkAqKiynabioTaHHt9OPQOYn5ZjTKREV2Q2OGQeMwhoaukWoD4yYcP/cwlhi+s1zp1BzqY/gX50V1LeDKrw1SLI+3z6Feue+tW1J+Ci6DutrCmSZ593VmkmUsuxxqfvSUgRpqsZhkQ21ruB/vNJs6KJYi91ljuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nc4amQUvxKsQWKG3BE+5gFZS5rHiDtjmdrwopfU9eKChkN9Fo/9ZFWC/KQ1E?=
 =?us-ascii?Q?/xuEK/DFRrCeegTS6GfYPukC4OkBehWQBrO4KLMDjqD+ZuJBHKWgi7+Lpe4c?=
 =?us-ascii?Q?8b/Y6rujWbk4UfSYoFAfHoofqXLHlRRrdyCWLZUJxx1IQZrKBytkO6mh+JK2?=
 =?us-ascii?Q?9btykdFNSmORqvj90p05qk0Tv2otAH74IrpMMrcaccrSYNWiyTMT/ywpVWzO?=
 =?us-ascii?Q?Z4kfzIWtGvxBh2W4Z3Jg2Vzheh+d6Ysk1juNxHdcFU9Ab4Qouguj8mi/gF5P?=
 =?us-ascii?Q?nYvMEYtqd4+B+hlOPLpHu0L+QQgs0ByY3bkDjJySPs1CsKv/XcfDUVeDBM/2?=
 =?us-ascii?Q?+XGtuqcvzB8XTAPPZ4aZWK50roe8DTSysv1Ui+JB/8PGxjEknTOVYp9a1uST?=
 =?us-ascii?Q?/oouswXEFnDeJCHKohISUitMLOSPR+NvIaC9vqXI9MUnFsEBASj65aEqeLGD?=
 =?us-ascii?Q?S1mJCutbKSi+AebKkbml/AMJABAKHTGON2beycjkB9BZDecZDSkAGNcclrt0?=
 =?us-ascii?Q?clJVW5qH4H9MpwgC+26JrANWEOCwXrdcdz1ujyOjkeTY8OuKh93bClexVDAg?=
 =?us-ascii?Q?oEjc3t870KcsnHt4mENn01HROWPOJnXpwn4ppfDP3qg6IcOIZeLKdfnazdCw?=
 =?us-ascii?Q?1x4kKALLmTLabnwAM/WlFPqPH4+zmDMzNoC4pYfjfY5oysLAuDsZ397iZZ7u?=
 =?us-ascii?Q?kc2W/YZPPdx3Uppl+1FZ6yyBMrjxP4NPdEzBbJ/Hpy/fhevsQap9sgUP8cry?=
 =?us-ascii?Q?B98ZLP/MAnB+mSb4Sa2pu+miOHrHi4EUo+MBVcO7ztNmYhuAJMW/ODt2mLEb?=
 =?us-ascii?Q?ECTQaZpoJSoHgcq+I4BXBSamHbbMEbr8UDht7bwmBv1EamsKjN2QKjkL39/c?=
 =?us-ascii?Q?nK+vG59BJMSCFGU94PvTiNw6yV7kfcjczpbZBt/oH43w4+SINZXZiqsGPzZY?=
 =?us-ascii?Q?uZdw2zxAoLiRKDt+dNg3a/oPW3RdfIKp4rr8RLaDMkmdcPkQd9XAxqEG1KNm?=
 =?us-ascii?Q?dUzbrn9qMFCNOCFqNuygs4RQ6TZ7V2Arw0Hl3wBg14X0ER+IyYVJNw08Vsls?=
 =?us-ascii?Q?fGFKqW2AqGN/NTLmXtw5ZJ5sYZUm1d/9ImtCmdUnNqip+9sYTxZuHwnggpkL?=
 =?us-ascii?Q?ZycXIOMqTxBW3VmctDnV9Za+DlhQgJtMdy1K4C3yVNgzX+IsL3FTSNS5hSvZ?=
 =?us-ascii?Q?LR/uCGZNnBiqiPy2QH4mq292VtOYdV9vuXiYBE4IkhF5f5NdvZ6u9dMSR+iG?=
 =?us-ascii?Q?yA130XsYj42nilnWnjgwMhCKUUrCI/Yt3GE7QXQJEkcwEeMHqVpS3YXY8xap?=
 =?us-ascii?Q?LkoXGjdyI1I3wNsYCETtVEdUuZTEmxXdtRKWNw6b1xVksqvOHsrRRRI8QCkB?=
 =?us-ascii?Q?ABXj4ek34h+hCuMOyAbA2NCPNQwhn56sn6Mt81WwQGXgk/Zox16YXv7t5xqH?=
 =?us-ascii?Q?bRZ37kT7SwN2CHw5/vc5Ko6thlREgGOL6gUNY2DXM/AjPlNHG5G44zzrjFiC?=
 =?us-ascii?Q?hPG+fcXfd//3Tk/NIwNkyuMMPwdiwMj+2z5hAPfGaoiu9r3dEEvKJW+qAnLY?=
 =?us-ascii?Q?C3ZKpPndolkL5iuJI4cH8j06Wq2cTHykskNGNYrs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9510f8-f93a-4713-3a75-08da8f436bda
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:34:56.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPNkQjEBW2t2TEgWQnqTjGvreSV3saftxXmymTR9aKPycHXTIgkDME/t1VRSn7wl6TxI7biBmxcFovA91paS1Q==
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

Re-factored caam based trusted key code:
- Two separate definition for encap and decap having
  separate code for creating CAAM job descriptor.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/blob_gen.c | 122 +++++++++++++++++++++++++++++----
 include/soc/fsl/caam-blob.h    |  28 +++-----
 2 files changed, 118 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 6345c7269eb0..c128a83cc8dd 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #define pr_fmt(fmt) "caam blob_gen: " fmt
@@ -29,10 +30,6 @@
 	/* Command describing the operation to perform */		\
 	 CAAM_CMD_SZ)
 
-struct caam_blob_priv {
-	struct device jrdev;
-};
-
 struct caam_blob_job_result {
 	int err;
 	struct completion completion;
@@ -58,8 +55,19 @@ static void caam_blob_job_done(struct device *dev, u32 *desc, u32 err, void *con
 	complete(&res->completion);
 }
 
-int caam_process_blob(struct caam_blob_priv *priv,
-		      struct caam_blob_info *info, bool encap)
+
+
+/** caam_encap_blob - encapsulate blob
+ *
+ * @priv:   instance returned by caam_blob_gen_init
+ * @info:   pointer to blobbing info describing input key,
+ *          output blob and key modifier buffers.
+ *
+ * returns 0 and sets info->output_len on success and returns
+ * a negative error code otherwise.
+ */
+int caam_encap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info)
 {
 	struct caam_blob_job_result testres;
 	struct device *jrdev = &priv->jrdev;
@@ -72,14 +80,102 @@ int caam_process_blob(struct caam_blob_priv *priv,
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
 
-	if (encap) {
-		op |= OP_TYPE_ENCAP_PROTOCOL;
-		output_len = info->input_len + CAAM_BLOB_OVERHEAD;
-	} else {
-		op |= OP_TYPE_DECAP_PROTOCOL;
-		output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+	op |= OP_TYPE_ENCAP_PROTOCOL;
+	output_len = info->input_len + CAAM_BLOB_OVERHEAD;
+
+	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
+	if (!desc)
+		return -ENOMEM;
+
+	dma_in = dma_map_single(jrdev, info->input, info->input_len,
+				DMA_TO_DEVICE);
+	if (dma_mapping_error(jrdev, dma_in)) {
+		dev_err(jrdev, "unable to map input DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	dma_out = dma_map_single(jrdev, info->output, output_len,
+				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(jrdev, dma_out)) {
+		dev_err(jrdev, "unable to map output DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_unmap_in;
+	}
+
+	/*
+	 * A data blob is encrypted using a blob key (BK); a random number.
+	 * The BK is used as an AES-CCM key. The initial block (B0) and the
+	 * initial counter (Ctr0) are generated automatically and stored in
+	 * Class 1 Context DWords 0+1+2+3. The random BK is stored in the
+	 * Class 1 Key Register. Operation Mode is set to AES-CCM.
+	 */
+
+	init_job_desc(desc, 0);
+	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
+			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
+	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
+	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+	append_operation(desc, op);
+
+	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, info->input,
+			     info->input_len, false);
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
+			     desc_bytes(desc), false);
+
+	testres.err = 0;
+	init_completion(&testres.completion);
+
+	ret = caam_jr_enqueue(jrdev, desc, caam_blob_job_done, &testres);
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&testres.completion);
+		ret = testres.err;
+		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
+				     output_len, false);
 	}
 
+	if (ret == 0)
+		info->output_len = output_len;
+
+	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
+out_unmap_in:
+	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
+out_free:
+	kfree(desc);
+
+	return ret;
+}
+EXPORT_SYMBOL(caam_encap_blob);
+
+/** caam_decap_blob - decapsulate blob
+ *
+ * @priv:   instance returned by caam_blob_gen_init
+ * @info:   pointer to blobbing info describing output key,
+ *          input blob and key modifier buffers.
+ *
+ * returns 0 and sets info->output_len on success and returns
+ * a negative error code otherwise.
+ */
+int caam_decap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info)
+{
+	struct caam_blob_job_result testres;
+	struct device *jrdev = &priv->jrdev;
+	dma_addr_t dma_in, dma_out;
+	int op = OP_PCLID_BLOB;
+	size_t output_len;
+	u32 *desc;
+	int ret;
+
+	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
+		return -EINVAL;
+
+	op |= OP_TYPE_DECAP_PROTOCOL;
+	output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
@@ -145,7 +241,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 
 	return ret;
 }
-EXPORT_SYMBOL(caam_process_blob);
+EXPORT_SYMBOL(caam_decap_blob);
 
 struct caam_blob_priv *caam_blob_gen_init(void)
 {
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index 937cac52f36d..632944df29f7 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #ifndef __CAAM_BLOB_GEN
@@ -13,7 +14,10 @@
 #define CAAM_BLOB_OVERHEAD		(32 + 16)
 #define CAAM_BLOB_MAX_LEN		4096
 
-struct caam_blob_priv;
+struct caam_blob_priv {
+	struct device jrdev;
+};
+
 
 /**
  * struct caam_blob_info - information for CAAM blobbing
@@ -72,15 +76,8 @@ int caam_process_blob(struct caam_blob_priv *priv,
  * Return: %0 and sets ``info->output_len`` on success and
  * a negative error code otherwise.
  */
-static inline int caam_encap_blob(struct caam_blob_priv *priv,
-				  struct caam_blob_info *info)
-{
-	if (info->output_len < info->input_len + CAAM_BLOB_OVERHEAD)
-		return -EINVAL;
-
-	return caam_process_blob(priv, info, true);
-}
-
+int caam_encap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info);
 /**
  * caam_decap_blob - decapsulate blob
  * @priv:   instance returned by caam_blob_gen_init()
@@ -90,14 +87,7 @@ static inline int caam_encap_blob(struct caam_blob_priv *priv,
  * Return: %0 and sets ``info->output_len`` on success and
  * a negative error code otherwise.
  */
-static inline int caam_decap_blob(struct caam_blob_priv *priv,
-				  struct caam_blob_info *info)
-{
-	if (info->input_len < CAAM_BLOB_OVERHEAD ||
-	    info->output_len < info->input_len - CAAM_BLOB_OVERHEAD)
-		return -EINVAL;
-
-	return caam_process_blob(priv, info, false);
-}
+int caam_decap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info);
 
 #endif
-- 
2.17.1

