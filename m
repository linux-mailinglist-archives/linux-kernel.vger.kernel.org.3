Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1739352DD25
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbiESSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbiESSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8E5C771;
        Thu, 19 May 2022 11:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgmzT/uk5T9YI5LpTIyDEvnW4uWiqwm552zf7nxkZNizJDUbNgWODgR/j2VSh945EVOvmvem+ATvsyLVIm1BIr6bWXvZKBt33EybsNIANm/r+fD1XqLHRb3BOXfrccgtulipyHlQkpksl17eYUoQFQMeH8Kp/AXmG98jd6yAm848mbM+xlk+AO10KVQTQox/8odPyu+YBLByrekaD0PxGVPTNPLv5pNWUTkJ7bmI8cnWxCQO/iJMp01QfieJIqaAJsEZ5k+DKJGnaT2282dffnU4PdNhVm2hcn1XDjFkGd5mPH92nT6FdYOuAEt7RlXV/V/SqSW8BconoqiPWfFDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyQsYIX+ean4UZUpkyk6ykUMbdOaa1M3iubaLOfoMi0=;
 b=l8CEPYbtIDFf+jdvQVctLIw5vzbZh+HKNw05XupaqBrB4uqi9JHsgyM14miZhMtM932Q5Jisqbwoj2LF+G0SfvIJICmHoj4KJS915p4epfXq7xrbAJYL/swxMWBA23uoN2+fOqlhV4V5Q9+YR5Ft1SYbKJbL6/ZPSLRieUjumCvAcWXBAgxkFk/dQ/O3kpKDR3z9BEOY6TklXYQ5YTks5CseQss94A2Q7Gtdf7rbyRRLyLzdf+kL1P6IgyMw8GpJ1Bgl3v5vWK6wrsll0I8S4a7+B7UoP3WhXZffGq4j+KE1N3Mokne6NkKYzPBKsipIUtPoX1tWogXsyc7g5cqSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyQsYIX+ean4UZUpkyk6ykUMbdOaa1M3iubaLOfoMi0=;
 b=DU3Ua+euqS2HtrQzM/CHZ1M97wKeeyLwcMMN2lpnvqk2Gc+RbpWDxcLK4WBVXUNuFRP0yhSRAgeEt0j/cXfFTcZhIIaRhJZHPDWgOHmd2rCLxnn2Nu/laCrSaLtE7G7fBtuq7PegtWQ+i6Tmj1TYM8NL03/qPnGvT22cCow1Go0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:46 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:46 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chao-ying Fu <cfu@wavecomp.com>
