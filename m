Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDC47EA04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbhLXBGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:06:03 -0500
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:21376
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350551AbhLXBF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:05:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Oc2/ogtyxb1X4OaMV5tdjpdsVfslmWolhMyJIVjvm7vyG6k0GFIaVFWv4D4xMdkZxuY8j5PP1fBWnR1R7llwlrFdIyvBbVIB+uXgGACzIBST+J1HtjDBbNoOPQMwJlG4ahWvBXHRj9t5aQXZXD9YDvw+pQR0CnQjYBpAMI6xNm61AvNy1k4GPDR6QpnjJ/QJSRhedWAK7Dmpg0S8IljeZgyO0MDDPJEYoYVFxUK+Lym3cw2Dhx9iqU+jYLRUiOxgEtRrVjLDnmC+YCJrqJPFe3z+SRKdueaqPfE1IsOzsanw14a0+V8BzkCbxKYy958QfFQQH0FqOXUZKDV2Vbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2U2NKv1TFMPPogbMA/QS2BdL5i+mp1ILjQzAkLh9LY=;
 b=BjTvKt0ATd7X3cX+PFujJ6Y30kRFvOGirdFBYI7wg4YuWmQ5RAplwDhB22Yo9n/nM3psuDKF5oasQWA6TxEMOEOa7r6td1EnLlANo5EsEli1GAORVN4aiAltOito2PmKU/ABo1MY9yvkgvVRzT1Wt5mZXRH/PGYJHhh9rb1cxVYQcHtsCvEO614cg+30rwBH8qAyz0HwJqil8DeV9t/OTNatgXt4GrSe/ImdCIJ74YFhDbte12pmQ3VCOxE3nBmQnzSdw4kxsJ3Q4SksjkomddlIFlyQO1FdTD0rbp5Vd5Bmp4vR/9pwAIlMWClgMpKvLXCPVy22NHQrys8UTDNnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2U2NKv1TFMPPogbMA/QS2BdL5i+mp1ILjQzAkLh9LY=;
 b=C3/6PKcQ1KClDRmc902UiUtMwYA+sora0WaBieRQbPlRhEbHaXkSCptHhCQ9JhHuyReqHmfW2EwXYgkdVutORq6zN65qt6ROkTlg9FqVzgtLpVesrc55uGRoRP/fBJSwfG1czLQvU9VdiruDBjmhxd/Noxu3L62NT7gH2x8PXyk=
Received: from DS7PR03CA0256.namprd03.prod.outlook.com (2603:10b6:5:3b3::21)
 by CH2PR12MB4645.namprd12.prod.outlook.com (2603:10b6:610:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 01:05:53 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::5a) by DS7PR03CA0256.outlook.office365.com
 (2603:10b6:5:3b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Fri, 24 Dec 2021 01:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:05:53 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:05:48 -0600
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
Subject: [PATCH v7 05/14] ACPI: CPPC: Add CPPC enable register function
Date:   Fri, 24 Dec 2021 09:04:59 +0800
Message-ID: <20211224010508.110159-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224010508.110159-1-ray.huang@amd.com>
References: <20211224010508.110159-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec3a8062-57a7-4738-4708-08d9c67988a2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4645:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4645CB3FCF27138B53C4B317EC7F9@CH2PR12MB4645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TsJMY24ki+WAbcxXROgIIBu+8tZn48W6McKFfLhKB2EKPDdthwYELHCA0vt4cHdo901qiViYiGEPLwuybMkk9lpBJuavW+Xq0ZjK5lSKvG25pD9MDp6T5lFt6QjbvO8tY29QhcGR+sGs67IONcgu5+pR2yjn1tpicPj1NnHv4xBMq7Xw3vTMd4q4wOGaEsvXFVu9PvsDD5XZi7XfuBNKraizSWofMjBDdL8a30cApL1QZJ9eXyCChojoMl9TIOWN0eyaMdJ2VVpVWJF6OPSjLUARprkM3aGoz4xflWRym7cS8ER+RN1nQYznRrI2Sa+v7yqEsBIcHFk1y9f8uaN18Kq/wrGoK3TgpEm8uV3kn27PaqQGH7v2wOwP6PC83ZbujaeHXMYH5+KufCLUv3HDKxxX1+cPYExObllz1ZB5AgK5+bPhP5c3FmZ0OmWHpboYgS1qFtKFe73Piq9DyI6jSw/etzd/dHOsUhfFOki//lHxqFYpNUaM+IwK5/C194uywHWcYLSgFKMB5jD0ZNFxrh06DNGhXANojJFZnDhOM0QExcYTnGKeTBv1E+fGOuJ8gkSHK91mlPwjIvKWzEhhioV69qwBG5fqZPZWDDI87oNn+YU00nlexD744OQXmAPSsx89G42wg2DJKiKVLI9v/UjeNlgyIu0oempZlM1Kntc5HbaEWE4OIDzIwhSQXX7a36EzdQ1U9QOPfuT0ON5cqrQ+41yUuX9mYMFllSRAFSMd93js4bJYPX/DoULW/jNqjE/RUjfQtADmeVildqoz6cNCnvl/9S3Gi22E8/YuJM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(70206006)(70586007)(7416002)(508600001)(7696005)(6666004)(2616005)(40460700001)(5660300002)(8676002)(4326008)(81166007)(54906003)(426003)(36860700001)(2906002)(26005)(316002)(110136005)(83380400001)(8936002)(36756003)(1076003)(16526019)(82310400004)(47076005)(186003)(336012)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:05:53.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3a8062-57a7-4738-4708-08d9c67988a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4645
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

