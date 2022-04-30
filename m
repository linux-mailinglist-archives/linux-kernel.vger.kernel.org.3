Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC4515DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382822AbiD3NyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381686AbiD3Nxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:53:54 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F49FDB;
        Sat, 30 Apr 2022 06:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACqt7cNqGiwvcVCX81aMt+Q7EXAV25y9Y6XMWRNfgNw62cMNjy7AoNLV0d1stAL3i2PEXWwzzzdFc0QSeOyo/he/d1lbpFKY05LmDeDz3/KCTAUYvRBk3+QY1W98hCXRYpulSZ6kOagDIEcm9ghmhV1BuZzXEPPom7ToZCwM1a6sfNO/1xgGzovD9i1e+rkeIoidlDFdY0Bgooz81/3T6DjzXYKzkrrSYm54W2d17EDh7auGFPHiZJHQngmtrnat8OWpkEJdC0uqVVtHPmBaEYwfBNIWSqf6qNGDiJoRZgbrYuu7Um9PLuUw9runzedEHbb/rwY5xJmbN2I9Gj7JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV7LJ5grIlE3aOHlv60sVa47Qy4odXuKHBATm9XJom8=;
 b=cnmywO0oipw/qQQWUmfFIOygQxuEC65iC1qZyQ+GKnPMjpmazI0GDePJcJAHLZeFc6yrqmgwRjbyegYzwGjt6ujA9WFEKOp+daohYYwAd4No8Yg4vRXCDOvvEzGYLJkeh5QQ8Hf8U0/wrXo/QRRLgc+c4lwrWOQJsxDGfOwrixsWQ83lTWDt+PjSQZnJHWiJD2zOfNaiAycjcXBo6vfzsV8wXtmGhgh96lA7pefb3IXz4CRtV27jJx7uocdqvAfBMXuIwOraJYKnpc28SAQkZBJ3vZJgP2B+Q2LblY2wXtFP1ydHnHTCoQq5QBLWW8PhuouzpYIPttd5qCdIrW2+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV7LJ5grIlE3aOHlv60sVa47Qy4odXuKHBATm9XJom8=;
 b=YyVmvvuBm/CsoD/oNC3zI1AiRGklWHiwvIKB8sbgOyYikN9teGromgW2dwhWb1PLPfAf+2tf7RDi7VCfL/7gADOW8Pr7qasm+8W0QmR7gRN86r1pPZ5ySQ+OWtncapKutHon2lh/NV0Enrxgo9qH0E2fcxlYKN6gR8ElTLhr128=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYCP286MB1706.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:187::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Sat, 30 Apr 2022 13:50:30 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%6]) with mapi id 15.20.5206.012; Sat, 30 Apr 2022
 13:50:30 +0000
