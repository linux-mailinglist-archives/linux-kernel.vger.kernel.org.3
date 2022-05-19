Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49052DD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbiESSw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbiESSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:52:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8535F24C;
        Thu, 19 May 2022 11:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWI+/EX+LsfrqO7Gz20GxK9mLO7DudDBl+PuMfSwvPt4jznOuX+h9aPt40rjV5wOS/A9U6PnSwA9iJpG8GVuC2q8E09lKvxhgIi7rk+mkLf0KdZ0N3mBZvNXwcPySUSTP6ER3/cMe/9CC5OaeWPYUkAKJOF6wo7QMxDT1by65dhSOjH5Uvo9/FN56G1n956qvyrQDSoKhOiTMdgH78nNGa098xy65Zah/PpZpMSoNSmcL/U34G6bLr3VQWRm8IWsCWefvg+L8nzAixFoC6H8IlGNgI/BmOiOhRYIV7w2cVYv8kS8XaHmmBxXY4gm2zN21nLzjOG2TMDDSKydplSjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dFtvrI6cAWIhkP2VikjYEVNfcUS4jClT066YFUgeao=;
 b=NEG4mp98/9hzl7952HMpdumOJel1YglS+lFZh+17LzS7STgwQ8SeXLfw0wVlAooVEXfUtga6oeiJ9Bpvb0yxUm12NdzwNwE+lEqth0bkOllBknvSXSgJla3dWtHR4IqMnBassUi/A/rW0kjzTuwSfrm2tM3Mc4zcZWR/PSJpOTxHDQ/TWPbPWfv5L3OQgE6AleRZDSbN8PQXLQ4kqsMoe0PrtT7TWWegHtiOxCuSgUuYbylo21S6nPHA065vP7REgyugqoAOw7VI0EWvVKAMQibmOeBf1zKM16o94SJlJboIYJ6VS+4CfbqPgNBjxaiwBREgN+NPApTjfWrP2zF9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dFtvrI6cAWIhkP2VikjYEVNfcUS4jClT066YFUgeao=;
 b=eLZh0hNjhuU02zV0crVjPCXP94hLecFWbGDfe15BNTWFBXt8BJbV+z2XIlo84GuczYeuL/JmxMlBhEIpg7+vT+3zvasY/ZZgeo6Q8Vzws38lzzEOBtpW7pd7u1HCoLYfgzohPmGy1Iq6PRbto0396cXNP1psrhwuqwr9Q33WD98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:50 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:50 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] MIPS: CPS: Boot CPUs in secondary clusters
