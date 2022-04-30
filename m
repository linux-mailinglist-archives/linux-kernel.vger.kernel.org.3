Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142A4515DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiD3Nzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiD3Nz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:55:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A566F8D;
        Sat, 30 Apr 2022 06:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KghrvQLNxii+iamwaWTbjeLd9v/9zKihCISJA+idyi/1y1bR3qJiRBUOHAQ/oMbZ+8am3/t4Jn7HOKyBk2bnRSxJQ0sXZvaYbOoNyeTwO39vpg50zSyGOdReHsb/2IaX/YmexLy5wV5yo8Lo8Ymvge91mGeqUhCw5mLvCBt+dzqgTatJkAiU6zrobVZoiMgcrWtov9joX4QENEeAWMw+2RI84N33os94vpD4159cJCtyvCxUP9y2kEwXEDqZtMsP9FOgq/8bmmqmu47qCyDBqKdeo8a1tnP/pCy0WIUZTM6gnA7hcKxeI2PDwBCMiFsPIAAfvTs5F6k74+mEymymCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znMOr2UdiYf9gJM+5XymrfVPvk8Y0cGGp54ZuT9/7b0=;
 b=Zir4eW09ZPBuTPxf/+tZCk27OZVIKUHX+Gl4m2Ub4WDpoMqdUOlMfx6EmlrL0IB+RUlnaj7s3rTKUx3E8/BcmMiEDLS2vRjlaRJXb8qhbvVeRigV0hVeHgxSLD1y5nwpfD+WBDc/x5FcOoHkB5pzY4hjR+NtngKFEkU2QwxlnNNj3dZp18fCGvAvvU6TvowUYAO1RkJnetezh9NO4A0P666jCf+42vjm0pyZCQleAilM9UMwC2DSeS9SvJzNj9TyYNV246hZrx9cl0F6icujhYQBUiuu7v2BC6TZP/CtcDCpifIoihOtSUkXD6nx057/kTQVpRRUVUzSsV07kQABTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znMOr2UdiYf9gJM+5XymrfVPvk8Y0cGGp54ZuT9/7b0=;
 b=PBhhYaDb0eF3k404rRcE/0juTtbtfa67E7xz44CJ3Cc1AKiBm7VENKgoToVgbiyinEsu08WhWf/DCyKrhK72gGsaMp0Kx/xo6avQfaEJsZNr44PIS0uCdPMS67s31B27lM5/22fdLGX/YsuLGpGYwppvs2SUaLNL4uMkdwt370s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1559.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Sat, 30 Apr 2022 13:52:03 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%6]) with mapi id 15.20.5206.012; Sat, 30 Apr 2022
 13:52:03 +0000
