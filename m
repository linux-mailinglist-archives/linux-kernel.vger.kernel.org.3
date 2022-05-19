Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7A52DD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiESSwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244141AbiESSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:52:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A113465B;
        Thu, 19 May 2022 11:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDFP/sx/juy2FjxsVRy9zH02Ufp1YSDu1qYOHjydPHUyM0uCPPMBE/UrC7fTXmC3F3eGPCb8+d8ZLolTYARx5/nBQ1iZTBRnvTI0hM3fdASJUrjk2AzDe8vv3Xie9xvy8GzN0CM5uoNXL096N36M24W8tgK76SpTU/Dvnm9hqelX7XhtVuyc8X4ltUaqfw+NlX43vcP1EIXSXSkN0BeLZityjeI1wVFE0jjjR3SbK1AKrrnbFnG7PTJvV1im3Ni/kL+ByliLXWRZfX5P9LV1vW/ABmQi9SqWRznOFYdnwAHsOXrAxfTX5ZPy62uUgXZm8XFe5QI+A87F6yaiCeqBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od9jMJfS91fPqn1FYncIFoA02CQC63lbj/2QQyAzKK8=;
 b=c6JfZ3cFgXtfg7dd0D4ZTy3GXZ/NsCniSjbUgOPv+TbHTWFrpspYsG9UOpzjQVUDZRjmLuLNR9jV2e3GUznBVqrvJKOd8lAM3o+6UcBvQF7azDHdwu7p9VcVqcI5QwvxxPuKHbYIZ119X9kmvjADj2kP33rM/7dICJmvcsf6b0QxfMXnyC44vcATta8eLz5rWXcX5zFGgHoLj8JSA4V3qRp7YQa3b4NcEYNr3Bd3cgQ+EGkQzjF3DLaQsTck8gyx2mser6A/aVatccMy1V1f7F1HlFf7GLyVDBAeUywuK+tq4PhrRPvFdYqyDpXmjkZP0957poUanF1hQkXwZPLcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od9jMJfS91fPqn1FYncIFoA02CQC63lbj/2QQyAzKK8=;
 b=DPs4S5aMc+3jT53WfVExIsuI84pZSdI5kdP4X1XdHoYI7iszoWr5LkdLt4X/Dnu4dNYuIZ1k/dzALg0Dr0A2vG4kIkNf6LOU6Uht56C0AeP68He2XaMgbhbs+y670oRilBGiDf1xaCyWk0mapDD/DqQdZIIXwt5TM/HzeVafbl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:49 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:49 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] MIPS: CPS: Introduce struct cluster_boot_config