Subject: [PATCH 04/12] irqchip: mips-gic: Support multi-cluster in gic_with_each_online_cpu()
Date:   Thu, 19 May 2022 20:51:17 +0200
Message-Id: <20220519185125.11686-5-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 543c2d76-11f5-4dec-5409-08da39c89f08
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546CCEF92CC1A19C17FB71AEFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ceWpuS+6K/37ZLAcfKVvAykrQdJxSe4Iwyz6kW66bbOCdEacW9pVy/uRrJ6BggCCn3wXzkyCtX6thMP27yx1kYPG2TnhFkDjVaeUCd8mS/rIh0+y3X/sd/9bLfM8nnxAM67kxipLwEd+VmS/WJoeeGPeaLBvPq076CH9UjphO151OwiJzLOJJYknJJPQdk3+bwifyOed+/w5cydLMpbkhcLQxKCD8HNXMhlPJBK+27MiHuoum6ZTZ2HyaLFlT0xSQNSYM8BQQ09CYk2DXFsRYuVhkOwgL3WVui41c53BOwnKO+KZEaMYraODBVp21GzPF18H5X0RMz89ND/QvXwUu6yiHbP/HY8ucY+TGkuz2v53mzX790gsgm3JgXCkK8w3jigCKn1CPuW177Jw9+uv/tuuUyaYeR80MYDP+MOz6o5cVLpiICYHdkiP+DOIBM182uqkLEemfOVxQJfjtfv8ZBGn0vtLh+161WNukDvb0GHBGZFhHk5vTAvCZ5X7Stmu/Cn2oPqECf+ChVMS5I7ZnrXPQh6mb6z79dQVh1ONKDs0252GD5Nsa8vWLuv48oXbCkgc/1kKfxJ2imrWjcNcFldSIZlsaHUkj6mxHJT0LmHmqYlwXkQGLex73UanKQjBi4AkHEmm22CBn1iTcCvqaEsVbKB7AjdrPzUFh4EPhdckynsFlN++l72xpPe5tju4Qz77YmyS9qzm3DkNtA87A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2/rcLu65mIAP/ViHYx4IRQKoElbIu1DRCuOQWhJIhFU3wo+wVrh6jri34+o?=
 =?us-ascii?Q?eEwn8A9mCb92+THFlLeY2kK+C5fToLHnrfBS/M8OXVU7fqb3gLOw41s0CIT4?=
 =?us-ascii?Q?1aNBIF5RJMbOKtMydq8W9TSx7OSuweo7OpTygZjxNxcORpEZFv4kOKmmrZJE?=
 =?us-ascii?Q?7AKCK9nJSzqpR29hq7iMDY9e/cJPowpMwmvDNLqS2WeLaZ3QpfEOKXlzFYCX?=
 =?us-ascii?Q?OIr1TvVmann60juidGRQp5IdCun0M0gu8DyBu0wMxATW75MeAfo6rQdQv+yX?=
 =?us-ascii?Q?STCn74M2o23BQoJZ5iAGScN3fd1z6JF7BeVdkOeNWVCaUoVeJ+/HuUTM22Bp?=
 =?us-ascii?Q?RSEDtejEL5vfyg6vSTYIM+RB7nDh8Yy9VGkZ6qYCO/PBvPehjxWq02ipHj68?=
 =?us-ascii?Q?1rYlHMQtlnbT2dUIRpWxTsbC8hWnSiHg0jPnUDjYyS7c5s8Zn+SvMoBEagHV?=
 =?us-ascii?Q?syA4CtsUg9TRTBjMS/jk6WApborZTz4CNKdh4lfWd19balU9PVgkibwlNC6V?=
 =?us-ascii?Q?zHwCy1/ftwU3SWY0V/7sEZEC19m0sF14arRffkiDsZDuumfNcIBIepsQAh2d?=
 =?us-ascii?Q?YNLzY+OEmoMxxLEhurxSDrivpHUH2vi6l+aX/a9poFpe6V0c3vbk2LVMK2gQ?=
 =?us-ascii?Q?Ay4zTpSMPxZi3wIrM2NpNG9IRphPY8Y2M4FsKXFWQXVVCLeX5yTg10oAtkFY?=
 =?us-ascii?Q?LexyBy7HAodF+CgXkOipzYKf79FZm7l4zP3Tf4wm/G3lL//4fRM8hA/1Wu6h?=
 =?us-ascii?Q?17Q4qzuGDaSLRFeC2ehekkMNOQqFOHWYsLCRLiT44DH8Kyupoaf4HIB5GSt5?=
 =?us-ascii?Q?Deo8H4G3bB/bh9lqXfTe7zrWZQK7Agvs14GqzXLVgvLW3bbhgZUSlOHPdqop?=
 =?us-ascii?Q?qhgVDet/1AV/bPnbbvCrbv4ReRTrs+9sNMnwuhlB3n5pe8HNUGDEo5JLS7TE?=
 =?us-ascii?Q?daK0tWVUTfUuMt6JrJ9o7qw6Ee/iG34B+VdfuV8l9/IYSNPX3PcOavC+nqAm?=
 =?us-ascii?Q?QSAcmikqIIacW735PVGEily57HHYzHPkF71aAxCcnEN2VyVjGGXnR+g1zJMy?=
 =?us-ascii?Q?uFx4Y+s96Q2cbHTi2xFP13BV6fHoMWGa4qEP1hGsTpVmBldHo+KOp/Nfi9MX?=
 =?us-ascii?Q?1eDmNjbCTi5RKqCPXcABcmvNwkjgacUV9/D5UR0WCNzI90a6+7xccqd4GCn2?=
 =?us-ascii?Q?H+uAP5gwGSpGh8Shc5/wTwlEyPca25CiJuX+4EiW6KR/vE8IodxMVTKXutKo?=
 =?us-ascii?Q?PrSc5myQWKfaro+6rqM7h9JksaorUbVjtfO5COR+9nLGk8Fy+2/Uc+wpI8kU?=
 =?us-ascii?Q?ztFvnwWy9totrz7VqhDDCnL2CqHfLCNckDLtZrRLMSzOTS36AcyDGjR2+dhN?=
 =?us-ascii?Q?v3i6IDqeBK1esYn8X9hMO/AfGpkBK2Pjqdw9krFW9WIWdNyn+gqLi1qy62gg?=
 =?us-ascii?Q?l656GRm1uGARyyTRaP0/rN9OmL3sguBN9NrWUxRJQwQb6FUE/fD41pjNna/d?=
 =?us-ascii?Q?F28DY/rcpHoZsGrGLJd+R+IcMFt/5es7g+wC32uFecTlh1X5NIuNnZSE1WMP?=
 =?us-ascii?Q?mRnFDd25OTzjhXBVSQg6ZGe3wHNuHYIDKFMkCB2buHbLDysXFBZriZIvirBw?=
 =?us-ascii?Q?pN4FeSsB0usUXI1ts33bu6IDwT93ls6CDIpnea8/Fcvd009GszGv4HvrJrsN?=
 =?us-ascii?Q?GFcvq5Hm2cHgPqmaPd5bW2IgYzBMNaCc0EqHNiPMveb+mTWBBUbdfEswkl4w?=
 =?us-ascii?Q?CCerSr6OS0UMKOq0Pk/RSxx/0tZVU1k=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543c2d76-11f5-4dec-5409-08da39c89f08
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:45.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeJUwvaCCwrMzffxXSW6exPkSsoZHiqTA/EXsEWuTCs5oVOuweyD6INUrigFSR4MDOM0s+K6eeBgixS7qk5KxaFRWRle4Kbq+/vjWSvl1po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0301MB2546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