Date:   Sat, 30 Apr 2022 21:51:56 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH 3/3] RISC-V: HWCAP: parse Bitmanip/Scalar Crypto HWCAP from DT
Message-ID: <Ym0+/JZ7zAGtSP8B@Sun>
References: <Ym0+Erz5DEnB78vu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym0+Erz5DEnB78vu@Sun>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce7e4b6-3c7e-492b-1c0d-08da2ab09aec
X-MS-TrafficTypeDiagnostic: OSZP286MB1559:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB1559D0F1AE9514966C10ECF4BCFF9@OSZP286MB1559.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1PWH6LI3AUJ/ISh+zr1YIz1iTFTSbX8Frrba6ldIv64XendKguQI2jlSIVi6UXojBz6Hfuku4bnw61+Cl1hXkRX68/SWU60OtuHbXSFqnRHiirrSD5nKDIh/hGdQ8ANDZNDq719o3GiWvekTpdk2AHqfK6bIFZbAW8SflPj1WpkNPGG55GL929iesvIkzGSzq5xtyIoa90/0DmoUwhcA/FFqMBuM5A1pjrcBnept1QKReuj8rT36ToX10OJ/aAQ2GGaM4SBk6uBlt8UboKWuxI8qnBtJSIVVYi2GozB40bUpgBAKXIPtCwNNtQ8vc+qlP3FkwfG3dLY9GeyyIv/5zhEky81xgljU3ArtwnxwFFMjss1GgztC4H0P4Z2SCoilboXgCsm4o3+baM1rKpCAb9ytyjD4c6gDLlCq8GvcIISkEiruOQ0pzwDgfNQlGJf4zJHqE1cAnjSZNlCrRSknyTSA6J7SLDFLy3qUbtXGBOzzGsmWEa65/Dhnq7Guonziqgu0vFvCfSGX9JMgZsa1Zhm+ppIXAbFBL0eghzhRkEcU5RvzvVGYWEefbtXl4VqWuJ9bpG6I4P67bxKPouAPtK4gkKTFYfdq5IJzzAPvtVE9WQdtB296J0lc5R2fa7DCwCfMNzJ9DCZvxWQKuYtGKvRiMBJlyKXXANYGPceRIgpwyEd6V4095fp6tfh96Xw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(136003)(396003)(366004)(39830400003)(346002)(376002)(6486002)(6666004)(6512007)(86362001)(52116002)(33716001)(6506007)(9686003)(508600001)(110136005)(186003)(38100700002)(83380400001)(786003)(54906003)(316002)(8936002)(5660300002)(7416002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gf7EKPLrinSb73O2QJcwrxYqnGDKSUkYPWq+s8e4KNDSENcwT/ZnqM/hGxV4?=
 =?us-ascii?Q?yU2dAbds7GLUxJG4ZNm7veAsMDABMu9Yv2aXmXx4wg/Ix4mZYPFDUpNwlnAp?=
 =?us-ascii?Q?BsU1C7DBZH9f1WEbIzlDjJEU9KLRpUKnwL95zLg8W8E9HpfuPK2rGTorxz75?=
 =?us-ascii?Q?gFQAdfyjcD1yCl3jh0ddo1+ZxT4Q2mpsKDNWi79q10FGBvkNgOsQV3csOuJ/?=
 =?us-ascii?Q?HZJU308PLjjWj19WFWK72Gpp/zP1acJU8Mc9tU2zaP89Ui3J9HIh+4WeXeuG?=
 =?us-ascii?Q?wJXynt2W9phtIUjmdSARZO2YZnr/Qtvr1X2uF6OLp05viWPBd5akkIuIpXdv?=
 =?us-ascii?Q?JXpN8a8UbrkKtXqdwB2rPWXsU5/KIC70h0YQ7ffr7HtXMMsTRVU0TwLFPqdv?=
 =?us-ascii?Q?thiOZ27HCSelyESK+2SbCkhuv1HPTKbZD/YxbbzKz7yncjxm9mvackMfnT/4?=
 =?us-ascii?Q?ellkvBji4tmlkHx0Uf49/zbb2dOUQXuwnppRWALcEGdcuUjwDBQkbOCQDHhM?=
 =?us-ascii?Q?NJyVP/phafZV4mwkxIjfZ22mSuOy5JA6p95tIXaOsTMCdn5WPZvgAdkhHlHS?=
 =?us-ascii?Q?qk2fQ7fkhJZKfVA3bWGVvF9X9atDZ/xQSFWiNVNtLb6RgMQaCK6+PCynDnB7?=
 =?us-ascii?Q?RNPmiqME2CEESLqBcF0+2NM2x9EdigWl4iMm2aimbDlswPNlh2P6IHDaGyPU?=
 =?us-ascii?Q?4YNgt42mpBPHhlHho3TIwAroeWkP2c7tDmogVMsOnvXY8lFQParNompZq7nZ?=
 =?us-ascii?Q?R9VYve2Wzq8LGFy68+JsBTOXTBhuc4Y5nCO6NhL/GLiTXppIc4lYtae0Jxlp?=
 =?us-ascii?Q?Skp4P6+gYxqmpUzCoCrepdX60yUMjycVARW/h6DGG/0he0q8LVqmPSgvSyAt?=
 =?us-ascii?Q?IFDM34sBNf5ayy4gYSmkRGpaZFusIRGizTMmqsPtpQP+tBQNzUIxQAz3h6ty?=
 =?us-ascii?Q?16Pyqo1GRnmmc8jG8ZbVnj/qj/zw1kQQrJ2hijkOhW4xi1E+JLuoG12gLhgE?=
 =?us-ascii?Q?qZAz5/Fd6J9/UFr8WI6fQ8o4qLWBUwDQvCcpXtfb3L0dlXpbvXzDClFOsGzd?=
 =?us-ascii?Q?DMPmaGuzcfih0FxKvvzsqUgITv43tnRSPnNhtSbyBOjv+uwzYiwybtubTZ4n?=
 =?us-ascii?Q?+UToLpXD8P/FKnoUGD6HpnJf6JF06qaUJiwY3aPu40Nc9j9ErV/zSG3YSATA?=
 =?us-ascii?Q?1h+02Dr95vbyD0wCSBICB2GPFdniFST8kDLv7x3f03sKmBlfYQ4YAHH2QznL?=
 =?us-ascii?Q?UI6VqhZboW1gV27LB+8Jlbjh2c1ZnUhPw/GkC0GDrgV2LDNjg0uHQTQXgLWg?=
 =?us-ascii?Q?rvfqhOFCzIR6wqknQ8ljYp1VAwGt2JJZNLQHLpG9SeLB0Jtb0YBhEJsQzHgW?=
 =?us-ascii?Q?H/KY5Zbq/cOqeEMsseAVLMoMnKJgBlt82VWT/xuowLfVPvV2dny6ZILOBfar?=
 =?us-ascii?Q?7izLl/5KooWzdtS8RSmKK0wdDZIL3PnsXIC0650bhyQK37bOG9/vdkA/Qm6D?=
 =?us-ascii?Q?2FfwhtgQG1gGUXSDKm+wHEA9sJ4fsyuEjq7tbeDfEPA9qBjbmrjRxpnN3u0f?=
 =?us-ascii?Q?CXXz2xggvjMqbeG6eqeZ5JGDy84XT2OHaXNWTukmDGxDAzfB4X3Lr7VI2Q1+?=
 =?us-ascii?Q?dfJN+CH+JJalDxHanCAxjSc10az6xI4cL6j3hd4wsFqp55/4GHbn3Y6EIOTW?=
 =?us-ascii?Q?wMwnYaEQiRuO8m1rXEqwiCPHMte/asmEPN9C5Ibw5xy4rf2he1nG9pVUhSzJ?=
 =?us-ascii?Q?Ew4JFuLO0w=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce7e4b6-3c7e-492b-1c0d-08da2ab09aec
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2022 13:52:03.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy6yQLp3Bo4yJ0lX8uAuHMm+YJ6ZyvWLEpEcSeLS9sT7dBZqs3MI2buGGCDbXqFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/riscv/kernel/cpufeature.c | 46 ++++++++++++++++++++++++++--------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index f53c40026c7a..c6a4d8d2a241 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -51,7 +51,9 @@
  * but it's not easy, and we've already done it here.
  */
 #define ELF_HWCAP	(elf_hwcap)
+#define ELF_HWCAP2	(elf_hwcap2)
 extern unsigned long elf_hwcap;
+extern unsigned long elf_hwcap2;
 
 /*
  * This yields a string that ld.so will use to load implementation
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 199eda39e0b8..357b0481f1d0 100644
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
index 10f9daf3734e..f3a033bb51f5 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -17,6 +17,7 @@
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
 unsigned long elf_hwcap __read_mostly;
+unsigned long elf_hwcap2 __read_mostly;
 
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
@@ -68,21 +69,39 @@ void __init riscv_fill_hwcap(void)
 	const char *isa;
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j;
-	static unsigned long isa2hwcap[256] = {0};
+	static unsigned long isa2hwcap[RISCV_ISA_EXT_MAX] = {0};
 
-	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
-	isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
-	isa2hwcap['a'] = isa2hwcap['A'] = COMPAT_HWCAP_ISA_A;
-	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
-	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
-	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
+	/* HWCAP */
+	isa2hwcap[RISCV_ISA_EXT_i] = COMPAT_HWCAP_ISA_I;
+	isa2hwcap[RISCV_ISA_EXT_m] = COMPAT_HWCAP_ISA_M;
+	isa2hwcap[RISCV_ISA_EXT_a] = COMPAT_HWCAP_ISA_A;
+	isa2hwcap[RISCV_ISA_EXT_f] = COMPAT_HWCAP_ISA_F;
+	isa2hwcap[RISCV_ISA_EXT_d] = COMPAT_HWCAP_ISA_D;
+	isa2hwcap[RISCV_ISA_EXT_c] = COMPAT_HWCAP_ISA_C;
+	/* HWCAP2 */
+	isa2hwcap[RISCV_ISA_EXT_ZBA  ] = COMPAT_HWCAP2_ISA_ZBA;
+	isa2hwcap[RISCV_ISA_EXT_ZBB  ] = COMPAT_HWCAP2_ISA_ZBB;
+	isa2hwcap[RISCV_ISA_EXT_ZBC  ] = COMPAT_HWCAP2_ISA_ZBC;
+	isa2hwcap[RISCV_ISA_EXT_ZBS  ] = COMPAT_HWCAP2_ISA_ZBS;
+	isa2hwcap[RISCV_ISA_EXT_ZBKB ] = COMPAT_HWCAP2_ISA_ZBKB;
+	isa2hwcap[RISCV_ISA_EXT_ZBKC ] = COMPAT_HWCAP2_ISA_ZBKC;
+	isa2hwcap[RISCV_ISA_EXT_ZBKX ] = COMPAT_HWCAP2_ISA_ZBKX;
+	isa2hwcap[RISCV_ISA_EXT_ZKNE ] = COMPAT_HWCAP2_ISA_ZKND;
+	isa2hwcap[RISCV_ISA_EXT_ZKND ] = COMPAT_HWCAP2_ISA_ZKNE;
+	isa2hwcap[RISCV_ISA_EXT_ZKNH ] = COMPAT_HWCAP2_ISA_ZKNH;
+	isa2hwcap[RISCV_ISA_EXT_ZKSED] = COMPAT_HWCAP2_ISA_ZKSED;
+	isa2hwcap[RISCV_ISA_EXT_ZKSH ] = COMPAT_HWCAP2_ISA_ZKSH;
+	isa2hwcap[RISCV_ISA_EXT_ZKR  ] = COMPAT_HWCAP2_ISA_ZKR;
+	isa2hwcap[RISCV_ISA_EXT_ZKT  ] = COMPAT_HWCAP2_ISA_ZKT;
 
 	elf_hwcap = 0;
+	elf_hwcap2 = 0;
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
+		unsigned long this_hwcap2 = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
@@ -181,15 +200,17 @@ void __init riscv_fill_hwcap(void)
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
 				SET_ISA_EXT_MAP("zba"     , RISCV_ISA_EXT_ZBA     );
@@ -239,6 +260,11 @@ void __init riscv_fill_hwcap(void)
 		else
 			elf_hwcap = this_hwcap;
 
+		if (elf_hwcap2)
+			elf_hwcap2 &= this_hwcap2;
+		else
+			elf_hwcap2 = this_hwcap2;
+
 		if (bitmap_weight(riscv_isa, RISCV_ISA_EXT_MAX))
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 		else
-- 
2.35.1