Date:   Thu, 19 May 2022 20:51:23 +0200
Message-Id: <20220519185125.11686-11-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60708733-2975-465f-288c-08da39c8a088
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB25464AE87ED1DCD1AE867F5AEFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCUvAg7leZCPt0bBgcl6289jjgI7DXuADEzlPHLFpU728t4Rq97wuz5uf3/IJty1wnAj8SYusKdPqdMm/3wvVCGb82ztGv/Rc5CqPPDM2k/FyjpigPUR48XX90dOF6LXaKF9MdvIu8Z8sEiUmfqBe4wZsPQHIVALb2kD3iX3dk6nwgHxhKhVl+UlXyK2jRDi6f2Hn+ISbHp4+mZyKX3NEwbbRavgPxwVpwbqSV/3b8meBjfs15pyHrwBWfbYCG8vnb/7WTRq9NPaJaYTOEgGyXrKCxYCdfYLs+xl74QOZe98xv1PgETlOsaD8Meu2AZSnD/ubq3qiW/E7jwMp1wLY7RrkBNQIHSs7HZAqciaof7K63JRgXhzcIWvEcSASc0gdj0qMRkwsQXFeIu1+UUGVSPBAp2Xl8Wf4039qHjA3xULoaTmxwEtpRx7p/cBYjDGQHyQ5WXPWRVZwNgi1oAUi8uGk0zRR4yXAzFmcp3bjGwSdIJyNYI4/NN7cKlFgaxuZJnAuecI5o/tl3wrVUOr2HL6sTvQECzMzEX+fbwYoz/SG1KCIEpw0o21iYPoawPWP2S1q5Ncc7G59c4u5dmOwfCRBGznBmH9eB9mzEOfp9AOEoNWxdJ4OkoX5V+YzgWiqCBWeZLE1D5AMSEaBYXq+LIzBc9W+2ffued2fJAa1SEypd/duZnHhiD9yx6AVOQDDZWSxPEPZ0DduKCQnCh4AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ha0h/28nlKi50IF8BaqskGIyYjVknUAs3LuLYxeIw2Huydtkjh0lXRVJs42A?=
 =?us-ascii?Q?yJbbHGQFstsGzyjAzxkPjVoH53zxPPGcRX1zs53FHQ2AgOO6LQxZWKZE8qKB?=
 =?us-ascii?Q?QYBEdkDgh9Sb3QV24s3Aa1O40ah0JFwMB4lgHu24ZgJvKwZ9Z6E3MNlC8rHn?=
 =?us-ascii?Q?Pv2kDoIsdjViSVZYzobBYhWJhq8acsvzbNBnRJZW77ZL8MNna0/okO+5pFcm?=
 =?us-ascii?Q?5qa4gXzEjHU+zSyjLCZcxTOv8mI6zF8AsRwi6xnAMDSG3FotBS97r/gqfAxT?=
 =?us-ascii?Q?sV41LdfTG4Ez5LaOalqk8cP2NWJ+VX7lccJGEvpGEig8uySduI79ZryjY+N7?=
 =?us-ascii?Q?TvmsxO22ZrHAbIh7V11XILjISA6shB+ZCNzppYKPwgj5O34sdJSD4AH/kEt/?=
 =?us-ascii?Q?ce61Z8bj/fYu0wXIIH2mB8o9sQSygLTmceu9YNkGx4wYc5lmcPe+kx7858H8?=
 =?us-ascii?Q?UGd8nqI1ZfqjXrPJQ03eV6wEqpKcjOaHNXf6ncggpqWYlrZ34uCTWWDvLQ4h?=
 =?us-ascii?Q?ByMPyDM9kY7MytMDRguI65dKLjWnZqU2aN+jXRqmVa7sMigT+BMIxFUF87hL?=
 =?us-ascii?Q?xVrB/uzmpv3SarhOp/pw49VkNwIv/+hW+SiHevA8yMt8S++/bFT4ELrNYR2S?=
 =?us-ascii?Q?JVQcuyxRlRMdGvB9wB8ujwKc+XUuZce2DfzckLpTZvU9mIsJ2ag6znQBu3Tm?=
 =?us-ascii?Q?4ODuLMjNswE7QjQFp6BLaDhhkK53j0AreOmKazVqzktDdu7Gsj2whuzFnE4z?=
 =?us-ascii?Q?51etQK/ic/X28nP+DT1/HtXi98gk+yKlMNWX4YOXx4MxqRCdRd5yDuNLMpX6?=
 =?us-ascii?Q?trdDEOQG/90JXWnGjR1d1Wev+digW3o5N9tRUNcDsEcC6BrjoREpjhJHNLtk?=
 =?us-ascii?Q?hvynbYbKku/lKr2/JWvyqawnFFq8sB47vBkUj8ieWashezVRHOk/ZIsdbrVU?=
 =?us-ascii?Q?Oi8t6Lm6+bmoGk8P551YyyUoZRWQc0EwY48zZqVwYcPdg37ggjbMBDSErAjT?=
 =?us-ascii?Q?gHKGD+lWBHL8qWTYk+kkxpgQeNkGM4F0Jk8BnvRSjy8S3ACICfGb62wHQbc7?=
 =?us-ascii?Q?eKyD7v7y3Iz2rBvEvmgqv4lDcD3L+RsnfVNXV3avw3hy8GvWF1dsa+0O3zkZ?=
 =?us-ascii?Q?85dPD1nDCEhYd10VCvw5MoKFglt97Nfywcbh222W/WKyZ70HmlVroiEoeKCi?=
 =?us-ascii?Q?tB9sM3zKwuVZjJ44kcBqRSrGaIqRDPFm6F01xCuhVJpprLFWEzP7k7BC8LUd?=
 =?us-ascii?Q?VtgxoER0d6mQPYcjtwesbJ0uX6CxCRgZe4vLLPE6vO3SNhsZi0R6q7sWQ7fV?=
 =?us-ascii?Q?jrqANzruYvd3cOAmxQ2BQQDLtd2+85c2gvF0Vbuif6y9WG9SOzaSLdY0jaVp?=
 =?us-ascii?Q?dTEcqPziCrmA87CMFqc0n6xlbcilZCGII/wEsDkuzoA2iKCpTodWAskmkssy?=
 =?us-ascii?Q?4IBOkh1Df8cXkKOh2LNCXmXBvcynzJGfZSZqRyuCUBe8ZnutzVLPwRYut8hH?=
 =?us-ascii?Q?oBVqCtpFFhLSJww9U9y6iiyInTiqrVm2A6jpKC/RevuQjt3QXnGeKwP1Lvqb?=
 =?us-ascii?Q?Kq11ztMMn8QIhn9agEG0OoVVTfEF6OJLFUaUQCUjavUWzJGOK6/eK9U+vnP1?=
 =?us-ascii?Q?w3C1kKi/pf6SqDoBeBBWovRaogds18TIOZL0hADAsUNnuJeMdV+dpcMa9Gsy?=
 =?us-ascii?Q?e3oAYr83QfcLcXDUuxPQZbHh/SUbOvdajTpFdHYt8nBY/sLA8GIicY3NvOO7?=
 =?us-ascii?Q?7XGhBWF3BUtQFpmbEiUOFITX+YMmPV41oG7/JW7lPWSlBH9kMEA4?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60708733-2975-465f-288c-08da39c8a088
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:47.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+HFUcNVxGhKn3t0De8EhWQBlApUnYezQ37CV38U2i3iu6Z7WXFZpqUa7L5r/U3DuRnN0LK37IUakTauvCypFXhiAJc6qYuZXdVH4wet2uc=
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

In preparation for supporting multi-cluster systems, introduce a struct
cluster_boot_config as an extra layer in the boot configuration
maintained by the MIPS Coherent Processing System (CPS) SMP
implementation. For now only one struct cluster_boot_config will be
allocated & we'll simply defererence its core_config field to find the
struct core_boot_config array which we use to boot as usual.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

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