Date:   Sat, 30 Apr 2022 21:50:22 +0800
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
Subject: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <Ym0+nr9KZBO118Dx@Sun>
References: <Ym0+Erz5DEnB78vu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym0+Erz5DEnB78vu@Sun>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b238793-026a-4525-b3e8-08da2ab0636a
X-MS-TrafficTypeDiagnostic: TYCP286MB1706:EE_
X-Microsoft-Antispam-PRVS: <TYCP286MB1706E7E52B2429995D387CC5BCFF9@TYCP286MB1706.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iifNFFkGZbDWnoJGS0XR4/a0Z3E0NNQJp3LlVqrSg6njYB/ZiDXF8PmsAmp0Fm+ULm7mQxAOAmcs/oPysKpM5psiZvrKyW80PtYkIuOZCzaO/Wk1vWgW7leg2uhKZLOPqhQVb1Z/k0K9wJxq8eDACryhHrh7hUdDyfis+mqYnJ7eKsX7tAUXbRkisVJmxvJlTZSpW3wm7mV6yQiZr/xDbQc6u2ikmHR58bZkDCTv0pz2LNB0kLrxHfSXqWiW3KJF6EEkhR9Gs50Q5fTZ7ejrB/DYY/fyv2hTIqz32OBYVcGQwG6uByz4sBK6FxMG0EMBuwSjv7kbsCCt5t+eoT0X4EUbXS29gXWLfsrq7eKzF3CG5jlgtQs2qUR2dKDlAlaI8wk1raMWFTpXfKw+edZbUZzeuZ16TilZ5JlmadkHQNrJ3fnzigZoWB8zv7OIjlBDVADdJozC3+b5dKgEjDDpgEkr/4c03uACbZaiAyQH3Qf53qGkLRyyIVhJT/zpOqqZsS6Wk+S7MbZSmXZKcY1BOqiwBrhXhUqCEHtyYAU2OPRPVKhaYEE3YeQKwQaJYeCqsUgSckWKXZR5T3K1HBwBz+BXmsD2lRPOZrylk9dpidbRoSdhHSNXEuUrSJGxhMMgMgTJtkK16AFZYKWVF8/zhKdgbO1t48e/XP4fkPrXO4is1WAVI3z+gSpOK0KMZbtkFY908vbsULNhtEouyZVb7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(376002)(346002)(396003)(136003)(39830400003)(6506007)(86362001)(6666004)(52116002)(6486002)(38100700002)(508600001)(6512007)(9686003)(186003)(8936002)(2906002)(316002)(786003)(33716001)(7416002)(66946007)(54906003)(66476007)(66556008)(110136005)(5660300002)(8676002)(4326008)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpaIyHZUxQM8EwYT2S93ZUHjzMjQXZ19P6L8di5Ses1bdkAZ9olGzllYtc9Y?=
 =?us-ascii?Q?3BwgHSEc4aWuijGIr1MAlTAxMpl8vf/jCYCdtY1/eSuLPJE0nkCA2zlwvT75?=
 =?us-ascii?Q?akU7/vlCiAHVzu24zF+cv7oqxeWLNEyTiRp6kmfWI/H49CD3FF0IKTpdEXY9?=
 =?us-ascii?Q?1Zd784F/ybpETSXqhMZy2ci9qpbnb7tbWs1xh2S1sNLM4LPC0zIdagxdQVVc?=
 =?us-ascii?Q?WxLyfFLAhHAUxppl211mFMu7wcOYw+yarvUnLTkbdbjRENzJGedXVPq/BXUG?=
 =?us-ascii?Q?a4MWCEU8CbtebeI1dH6EXX4V1xgwSgfUH+JZMcUjK4vmhqXLKNnq1NS9DmUk?=
 =?us-ascii?Q?Xw/88Ll5X2FaLRes0W8B8dFzq8vLZs9B2P9YKn0jCrmI/mJdI4B+0mD47iT+?=
 =?us-ascii?Q?2VwCbcWMcZR3ZTfxqx08GOVGhcR11HOG+c3DkbvXERQRWa9yqWqZ8rVi6wWO?=
 =?us-ascii?Q?GYO9A38oju5zKYdrzWR61zYYBgKLoRHouW2TcPZNOCi4GlNu3TR9xe/F78Fp?=
 =?us-ascii?Q?rCAo1SDtqVdaq/ulsTdsQ+nHipsYRp3PsK3GznIl8Z39uVB5F4kjCz6+gj4M?=
 =?us-ascii?Q?j7iBTfgT5W4KDJqw4ZYEX5jzV83dJNY6o3Pem/FRBS7DdIYmU5fOLFEGInWV?=
 =?us-ascii?Q?KfQAYoB2gz+bCO1TB1CgUsD9W0FYedWhsKyGtuiBnyI0pg4Q8MxUkg5unLQU?=
 =?us-ascii?Q?e7GePlnrcuV9FPNXmDl0ftWIyrwOsdpRQQm+BsjN3zoac2t7Pnw3ZHUdQ294?=
 =?us-ascii?Q?RA6bvtcf3bU11YtgVS+0Xodoir0PqesU4dUbpmtO/a6/HicHO55g1IMXCtFY?=
 =?us-ascii?Q?XeyqBxrSugiBhTBzzadvkVrY2GBZqlwDrkkYk8PvHpO09cJMpYbh10qfb9Tl?=
 =?us-ascii?Q?+2ElpiPN8z7schdS2vKzLqo+R5k/Hgm+QQNewRO9h5J1K2xF8dCbNIgIL7Pi?=
 =?us-ascii?Q?1B2glfDbFrpiuCt9eUdBa/cWk7KzrgOCzXGbAwvVt6vECFvN36pi1wub+Oul?=
 =?us-ascii?Q?QxNnX2yARbwx9V7FDMhUsrY9SbB+UKKPjlvvzhUAo1+hDE0zBepmCnY2Bof7?=
 =?us-ascii?Q?8lrsA7vHD3KE42ZoBtzTFDP549jhmVLF95rVht/ifr7M3jaqrMtaPrOgX0VB?=
 =?us-ascii?Q?luRaYIiFtESraOBaqog+Gr+YsrrnzCvQrlKtsV/O5Buys7s32vLdFNNPa0ZU?=
 =?us-ascii?Q?gaYhUxmf9xjHcU2O+RJyTAZSHMV1l1I47MEVKOQHzYwhMJQsBAsEiNDbcN6+?=
 =?us-ascii?Q?2Zv6AJGNEPUJyk1AHBaGsxpQjFxbUl7b5bjvK35naOFivrv2F1qBKzLlgAs+?=
 =?us-ascii?Q?ZYpxoEJso1d+xwuwx1ghKiBhrr4/VAQ77qgj6SFr4/7HZucTvsuqA0jCQ+9T?=
 =?us-ascii?Q?Ra+TbhMCcgKFFYfIia69zH08VIkpqHbB465mStucRi1+a+hCB2Vrb1kIsKzD?=
 =?us-ascii?Q?+/E5nsa7/5QTtoCH/cgqZCFpGA31EPU/bE4LIqifPfp5yoCNdlWMv2PVpqLm?=
 =?us-ascii?Q?He3v5ioDqqhxTAFuHmKIw2UgZpbu4qMRbOyNcQ5bOYUjvIeJydUWRaLHEsqB?=
 =?us-ascii?Q?GmmC8V7q0cAQmxVaQySnffYI7C0mtOuC3o/7HlnNe+CUQAyeqN3UDT+7M7tg?=
 =?us-ascii?Q?dJUNTuL3QX+BJPVYuGpC5QBnn3i6WBh4yMFbmTpGOSsr4ktrlhaHYcqNgyd0?=
 =?us-ascii?Q?bzGosGijQbvxsls18e7Lzx57UiL0RRVKl8a2VDy4EIziOp1+IRA28/mKFABh?=
 =?us-ascii?Q?cq5kaljW1g=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b238793-026a-4525-b3e8-08da2ab0636a
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2022 13:50:30.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTpi7Q+Cjk5EF9TdqbZqutIxORbGYyh2UDfHKzq/WBx7kcTdwhQzILQVlwKPoA0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit parses Zb/Zk related string from DT and
output them in cpuinfo

