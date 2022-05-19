Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BEE52DD21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbiESSwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244086AbiESSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89295C65C;
        Thu, 19 May 2022 11:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js4vSDSRpz7ZRFY0oZ/2AHYz3dR6f7xj/uCzQLNOJKN3Ura/2I0ximagmSuBOdjP4aKJjaPdiqq2dAqxOJg467k3bn5Bsw7KkcfNP1+UYfGNitu6nK8o1gHkzFxQTY1qmMEMkP5eeWo1CqWf3N+NL0pFsqESl/EDM0agaWfMhXDl1SdOFCdxSwINCCa3LJo83rEa4xUNMhznoPZFemzbWUobyDD0L0trfAaBl6swExbgieYyDRRs5MI3FLvPXbVrtf8f2KAuGd5EIfczc2sWG7Xyg+fr9TxO+Xgo3vhwJZmmFrXyAlpnLXHJnKN+/BqiSL5/i+oLBvB+lnrXsEeFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbHWfH0z15xz5Aq72pOWfFM72g/RDNt0+IPSkICQQRc=;
 b=XT7H7KS6lGsJZnw7t6jc5jIIxdnKolaBXr9NkfovjWfGS/h9L2SNvGJXDZ0lor5BWKCL0YoMPljKC4so7GIrlZzkdaNjVOinfsMr8FCCKVSoKJyqhyIcYw1c9prDwn90JTm+60n9tTSc+4Gq1cHVlhtqJkAWlMPI0nwWym6nPOXMYChoWQFILZmcLrHpEkl6p8zHGn6KtZO8P+ZsjKqheeRO8pP6LJp125JGs681kBgItJnSlEWmCsrn4IPC9Q5nRQPer1L5+/BAha5wxJ9Wfg2ccTckgc3Uo21nEHBbDUh5Zin3Zq/hPEDcFeGELPPxyKmJOdVysTVqR8wmuBbPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbHWfH0z15xz5Aq72pOWfFM72g/RDNt0+IPSkICQQRc=;
 b=GOagESqd2+Eaj9ON8WYHvySLSqIW0TglAT3uh1lmaUcihzHhArRBUXvn3fjRRgD5TmG2zFZi2RbNI6WFB3XHO2JuupsaAF+cTQTEce29XIgIPTIl+zGSYr8xkQUbF+u4LnlLoTC5EEi8S9edDXjumfX+/fzp7zkeI5CjD1rEbzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:45 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:45 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Chao-ying Fu <cfu@wavecomp.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] MIPS: GIC: Generate redirect block accessors
