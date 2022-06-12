Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04497547B93
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiFLSro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFLSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:47:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DD519C02;
        Sun, 12 Jun 2022 11:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMzlntGMPL99Yg3zC5mhC2/aHUzh3kiHVA4RBHEhcxezpezKv2/Qnsi8lopP7+J1v+YOib2GbaDD87XC6miuejYCRZYOrHcE/xmh5BvRr5j/P+TwekEa5tP0UmQ/Sf0k8kRgoP0+mYzA9wQPko43edcHqU8HksjuD2ZKE6znRs/WR9aY2urkmjjEGEbBG5uWewe6th03sL7czX885Et5z0vg9rPAdWq8w7x1STtjLj3zu/7F7cAA0i78jhHmPrvr/CNGsUg5+kK7VdyupE55KSbQ8pDGvKlwJ1x4wTMeadSMVRW1js0mzZJLpoBuJZVoq0Ji3S9M0OFlkLfV7IREbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAS/WqgaLI5ZDulXxSzgiEpfhXEF7f3M4bAAqAArLk4=;
 b=EssuTSkJ7Sbo5Mq/2DKsHKMJll6ZKftLJr4Xa0ju50iMNbi2sgYL/1CAsOdlsohihgQk/HujfZseAFOSi8eWsh+vMbEXC1yvfAYaeRFAT+EIKIVojNxFfIWNWgiNROGCOpTZjX4Bug29SWm47Fqqv3HG6vbi8Ir86pJ0OvtVgDDpBRybhybkYKOgeoQMPSzgZ/OvScgcCc0qejvXSHOm2SynAa/u0rblJdO4AOM9o59LWs2dogFunNQKR5HjsOvvuBuQuVkVmylwui64JmarTtOWfvzof/S2KS1IhEL3PbtHLPy42cY28vNDdQoHtlfWseUFyLh1FSHFBNVCrHbsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAS/WqgaLI5ZDulXxSzgiEpfhXEF7f3M4bAAqAArLk4=;
 b=Wo+gLqyNyDnddzH82pYitoOtU4RTo6dxLnEBqreKdbfU0ftIRxSeGC0WQEWuDbYHeLRK1xbzOSNDJE3jRWl60HD+CocLcCuDzx2UYlrURpk5+L4mEYECV2IE80yuSehgK4S8QownyTfsO4H4LIZlkyCZOP7cpn2QFyVn6JD8gZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:111::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Sun, 12 Jun 2022 18:47:38 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95%9]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 18:47:37 +0000
Date:   Mon, 13 Jun 2022 02:47:31 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>, Conor.Dooley@microchip.com
Subject: [PATCH v3 3/3] RISC-V: HWCAP: parse Bitmanip/Scalar Crypto HWCAP
 from DT
