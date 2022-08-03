Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88B588C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiHCM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiHCM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:27:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA71A83B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk1zkJzDtlQm1gjsHXlCwHesnf6bbbZhziysphIWkiDqsU3zlqZZlYVv/tJAD1IokqCybzAHNoZvFKT3OQA/jaY0XrZISxN25uAtGxMWAWiix3mbqnfYvj2N2weLMJmLh5zysXX+tFNLKM1q9SktxFp9AfQ8oXCaOuNBgvYm25y1nYTZtPDYkYIne+tp3BA9ObQG/14xJ5Qpz9IQ7JvzYkIZFpgEV7wZKvcmUYR/MtlB4qJm2eEKgstia+kDX+r463d6otpDuLRM65vNm9evaZ3F2ov13ROGVjPJ50uE4V2k3gv4NUo/AgMrTT/FsM+BshSgdvagYWZUMDyrPvJa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfIVfuOCDXtVtXB6ZrZ4HmxHRTWObBWCu3jDeTkx16k=;
 b=kRhMsyuZl5D5eyY2rSjoqo6MNMzDUvAJxw/AcCueC9640TMCUuyXkuDZEz5SFOpUCvBR5yK7fJl9fj/BPaf2h55cJj2B/ZqGKdlCqTYbcBPI15bhjb16EjVdFJTGg2a+2L0Q7emgcJTg9U3DiZLZ1xA3d8J12r3Rndf2c1XaKoLekLMdql5zigWujhlImxA+WUvaGVeRuXX8rLrZwRCP3ecUZLKaIS7kwpXXCSJWdYukCWxzqKw+/8qKof+8IcNtPOUaUIKKzgfpVmSIkGnqyN0gDUmi93b3mJK+4Zo9/izwG5DQa4QZKAfjLykeQedWDJne7mneHgwwzA6mrLN9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfIVfuOCDXtVtXB6ZrZ4HmxHRTWObBWCu3jDeTkx16k=;
 b=UHkyQKd+eBuqpWviDHQyNSY+1f1+ZAOUvPV91JgHn1y+OT68gcQktvi3wWVfFcAfXTxm2u+SvamXoUxCBQwY6CLVk510RERXYyAU9bW0C0cvX2QPWI2Y5bvceG7Wn6LQtKJpq3/GfNXuQhJjVBN5jndWk8RNUFnBQVGK+37pNPM=
