Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12739463484
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbhK3MlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:06 -0500
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:9505
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241709AbhK3Mku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD2tI7yuzSe2hzEKhDB4ib4Dh998LTf0w4ub6o+qnluweaf6yrmHhTk7ANipwznsyquQan7U9i2m71J44NegTOTREIZnemTUsKbpXtI878AlK4nWwI4eVHoli1u5HLu1/pHpo8JxP2oVLLJuNZknCsA+e0MgMezRSW9z+O1Y9KHICJdLuDhhtzM1v/IxsEy/BN5VzmbuhRaBYhxKb6M2k+f0MSiA91MEzwD53U0oxNK34o7i+TNgQ7LiyAGOV1/UhGgKm5ZfAbw04wtTW45TKHVTT+/1NFSYqdiL3N04D7EraHzOfDldxXEfhFelWrxmEwOwzZFYaIlpEB5KF+A5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWkb2gJJa01lVW9tULlBzYKUUQMaGUZN8bXnAgokfoU=;
 b=K6NsLDP91i8Wi1Q8ELWR4X9GL3r1YaPiWNGAkqfjYI3Y68w5hpyLsykm3sIlSRHbbJ1+DLmPWS3ZyRST0qfBfnHYi12dRuAI+Mfxkc5lFRhy5j+kvz9z2ZbMzwKjnCR0hn1HEQSIja+AdbsOgeyjaUSND69Oqdsa/tH5N2qs+nXbgHT79sDvnYmlxWJmTrkwjc4AqjeJaU80eSLFRd/TeW9GEx5PQ0+TFsi8A134o97iY2cMGL6J1/JdcXaZgYY6coXLwm/Qhc+odYgdqGmzDHllpkCqV9vXb++dJP+XOfWXMs+eoZ4WaW9nmOZ3uFinT36vB945tprotVyvp79/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWkb2gJJa01lVW9tULlBzYKUUQMaGUZN8bXnAgokfoU=;
 b=n5aSsGE0r+cIh2taZDlAu3x9nBGquaBjEDsNmllxioqiJC7U84ZD6GRjJ/E2ZOv60hg1LwZUQ+C+A0HWP7TLKNAx5y17aKy5HJ3A+kqSXrfBZr/JYtkRRx9GJ4oWu9ZJ5KEGXhnNxy0In4sK9e+123Z1yui0eK2Yz1Bm6oLrrYA=
Received: from BN6PR22CA0049.namprd22.prod.outlook.com (2603:10b6:404:ca::11)
 by MW2PR12MB2444.namprd12.prod.outlook.com (2603:10b6:907:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 12:37:26 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::5d) by BN6PR22CA0049.outlook.office365.com
 (2603:10b6:404:ca::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:25 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:21 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
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
Subject: [PATCH v5 05/22] ACPI: CPPC: add cppc enable register function
Date:   Tue, 30 Nov 2021 20:36:24 +0800
Message-ID: <20211130123641.1449041-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f959d106-0c03-4cb4-1f06-08d9b3fe29f6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2444:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24442573FECFB77F9EB50193EC679@MW2PR12MB2444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJ5WMdGgwFi+3Ax/aaXlZbhvHRAqYR/uQimtwMk7kkaC1JcYARJGQLFhgfFDMzNKICC87OhHZnHSx+EcRRTPjH9IM5E07HR4ewXn0qr7LUxiA5Yt6vLJCXWq2B7orVANuTvAYi9NsKT2N1M05Jqgsv1d+B3Is/q/zH2ottCWmo1PLs0f1IZAUnKJbxU/pH07BeiLuA01h5v/pCtrpUqB/OIn8cYnWfOjpPdYkIe9AF1futwiLuns/TfuWjwHUEqclQmeHHhuFRGSztuIt6ZXRAMf5Idj6PfW+em5K/CIPfio21uH+/cvvTnGwgIOIk6uz8HB4KRb1kyODojg9pVOeMSr4b/t/5DcyitxtEGj+90y25pC8i5oW0g3d/snvMr0CbeeXnmgZZFEVD7pvVnfN2fUa8uu4DLJWGm4Sf/YIpwD4R1oFOgVWWpgHaaKd+q7BQeO39OJLRLP5EHDuZ6zjpwKWZuVE/exDOCSEuBI1WJHfpWIfheXE5wkzo9CWacwOevM3KCxNipuWT/B3taUnFazoXAUZ+RdLykoWIrt9P97Cd6JB/p4vi9cbcdIeXXgZOVJ87fG/ugNsAbDzsHs9YJ0YP8wrLd/zQYpv7M+2cp27R3id3nnAiNE+8tiNHM+MY5BRhHR4ec9CICo31jedYZyrRzphbtAbFnaPdYElZivhtGa/JlBBxdsEDV/jnyddMzbgPitmGYNApO5c0vojBL4WsDxRRMQ076wRPhHAjmGZArDaeIv39puowZ5FxaYCFvwjJF+Qqe9Vgv1rC9XR3zdZzYnTAZGrIo0J11D6XY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(54906003)(47076005)(110136005)(316002)(2616005)(82310400004)(70586007)(186003)(508600001)(7416002)(81166007)(83380400001)(16526019)(86362001)(426003)(36860700001)(36756003)(7696005)(8676002)(5660300002)(26005)(1076003)(8936002)(2906002)(356005)(336012)(70206006)(40460700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:25.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f959d106-0c03-4cb4-1f06-08d9b3fe29f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2444
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

This register will be used for AMD processors to enable amd-pstate
function instead of legacy ACPI P-States.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 45 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a46f227dc254..003df9fba122 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1262,6 +1262,51 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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

