Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8035A78CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiHaISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiHaIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407CC6B7C;
        Wed, 31 Aug 2022 01:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQT4EhNO8xna9j5Bs7Oz55sYQOq0IzB2V7eAxaumENriLnXitjgakqmn3J/KPFn8XrXCOWFuO3KS7t5iu1ffTDiuz+l22qZF4vHAa2IjRoOg3mbdIQjtiZhwR9zelm2/NJpOwiYxpPF2SReprFAf+k0r+RgN8qqqnj/thnuJu2Ne0Df4x+LQyWWZ5u6xTxoEhLzqXbNPXb2jJbW2FIMQNTawt10VC6a/bxTEXy33EPC1g+bVC+ifwGIClnAnZUvKl+76q3F856F3DLPbl7mzthh486uOLu9gZb/gAavMEb43+0OAf4nx0bZ5Di3Jk4/Y/+fnuOcNzZ02xgK/b1kRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npmUcNfBPE1lgkLP1GY2kCBueBj/1FtBwIB5Pz3Gz+M=;
 b=aCJGzbAChKu7eEYklGMRAzNc0eKSfawG3lEYlhSjhyY/T96aZfoFgaugkVbwj3o5yk9B0G86k9dBoaeLyIuG47X4yyA/YHZhypioPiZdl3fHFAn58D+Np6/z334jdYveeynMc8unXOHtIcdEQkHWWspfPdC/kfGTFaPUylac8yeJ78Zrmp7jFrPfaeIeVq5Tin9vCfoAMQATLZ9EEXDrbxUR+M/MhKLnbOexEG8/7VEqRYTjSYDEDg0ClDT5mGy6WVikRdUD9ia9mMmX7xlvpC4oUAwM18d+EFBQs5Z0OS2Gx+1rL/UqHGHDJvk5EVbb13pyWigx6mgoHd5ba+PO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npmUcNfBPE1lgkLP1GY2kCBueBj/1FtBwIB5Pz3Gz+M=;
 b=TYEMo0JlyMpKwneqrdJDEis+r1IORfjwAXPMGrZq0+1gsBZX1e85L/Fz2aVnN4Jn1g1SI2Twf4NvmoQRwtUJHooHXzBoivxsZ96Gg6OGS+tZj9B1JLS5+lPciI8zcCHHal5B9HQOGrZ7S5f2Rj6TSaNdVbI1srCalw4Dl+OU6v0=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 08:17:14 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::88) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.18 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:17:11 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 13/15] cxl/acpi: Rework devm_cxl_enumerate_ports() to support RCD mode
