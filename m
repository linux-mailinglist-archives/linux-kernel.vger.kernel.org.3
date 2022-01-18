Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635CB491EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 06:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiARFFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 00:05:36 -0500
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:26720
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229475AbiARFFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 00:05:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJCTAxRC5yHN+CgiWkCDXEYdJB1zjCV/pirQ9XXCy40nvpc3oHX7S5Oum6PzQC36lOmS8umie+1pXOVlHafAfh/D3y5iYui2CepHhwh1cGqoL0WOJ2wrpQ4AwLe6l9jSkSM5ZRvk8s3bEFFc55Bz9yStF472aL/juuor5ANq9DOhZhsQJdOuUo5xrDbZDO4qdHQoTnTdufQDUm4l55Q+IsnkvqIM/U5ysoPvuND7isodLVVG9Qjd5M2hlxPgtvyIyx002RtEgr2ILFBSmZXmVOfeJ7IHm9dVsVjatUwcrfrJIoNlKi2EamG0IeKrL+r6b6Vem+2rKVT5Khin6xIgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qLSLJRJBgq4INi0AzQ9eBxM8AO+2usbpFfvC5+WHR4=;
 b=aNC4C4jSbuSyyBbRkdh43tQfK4SloCGYF9AurJL4/dz4omx9dqSnNxqRr53FI5Rx1LFpjk5w0b8zhqli+v0BWJpPKMOEbMIKTKrJPzQO6mstdjZFwwVwvjWw8gkdDLW2t5E1e93d083AxcRwhP980NExCSRshzPuczdUNH+p+likSrgEw8AGJHRSRE/bHHgsvcR+hV5daboouc8G3sJVoKj54av21qEHWBbB22kzZ7eObB9I+kYiWFyAoCCs7mLz7+uqS1ePxjs9Uqr3H+33HzYkwxt61Rhs1NbSq81R/EkfwvOBGo9Ltzeen0/Dt8mqh7U0vf0uA5VvT75Jxy+3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qLSLJRJBgq4INi0AzQ9eBxM8AO+2usbpFfvC5+WHR4=;
 b=VJKlz1WgHS/1YQobrRrdZJF+mzpO+cvUOVzQACosmEbZclPMtr/jZmnhAdekgkG4DPA7Z4Fc21uLMIwuhq8Dx14SbZI0LmzRndlfAZerMLcvDisFkB3jb5hNeQ8R3prCGEaxU+5GrIhByeXcAZ/cebT+DT+iPPqBj1edxgubJXM=
Received: from CO2PR07CA0076.namprd07.prod.outlook.com (2603:10b6:100::44) by
 BYAPR12MB3512.namprd12.prod.outlook.com (2603:10b6:a03:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 05:05:28 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::c3) by CO2PR07CA0076.outlook.office365.com
 (2603:10b6:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 05:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 05:05:28 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 23:05:23 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <srikar@linux.vnet.ibm.com>, <riel@surriel.com>,
        Bharata B Rao <bharata@amd.com>
Subject: [PATCH] sched/debug: Remove mpol_get/put and task_lock/unlock from sched_show_numa
Date:   Tue, 18 Jan 2022 10:35:15 +0530
Message-ID: <20220118050515.2973-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf6dce43-e396-43b8-e8c9-08d9da40250c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3512:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB351225B0E704A35B1FC75E7CB0589@BYAPR12MB3512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6y6azGAhw7FhqYueKmyieq83yK3VgdKm7q/m5f9LzgBycU8s6oWSwXOl63nVnDgf4mJfoaRq+GMMkQNNkHNrZQeIragm5HPH42e6FmJZT7+PnBSxtZypSjjwS17mITBqycw0Fr+eIlKIE4QGm331SGsUCr2+ZwwVrecRz15fTgQdE78ADeALS5bwn3t+6au2JwuOKokxIFPv5Xmg9PQkWosCwA92sqBhf9BHfxoiIDJXQogjIhNZiJ+UKTXPrcUSAsfXNZrzxEjin/qQfR54dyiZ6BKoJX1SVztikjsibpTCUl2GwI0xYsXTyrbiKuCikM6zrnrKvPI2o1ONjyXb9vnMGKclqLJpD7t8r/yzhMm4QZE69+63A5GoEKeY9JyLbAPQWojIeGtKKNNY3zR0meWid+CTh2QLSOzP1vVZjVky9Lyv1dhqhd9tsuTiPaXV4QPCE5RIvIDreYv0UnGpLfy2r+SOtsg8mwPZfImdkD68NXiVovNb9tuYBf07jjLs1gLeEjGGloNhIls9j56RGhqNG/0r6j5RaXct/y4HbuxP/QfH/Xq1nmhdN+qSotARVPVNETFSTC+Nt46FxFzKPbXOjuQ1ssb6FZZlaedEmuS5BMiz0cBB3S9dHG1aIPtqqNMusyZKy7jyZ77TNtqtkZxaRpOqFh3UZ4ChYjsxbn1YwAYR8MjfIa3z4CwivduGvXHTZXyjPEidbymAoNoVA+e04DmFPsAn2330eQSPvqGb+au0mO0wsyfI7QtfrbzwWMe5fxaVdHRQsBtcHpLhfiCci7bi2Kel8I2j0xS9EZs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(5660300002)(82310400004)(70586007)(86362001)(81166007)(336012)(40460700001)(2616005)(26005)(316002)(4326008)(36756003)(70206006)(1076003)(356005)(54906003)(508600001)(83380400001)(8676002)(7696005)(8936002)(2906002)(6916009)(426003)(7416002)(6666004)(36860700001)(186003)(47076005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 05:05:28.2282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6dce43-e396-43b8-e8c9-08d9da40250c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The older format of /proc/pid/sched printed home node info which
required the mempolicy and task lock around mpol_get(). However
the format has changed since then and there is no need for
sched_show_numa() any more to have mempolicy argument,
asssociated mpol_get/put and task_lock/unlock. Remove them.

Fixes: 397f2378f1361 ("sched/numa: Fix numa balancing stats in /proc/pid/sched")
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 kernel/sched/debug.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 7dcbaa31c5d9..50e05c8d0d61 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -931,25 +931,15 @@ void print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 {
 #ifdef CONFIG_NUMA_BALANCING
-	struct mempolicy *pol;
-
 	if (p->mm)
 		P(mm->numa_scan_seq);
 
-	task_lock(p);
-	pol = p->mempolicy;
-	if (pol && !(pol->flags & MPOL_F_MORON))
-		pol = NULL;
-	mpol_get(pol);
-	task_unlock(p);
-
 	P(numa_pages_migrated);
 	P(numa_preferred_nid);
 	P(total_numa_faults);
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
 	show_numa_stats(p, m);
-	mpol_put(pol);
 #endif
 }
 
-- 
2.25.1

