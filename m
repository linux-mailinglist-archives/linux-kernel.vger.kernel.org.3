Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A74533C46
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiEYMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbiEYMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:10:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7861326E7;
        Wed, 25 May 2022 05:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdf2NRdB5duYzg5muAqPEfT1Tc8jgKAZc+v/wRRVT+Ahh5phlJAUZfkoLVO7m57oPITfK7qETNdmQ942US9RP8vVTdE0fbhkRmcQOADFQRJ6F5Jc/MYRoTQTxhxfI9LlgHWbzJaJiuQvq9orRryx1X7ABny6d6ABktzDgdtJeU2/Q7i/1eBeSr55+8RBVvvzoGBE0bGzpKsUPFQTVb87ZmdEqNkqqln1Px/P7mgS7XXmRjmutRl5YUKcsuCZuGj4BoUC8Ge459ahJV2xXXLJ46TQI6HMNW5qAzsYdU1hhSJJ1e9jeKP68+pw5J+N8fPg7XV0+lxf1vssQvvRHNKexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKHeY6di+GfXY6TFQaFocHDXSUADOxmeX5VfbEZLDDY=;
 b=gi5L470W8ZWM1+6gLA36B9Ur55Of7aCXCQPhfqLZKYiVRD7X1zvX5EZWwzcAYaS3jjp8CtaN1DjhZOhddG/yxcInHEtilbthzuA2NeI2pPwsz/Gbh/zqGlm1AwNwjblhYF0u7DkcI06Ylx38A7XbkdeEsBsBwb/B24IG7fTYjznofvIjI6nxWGR4Qf2cHPLVcfIz7kDi/K8dEMoCExd32dMnL/nM6+VLMlqw0H26FO8wJedLUqYDowtEqAPEbX9FfuyS+/kpPe7LN6Ub6GSdgMAKoRd9Qyuo2ICVxDDPd8fjZVnNSWM6Qc5SAHYkd0liy06+k6lYljJJAdKjWEzcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKHeY6di+GfXY6TFQaFocHDXSUADOxmeX5VfbEZLDDY=;
 b=KiH3qqexU0ewZWhsmnP9ZWYyOyNK7Unu6p7zHnl7XxjTvc12HlCw5Jvkpkw5dgSRMSlYDl+gEpmSinR5TWhtfIorqKe3TSErRY+wvnh86bm0h3Z+r3YPMDhMZQ8hKjJCUNoCo/YEu6kuJGZPI9UZbmaLtDno3QoVUIOZk8mHyH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:51 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:50 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Subject: [PATCH v2 02/12] MIPS: GIC: Generate redirect block accessors
