Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F6475540
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbhLOJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:32:52 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:44000
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241191AbhLOJcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:32:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXl5VobnXJH+Vh0PCDnr1uIYGUsrKUXyagoAizaSAM1FUoR9U0lxYvj5dwvjOrsyNBlXYqyK0sucuP4SDYE8lz4kLYbyBWmyVlRMN+8z44ALJ2eqrVeLHyz2Ce1YrDNlA4tdfnrJabtsFNiq3Td1pudTyvzX8GHF+kYLHNgLP8uHPHDroY4yMibTGGrFp/qY7IQTnaWu+Qa/F5nd8x3Ea65uhZKVeCi8THy6QGsTlOSoyO3JuB08x9MKqcVD9wojheTETmqdGl5o56pBKNMsquzq8c7+wvD2XqbO6GpH+3avAlYClHwubnWpPM6txlxHYwqYQuRsJJoWaeSnUya2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4N8wDAdvFBA1+za8yISTGJm+OMv850y3Vu3lvUW+kg=;
 b=H1927Zb9u7YfCTAQ4fIo2HPO2S6mb4HyhM1VMVvLFfEGmyUULYvgvfNLddMKsVFAVl6IhzAFh6EN3qHDT/ERu9ZsSz2tyIHmxZvtXZVCKV1HYhsqQP6XMHgHYmQ4hkrzeJ3CBDTHJaLo7l5GHhbfpHKu8XYE2HXsQlAvMUsNdOlT1odntN6xRcvtWPwb70nFiQo+38OYFe+jS0fph4l0m8lELU/B1oClAv1GZGFdAGlpX0Q7OgIF9h0dF81kGO5bpQ7II8fMpom5oIJI7nbjBDEXEkbSwVbdhzjplL7r6HZfufKB8ZoqhxT3xSgy/k3dXMj/W8G9BhT+A2yR8MgNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4N8wDAdvFBA1+za8yISTGJm+OMv850y3Vu3lvUW+kg=;
 b=v6A1xaagbpX1ls1zz2Hi6Rrtp6DCb3BPn8rODmEmU3OFFKrvtrejHHSZgb/evhsnQFoGkssbHw2Tl3bTGlWitlgRbjGAZZbgXJuNmPsP2RyksbMq9MxUtGnanJBo31k3e/sxZQEVelQfpG1XNwGxMZUI/o6zInlnHK6nbLTo+vU=
Received: from BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::31)
 by BYAPR12MB2805.namprd12.prod.outlook.com (2603:10b6:a03:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 09:32:49 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::f) by BN9P221CA0011.outlook.office365.com
 (2603:10b6:408:10a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Wed, 15 Dec 2021 09:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 09:32:48 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 03:32:46 -0600
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>
Subject: [PATCH] usb: xhci: Extend support for runtime power management for AMD's Yellow carp.
Date:   Wed, 15 Dec 2021 15:02:16 +0530
Message-ID: <20211215093216.1839065-1-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eee948d-ee80-4e6b-e3c4-08d9bfaddb97
X-MS-TrafficTypeDiagnostic: BYAPR12MB2805:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2805465FF8994A55E56EE2A8A0769@BYAPR12MB2805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCtSR2JLmEHj8doxOYiZZFM55XPidAdOiVhO6AmitlgPGQkrxnvnCQJUywvPYRV6cw4f8Uk5RrGKY0auL0yaceI1zLojI6fGEhkP25TzMI19HTLHL8a/IrYcBG1Q1SKRgOszf8JcN60Jhk5ED8Xad6v4ZunGSnHQP/VzcePyArRfKCaFG6F0X8cMhcZGh1qC9OIjW0e/R8PRaKZhh9odq4OMyYTFrWVES/Wl3ksFxUtK5B4GbXFfkAz6GnPkiuOzIwmhrovEZ3hnVVytjvrpXzSHb1wpJ85JRVxkw+TwgVrTOcfkwbPigHekgjEJHkOPerKVOrnzq6QGoPFBE7Is93V9M4dYAfEDZKQQ++2KVgFrKIooDyE71eCyTHHhVmoanpkNj9sKXWi+3njs6GJE9qmVXwXU4nS+M5zsqYIU6zTMKyfUoN3zwNw6mEuGsWuRgckKPHFs1WnSkqXed0zK9pid209aCwUDsRpQFZy+n9A2OS9iDmV1Pm1RLSotvSbHRWMBcTgcCIDQ2OhwSG207gY8+0IwBjuyaPfcgDXl+PJ2rg+5WLI15SSmU5Ba3Tpn4cli+QRY/e+5dzumMCYY4LSsIhNJM09SZcKhIq2H0ysLs8lUe4Czknv6ObuM/9+XMhrnyt2FHV14YD0yQacJUJwlnCqFFNTcdan8EqtuuCzrqvCvkOWsp2H6lmHSVuuCSoaGcX7LVtdbjBo6hSMxA/LTmoObXAX0OMBj+8I1p9uw97tOmPlWsN2fzWpMF+hLAw6VHs/6TtkFS1r6j2bwtybn336I7EqjBgc3k9qUzAM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(8676002)(36860700001)(47076005)(81166007)(1076003)(356005)(110136005)(82310400004)(54906003)(86362001)(70586007)(4326008)(186003)(26005)(336012)(6666004)(40460700001)(2906002)(16526019)(70206006)(316002)(426003)(508600001)(7696005)(83380400001)(36756003)(5660300002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 09:32:48.3735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eee948d-ee80-4e6b-e3c4-08d9bfaddb97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2805
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD's Yellow Carp platform has few more XHCI controllers, 
enable the runtime power management support for the same.

Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/usb/host/xhci-pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 92adf6107864..3af017883231 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -71,6 +71,8 @@
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4		0x161e
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5		0x15d6
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6		0x15d7
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7		0x161c
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8		0x161f
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -330,7 +332,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6))
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-- 
2.25.1

