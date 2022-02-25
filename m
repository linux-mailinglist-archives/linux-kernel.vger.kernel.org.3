Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C34C3E12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiBYFyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiBYFyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:54:05 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70DD1AA062;
        Thu, 24 Feb 2022 21:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZH+LoqSeMy7Nqlq9wTA6fsPUuf7TYvd5kJatIONTcMqFQDGWp3NSkgC6ZBQWipMrj1HnIfKHhsvHxqe5TtY6u9qmzcJqtnPcQm4j4agJxJl+yUOU7J7hZxFus2QZPeGVn4Xtk6Zzl8PhOYNOZHbA9C9lh6GUwtLCyD0gUe0TDKnFxPtgvzDjSFGe6APQbRB/Kc+st1yiIEIBLQgGpvUxAoi+C8yE7xF2fsGju6N5oT7belcjgsENe+YwIe7uEjDTvJhjR59LNz5xBJGL7ObHsiFPPwNpDhiy8zG9BUwuW4fc+WEjJkfWno0XJfrj5I3lzwvQXJXh7JCb/b+5hzHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ+AlfLgI0UhBVGHhd8Tdze1khjMojD5wSv1JsOYwqE=;
 b=eICQHc7vvpk9Fl1CsvxDWW3MzyV47uh6R4w+K0Pryd+TYmzW8jLdHkgcWVzi7/Qhj58rB1/YQMaCbV3RavmrGBrIfSoP3c5+gruSo0t1HpRzGTQrzheCBKcNR03cT/sXP8A2AlYTJcWn2fWfNYqvWlQLfap9woqRBMIvDrlXzVN4z0PuajP8187B3FigCog38bA8WnNoZLCDdK4sEgQ4B3WVccCJ+DZ8KW391VixTNpqKozNbTC4RkbbHt9faLs92EJG/6bMpKUbRE3D7Iunp2ma9p6WEIsZT9jHXGSATNfjfvUjZlj1ZnVYU6xQBXOvJh0mzJbt5LlXie+lBxxIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ+AlfLgI0UhBVGHhd8Tdze1khjMojD5wSv1JsOYwqE=;
 b=kgaiQB1Uhy5FhAtGRdwYeW2u86o6AnVSsoGJqr0sp/X4KFDtBCP+DYXJ0+i3G92y11Ui3eHzzLXleptQD/4VA/36YsAjU/xz6H5+3onpW+B3+fv0aFBgarR5gxBkSzYmltdslGKddl8dfHY+GQoeJM3UZy81wcHoUZ3/dcqQTVSCGi2Gbm7KMsMK47UqQN3ATfbWOazwD0NC0EGGl9uFAqE4dbfz2RUoJwgavc0WaR91KKsUQwJX98jyAXtcoLMxKcr5bjs6+i92Avw3fsnbI73bs6rIeHo4bqRKVtQjCGhT/SCoQXzfqO9y23Lf7FAFepIGkjb7NMgNggjwtthqgg==
Received: from MWHPR20CA0039.namprd20.prod.outlook.com (2603:10b6:300:ed::25)
 by BYAPR12MB3302.namprd12.prod.outlook.com (2603:10b6:a03:12f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.23; Fri, 25 Feb
 2022 05:53:26 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::14) by MWHPR20CA0039.outlook.office365.com
 (2603:10b6:300:ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Fri, 25 Feb 2022 05:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 05:53:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 05:53:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 24 Feb 2022
 21:53:24 -0800
Received: from henryl-vm.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 24 Feb 2022 21:53:23 -0800
From:   Henry Lin <henryl@nvidia.com>
To:     <mathias.nyman@intel.com>
CC:     <henryl@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] xhci: fix runtime PM imbalance in USB2 resume
Date:   Fri, 25 Feb 2022 13:53:11 +0800
Message-ID: <20220225055311.92447-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8496e332-e047-46a3-43ae-08d9f823241b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3302:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3302FBC5F1D0E25196458115AC3E9@BYAPR12MB3302.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnwcGhVm9ZRzN7bCx7fD4/IrX2VyzII9A4QarH8mNjgp4mBbuFrEtF7aXdQc1RgjmqDgO6QECihBGZ5gSRcpe8pxpgVfZgMIfzdBJEqTybw+s+eJIOGOQoJvRkYQbcUWxbhJX2vA2QrNCikkn2odJumhfGRPtwr+0JOUjuJqtT6x2ox+XOQLBDhqWz6bZDYhBY73YPyTmc1Il4RaIHgFG78XBD+J0S7Ffcqml/DZa8SweSteYEPmdFNQbvvosCUhxB+9Sehe2p8wHK7cEI5MX3HOSUjA7+Uif9vIhLy2vfqKTkOW84n9Uq42Vp6oWS6//rciN70Szo7kqBlm9I6V2f43EKDpAEx76sKB3+WHUDajhGRZfjVuZCHhVBHLFMP5mOxS6b9k+paEZ8gVoF/nFLl5Dkebdu18jyJrKnCL0AG5MprbSxkjRoL1iy70XlpHOWGz5yNItXmaGrz3dQdm6WIS/ZSjBAJ5kKoAWprQSup9b6NimGR9ammTXyTCQ0nfvJRct5C8Bcvort6zdqSrVzN2aJzduUXMUi6dxgZ5s06XApWhH61hJEmCHTMynzxvoaQLrB2BQuY15BfBtTolKLzbZ6akQWcGhjuObrCe9kpHpYp2xlX10fST76K16d2NEITVZN/ef5JyVZqPAqVtonQhypuLdH0NaxHZNV54AOm1H10J+d8V6NZofrrhmZJxQiN2bW6+BSWWCdmFg/DlHA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(2906002)(8936002)(36860700001)(36756003)(40460700003)(5660300002)(47076005)(4744005)(2616005)(83380400001)(6666004)(86362001)(7696005)(4326008)(8676002)(426003)(336012)(316002)(54906003)(70586007)(70206006)(6916009)(82310400004)(356005)(508600001)(1076003)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:53:26.1696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8496e332-e047-46a3-43ae-08d9f823241b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3302
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