Received: from BN9PR03CA0101.namprd03.prod.outlook.com (2603:10b6:408:fd::16)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 12:27:08 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::fc) by BN9PR03CA0101.outlook.office365.com
 (2603:10b6:408:fd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14 via Frontend
 Transport; Wed, 3 Aug 2022 12:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 12:27:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 07:27:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 07:27:07 -0500
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 3 Aug 2022 07:27:04 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <maz@kernel.org>, <tglx@linutronix.de>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <michal.simek@amd.com>, <nikhil.agarwal@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with gic-its domain as parent
Date:   Wed, 3 Aug 2022 17:56:54 +0530
Message-ID: <20220803122655.100254-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803122655.100254-1-nipun.gupta@amd.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7938ca3e-e5cd-4511-56dd-08da754b7bcd
X-MS-TrafficTypeDiagnostic: PH7PR12MB5656:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7id9rWlHwUH7Gqz81V/8UhYUz5dEFOT+g5WTH9hrBIop89dUWXvTidWVMGiDZEIrlhVN4mH14GtYYdtFcNubhtAtKp7sBSX3ubNq7q06+qiVVmNi6KUMUCrm7REvnGkNMaBpBMfb3QDkGeW3H2825Z3RpTr7DUDGszge4GGBm/9bGp/HyMAuduJH2cP9nc5yqU2uPpwyhWjmYsXeZuZigwmIIDjHzlxOp6qs/dlBrqmTnIGhmaE4/mZIN16+vNAp2FlDDxyQtnGwE72wkMMXaBW0RzvDjfTQRd/ZqkSKZtA+5CEFMM6miwiD1SUStShC9eOMmJ7WhW1CL7AnKKLivacNe7CUlZ6HrXwlCcVZRy3lkCZcxsuEsZK6XKWQdVVt5hTVIrk6t/aKDLEphW/8iydNbslfpGgi2yHAhi7bbFPRH7RdLHIWmhnxqkZvRdVUfIM8ML7WZ9DMlVyzZLmnyS/YHSHyCqNbVmnJtDTkK1FXj/No5Sce4vW7EZaZeanT185wh/ejDHwFqpwVlBrlC+vZ2EIXvWx+21PEGWisAP0kS/eVm0dPClV+277RjIcomyDIeai2t6ln3VUxJge+5DnOhcaLnFbgEbrPyhJpxk7K4zAR3nJs4CiZdX5wUCUEcfw+7CyDY4DQxlj8kbdOw7PMQrJnnsI6xxPwYVOoVTEbVeyPNEjlumTZ/wwe7Ml9cY1Uy4AMTD49sHfEpD76GZt3raiBcALDXUhrde49x1p8QH2nDJ7ueTM8zsVS7yC5SYgg0+/W1XQEDvB4KJA8CsAQhEvQE195MFmXa9WjqIVCF87Tcu8yq1oJJMmtBZavSjGpzPmXr4SzNn04AVgF8OgDm84u8CZNWqN42nlIv0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(46966006)(40470700004)(70206006)(70586007)(8676002)(4326008)(82740400003)(40460700003)(356005)(44832011)(81166007)(86362001)(41300700001)(8936002)(40480700001)(2906002)(5660300002)(478600001)(26005)(6666004)(54906003)(83380400001)(110136005)(36860700001)(2616005)(47076005)(426003)(1076003)(82310400005)(316002)(186003)(336012)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 12:27:08.5773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7938ca3e-e5cd-4511-56dd-08da754b7bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices on cdx bus are dynamically detected and registered using
platform_device_register API. As these devices are not linked to
of node they need a separate MSI domain for handling device ID
to be provided to the GIC ITS domain.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
CONFIG_CDX_BUS and device tree bindings for xlnx,cdx-controller-1.0
would be added as part of CDX bus patches

 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-gic-v3-its-cdx-msi.c | 113 +++++++++++++++++++++++
 include/linux/cdx/cdx.h                  |  15 +++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-cdx-msi.c
 create mode 100644 include/linux/cdx/cdx.h

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5b67450a9538..623adb8a1f20 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -115,3 +115,4 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
+obj-$(CONFIG_CDX_BUS)			+= irq-gic-v3-its-cdx-msi.o
diff --git a/drivers/irqchip/irq-gic-v3-its-cdx-msi.c b/drivers/irqchip/irq-gic-v3-its-cdx-msi.c
new file mode 100644
index 000000000000..eb17b74efdc5
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-cdx-msi.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD CDX bus driver MSI support
+ *
+ * Copyright(C) 2022 Xilinx Inc.
+ */
+
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/cdx/cdx.h>
+
+static struct irq_chip its_msi_irq_chip = {
+	.name = "ITS-fMSI",
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = irq_chip_unmask_parent,
+	.irq_eoi = irq_chip_eoi_parent,
+	.irq_set_affinity = msi_domain_set_affinity
+};
+
+static int its_cdx_msi_prepare(struct irq_domain *msi_domain,
+				  struct device *dev,
+				  int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	struct cdx_device_data *dev_data;
+	u32 dev_id;
+
+	dev_data = dev->platform_data;
+	dev_id = dev_data->dev_id;
+
+	/* Set the device Id to be passed to the GIC-ITS */
+	info->scratchpad[0].ul = dev_id;
+
+	msi_info = msi_get_domain_info(msi_domain->parent);
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
+}
+
+static struct msi_domain_ops its_cdx_msi_ops __ro_after_init = {
+	.msi_prepare = its_cdx_msi_prepare,
+};
+
+static struct msi_domain_info its_cdx_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &its_cdx_msi_ops,
+	.chip	= &its_msi_irq_chip,
+};
+
+static const struct of_device_id cdx_device_id[] = {
+	{.compatible = "xlnx,cdx-controller-1.0", },
+	{},
+};
+
+struct irq_domain *get_parent(struct fwnode_handle *handle)
+{
+	return irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
+}
+
+static void __init its_cdx_msi_init_one(struct device_node *np,
+				    const char *name)
+{
+	struct irq_domain *parent;
+	struct irq_domain *cdx_msi_domain;
+	struct fwnode_handle *fwnode_handle;
+	struct device_node *parent_node;
+
+	parent_node = of_parse_phandle(np, "msi-parent", 0);
+
+	parent = get_parent(of_node_to_fwnode(parent_node));
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("%s: unable to locate ITS domain\n", name);
+		return;
+	}
+
+	fwnode_handle = of_node_to_fwnode(np);
+	cdx_msi_domain = platform_msi_create_irq_domain(fwnode_handle,
+						&its_cdx_msi_domain_info,
+						parent);
+	if (!cdx_msi_domain) {
+		pr_err("%s: unable to create cdx bus domain\n", name);
+		return;
+	}
+
+	pr_info("cdx bus MSI: %s domain created\n", name);
+}
+
+static void __init its_cdx_of_msi_init(void)
+{
+	struct device_node *np;
+
+	for (np = of_find_matching_node(NULL, cdx_device_id); np;
+	     np = of_find_matching_node(np, cdx_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
+
+		its_cdx_msi_init_one(np, np->full_name);
+	}
+}
+
+static int __init its_cdx_msi_init(void)
+{
+	its_cdx_of_msi_init();
+
+	return 0;
+}
+
+early_initcall(its_cdx_msi_init);
diff --git a/include/linux/cdx/cdx.h b/include/linux/cdx/cdx.h
new file mode 100644
index 000000000000..244ad721771d
--- /dev/null
+++ b/include/linux/cdx/cdx.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD CDX bus public interface
+ *
+ * Copyright(C) 2022 Xilinx Inc.
+ */
+
+#ifndef _CDX_H_
+#define _CDX_H_
+
+struct cdx_device_data {
+	int dev_id;
+};
+
+#endif /* _CDX_H_ */
-- 
2.25.1

