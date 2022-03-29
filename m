Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E64EA5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiC2DRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiC2DRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:17:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA5939F7;
        Mon, 28 Mar 2022 20:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hajiK7kpX9PCU5CILl2Lvd0sWv5od+07+C9VbXFVjF7UI4Rsvc6RGtRDLK/YKTOg0z+ckIznDPVmn7ZhYleZVANjxQbepVCdIPyCwoql2QUtOGnlMcxAGF1huHgFSVeA3Tf4lFE9F5xOZ6UM/ZyTwKD6Sqxh68kevvWdewYJsP/ZPEK9gW/8N8pEPnMLdwbVZFRajCPx7eR0OYCBUN7utyYq/RVh2JW2z7wbyelT2d11A1jFV8rYOjdcDDhYQwfKMEJVMxlOvgQrpRsb6X0gURZazfTmJbbYUECfgRsNqUf9LtuZGT5mSpymbBw+yeBKqGQ38deG+qXSrs3n4zmTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urjPh8O1vLyhsUrZZgDM30gA29H/WB4kYiLNohpO1aY=;
 b=kBTATrZbslNpMOVRl4enFKZFQgmJYUqfkGZkKJG5CwwoPIBQyJ6yxHxkd8AJzV8xiUaCc/gLft3XbLrUZrWoiTqJjecWIJRpnbyRyZneV7hM2D5zzMoKp/W7ciJzJ4NXH30lnh/LVBpAEB/eTBSby+Cw8qv7LaB4l9g0ilV2kC2Kex/yZzuSnkvAt8jJCIJdfvv8MFcEz/qGXCYkeWbXIGwqiuJ1IZPENHMnh7wzGxPnNaJMvs3dtPA/PGw3lflLoQPuxOD6V2+0NLfql8xAL+4AoA7WpuwE9mzGQ8NhF7xXvO4tsCX9nJNYT0PwU0T9vhlSQHxeNS1VBNu0qV4HqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urjPh8O1vLyhsUrZZgDM30gA29H/WB4kYiLNohpO1aY=;
 b=rKjXOxGWZQnI6iF+IGyFLpDm37z7C5/x5F6nZXA+II9KyPWhR4GGg4NY2eOJnNVo8bctTuaOIu6qzxZxdVUnOy1OHRc7dWsRASXqKvw/Cw5jyqaiPXI3bh7ApDmoC2Tv/e3lZKrdviarrBGJyVIdvMqwnsJ5Gqs2sUnGqPpp10k=
Received: from DM5PR19CA0040.namprd19.prod.outlook.com (2603:10b6:3:9a::26) by
 BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 03:15:57 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::d1) by DM5PR19CA0040.outlook.office365.com
 (2603:10b6:3:9a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 03:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 03:15:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 22:15:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/4] crypto: ccp: Export PSP security bits to userspace
