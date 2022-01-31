Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8014A3FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358053AbiAaKRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:17:31 -0500
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com ([40.107.21.91]:59041
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358007AbiAaKR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:17:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbbJOL0KZBGCW4cyK3X5+9yc3FicwevtpsyzqojOuIWTLstJtedRW9p/5LBu1Cn3+wGJF6dFvCZuIIHZ6p8oR4d+aIKeWQglOtR/jV1bKLh51WuQ2XmIMEVZFyQnSzuFWnC8D5BGN8KX5VgXwEsTTGYNiAMeiE4b275rFx4z2CrMIxvYm1fW7wgavFsymiLinolMcRE2PmamNO/AeMbyntFrlwUZ4+wj/ZD40w3w/JtFyr/pde5bQXLlwnS8szWV0VuGvEbT9mNht9QkGWhzs3KBnYJX2WCOZyNWebQukaQSxV4n0LYdi4+0e+tFlCoIIOLRS9sizrjIKNa56ja74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jprqp1wpSmv/+IpaJLRMzJt+LtbGTSJ2C3pfGOhQEbg=;
 b=i7/G4MG1fDsTH4c10d/OdfbXUEEpRcJgOjipWscaXL5rlKbQopi7ZrxG3ZdFcoWpdkG41p0/PrZtXFfUKXtVA1IJHcbJ4/g/oHbUse8twGtQFsG6ctCZ8mAl/pRXcEXF930BqKDNmeznwx9ExzM0Jh09uVuuxEdEXATz1ZPobc8QAgotx1Dn/8jky9c7ePhNOsWxp4kfx03X7+9jCVX8No3TOzEWyUP5TfUsDop8zC41ktos36VORRGxA6DWMYi9RJN+wd/ozJO5rEF7misazzSJhxmIZEN7enIqrs2yoLzNqKniFPKC1q6/WyUrNDXyImOCkEcCPf53fvbDSRmFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jprqp1wpSmv/+IpaJLRMzJt+LtbGTSJ2C3pfGOhQEbg=;
 b=CZNun2LIm++ZMxx+qx+V+hNQM5tRXA+WeGc0yWNk+tyPd3N6LmnR+xzztO07hwk0ZW/cfmXJFUhcebWrqZ/oBLzjr8E+weoeFIjkSaIoTyoHtGJJNX8xAoE7Dp7sJXgsxjdk6nP//vR4jcv/j4/SaCckdO/BVgmT9bUu6l5KUF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB3503.eurprd03.prod.outlook.com (2603:10a6:803:30::15)
 by AM6PR03MB5656.eurprd03.prod.outlook.com (2603:10a6:20b:f7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 10:17:23 +0000
Received: from VI1PR03MB3503.eurprd03.prod.outlook.com
 ([fe80::cd9a:2b22:3199:5b58]) by VI1PR03MB3503.eurprd03.prod.outlook.com
 ([fe80::cd9a:2b22:3199:5b58%6]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 10:17:23 +0000
From:   Nemanja Rakovic <nemanja.rakovic@syrmia.com>
To:     linux-mips@vger.kernel.org
Cc:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, dragan.mladjenovic@syrmia.com
Subject: [PATCH] mips: Enable KCSAN
Date:   Mon, 31 Jan 2022 11:17:09 +0100
Message-Id: <20220131101709.17434-1-nemanja.rakovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0121.eurprd09.prod.outlook.com
 (2603:10a6:803:78::44) To VI1PR03MB3503.eurprd03.prod.outlook.com
 (2603:10a6:803:30::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abfd08c-b334-472c-cfdc-08d9e4a2df13
X-MS-TrafficTypeDiagnostic: AM6PR03MB5656:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB56560C3F59B0EDB66DC785F18F259@AM6PR03MB5656.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQYnAUlnNUfPUGp/0L6BIVYBPjmNiTGlxdlWE3Kw/rTh0xYn5nN03kqX+XBaPSCKsPVR+oaVZqWKLb5P4Gt3EmyUhSYAX3WUwfocOZ7jZHkshw64NL1Hme8VWZD0F7vbRu2QTjeaReGmyr4ZwNiyd/oInAAEN+VuFll79fyCQ/7ZCrWMmK9Gx0zcJH35wmfTatCcgmaq+78f5hrz1nJQzNAnkYC2+TrimHaRuX5gt42GEXiH2tTUyn2MGWsBkk4hD0kBuLFoGryXOyN9iVnoIB6u8CwJEcSfa9HfIKfmkhA6MJxjbfHP/1ZzLmbP5yqAk3K9Xm8rRVoZH/pUlAzmPny+Yh0nahmI95+Zbr5J2xqIR7z9cmJWWvMLYFmY3CuaiXj28U6/O2Qrk7Veh30nyS0ctPkoCJ6YFSGBNAp2s6nsib1N9BH+z7lN9+6bKF3VT3cW0rkwPC7beBVzDLUmtIiR8p6oS6IejD+W9hqq6unpdyA8wjvcGu9Zgle7iVVKHqfLp5URbAxGAtS/ioBkGRiFChNd5m4EnID80Q1XXjxryXxkgIZEnolcP7tWW6UQdcE/l2I0fc/zwFO4b/lkgJCsMPZhokshmuc74koXkzjOK3CyW3X4dBzsI9ukI3ICKmVfxEmML91kM6WFi6oLMmkdfBPiIijxLsrgXpt55M/l4wVpE+/Hm4HvewCSnKLJO05eBVmIz7vr86bQ1K9YBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3503.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(39830400003)(396003)(136003)(376002)(366004)(5660300002)(508600001)(44832011)(52116002)(83380400001)(6916009)(54906003)(316002)(6666004)(186003)(8676002)(6486002)(8936002)(86362001)(4326008)(2616005)(66476007)(1076003)(38100700002)(66556008)(38350700002)(66946007)(6512007)(6506007)(26005)(107886003)(2906002)(36756003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4jdC0F5ioP9dnR79vUVGG7+Ih1kzWDebKp7Dm0ednmMmDWjzI9nMwRjYqdz?=
 =?us-ascii?Q?J47dN2znafMb3pFSphcPjEEwNm2eJPkfy4fCKiVzHg8flfHpJAWwffuXfLnc?=
 =?us-ascii?Q?qyF4OBFQffWrk1qdT4d4MtHicEXgj8WV3hT889aHx0/egAYlk64wYRrkEamr?=
 =?us-ascii?Q?HXKJ4lQdjaf0mP3xAEcXIt2kxfTLi1A28k8+8vhlhZPWWb4mbJUZkOhESmdF?=
 =?us-ascii?Q?myx/vbHgSTda9V+JzZUiBzBNtSLTfQ2y7TPIlUEh8OTYFlCICUj4QypF8Nn5?=
 =?us-ascii?Q?/LKnmzJIMixpwb2l9hGQ5vBg7se3TeBh/zUY/L1yYZkKpbWUWmOKWWhvcgDR?=
 =?us-ascii?Q?eQgSPShfX6y7oQyQv8Ct+jfxFLKWoytdW5GEOsgPrIc90M2xGpIY3FEqasZT?=
 =?us-ascii?Q?mXWOXlhL1GsPsXaASkbKcZMRwu0vFdKqBWMj9AtDJbT8698611SodeGmzhze?=
 =?us-ascii?Q?hs5xszhTQj3tCN0FMpCdGQhuhezWASqn81YpXrG0urMfLlS8SkG4+V8EkGm5?=
 =?us-ascii?Q?9R8pHeQxm46nKYwEd9FSI58AHTceOq1j218zkh7PShlONeRb2ulvtU3SEU/f?=
 =?us-ascii?Q?RLCLk+KV4Jw+y9F/aOJeFANgNz3x1G6ixeLKw4/6TNBIuFrE5yHVHKTLRO/b?=
 =?us-ascii?Q?lx5rFDTnDgS/2PbZoevH2cv1A5580ZbJGYdXwxRQ2YdOCwR7yjPoFVJ4ypGQ?=
 =?us-ascii?Q?vOHrQXVNwsU/aUmvsijL+4jGgZ3ACWOAp/3wjN6Ztkp21ueCPy2rSlsZ2F3y?=
 =?us-ascii?Q?SabDZm3HT8RbCpEbWFpgeZwtqZPjUF/LeB6WCrmi+gS6ezYra80lepJKQnji?=
 =?us-ascii?Q?damayVNm3byb8dqPTL28fAqsEqjqqx2L3Qf5DwnrUCp5OIz+56U9HiWxxy4R?=
 =?us-ascii?Q?VCc0zkIm6Lb//u+SaP0uZdqhhhKs3cyLtX7WLS0UYQgPKN45wfa0JNQsz7Tg?=
 =?us-ascii?Q?C24Vr3p1xc7egexfjBzHb9G2z1HU6J2LkCFvSxYTU4q9zegIzFn7ptUmoLDc?=
 =?us-ascii?Q?Z2jt3xNkrtXgy+wGN1DgvBuADX/Xf/dUry62n97uIFZs/1Hyxn47pvqTHtWF?=
 =?us-ascii?Q?4UkOmji3IbOrFYPs/e1Ohkpvj+stLBWs1CqRsQYoMAXBMQLoi53SEsQ+7JC/?=
 =?us-ascii?Q?zYuEw4+JHFbxVkZDLq6HZ3u3YACR5N+bsvGX5JS7I1gvv+GOrrAhb7sRNA0k?=
 =?us-ascii?Q?yzriY8p8tL3qTDjinwdQGNLPjbBBUgY1y820ZQpGLczefbtyClQIG6vdFBGy?=
 =?us-ascii?Q?YOqTNvvQHz29KqkIV/jb1FfUaZI3G+Ze8GEoJtfrOoSMsm8IsvKIfApGvXfs?=
 =?us-ascii?Q?nnO9xuz70b7yapbQmuwKZv1td1Ws85EMXJDd/XZOiMAq8VEYIooAW0b9yR8c?=
 =?us-ascii?Q?vtcqz1Lgo1wsbMEOkmN+Dj4ITz4XPjZdkLbK9K9Vd6g38Lym657kUA/hapBY?=
 =?us-ascii?Q?N8LKOVKmcSlTh+4ggFty8rrqa0RwjXqUeftJETE6H+4YlpVOybZYsb1EUcA/?=
 =?us-ascii?Q?TKmdDcv9XpAGzJ62Wc/5m2sz45xC4H1E08eX1TkxqLmNrtPiemV1SZYeTtoM?=
 =?us-ascii?Q?PgB5Mo47kk76Y1Z8pHQc+80+0U5qxiKjJt1AzTGEiuj8dPLERbHCBjGLTopQ?=
 =?us-ascii?Q?ZNe6PLCU8oy1x18lTxADhYV22O7Q03yyzJ2YXhGJI85QogmDDp0JC6garITJ?=
 =?us-ascii?Q?/UXgMg=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abfd08c-b334-472c-cfdc-08d9e4a2df13
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3503.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 10:17:23.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V4ZLWKplg9Hj1OZ/zL9adSFFL+P4GS1z40McdiulgpTPeE1la9QOxP8bF+hGntb6Ejn/4NuVMGZy8ZS9QeWBV4ZvOOqKzHEaxk4GhcjYPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5656
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables KCSAN for the 64-bit version. Updated rules
for the incompatible compilation units (vdso, boot/compressed).

Signed-off-by: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
---
 arch/mips/Kconfig                  | 1 +
 arch/mips/boot/compressed/Makefile | 1 +
 arch/mips/vdso/Makefile            | 3 +++
 3 files changed, 5 insertions(+)

Changes were tested on qemu (qemu-system-mips64el) with the
64r6el_defconfig configuration and KCSAN enabled.

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 058446f01487..651d4fe355da 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -101,6 +101,7 @@ config MIPS
 	select TRACE_IRQFLAGS_SUPPORT
 	select VIRT_TO_BUS
 	select ARCH_HAS_ELFCORE_COMPAT
+	select HAVE_ARCH_KCSAN if 64BIT
 
 config MIPS_FIXUP_BIGPHYS_ADDR
 	bool
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 5a15d51e8884..a35f78212ea9 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -38,6 +38,7 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 KCOV_INSTRUMENT		:= n
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
+KASAN_SANITIZE			:= n
 
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index d65f55f67e19..f72658b3a53f 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Objects to go into the VDSO.
 
+# Sanitizer runtimes are unavailable and cannot be linked here.
+ KCSAN_SANITIZE			:= n
+
 # Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
 # the inclusion of generic Makefile.
 ARCH_REL_TYPE_ABS := R_MIPS_JUMP_SLOT|R_MIPS_GLOB_DAT
-- 
2.17.1

