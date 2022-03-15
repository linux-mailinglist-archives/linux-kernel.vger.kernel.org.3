Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C74DA49E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbiCOVbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiCOVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:31:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC25BD33;
        Tue, 15 Mar 2022 14:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCwMlV7bdEGH/OZ9aQ3jFYIZIiMSyBkQFFwwDOxiSSwul8Ed52p5Vh7d8Pi5R0j+8p0KHRsylFFjegM6Dfpoag+n5PU6mWFrtlkap/oRxI3VbvPW1AOlpyp+nbofKRW/qQJqfvve1FjQMH6cCbxkex1Xvq0z/8TyZNo9IXSLo1moo7/37hf4GbiArgSuFYYuqyaXbBShTtJK235DcMGOOY61XTNw5odaebpjXoZVCuPyAHWHUP185yOd1gXipT9ZrmBLjJh8KFPV/VXXrWrE2N955HrzPh3ZeyrIGiUXbE67tMGiV1q/jOB6A5Rsvz8Z2Fst7hqrshZcEMYS6kdYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jHrTUrw1/xJxuZosBBpAOZuXF/B/bTFIClAAx/VUGo=;
 b=nN7ceEabqU3rfbk1liar79gfQOml/bRm1AuXM0BXTa9LKx7v1YG0C8BYthVvy1MmqBtu98nBf1LzrKsdyswjGSqtIcYxOAWqIVyfldMEeA66pA5E72hlDBo/XWVFzfBjiLRMe5itgq3AflQhBIVpV3mAg0b4mL0cV2VlXf1Bst4uOStrph4F89DRGyTpuXTUmzhch03Q0Wsist+N4sclPBrRsJfqsLfPkqzbKRut4DiZVP6h0Xc9ZQSnQ3RK4N+6EJ0KgWI1mlPGfoJG95DFzA6Yp5XWSrEgFLy9wKt2gR3raD4XMf3LVdGucgwwuZYBgDrsCI3Zeb0EytOEx0xVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jHrTUrw1/xJxuZosBBpAOZuXF/B/bTFIClAAx/VUGo=;
 b=Hv4ffcmaqAii9b2GC2h35OdEtqsobLFxuCCBuUxExQkNzJKcoVBPK0LcjmUdzfyk/YH2I8+2U4wTDC8xcoZghSspVLvMwaSndoMzGJWwfulGAWwIcLFQ1D7tvybWdw8BIX6pUqZW9DLdbIpnVjw+JaoUCHoyc5CEXj9rwt1fYWE=
Received: from MWHPR19CA0063.namprd19.prod.outlook.com (2603:10b6:300:94::25)
 by CY4PR1201MB0245.namprd12.prod.outlook.com (2603:10b6:910:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 21:30:24 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::54) by MWHPR19CA0063.outlook.office365.com
 (2603:10b6:300:94::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Tue, 15 Mar 2022 21:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 21:30:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 16:30:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RFC] thunderbolt: Automatically authorize PCIe tunnels when IOMMU is active