Date:   Thu, 19 May 2022 20:51:25 +0200
Message-Id: <20220519185125.11686-13-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76327c10-5294-4b8e-e574-08da39c8a108
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB25462B8E0A195A8385DA202BEFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6k3P+dZmlD2Rrw7t5+Ar5birB3PU8P5LFXrPCLJE/Wy1Cz10FXHl0vSIaaun3GHs80Ebc3f3qfVwRFxKGPUxbRr6wf/CNNMZUYO/3YUbhxYPs0Dz1yA9JGqmJYWyeggKqGUqG2ORJJ45teP8WuywZau9Fe6Giw2VHrsq0fJogwCK9al/ISrWbrGqhzVfl9tCbQS43rEmIHM8/PEU8myWVqi3UJSRBfGexsBt39KuPpgjxnhWPABDdRSEPthPBKrM0hUcoy6ERGpiIkF/1VG/urLKFXF2oMNCkOJcASJkqwATOlQRlKuvhtX15gsWDKKvrPlQ0aGnE0uOwaoW7tyc7Lun3zGWm2LG30U1YYa6Z7zbXSU2k7X4K63whq3j3Kp0bXF7a0JRBDpLaxqgacuRSNcTCEVIdDwBTHvAKB9EAtCTIZ2TGi6QnhfGCx7Z0nwxPWz10bMuGR8C+F1XupfEGS0SHbVrdFjmHAMmXh5/wMq43cXp0YgLrVKj8aS3BMx/yh1g7A0RtnGcC8R40QasNECdG7Ss+xCb+1lphyySd7a7CO/1R6RyJJxPrvxd4BCqF2F472eqFaX0PAYNutebNUtAeZF1cvTONlGEYa3vXIrnoNKrPEXm5dCQVsBIMusUnkrNC+VWYJc+27yZ0sJFQLOHT9sVizQ0ijjQliqTWD4GxbZIh7nU8lnT5Vmfihb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(30864003)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Ebsq4NGWM8eF3uGU9R3kf4vlZc15rQOHF4WyoD4ZmEXk6zMIHRSv2xKSuer?=
 =?us-ascii?Q?dK+iCIkitcOWpaoma3vTLGzWX2vpCto+8B4QNWKsrHIci5OOumefcP7X3XfL?=
 =?us-ascii?Q?rUUbdelxnogEtX/RRkTE0qzogPLoir8cor0u/sBKm0tfSc/7295WlMHDp4yp?=
 =?us-ascii?Q?3cKjD7uKdskZvn0BEycTUyqyUqXr2NoYcX4lRCOiCoVsIVX6XmaWn8tpk7n0?=
 =?us-ascii?Q?O/hU6Mf99VOf8mAPsLab/EavbU6Hbj4HrNVcbTHOqIz7bnMwQp9Q8rzfoTgY?=
 =?us-ascii?Q?OZsE8mm37IpNotUJmuo0u4V0uI7UWYmMGWlTw40VXs0ceYv4JA6CIA675lXA?=
 =?us-ascii?Q?qLU/HxJ2z8j9B0m9lWNLK2Mrh+GlvmUwH/u8fGYlFwNNcsxac4zXWW9n3c6R?=
 =?us-ascii?Q?Ice6nxtvLcJULd15jCO9cB9r1a7BkQjV2QjWtDaHxhJ0Mag7f4HR/nYUhiIL?=
 =?us-ascii?Q?k1upXGruYHXfQkUTM4brfuLoJTcuDrre7jf8PPfSGkA2qjGcga0uff9c1mP3?=
 =?us-ascii?Q?eAqdMXGqUqg+acYitmtV0REvqmdbwkp4mmdzQouz794i78elBFW95ud8Jnhi?=
 =?us-ascii?Q?unutddNZPOvQtgUMmHkzrgcgkee2OZcAKvNtD7r4+fm8d9w7buh9gOwam9PN?=
 =?us-ascii?Q?TSkEZaqqfc+jqvwUjg1v9mBX8J7n/gJQ/S30o0bFyBe5LAI2rljvxWVXQIbh?=
 =?us-ascii?Q?/5sCPGc2N/PueidTr+AYrOqYiRb821snW7uF+zwf8IdZJBbepDe4Vl7NAhEq?=
 =?us-ascii?Q?x8g5ViilbHBVwr70zfqvp/8qUInk7lehr35NjzUr28/j+yoCDUe9OiOOTmnz?=
 =?us-ascii?Q?L2ymX+TTMmv2/uuAhU1jxcUBeNIQPq+IWRWWabDrApoxWnmQs90l8UqryNG5?=
 =?us-ascii?Q?60wOxkE0KFKgbEWudk4I1UuZpcc/qrGEJsXC/Ls2ijqljwL7Oz6tRDW+6Atc?=
 =?us-ascii?Q?3ldSlx/oEvBAU8Euu/4teAt1EyK0Je3486S9UghfD3mCR2BRC2XXB90fbo/v?=
 =?us-ascii?Q?VREFxXrk9OlrmYH0WAlo2TlBQfy5Wo3HT78lbavanDMoCs+4fJSobAOquwSU?=
 =?us-ascii?Q?AG+Z2bt27KIJTqhCZ5idW0u6z3O89nnrqnHBoDkQ1kbNjfJdCqESP5NTxA3G?=
 =?us-ascii?Q?Blwi6wgQV93QIqkfqdvPzItWo23dWiB0xlrKEdbkzcLM51caWXiBQB28sEZ4?=
 =?us-ascii?Q?u8V3j7bo7GnyEoJXBKL0B6pOv9xr1O4IXQLoHEoAERBDNEjRm//z+agkQSPE?=
 =?us-ascii?Q?G1+pSZISPwAQ2NKCPoNhXBdRbXz+YX6L+RlshJ4H9NwuUHiMJJ/cnA25Nuei?=
 =?us-ascii?Q?74wGG8aTEwABuXEkIECiye1WHPXDyfYYJe+TF3QEhfOEq8ZZfd71vSaYBvVI?=
 =?us-ascii?Q?CiqDll0ZxqQcLQ4lU29cBztQh/y9Yf2Mv14ulMM4qMRy48SnZ5TSR+SLNY+A?=
 =?us-ascii?Q?APH/AUFqBDx3w6oK9NMheo7gz6iMR/tpQ4yI0xcTarStCUW0YN8RtPZBKE8g?=
 =?us-ascii?Q?wRM6yfP+KlfaKEWNLNxXAgXp/7BmRiy3IBs3ZI2yqAlQMWOvsY7iC0lxyVsQ?=
 =?us-ascii?Q?cZty7NP9h3f9NEalDNLB1yEFPG5eMjr5YMyffY769OI5w5Z7b1YHyzCMN4/g?=
 =?us-ascii?Q?JI8hgfI2Q1jlYKOJAUqVD8FF1eqEo9ZaZxfDyHNzAEOe1e5XReqKX1yJqX4u?=
 =?us-ascii?Q?IZl7E2tk2r22CZ/IUqCjLxZZWWHxYRWiGEVhUQHNDChNRxSUVI5ZuZtQFY2w?=
 =?us-ascii?Q?jHFheVd1VZ2MReQ4MG/hBawcTpuWJMMSeWmDMO7opV0Lz8ucz7VX?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76327c10-5294-4b8e-e574-08da39c8a108
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:48.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbSfrhKyj7JhGVnpTOrig7HS4fRgiDZom0wjwraLvXMMNRL45UhIAps2EzXQbXtcpoK51Wyn40osnmB1Y1gXompX4coTZIkCrxLb2/dId7M=
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

Probe for & boot CPUs (cores & VPs) in secondary clusters (ie. not the
cluster that began booting Linux) when they are present in systems with
CM 3.5 or higher.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

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

