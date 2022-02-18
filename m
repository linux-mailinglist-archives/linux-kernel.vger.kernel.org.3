Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950F84BBD72
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiBRQ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:28:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiBRQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:28:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF022613D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:27:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFtLBEa0V/2w1dLyBI2+iqTane79zyrkTHhZPAeHOixHCOQvP/NnDNM2uloQFsGo7A4iqFXMMZGIfx3CmwQN1zRD8rwgmMy2HQ9a5yH1UezdaDl58Xb8B4PxmEXavBO3d80Wwb5QTegePknbyUCVZR0MMNOGPixZ/Ne6K2DU9FdooNK7VsyLNjTkU5h/YcJqLyyi+miZ/tkGIBis5TGpMRj1IKQnSH3Q7QLO/zyqyXH8Bje5HZijA4S4HiKwYLolsed9dgyG6E4hO0i1yroNw6Tr9eJmOhpWFmK1AzIAPUSz6rPimi5VopbgLDqzwIIoSeHdcEgGJSh5VWORRuYk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBmi1uWzWtMNPOuT+YTV4RcbUH9226MFUUWW+aIzmBY=;
 b=UCv8WRCTs38gPJhC4vVCzvrJvgXH95vLJJDUiLn9qBjFT/XcDFHHNlnpQucF8e0X9LeA7gld603JoHC0dudp/TQiHBtqA/TzQZluGi0YyvSU3bLb+xFij/E+uWGJ6MjlvEIT+p5vnOZctc4Tg4y1VPILoQQpLTJMaVciwmZ8PvhSS7XKeE0kMol9C09HyZ0z8oMaWG1P3MF1U2UOLoND0YLkiOcnuaqY3+WSx9BsQ45srWOQUZ4DCe1wY9bMGSKhrQF2EvXhJTXGojSOiu1v1jqKYj3wyxnCQ6wo5ft7CaNBrSanZ7CtuEgzLyFTHPh1XGI9EVTIVvYSFBkMAmFwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBmi1uWzWtMNPOuT+YTV4RcbUH9226MFUUWW+aIzmBY=;
 b=GYFlxEWGFU0AW8V0IRUXYlwHpg9XrTyA7ElY7wTfGrBkXcP/EZTEdWDGKPTk5XKgQ3/ATe+WH6x3Dr5bz8no8wpjo0MwV4hHZV7F7wgE/3fkeq9LvrQE75MVgfJ2HyCQvRq3EJJEgeyyuPB7niKa0AXW7y0REzEx6eoiFbfWRu0=
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 16:27:50 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::3e) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 16:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:27:49 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:27:43 -0600
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <peterz@infradead.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <song.bao.hua@hisilicon.com>, <srikar@linux.vnet.ibm.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>
Subject: [PATCH] sched/topology: Remove redundant variable and fix incorrect type in build_sched_domains
Date:   Fri, 18 Feb 2022 21:57:43 +0530
Message-ID: <20220218162743.1134-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f3f57ba-1189-44a0-f0a2-08d9f2fb9af2
X-MS-TrafficTypeDiagnostic: MN0PR12MB5931:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB59311AE69EB1BBE0564E109C98379@MN0PR12MB5931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RnuuEj49xNG1kM+EyGox83BixjuiFzhwfeXhmF6fcIJEXWDxxksqpLtJMZlw+FVKnHe+O9dUx46ujSm7S1UgKJENQSgpplROhDxGsqNq9Wpp/xB+t6fDsLIDh5oPfNilJXD6y+D1ZzyhzvmjJ3sMcVYUnpUvlYBjhOC/Cka4ksQ2Bf2VCLzf+cccoFIn4W5TmKV0MJLRQoYHuCArXh2gD+UHYGg+zGU85E1u51VDSQNhilf2g7qBftCmTxKG69u89d4uG1HoiM171b3SvTojkdvNw/s2ao3Bo/G5/sVnU2oi6d11H2KvSgTWCFHZVs5slMhjy1THfi5nWoETb3EKyeLiLWPAHF1YF6QEugso861mLWZW8PQSDwQQJTbSyTM+fW93xVT++KdYEx2fIUcAuh43PXZZZplHdYFVK96E93lbN+CbG24Y7d91I06gqdtJQy8VrlqUyKrVXrapvV9/r+GWsHIKvUN2hh3xxO0VUJRtDrZsuHT5j/Fxcn8vQH/JIXYzV+EI1ri+jjId6LgIc1mnShrAZ58KMrEdXhEojqQaJcX6y7gZsNB1tmvRzSptky84FvjChZ0HujHrUvyqLb+IerHNbeJ3UACnHYgrSbpJk44P1AhOOKV9Psm/pvTbvIo1+WU2z/8GPQ4Fa8+Ood6V2811LPhYtPwciTnWwDgdaKt+JWGZa0YhOoJp85ICj2ae3aYOlwEyK2VGmnhOX/+PtWprRdRv06u7SrtWHYA8XdrX+10tp7iTHlJbKpu7UuAVLqvi6/3lvi/5TVYKEzRyMOJ2eSP6VjeZ2Q6Axo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(2616005)(1076003)(426003)(26005)(82310400004)(186003)(336012)(40460700003)(70586007)(6916009)(54906003)(81166007)(508600001)(316002)(356005)(7696005)(36756003)(36860700001)(966005)(70206006)(7416002)(8936002)(2906002)(47076005)(83380400001)(86362001)(4326008)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:27:49.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3f57ba-1189-44a0-f0a2-08d9f2fb9af2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating the sparse warning reported by the LKP bot [1],
observed that we have a redundant variable "top" in the function
build_sched_domains that was introduced in the recent commit
e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when
SD_NUMA spans multiple LLCs")

The existing variable "sd" suffices which allows us to remove the
redundant variable "top" while annotating the other variable "top_p"
with the "__rcu" annotation to silence the sparse warning.

[1] https://lore.kernel.org/lkml/202202170853.9vofgC3O-lkp@intel.com/

Fixes: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/topology.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e6cd55951304..4b757fb8f661 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2255,7 +2255,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
 			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
-				struct sched_domain *top, *top_p;
+				struct sched_domain __rcu *top_p;
 				unsigned int nr_llcs;
 
 				/*
@@ -2280,11 +2280,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				sd->imb_numa_nr = imb;
 
 				/* Set span based on the first NUMA domain. */
-				top = sd;
-				top_p = top->parent;
+				top_p = sd->parent;
 				while (top_p && !(top_p->flags & SD_NUMA)) {
-					top = top->parent;
-					top_p = top->parent;
+					top_p = top_p->parent;
 				}
 				imb_span = top_p ? top_p->span_weight : sd->span_weight;
 			} else {
-- 
2.25.1

