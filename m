Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A730D4C3ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiBYHQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiBYHQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:16:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3320A39A;
        Thu, 24 Feb 2022 23:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWiXAba7zRc9aiHfLu200ZgZ1fmK2Yh4KIezJS9eSvONiOMvCu26FvGDi9G44IDWmmY5A7sqeq5TUP3ZEMhoM1adapAzaY/F/GUT/vyubNpnRFXBp4i7l1NkG4qUPQft7sN5Ml6qLFlPC4De7LREZroR0dcExZi7f5abfM0+AtHeI1gA3cRMJlv4iWKavzcIFjrPNoIvnHezPBnpcX47R6O6r8ryV+KVMa/UWUDWSfIn2aoU3gcP+18gVX+X4D0pOMCisrZta/paYTug8UT6iLXRsliY+UsNx/RxfWShmiOk/EmFbA0yv6iQYn7MNxCZKW3etDqOlc4WHFf6zoRX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny8gHbh0IARovu1egy7EbUpzjRYarq2ytwagwI//nio=;
 b=WcklE6h3gK5KYNd37dE4GRIGDd2LkCqQwyl4Cvu8l1hIr0Erv1eUN7wYRh67WQ71mqKuhRXepvP7XoUrmoF+5VDO4wdtGDkv0v7QS0Bs0JaOSVv7wtk/fa3GYBpuXMqK395JMKLPpqS2CLchGRn5Q98Rh/hRgsORj+TTtn3UUb91bsOqJOx/IaySeWWLx51FY6W7kgB/e/QB/VqmgRuFqViph68XYmSBKNn6j36W3xWe28i8uLj8kv1TE8qErE3wYYsCFYmZUkdykKvr0yTY5QxUR1CS1cD71xqhFVuRg/4o/y3WB/SxMYNRMYeT/l93b14tzA/IQ3gMsfXa2YSsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny8gHbh0IARovu1egy7EbUpzjRYarq2ytwagwI//nio=;
 b=kxwoptwlxF3avZvwAb30dMgPLOAKVrhH2yn90qFUNWh1Mn+Sy00aJtqwYAgK2OtV+heMkru1lo3OgZf8LNZK4lZ5/c8KBT66+GSfqCOwFSx8bKmvmzztkqYVc3pnKN14COpkxSIEtqkyA53UGKbDrPy/SrI+bJlFnX9DGqoEa7A//0S8Yl34NdRhjLGvTPffPTpiSsez0Jwu14qX2ZgSIl9jgiskRNZtAsGtZJjjei+c1xbmeLsV6TRZQu2r236E7c91+EVOZltkfKDqfa6PUNsTh6r+zyOXeUdo30Yuhe6ruAPCmSnrUTkZ4QE64Of1hIXc2/pWZwOylZCkuxYJ1Q==
Received: from DM3PR12CA0091.namprd12.prod.outlook.com (2603:10b6:0:55::11) by
 BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 07:15:26 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::ed) by DM3PR12CA0091.outlook.office365.com
 (2603:10b6:0:55::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 07:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 07:15:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 07:15:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 24 Feb 2022
 23:15:24 -0800
Received: from henryl-vm.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 24 Feb 2022 23:15:22 -0800
From:   Henry Lin <henryl@nvidia.com>
To:     <gregkh@linuxfoundation.org>
CC:     Henry Lin <henryl@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Date:   Fri, 25 Feb 2022 15:15:06 +0800
Message-ID: <20220225071506.22012-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225055311.92447-1-henryl@nvidia.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4670e78c-b8e2-4b81-48d5-08d9f82e9888
X-MS-TrafficTypeDiagnostic: BY5PR12MB3970:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB397038A9C86EE87E21187740AC3E9@BY5PR12MB3970.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XDJN5eMeGD6wNysvx6xhK7TWdQRPi7XxTxLx+X5illvrAFLdSeuguAXWIPW1StU7rDHGsYY+B/Mn7u9ntimy5iIQsukrF6+fgsJPs2zCVpLApNfaTFIzc1In5WqRqaivP1zy9cokbdBEG5+Pdbp2S8nr1QW01DfQiiMpb6gARMWfXeZHYh3W75YbZuUpGGjFk1ZOHXg8u7y3Y+eLjcihK9Y7Y2ddNBmR5kN1eScKR1fKhQzhambStqte3RUW85hDXeAfhoTJaOVcJ6ldHh77PJnNPpHCtzhZ/U+UTHfFzYulQFtK+8ZyRiY2GEqS9qV7DvblntoIvvxn1AU+D/kDvQvbrJp2h9FeWjeB9flAzX8bAwF7+kP8PN/BuFdPtE2qp8/dmNcy197mg8CP995t48zCSwi0SUcC+h6b9/ZLF9zIdLbn8YLnG6q8e5hkPFzX4VeCeuX4/tS5QYBi2bzx68mcDoPehFXmmabJ9kKeUxd97hWev7sYsI0zn7EOzLA9zVMM3yA7JMYi8QAPCZJdD5qaotZx7zcOk1Gm68BfBqnZ++CscmSFpfaJcqTv3Gq9HDnNOXnd/bK+5EMtlo2xv3LNKF17DmNgGcIVVRjXeiffojXX0vsFfDm9FZUWAPJkT8DJycNoeqCsInOsvlnFaBESeG1m8vGUzqmJjmLb40hLZd/DWhmaHlP13FBXfIAmJTIf6beCDgGvp/IkWRDVw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(47076005)(508600001)(6666004)(7696005)(83380400001)(316002)(6916009)(5660300002)(36860700001)(54906003)(36756003)(4744005)(8936002)(8676002)(82310400004)(4326008)(2616005)(26005)(186003)(336012)(426003)(1076003)(70206006)(70586007)(86362001)(81166007)(40460700003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 07:15:25.9794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4670e78c-b8e2-4b81-48d5-08d9f82e9888
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB2 resume starts with usb_hcd_start_port_resume() in port status
change handling for RESUME link state. usb_hcd_end_port_resume() call is
needed to keep runtime PM balance.

Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status")
Signed-off-by: Henry Lin <henryl@nvidia.com>
---
 drivers/usb/host/xhci-hub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index df3522dab31b..4a8b07b8ee01 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1090,6 +1090,8 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 		if (link_state == XDEV_U0) {
 			bus_state->resume_done[portnum] = 0;
 			clear_bit(portnum, &bus_state->resuming_ports);
+			usb_hcd_end_port_resume(&port->rhub->hcd->self,
+						portnum);
 			if (bus_state->suspended_ports & (1 << portnum)) {
 				bus_state->suspended_ports &= ~(1 << portnum);
 				bus_state->port_c_suspend |= 1 << portnum;
-- 
2.17.1