Message-ID: <YqY0w6SeebuNP1vS@Sun>
References: <YqYz+xDsXr/tNaNu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqYz+xDsXr/tNaNu@Sun>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70804b8b-6f2e-46d5-0ba6-08da4ca4058f
X-MS-TrafficTypeDiagnostic: OSZP286MB1063:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB106301FB23EAE60E4901FD0DBCA89@OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6PZ0JP2buPdkCz77PUD6lOj1JoirIAMX11tQfZ3FUOZ2gDgX9X6vwAuoRacsbaa9aRa/7lldFd2OdSQ4a7wrJpx/Y4utCihd+iMb7U6rlOsT5nw77gg2W5slHX/N2ydX+bNCacAI31kT6LXavtkOHJLi/9uJHpcgdblzN+IvkuiaCek9/jOVs7VX1rW9C/bo4s4T5crDsMHhVHbqxdfZ2tcozNcMsfhoBDTR4WvT48VHArjsMuPks/+EpJv6dJ4o+o+ui2vzhYpm0y3UNxIuujwyDsLpcV2B6LLzgstLEmXxRGHe/Xfz3vKXneWyNtU/mFTOgKXJH7ABCQAj9tF0MLW+Xy9vYOEm2gE+p+dqU9jbyKd0jVd1HdJ48a0P8J/w9q+IgL2eqOcocx7rP3DBKm1QXfS02ksy1bMN6pR/RaUXPzV/I7fPEAuzWltnzB5FU8aDcQO62kPuTOV94vDb6p7faz9nDSQtCP2g8Y6MVxG6wT4iXDtaG0bRJDrsdWYnadp0cG1zA0vZKQjupplcxrRJKVEAUdXFPThRYnpZ7GMbyxkRVydQu2R/jqOeGp5efuoZn+yG221T/x6yK8b05JiVp+Yvw9M/rtnignphorqUXawtgEZ3/Lj9gvkPmbaG/E++ygWiAnJpSB+/PUGa4l27PwwRtGdNWhFrW57sM0hVsUjULcnERk4d8T+8Oo4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39830400003)(366004)(346002)(396003)(41300700001)(41320700001)(6506007)(52116002)(9686003)(6512007)(6666004)(786003)(316002)(110136005)(54906003)(66946007)(66556008)(66476007)(33716001)(6486002)(86362001)(508600001)(38100700002)(186003)(83380400001)(8676002)(4326008)(2906002)(7416002)(5660300002)(8936002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dw5oQjvfr2A0p1uBKG+AVBGhi6O/MDHhztqN14loJH17sf42qVvPECXtOLxD?=
 =?us-ascii?Q?bXBDQFMBOnrvZ/IO0BglTRzMIxr6ovYc2JXqgCENug7crq5l/EdYK/twCnPO?=
 =?us-ascii?Q?j6Kt/RvKpfEt/LWtJ7YqDYRZYvImor2JLqRpKAAokzG0zgxzWoo3zdZokywd?=
 =?us-ascii?Q?LDGxUYPIJXQ2p0A8yW9HhSOQl1oLiNYNFLhaiACxOjpBx89cnl+GcCKPqp8h?=
 =?us-ascii?Q?hzBTZQVOpOsR6cKCCydmg//EToqhAaSGLS5Tkm9pBN94X/fG4O51Hrv5DH0L?=
 =?us-ascii?Q?EJlB+MkxxhWpHUBreiD4ZH3bcp0Ji6nyDK+hMDl2YnKmihmCDvrzJcDy2QNL?=
 =?us-ascii?Q?fb1hGuPsPyR5FWqh3JU+35VToFveRnWIi9ZVzG7K8/6HGQNzG4IQWUvMfrX/?=
 =?us-ascii?Q?iaesEXxH83yCZiq7A14Tw8oMcQXQNuhfTt2U/1xrbBv8C4ZYuY8HYtu3sHks?=
 =?us-ascii?Q?c1i0RLUFw315qPj5rPkGrCve81qJl0Mpc27rgHyeRdyRWReBrufRbLkp9Mi5?=
 =?us-ascii?Q?tRLTGcxNoFnVeeEtJbLlNZJvHNr8wnGSoKHDYrG7yr1r8c9OsFciBGQTP6S2?=
 =?us-ascii?Q?OIAbmhskYKWyfqNToTxN7QOeYUJ9HmkkJ9mRJcRA9Q2S85J2PLa52HDA60YE?=
 =?us-ascii?Q?4TblfG9/bGAeJzVEH0yf45dvHKSN4wthQkFm3rsinPU6bPsograBMNdNEA0G?=
 =?us-ascii?Q?ugFjXGppW0CbPfo0UuklCssqVtWKjVlMH0g7fyiuRLTPhNlJlCLSvQ88VAN8?=
 =?us-ascii?Q?0ruPrkKAOLoW18hs9PPu7f237aTImqN/vuDKjiSQPZryaQMr70FsH6k7MW8l?=
 =?us-ascii?Q?k9mwg+Wogk036CNX67VTnPlCvYnFIzY8u/WmVc5OkXhc0q3gTEaPNJSlXE0B?=
 =?us-ascii?Q?FrKjp5uTBz9Et2exeFs/lCwAcR+ms8tJyuNHGD3Gft5e9E9/IyXshD1IMUbJ?=
 =?us-ascii?Q?DdtIdZfhD0YAyKeJ7laD9lJhCZgVYzZsQ2Uzxza0TKWZ9E6tcGqwQOXueu1B?=
 =?us-ascii?Q?IjaCAiDfR5jWI4BdZX8se470SJZeaVMYtyrm2U87K2y+fiC2n3Pe7KyrmCKS?=
 =?us-ascii?Q?Wrx7vxuX9oFjmSBWiWpVayO6BbVKm85Lsfvp2xAXER2taQOQRnzyiAkxTOQo?=
 =?us-ascii?Q?tEX7zUMJytHObd72tl4P/ehllHWJ+CF/BhQjWzBLULovHXx1t72KDDm/uN6X?=
 =?us-ascii?Q?MUOpCi05xTutTPxL6mrriRG0q8oXHAi3LF5+VLa8tlEPT6OBdcg4g18o0xsV?=
 =?us-ascii?Q?x+WG0xZYzfV31G0HM98DsIIRSwlVU4ObBfU6MCfAveQ63a1/rnfilp0C3ZQR?=
 =?us-ascii?Q?qQlxlHQ5C/7flZ4GgP1e5eh6QadswmQI8OMOtfk22jMJ5cCSvX53KfPr8o/P?=
 =?us-ascii?Q?vYlo4X85RNrQ7lU14mYHW5kXJD868VUpBlqTNIcf7ngJBNHetwCHXHaHCI/A?=
 =?us-ascii?Q?O6IPTidoQMadOxP869oE5Ci74wrAWQ+6bqzB7xJOkVB/WK+R+yG6Nu1Fpq+u?=
 =?us-ascii?Q?PtYBAho88qCMIcW+Npm3Zp2LvJTOTYjqdMV7CfgjYh6r9+pXRAIiRlIrK6Gm?=
 =?us-ascii?Q?r/TRbYbd6S09dXPjypTiHxIL7/7vHe7gke/Of5+fgHC7wCwB7p/sZZkf6iHc?=
 =?us-ascii?Q?kYVjIZiQSVH3PnckD/2k1sCCnc3GewTIUiVTKzejiiMqAXksCM2e+iWrwwJj?=
 =?us-ascii?Q?4NhwZElGiCHQr5emdF/aEfqFOSWIN4Zj5b0d3T86W9LdoSEDeXZTKVUVJ/cP?=
 =?us-ascii?Q?qX0PzxC3dQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 70804b8b-6f2e-46d5-0ba6-08da4ca4058f
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 18:47:37.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wsdr9D1IPhQ+ZYmfVBfl0DOxotLJF5v4MekOgUv+erehpNEEjIeU5us9IkctBaDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One viable way to detect Zb/Zk HWCAP is from the DT binding.
No matter how the "M" mode things change, this way can
always be an auxiliary way to detect it.

Note that QEMU currently has "zba/zbb/zbc/zbs" in their device tree
riscv,isa

This also fixes the isa2hwcap way as using unsigned char
for long extension is not viable. Note that the tolower function
ensures functionality. For other no-hwcap extension (e.g. h, s, u),
or ("|") with 0 has no effect on hwcap.

Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 arch/riscv/include/asm/elf.h   |  2 ++
 arch/riscv/include/asm/hwcap.h |  2 ++
 arch/riscv/kernel/cpufeature.c | 48 ++++++++++++++++++++++++++--------
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 14fc7342490b..cbf70c5ac1a4 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -65,7 +65,9 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
  * but it's not easy, and we've already done it here.
  */
 #define ELF_HWCAP	(elf_hwcap)
+#define ELF_HWCAP2	(elf_hwcap2)
 extern unsigned long elf_hwcap;
+extern unsigned long elf_hwcap2;
 
 /*
  * This yields a string that ld.so will use to load implementation
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 02c454a12683..ef0349c5d303 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -17,12 +17,14 @@
  * instruction set this cpu supports.
  */
 #define ELF_HWCAP		(elf_hwcap)
+#define ELF_HWCAP2		(elf_hwcap2)
 
 enum {
 	CAP_HWCAP = 1,
 };
 
 extern unsigned long elf_hwcap;
+extern unsigned long elf_hwcap2;
 
 #define RISCV_ISA_EXT_a		('a' - 'a')
 #define RISCV_ISA_EXT_c		('c' - 'a')
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0c2638365ec2..40a5ab3962f0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -23,6 +23,7 @@
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
 unsigned long elf_hwcap __read_mostly;
+unsigned long elf_hwcap2 __read_mostly;
 
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
@@ -74,21 +75,39 @@ void __init riscv_fill_hwcap(void)
 	const char *isa;
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j;
-	static unsigned long isa2hwcap[256] = {0};
-
-	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
-	isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
-	isa2hwcap['a'] = isa2hwcap['A'] = COMPAT_HWCAP_ISA_A;
-	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
-	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
-	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
+	static unsigned long isa2hwcap[RISCV_ISA_EXT_MAX] = {0};
+
+	/* HWCAP */
+	isa2hwcap[RISCV_ISA_EXT_i] = COMPAT_HWCAP_ISA_I;
+	isa2hwcap[RISCV_ISA_EXT_m] = COMPAT_HWCAP_ISA_M;
+	isa2hwcap[RISCV_ISA_EXT_a] = COMPAT_HWCAP_ISA_A;
+	isa2hwcap[RISCV_ISA_EXT_f] = COMPAT_HWCAP_ISA_F;
+	isa2hwcap[RISCV_ISA_EXT_d] = COMPAT_HWCAP_ISA_D;
+	isa2hwcap[RISCV_ISA_EXT_c] = COMPAT_HWCAP_ISA_C;
+	/* HWCAP2 */
+	isa2hwcap[RISCV_ISA_EXT_ZBA] = COMPAT_HWCAP2_ISA_ZBA;
+	isa2hwcap[RISCV_ISA_EXT_ZBB] = COMPAT_HWCAP2_ISA_ZBB;
+	isa2hwcap[RISCV_ISA_EXT_ZBC] = COMPAT_HWCAP2_ISA_ZBC;
+	isa2hwcap[RISCV_ISA_EXT_ZBS] = COMPAT_HWCAP2_ISA_ZBS;
+	isa2hwcap[RISCV_ISA_EXT_ZBKB] = COMPAT_HWCAP2_ISA_ZBKB;
+	isa2hwcap[RISCV_ISA_EXT_ZBKC] = COMPAT_HWCAP2_ISA_ZBKC;
+	isa2hwcap[RISCV_ISA_EXT_ZBKX] = COMPAT_HWCAP2_ISA_ZBKX;
+	isa2hwcap[RISCV_ISA_EXT_ZKNE] = COMPAT_HWCAP2_ISA_ZKND;
+	isa2hwcap[RISCV_ISA_EXT_ZKND] = COMPAT_HWCAP2_ISA_ZKNE;
+	isa2hwcap[RISCV_ISA_EXT_ZKNH] = COMPAT_HWCAP2_ISA_ZKNH;
+	isa2hwcap[RISCV_ISA_EXT_ZKSED] = COMPAT_HWCAP2_ISA_ZKSED;
+	isa2hwcap[RISCV_ISA_EXT_ZKSH] = COMPAT_HWCAP2_ISA_ZKSH;
+	isa2hwcap[RISCV_ISA_EXT_ZKR] = COMPAT_HWCAP2_ISA_ZKR;
+	isa2hwcap[RISCV_ISA_EXT_ZKT] = COMPAT_HWCAP2_ISA_ZKT;
 
 	elf_hwcap = 0;
+	elf_hwcap2 = 0;
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
+		unsigned long this_hwcap2 = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
@@ -187,15 +206,17 @@ void __init riscv_fill_hwcap(void)
 #define SET_ISA_EXT_MAP(name, bit)						\
 			do {							\
 				if ((ext_end - ext == sizeof(name) - 1) &&	\
-				     !memcmp(ext, name, sizeof(name) - 1))	\
+				     !memcmp(ext, name, sizeof(name) - 1)) {	\
+					this_hwcap2 |= isa2hwcap[bit];		\
 					set_bit(bit, this_isa);			\
+				}						\
 			} while (false)						\
 
 			if (unlikely(ext_err))
 				continue;
 			if (!ext_long) {
-				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
-				set_bit(*ext - 'a', this_isa);
+				this_hwcap |= isa2hwcap[tolower(*ext) - 'a'];
+				set_bit(tolower(*ext) - 'a', this_isa);
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
@@ -246,6 +267,11 @@ void __init riscv_fill_hwcap(void)
 		else
 			elf_hwcap = this_hwcap;
 
+		if (elf_hwcap2)
+			elf_hwcap2 &= this_hwcap2;
+		else
+			elf_hwcap2 = this_hwcap2;
+
 		if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
 			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 		else
-- 
2.35.1

