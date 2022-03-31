Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AD4EE319
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbiCaVOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbiCaVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:13:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F21223872;
        Thu, 31 Mar 2022 14:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUMZ8CoEbnKnjLT6zBOnK11NgQqJtbaW2jngLpuNVeymuJFuP4WS/qw/8awxbzMYhqz+LmuMqYzfBXt+SPJ3uz2wD/VAw6oJN18wBX9ImER29DwvWKT//xtxGbADGSkHs8UIuDAvmyRxxKgSf6lJ/B49z9dnarZUGqj6pPw6i4t81AMOibexI2mXxdPg2HYCL87RBUHCl0VYSysQ8M4VuHu3WwUOJFJ3csj4LzgMy9Gm/Gv4I7E2gaANkbjb1pTOjHEAdgmVeQu2ewhxAPfaF/s18iik2pYgr3OR4meef4ymMDHtxxZNPykkB9wgcJWsssh3H8X6fPEU3Mv+ny7lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUm/R3J7CVYyM9Z3lyG7h0i6ngl+76S2QWnp5/dooEk=;
 b=KHDd9BC6bxvkoE2VpURCZN/TSBI/bCmUeqeS7UoDGkTSC7FRC8nBKCBFFF8cq5r3jT61ZbCUJOMjf3TdmNWaNMmIGEW5DgJg2orjKFhhvnMKmCDuLhg39dUjSGgDobprJgCkdOHYmOGMK7M+OdgkkbYljHFGiScBdurUrZzFZxYtlbYNQa5u0e0et7lrNcTIt5aXfl3OCbqBzIWdAY6E4LYS2Qz1rKCk2jDLKIKtwOWweSqchammluHgOI8DU+cxarXI77H0Wgti0ePuu0dJ8JvzEqn7FFgwuVFxsPEKyaTX6ZCTRNoq0QJ82kRxFHrMdi4UIQ2ntSED0wErIunqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUm/R3J7CVYyM9Z3lyG7h0i6ngl+76S2QWnp5/dooEk=;
 b=iuUqslDQsMm/+hOub6ZgMfIIjJOjczcOWdeMn0nKkfgKp3aZjjly9bNuY9rDmJnYroiQwrD5BZlseMOfk9vo7ywOpUfhF5YMFOSdcH6w1SLSVjf2SmzUkdacpgVGZLxexY7EfVYLKW0O60w3Q2DIpRhPHHpVg8CAw8ei1lfjz9c=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 21:12:06 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::a7) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 21:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 21:12:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 16:12:03 -0500
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
Subject: [PATCH v3 2/4] crypto: ccp: Export PSP security bits to userspace
Date:   Thu, 31 Mar 2022 16:12:11 -0500
Message-ID: <20220331211213.2844-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331211213.2844-1-mario.limonciello@amd.com>
References: <20220331211213.2844-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98212183-b95c-4391-e904-08da135b1c57
X-MS-TrafficTypeDiagnostic: DM6PR12MB3001:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB300199EA5E1E988445F6DDEBE2E19@DM6PR12MB3001.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7zocdKVex/WXO/rhW0DNC33QXWL6O0QKG4sayW+Be07LePfvgHeujf/fPhn56K456ed3zJCzCJVJISy2OXc+h20LspF8FH2ejeQHjb8HY/ix+VZcRfZ3FWSaY7XJgHviLaScfGZ2Pi3+3cZzZPVu9g3djuLjmxbfth4Hc9RPS7+nlcD6ostL994w10i3FUZPuXLAj2blRrJEIXXZ/nN/xNXnWu6WssBmz46hdlwFB8s9v786D1rHKimXOO6tCwIiNfh0LVg7QS3i+9j3bTgY9MQss+8gL6Fi4RcHmt4/JXmgcjUntFDuWfLCzO07pQBFBqStwjUb3IW4dYuabD0nd2uxenLE8nN0HPxeUlrXNLkc4XEy5AjkRG1XtutS9h8+raI5p3bs56pmyanUqcBgobRX5v/prZrrO0CBb3DPkABYnnTkwiBs3PEqF1/OpQSH5PtOA1XdDF4mN5TZlSm5RgUX7rlqI4l1iEQvIZaZrwjAbliIVtGEsMbprEA7+jNCvJFyeoY6Z1+0ReM6Io+DRrWFtMkX2f/XWQ0lZD2yGiecNTv9Z9S/RQTOMsnFUBasgIT4EuD9CgtBu9nPut+FawvcxEGCJcjW9ZZ+UKu+/GnAhbv9XJ+AJ1jW0LPwKf0ZRBbEZGUAYqUz/cZlH2BRq00Fu9s14xQoA3w8NyqIycHRioq5KjATvGYpVwKkQ2sV9rBfUr8K2XLGISUZm0vAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(8936002)(1076003)(508600001)(47076005)(186003)(86362001)(426003)(5660300002)(83380400001)(81166007)(36860700001)(16526019)(15650500001)(36756003)(336012)(2906002)(26005)(110136005)(40460700003)(6666004)(70206006)(2616005)(54906003)(7696005)(70586007)(8676002)(82310400004)(4326008)(44832011)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:12:06.3102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98212183-b95c-4391-e904-08da135b1c57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
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

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add Tom's tag
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

