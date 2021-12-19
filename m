Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA547A155
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhLSQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:27 -0500
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:35008
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236160AbhLSQg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ2xOU0YjlWej5ag12RcZlKRZpOnbLpBpxOKX410wQtWa8csuSghTaGIdjRhrEnRhLM3clLsLp4eNEaXt+RGbZ5xKWDFCKouK8PKHg2vY+L8Ke1fPxfOChRkQn8CG6WDfZdAJUeLxQU/odJ1hcA1L+vJbu3pv3zkWo6iqBbWtzfJOgAI1F21U/BJqx3FfylyQa3+pNuI/KydxQYCZi65fgMZmvTt/+IKOzg0YYAHXL6CFDxEBdypFSd697YKXjcpGjKChHT724AwkeBi/7LX+t4NFjizahAek4k/H7Sil/ES1u1BDbBIu+x5Mlk003vr0k/VYbR0zH6++L0d0f8xDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2U2NKv1TFMPPogbMA/QS2BdL5i+mp1ILjQzAkLh9LY=;
 b=esipFoIn2k4Ggh/1YnISw3JGe1cSEpIH/quQ2vjk0rxDuK1/gTDlqnhH1O3NiUmuIEDWpLib1fVLTT0r9FgB5YntXYXEGI2Sfz0TdVLBAM0ZAYpKJ6SiISyh9lVptZr82WwBfZL9FuAIY25ByvxihBUz+3BPLzuI0S9CjyB5JGwNoSnGbYPogbcr5ZbLcGbkqHOK08k8nIXB4g96Dvy31yJ+Nc1exZqQuCpA8jECSkz0RPBnb2v93d+Eea572w9SBRTdGo6FjufkAwMGTgrXQlxWvl/Y8J/akuBkmNhpOh+OH5W5w16Lr6HjGmludTYHgJnL5gizkqwBjGWBM5+xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2U2NKv1TFMPPogbMA/QS2BdL5i+mp1ILjQzAkLh9LY=;
 b=D8Q9yR5ebmuyXepI76ytq9BvkiYFtaYsmH0fYyDyQMSIZnOyR1KZRkKO50Nto6Y58uPUSuf6KVieCzsDjlgheguoFRPj2xVYPiqtWdY8OXIdLuxwYYqFkwChp7VT/Fi1OBpycydjyhkxfYEdNuNd7TA/T9zQYmX/3ICCo1/Ng/w=
Received: from BN9PR03CA0373.namprd03.prod.outlook.com (2603:10b6:408:f7::18)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 16:36:22 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::4d) by BN9PR03CA0373.outlook.office365.com
 (2603:10b6:408:f7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:21 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:16 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v6 05/14] ACPI: CPPC: add cppc enable register function
Date:   Mon, 20 Dec 2021 00:35:19 +0800
Message-ID: <20211219163528.1023186-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211219163528.1023186-1-ray.huang@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5b4624-c7b1-4426-e85b-08d9c30db0bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4283B152D97AB482696F9E8FEC7A9@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNEy2+WfyaQhaSL37+JfDnY0suD9zy2rJg21ssIRdbR/ivMR2pgh2q6URjTKezJ5UQlq6aD4ESY+hCs9w+zlK0kg76chjwK70ZuRU3f9LrFWFAkfBkaRYjYlkfdMEdtjUAVyHnqEgsvkBV2H7TFdiLrQP6l1zCgFXJYUuPoUfKChSY+mCfRFIEclwZxV6o4k7/I7GUSNkXUDw3xcyaGneaj5S4CurbWQbMLtAeNvVuxb84kKg42DJTRdx6KOqFOKKHcwMMW+d3zsNR+kuPBQUycks4TUHq2JniwESlEwVgwWj3+ICSqJOyhc9Ewh+H7LzJ5CvAfdwKYcogkp9Co240OyzUZZjdlmkB7AyzDGVY7jnXE6+80eIIMDB6cKTO4tj4KG7YxIsMvOb1Ew8igvU+Y9+X98Ug95MA3eHlCphvT8VB7IuI1YecGVbJcv/uvcMvMsB3KXQVXlu+m7LW4M0IOf5QBRSxouRMk/he183kVSVYODLCHtCgHRa01/7r6QaRA/0qYTMFPgsKnaqeZ2D3FJglFsQGBzLwKnXjZvNPrTbf8Ft8xmZAFO6SndPBEASYbhIQfYvNPJKcHmvwv00kkZNpCUnNOCofinsHXdg9eXR2eRxD0ioVAQTTLc63iVvBZ2F4i/GX/q8vpvQ+RNccESuLsQDxxH6u+riJeTQwUj3owqzIWIT5PjRPNCnl5fedJLcvuJlvtmSUZLFt7el5BS1BxdQOjt/lANDA9hqUxm80wCr/JGqVabf0e7lVlLlrm4PdjfI5AYpD2DERqTLRtVot9IH+WrMHAied1GJOY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(316002)(83380400001)(426003)(336012)(2616005)(36860700001)(2906002)(54906003)(86362001)(110136005)(1076003)(5660300002)(7416002)(8936002)(47076005)(26005)(4326008)(40460700001)(70586007)(356005)(36756003)(82310400004)(81166007)(7696005)(70206006)(186003)(508600001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:21.6525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5b4624-c7b1-4426-e85b-08d9c30db0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinzhou Su <Jinzhou.Su@amd.com>

Add a new function to enable CPPC feature. This function
will write Continuous Performance Control package
EnableRegister field on the processor.

CPPC EnableRegister register described in section 8.4.7.1 of ACPI 6.4:
This element is optional. If supported, contains a resource descriptor
with a single Register() descriptor that describes a register to which
OSPM writes a One to enable CPPC on this processor. Before this register
is set, the processor will be controlled by legacy mechanisms (ACPI
Pstates, firmware, etc.).

This register will be used for AMD processors to enable AMD P-State
function instead of legacy ACPI P-States.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 45 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0c4f7005818e..6c0a55a17dfc 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1268,6 +1268,51 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 
+/**
+ * cppc_set_enable - Set to enable CPPC on the processor by writing the
+ * Continuous Performance Control package EnableRegister field.
+ * @cpu: CPU for which to enable CPPC register.
+ * @enable: 0 - disable, 1 - enable CPPC feature on the processor.
+ *
+ * Return: 0 for success, -ERRNO or -EIO otherwise.
+ */
+int cppc_set_enable(int cpu, bool enable)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *enable_reg;
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -EINVAL;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -EINVAL;
+	}
+
+	enable_reg = &cpc_desc->cpc_regs[ENABLE];
+
+	if (CPC_IN_PCC(enable_reg)) {
+
+		if (pcc_ss_id < 0)
+			return -EIO;
+
+		ret = cpc_write(cpu, enable_reg, enable);
+		if (ret)
+			return ret;
+
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+		/* after writing CPC, transfer the ownership of PCC to platfrom */
+		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+		up_write(&pcc_ss_data->pcc_lock);
+		return ret;
+	}
+
+	return cpc_write(cpu, enable_reg, enable);
+}
+EXPORT_SYMBOL_GPL(cppc_set_enable);
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index bc159a9b4a73..92b7ea8d8f5e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -138,6 +138,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool acpi_cpc_valid(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
@@ -162,6 +163,10 @@ static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_set_enable(int cpu, bool enable)
+{
+	return -ENOTSUPP;
+}
 static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
 {
 	return -ENOTSUPP;
-- 
2.25.1

