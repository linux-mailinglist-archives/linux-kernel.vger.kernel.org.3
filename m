Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B735AD3FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiIENfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiIENfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:35:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84801403B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhmTKdP+ovBnziefiVC4Qf0G0MAyRb5gm8Dw+UAihRfjLBRAesrL5HyLUbgqEFiu+RBSJUGY+u+G09GFJUcG6FOjUx5CbaqZJ67g4yAnnqlSUnIEsqlXzOLI7wQ8qzVnHYD9JAQ+stemUl4rRYoffgBsz77Tu0XIfwoECA7DCUTvPWqK2EANllmRM0oedP5EyM5B8O15MCgHBJkINHy+SSxIr1XI41qiezJRY7LYTgqSW+3wxz1sWShKktYHNwLYxySZql5/dr1Xol9ADqpmxzzOLmsQQrbUcz38fceSg61I0998UY/sZ9YPnk3M3Dh8WVghFOOLCVW5zmHAKa4UEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouXMirUJooxVjewuyl91g8VCVuTnSKkxZ1LRI17MI+8=;
 b=DaDhesPX81QEO3PedUcVlt8swzJ6GN+sAo7tb6IligoLDYojr83gImz6IO+LdfdogSPQnwydBjrjgG7upNcvH0wh3RjAoaS+/jnNgk2OTHit6CxQ4IvcnD3iJzZdQzzR34Af2QmEKIB7Gl0f/ccNiANYJetTakyvCzpPd25ikhqych7hI0hjzP8P3gwcmQxGyp60eB+ADTwJ1r7lpK+re+6Iv/Q74P6YQyBrq/1XcZORh9kwsBdc4WBsFqVIxz5PEkNKQw4GYPg2Up6EF094vum3lSCAAuoR666EgdowGl9P81A9ixXK0h5GzeKqED6y284eWjWLEAJGWctroe92Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouXMirUJooxVjewuyl91g8VCVuTnSKkxZ1LRI17MI+8=;
 b=UuhaeVLz20RxfH89/dFBdrUwwgsgND2hES6w+hmkrF2YTo2aSUJ7Ep8TfdOwTIfv1BXyK7ALSDO4RcFUqr73nGOwcRdgrHwYIdzxT+CevPHCPbnUxGb4rrORqQc2wcuzTiBtrfm21d1ebVj/YaoGZZDYdtTuWvL5mgVMeQ25t9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:34:59 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:34:59 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 5/8] caam blob-gen: moving blob_priv to caam_drv_private