Date:   Wed, 31 Aug 2022 10:16:01 +0200
Message-ID: <20220831081603.3415-14-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6875b152-ee97-41ce-477c-08da8b2935ba
X-MS-TrafficTypeDiagnostic: DM4PR12MB6495:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SFTM7nGyFMrJrgCl+uIbfYByPBqK5BaIhOXJMwK0s7sP70LQVXWm5fJch6+T299d+aTwgRCB1+xP0FIbqM+tCQ1UGx/Txyzx3a0dou95afbDjhTHDrBKhrewCzgeoNkTYOOkyPFo/61A3xnKoi3XRrzi1dnlOdVOEDnKgyRZtRCuUKL6k+oA0Z+R3MBSEO1srHTTD60l9HH9jr2xPaKTFcJ5bUByX1uWoeskqUoXXQN1GbzBYsi2eGq7ozT0mBc1cY/OGbd+tP7PfIJiVc9LR8SgWkQOW56+U9h3IkqwqRLWnsLULcnUSJTCTl4XPtUCqkQeQpgBdvQoSYEtG0dPKD2Xj9Hhq7/5bRfVnxglGPK7E6/gj7mx4LvvdJojAYOVaVIEKb5My3CgJsROOdNVjMdjmKtYlR+Mtik2Vn/tHSTLHHZiF7cu+h88hF/XdKC78LE+kEmV5bjHWTrJM/vtdmAAr+sxrRBkaXQOccFrb/Q/W1JVbmPIOcBPg4RA8G+D6CfhGQRGWOe9OXluQzSoAcjeShylM8zZAaefqzY5y5NsqaEdZch0oXUxtBGToIAxzK2p/YbwIYuOVEsKJtjFBSYproL7KDjdXIPdyHoXasIWG9ZJRyH2JZSw+EoMnlqVk7/i2hBRDkb3UlmLAbqCCnPwp2ELnN2M8V7833xFwv5epmKCZqKCVCGVb8so1RUumqPHboFfSVuLoFOknmd8tglV7woos3NoCIs/ojCRmjaBfTA8wZHO87e7gFfEaqKrPPtzG+IG3QycGnk8DTBGY7IqLFWtPT+pCXSGbYRt7rjGYrlDSC9iGIkk3ZMAvjd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(7416002)(81166007)(4326008)(8676002)(356005)(70206006)(70586007)(36860700001)(36756003)(82740400003)(47076005)(478600001)(83380400001)(426003)(336012)(16526019)(41300700001)(1076003)(6666004)(26005)(186003)(40480700001)(316002)(5660300002)(54906003)(40460700003)(110136005)(82310400005)(2616005)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:13.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6875b152-ee97-41ce-477c-08da8b2935ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCD mode has a different enumeration scheme other than in CXL VH mode.
An RCD is directly connected to an RCH without downstream and upstream
ports showing up in between in the PCI hierarchy. Due to the direct
connection of RCD and RCH, the host bridge is always the RCD's parent
instead of the grandparent. Modify devm_cxl_enumerate_ports()
respectively.

Implement this by introducing a function to determine the device's
downstream port. The 'for' loop is adjusted for RCD mode and in this
case find_cxl_port() will always find the host's associated port and
the loop iteration stops.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 61e9915162d5..08b99423dbf8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1084,6 +1084,22 @@ static struct device *grandparent(struct device *dev)
 	return NULL;
 }
 
+static struct device *cxl_mem_dport_dev(struct cxl_memdev *cxlmd)
+{
+	struct device *dev = cxlmd->dev.parent;
+	struct pci_dev *pdev = to_pci_dev(cxlmd->dev.parent);
+
+	/*
+	 * An RCiEP is directly connected to the root bridge without
+	 * any PCI bridges/ports in between. Reduce the parent level
+	 * for those.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
+		return dev;
+
+	return dev->parent;
+}
+
 static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -1339,7 +1355,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
-	struct device *iter;
+	struct device *dport_dev;
 	int rc;
 
 	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
@@ -1352,25 +1368,21 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	 * attempt fails.
 	 */
 retry:
-	for (iter = dev; iter; iter = grandparent(iter)) {
-		struct device *dport_dev = grandparent(iter);
+	for (dport_dev = cxl_mem_dport_dev(cxlmd); dport_dev;
+	     dport_dev = grandparent(dport_dev)) {
 		struct device *uport_dev;
 		struct cxl_dport *dport;
 		struct cxl_port *port;
 
-		if (!dport_dev)
-			return 0;
-
 		uport_dev = dport_dev->parent;
 		if (!uport_dev) {
-			dev_warn(dev, "at %s no parent for dport: %s\n",
-				 dev_name(iter), dev_name(dport_dev));
+			dev_warn(dev, "no parent for dport: %s\n",
+				 dev_name(dport_dev));
 			return -ENXIO;
 		}
 
-		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
-			dev_name(iter), dev_name(dport_dev),
-			dev_name(uport_dev));
+		dev_dbg(dev, "scan: dport_dev: %s parent: %s\n",
+			dev_name(dport_dev), dev_name(uport_dev));
 		port = find_cxl_port(dport_dev, &dport);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
@@ -1418,7 +1430,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev), dport);
+	return find_cxl_port(cxl_mem_dport_dev(cxlmd), dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 
-- 
2.30.2

