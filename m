Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B925533C62
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiEYMMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243395AbiEYMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F1338B3;
        Wed, 25 May 2022 05:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn5yy9xo66EZCWim4dPCL4k3oXoO7IoISXY9f6/3NaS498FsbHSTv2djWZEYr23baiJlt3IS4lOfzPgZqnC46Ya/PAWHMd7XqWIAApVisyLtIL9IW8HuybZdVk1ApIodWaRzifk1SsYo2/OsEx+572HzQV43dDf2eUGMlb6p4pIMc0lzJZaa2rZLb9MX4L/acHuQpJdVPLchFEuJZmiu6aHeqOKIEKsZVcDQ+evObNLMDALyEUzixUpAfX4FBgvd3w8zFYAEfumaqDFVz5+Ik3YsqpeO8yuWG46IBHXU9OjOAbQnvZ90bWIShIAmr9/+Sx5nvajKGxmLn+HD34UEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPxdCmC+WM4EtAb7p2VDGMF/WDygPNKARXVV4JvNRIM=;
 b=WiKvcDrw6/FjL3RYefH9OAHKoFdHvRpa/OW84knSO8i1zc+UIJIvI+sz8XxLpksHGeh8RNtn/lTT/0aWbCDYEsinv7XbpJVyBuwXXRn5Yy0B1zoR/enpuQgVieAQRJBMtykHP1Diwxr9Z4ojUUhcG0VP91zcNi4z44UayuNToexrI2IgeY9wtq8eSu7A+xnsKd4B1iOPI26xP01BBbU57jxNA03k94pWkrzn0wpf5OZz3oBqDKMSvHWEDEGl/m8Ppy8xxkU5YhC+91uo1nar8OrzQPYuGWc4e0flHMlSoVvH6mM4nM27skQi639+7E6kiqHKfFFb3ypLIN8IEV7mCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPxdCmC+WM4EtAb7p2VDGMF/WDygPNKARXVV4JvNRIM=;
 b=QYPRTO7LxL0ROrinA7ib5mkCMFC8IS6fjWGaNmOQkzpCKuclC24M1T0gjNXYD6vyVQ21V2qBmpH9DLI4NEnZcmfWaSDN5H92hnKr9jZxzID0Nj9pN1mYBrbCO0SKGlXX0rtlKEOBI2jyd5iTb6rybRlhHcczlexrs8b+pGx795o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:58 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:58 +0000
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
Subject: [PATCH v2 09/12] MIPS: pm-cps: Use per-CPU variables as per-CPU, not per-core
Date:   Wed, 25 May 2022 14:10:27 +0200
Message-Id: <20220525121030.16054-10-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 566d64f6-4257-46db-43e1-08da3e479f24
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB7859D99CDCF425DC1B8CF695EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQLhES1TjwucpvLrc63aXoV3gPKonOpCoic6P8FmLlbO9BBQfmkZw7Fp1fGuf6eNmCOeiPTTttinGMsBNPO3U5Isg9n4VU9WkjTRuO2UGYugzbSnyfwBS/UY79Vw2phWFsRkb10ZhFL1JORBUtKN41gZpjh1lmItM5ZiFtRARSw+VydKn3xulrZB9KiBjK3GHkqfzxTwa0WqmEVihwQW2ZXvXHa2spiVGMfqgGDIjQUoSJLKm91FUWoCnxsKbgMuwAuxZsKNMFr+Etpes586CKFuOiDuKK+u3mozBPoN/mjJ7DM9I/wXX9tWAnUC1mP4eAnRnamAt20h9rGYm0vBPLt2h/tfEdZCu6iaAgOWZetDPyWr4iXwuhU7b667NMaObGIzfrj/CfT1dTuxLo/OMtwxzdyaaN4oKFzn0NI2jFYep4if6ybHRHD5s/NjDNKv0b2OTl5kBwU830rzG6E1dEqOsTltmMKBMKYsgVty289ZWV4Rf+hAyJSKbfJl7hKK0aJVDJDTSW4xfmZiEUBfwmGSgfPDR+Rauqs0lsBVzAjSDzrd8ZrFF9e48bqcNYq8wOiu4fjFAh8npxsMeQwZRY1aMdnxRX39NPCUAXHM+4vrX90h33RWEGiHlbJf4+6MoRJ1j2t/uzVAS8v/HvFkv+QkiNl7KNgasNIqirdqFQmrSMFhX1EVwXPkQii998TswgLf87FrkFjwMV4/OYzgUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(396003)(136003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YOdZH7VSOzYWbbAqeXXL6jWeBjYKOhf95ygWOURgPvTCuvE7rYSrHfn2Nls2?=
 =?us-ascii?Q?U43cwnLGcXfPe3uzFLCNtBSkNw+SucBU55GBF4tyWvE/6jro+YsJfKgJaR3w?=
 =?us-ascii?Q?r7DLY3v12NC29o5ET+J1iHLYRx2sz/Cd8UJrGyKaCymcEOVoU8iEBseEjkwb?=
 =?us-ascii?Q?hyzRk5Iz83jXv1539c2/CBRIVMVJQiPzJSmXi8qAGWFlhz6WHRa4ctwhois3?=
 =?us-ascii?Q?urwE9/rE2XfHHcQtN39CxykCXdf3trIWGmmA7nZ0uWN07MyChYyBoIAIoCnA?=
 =?us-ascii?Q?Y/Yoc0vx/fHRJGnx/aMIMxT545q4qNU+8ExQ3ZCmSFbCGmwZ2ByUR1XJwKoo?=
 =?us-ascii?Q?psJVOWrjcT/s4VXHK/GfKBbuRMu+gqooouXbvO5ssCPt9k1I2F5pz0a3XV7s?=
 =?us-ascii?Q?iM7fvDXJkCifX6aOv4J54ErvFo8dh7x19gRPxmc3ppi1x4XejsMARo1xTU4h?=
 =?us-ascii?Q?QysWKyi/ImuaNEMeL2cZwOOX7Vu+1BdkHUchHWr4GAD8+5+7cmmWJDtKps9M?=
 =?us-ascii?Q?0pKYhttrZr3v5WaYQ985BN7cxPKr4i9sMpcezRCjxzDjFu87/PiP+mtc/LkQ?=
 =?us-ascii?Q?a+RTheLPxMq47Guz3GQy+pRJpmrFHOiahVM31MCLTQwcJaQhLOXKe0JmGcNU?=
 =?us-ascii?Q?MGGaiSFklThnil9Z78HIF/XX/1FGkSVzicUl9S+Ufe1+xVXQErQyAdb8hG4Z?=
 =?us-ascii?Q?zQU67+4B/iteb/tYiqdLOw4Jj8dvDrEMuadFTgld/n4rriE3WfIUdBPk5huz?=
 =?us-ascii?Q?IcefLjP90O7P0QDuZP0HpPKfOiMzUl7I/eK4jpiCWBkN2VlrYnihRSjYJnQO?=
 =?us-ascii?Q?+1XPnjjcIJ2uVaUGQus85Z9iyYaC+obl4PeczHneahoh73XRRKW43dzJ4/uK?=
 =?us-ascii?Q?ADf8L2Poma2kP76Qp8Bf0JZyNUn3MjBkIVY7ivcNRBRkrfKCC26fU0f8VnM7?=
 =?us-ascii?Q?uo3BGTsF/LXVaSs2k+NV/0VtMVPyIgch2JmZm94nIVr82J0rZytVDWo/X7TQ?=
 =?us-ascii?Q?0KGGQ8G2XP9k03OenZKea4ppeESB7ni7mMHTF1Z5Hwi9OWucuOVsta3KlZ0V?=
 =?us-ascii?Q?O9IoT2up5ELzR7f7HN4rb8xPZCLNzmaArxVulKEK3lDwzDv6S4feKhpMyEmr?=
 =?us-ascii?Q?ap/7xIs+py2mDs0Dzx/NjvAZMRo16IhUZIle2hQcX6nxUsXYHeZNKcFM9fvC?=
 =?us-ascii?Q?iPTTS5KDvU/V9ZJFH+6+YrUlm+9TxviwtVGaFbilMYDtDw+j2hr8xA84Q1rr?=
 =?us-ascii?Q?/yZ2KBnRXAWYEzlhE8HQ/nU52zq5knpYa2hXJKEEssSxVwnNhAjTBKp19g8U?=
 =?us-ascii?Q?FO7j5pXFk7nAKlf4aiVaK0t+vUzjw2IsWWirFz33iUGtGTHJMuRKnUsqHj1+?=
 =?us-ascii?Q?B3sCVrqNBz+yWK1oPOuMFLtfL0MLlPdGOwS5PWHoqko6yemAYIvntElME4PQ?=
 =?us-ascii?Q?t85HhGlNFy29YtwK+lnP46e/GOSCI6+zW//IYLj5kTLF9L2s8SD/NzL0kf5c?=
 =?us-ascii?Q?dR1SJIJxjaRpQg+Kn0XoK5qAHh3lXDLQoH/ZuWYdpwRorzczqXFVjz3y7kuY?=
 =?us-ascii?Q?j/Q38ZIC7hU767j6iFXyNamKAIpFnD4yXKGAlXRuorZOebUYD/r4QSagNwj0?=
 =?us-ascii?Q?6UczmA2kuvf9ejW/PwZ0Ze5gylbIOlksNm2iXU59N81BgwenfWlaNVYoDQEJ?=
 =?us-ascii?Q?N+7hzVthrU03A38dQ1s2HAHABC/VOX/fBZmernvb5ZrgSppXPtGTFG1+kOq3?=
 =?us-ascii?Q?IqBVyEpDQDcI0EKFvjykuohfQflu6lpIV9jt3rwFFKkCm9TKGgJ6?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566d64f6-4257-46db-43e1-08da3e479f24
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:56.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZTmhp/x3Gsk9SRu7o/nsuL9KTiWlFIMqs+in6gSNtoUpPvCtevcklsgm9MdTiWGM1pt3d/rYzhNr0jH1JQt6Bata218nERQZtudDmZ/0Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7859
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

The pm-cps code has up until now used per-CPU variables indexed by core,
rather than CPU number, in order to share data amongst sibling CPUs (ie.
VPs/threads in a core). This works fine for single cluster systems, but
with multi-cluster systems a core number is no longer unique in the
system, leading to sharing between CPUs that are not actually siblings.

Avoid this issue by using per-CPU variables as they are more generally
used - ie. access them using CPU numbers rather than core numbers.
Sharing between siblings is then accomplished by:
 - Assigning the same pointer to entries for each sibling CPU for the
   nc_asm_enter & ready_count variables, which allow this by virtue of
   being per-CPU pointers.

 - Indexing by the first CPU set in a CPUs cpu_sibling_map in the case
   of pm_barrier, for which we can't use the previous approach because
   the per-CPU variable is not a pointer.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 9bf60d7d44d3..a7bcf2b814c8 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -56,10 +56,7 @@ static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
 /* Indicates online CPUs coupled with the current CPU */
 static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
 
-/*
- * Used to synchronize entry to deep idle states. Actually per-core rather
- * than per-CPU.
- */
+/* Used to synchronize entry to deep idle states */
 static DEFINE_PER_CPU_ALIGNED(atomic_t, pm_barrier);
 
 /* Saved CPU state across the CPS_PM_POWER_GATED state */
@@ -118,9 +115,10 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	cps_nc_entry_fn entry;
 	struct core_boot_config *core_cfg;
 	struct vpe_boot_config *vpe_cfg;
+	atomic_t *barrier;
 
 	/* Check that there is an entry function for this state */
-	entry = per_cpu(nc_asm_enter, core)[state];
+	entry = per_cpu(nc_asm_enter, cpu)[state];
 	if (!entry)
 		return -EINVAL;
 
@@ -156,7 +154,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	smp_mb__after_atomic();
 
 	/* Create a non-coherent mapping of the core ready_count */
-	core_ready_count = per_cpu(ready_count, core);
+	core_ready_count = per_cpu(ready_count, cpu);
 	nc_addr = kmap_noncoherent(virt_to_page(core_ready_count),
 				   (unsigned long)core_ready_count);
 	nc_addr += ((unsigned long)core_ready_count & ~PAGE_MASK);
@@ -164,7 +162,8 @@ int cps_pm_enter_state(enum cps_pm_state state)
 
 	/* Ensure ready_count is zero-initialised before the assembly runs */
 	WRITE_ONCE(*nc_core_ready_count, 0);
-	coupled_barrier(&per_cpu(pm_barrier, core), online);
+	barrier = &per_cpu(pm_barrier, cpumask_first(&cpu_sibling_map[cpu]));
+	coupled_barrier(barrier, online);
 
 	/* Run the generated entry code */
 	left = entry(online, nc_core_ready_count);
@@ -635,12 +634,14 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 
 static int cps_pm_online_cpu(unsigned int cpu)
 {
-	enum cps_pm_state state;
-	unsigned core = cpu_core(&cpu_data[cpu]);
+	unsigned int sibling, core;
 	void *entry_fn, *core_rc;
+	enum cps_pm_state state;
+
+	core = cpu_core(&cpu_data[cpu]);
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
-		if (per_cpu(nc_asm_enter, core)[state])
+		if (per_cpu(nc_asm_enter, cpu)[state])
 			continue;
 		if (!test_bit(state, state_support))
 			continue;
@@ -652,16 +653,19 @@ static int cps_pm_online_cpu(unsigned int cpu)
 			clear_bit(state, state_support);
 		}
 
-		per_cpu(nc_asm_enter, core)[state] = entry_fn;
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(nc_asm_enter, sibling)[state] = entry_fn;
 	}
 
-	if (!per_cpu(ready_count, core)) {
+	if (!per_cpu(ready_count, cpu)) {
 		core_rc = kmalloc(sizeof(u32), GFP_KERNEL);
 		if (!core_rc) {
 			pr_err("Failed allocate core %u ready_count\n", core);
 			return -ENOMEM;
 		}
-		per_cpu(ready_count, core) = core_rc;
+
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(ready_count, sibling) = core_rc;
 	}
 
 	return 0;
-- 
2.17.1

