Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49349533C58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiEYML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbiEYMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2131.outbound.protection.outlook.com [40.107.104.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065F54AE19;
        Wed, 25 May 2022 05:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwrMO6gBzD4IssWm6GsA9xI8LK9W5fqk0vmncQuDsi33Cg7pIjEXktlnOJLK9LhrCuMb6PfgP6oeMTP2CpIbhI9nNJsUN8FBdVgAhpyIek7Y5/AJ45anG/anWkiHkc+7ynPMGtvJXF80Rx6ni7e9lT+o2Pc2+VVsA4Yie4EmRuCK+3qiP4u64rv6W0JiaFI9sLDWBXeEPi4Q6DsJVnPkIOgKYziSFW6zL+d5Ymlvm6Ui1R7zuRYfiL6ZEZhkOHIB6bk2xOR6r2fYEYT5Z0fhOf4asxWw3VXM0lb85y9ptVnuJLpIXmCHZCd4q0dwYlX+izzJT4LY4qFp4v1f+8lJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYCER7lHlJ0vBTZV4EChtVaSiBwsly/gzHNlQ18pgig=;
 b=SUJFaCkdLqpi7IuktiOx1+f6RsBpGMEQOm66HKEoZk1U6sqwrW+VFyhN044LRMg0bxETlWO4X0XUTI+F5p1ruuShfxM4Eo9GcEyESX/JBmeBVzViDpn5sGPhFXUBdAH9WPXa9ou7i+2u0XUA61LVsLHKIOFcvTrVcQM1os+txoVlNLGlpke7mo2gQW5uYAAqIBY6R1yUS9tkffp1kBpxZvimGLC6Y6qQCeYZ2Nqfk8+Ya9V5YpJaxAMKvWwNfghDYHfr9sm2RiUOQX2cN+q2bg5s1YumXrzAPLhpTvFZp+rfXdN0di/rh+udqvhhDP4SfLmnpmkQj6E5Tnz7pmk4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYCER7lHlJ0vBTZV4EChtVaSiBwsly/gzHNlQ18pgig=;
 b=U/isu2u0rmbUsNwKkwUmWG4HYqTCB1zBWrbG/g5pjr+mbJpUP8VYy/89+2512L9PzRH5fOi/Fn8KE8kZWSZYTraW+LTYmO37YdXGT910ZwiI69RIUJLNPWm8UlmYIoksG22FMAZHTlICHuP4ojRWF6vJtE9s2+haL/wh+xKArNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by VE1PR03MB5439.eurprd03.prod.outlook.com (2603:10a6:802:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:11:00 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:11:00 +0000
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
Subject: [PATCH v2 10/12] MIPS: CPS: Introduce struct cluster_boot_config
Date:   Wed, 25 May 2022 14:10:28 +0200
Message-Id: <20220525121030.16054-11-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af8a00d3-939f-45cc-dbde-08da3e479f7e
X-MS-TrafficTypeDiagnostic: VE1PR03MB5439:EE_
X-Microsoft-Antispam-PRVS: <VE1PR03MB54391D34FE40584B65D7BAD5EFD69@VE1PR03MB5439.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVQ+2d+cFeVQ2SnLNp3Yk/oe6gC1fsq2yAX/ovtTN9FfRUgNs252R+2j9LX6M3ShORR15PBwstQuyKAxXd/+le1Wo1hf+58lMavstyVVPoup7uirGhXcdy9GqKzdUygamWV0nPOj5/dPnImm5thcVo0gAqOZk99tCm4DEm6SdJxckChOfGd0/oWaod0YA3YnLU5DGpij8mRZdzNp1/ebsC5oE+sniD2XOa4XpcPpIZCXti35B9ULRYqUrewO7J4Aypp33bCz65uhkjkNlLnvlA1Hr69yzp3GeMj49JbRoG8WxKqm3TQ2KdiAKluk0thNsLHze9eo4389V94ibePUZ6vt7iUd5FHOSY0vd7tri+rjEIDQPtiEaNzlDgGBmv7fSATk6hA93EZ4apFU4Oy+w5ZZUJ0Sh42e/DYrdEWlDxeS3jiCVbID91soSAopxLZuJXgvQGnwJiLR34eosNPygYdd4rQ+MfZMIT+O6vSzJ3mrT0mMlwIwRE3XbbbYVcd1wPQ0inBTM0Ik2k8nuyfKcUpc9+Wf4fR3HCtDqlm//ypUc5LZgCgprLuM78xiMToDCE5qEOlq4oWjc6RCslhUnC7jIlD9hxM+dSL0uDi4eJJEX2EbTC1X7DDAKtr0Rcwgzm0SkBCjrv42SbXbKtDmcRthPXbkGY5hVBXULt29ShWh0o0npZAUK5SfyEpK7wYAuTnsVN8pkMLBVw3C9Q4tdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(396003)(39840400004)(376002)(366004)(346002)(36756003)(6486002)(7416002)(2906002)(6506007)(316002)(8936002)(86362001)(4326008)(66556008)(66946007)(52116002)(8676002)(6512007)(26005)(508600001)(5660300002)(6666004)(107886003)(54906003)(41300700001)(2616005)(66476007)(6916009)(1076003)(38100700002)(38350700002)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pFhrJ5SS49E88VFKNPM8y3dRvx3P26cOlGQz/vyuVpSJHuEyk+4U+7YL+jMW?=
 =?us-ascii?Q?rK2Y77KNVw5gUIKPTrKjr1aSy3mUTIaHZ2tK+C5Vm+SELXCJZGJG0kzDdvvW?=
 =?us-ascii?Q?VuyNTSsIPcMZoVeA02KQACT8IsVBaTeEcngQL4KP9XIVOY84EeHKEQH3LHC8?=
 =?us-ascii?Q?0fKuuX8EDnu+C+ZdlXWyi7MlH4+qmcmHzXOoxmj11H/Tk2959mC0aa6DfT7T?=
 =?us-ascii?Q?Mls1SSmKt8+oRcZ7Er5C9dCeNroT6Kd7iZqOV0r5Jh9rcyaztHFFDtkRxyTG?=
 =?us-ascii?Q?1AfALoympT5B3jVsckvrfbcQkEEVXzYeBbbGWspq/z8NWAdpSxKy4tJkXHD/?=
 =?us-ascii?Q?NjmXg/zSdhOtdWRe5/EE4sJjsf6pMVIb84Vr/Ft9iB7AY4MdW9cySgw4KnA7?=
 =?us-ascii?Q?woTl3KbPSwkUqoG8xAPFwfffKXl575t/MFMZk91zn2CdvHnnrIwrkKrInP2T?=
 =?us-ascii?Q?CQbEgxvbM16TdcIswXgsNsgS4UN3KgRMLEtllQ8KrW4ZGxLgO4kod45KOgiU?=
 =?us-ascii?Q?Q2EIQCSQl1dOrzu77R40XJgwi1Lj2RPrx+Ku7fPJ1faI6o8eegw9w9zhQ5zn?=
 =?us-ascii?Q?dX0BDjbUyGBk60/IpLjMUnk4ZYK5j+bMB/g+bZeKo6Y6XvLStme2yr6oR7AR?=
 =?us-ascii?Q?JtgkIohzIRZoUt2mUz7E2t8ZlifyPnhOvKShwFjrSn5X6blFO4UOjT0SGk/F?=
 =?us-ascii?Q?EA54Q2bm0Q5x6pPQ+J2Ygyz5ubjQxYbUH8J4o8FA+0p0td08QqPClkPqdErY?=
 =?us-ascii?Q?z7KspOBH6g5xkwMBoHdSLMeqm8a3ouyabHyyziVAlHCGZap1//LERu1LGPGF?=
 =?us-ascii?Q?pYIgt9HNjjT5gg1RZrKAj8Ton9qEz1FUGxrhqrfUIw1HV9Tluo/zP6ualuUW?=
 =?us-ascii?Q?jqbN+BPHfZCJBSK55ePFhTiLhZRa9qHAdj+meLG977G7px08lJO+l6gb7GvK?=
 =?us-ascii?Q?9FPFAvDoNIRZnbqS41qdScqO3qjJ5fXWdirIbvyROdLod0sIfS9CFLOax833?=
 =?us-ascii?Q?LDATMPoVtL+wIKuYQLgWquNVSuxWt7FMwyJr/Et4H9gAK8YY/a9FvjZkYEZ5?=
 =?us-ascii?Q?yAFgBtNW2nCOf1zW7dxbGsA4HJh6Dy3+Ny1bHrqjsAiJMEFkjzXfTpgOHJMl?=
 =?us-ascii?Q?6KRWUftqicRh0xgQQMa42/4PP5/vgFcNRc6oQKTeWXJEQpJHPhXoWd4+oR9g?=
 =?us-ascii?Q?RkdVFrmIjtlpT9VvBr55FS75NqOIi903o4CdL3wE3kBr6nPmY4rOfNDSihk9?=
 =?us-ascii?Q?dfVef9Hlkkgdri+HRfXAYjWXKM2u38oEpPiRC/DSNh1eGAMGVa1aON/Yjdxn?=
 =?us-ascii?Q?J7xgE/3/ocab1XB26gNT5wBN0nzrXXytDU7F/CsX28k8wt2bB97n4dxhBHdD?=
 =?us-ascii?Q?ZZ8dsSgslu5te1AvbPUHjUGeI0O5WPyeUDlH1zLgsL795+nJsWPgGo1kufa8?=
 =?us-ascii?Q?KRBCoob+w/pG4yLJDhhd/p8+vO35+TfDkVHBAQDt9oRVE5TukYazLsyA+1AF?=
 =?us-ascii?Q?8r7yX6pzoxksnO6mhrpTs0FFdmalNUO3Inkim7tXL2yP3bA6akBjXDt46vz/?=
 =?us-ascii?Q?6jOgldG30MyfPrgS9s2T9DugdL7XGiDc4EceB2YxdntuHfJwMtLbtrSCo43Y?=
 =?us-ascii?Q?ZeTkQwXm6BFmTlYlesajlliEm236JtNJtYJ6z8lCWQ7vVe2O0qj9lsmX5Vrg?=
 =?us-ascii?Q?ER7TXK0tCIDwZxVvvhrcBoUNtLjUf8MZW7sBJhIQn0ppeAAGxw0arISXblXJ?=
 =?us-ascii?Q?lKXqcVlCmTK8pNPHLv5OIo5pB+95nvBfe5KRhC2ZwzL7ubsg89GM?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8a00d3-939f-45cc-dbde-08da3e479f7e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:56.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vWhPObd5LrI/fHMzcKUa+ZZrI5Bkv/N2DJKhwKvDo43FTt0M8BdNK5weJN/+cBMZuqHZrM6VTQjIQm7iEopF/Ys0Q5U8bFfA4+IFN0V2dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

In preparation for supporting multi-cluster systems, introduce a struct
cluster_boot_config as an extra layer in the boot configuration
maintained by the MIPS Coherent Processing System (CPS) SMP
implementation. For now only one struct cluster_boot_config will be
allocated & we'll simply defererence its core_config field to find the
struct core_boot_config array which we use to boot as usual.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index 7e5b9411faee..84a713667be2 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -20,7 +20,11 @@ struct core_boot_config {
 	struct vpe_boot_config *vpe_config;
 };
 
-extern struct core_boot_config *mips_cps_core_bootcfg;
+struct cluster_boot_config {
+	struct core_boot_config *core_config;
+};
+
+extern struct cluster_boot_config *mips_cps_cluster_bootcfg;
 
 extern void mips_cps_core_entry(void);
 extern void mips_cps_core_init(void);
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 04ca75278f02..7d1f032e8275 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -391,6 +391,9 @@ void output_cps_defines(void)
 {
 	COMMENT(" MIPS CPS offsets. ");
 
+	OFFSET(CLUSTERBOOTCFG_CORECONFIG, cluster_boot_config, core_config);
+	DEFINE(CLUSTERBOOTCFG_SIZE, sizeof(struct cluster_boot_config));
+
 	OFFSET(COREBOOTCFG_VPEMASK, core_boot_config, vpe_mask);
 	OFFSET(COREBOOTCFG_VPECONFIG, core_boot_config, vpe_config);
 	DEFINE(COREBOOTCFG_SIZE, sizeof(struct core_boot_config));
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 975343240148..f80466f810d4 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -17,6 +17,10 @@
 #define GCR_CPC_BASE_OFS	0x0088
 #define GCR_CL_COHERENCE_OFS	0x2008
 #define GCR_CL_ID_OFS		0x2028
+#define  CM3_GCR_Cx_ID_CLUSTER_SHF	8
+#define  CM3_GCR_Cx_ID_CLUSTER_MSK	(0xff << 8)
+#define  CM3_GCR_Cx_ID_CORENUM_SHF	0
+#define  CM3_GCR_Cx_ID_CORENUM_MSK	(0xff << 0)
 
 #define CPC_CL_VC_STOP_OFS	0x2020
 #define CPC_CL_VC_RUN_OFS	0x2028
@@ -305,13 +309,22 @@ LEAF(mips_cps_core_init)
  */
 LEAF(mips_cps_get_bootcfg)
 	/* Calculate a pointer to this cores struct core_boot_config */
+	PTR_LA	v0, mips_cps_cluster_bootcfg
+	PTR_L	v0, 0(v0)
 	cmgcrb	t0
 	lw	t0, GCR_CL_ID_OFS(t0)
+#ifdef CONFIG_CPU_MIPSR6
+	ext	t1, t0, CM3_GCR_Cx_ID_CLUSTER_SHF, 8
+	li	t2, CLUSTERBOOTCFG_SIZE
+	mul	t1, t1, t2
+	PTR_ADDU \
+		v0, v0, t1
+#endif
+	PTR_L	v0, CLUSTERBOOTCFG_CORECONFIG(v0)
+	andi	t0, t0, CM3_GCR_Cx_ID_CORENUM_MSK
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
-	PTR_LA	t1, mips_cps_core_bootcfg
-	PTR_L	t1, 0(t1)
-	PTR_ADDU v0, t0, t1
+	PTR_ADDU v0, v0, t0
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index a7bcf2b814c8..84e79bd84971 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -107,12 +107,14 @@ static void coupled_barrier(atomic_t *a, unsigned online)
 int cps_pm_enter_state(enum cps_pm_state state)
 {
 	unsigned cpu = smp_processor_id();
+	unsigned int cluster = cpu_cluster(&current_cpu_data);
 	unsigned core = cpu_core(&current_cpu_data);
 	unsigned online, left;
 	cpumask_t *coupled_mask = this_cpu_ptr(&online_coupled);
 	u32 *core_ready_count, *nc_core_ready_count;
 	void *nc_addr;
 	cps_nc_entry_fn entry;
+	struct cluster_boot_config *cluster_cfg;
 	struct core_boot_config *core_cfg;
 	struct vpe_boot_config *vpe_cfg;
 	atomic_t *barrier;
@@ -142,7 +144,8 @@ int cps_pm_enter_state(enum cps_pm_state state)
 		if (!mips_cps_smp_in_use())
 			return -EINVAL;
 
-		core_cfg = &mips_cps_core_bootcfg[core];
+		cluster_cfg = &mips_cps_cluster_bootcfg[cluster];
+		core_cfg = &cluster_cfg->core_config[core];
 		vpe_cfg = &core_cfg->vpe_config[cpu_vpe_id(&current_cpu_data)];
 		vpe_cfg->pc = (unsigned long)mips_cps_pm_restore;
 		vpe_cfg->gp = (unsigned long)current_thread_info();
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bcd6a944b839..360d132bee71 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -27,7 +27,7 @@
 static bool threads_disabled;
 static DECLARE_BITMAP(core_power, NR_CPUS);
 
-struct core_boot_config *mips_cps_core_bootcfg;
+struct cluster_boot_config *mips_cps_cluster_bootcfg;
 
 static int __init setup_nothreads(char *s)
 {
@@ -118,9 +118,11 @@ static void __init cps_smp_setup(void)
 
 static void __init cps_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned ncores, core_vpes, c, cca;
+	unsigned int nclusters, ncores, core_vpes, c, cl, cca;
 	bool cca_unsuitable, cores_limited;
 	u32 *entry_code;
+	struct cluster_boot_config *cluster_bootcfg;
+	struct core_boot_config *core_bootcfg;
 
 	mips_mt_set_cpuoptions();
 
@@ -168,40 +170,54 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 		     (void *)entry_code - (void *)&mips_cps_core_entry);
 	__sync();
 
-	/* Allocate core boot configuration structs */
-	ncores = mips_cps_numcores(0);
-	mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
-					GFP_KERNEL);
-	if (!mips_cps_core_bootcfg) {
-		pr_err("Failed to allocate boot config for %u cores\n", ncores);
-		goto err_out;
-	}
+	/* Allocate cluster boot configuration structs */
+	nclusters = mips_cps_numclusters();
+	mips_cps_cluster_bootcfg = kcalloc(nclusters,
+					   sizeof(*mips_cps_cluster_bootcfg),
+					   GFP_KERNEL);
 
-	/* Allocate VPE boot configuration structs */
-	for (c = 0; c < ncores; c++) {
-		core_vpes = core_vpe_count(0, c);
-		mips_cps_core_bootcfg[c].vpe_config = kcalloc(core_vpes,
-				sizeof(*mips_cps_core_bootcfg[c].vpe_config),
-				GFP_KERNEL);
-		if (!mips_cps_core_bootcfg[c].vpe_config) {
-			pr_err("Failed to allocate %u VPE boot configs\n",
-			       core_vpes);
+	for (cl = 0; cl < nclusters; cl++) {
+		/* Allocate core boot configuration structs */
+		ncores = mips_cps_numcores(cl);
+		core_bootcfg = kcalloc(ncores, sizeof(*core_bootcfg),
+					GFP_KERNEL);
+		if (!core_bootcfg)
 			goto err_out;
+		mips_cps_cluster_bootcfg[cl].core_config = core_bootcfg;
+
+		/* Allocate VPE boot configuration structs */
+		for (c = 0; c < ncores; c++) {
+			core_vpes = core_vpe_count(cl, c);
+			core_bootcfg[c].vpe_config = kcalloc(core_vpes,
+					sizeof(*core_bootcfg[c].vpe_config),
+					GFP_KERNEL);
+			if (!core_bootcfg[c].vpe_config)
+				goto err_out;
 		}
 	}
 
 	/* Mark this CPU as booted */
-	atomic_set(&mips_cps_core_bootcfg[cpu_core(&current_cpu_data)].vpe_mask,
-		   1 << cpu_vpe_id(&current_cpu_data));
+	cl = cpu_cluster(&current_cpu_data);
+	c = cpu_core(&current_cpu_data);
+	cluster_bootcfg = &mips_cps_cluster_bootcfg[cl];
+	core_bootcfg = &cluster_bootcfg->core_config[c];
+	atomic_set(&core_bootcfg->vpe_mask, 1 << cpu_vpe_id(&current_cpu_data));
 
 	return;
 err_out:
 	/* Clean up allocations */
-	if (mips_cps_core_bootcfg) {
-		for (c = 0; c < ncores; c++)
-			kfree(mips_cps_core_bootcfg[c].vpe_config);
-		kfree(mips_cps_core_bootcfg);
-		mips_cps_core_bootcfg = NULL;
+	if (mips_cps_cluster_bootcfg) {
+		for (cl = 0; cl < nclusters; cl++) {
+			cluster_bootcfg = &mips_cps_cluster_bootcfg[cl];
+			ncores = mips_cps_numcores(cl);
+			for (c = 0; c < ncores; c++) {
+				core_bootcfg = &cluster_bootcfg->core_config[c];
+				kfree(core_bootcfg->vpe_config);
+			}
+			kfree(mips_cps_cluster_bootcfg[c].core_config);
+		}
+		kfree(mips_cps_cluster_bootcfg);
+		mips_cps_cluster_bootcfg = NULL;
 	}
 
 	/* Effectively disable SMP by declaring CPUs not present */
@@ -286,17 +302,23 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 
 static void remote_vpe_boot(void *dummy)
 {
+	unsigned int cluster = cpu_cluster(&current_cpu_data);
 	unsigned core = cpu_core(&current_cpu_data);
-	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
+	struct cluster_boot_config *cluster_cfg =
+		&mips_cps_cluster_bootcfg[cluster];
+	struct core_boot_config *core_cfg = &cluster_cfg->core_config[core];
 
 	mips_cps_boot_vpes(core_cfg, cpu_vpe_id(&current_cpu_data));
 }
 
 static int cps_boot_secondary(int cpu, struct task_struct *idle)
 {
+	unsigned int cluster = cpu_cluster(&cpu_data[cpu]);
 	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
-	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
+	struct cluster_boot_config *cluster_cfg =
+		&mips_cps_cluster_bootcfg[cluster];
+	struct core_boot_config *core_cfg = &cluster_cfg->core_config[core];
 	struct vpe_boot_config *vpe_cfg = &core_cfg->vpe_config[vpe_id];
 	unsigned long core_entry;
 	unsigned int remote;
@@ -449,12 +471,14 @@ static void cps_kexec_nonboot_cpu(void)
 static int cps_cpu_disable(void)
 {
 	unsigned cpu = smp_processor_id();
+	struct cluster_boot_config *cluster_cfg;
 	struct core_boot_config *core_cfg;
 
 	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
 		return -EINVAL;
 
-	core_cfg = &mips_cps_core_bootcfg[cpu_core(&current_cpu_data)];
+	cluster_cfg = &mips_cps_cluster_bootcfg[cpu_cluster(&current_cpu_data)];
+	core_cfg = &cluster_cfg->core_config[cpu_core(&current_cpu_data)];
 	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
-- 
2.17.1

