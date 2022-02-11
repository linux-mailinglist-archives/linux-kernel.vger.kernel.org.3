Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE864B2A23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbiBKQWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:22:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBKQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:22:17 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40131.outbound.protection.outlook.com [40.107.4.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0E1FC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:22:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFQ2DP6U9dDfvymmln+qazZJbzYfGLa287kSPdGq3LB4l2yZXMTGAUsY5iSHVnpZRnU0T8opXKSb49vQEJoXQSTva32cQG1a3xPw4CSo4PiNPuJoqvCfb8SvFwlZtTUVTwtNMZ7VFte3KyNOMDdBg41A6WMKDfXk+cHHRA0p64SV26Vg+v2OaFVg6w3CtSZMCGCwCydZVRi2yr6Wo+abOuoy6Dp0JwhogBtzjcKxo5qX+cJAMyo9eZDN5rfYtOyzQiBY1j7zcba9T+5j2JbwAANnmRnGYmwXGcfyKgmQDm/10M1wi7JKBHRLahki7+Ntq5/krOG8m7KqMCG+F3v25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAcHh6G/IT140NbydMeccww7FJZlQGUkRpGd2/6Qilo=;
 b=ZcvhEMjBGRAD94zl8vamTJVC+EU9oTfn/30aalYu3/NnVKQ6qO8mQVNImuTpLcfhFqeylcP84+O9rlnYWpdEuEhu8tQ5HPeznyYh3Z7rByXPN5mwyWsy9yxEnnKvk3kAvjovx7JxbgUS5a3nUzLSKJ4rZxFNCrJukvSfq9v6f1/JFirHBAUPgo3+bJt4CaXaQPiRMzxz4g+Vys9424OQqNBe781oSd321gfRowchwJ6G7vGOG0ZzW992MNvoTeXZX54IrnC9SuPhUMhzMBcQAjd8BjnWOZlREzUpXXe2onAXXgISoyXgheyvJ1WO4MC79tpqJ20OUzlvFFecNeXMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAcHh6G/IT140NbydMeccww7FJZlQGUkRpGd2/6Qilo=;
 b=HwIUYtu6syJp0A8rL6ZIgoWJ3jkr0AmabbXxzLhzlYfGFe9pdAAZUVuxSQ5rxECrOzOE/n0AUkplHHuG7j7X7gxqaMOZQj9o78uczo9tYphhm20tLmPWxjdiW3IJCATZ0a7tzLbiACw3QW/S5otP+ueqSI3quoL2R//uV76MX10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB3503.eurprd03.prod.outlook.com (2603:10a6:803:30::15)
 by AM6PR03MB6120.eurprd03.prod.outlook.com (2603:10a6:20b:ec::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Fri, 11 Feb
 2022 16:22:11 +0000
Received: from VI1PR03MB3503.eurprd03.prod.outlook.com
 ([fe80::bc85:315d:e7f2:f001]) by VI1PR03MB3503.eurprd03.prod.outlook.com
 ([fe80::bc85:315d:e7f2:f001%4]) with mapi id 15.20.4975.012; Fri, 11 Feb 2022
 16:22:11 +0000
From:   Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, dragan.mladjenovic@syrmia.com,
        elver@google.com
Subject: [PATCH V2] mips: Enable KCSAN
Date:   Fri, 11 Feb 2022 17:21:42 +0100
Message-Id: <20220211162142.2402-1-nemanja.rakovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To VI1PR03MB3503.eurprd03.prod.outlook.com
 (2603:10a6:803:30::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbdf3476-ea63-4e1c-bfb6-08d9ed7aa7ed
X-MS-TrafficTypeDiagnostic: AM6PR03MB6120:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB612001F7EA5A966A13CBED418F309@AM6PR03MB6120.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xooVhLUAsVS5uSh5tZPmS8ESwH0rbt0WI54G6RYdY0hMYV2x4Uc09WSRkuPLxVF79AogDEIpvabVzfXIThU441KTcZ2xrOSifmsYz0PlS92UT5oQ79yi/38NbhueZPvyDJ2jGhbhfM5qWwrOtb9Jf/il2CZO5jC4sWjGqdGUum8nqUHUXeAechmCrwy6xqTiYGBX5MYgl9naObz7E7RqgbCRMWsJ1sM3ITpx16ZgAt14+7Cv/h/Tv8j7dBocqFxiumWrEq4F1KRQ0ObM6J2kGTJ54bnk8goQacihVDDGdjMl5dfmuDfD0SRui8diAOr+hUhJVh54x61bxZlnNQAcP/51BsNzVC3Nq2lv5CC5DX12rIT9plsTgTCrcw1K/PBpa0NpLQ+6vCcdbTjOqjH6Q2SwnUmj58qOAdbUQ/r/2Bw5YNkbvMLJgICMHZOafh1XeVnN4vUsp5GbtWRL95hQ0IVCQ80OV6sgNkvV8Vqw19hnm2cuPUgveES0zqNIItz+ykweyABVNwZ1TJZ3cvJLZxFq0rdebqhut2soUM9INgLQcuMEc0Cuw6jlIcEW/NzNbsgsnG/uuXWg4O37IeYdTAxsaA+y3sNrbgY9VvYm7206u6bM3/8mtGNeOjwwVckzMYwEvVKXmRuxW3bwHnPtkgp8EsUhycPV2XOtee5+uzBMDgS6W7o41Rskcv5/3bp4uIk2lrA9vyjaGw8AUHnEigfmSg9ctscIfMpmecfeW9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3503.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(54906003)(83380400001)(109986005)(6666004)(6512007)(316002)(8936002)(26005)(38350700002)(2616005)(38100700002)(186003)(52116002)(2906002)(1076003)(66946007)(86362001)(508600001)(66476007)(5660300002)(8676002)(6486002)(66556008)(6506007)(4326008)(44832011)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O0brAisK8MfMh20hhduGf7D3LSX2m+bSilnnTOQ729rtwMQtOBTfV8Ut2T+n?=
 =?us-ascii?Q?5PkV6HXnpkPZBIR7ZiiFEYVBF2AaImhnQMrZPHrEEiUT1ejCawvLEddApb1p?=
 =?us-ascii?Q?frwBMQ5mc6cqi2C/nLS+tO3c2yehzfYUh0y+sjtu4kvN7y5ikEARm8xQhL4r?=
 =?us-ascii?Q?E+PNAyS2BGpNbuv8oHIbhGJVMcZDuLcYG3zYGYwyeASaTHwd0rHhq1B57LGK?=
 =?us-ascii?Q?lg4NcehbTqAY9vMjshHBPgBdlzxjq7NobN1Gz/9EHiMlMEt7YVH/3tfhXmVC?=
 =?us-ascii?Q?xKtgcUKzcuBZxQg/gR5iOT88Vb4ypMNKiZVPJbNs8rBscef2JfCdPmW+yy34?=
 =?us-ascii?Q?LLsfvt9R/8vXMetzC2byBdd3Dl8MNDGRPzM2Bx4gkOgakvTB28QDAYuB0Nz3?=
 =?us-ascii?Q?HdRXw4cCvb7MExiYcyrrm7dkeHR0bL9ypDK797b8iFpeGC7SfNvvKqiqC7Ag?=
 =?us-ascii?Q?sdzGyVRMekOYHaGJ9j884onPDGG2AgGWU2+a6D7atLXvyH+5glx8n08Wv0lz?=
 =?us-ascii?Q?Hrdt3QuMUpbVQhaC99U3ISkUKlBbr/mt3pxfGT4BS7qwgKKz9zUZAKo9nld5?=
 =?us-ascii?Q?7Mphc5ldkdPdcRbgiU7MQeyAmu8ayy4OJxMTukjqtLsYbI0dS3iGzDWNFWlk?=
 =?us-ascii?Q?buyPeVq+GO3eeoVw7f6uI52Fq0HJW+sn8xPdvXAasGIv/pcTp8GG5eHEgufN?=
 =?us-ascii?Q?NNMWwhU7nUDotm8DDgSey18a0UnVIRjX8vqXwbeXf3GuYYjPraQCs7b3oIsR?=
 =?us-ascii?Q?2mDfh+9ao1pHIBrY3az3FuVTzJ4O/Erl0UzimK3JF5r0DuV2uK8cC/1Bol6K?=
 =?us-ascii?Q?1CeJ8A07zSq7hwWQfVZ9DYXvni7li/k4W0oER1WkBUuvK90V5wozvyirjn3v?=
 =?us-ascii?Q?AOFeOA45gxy9bUlIQG42/WTWNXym9kaUiP8026NTXYIuqLRXVBQgbxVFA71q?=
 =?us-ascii?Q?bFKGMGmYbfnCpe1/3SzqTPwEo5oVkQHdVIv8DyM/WefiyKx91ikOAD6Y4Q4/?=
 =?us-ascii?Q?nD1VvPX1fd1kQ6Pe/n3H0B25Nq0GM7Psn4SKpvkxGJw8sszVKWhSPLN6znxK?=
 =?us-ascii?Q?A5IMa8aNNO6RZ9j3bOQo/HQ13bSM74txnU17LkC1a0sqJHtLXsf2si4M0loB?=
 =?us-ascii?Q?6b/thCmjKntu29JdHdK2Nv6zE3qSp8DoY0Gwlh7+74cpH8wX6OfFQpdVlrjZ?=
 =?us-ascii?Q?RWvUtYbRdFoiOQx0tiAnBe6rDmTI4V+s6tsEEHg93FzhhmC4Z6dbcDcP7Wld?=
 =?us-ascii?Q?3728r8+L0oTljcJvLhFcxBCwlVcmUgdDqD6hz4MHyxdyweaBuI6lhnnKvtmG?=
 =?us-ascii?Q?x7xm54VBXfvS1HFX0DsZSIV1odDxAAHEO7IUE4j4tii/sw7Zt1Sp8Qlsy/pM?=
 =?us-ascii?Q?pVCGbj7Ok3are7VsVIk6J6vXx8Z4GvSF4+carCvtN5YVrNd+h8FlJSVJhxxS?=
 =?us-ascii?Q?ROZDIbikabq64TYSQ0NT/zQHI0I6gBr9xXT5FFy4N5blpsvO76ms+WrftEl1?=
 =?us-ascii?Q?JvTuRZ3upvFdqaxSMbw0szvm3Oy1ls1+fHrJXHAi4fDdDs0y3e2dTSJfutdN?=
 =?us-ascii?Q?Z0V9+JXYccaGuNaCMxU21atgpydnjhpUDqzDAx2lkwWUzPqaXWnFTuJ0IoSt?=
 =?us-ascii?Q?3UejaYH9X2vSl4WfA70MCwMj8FTI22S2ufhMmGTSsWfSRrxQcm8ZcIbak7pS?=
 =?us-ascii?Q?5FjCWrJxPYzCrlt+33GO29hKCSo=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdf3476-ea63-4e1c-bfb6-08d9ed7aa7ed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3503.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 16:22:11.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuEqq9U8uSq9kdKDiampZbZQ1K+wFZ4NxHDDYdnMCq7xTsBCEY9UtAgOtenJrwLGYal9yN9ieWDsMkh5u97mJ+Ciin9IDemoeTXk/mkTvpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
index 5a15d51e8884..6cc28173bee8 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -38,6 +38,7 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 KCOV_INSTRUMENT		:= n
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
+KCSAN_SANITIZE			:= n
 
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