Introduce support for multi-cluster GIC register access in
__gic_with_next_online_cpu(), and therefore in its user
gic_with_each_online_cpu(). We access registers in remote clusters using
the CM's GCR_CL_REDIRECT register, and so here we delegate to
mips_cm_lock_other() in order to configure this access.

With this done, users of gic_with_each_online_cpu() gain support for
multi-cluster with no further changes.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 4872bebe24cf..89a3c6d04e09 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -69,6 +69,20 @@ static int __gic_with_next_online_cpu(int prev)
 {
 	unsigned int cpu;
 
+	/*
+	 * Unlock access to the previous CPU's GIC local register block.
+	 *
+	 * Delegate to the CM locking code in the multi-cluster case, since
+	 * other clusters can only be accessed using GCR_CL_REDIRECT.
+	 *
+	 * In the single cluster case we don't need to do anything; the caller
+	 * is responsible for maintaining gic_lock & nothing should be
+	 * expecting any particular value of GIC_VL_OTHER so we can leave it
+	 * as-is.
+	 */
+	if ((prev != -1) && mips_cps_multicluster_cpus())
+		mips_cm_unlock_other();
+
 	/* Discover the next online CPU */
 	cpu = cpumask_next(prev, cpu_online_mask);
 
@@ -79,10 +93,16 @@ static int __gic_with_next_online_cpu(int prev)
 	/*
 	 * Lock access to the next CPU's GIC local register block.
 	 *
+	 * Delegate to the CM locking code in the multi-cluster case, since
+	 * other clusters can only be accessed using GCR_CL_REDIRECT.
+	 *
 	 * In the single cluster case we simply set GIC_VL_OTHER. The caller
 	 * holds gic_lock so nothing can clobber the value we write.
 	 */
-	write_gic_vl_other(mips_cm_vp_id(cpu));
+	if (mips_cps_multicluster_cpus())
+		mips_cm_lock_other_cpu(cpu, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	else
+		write_gic_vl_other(mips_cm_vp_id(cpu));
 
 	return cpu;
 }
-- 
2.17.1

