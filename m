Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4FF52DD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbiESSwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244135AbiESSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:52:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006E5EBC3;
        Thu, 19 May 2022 11:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzMX4PVBp3M1GAL6URx3K8RoVCfhw391XC5YVkW8LEWz3RWuu8tv0kQXsQ6GK/UGU77fFGKyF+Q+I+hsgSNKc4CFqs5MdBMui0aBbVDi6MvfSe5BDH10K6vOWcNP02XHohvoKXPhAT6EnUiXUizGS2afKvBinn5IlJ9rthZleT69dbFLn8tRP7PeDeXUdmbwFdaDeRfmJuLGt7Fl4B8+4a/o2cXbE4cVxhuv22voclr44ZjMTbpeEZ4TUVzDKYziWrYdLfZm+VzsCRgrfMGKDDq3VrmvvIV2LdpO8PMC0mjW2318KYbrjmwqApRYGBPj346rTRO2yaYWAYzv0foEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C95WrmpzsEvNeDP9qqfswt/Axyd22O0kfW5VZSDWRFY=;
 b=k/Yskhvxd7DgnItT1ty2yl7/40COqI8+2K+eQZMUymiWGhVJH9bPSfw0koYqlijZu5X89EcveQwSajv3g17Zt79LpFE0DJjhPSUxwu44ki8L4m2pMn2W5NuwISlH/kOMftbwDT8Wbm8tzDVBhPblZ2ZN+Yw3mz7B4FnUA+SmnXJS/NbiPGSUg8m44vX+g58Ryinm/jNTHkJlhuwR6/N0/uI3L84boZFbTcMGs9ZqETyrWWA+CL+WIv28f7w2eyNeEp+KlRBYjKfpEZ1bujovRVr65t4BvcbTOZaMg7tkNX3NgyELZVNVTduilfcYrmUe0yb9hwDSJEO9Nl/pmj2eIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C95WrmpzsEvNeDP9qqfswt/Axyd22O0kfW5VZSDWRFY=;
 b=lxHeJ4sHHAy52rScPW2Z99L268nkORFbKdsnF/gJlRTPnsGgD0mpBwmLYpE1IOSi0SOTGUaz7CyqLS82iP2kzmXqZjQeLU/pwXWSiPZCNu6WFEATEdp5XHZ9hYR5RtKBD5qf0cEuR71H1AHtptHxD7OiVJsFuRd/q4hd6RglimE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:48 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:48 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Chao-ying Fu <cfu@wavecomp.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] MIPS: pm-cps: Use per-CPU variables as per-CPU, not per-core