Date:   Mon,  5 Sep 2022 20:06:28 +0530
Message-Id: <20220905143631.2832-6-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e7ac7ca-6a0b-4690-4add-08da8f436d6d
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUhnibSSjXJDsY8wEJX4f572kpqslqiNFox6kIGS3lK0cijHzGHBVDBm2sjRxdOolGPU3keW0HiHNWPOzDJ3EbrdLHqJpn1FRtZg4KKXStzbMxOkp6U/Txkxhi0VdB18em9YWHUZQHxuMC9MUM3GTon/8Ux5aEGUddnt2s8w1F0YKdAR0jS/hHUmyRoDeNU+RsFM2igr+7M6ze1guSAHVW3WYKW5w54zVd8pTJuF5JrHPlCNvW26vMQds8h5kg7xScgsVVve+/v/idNZajC5z0QUKbONjhMPDtHI2wRbupyDicJMUUWiZZk2d+sAP5yN2JDtjFEMi/J3SMEXlwxaj02ix5ZJkBw8aSEV0YEU2ltq8v5EKJR1zu+DfkeEYEJcqMTdELTncxJo2lWhde5bGLphwkhb8q2b3NK4sNyxtL8ZE1WwfG4DSJMfjhseASUUpROTX4WVIiXbJIpJOC6Gbe6xOnA+rqSCkxmn8tmohbYIbv/OBNLzYN3RC3oJQoeTY4Kws2BIo/MamLJ4LjXPqrPW3+658ZvZl+BKJSKYp08wx/lQ1OOLRVm9S0ZJCKJZxSdjBefjFtX70PH8zhCJcJGEvWYfHHgpyH9VaXHTci+hGisgWO6x/QhdqLYhlATol5+kBCCX0ALEO4cDmjsbXReDVoc7/jCBy5wPO2jU2dwGBlID2MMe3IOJGOS2xXsMzDfxp4pujwmCg4x9cui6IbL4nXElnSndofE5xCJn8RuedMz/nmCt3ppbEEC72KkvfgD5XvP8wRcbWY47IaYBfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FxPqMPRG6UCZGPSg0XK2feO/TO7FYQKZYb651TFxrwCPMop55FaESumHqnND?=
 =?us-ascii?Q?shj9VnKbbpKQxRE/k+zubqCdV/ZzlB6Q3+diw7dSbeeT1cIPSnAo+nJVtDlk?=
 =?us-ascii?Q?nXSktZ34TMp0r9gQELJ++09SFMySu/4qUyKHVQbYsD5/5fsh03cs3fmHwTcL?=
 =?us-ascii?Q?66+QHElEVZ6QxZ/Kg938lDaAxibGxMEiHEZ0wRnzAM1gdj+bJZ+oQre4C80X?=
 =?us-ascii?Q?mIfsnNJvlGXC+iVlQpdt/9u1a6Ms1LxMbjNzXi0hvUlIXZTaPXfIDIzFmr5L?=
 =?us-ascii?Q?2Cf9V1GDuBOYRkQM84bYUi20uqPnPaPKPczjyb1ZlxsA+BYChRvfQPIfcZzU?=
 =?us-ascii?Q?CW6m2nBRGapqw54E+t9SnyFntKQfp9VehcyulVaAqRV5MXAqwg/njGXbF0TJ?=
 =?us-ascii?Q?eWwX9Fxzu7u3lAeJspAq6iKLoaUhWUlwmqV0NRjwZoRGhd0MoWJT+GgztVdV?=
 =?us-ascii?Q?vyjoUIsucrh7kz44Gw4DekQyarXGpjo1Nj3VdBy6V80kUIhAVN3lrBRZIwYT?=
 =?us-ascii?Q?pAgWv6fjnHMI00U3g76Yf081b1643ZQ8lC3W8s9XxKpwMPHM/wr4eOehmFjv?=
 =?us-ascii?Q?fDZcfW1/ky4tfRnhQPgEvHrQWKjYUEZk5p4X5pOx2hyfzMhq5FKC/8ofJY09?=
 =?us-ascii?Q?Kx+wU7mF4T6xl8yQhPe5WQ1AJGKpHdNptKSATyKKKjCoy0Ulipmo+gCS3O4r?=
 =?us-ascii?Q?EDDnyGQ6ipPNiPJQW3CcVbvF75poJx0fH+WPSvVcC6RJbHUEBk1C4onp3e/X?=
 =?us-ascii?Q?nBs/pPSsT4TwZwvrpb97rxo7SpIQkJr4OY7/RCINJQiE9nytTxCVJMAcs83D?=
 =?us-ascii?Q?u4yMIYz+mJkKQ+4EfyXzI/CXOpRJA+zQDB4a3s3THlV1ut+jGXsVw5T7i8u2?=
 =?us-ascii?Q?bDTumgi5MXlTrGvx59ueM8Y2bMuRyIGUBUoXH1BtzuKy+rIqcJhDurQLqmuK?=
 =?us-ascii?Q?VDKCAfcoGPnv9Hw5O2Bry0Zd8SBYONLl/w5iQAuJqGKL/aW/8uwz7dK2LEuf?=
 =?us-ascii?Q?lxCCsG2SvcV7Y/E/UPyBIbyjsOnj93EJ05V3CUs294ukOajGNsiWgGX18qro?=
 =?us-ascii?Q?eu+lXJppIbA1mYcfSnxyfcYZL9PsN13jkR/rME6rReNj7AY2kiFD43Q3bBNf?=
 =?us-ascii?Q?bOJ+1AzYpzoVotRKRrY+J13TsRKtD0UD7ZXyuRqGtUALJ8vKdKLnGRoIWNj1?=
 =?us-ascii?Q?ZKIzwZZ0u7yh0fDgZP8W9cX/iXnWmzy4y5gscQ7fSZzukJ2X3Ndi384jVXGm?=
 =?us-ascii?Q?2GgE8vM+3SVNWq68iHm2+A6nO79JTOALAXZdJ3vNEb0xvcaN9/cowNi4zuHE?=
 =?us-ascii?Q?o4cGHaSSd5ynjWQaTZoOIv6hAXmtoed0hlvb1lFr9Cvh1AYjS8vlFhkIB8VA?=
 =?us-ascii?Q?5HMy9R9DgUqtGb5hzVE9bkdjyzl0hK4qk9jS6DqeSsruwlGouP+sJ8bdFJb4?=
 =?us-ascii?Q?qExVHpLfohJyanYrfgkRK9BtCbW3e370chwt4dnBdT4IggvvDPgn54WUII/T?=
 =?us-ascii?Q?CWu6sD37nE5yIM6ItXWvYTex6sg5B9pbkNmmSIyAN014HhEEk08far5R2F2E?=
 =?us-ascii?Q?quLcOKOhTbCTSNxyNZIhSr3TFpu/DbCdfXYCYLni?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7ac7ca-6a0b-4690-4add-08da8f436d6d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:34:59.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yjec1AaxUKtKFPpl2ZPCgSrJbrmiM2jJjFg3ouL8/JeLE0JQ/ZRGaDMuaDfN3G2fiempvHv9swkgpw7kxCeyMw==
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