Date:   Wed, 25 May 2022 14:10:20 +0200
Message-Id: <20220525121030.16054-3-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa36879a-b5a7-4796-9e78-08da3e479be6
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB7859BB911E859FB5B56BC5A1EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbCXZZm/rZYxpJUEcEJHrmGcHu6m750y6qeRJ46KC4l++A4w5HkgrC4ZhLNOof/5LVZfyyRPc/G8wjyFokeV+vMm/MxIZ/0+GCtneQiJrWdnUE+h5KrxMliOU7xghT6CawDvBO+p/iJr3dTdVSCHGHyZeZ14C1SVix6ktdkCdTOeeDzMzsjQIaoLNBccLtuvvLp7YrEus9i5Oj0VYIpItnsi5MZtCPXh1lEEWYTTCYMhpi1+LSHIbMPPEaANMMW1KMcI+H2k3UaO9iBoRujbZlW89ihvtS4/PcTVCSDnma/cYkuLCf3xO8sJO+yJlb/DmjdH4qSoQq1f4rYvUcibTphon5NtVOIR8gqqwdR6LByFfZq3klaafi8Zjwc0B+C44ehQTrAiz0/Nu0qrPw6oDa+oXJ0wQ2eFJc25Ge+nhRbzsbzf0uKh2N0Q0Jm8UM15QX04qnpSkhZmdu5kQuYD6HZYzBDrZOZl/6XllSWgys7utrTVOnRztZO2irrpxnel7x+Tg6X9B9TSpdaGn84zTwFgo6BUXCRtYkZY3Sj7a6sx2D/QiSZwq8A5qsuqpcbJ4h7cy1NQBkZ9zutZ9NMUVhb9M4xp0QDL7x1BnywhgXQGWTIY/TMe/gZ96d5S80b7bcu8bXc7E/ff6YqRfDq4vhJjqk+BJxMsLLQ9tDEi/4oTMCQmbLVTggLibUltXrrLCcL47D8WvCe3pyDo4krPnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(136003)(39830400003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4c/uoCFKMm93KECXwGeyaDSJCSXvdrNZiCAAcrIgtCUndeOL8zERmoj8UZO?=
 =?us-ascii?Q?rmkxmqyD46yu3YBLvzYc6Nj9cQPD8sNh0XR3t0kXT2+QMLIC2D6Pq6+hIl9X?=
 =?us-ascii?Q?c0omgx+BJVM2STVJRZvwSXfeHfcsPfRgzPB6LpR+fmp1q4xnLzyVm4DDTkQ2?=
 =?us-ascii?Q?4R0N3kYRqLus9+nRbinoBrkvfJz9FAwAufdTHj9RuwSaFQmx9pWi619VTaPO?=
 =?us-ascii?Q?tBcGSqIRyqKdtNKHOpZMYWLPIUXgxruUrg0WegVd+ZIbKmz+ROEKfQjGAnQS?=
 =?us-ascii?Q?O+MBXNNkaLDRgRoQ+G8U6JZ5bAgmzLe59yd+/PDijM0XT8RiVUkQias1TNxD?=
 =?us-ascii?Q?nLAAdOc9SBO/EhmhSmKJPgJHPboi9RwfyPuAr7XOrxoORjfS3eQFNd/iE9kh?=
 =?us-ascii?Q?h09KcljC3kSxByljUgO+5H6IT+XkU/Hz3vvyNmeBiSOLhzANObyQQzO9Yu5Y?=
 =?us-ascii?Q?fEJ2tC10fmOTZZ9HCmaSCY0ruJtPWo08PsHvi/LI2ECYHIZHtj0vzUpvrwbX?=
 =?us-ascii?Q?EEX8Vt3r7U4HEtFhuCnMr38sKT5A0G00VxG8+Tlgrq974jlVFMuzQ8QKxPJX?=
 =?us-ascii?Q?rfE2gS2+d61NtmOo+Myvn1d8zeW/7xZrN5GQoJPjAmj8PDcf/PWG5v1YffJJ?=
 =?us-ascii?Q?Q2tFvIUoKnsED1UXqxBwM/ewMBCgADcw/Dk6nQlwne+jIOnggOQuCiASIfBz?=
 =?us-ascii?Q?emhq0BrosxRjKpMOgKjTZ8QVP4zv3FWA8J5pJPrPOAIcMHalSLSHNxLpI7Pu?=
 =?us-ascii?Q?PQhPtCWjD+bU0vNOHLyOHmGllTN7sXc8iiSNH+DO5uaGUt/wtQeH2i0IZnl4?=
 =?us-ascii?Q?WOa6+WD/lu/eN/2YznixgTtiQazDjoWoOQcoSz5fzQgc8JBu/PrYYqeXHuZN?=
 =?us-ascii?Q?wUlm9t0zFtyXIbKFWg8h9rq1cyyFZr0pT02RGx9ttCn6LJUnhUPx+wykqPrM?=
 =?us-ascii?Q?gaxYf8RviQNuH9bku7s0L0v5a24NNhUOAj60Bx4Gcwzmm6pgR3v1bQNn3xAe?=
 =?us-ascii?Q?hVl5rvyEQqj7p8zfxE4XNguCy3ZmqLF4tcczYOzFqJRyLp38qEoBz3SFOB5p?=
 =?us-ascii?Q?342HIVQX8QNE/fY0muiX6zyQljWRt/LcIKOQx4YP0bhLNctPu50W/84AVIB9?=
 =?us-ascii?Q?9/jfp4P4YzIH9rG2XzroWmA3mPlTnLCEbKM7nENUCwvIslQJCPZbWq6+0r+j?=
 =?us-ascii?Q?HP+jBOJ3Li3C/F47kQpKpCwr27AXx6iq04f2avZOQwlsJQu8dsB9MnYOg+CM?=
 =?us-ascii?Q?OrakQV9nj5OlZWN1zYC/wa2VDvjWBOCm/+6iI0O7OnNAk9f2HvRZhR7Lx//y?=
 =?us-ascii?Q?zH0wMypZZzxNkcYDcR/qa6POXFxdLYE2JJTKGMM7yG6LDbrJXQrtIGa+PhN4?=
 =?us-ascii?Q?VCJiFXsBD8oX2dmRlIcBFpDcLc6mjRah5klqxZZLngryma4224y7HDrFuehi?=
 =?us-ascii?Q?WJnY0Di/u2lmkIMBlsQOlCUsVBnTrs6GCCJ6mRCnFzHSxlwGg2Xx3mwWD1te?=
 =?us-ascii?Q?22LWhmiwBBPoGBbCEODQPUjBcjt/B54btvBRxmu6Mag2G5zKn4YSyp4wXefL?=
 =?us-ascii?Q?lXUX846MqK2qkk4GVJ/53Uoc1ICqEsfJ3isAEY3TfBTMXGULA7hA0Y6ofEFV?=
 =?us-ascii?Q?WMDsG8d++gmfoyIVc3iT1vcmvH5ojAjI4sXjwtCPJhWA9L6LbbDl/s9ZufrQ?=
 =?us-ascii?Q?Qy1I1qzuqP0HBdj785q0et9kDa8pFQINIc9Is7n6LsNaOcDAXLxA/WGNH2KN?=
 =?us-ascii?Q?eL4HyxhA7Ta2WvGbs1FPhZ6uSsAWXfE=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa36879a-b5a7-4796-9e78-08da3e479be6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:50.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9yk2QqCTPGfpWzSibr7dcibrtuuNXNWeoSlJ4CCRqep/ZN/uwu5zO0zM8NReTW3KpJOk+HiVoSHBJIZr5P1aLWG0p9e7YIVe6buL6K8FNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7859
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

With CM 3.5 the "core-other" register block evolves into the "redirect"
register block, which is capable of accessing not only the core local
registers of other cores but also the shared/global registers of other
clusters.

This patch generates accessor functions for shared/global registers
accessed via the redirect block, with "redir_" inserted after "gic_" in
their names. For example the accessor function:

  read_gic_config()

...accesses the GIC_CONFIG register of the GIC in the local cluster.
With this patch a new function:

  read_gic_redir_config()

...is added which accesses the GIC_CONFIG register of the GIC in
whichever cluster the GCR_CL_REDIRECT register is configured to access.

This mirrors the similar redirect block accessors already provided for
the CM & CPC.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
index 084cac1c5ea2..fd9da5e3beaa 100644
--- a/arch/mips/include/asm/mips-gic.h
+++ b/arch/mips/include/asm/mips-gic.h
@@ -28,11 +28,13 @@ extern void __iomem *mips_gic_base;
 
 /* For read-only shared registers */
 #define GIC_ACCESSOR_RO(sz, off, name)					\
-	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
+	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)	\
+	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_REDIR_OFS + off, redir_##name)
 
 /* For read-write shared registers */
 #define GIC_ACCESSOR_RW(sz, off, name)					\