Date:   Mon, 28 Mar 2022 22:15:51 -0500
Message-ID: <20220329031553.798-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329031553.798-1-mario.limonciello@amd.com>
References: <20220329031553.798-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30223fd-b38f-42d0-4ca1-08da11327111
X-MS-TrafficTypeDiagnostic: BY5PR12MB4211:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4211E333AD910A88AFC689C6E21E9@BY5PR12MB4211.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8Z4s0rPKWrVecoo23JPrMk9pSG0pxNiki7oOy25ejSldVuERUtwdPCWiBL2sqMi1ur9Awtv8kcKhpUxnJhUPmM8HmBUALMZUlRjmpb6bWQIN7R9g1Zr7LMrd4fbVSYJRC0z+LuPHhg5395FsjPUMU7kf181rtXD17O757X/Ilil2zgtNdcqg3afPCWsbSxjS9yzEvRwkH9SFallWe8meXoUmlO+5PDGAnyQWxsw5oOMbcvN8TkztBvMLyCoZ+6e4y2keEusq285c6GWYoLLPAyyWUGXn+1SB253dLAKiyGHSA1lq1PHlWBUNFExWHBWPNKXw7fzG50Xse5HoAoScedgykIi7dP1ymfeWPMT1iFc98WwNCAx/8M1x8Qh1a8iFjVGBqeRaT7K0ByYqftsbIxSAWSr+vZLR+qHgwwTi/5cpNn+4NaU+dbXcb3HoBgVJkEouOHYc2OtsVmDVAkSPhTL8hkAtZQbnJh/tzlQjUFhaBQC4ql3ZaYNo86VYb6F153gWZoPbm+DW0VQtBwu7brL7o8CoC5o1GDMoEQHQya0f4LXOq7i49TH2/kr0uzZwTBFqo9wpi6qOk3+1XjdGqYDaQL4HzN8qiaRD7enOMxBXeI3GZGesWcZR2tSZiO0qaeaVCUnG1RLy4pNYzzzD3YuM1E8DlykcpQrjkeWhh74PyG0SvMvtZndbplwe1sPMnCPPmKjKe1Pl5kVthjEzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(86362001)(8676002)(47076005)(70586007)(110136005)(54906003)(81166007)(82310400004)(356005)(40460700003)(70206006)(4326008)(5660300002)(336012)(26005)(36860700001)(2906002)(15650500001)(16526019)(186003)(6666004)(83380400001)(44832011)(426003)(2616005)(508600001)(1076003)(7696005)(36756003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 03:15:56.8248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30223fd-b38f-42d0-4ca1-08da11327111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSP sets several pre-defined bits in the capabilities
register to indicate that security attributes of the platform.

Export these attributes into userspace for administrators to
confirm platform is properly locked down.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-driver-ccp | 87 ++++++++++++++++++++++
 drivers/crypto/ccp/psp-dev.h               | 17 +++++
 drivers/crypto/ccp/sp-pci.c                | 62 +++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ccp

diff --git a/Documentation/ABI/testing/sysfs-driver-ccp b/Documentation/ABI/testing/sysfs-driver-ccp
new file mode 100644
index 000000000000..7aded9b75553
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-ccp
@@ -0,0 +1,87 @@
+What:		/sys/bus/pci/devices/<BDF>/fused_part
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/fused_part file reports
+		whether the CPU or APU has been fused to prevent tampering.
+		0: Not fused
+		1: Fused
+
+What:		/sys/bus/pci/devices/<BDF>/debug_lock_on
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/debug_lock_on reports
+		whether the AMD CPU or APU has been unlocked for debugging.
+		Possible values:
+		0: Not locked
+		1: Locked
+
+What:		/sys/bus/pci/devices/<BDF>/tsme_status
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/tsme_status file reports
+		the status of transparent secure memory encryption on AMD systems.
+		Possible values:
+		0: Not active
+		1: Active
+
+What:		/sys/bus/pci/devices/<BDF>/anti_rollback_status
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/anti_rollback_status file reports
+		whether the PSP is enforcing rollback protection.
+		Possible values:
+		0: Not enforcing
+		1: Enforcing
+
+What:		/sys/bus/pci/devices/<BDF>/rpmc_production_enabled
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/rpmc_production_enabled file reports
+		whether Replay Protected Monotonic Counter support has been enabled.
+		Possible values:
+		0: Not enabled
+		1: Enabled
+
+What:		/sys/bus/pci/devices/<BDF>/rpmc_spirom_available
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/rpmc_spirom_available file reports
+		whether an Replay Protected Monotonic Counter supported SPI is installed
+		on the system.
+		Possible values:
+		0: Not present
+		1: Present
+
+What:		/sys/bus/pci/devices/<BDF>/hsp_tpm_available
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/hsp_tpm_available file reports
+		whether the HSP TPM has been activated.
+		Possible values:
+		0: Not activated or present
+		1: Activated
+
+What:		/sys/bus/pci/devices/<BDF>/rom_armor_enforced
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/rom_armor_enforced file reports
+		whether RomArmor SPI protection is enforced.
+		Possible values:
+		0: Not enforced
+		1: Enforced
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index d811da28cce6..d528eb04c3ef 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -61,5 +61,22 @@ struct psp_device *psp_get_master_device(void);
 
 #define PSP_CAPABILITY_SEV			BIT(0)
 #define PSP_CAPABILITY_TEE			BIT(1)
+#define PSP_CAPABILITY_PSP_SECURITY_REPORTING	BIT(7)
+
+#define PSP_CAPABILITY_PSP_SECURITY_OFFSET	8
+/*
+ * The PSP doesn't directly store these bits in the capability register
+ * but instead copies them from the results of query command.
+ *
+ * The offsets from the query command are below, and shifted when used.
+ */
+#define PSP_SECURITY_FUSED_PART			BIT(0)
+#define PSP_SECURITY_DEBUG_LOCK_ON		BIT(2)
+#define PSP_SECURITY_TSME_STATUS		BIT(5)
+#define PSP_SECURITY_ANTI_ROLLBACK_STATUS	BIT(7)
+#define PSP_SECURITY_RPMC_PRODUCTION_ENABLED	BIT(8)
+#define PSP_SECURITY_RPMC_SPIROM_AVAILABLE	BIT(9)
+#define PSP_SECURITY_HSP_TPM_AVAILABLE		BIT(10)
+#define PSP_SECURITY_ROM_ARMOR_ENFORCED		BIT(11)
 
 #endif /* __PSP_DEV_H */
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 88c672ad27e4..b5970ae54d0e 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -32,6 +32,67 @@ struct sp_pci {
 };
 static struct sp_device *sp_dev_master;
 
+#define attribute_show(name, def)						\
+static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
+			   char *buf)						\
+{										\
+	struct sp_device *sp = dev_get_drvdata(d);				\
+	struct psp_device *psp = sp->psp_data;					\
+	int bit = PSP_SECURITY_##def << PSP_CAPABILITY_PSP_SECURITY_OFFSET;	\
+	return sysfs_emit(buf, "%d\n", (psp->capability & bit) > 0);		\
+}
+
+attribute_show(fused_part, FUSED_PART)
+static DEVICE_ATTR_RO(fused_part);
+attribute_show(debug_lock_on, DEBUG_LOCK_ON)
+static DEVICE_ATTR_RO(debug_lock_on);
+attribute_show(tsme_status, TSME_STATUS)
+static DEVICE_ATTR_RO(tsme_status);
+attribute_show(anti_rollback_status, ANTI_ROLLBACK_STATUS)
+static DEVICE_ATTR_RO(anti_rollback_status);
+attribute_show(rpmc_production_enabled, RPMC_PRODUCTION_ENABLED)
+static DEVICE_ATTR_RO(rpmc_production_enabled);
+attribute_show(rpmc_spirom_available, RPMC_SPIROM_AVAILABLE)
+static DEVICE_ATTR_RO(rpmc_spirom_available);
+attribute_show(hsp_tpm_available, HSP_TPM_AVAILABLE)
+static DEVICE_ATTR_RO(hsp_tpm_available);
+attribute_show(rom_armor_enforced, ROM_ARMOR_ENFORCED)
+static DEVICE_ATTR_RO(rom_armor_enforced);
+
+static struct attribute *psp_attrs[] = {
+	&dev_attr_fused_part.attr,
+	&dev_attr_debug_lock_on.attr,
+	&dev_attr_tsme_status.attr,
+	&dev_attr_anti_rollback_status.attr,
+	&dev_attr_rpmc_production_enabled.attr,
+	&dev_attr_rpmc_spirom_available.attr,
+	&dev_attr_hsp_tpm_available.attr,
+	&dev_attr_rom_armor_enforced.attr,
+	NULL
+};
+
+static umode_t psp_security_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sp_device *sp = dev_get_drvdata(dev);
+	struct psp_device *psp = sp->psp_data;
+
+	if (psp && (psp->capability & PSP_CAPABILITY_PSP_SECURITY_REPORTING))
+		return 0444;
+
+	return 0;
+}
+
+static struct attribute_group psp_attr_group = {
+	.attrs = psp_attrs,
+	.is_visible = psp_security_is_visible,
+};
+
+static const struct attribute_group *psp_groups[] = {
+	&psp_attr_group,
+	NULL,
+};
+
 static int sp_get_msix_irqs(struct sp_device *sp)
 {
 	struct sp_pci *sp_pci = sp->dev_specific;
@@ -391,6 +452,7 @@ static struct pci_driver sp_pci_driver = {
 	.remove = sp_pci_remove,
 	.shutdown = sp_pci_shutdown,
 	.driver.pm = &sp_pci_pm_ops,
+	.dev_groups = psp_groups,
 };
 
 int sp_pci_init(void)
-- 
2.34.1