Date:   Tue, 15 Mar 2022 16:30:08 -0500
Message-ID: <20220315213008.5357-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db291d5d-1cbd-4cdc-ed1e-08da06cb03d6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0245:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0245B504F44E887926792371E2109@CY4PR1201MB0245.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Od87hLt5AurcZ0xhZgmSlGSUKhyuDfHGrjifbsudNZlTMEOTukfvp3QUUho8Nzd9kpVbbmUCNvCewQVE3XjxXWZyW/Ekc6PViqIEGBz1E9tzeViCzlNZpGq7YpBOGqz5bnUaAL9Vm0xRSx3uL32EMLRbnv/Ub3E/73tj9ICkC+E0yxLdHfBQahDh+qIX9B1PjofIwncoWvDbtQX8bTB8AynahqGMVkfXMMw7qWwwQPwc8r9t7cYKiOB9Wv35vZr8ImDcvn8TGRdgXqotNZVdHoi/2aLMf6QmooKxjAEyQdg0QmhUXB0mvQaxPFtFm5jVsUFOvydFogyHJ/X5qVBKIBt5rbExcTBgqGAnQlC1gf208st/XaQVFERpfAzobuh9+sjQRKDezjhd2yAnbg6Rk2VYGCg1l8VmbMi2BS985MhseddX9NBMC7+NiiaWt7ZqqfUSWPZs+RNoVf1HZqeQTrtd91Q1MtpFB3BrPnvRHh61Tr4R0JPw7wTFaYIWOBJRsAFGAoewMclq+fNCPP0g9npTXl/M3Kpo4s8vsXtmEg2ZpYtnBfdyIWG0+LH4Yub2xVgfk7wgxErAHMHDwkKuB3BJbTjA5O5Gr9mXMraUaPFCn97vayzdNXney337Hd5lcqm/JpiXwQ4223WbyfkFm1zdGOKsWw/eJHo+FY4red94rtOa4sXTf95o0UH/IEULYHsWu/Tr9cwGtDlxStsXWL3FbhYBv5+P1aPJ4rIG7yCGAVXpNygBlUKGBSq0R1Jl4X0QFIzQHPGkl26DUqaQgvpvlwwMCxm4NzN2CaxQA4E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(81166007)(26005)(356005)(426003)(7696005)(66574015)(966005)(2616005)(86362001)(6666004)(82310400004)(1076003)(2906002)(508600001)(47076005)(16526019)(336012)(36756003)(5660300002)(8676002)(70586007)(70206006)(36860700001)(44832011)(8936002)(110136005)(40460700003)(83380400001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 21:30:23.7016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db291d5d-1cbd-4cdc-ed1e-08da06cb03d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically TBT3 in Linux used "Thunderbolt security levels" as a primary
means of "security" against DMA attacks. This mean that users would need to
ack any device plugged in via userspace.  In ~2018 machines started to use
the IOMMU for protection, but instead of dropping security levels a
convoluted flow was introduced:
* User hotplugs device
* Driver discovers supported tunnels
* Driver emits a uevent to userspace that a PCIe tunnel is present
* Userspace reads 'iommu_dma_protection' attribute (which currently
  indicates an Intel IOMMU is present and was enabled pre-boot not that
  it's active "now")
* Based on that value userspace then authorizes automatically or prompts
  the user like how security level based support worked.

This is further confused because a pre-OS CM may authorize PCIe tunnels
and the Linux USB4 CM will re-use tunnels if the paths discovered are the
same. This means if you plug in a dock pre-boot it works in Linux
immediately, but if you plug it in after boot you need to authorize it with
userspace.

All the hand waving malarkey should be unnecessary when the IOMMU
translation layer is active.
* First detect that the firmware has allowed PCIe tunnels to be created.
* Then check if an IOMMU domain is assigned to the NHI.
  - If it is, set TBT security level to "NONE".
  - If it is not, leave things as before.
* Lastly when a port is scanned via `tb_scan_port`, check the security
  level.
* If it was set as "NONE", create the PCIe tunnel and update the
  'authorized' attribute to reflect this.

Link: https://lore.kernel.org/linux-iommu/20220315162455.5190-1-mario.limonciello@amd.com/T/#mbe71d35c27bb91f6f9781eba7676d38ca467f6d5
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Remaining items to be done/investigated/discussed:
 * Documentation updates for this
 * Is this a good enough method to check IOMMU is active?
 * Should the IOMMU check be on PCIe root port for tunneling instead
   of the router? If so, need to discover it via the device link
   (possibly at time of device link creation).
 * Maybe create a TBT new security level definition "iommu" that
   functionally behaves same to "none" to make things clearer to userspace
   how the device was authorized.
 * Drop iommu_dma_protection attribute?
 drivers/thunderbolt/tb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index cbd0ad85ffb1..eaa8429e0156 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/iommu.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -18,6 +19,8 @@
 
 #define TB_TIMEOUT	100 /* ms */
 
+static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw);
+
 /**
  * struct tb_cm - Simple Thunderbolt connection manager
  * @tunnel_list: List of active tunnels
@@ -690,6 +693,16 @@ static void tb_scan_port(struct tb_port *port)
 	if (tcm->hotplug_active && tb_tunnel_usb3(sw->tb, sw))
 		tb_sw_warn(sw, "USB3 tunnel creation failed\n");
 
+	/*
+	 * Create PCIe tunnels if security has been turned off
+	 * (such as by IOMMU translation enabled)
+	 */
+	if (port->sw->tb->security_level == TB_SECURITY_NONE) {
+		if (tb_tunnel_pci(port->sw->tb, sw))
+			tb_sw_warn(sw, "PCIe tunnel creation failed\n");
+		else
+			sw->authorized = 1;
+	}
 	tb_add_dp_resources(sw);
 	tb_scan_switch(sw);
 }
@@ -1702,7 +1715,8 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 		return NULL;
 
 	if (tb_acpi_may_tunnel_pcie())
-		tb->security_level = TB_SECURITY_USER;
+		tb->security_level = iommu_get_domain_for_dev(&nhi->pdev->dev) ?
+			TB_SECURITY_NONE : TB_SECURITY_USER;
 	else
 		tb->security_level = TB_SECURITY_NOPCIE;
 
-- 
2.34.1