-	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
+	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)	\
+	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, redir_##name)
 
 /* For read-only local registers */
 #define GIC_VX_ACCESSOR_RO(sz, off, name)				\
@@ -45,7 +47,7 @@ extern void __iomem *mips_gic_base;
 	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
 
 /* For read-only shared per-interrupt registers */
-#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+#define _GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
 static inline void __iomem *addr_gic_##name(unsigned int intr)		\
 {									\
 	return mips_gic_base + (off) + (intr * (stride));		\
@@ -58,8 +60,8 @@ static inline unsigned int read_gic_##name(unsigned int intr)		\
 }
 
 /* For read-write shared per-interrupt registers */
-#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
-	GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+#define _GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
 									\
 static inline void write_gic_##name(unsigned int intr,			\
 				    unsigned int val)			\
@@ -68,22 +70,30 @@ static inline void write_gic_##name(unsigned int intr,			\
 	__raw_writel(val, addr_gic_##name(intr));			\
 }
 
+#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off, stride, redir_##name)
+
+#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off, stride, redir_##name)
+
 /* For read-only local per-interrupt registers */
 #define GIC_VX_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
-	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
 				 stride, vl_##name)			\
-	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
 				 stride, vo_##name)
 
 /* For read-write local per-interrupt registers */
 #define GIC_VX_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
-	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
 				 stride, vl_##name)			\
-	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
 				 stride, vo_##name)
 
 /* For read-only shared bit-per-interrupt registers */
-#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+#define _GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
 static inline void __iomem *addr_gic_##name(void)			\
 {									\
 	return mips_gic_base + (off);					\
@@ -106,8 +116,8 @@ static inline unsigned int read_gic_##name(unsigned int intr)		\
 }
 
 /* For read-write shared bit-per-interrupt registers */
-#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
-	GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+#define _GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
 									\
 static inline void write_gic_##name(unsigned int intr)			\
 {									\
@@ -146,6 +156,14 @@ static inline void change_gic_##name(unsigned int intr,			\
 	}								\
 }
 
+#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RO_INTR_BIT(MIPS_GIC_REDIR_OFS + off, redir_##name)
+
+#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RW_INTR_BIT(MIPS_GIC_REDIR_OFS + off, redir_##name)
+
 /* For read-only local bit-per-interrupt registers */
 #define GIC_VX_ACCESSOR_RO_INTR_BIT(sz, off, name)			\
 	GIC_ACCESSOR_RO_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
@@ -155,10 +173,10 @@ static inline void change_gic_##name(unsigned int intr,			\
 
 /* For read-write local bit-per-interrupt registers */
 #define GIC_VX_ACCESSOR_RW_INTR_BIT(sz, off, name)			\
-	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
-				 vl_##name)				\
-	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
-				 vo_##name)
+	_GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
+				  vl_##name)				\
+	_GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
+				  vo_##name)
 
 /* GIC_SH_CONFIG - Information about the GIC configuration */
 GIC_ACCESSOR_RW(32, 0x000, config)
-- 
2.17.1