One thing worth noting is that if DT provides zk,
all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.

Note that zk is a valid extension name and the current
DT binding spec allows this.

There currently lacks a mechanism to merge them when
producing cpuinfo. Namely if you provide a riscv,isa
"rv64imafdc_zk_zks", the cpuinfo output would be
"rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
_zksh_zkt"

Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 arch/riscv/include/asm/hwcap.h | 14 ++++++++++++++
 arch/riscv/kernel/cpu.c        | 14 ++++++++++++++
 arch/riscv/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 0734e42f74f2..199eda39e0b8 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -52,6 +52,20 @@ extern unsigned long elf_hwcap;
  */
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_ZBA,
+	RISCV_ISA_EXT_ZBB,
+	RISCV_ISA_EXT_ZBC,
+	RISCV_ISA_EXT_ZBS,
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNH,
+	RISCV_ISA_EXT_ZKSED,
+	RISCV_ISA_EXT_ZKSH,
+	RISCV_ISA_EXT_ZKR,
+	RISCV_ISA_EXT_ZKT,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ccb617791e56..7251336969c1 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -87,6 +87,20 @@ int riscv_of_parent_hartid(struct device_node *node)
  *    extensions by an underscore.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
+	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
+	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
+	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
+	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
+	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
+	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
+	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
+	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
+	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..10f9daf3734e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -192,6 +192,39 @@ void __init riscv_fill_hwcap(void)
 				set_bit(*ext - 'a', this_isa);
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("zba"     , RISCV_ISA_EXT_ZBA     );
+				SET_ISA_EXT_MAP("zbb"     , RISCV_ISA_EXT_ZBB     );
+				SET_ISA_EXT_MAP("zbc"     , RISCV_ISA_EXT_ZBC     );
+				SET_ISA_EXT_MAP("zbs"     , RISCV_ISA_EXT_ZBS     );
+				SET_ISA_EXT_MAP("zbkb"    , RISCV_ISA_EXT_ZBKB    );
+				SET_ISA_EXT_MAP("zbkc"    , RISCV_ISA_EXT_ZBKC    );
+				SET_ISA_EXT_MAP("zbks"    , RISCV_ISA_EXT_ZBKX    );
+				SET_ISA_EXT_MAP("zknd"    , RISCV_ISA_EXT_ZKND    );
+				SET_ISA_EXT_MAP("zkne"    , RISCV_ISA_EXT_ZKNE    );
+				SET_ISA_EXT_MAP("zknh"    , RISCV_ISA_EXT_ZKNH    );
+				SET_ISA_EXT_MAP("zksed"   , RISCV_ISA_EXT_ZKSED   );
+				SET_ISA_EXT_MAP("zksh"    , RISCV_ISA_EXT_ZKSH    );
+				SET_ISA_EXT_MAP("zkr"     , RISCV_ISA_EXT_ZKR     );
+				SET_ISA_EXT_MAP("zkt"     , RISCV_ISA_EXT_ZKT     );
+				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKB    );
+				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKC    );
+				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKX    );
+				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKND    );
+				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKNE    );
+				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKNH    );
+				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKB    );
+				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKC    );
+				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKX    );
+				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZKSED   );
+				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZKSH    );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKB    );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKC    );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKX    );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKND    );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKNE    );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKNH    );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKR     );
+				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKT     );
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.35.1

