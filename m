Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98424533C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbiEYMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiEYMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2131.outbound.protection.outlook.com [40.107.104.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD1BA186;
        Wed, 25 May 2022 05:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HodbvbjcLitz0wn9NP7MpuFxA90YYxQEbGESf561LezUsYyDLzNWLMDqOl69lzJUEXe95jhINR4b4VL7Y2dxgtVvvW82pAyW+opRBimlin33V+eI06J1hqgp7kZUGYT7HGRz40cPrxXE8y/usG6v8pmMhOe0LfbLW5DGp2cZvqDDol6ehrnbu5Ei099DH4MWxgLKrmc8k/eGZm2vLDY/TbuonJ3352oe3p3Hei3ROHf9bKCRrL2B5Nrt9hNgTOfsRKFMeQY1ek7FdUIIrAoKQSe5NX8yusIDesDhPRH0d3Xj9BSzL2zRbnfsL57VVw0pe4r3K52ZllGa7pDKi8su/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgCq1+XIeSZPMsbE/nKY17gr9fIDu7xw/OBV00nPoSE=;
 b=WRXmwTo+PaqVylW3eC1wJDDj4JntxUCMojvpBAw2+n4lZ2DAyaywN/AgXGi9Qzm3D5L8bt3MyfWL38cmYISQnY1cqQRZ19XASwk0eHZV+Sz2q93f638Eb5fpA1RvOEikbQA88F/zeQJ6uS0uvTkDrbVSEbqDIhQMF0Rg3B8i4Ph2S91DwEHUq6yrCoSW7x9+ZbWqcbwoPcPCwlFlR6v+ZK4m6N2bDgBJWNadcoy/nPFlsBXCryoxQHHwFCaGoK70Ci4oO1b/vSZ3oPA6mQh8YtWPbwoLy1vXw2ylc9vgGQ0sTSxeo+ZDRpZOjQHEkknJ5CS4XS709bSBDj+ySzhZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgCq1+XIeSZPMsbE/nKY17gr9fIDu7xw/OBV00nPoSE=;
 b=YUDTa61I/cU/lvbJPIwidiVjB5kWVmIO2sjjkSw8Wb96iahekdgMVnPjk2oFjbsYpgCIhedDoSWviDBWrWsul3UeHeUme/rZTsGnsIoEUQD1IDVt/xX5KAsrK0Y8MMvZ0qjOkfWm76aJJLVrM/rU0BKIDBTpHpNWESqdj+obsCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by VE1PR03MB5439.eurprd03.prod.outlook.com (2603:10a6:802:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:11:01 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:11:01 +0000
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
Subject: [PATCH v2 12/12] MIPS: CPS: Boot CPUs in secondary clusters
Date:   Wed, 25 May 2022 14:10:30 +0200
Message-Id: <20220525121030.16054-13-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da47688e-03f6-40d7-827d-08da3e47a02a
X-MS-TrafficTypeDiagnostic: VE1PR03MB5439:EE_
X-Microsoft-Antispam-PRVS: <VE1PR03MB54398F4220FC39ECB52C2751EFD69@VE1PR03MB5439.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vws8sNo4LweftWz0GRvawXEo3Irt4dW7MMO38YqXaFn9iV31CMyDU3ke0RpxnIf40gGt6A5Ar/+ZRwX+8hrxogoUDiPAsK0o6RATaXQ7GAQnvhXza2UPL4Y8X/wP2rIIuADVTLURFJGzi4PABiZPxvuyW8ceLdrDTmPacOoMuf5B4t8qtWyaq/U/tqJ1tEX1vNXfDKHQIm/dvOBQ8fLiM5/I/rjBkOoOoVT+c+TpvLrg8MuzNdZ/fvmjn0MRVWSggh+VYXjtmha5Ue3LAG4l1hpHgF/i+1IQoC1ZYHOtmH71nZzORQuuWkIDZ5mla3DmZ7Eo45PbGa0jHg4X9PR0POKjjZJwHSMG8iZjT7cgpRsIap0q5eF1+nH1MoO/3XWRt3OfG+RE0M1Fdsx2n5mn6YTwoCmTeIUEfOJI2avd71snxTJDlePLkKyQxYnpDuKwlcHrb2Gize7LC5d9iWrnmD7LE4j3+U4yx8t6GmTWr2DIdTxv2kRZbrrA0XhoWwcsogr5EquPde5yJUe9h6uI8GRbfihkmqVhERoQoD6Zd5D/1MKU/oWdXFw5fCeyaMHntkmbEMY4XnTcfwV6FbM8hS/xVsTL+mQARH856j2B86zjgCXa0I5LACMIWaRgdBgAnp1x2zyieNodSePAOeVZADWMC+5CkwKQqByX3V8xU9vLzmnlYSjgUmMDMA23r2KF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(396003)(39840400004)(376002)(366004)(346002)(36756003)(6486002)(7416002)(2906002)(6506007)(316002)(8936002)(86362001)(30864003)(4326008)(66556008)(66946007)(52116002)(8676002)(6512007)(26005)(508600001)(5660300002)(6666004)(107886003)(54906003)(41300700001)(2616005)(66476007)(6916009)(1076003)(38100700002)(38350700002)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llQzSegOBhsIjG/TpCTEgvKeWdgg9pb9XXiWbT2hRzSsnxR6/Cw6ZbpePgHT?=
 =?us-ascii?Q?KB8vH/Wpu3GnNyhc9RTr9dxUgpyJ2mhKuj9aIJJA/Oxjgyhv6XJJhm8cPGaE?=
 =?us-ascii?Q?JccQedujRsPQkEapOOnOi50iOE1wjBD5//CUTxVyTGB5dbk6Ikvns1RvCa/R?=
 =?us-ascii?Q?8wgBCeZ8+pOWX+0dt44gj4awRHTMmj0EY4zjvuEoARaui2xzeN7hbmuaFkFa?=
 =?us-ascii?Q?JJ2NfdNjYvH6yNX2ToSxxeTyo6ZNpzMJPqJQme+hMjwqVeTX5iU+mkkP930e?=
 =?us-ascii?Q?eB98WQAwaNiqMdTGWjOXVMQOOX23EMl5hgdHPk/NbZMrW4n3MLd7mYMJh1uN?=
 =?us-ascii?Q?HtNONrCFN1KQk/m/4Sl/ISvPQgW1WTDKRNwq5NUdOIuAT1166nDReUozJFdN?=
 =?us-ascii?Q?2rOYXNNj+itma+3ErrVMrOZALIVDnNA38WcxtuwI9aGYzLQQAS6yfi/lm6GS?=
 =?us-ascii?Q?GE216Lyto5bdPloECTvbwECLENSQwjz+rvM7M7nr6tzJI1OIIrmpQSThD7NI?=
 =?us-ascii?Q?9FHBpW1T6fjkeNfiASmEkEV9wqCkH+Lh8CPtjeNlLqCu6Iz3wLOHwj5gYZWv?=
 =?us-ascii?Q?pJhEwCrKn+EThN7b0ONDNJoo9GFQSnn5ACUmw3PF3x/3qYeF7znHyRV3Lzc5?=
 =?us-ascii?Q?aNvO/DDsMV7cqvVj14j2Q02RD4m2VoLcaR2B1Jrr10l9XWEU0gSAv4MiluaQ?=
 =?us-ascii?Q?g/il+F44MJp5UO6SWJb6OO7oNOWUXT53Pz+eNz1G+I+CU2CWAFcFzPABAYee?=
 =?us-ascii?Q?Zu1VLYUBQMVcLVtTYhVqYjmsdaMzgcOSUeN27ONSr13xF8dJW33qw6OfcDkB?=
 =?us-ascii?Q?BosrLD6QUxccENQzUueSxJljHZqv/yFGy5KLDyF9HkzKvnPD54viLVa1mQbt?=
 =?us-ascii?Q?H8su1Fi57dJ9gl3X2CyDcVXDzyFBe3fDjKIZDdQme5S8/76h34098K61vmxl?=
 =?us-ascii?Q?RYlBjbijL1rYB16LvGmw3q7WBxv8JOwkGlThBPVIhjOxS8hanmho4sRiJ1+K?=
 =?us-ascii?Q?IhzO1XBFTJgG4BG6PWzOGw7ww0o+/fKvmNxDz+00Y/wg49MMd6hv0nXaRPAE?=
 =?us-ascii?Q?w8wKrJm7OiWP/1BLvojj7r3tiiF/EDGDh+JkIvNoDFGiDzZ1NxtceAAjFCpC?=
 =?us-ascii?Q?IxAmRxD7bo2TSZoX7G13adh5QvQJkuwTV+EhVxBlvoXf3rFNragE1Ka5D97E?=
 =?us-ascii?Q?HzcQeywDYyoUWIeCB44p/XLj648rixMzvcAn6CT6X8f3sYI9AUOvhyDQx4+m?=
 =?us-ascii?Q?Psao9wDQRpyc/55GGshe2oHwDNqLj0WHsszaBHBOCRSFDrBG61Xvyh5yvmhK?=
 =?us-ascii?Q?PN0/4wewX0V5YqFvckTyhoQc2Dg4Wr1DEzmMo7QJ4kdF+ujbkYlSNDNeHGRn?=
 =?us-ascii?Q?uVbzB0ZGrQdso/91iMsD06StfVV6KmLFksMeLbtaqpRaSbIgD6D0owiZlAai?=
 =?us-ascii?Q?dtYNnb4StgTp02cWLg1x0h5Zts9qUU0tsK90vtheGlHHZ7Wj27lU9M8unD/m?=
 =?us-ascii?Q?iiyIew9SF59xVDjbywLHS0qRBEC7p5okx2eQDp+uDrllCJSQTi+nPlqd0X2c?=
 =?us-ascii?Q?OAD5sVA2sD4bVpEuxPPvYic7qXinQfQF2UUhNAVwaU4T2J2cbVZL7MNvu8sm?=
 =?us-ascii?Q?SMvr3Se4hTk2RhlooIKs1K8AfJDSqrN5dbAkUXcTt728sjSXHV99QbB8NTKH?=
 =?us-ascii?Q?AbTFEHZMhnTWfr6URE4ifdsI5R5XdFMreKQSP/hSbi8IbsrV0uSt+vRccLVL?=
 =?us-ascii?Q?QJ54Sb7/JGXcI8PAa1p6NJglZHRXLGolsqchkT7LMzxLAhecMDXE?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da47688e-03f6-40d7-827d-08da3e47a02a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:57.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYu8iyqfCx0Zpiq+QPzNFmyFMe56FDMMrGvrKiojXPHyT9AdpH8J3icjUU6ddzR90QWUXuo+J7ZZ6MMT0gs4fJbSPJapO174ZsCJnNhkLSw=
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

Probe for & boot CPUs (cores & VPs) in secondary clusters (ie. not the
cluster that began booting Linux) when they are present in systems with
CM 3.5 or higher.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b1..435049907e44 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -239,6 +239,12 @@ GCR_ACCESSOR_RW(32, 0x130, l2_config)
 GCR_ACCESSOR_RO(32, 0x150, sys_config2)
 #define CM_GCR_SYS_CONFIG2_MAXVPW		GENMASK(3, 0)
 
+/* GCR_L2-RAM_CONFIG - Configuration & status of L2 cache RAMs */
+GCR_ACCESSOR_RW(64, 0x240, l2_ram_config)
+#define CM_GCR_L2_RAM_CONFIG_PRESENT		BIT(31)
+#define CM_GCR_L2_RAM_CONFIG_HCI_DONE		BIT(30)
+#define CM_GCR_L2_RAM_CONFIG_HCI_SUPPORTED	BIT(29)
+
 /* GCR_L2_PFT_CONTROL - Controls hardware L2 prefetching */
 GCR_ACCESSOR_RW(32, 0x300, l2_pft_control)
 #define CM_GCR_L2_PFT_CONTROL_PAGEMASK		GENMASK(31, 12)
@@ -250,6 +256,18 @@ GCR_ACCESSOR_RW(32, 0x308, l2_pft_control_b)
 #define CM_GCR_L2_PFT_CONTROL_B_CEN		BIT(8)
 #define CM_GCR_L2_PFT_CONTROL_B_PORTID		GENMASK(7, 0)
 
+/* GCR_L2_TAG_ADDR - Access addresses in L2 cache tags */
+GCR_ACCESSOR_RW(64, 0x600, l2_tag_addr)
+
+/* GCR_L2_TAG_STATE - Access L2 cache tag state */
+GCR_ACCESSOR_RW(64, 0x608, l2_tag_state)
+
+/* GCR_L2_DATA - Access data in L2 cache lines */
+GCR_ACCESSOR_RW(64, 0x610, l2_data)
+
+/* GCR_L2_ECC - Access ECC information from L2 cache lines */
+GCR_ACCESSOR_RW(64, 0x618, l2_ecc)
+
 /* GCR_L2SM_COP - L2 cache op state machine control */
 GCR_ACCESSOR_RW(32, 0x620, l2sm_cop)
 #define CM_GCR_L2SM_COP_PRESENT			BIT(31)
diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index 84a713667be2..7bcad119ceb1 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -21,6 +21,7 @@ struct core_boot_config {
 };
 
 struct cluster_boot_config {
+	unsigned long *core_power;
 	struct core_boot_config *core_config;
 };
 
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 5b843c2ff077..f4c23bcab417 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -309,7 +309,9 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 		      FIELD_PREP(CM3_GCR_Cx_OTHER_VP, vp);
 
 		if (cm_rev >= CM_REV_CM3_5) {
-			val |= CM_GCR_Cx_OTHER_CLUSTER_EN;
+			if (cluster != cpu_cluster(&current_cpu_data))
+				val |= CM_GCR_Cx_OTHER_CLUSTER_EN;
+			val |= CM_GCR_Cx_OTHER_GIC_EN;
 			val |= FIELD_PREP(CM_GCR_Cx_OTHER_CLUSTER, cluster);
 			val |= FIELD_PREP(CM_GCR_Cx_OTHER_BLOCK, block);
 		} else {
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 360d132bee71..311e9e40e5c7 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -25,7 +25,6 @@
 #include <asm/uasm.h>
 
 static bool threads_disabled;
-static DECLARE_BITMAP(core_power, NR_CPUS);
 
 struct cluster_boot_config *mips_cps_cluster_bootcfg;
 
@@ -36,6 +35,51 @@ static int __init setup_nothreads(char *s)
 }
 early_param("nothreads", setup_nothreads);
 
+static void power_up_other_cluster(unsigned int cluster)
+{
+	u32 stat, seq_state;
+	unsigned int timeout;
+
+	mips_cm_lock_other(cluster, CM_GCR_Cx_OTHER_CORE_CM, 0,
+			   CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	stat = read_cpc_co_stat_conf();
+	mips_cm_unlock_other();
+
+	seq_state = stat & CPC_Cx_STAT_CONF_SEQSTATE;
+	seq_state >>= __ffs(CPC_Cx_STAT_CONF_SEQSTATE);
+	if (seq_state == CPC_Cx_STAT_CONF_SEQSTATE_U5)
+		return;
+
+	/* Set endianness & power up the CM */
+	mips_cm_lock_other(cluster, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+	write_cpc_redir_sys_config(IS_ENABLED(CONFIG_CPU_BIG_ENDIAN));
+	write_cpc_redir_pwrup_ctl(1);
+	mips_cm_unlock_other();
+
+	/* Wait for the CM to start up */
+	timeout = 1000;
+	mips_cm_lock_other(cluster, CM_GCR_Cx_OTHER_CORE_CM, 0,
+			   CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	while (1) {
+		stat = read_cpc_co_stat_conf();
+		seq_state = stat & CPC_Cx_STAT_CONF_SEQSTATE;
+		seq_state >>= __ffs(CPC_Cx_STAT_CONF_SEQSTATE);
+		if (seq_state == CPC_Cx_STAT_CONF_SEQSTATE_U5)
+			break;
+
+		if (timeout) {
+			mdelay(1);
+			timeout--;
+		} else {
+			pr_warn("Waiting for cluster %u CM to power up... STAT_CONF=0x%x\n",
+				cluster, stat);
+			mdelay(1000);
+		}
+	}
+
+	mips_cm_unlock_other();
+}
+
 static unsigned core_vpe_count(unsigned int cluster, unsigned core)
 {
 	if (threads_disabled)
@@ -59,6 +103,9 @@ static void __init cps_smp_setup(void)
 			pr_cont(",");
 		pr_cont("{");
 
+		if (mips_cm_revision() >= CM_REV_CM3_5)
+			power_up_other_cluster(cl);
+
 		ncores = mips_cps_numcores(cl);
 		for (c = 0; c < ncores; c++) {
 			core_vpes = core_vpe_count(cl, c);
@@ -86,8 +133,8 @@ static void __init cps_smp_setup(void)
 
 	/* Indicate present CPUs (CPU being synonymous with VPE) */
 	for (v = 0; v < min_t(unsigned, nvpes, NR_CPUS); v++) {
-		set_cpu_possible(v, cpu_cluster(&cpu_data[v]) == 0);
-		set_cpu_present(v, cpu_cluster(&cpu_data[v]) == 0);
+		set_cpu_possible(v, true);
+		set_cpu_present(v, true);
 		__cpu_number_map[v] = v;
 		__cpu_logical_map[v] = v;
 	}
@@ -95,19 +142,15 @@ static void __init cps_smp_setup(void)
 	/* Set a coherent default CCA (CWB) */
 	change_c0_config(CONF_CM_CMASK, 0x5);
 
-	/* Core 0 is powered up (we're running on it) */
-	bitmap_set(core_power, 0, 1);
-
 	/* Initialise core 0 */
 	mips_cps_core_init();
 
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
 
-	if (mips_cm_revision() >= CM_REV_CM3) {
-		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+	core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+	if (mips_cm_revision() >= CM_REV_CM3)
 		write_gcr_bev_base(core_entry);
-	}
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
@@ -185,6 +228,10 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 			goto err_out;
 		mips_cps_cluster_bootcfg[cl].core_config = core_bootcfg;
 
+		mips_cps_cluster_bootcfg[cl].core_power =
+			kcalloc(BITS_TO_LONGS(ncores), sizeof(unsigned long),
+				GFP_KERNEL);
+
 		/* Allocate VPE boot configuration structs */
 		for (c = 0; c < ncores; c++) {
 			core_vpes = core_vpe_count(cl, c);
@@ -196,11 +243,12 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 		}
 	}
 
-	/* Mark this CPU as booted */
+	/* Mark this CPU as powered up & booted */
 	cl = cpu_cluster(&current_cpu_data);
 	c = cpu_core(&current_cpu_data);
 	cluster_bootcfg = &mips_cps_cluster_bootcfg[cl];
 	core_bootcfg = &cluster_bootcfg->core_config[c];
+	bitmap_set(cluster_bootcfg->core_power, cpu_core(&current_cpu_data), 1);
 	atomic_set(&core_bootcfg->vpe_mask, 1 << cpu_vpe_id(&current_cpu_data));
 
 	return;
@@ -228,16 +276,123 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static void boot_core(unsigned int core, unsigned int vpe_id)
+static void init_cluster_l2(void)
 {
-	u32 stat, seq_state;
-	unsigned timeout;
+	u32 l2_cfg, l2sm_cop, result;
+
+	while (1) {
+		l2_cfg = read_gcr_redir_l2_ram_config();
+
+		/* If HCI is not supported, use the state machine below */
+		if (!(l2_cfg & CM_GCR_L2_RAM_CONFIG_PRESENT))
+			break;
+		if (!(l2_cfg & CM_GCR_L2_RAM_CONFIG_HCI_SUPPORTED))
+			break;
+
+		/* If the HCI_DONE bit is set, we're finished */
+		if (l2_cfg & CM_GCR_L2_RAM_CONFIG_HCI_DONE)
+			return;
+	}
+
+	l2sm_cop = read_gcr_redir_l2sm_cop();
+	if (WARN(!(l2sm_cop & CM_GCR_L2SM_COP_PRESENT),
+		 "L2 init not supported on this system yet"))
+		return;
+
+	/* Clear L2 tag registers */
+	write_gcr_redir_l2_tag_state(0);
+	write_gcr_redir_l2_ecc(0);
+
+	/* Ensure the L2 tag writes complete before the state machine starts */
+	mb();
+
+	/* Wait for the L2 state machine to be idle */
+	do {
+		l2sm_cop = read_gcr_redir_l2sm_cop();
+	} while (l2sm_cop & CM_GCR_L2SM_COP_RUNNING);
+
+	/* Start a store tag operation */
+	l2sm_cop = CM_GCR_L2SM_COP_TYPE_IDX_STORETAG;
+	l2sm_cop <<= __ffs(CM_GCR_L2SM_COP_TYPE);
+	l2sm_cop |= CM_GCR_L2SM_COP_CMD_START;
+	write_gcr_redir_l2sm_cop(l2sm_cop);
+
+	/* Ensure the state machine starts before we poll for completion */
+	mb();
+
+	/* Wait for the operation to be complete */
+	do {
+		l2sm_cop = read_gcr_redir_l2sm_cop();
+		result = l2sm_cop & CM_GCR_L2SM_COP_RESULT;
+		result >>= __ffs(CM_GCR_L2SM_COP_RESULT);
+	} while (!result);
+
+	WARN(result != CM_GCR_L2SM_COP_RESULT_DONE_OK,
+	     "L2 state machine failed cache init with error %u\n", result);
+}
+
+static void boot_core(unsigned int cluster, unsigned int core,
+		      unsigned int vpe_id)
+{
+	struct cluster_boot_config *cluster_cfg;
+	u32 access, stat, seq_state;
+	unsigned int timeout, ncores;
+	unsigned long core_entry;
+
+	cluster_cfg = &mips_cps_cluster_bootcfg[cluster];
+	ncores = mips_cps_numcores(cluster);
+	core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+
+	if ((cluster != cpu_cluster(&current_cpu_data)) &&
+	    bitmap_empty(cluster_cfg->core_power, ncores)) {
+		power_up_other_cluster(cluster);
+
+		mips_cm_lock_other(cluster, core, 0,
+				   CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+		/* Ensure cluster GCRs are where we expect */
+		write_gcr_redir_base(read_gcr_base());
+		write_gcr_redir_cpc_base(read_gcr_cpc_base());
+		write_gcr_redir_gic_base(read_gcr_gic_base());
+
+		init_cluster_l2();
+
+		/* Mirror L2 configuration */
+		write_gcr_redir_l2_only_sync_base(read_gcr_l2_only_sync_base());
+		write_gcr_redir_l2_pft_control(read_gcr_l2_pft_control());
+		write_gcr_redir_l2_pft_control_b(read_gcr_l2_pft_control_b());
+
+		/* Mirror ECC/parity setup */
+		write_gcr_redir_err_control(read_gcr_err_control());
+
+		/* Set BEV base */
+		write_gcr_redir_bev_base(core_entry);
+
+		mips_cm_unlock_other();
+	}
+
+	if (cluster != cpu_cluster(&current_cpu_data)) {
+		mips_cm_lock_other(cluster, core, 0,
+				   CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+		/* Ensure the core can access the GCRs */
+		access = read_gcr_redir_access();
+		access |= BIT(core);
+		write_gcr_redir_access(access);
+
+		mips_cm_unlock_other();
+	} else {
+		/* Ensure the core can access the GCRs */
+		access = read_gcr_access();
+		access |= BIT(core);
+		write_gcr_access(access);
+	}
 
 	/* Select the appropriate core */
-	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	mips_cm_lock_other(cluster, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 	/* Set its reset vector */
-	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
+	write_gcr_co_reset_base(core_entry);
 
 	/* Ensure its coherency is disabled */
 	write_gcr_co_coherence(0);
@@ -245,9 +400,6 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	/* Start it with the legacy memory map and exception base */
 	write_gcr_co_reset_ext_base(CM_GCR_Cx_RESET_EXT_BASE_UEB);
 
-	/* Ensure the core can access the GCRs */
-	set_gcr_access(1 << core);
-
 	if (mips_cpc_present()) {
 		/* Reset the core */
 		mips_cpc_lock_other(core);
@@ -297,7 +449,17 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	mips_cm_unlock_other();
 
 	/* The core is now powered up */
-	bitmap_set(core_power, core, 1);
+	bitmap_set(cluster_cfg->core_power, core, 1);
+
+	/*
+	 * Restore CM_PWRUP=0 so that the CM can power down if all the cores in
+	 * the cluster do (eg. if they're all removed via hotplug.
+	 */
+	if (mips_cm_revision() >= CM_REV_CM3_5) {
+		mips_cm_lock_other(cluster, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+		write_cpc_redir_pwrup_ctl(0);
+		mips_cm_unlock_other();
+	}
 }
 
 static void remote_vpe_boot(void *dummy)
@@ -324,10 +486,6 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 	unsigned int remote;
 	int err;
 
-	/* We don't yet support booting CPUs in other clusters */
-	if (cpu_cluster(&cpu_data[cpu]) != cpu_cluster(&raw_current_cpu_data))
-		return -ENOSYS;
-
 	vpe_cfg->pc = (unsigned long)&smp_bootstrap;
 	vpe_cfg->sp = __KSTK_TOS(idle);
 	vpe_cfg->gp = (unsigned long)task_thread_info(idle);
@@ -336,14 +494,15 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 
 	preempt_disable();
 
-	if (!test_bit(core, core_power)) {
+	if (!test_bit(core, cluster_cfg->core_power)) {
 		/* Boot a VPE on a powered down core */
-		boot_core(core, vpe_id);
+		boot_core(cluster, core, vpe_id);
 		goto out;
 	}
 
 	if (cpu_has_vp) {
-		mips_cm_lock_other(0, core, vpe_id, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+		mips_cm_lock_other(cluster, core, vpe_id,
+				   CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
 		write_gcr_co_reset_base(core_entry);
 		mips_cm_unlock_other();
@@ -543,11 +702,15 @@ static void wait_for_sibling_halt(void *ptr_cpu)
 
 static void cps_cpu_die(unsigned int cpu)
 {
+	unsigned int cluster = cpu_cluster(&cpu_data[cpu]);
 	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	ktime_t fail_time;
 	unsigned stat;
 	int err;
+	struct cluster_boot_config *cluster_cfg;
+
+	cluster_cfg = &mips_cps_cluster_bootcfg[cluster];
 
 	/* Wait for the cpu to choose its way out */
 	if (!cpu_wait_death(cpu, 5)) {
@@ -605,7 +768,7 @@ static void cps_cpu_die(unsigned int cpu)
 		} while (1);
 
 		/* Indicate the core is powered off */
-		bitmap_clear(core_power, core, 1);
+		bitmap_clear(cluster_cfg->core_power, core, 1);
 	} else if (cpu_has_mipsmt) {
 		/*
 		 * Have a CPU with access to the offlined CPUs registers wait
-- 
2.17.1