caam blob-gen: moving structure blob_priv to structure caam_drv_private.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/blob_gen.c | 8 ++++----
 drivers/crypto/caam/intern.h   | 6 +++++-
 include/soc/fsl/caam-blob.h    | 2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index c128a83cc8dd..5164e62f9596 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -70,7 +70,7 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 		    struct caam_blob_info *info)
 {
 	struct caam_blob_job_result testres;
-	struct device *jrdev = &priv->jrdev;
+	struct device *jrdev = priv->jrdev;
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
@@ -163,7 +163,7 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		    struct caam_blob_info *info)
 {
 	struct caam_blob_job_result testres;
-	struct device *jrdev = &priv->jrdev;
+	struct device *jrdev = priv->jrdev;
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
@@ -267,12 +267,12 @@ struct caam_blob_priv *caam_blob_gen_init(void)
 		return ERR_PTR(-ENODEV);
 	}
 
-	return container_of(jrdev, struct caam_blob_priv, jrdev);
+	return &ctrlpriv->blob_priv;
 }
 EXPORT_SYMBOL(caam_blob_gen_init);
 
 void caam_blob_gen_exit(struct caam_blob_priv *priv)
 {
-	caam_jr_free(&priv->jrdev);
+	caam_jr_free(priv->jrdev);
 }
 EXPORT_SYMBOL(caam_blob_gen_exit);
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 572cf66c887a..2fb7df3ffda5 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -4,7 +4,7 @@
  * Private/internal definitions between modules
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019-2022 NXP
  */
 
 #ifndef INTERN_H
@@ -12,6 +12,7 @@
 
 #include "ctrl.h"
 #include <crypto/engine.h>
+#include <soc/fsl/caam-blob.h>
 
 /* Currently comes from Kconfig param as a ^2 (driver-required) */
 #define JOBR_DEPTH (1 << CONFIG_CRYPTO_DEV_FSL_CAAM_RINGSIZE)
@@ -114,6 +115,9 @@ struct caam_drv_private {
 	struct dentry *ctl; /* controller dir */
 	struct debugfs_blob_wrapper ctl_kek_wrap, ctl_tkek_wrap, ctl_tdsk_wrap;
 #endif
+#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN
+	struct caam_blob_priv blob_priv;
+#endif
 };
 
 #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index 632944df29f7..380b0bcb79dc 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -15,7 +15,7 @@
 #define CAAM_BLOB_MAX_LEN		4096
 
 struct caam_blob_priv {
-	struct device jrdev;
+	struct device *jrdev;
 };
 
 
-- 
2.17.1

