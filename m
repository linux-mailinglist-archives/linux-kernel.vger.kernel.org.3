Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3952B62D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiERJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiERJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:26:49 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C486D4EB;
        Wed, 18 May 2022 02:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfGRLgvBp9AYOMkkRwXu4SdjbAeLKMePOfAWcSjcVtCeQMDIZ8HHkkIZUZvs5RRK5vRihxLTzf0IAsBsO+vtq+ExfI0+s0jz++kOpkj1w3qnvTRI8NQe2bMYjDCWkuF/5uHOptoBufADVHAEAwSEPQaaWUc+Cskq+iVscSIUZ/T2tsH8uaLpW5L+Wc+oq/8Wi+e50RLXIsXRYPD73TwtZN9pbyxeUGZbgE1laLjb5oaUwN2nY8Ig+elgzMEYdfw510FOlLpMdXL+/3FCEpPvGcKYieri4UlVuTyLAmAY/5CkdYr28yiqRsgLQFOAQ7802KJzGgCkDT683LuOPuP2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb9uXup1SNxpWP2+fr3T4QxkLHnxcu9yVSz47ObqrQo=;
 b=PI1EgD1r/9/c7MAaDx5FuaLfmPVM8c1CD95iwGOh7Q5JMZK7SSsHd4uNSVNZf8I4dnuWp11RYOAXZ9jjysuXVuA7kBqeHmy+ke/AsKH/GTK60KuVdDyVeqXqJKigzHfMH6eLfvDBrEr9n4TZMAq2Dzvcl7IR3aiSPHgwDLAfauoIAyHzelXJ+o9gBSty4ZLetlYeKQbgerjoP4A76aoJDuSLIUrKisxsbMb3AvbiYys2LeGxgMVxwM2U2hK4UEY9sg69RHbfft5GXMtUbSGgm3eRk+YMBHx+CgF7SIe8rMzspHrNPgeOqPQqu/k97TjBcAVacfUIW0RhgOzHiVt1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb9uXup1SNxpWP2+fr3T4QxkLHnxcu9yVSz47ObqrQo=;
 b=YUwoFpSx7U+cALpoUBO+DAQAatyl2nFym89A1TffXLkOy6XeYNgV1Hd7lFha42KMNGTKxZkjxo0Clj1yqgOostjTiDxxuH9CaQGSLZM50ur13GKLA8gu1W045Y6rNqx3eaJRLH/aYAUwBTSGbjz2450I2hcKhNOuYcpaoyuspH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSYP286MB0024.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:86::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Wed, 18 May 2022 09:26:41 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 09:26:41 +0000
Date:   Wed, 18 May 2022 17:26:34 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH -next v2 3/3] RISC-V: HWCAP: parse Bitmanip/Scalar Crypto
 HWCAP from DT