Date:   Thu, 19 May 2022 20:51:15 +0200
Message-Id: <20220519185125.11686-3-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 173b34ee-6bbd-4cb8-e6e0-08da39c89e76
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546E95E252938756F7DDEDFEFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaBmca+/JrSMC2Oapv/HXvANDWgs4DLm+5vtOTB4CK7KKGGnrtbMtHimP7J12lkwZNFHclwxeqLYqesa3JQ4SCuE6W9acjEbzI9YXb7G3htfkpBIGuJSgSi5ISFJkSIpDYnKBIK+KYiCKKoEys/P5iC5LmsPUvdeoKndiicyEUGcsaRO/M7z6c8Kkc52mIN+LVGgP5PC063ZoOzT4Tly+KgAVWxJh7WJ2eqcoyCTMjjvTQrQZenOMDoIrUK3nXf9uMLqB85rvQLmDsiLG3Jbftc87XEDhzGudhLhQ0huxkgLBNQQf6KbDZUg7VHM2sKLiBdGWoTvZwCDvLTlbEw1Ovs7R8BcUVa+pIzaBBaTSkYIIdSJpL9lPj2J/UWPEwGsJT05mll9yhAl/Pcc+UYowPX438sbj7mglx0Yfg7k8oHolFaw/SFPA7r5tCPSLrWu4n+AO0DZzvO9g+Yr/7Qz0WZxu5aWY+ySVgP4mNQdmGUMfxjLyYOPD7vvKoyLPhMp3smfgrdD+1gjDHOZNllwRmBUSGrbTSlNmdQ5L81WRZHQf2mR8IRepMJyAYIMFnScprUFCXGhe/snZjBpxnaLKI41BvCjTmhBMcDzqHor11FZsYD8rKbMiFfesGtj4xtZJzO++bfqVFBXxly3UZoOoX8VkxWpwK7eTPazFUbxiZLKuXniT13Ahsam9efHACcmn1+SYuJ9IhjtR4QBfCCeCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VcbzS+EzdGiEQVl/p3LlBwN8w5BN6LJ+zoLR5rlug4poDVh7IzSMsjHQcLjJ?=
 =?us-ascii?Q?vrypN1Hcswy3+Be4muFalLhWOLklsaXHcWMNlPPTtAj8GMp6RCMZw4jS/XKC?=
 =?us-ascii?Q?mnT2/IOTRvR1mP4Ku3rdjPJKZEpH4LtPbfrpaIoJMDdW2AbHx+vjyi0rK9rK?=
 =?us-ascii?Q?dst+ykAGynWe4RJQ22vlEpg9XiBwE3ID6z9Bx4gGkf++jPnavfxgbfrxLQ5O?=
 =?us-ascii?Q?oIQN9Aq+2J2+d9Sx93Em2W9HPQ8ZGSm2TJw4bKSh6AJ+857lVSXqZuqdMBI0?=
 =?us-ascii?Q?xpks+AZFXg9599iMxIR4QLA5oZY8k/n+lP/HChHPVLvZr8EIfLvmE8VlJwhG?=
 =?us-ascii?Q?p744tAOz3r6x/Qs0mxi0uL+T0WrYRpmKQ3N47aQS1d0b3Wmfq97utLtZYx62?=
 =?us-ascii?Q?r0iTCnrU1DNTV77ApwHnsWyK8cdwP60iPaO2G2V8rkd2TP7zMO5/N+QvLpK3?=
 =?us-ascii?Q?yoy3jeCTDsY6cFADZptk1NEnn4yeCJMRyyzIrGEIhAjUrv1gzLLZMid9Ijdv?=
 =?us-ascii?Q?lIMu+53z4xeXVjqbA91nlJRUkOybbSoU3eWHLiVkr21XuAh3Tn8p6/tMr4NN?=
 =?us-ascii?Q?co7wr0l1lZdG+FixPGfxuoVcJi9kTufcxb3KYzxDR5WZFlATNflGjMPFZAP0?=
 =?us-ascii?Q?BQSvnojR97i4vsJhW1yD74tiKXyGcvDXAkqi8g1/I0B0N/Btd3GI3avgSobK?=
 =?us-ascii?Q?u145+y+4N+7LeU+GmFqwXSfVIWieosth9jckcsYvWfJMogg4mpXj1PD8x2Ce?=
 =?us-ascii?Q?bbmik13xFJ4hrk8AXy7METzZOTH0RiJi4m7MA2OQjmE+5woixx7oMd+fJtk8?=
 =?us-ascii?Q?N8RtgQdFPU+PAsEbIMdJIjQqoK9cNIdH0e1jCKpj6arsJaxUQ99WOT83MI17?=
 =?us-ascii?Q?wB2sZ3qAwHwi1n7A5RKY6NbDj4dYD/TR4447Y18tsT8ZXghh3eKJftX9zczQ?=
 =?us-ascii?Q?JdIvQtVSeSxkAx6QrgMv0EaVUEXnwi4iq0V+pc2TdfhJl2nj/w1TylLkdp2h?=
 =?us-ascii?Q?L/lPwYHHXqAYQDOVdFkFaZRw+/qIJnDFR2PHptCGgo+BHFE2inSF7xf5pQp0?=
 =?us-ascii?Q?nqRjgUXZXBXDMIcJekS7EHQT6qqS2Ak7y9qPc7vGyRskMkKXdx+MhTse3M6W?=
 =?us-ascii?Q?azmyTXgI3c/9yY6iO4tg0xdhpFNAa9Uh2h7cMwCn5GjmX8ZAKvWN4E/UUGzp?=
 =?us-ascii?Q?o6ExmOqgadH8M5TLz2d3xbRrJz+3i+iWtY5vV9wsiVnRNdGrCtuvCAha31LX?=
 =?us-ascii?Q?rtx+r6XUFAYawsAL8ftP3Juj7WXJIkA19k1AQems4gw12TPSJgZ3JgMocK3e?=
 =?us-ascii?Q?RsyRIqbgOnY9KIJiJYKPsEgaIQDGJw+a/KSx12+MlAobmLR3IAQrtEzTrZZM?=
 =?us-ascii?Q?UUKnDlY1gReoORFLX1vgET6on8cpsYDv5faJs/3CJlqhQ57mSoJD297ENqsa?=
 =?us-ascii?Q?c05YVe67xYfVROHOBF/4foEC3oXWxpWR2kpnAEElKt33DF8UXY7r0dRJb9ue?=
 =?us-ascii?Q?DJNmgMF+K8u557H6gwm+cuFeCZY0B1w+AV6j3cv67woBjT7BQC9UaITiS+lG?=
 =?us-ascii?Q?U8uriJ+KjJiwCA3/6idivFTHjvTtDfG8jOSLZRdGhT3kVZl0iaujkvqSfIsA?=
 =?us-ascii?Q?jgbakJvINIOl2Z2GlLP4GRf0B+I7Il8BgcRG7rYNPOD+4MrPJ3h/qVkHx5dH?=
 =?us-ascii?Q?yjqJRv7Nh+8QaOoSMgSsTCBTMyXQxuPNAr4TKrrap2hBhfbqzRFrkbn2vXXy?=
 =?us-ascii?Q?xFZSq/ViAMUWQWLfpCfysBHy/iWr0ag=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173b34ee-6bbd-4cb8-e6e0-08da39c89e76
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:44.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd4R1DUUL2Ry9xQdMKDsXrOm/FhlVreHZPNI/I/HUx187V8OPQbQmoLaM3JFmoOm3ZDNmV/gKFvfqRQWu4aIf3PjEP4EJqEGB7mIAHrX/c0=
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