Date:   Thu, 19 May 2022 20:51:22 +0200
Message-Id: <20220519185125.11686-10-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43a7dfa9-c7df-4474-5351-08da39c8a051
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546158BAD2D757607BA3780EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzDlOW1Q3kCiC/+qW+O03R/NmVdhEfwE8TxO43EhgT1FjzQ4kPNcrkxibRqkZ06RDdl36WL+OM9YjL1sVeBxa70zMddD/e9sByJCKmnNdc1SdbRbKUTk53GnpOk8tl6pFv+OYcwTUsa3ZyNs0SmxKnx05G1rRa1wzlCMRrxlzAWVVpCgP4rz5YfPiayinHfaEhsJNAnnKa+7l3BH6q/WeYlapAI83aUgRTMBpNJh9OSuDcraXEl+t0aIGrIfF9Sy6/JMaIZKXx81mP9/YDJq6QXOS95o8A1upU/C/cCb+1vwk6Z9WZZFAW+j6VbDdWzizCN7ZryuVfijLdzDpGbkr8xMzOyQvLvbea0TlJSR0R54LpvE/ht2a20NnEqeL6u/Z7jO+5TEBmJ+dgZRoVGEpk/mWe6sSTCuZnKBCccR+zTO+bqfHkRypwq0i127QguaXRB9e/o7CWFDGArHeOZVat4J9MrKvWusEAmv1DKWCH8rdZBF3Z9+7Jvi4syZKGnYFjBmSKrj7fmaWDyOvD85AbHaLOskhcOgjqQWVMAGo6ACe2mKp8tmlv1PCTfvoDmQwdsk3dmNl05aLLczSIM/lYAFmVqN7ZtdJcDiVN+Pg3/LjkOHS0w8gBqLaC2YLu8J1ejDsqICbwRs+ooqJxmMmjyis+NVFZBgKEFwNlMkA4oUWlATXwpdO/j4KSm7Lewr1uTzyiP6vyIluq8yTNavbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upDKHsiHeavZXxOlXIJE8C3VUq3Q7/3jBhb2tjnD2x7JI3NZb6KKTWxvOWba?=
 =?us-ascii?Q?ipN+5V3JyV3orRStqNcf9Y0Fxl5oL2mdCK8YksykSM7FP2i9w6VsKLE1/vYZ?=
 =?us-ascii?Q?m4fcuO0CMs/zJB3QaoEWOMP9+MniC6dyRwmueji1Lh38dSZxuAPl6uchCBur?=
 =?us-ascii?Q?c/XJj0DoRHgrG6raAvVxuLef0A7SyGKFs6OH7LNcv2KKWLXEzJRxN9rA3oQh?=
 =?us-ascii?Q?3s/KpHrHqgScqfGXuO3fgjaYoFKbJ05/Rb+t5FwQ5Dwxn01I2x3fNqe5ilxZ?=
 =?us-ascii?Q?6p14C78CKNkY8gv/gVlyezk5MXP2kz2204FBQhH2562RFg4/ehqyl19SINsd?=
 =?us-ascii?Q?JK54ZuwUsjERc0qzqXOVOgIMsVQGImi497+YV9MMuimjnYkb/Vlfd19mwqdq?=
 =?us-ascii?Q?/qKdUxX6LfmykPUeC+EFuSiQvPmy3SsEMSrq7UrquuBV6ZayutJts5w+Tnos?=
 =?us-ascii?Q?X2vnmvlylbu4QxpAjTn4Auc8ZdrxL+DieTPuX7YGbwuXukEFbm1WFLmUNTkw?=
 =?us-ascii?Q?67FgXp9H7tS0QXVL/hXwHWfRJRldnsFtaSWbKElATuF0jGzol5RQOqHQ4XHU?=
 =?us-ascii?Q?EiaTeamy1cq9LK2woujR6JeIf7tCDHyvjs9zeBF5BRWT1AC+zUvJDx3ydhrJ?=
 =?us-ascii?Q?MtBBMKUqBddEMSTi94MKZnYhnjhZtOAA5XqgxXJnVgd43ndESK3sRexnzfrl?=
 =?us-ascii?Q?Ehy3fWlR2MUXwW3OHgkgPmXB2Cla4MIofc38RmeYX6CMwkkxvxjo2IA5JDXA?=
 =?us-ascii?Q?h//dgGLDvaGZzFA3NmnPCOoY2ji4wrYveBqm45tc0qSPWoyvw+rTxKC0LQDN?=
 =?us-ascii?Q?2vznPMucwWOfbhqPFfl2Skq7IfDoWspa6567QbvMoiKaoRx25kC+HT4jVyu4?=
 =?us-ascii?Q?/xxw26JUoYgPRU9thFjI9XCXITgkJfnS2kBtXCwIY2hCrzUKrQXugAL8qRnU?=
 =?us-ascii?Q?gdxOt4TBF3/9/1m8kmyy6UDD7qqcJ4nPH1OWiprVZrmfxLEMRlvdOLoPpplU?=
 =?us-ascii?Q?6U187TdddlnX88xFN/TOQ9Xx3reCxypcDKZfjaMHWdBjq4GjG2rY1NcCZAke?=
 =?us-ascii?Q?OLFaolZkvlLV/BFDV9qm20lC8Z07rQFWrugtH6P9r6O4BPnssC35LhveWgpC?=
 =?us-ascii?Q?EmFL//nDqjVdwvJYt4nlM+Us31OEexJlRIvuwcFm9vdkdoe9JJ+OfA066Tw0?=
 =?us-ascii?Q?jWimK+vsFAke2Wo6e7X/PBYjOF2reuTYZubxryV9Ce1SqVR44mJqJX+jwnHI?=
 =?us-ascii?Q?1o2sFERCtS3c/HM8okBVu7XwIBwwfOAhzC/bL+XiKYEVCCGvnN+e6bKAPW5a?=
 =?us-ascii?Q?7fBiCO2fuhoCWs/gwEuABjJ3e3w6LBbADycCslTgSs/z69Cj/nHlfNwnQtD6?=
 =?us-ascii?Q?AgLqsYnRz5PYnlGag7NpLba5njtAQ7zEqEX4dl1TA8lBh+PqLYZfVTN1iK6B?=
 =?us-ascii?Q?s5eWkHSptNxPYdgNBmmwtCWi7UEzUKEuILe46j4FQjzoTdUH8lu8q4hk+0lE?=
 =?us-ascii?Q?B5Rnvpg6Ab08zDRHqk70JX08uLywswNWRjLlJ8WOxM5ILeQ2PdTlU81DueBm?=
 =?us-ascii?Q?uEhxvgSaP7JEezXhaQNFKThzxTkaGD6UGAyPit7heXE779RSrik7nWbD9zSh?=
 =?us-ascii?Q?Wh5KnRb3LdO3HfnBgksmEjKfKpFnDdzDuB0B7XRk/rbWneCpvEEhGyxmZdVd?=
 =?us-ascii?Q?OQMIPtbCMrAEAV7NE5B3igEP0GMNdwj1CqOX5lxIZMXoFZ8hwPJUpT/tI4jJ?=
 =?us-ascii?Q?J9ui7dNTjImgRFNjwr300hLiMC10h1g=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a7dfa9-c7df-4474-5351-08da39c8a051
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:47.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzwZd/l3DsN2FI0pJD48GUML65C/sbhyOmXiTYRfIwHIGhw4oE4akoFBGBv5R5DDNGDIhzkQAGFVsqRojKWrkoXsIJnXMdHdiGJaO4YCwqg=
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
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>

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

