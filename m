Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E109B4EECAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345695AbiDAMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiDAMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:01:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FC517E2;
        Fri,  1 Apr 2022 04:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWeDSGi3+IvS1RPrcJOLVGQNU9ub1M/5YcnxrTJdVV30Px/elbUXgInIFwaLa73xyRMAG05jzs1YCNh5DCoUTmjQHagz7PPcIIWvD+uabL1X/kokXag+aIIxUM5yfGBYiCaZ+qwk6RwwwYBKhxXvyO5Fm37DEdmMb8I9rDsobkfghMjmyV7YS3GbLh2vO4BJvu+jT0rOYz5qEthVgflDZ3p9SL7wng7o/r08waQLUKWRnrLRGHxhXLjaBZUaCxXd+Mr2vOsELQ0ZaNV5Ju5C51X9BCl/VMwsFAbW/xE4ZyG+kseSYCP28JUqSbHw7PCNz9xN+BuCuB0ARZpiFFw/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrUyoBi6dWiY5DdTIj7koCyVAqO7EeAfUdR3Q6ZzYrg=;
 b=SRw41e+Hjp5tGKNdWjjJvn29WL968owVYxDTcIyYZKlRniXBnfPDknfNmsugXwJ9ezuL94zvA0wlqAOHd4GGLZWeQRDMPvXF+I4bppG0XGmdpxV1i5Muzx0XkU0hjSBPgDAIVQpog/y/kSPR6B1YQ7xfQahhnPyyLfW3mc10tDDtcKyw1ljsR0Vx/vMkR8AhKFIB848x64HVIiOHFI+1yiSP/AXIwyKs+VJLuR2ycLEIwsCL312VDQULA11l0/es9C6443dAJL+SAojcKhec1QBrCiwEa6QrdCArYSgQ7ZeJcTMsJoKEMZDIzCM+dZ68ghit7Itx7lVvyuYzNqLYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrUyoBi6dWiY5DdTIj7koCyVAqO7EeAfUdR3Q6ZzYrg=;
 b=Z6yXVR01dHhAoZgE9yeyXhzOVzKvJSYcWW2fn/I+XbwfvMpDsIRGDbeuUStKh1dKeAhyOTeE7eK/9cTY9oiDv81d1mu4trBrOQbzN6aaT1jVSaSX6q/Ngz5v0arjncvVV6rjBEszbFgAjZE/vJPDZoFOyWcO7I5qAfm2wpIcAPhjoNJWYg5G9JvI3n4nXRlJx0/xy+4n1KcNEX0kg8RH6GVgjo+61rCNMDVpnAIjy3LOsBgIrcIQBnaMFoPvBqBspwB4QDs39u7aU+Ns+5mnrn23k9EiQIz4XxIcL0of/njykzQFou5eomGo7lEjLXX46WKWBO9yrhFcyRkmcakBHA==
Received: from DM6PR06CA0007.namprd06.prod.outlook.com (2603:10b6:5:120::20)
 by CH2PR12MB3720.namprd12.prod.outlook.com (2603:10b6:610:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Fri, 1 Apr
 2022 11:59:48 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::73) by DM6PR06CA0007.outlook.office365.com
 (2603:10b6:5:120::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Fri, 1 Apr 2022 11:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 11:59:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 1 Apr
 2022 11:59:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Apr 2022
 04:59:47 -0700
Received: from henryl-vm.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 1 Apr 2022 04:59:45 -0700
From:   Henry Lin <henryl@nvidia.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Henry Lin <henryl@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] xhci: stop polling roothubs after shutdown
Date:   Fri, 1 Apr 2022 19:59:15 +0800
Message-ID: <20220401115916.104527-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bba6bc2-580c-4fb7-1a29-08da13d71f04
X-MS-TrafficTypeDiagnostic: CH2PR12MB3720:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3720B568251C93E02C3FEEEAACE09@CH2PR12MB3720.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7CnAFam58akyj0hpQYosdie7BTHc5PRGbz3iAkkM9cAbfUl1zwCCFx3bNz1vB0FDqhPgf/Z7+E/uDPUbWCSC1zruOwPWkqDcAee42YBU7FkfeY47v7SHAAekGS4f/7UO0KWyMW2EwEGzze/NAB4BiIZQl8h0ZbTHzUMjfzTHlrSCnbVggQx3OPQ6688wkrpMG9QMPKo9PhuNi3CV0r7eqyNT6hXzcvVkDQ60Uk6BDnU1laSdHMIl4haQLPjodgub+PA3sVeZGlzovMw3WACbeu+4/J6VHRdhQ7kExGMaqpEuJMwwdaJUODCf0rKETz3Ts47BRXQ+KYvIVF9RqQEJKCgZ1ofg/onk+OZL/m8YU3I/Sr9jIIUfBY6uHarUWuzgup8EFHzcBnGAvG5uy/2skkWA1woz+OkiC30YgfT22b6V5B98m+xUjHrCyRUnidP9ujme3O+wBX3+zqLxjQIZgq5AP22sEk6ZZjQzRNJt8Q1xwmdJdmMcJ8Hhmr7nkcxqXTvNPzKJS8x1Afv2fM5nPxqalZFzxwZvfSynTLl4MS6uu9MLWsYKwTTRWYYVxAffVyzS9VVd9cF8GnLZ8yoMmvUj26r2Vg2VKFNzES/j7E7Jsebo70kBNjCl4PCZkBPgY94v1nnUPSIDFpRAdOPPTykR5e4KahznJnp3CDax+I00zQudGvlEiW+bQha3jxsutTQ5FDfVaAQ11TOTuTmfw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(508600001)(4326008)(8676002)(2616005)(36860700001)(36756003)(70586007)(70206006)(1076003)(426003)(336012)(26005)(54906003)(82310400004)(6916009)(356005)(86362001)(47076005)(5660300002)(6666004)(2906002)(83380400001)(40460700003)(316002)(8936002)(7696005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 11:59:48.4355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bba6bc2-580c-4fb7-1a29-08da13d71f04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3720
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rebooting, XHCI controller and its bus device will be shut down
in order by .shutdown callback. Stopping roothubs polling in
xhci_shutdown() can prevent XHCI driver from accessing port status
after its bus device shutdown.

Take PCIe XHCI controller as example, if XHCI driver doesn't stop roothubs
polling, XHCI driver may access PCIe BAR register for port status after
parent PCIe root port driver is shutdown and cause PCIe bus error.

Signed-off-by: Henry Lin <henryl@nvidia.com>
---
 drivers/usb/host/xhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 2d378543bc3a..e7ae6766220e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -780,6 +780,14 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
 		usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
 
+	/* Don't poll the roothubs after shutdown. */
+	xhci_dbg(xhci, "%s: stopping usb%d port polling.\n",
+			__func__, hcd->self.busnum);
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	del_timer_sync(&hcd->rh_timer);
+	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
+	del_timer_sync(&xhci->shared_hcd->rh_timer);
+
 	spin_lock_irq(&xhci->lock);
 	xhci_halt(xhci);
 	/* Workaround for spurious wakeups at shutdown with HSW */
-- 
2.17.1

