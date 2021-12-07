Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B90D46C7F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbhLGXG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:06:27 -0500
Received: from mail-eopbgr00127.outbound.protection.outlook.com ([40.107.0.127]:30532
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242411AbhLGXGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:06:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWmo+G0o7JJAibQEcEFYUtRv0t8I9+CK/Dw0fJ6zxr0rVPjW+99+Hlc0d3rsHZMWZzluW6AHgF07uuFCDywQjvW/MpFVFiiXH85KaDLSp7uy2N3j+JesC92orITs3sT6Qm1j5aHVyrp6X3LlIEUxiky+v2hvbSlfuT+JjbOG1V+tVwTgiSN1PjiH2+MrEn+rrJwz8Ylzs/5eyAnfFg6xcTMqphxjDNa1/eEOiW/gq8S55wMjxUNrYr5qm0E62JCpvqgW/WwEKPUPWY9FQZ8ImYeR4Pu6aELfMdm0cC+Ia8kHE/nFPEZrG0ruv33ghO0fvcd/fjWWpu7cYehGAhxjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHx0KXtaALH4p+/5d5g7Ih/C5F6ooHmhpk+qpygJKyU=;
 b=m0YwJNl6zIoslz/i1zcCjx9R5XtkX3m+lCkvOogDk0TZydj+OebM4HkGFmrl51MSgilGdQqpv6/UM5hDHHAFY0SUwTTm6tNprDFPD3/71ctUvct3RzhgGv01b4Iazc9wuT74ehJ2W0TXWe1orVI0qkYuFpy82jxp2aal7qI38S9ZFgRYNwSwb2ZFYEzZnv1ZYvZJEXXQuH6BPF1Ilg3jWnpuPPJxcxwXMwpoOar/tzzwkYP1q6S/XmhGg5vrKT7AcWs/cH0FtV+RlnUb9kc24eQulbbKWSc8t8LNaPzxh/O9TJpicZNqkr+LMzylIFoKwChUtrxCXR8A8unbjCZu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHx0KXtaALH4p+/5d5g7Ih/C5F6ooHmhpk+qpygJKyU=;
 b=cs2ciyLHsTbhCOjyEWAp1X7yMIfeOfusnY/VqdvDN1ZN5INg/AwR6J2Cyxivm5w/t4wXDs0SaKDjHKTMALwozLCdjqjT6TVbydEncVS0RRInPUWVjx1ZqSr9w3B+wP3e5TSsQ+RaEv9El+Gk3y2MmWmAPrxX85P6E/7C/XFgILo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
Received: from VI1PR06MB3102.eurprd06.prod.outlook.com (2603:10a6:802:c::17)
 by VI1PR0602MB2910.eurprd06.prod.outlook.com (2603:10a6:800:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 23:02:49 +0000
Received: from VI1PR06MB3102.eurprd06.prod.outlook.com
 ([fe80::9c38:9d12:599a:a1cf]) by VI1PR06MB3102.eurprd06.prod.outlook.com
 ([fe80::9c38:9d12:599a:a1cf%4]) with mapi id 15.20.4734.031; Tue, 7 Dec 2021
 23:02:48 +0000
From:   Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, michael@walle.cc,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, horia.geanta@nxp.com, pankaj.gupta@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        l.stach@pengutronix.de, qiangqing.zhang@nxp.com, peng.fan@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, frieder.schrempf@kontron.de,
        krzk@kernel.org, shengjiu.wang@nxp.com, gregkh@linuxfoundation.org,
        ping.bai@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        marex@denx.de, thunder.leizhen@huawei.com, martink@posteo.de,
        leonard.crestez@nxp.com, hongxing.zhu@nxp.com, agx@sigxcpu.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: [PATCH v3 1/2] crypto: caam - convert to use capabilities
Date:   Wed,  8 Dec 2021 00:02:05 +0100
Message-Id: <20211207230206.14637-2-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0069.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::46) To VI1PR06MB3102.eurprd06.prod.outlook.com
 (2603:10a6:802:c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from GEO-HfyyrYQLnZo.lgs-net.com (146.185.2.7) by AM6P192CA0069.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 23:02:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502845d7-a7a0-4847-f170-08d9b9d5b037
X-MS-TrafficTypeDiagnostic: VI1PR0602MB2910:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0602MB29106F11F254023AF98A011BA66E9@VI1PR0602MB2910.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8HwlIdOQ+EFdRXIicd+lLhf2rS+Sr+wpgNRfCxw4myUo8LBvXajsM2ZkQK4pLHm7x0pTDuX5DuuUw5/yrN2VXC5JWAD8Mh/dgHzuLUMpwvXsv3WRvRhaMFltcKIwPgjXS14rR++GeRlI/7+vRmRKhpxklRz5aE/Cz1oBYECxWFhyjQMGdMAlPPWbSXBSznot5CwMLGv6b478EuAJs/3ki5hPAjlUTDM22aW9rTqHYhEhL5FwpNXEBQes7WIfghC0aWyVGTkyrItgVU5JOwIzqseLJ7ZQLfKE5CS0Gx6nEf2rvDOtOcZzmXu0Gs+YeIOSOiO4auGhsYymhnGImAukq/skcoP46QvGYfa+W2Kj2dHevqTSkSnwmj/4wLqDm1kCVrRuQNcMBDxxmZU01p0bORmZMhgmaUrADXq0VWvbMm4hXabWMDF1KtQdoCytgE34k+NprwOv8iJKcUr7l/xBboRVx6CntIs9h5Lea8ZKTddeLT3356qWhZn6WqSOmTIB43YRiBUAsIZzYqYx3oAZ3ll+u8VbUL8MgtLWp/rlIyWX3zGkV9PgM1dnYs54JqKFwOHjq03tWfiR+6y2zLK8RtFfMQgVnNPj5cMcRWDWX0togZu11uiBHYunAkd9AY3TgoUk9ALbiQPE4E+6I+hw99rZCMIMUfSq38XPJJYmAjZcU974M60wR23p/FULIYJB2myZu24E+7UXA2Z/N46VoCw0DQOPsCw8spXRjYeY6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB3102.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(316002)(86362001)(83380400001)(52116002)(38100700002)(6486002)(6512007)(66556008)(66946007)(38350700002)(6506007)(956004)(6916009)(2616005)(4326008)(6666004)(7416002)(2906002)(7406005)(26005)(186003)(107886003)(44832011)(30864003)(8676002)(8936002)(1076003)(66476007)(5660300002)(508600001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HpRtB81Z1YV7lRBlJ7TJyFOAfADhfhFgmBU77Q4Os6cme4UGD2bXQeoisOs?=
 =?us-ascii?Q?JWxR2w63DKwI4ZBaOAQM+vlMqBeoto6M+yg9dB/HdnRLanDHInPDHcyba2xD?=
 =?us-ascii?Q?0JLVfWjbXrm5mbz7n88zqibyv6BoNkEYLgDotBOpQAp9kMZKwNIrbAx4Gyri?=
 =?us-ascii?Q?eFdMWeUejxjR0A6kU7nngooW12eb+HzzWUWDuXaizYI2d6qKZc+ZYPM3xuB3?=
 =?us-ascii?Q?Lo9yrbqm5psL523dgu5eznFXndjHdxg74kBS3YdxUqyGkP0SNAxAQ+Nf1weY?=
 =?us-ascii?Q?kDKYBw4Ss1mB7YEA9wE5JMjadVxosv9rQE+IhljBrxytDC0vduJdNbjBYTyv?=
 =?us-ascii?Q?KhmhAduuv2JRBO71L6v7fvuV+EgYKbrHAAtG1HhPQoq3eOIWrv+eoVJwIbRP?=
 =?us-ascii?Q?wApJ5wEN2AFipQ1YN+OMflgRJWklLD7PSMicAEV8J6I+CFKRh2beRpUax1EA?=
 =?us-ascii?Q?F1T9YwDObv7fjq8fxf5oOEo89cu71SqCHTxEb9wqTerbDMIIRhInUcroLa3P?=
 =?us-ascii?Q?CmfB048e95JlJsm+9CPK6j24ss3kvXHrSTlbU+JTWCKqZdXv2RqYsMBaw/uR?=
 =?us-ascii?Q?2UUFySxcCJ6zR1D0AeYg57sMLllExV+m6f/+FtNlSXfavRHNm4W46wSU4V0H?=
 =?us-ascii?Q?GwPymYFCRnI/WpwGza75DSBZYXgsbPozlNkaPLvLFGwLnnJYYAf/4smkyW0K?=
 =?us-ascii?Q?AZTxby272fq9X81XWY9IM1p7F5rX1u3tj9Fiq31UuhxCYWa6IY6kveuO0M/z?=
 =?us-ascii?Q?yF7vGWFJKwxro6F2evwsunGru1n0TMMEbw0zBbfxIx4gqhjTVTPuq4Lcx5Pq?=
 =?us-ascii?Q?ozfDiomQCl+uQOG2cvmUuTkt8H8xyQlDU8jq0cnrh23domB7DiKjHVU1Bu3/?=
 =?us-ascii?Q?uuq/nofk3j3HybZ3bygQRVJ8idVPOjJTw67o4CFo3VfAyGvw91xLtDycvyJA?=
 =?us-ascii?Q?3U1PCtEaF4Q0dt/spGgf7PqIy+VJIlK7gRyRd+K795VasAKnHrXY5o5lo4kP?=
 =?us-ascii?Q?/hjgdZjIbv+PfTFjXqWZfJVF2BJ4cOxxVLd404UIW3rumqqzPZjY4vM0bmGe?=
 =?us-ascii?Q?maHvyBkS3DI4keUcqgZdXBxx7AyFY/DktXgqqM5fKrDLoyt0y61xLk4AkxhG?=
 =?us-ascii?Q?fT+T67yCqTmDZZ7JKiXdeswjG63NJLeNs6PahcAjvIko1fdBI1DU8YO7KpD1?=
 =?us-ascii?Q?RsEF7nI+WpPGP7Pb1LuOj2kjaFfDNf+kFtfDlkCDBeMo0UCYxICws39+PLC2?=
 =?us-ascii?Q?yk5Qvvn9xwbIyeSZxmcckF0oLehauJxol/a3I8dQTqFgaSKDpznX8C1vDET/?=
 =?us-ascii?Q?QWzQ5lZ0qemwhJturyc4iOhKVsY5pkDA5Q6hnBc9gKAI8ZSfZeWeYwxkxJ2U?=
 =?us-ascii?Q?dR5c1H1ra5q2DaniJMrb7dIh09uztVUKmGrcbC4sRCd3GXA0ztcbuKKcLQPJ?=
 =?us-ascii?Q?s37nnRBtM91oOwvltZOfCuk833rlDHkffKvjWOW0StZ/GnMWbKQcPlZmyJJ/?=
 =?us-ascii?Q?nY/gTsq3kOE8VWMazbxPPQTSUYaeYd04LU4K08NRZMJ39IovHFbqqu9uqmfZ?=
 =?us-ascii?Q?OnbC2GXtY7818xEGXOpsNxCuuKZI1SFBhaA8E2+tTNjM+UFz43tnGq+ZZSA8?=
 =?us-ascii?Q?Rjy7/DlFrAlXA6ZN3Wb+YjcU7oEaGBUM4NVL8piK+/Dl+Z0106DcNqjsvweu?=
 =?us-ascii?Q?Ti0TuXwcuzJKSA4oxCvzzFXcj8w=3D?=
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502845d7-a7a0-4847-f170-08d9b9d5b037
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB3102.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 23:02:48.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwQ2UyhTKesyZzUN3njCWfwLdvkfdiPzPYiYHXi/cVx2fdIZQNx2fUna3kppoAVn72UkHBchwNUxaWnKRN7BezgXMEfHScD1GCBuKXai4/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB2910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAAM driver contains several variables, which are used for indication
that certain capabilities are detected during initial probing of the
device. They are defined as u8, but mainly used as boolean variables to
identify capabillities. CAAM JR driver code also contains the static
variable in the probe method, which is used to derive the JR index value
and does not respect how JRs are implemented in the HW.

Clean-up all assorted variables, collect them into one bitfield value
which encodes capabilities as bit, and use them in the execution flow
instead.

Replace static indexing in JR driver with index derived from "reg"
binding, as it reflects the actual JR number in the HW.

Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
---
Changes in V3:
- Address review comments from V2 series, replace inline if statements
  with explicit ones
- Add more helper macros
- Merge change done in separate patch for JR indexing into here
- Change caam_ctrl_check_jr_perm() from register readout to status
  binding check
- Do not export caam_ctrl_check_jr_perm() anymore, drop the declaration
  from header
- Remove more local variables in probe() and replace them with
  capabilities readout

 drivers/crypto/caam/caamalg_qi.c |   2 +-
 drivers/crypto/caam/ctrl.c       | 115 ++++++++++++++++++++-----------
 drivers/crypto/caam/intern.h     |  20 +++---
 drivers/crypto/caam/jr.c         |  19 ++++-
 drivers/crypto/caam/regs.h       |   2 -
 5 files changed, 106 insertions(+), 52 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 189a7438b29c..1b7cdae28290 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -2610,7 +2610,7 @@ int caam_qi_algapi_init(struct device *ctrldev)
 	bool registered = false;
 
 	/* Make sure this runs only on (DPAA 1.x) QI */
-	if (!priv->qi_present || caam_dpaa2)
+	if (!(priv->caam_caps & CAAM_CAPS_QI_PRESENT) || caam_dpaa2)
 		return 0;
 
 	/*
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ca0361b2dbb0..37c0c6af1137 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -79,6 +79,36 @@ static void build_deinstantiation_desc(u32 *desc, int handle)
 	append_jump(desc, JUMP_CLASS_CLASS1 | JUMP_TYPE_HALT);
 }
 
+/*
+ * caam_ctrl_check_jr_perm - check if the job ring can be accessed
+ *				from Non-Secure World.
+ * @np - pointer to JR device node
+ *
+ * Return: - 0 if Job Ring is reserved in the Secure World
+ *	    - 1 if Job Ring is available in NS World
+ */
+static inline int caam_ctrl_check_jr_perm(const struct device_node *np)
+{
+	struct property *p;
+
+	/* read "status" property first */
+	p = of_find_property(np, "status", NULL);
+	if (p && (!strncmp(p->value, "disabled", p->length))) {
+		/*
+		 * "status" is set to "disabled", which would imply that the JR
+		 * is not available for NS World. All other possible combination
+		 * of "status" and "secure-status" would rather indicate that JR
+		 * is either available in NS-only, or in both S and NS Worlds.
+		 * In a later case, we indicate that this JR can be used by the
+		 * Kernel since the resource is shared.
+		 * For details, see:
+		 * Documentation/devicetree/bindings/arm/secure.txt
+		 */
+		return 0;
+	}
+	return 1;
+}
+
 /*
  * run_descriptor_deco0 - runs a descriptor on DECO0, under direct control of
  *			  the software (no JR/QI used).
@@ -100,7 +130,7 @@ static inline int run_descriptor_deco0(struct device *ctrldev, u32 *desc,
 	int i;
 
 
-	if (ctrlpriv->virt_en == 1 ||
+	if ((ctrlpriv->caam_caps & CAAM_CAPS_VIRT_ENABLED) ||
 	    /*
 	     * Apparently on i.MX8M{Q,M,N,P} it doesn't matter if virt_en == 1
 	     * and the following steps should be performed regardless
@@ -169,7 +199,7 @@ static inline int run_descriptor_deco0(struct device *ctrldev, u32 *desc,
 	*status = rd_reg32(&deco->op_status_hi) &
 		  DECO_OP_STATUS_HI_ERR_MASK;
 
-	if (ctrlpriv->virt_en == 1)
+	if (ctrlpriv->caam_caps & CAAM_CAPS_VIRT_ENABLED)
 		clrsetbits_32(&ctrl->deco_rsr, DECORSR_JR0, 0);
 
 	/* Mark the DECO as free */
@@ -612,7 +642,7 @@ static bool check_version(struct fsl_mc_version *mc_version, u32 major,
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
-	int ret, ring, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
+	int ret, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
 	u64 caam_id;
 	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
@@ -622,8 +652,6 @@ static int caam_probe(struct platform_device *pdev)
 	struct dentry *dfs_root;
 	u32 scfgr, comp_params;
 	u8 rng_vid;
-	int pg_size;
-	int BLOCK_OFFSET = 0;
 	bool pr_support = false;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
@@ -666,11 +694,12 @@ static int caam_probe(struct platform_device *pdev)
 	else
 		caam_ptr_sz = sizeof(u32);
 	caam_dpaa2 = !!(comp_params & CTPR_MS_DPAA2);
-	ctrlpriv->qi_present = !!(comp_params & CTPR_MS_QI_MASK);
+	if (comp_params & CTPR_MS_QI_MASK)
+		ctrlpriv->caam_caps |= CAAM_CAPS_QI_PRESENT;
 
 #ifdef CONFIG_CAAM_QI
 	/* If (DPAA 1.x) QI present, check whether dependencies are available */
-	if (ctrlpriv->qi_present && !caam_dpaa2) {
+	if ((ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) && !caam_dpaa2) {
 		ret = qman_is_probed();
 		if (!ret) {
 			return -EPROBE_DEFER;
@@ -689,33 +718,29 @@ static int caam_probe(struct platform_device *pdev)
 	}
 #endif
 
-	/* Allocating the BLOCK_OFFSET based on the supported page size on
-	 * the platform
-	 */
-	pg_size = (comp_params & CTPR_MS_PG_SZ_MASK) >> CTPR_MS_PG_SZ_SHIFT;
-	if (pg_size == 0)
-		BLOCK_OFFSET = PG_SIZE_4K;
-	else
-		BLOCK_OFFSET = PG_SIZE_64K;
+	/* Allocate control blocks based on the CAAM supported page size */
+	if (comp_params & CTPR_MS_PG_SZ_MASK)
+		ctrlpriv->caam_caps |= CAAM_CAPS_64K_PAGESIZE;
 
 	ctrlpriv->ctrl = (struct caam_ctrl __iomem __force *)ctrl;
 	ctrlpriv->assure = (struct caam_assurance __iomem __force *)
 			   ((__force uint8_t *)ctrl +
-			    BLOCK_OFFSET * ASSURE_BLOCK_NUMBER
+			    CAAM_CAPS_PG_SZ(ctrlpriv->caam_caps) * ASSURE_BLOCK_NUMBER
 			   );
 	ctrlpriv->deco = (struct caam_deco __iomem __force *)
 			 ((__force uint8_t *)ctrl +
-			 BLOCK_OFFSET * DECO_BLOCK_NUMBER
+			 CAAM_CAPS_PG_SZ(ctrlpriv->caam_caps) * DECO_BLOCK_NUMBER
 			 );
 
 	/* Get the IRQ of the controller (for security violations only) */
 	ctrlpriv->secvio_irq = irq_of_parse_and_map(nprop, 0);
 	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-mc");
-	ctrlpriv->mc_en = !!np;
+	if (np)
+		ctrlpriv->caam_caps |= CAAM_CAPS_MC_ENABLED;
 	of_node_put(np);
 
 #ifdef CONFIG_FSL_MC_BUS
-	if (ctrlpriv->mc_en) {
+	if (ctrlpriv->caam_caps & CAAM_CAPS_MC_ENABLED) {
 		struct fsl_mc_version *mc_version;
 
 		mc_version = fsl_mc_get_version();
@@ -732,7 +757,7 @@ static int caam_probe(struct platform_device *pdev)
 	 * In case of SoCs with Management Complex, MC f/w performs
 	 * the configuration.
 	 */
-	if (!ctrlpriv->mc_en)
+	if (!(ctrlpriv->caam_caps & CAAM_CAPS_MC_ENABLED))
 		clrsetbits_32(&ctrl->mcr, MCFGR_AWCACHE_MASK,
 			      MCFGR_AWCACHE_CACH | MCFGR_AWCACHE_BUFF |
 			      MCFGR_WDENABLE | MCFGR_LARGE_BURST);
@@ -745,7 +770,6 @@ static int caam_probe(struct platform_device *pdev)
 	 */
 	scfgr = rd_reg32(&ctrl->scfgr);
 
-	ctrlpriv->virt_en = 0;
 	if (comp_params & CTPR_MS_VIRT_EN_INCL) {
 		/* VIRT_EN_INCL = 1 & VIRT_EN_POR = 1 or
 		 * VIRT_EN_INCL = 1 & VIRT_EN_POR = 0 & SCFGR_VIRT_EN = 1
@@ -753,14 +777,14 @@ static int caam_probe(struct platform_device *pdev)
 		if ((comp_params & CTPR_MS_VIRT_EN_POR) ||
 		    (!(comp_params & CTPR_MS_VIRT_EN_POR) &&
 		       (scfgr & SCFGR_VIRT_EN)))
-				ctrlpriv->virt_en = 1;
+			ctrlpriv->caam_caps |= CAAM_CAPS_VIRT_ENABLED;
 	} else {
 		/* VIRT_EN_INCL = 0 && VIRT_EN_POR_VALUE = 1 */
 		if (comp_params & CTPR_MS_VIRT_EN_POR)
-				ctrlpriv->virt_en = 1;
+			ctrlpriv->caam_caps |= CAAM_CAPS_VIRT_ENABLED;
 	}
 
-	if (ctrlpriv->virt_en == 1)
+	if (ctrlpriv->caam_caps & CAAM_CAPS_VIRT_ENABLED)
 		clrsetbits_32(&ctrl->jrstart, 0, JRSTART_JR0_START |
 			      JRSTART_JR1_START | JRSTART_JR2_START |
 			      JRSTART_JR3_START);
@@ -785,10 +809,10 @@ static int caam_probe(struct platform_device *pdev)
 	caam_debugfs_init(ctrlpriv, dfs_root);
 
 	/* Check to see if (DPAA 1.x) QI present. If so, enable */
-	if (ctrlpriv->qi_present && !caam_dpaa2) {
+	if ((ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) && !caam_dpaa2) {
 		ctrlpriv->qi = (struct caam_queue_if __iomem __force *)
 			       ((__force uint8_t *)ctrl +
-				 BLOCK_OFFSET * QI_BLOCK_NUMBER
+				 CAAM_CAPS_PG_SZ(ctrlpriv->caam_caps) * QI_BLOCK_NUMBER
 			       );
 		/* This is all that's required to physically enable QI */
 		wr_reg32(&ctrlpriv->qi->qi_control_lo, QICTL_DQEN);
@@ -801,21 +825,32 @@ static int caam_probe(struct platform_device *pdev)
 #endif
 	}
 
-	ring = 0;
 	for_each_available_child_of_node(nprop, np)
 		if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
 		    of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
-			ctrlpriv->jr[ring] = (struct caam_job_ring __iomem __force *)
-					     ((__force uint8_t *)ctrl +
-					     (ring + JR_BLOCK_NUMBER) *
-					      BLOCK_OFFSET
-					     );
-			ctrlpriv->total_jobrs++;
-			ring++;
+			u32 ring_id;
+			/*
+			 * Get register page to see the start address of CB
+			 * This is used to index into the bitmap of available
+			 * job rings and indicate if it is available in NS world.
+			 */
+			ret = of_property_read_u32(np, "reg", &ring_id);
+			if (ret) {
+				dev_err(dev, "failed to get register address for jobr\n");
+				continue;
+			}
+			ring_id = ring_id >> CAAM_CAPS_PG_SHIFT(ctrlpriv->caam_caps);
+
+			if (caam_ctrl_check_jr_perm(np))
+				ctrlpriv->caam_caps |= CAAM_CAPS_JR_PRESENT(ring_id);
 		}
 
-	/* If no QI and no rings specified, quit and go home */
-	if ((!ctrlpriv->qi_present) && (!ctrlpriv->total_jobrs)) {
+	/*
+	 * If no QI, no rings specified or no rings available for NS -
+	 * quit and go home
+	 */
+	if (!(ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) &&
+	    (hweight_long(ctrlpriv->caam_caps & CAAM_CAPS_JOBRS_MASK) == 0)) {
 		dev_err(dev, "no queues configured, terminating\n");
 		return -ENOMEM;
 	}
@@ -832,7 +867,8 @@ static int caam_probe(struct platform_device *pdev)
 	 * already instantiated, do RNG instantiation
 	 * In case of SoCs with Management Complex, RNG is managed by MC f/w.
 	 */
-	if (!(ctrlpriv->mc_en && pr_support) && rng_vid >= 4) {
+	if (!((ctrlpriv->caam_caps & CAAM_CAPS_MC_ENABLED) && pr_support) &&
+	    rng_vid >= 4) {
 		ctrlpriv->rng4_sh_init =
 			rd_reg32(&ctrl->r4tst[0].rdsta);
 		/*
@@ -900,8 +936,9 @@ static int caam_probe(struct platform_device *pdev)
 	/* Report "alive" for developer to see */
 	dev_info(dev, "device ID = 0x%016llx (Era %d)\n", caam_id,
 		 ctrlpriv->era);
-	dev_info(dev, "job rings = %d, qi = %d\n",
-		 ctrlpriv->total_jobrs, ctrlpriv->qi_present);
+	dev_info(dev, "job rings = %ld, qi = %s\n",
+		 hweight_long(ctrlpriv->caam_caps & CAAM_CAPS_JOBRS_MASK),
+		 (ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) ? "yes" : "no");
 
 	ret = devm_of_platform_populate(dev);
 	if (ret)
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 7d45b21bd55a..37fa9db461c7 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -86,15 +86,19 @@ struct caam_drv_private {
 
 	struct iommu_domain *domain;
 
-	/*
-	 * Detected geometry block. Filled in from device tree if powerpc,
-	 * or from register-based version detection code
-	 */
-	u8 total_jobrs;		/* Total Job Rings in device */
-	u8 qi_present;		/* Nonzero if QI present in device */
-	u8 mc_en;		/* Nonzero if MC f/w is active */
+	unsigned long caam_caps; /* CAAM Module capabilities */
+
+#define CAAM_CAPS_QI_PRESENT	BIT(0)	/* Queue Manager interface (QI) implemented */
+#define CAAM_CAPS_JOBRS_MASK	GENMASK(15, 1)	/* Job Ring is available in NS World */
+#define CAAM_CAPS_MC_ENABLED	BIT(16)	/* Management Complex is enabled (F/W is active) */
+#define CAAM_CAPS_VIRT_ENABLED	BIT(17)	/* Virtualization enabled */
+#define CAAM_CAPS_64K_PAGESIZE	BIT(18)	/* CAAM register page size (64KB if set, 4KB if unset) */
+
+#define CAAM_CAPS_JR_PRESENT(id)	(BIT(id) & CAAM_CAPS_JOBRS_MASK)
+#define CAAM_CAPS_PG_SHIFT(caps)	(((caps) & CAAM_CAPS_64K_PAGESIZE) ? 16 : 12)
+#define CAAM_CAPS_PG_SZ(caps)		(1 << CAAM_CAPS_PG_SHIFT(caps))
+
 	int secvio_irq;		/* Security violation interrupt number */
-	int virt_en;		/* Virtualization enabled in CAAM */
 	int era;		/* CAAM Era (internal HW revision) */
 
 #define	RNG4_MAX_HANDLES 2
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 7f2b1101f567..e218d4ae604c 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -511,10 +511,25 @@ static int caam_jr_probe(struct platform_device *pdev)
 	struct device_node *nprop;
 	struct caam_job_ring __iomem *ctrl;
 	struct caam_drv_private_jr *jrpriv;
-	static int total_jobrs;
+	struct caam_drv_private *caamctrlpriv;
+	u32 ring_idx;
 	struct resource *r;
 	int error;
 
+	/*
+	 * Get register page to see the start address of CB.
+	 * Job Rings have their respective input base addresses
+	 * defined in the register IRBAR_JRx. This address is
+	 * present in the DT node and is aligned to the page
+	 * size defined at CAAM compile time.
+	 */
+	if (of_property_read_u32(pdev->dev.of_node, "reg", &ring_idx)) {
+		dev_err(&pdev->dev, "failed to get register address for jobr\n");
+		return -ENOMEM;
+	}
+	caamctrlpriv = dev_get_drvdata(pdev->dev.parent);
+	ring_idx = ring_idx >> CAAM_CAPS_PG_SHIFT(caamctrlpriv->caam_caps);
+
 	jrdev = &pdev->dev;
 	jrpriv = devm_kzalloc(jrdev, sizeof(*jrpriv), GFP_KERNEL);
 	if (!jrpriv)
@@ -523,7 +538,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 	dev_set_drvdata(jrdev, jrpriv);
 
 	/* save ring identity relative to detection */
-	jrpriv->ridx = total_jobrs++;
+	jrpriv->ridx = ring_idx;
 
 	nprop = pdev->dev.of_node;
 	/* Get configuration properties from device tree */
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 3738625c0250..186e76e6a3e7 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -1023,6 +1023,4 @@ struct caam_deco {
 #define ASSURE_BLOCK_NUMBER	6
 #define QI_BLOCK_NUMBER		7
 #define DECO_BLOCK_NUMBER	8
-#define PG_SIZE_4K		0x1000
-#define PG_SIZE_64K		0x10000
 #endif /* REGS_H */
-- 
2.25.1