Message-ID: <YoS7yhANyM6/Dlts@Sun>
References: <YoS6qRhxGuwHmK7q@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoS6qRhxGuwHmK7q@Sun>
X-Operating-System: Linux Sun 5.15.26 
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1ca3e96-2e7a-4ef3-2bcb-08da38b08435
X-MS-TrafficTypeDiagnostic: OSYP286MB0024:EE_
X-Microsoft-Antispam-PRVS: <OSYP286MB0024828DED3C4E05BE707E6BBCD19@OSYP286MB0024.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: judtiGB22SzoTePbYOD68JudlrbKqUkyUQtZxGhXRDFZHNsJLcGlwUFft900YCs4Mn3fG+zToXAyHgzy5RLgAXLGMHGMvl4FnOyiYX4YR8u6YeFie8koRsbo/ZY172bkWGn69vtneINyJwGyvOpLfv7wmowfSzlllTPq8hGgg0X5PfxN/uPsBTMwzZZweZqK7BfUnu+zWustUzSNyS2zk3COW4nsMA23nN2aLQEjcxbp9Y44Gks1Je3LKQUng6TeSqeAka43ZzjP5sKWkDifIFbnnVseZ/xpJrchB/mR3AGbEdLeDIc0Qmxc4m+JOixtg3dviH7Vsme1Z4KLVPcww0gSKrF1vjiTSkmlNHiERyPWTcw5JbOzIf33xHTiQ89mAPlB5Aehlbe/dHpmrA0vbxCdYCN0mVdKqhBZv0Qlx1rK+qhL2gXhLzm/xXx03vSYoZgFuzfrIjVJTwKwMIwEnrdIraC2Wpk/Q4m6ztcuq2Hasi1mfBfGKFRBMZbIcve+CKqAfUdPYUGBXWDDrw/F+VOY9z3FrzUGG3q9pJwAYKjeMKXx56Q6iHnu8datGVfAIvVC7/0ZdBZkgn6oSU4FzDEtsuKyhAn7Iisi1OR7Iz8LeqC+zGyCIhEnOQNibiQzRhO5I73T4q/WyXca1ALVCQq1QjnCdtlWTgsD1udwLC0BIapoonxLLQD0rtZPoDJi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(136003)(346002)(39830400003)(396003)(376002)(83380400001)(786003)(6512007)(6666004)(316002)(6486002)(9686003)(41300700001)(41320700001)(6506007)(2906002)(52116002)(86362001)(8676002)(8936002)(508600001)(33716001)(66946007)(66476007)(4326008)(38100700002)(186003)(7416002)(54906003)(5660300002)(110136005)(66556008)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmGRnlImVaedpAuD2lLukeMkw+wKsTs2x07Ax/CakYt4fKIkDPQ+W31ZS06x?=
 =?us-ascii?Q?XgbCf8oXt28FRwUGqgbb2jNNEyk71sFmW5G6fEtSZ6aO7Q2FGR80mFr/3g+o?=
 =?us-ascii?Q?IwOZ/pKQZexdqhVN9UahISCW/i9b+qXyUov4OPuGoplUz+FpJT10wOC6Dkud?=
 =?us-ascii?Q?VH32cQFqtyoQ0LJNayMxQS0ZkiZVX0pZjtJo8IgheaM7s8q0utkRPXmrCl5V?=
 =?us-ascii?Q?jP3nJCKOM/A+1IFbFPntQ6QERxhi2eKdLiX+qNvhdDtQBawufHpNCkICTOXm?=
 =?us-ascii?Q?AL5JzueHJG7wsf7jscq4Ns1DH7+Y+oGo9+xb3O6EZfgeUvgiG6nWUyVsnQIa?=
 =?us-ascii?Q?Slg9O6/E1rLnfgWMvD0Kp9CVaMHdPmkfvXr8uERJ7Mqtew28UYjlSfTTYAoc?=
 =?us-ascii?Q?4/xGqrvjGpliiOv/b2cbz/KOTcDxwhhT46FxwbC3VlOS5OMcAK6tVtpCYbwP?=
 =?us-ascii?Q?rdJ6pwVJCMIrPdlcLRuOdzznz/933jUCTKW29bW9zJcPA5sUW59ITv0pkQml?=
 =?us-ascii?Q?q5ldlki3Z+3fin+smbM9QTIaU0hU5sZGoBwoweNLey6SPkTMqtUdzf2fH/51?=
 =?us-ascii?Q?gMvw01VMPUuJi1iCJyfdGQDahmPkwfdFFnYP0ktUXKyg/8iYKbCy4g8pXjev?=
 =?us-ascii?Q?3wiEKMv6uDo6ja0vjYB2AIgU4vgomfIf4xJ8d8HIxsNiSwKNVJFyIk5UJ5Rf?=
 =?us-ascii?Q?JAuEyaJgWQg0nzqDpq33kUw60RDRH7uiWUvZKdtKtJB2gQHSi17rpTH3m3we?=
 =?us-ascii?Q?8wKTfF9r5z4AtQq5Q40ZT/Yb68zTt7+TWrzVTPyRrEPTrE7l7I8W7nUDtLOz?=
 =?us-ascii?Q?72NOs8pEtDDbVHIGXRF5LuyvF1jyYX887pVDwMy41ldQcmVqBOrMUqwdfFLq?=
 =?us-ascii?Q?2rXs5w1bmKe7H7O1Mz1+crcnjiD91dHKQkX34iX0LQ8lDfiG7dIK+NIP486P?=
 =?us-ascii?Q?ZxGuIu/WzvaEe+TZpO5OCysHWd3KrbV2tVoDpXUzvqs58CZNN5ZhmOQl+8qV?=
 =?us-ascii?Q?8qX1ZbPnOfIw7Of9o9BMDOqn/tKp8bUqYdvW2IMFjZ8UKsejnL+iIABJ4OxM?=
 =?us-ascii?Q?rPr5kzNeReVTepUJ3IFtk+U0+9MZKjt8R1zNiTF/LUdudxF3ugEOs20iKtQy?=
 =?us-ascii?Q?eEV0KWdCBAnRR+968P6DOx3XnF/v8OhnE9eg48MAcxf48xrE2aqXDwi9gjON?=
 =?us-ascii?Q?Y0HPQVVybXCJehZlLhAGha6nxlZXm4lVUUVKPJrhyoHRNNtyQ7hXBG8kwi4J?=
 =?us-ascii?Q?hM7e3m7qyTbaQWg5zdsu2Adon+sV+5c79ohMOwB3NYgHPhV2FHgPzAuJJf25?=
 =?us-ascii?Q?Yu5gpq4lilxeAXgunuZKTqG/KyOSz+U2TjdeB20SKvXCK88Ha7D+y6nv1ym2?=
 =?us-ascii?Q?LRxLA0npWaPoxGw20f8MKg4ZqJwYUoVZ4X5pQZt++SReu/B4lt9dzCFw10oH?=
 =?us-ascii?Q?yQG8t1/CO2X6Nt52DitC1i6vXWva1QCyuohZj/nXcObJBwxoVCRCzLu7hBjP?=
 =?us-ascii?Q?Q/pi17mX+R41Yd8r28m1PJ34ROPM3svWhDVrohJy3L5VhltSWdPWS34zYddr?=
 =?us-ascii?Q?360fqakCOMUZo/dEJjwOntm1+9VZ7G/H8GLc/8MJA8ue0fWPSMRUf59l31u1?=
 =?us-ascii?Q?l1BTD9Iy6AAu859LjJ/7a2qi35YTVs3BMdw6uYZDXs6MF+Y2t71LDwX9mXff?=
 =?us-ascii?Q?OTOpDfoomYvo8VyhQUI6WzYbleUoICuD1LtAXDDpj6Lpq/+YdETqMV7dmYzs?=
 =?us-ascii?Q?Oaqc876FxA=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca3e96-2e7a-4ef3-2bcb-08da38b08435
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 09:26:41.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g59vRL6FS3v6kamzG/mvZ5wGL6t/4RdBE2u7r1o8IRk5QOjzWhZz2EAdRFr3X7xp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYP286MB0024
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
index 800a7aebced3..03ea199edffc 100644
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
 		if (bitmap_weight(riscv_isa, RISCV_ISA_EXT_MAX))
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 		else
-- 
2.35.1

