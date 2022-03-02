Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59C4C9E08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 07:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiCBGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 01:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiCBGwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:52:32 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183BFB2D6A;
        Tue,  1 Mar 2022 22:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV+Y7k58OyyR1fKQf3ixrKSbSg1jE+ZsO5AZlWt/rxS0Bwnddxrz2qVCENVf7OcEuwhosUv9cS65qqQRq2zuVICdDTXTznY90k3reBEOqPjRllYlgDOlbrOQh50WRqysoUaK1NEvhwiMiFJMjrSIUFVmDqXOy8jiv0pBVZii03f5iuIqw8Uv5oCDu29n1SHSpuQQoWmOWAxjlsJURp5OIOHDEjCVr3gPOfv5eby+DYkdph5eDE8pyRq4IpszUw4psiC1BUrdCSy9PQi3V+mDs7lkh8KU+dMMEF6HZxfwf/T/vKz5WJTXUQ2+tFBFzmtJVPUdJC8pbHGwtJGvpk5QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxRfNa7ufEglBa4hLoflld9PtFpbCrt0CWWgNoAo+jw=;
 b=IZad8ZxgQePeTEZQnAKLw7J37QqK9s6IAEMo7i5ZnjMFuZOJOIPchf2sTLercVcSYzAOMAeEBASDtpD8mpL36Xhl9vLHjn5rPyoyOPGam+ZLlJFndQPa3l8VwckBgr0J7UEBpBukGFJG7SMC7mh4Y8awcVy1GXSY8tzcEwbto3q2b6HIuOQ/ITRYXkMoTxJcmF3XTEVlfLbgbOQc9H+2QVfjno050kaaZPrq0tRTUitL5rKErdr9A0mLWjglZ+E33Qv28kj60DSQdf9xMb2MotK+4x/chjzd11p54/Z0OYqaNpCKi7NQ03h8f3E/vKY9rRKm8LYGE9N/d7v58UM5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxRfNa7ufEglBa4hLoflld9PtFpbCrt0CWWgNoAo+jw=;
 b=b/gkNRBMe5vuiW+36Ez7Z3EYYkMwUrCmqqXqiuwQfzlHGcrClCUXnuk013QyycdNUtk5ALCOYcU6cocaaS34/fU+TobhHxE24sjNwVx8ljQjtSsKUr/rZdOaU7zgC/nX2MhNHiGPC6N1FxzPA4vwAUBE7n4Ftg/APaQkd2ONUcH2umIkGFkK3X1PdEenUtNjh5N1yRke0USwsKFBTzU+qzMyDKJu2FKlE/1Wc7A4TRe1gMpE235mhpieyJVWd7gtySR5dmCr10PNzkeEgiwMQE1X1QlhnUxBMWKfgkI9zUGCHE8R/BKgslO9GcZ5EjToqfKMoYCwwBj4yKY9y4foqA==
Received: from DM5PR21CA0028.namprd21.prod.outlook.com (2603:10b6:3:ed::14) by
 MWHPR12MB1648.namprd12.prod.outlook.com (2603:10b6:301:11::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Wed, 2 Mar 2022 06:51:47 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::76) by DM5PR21CA0028.outlook.office365.com
 (2603:10b6:3:ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.1 via Frontend
 Transport; Wed, 2 Mar 2022 06:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 06:51:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 2 Mar
 2022 06:51:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Mar 2022
 22:51:44 -0800
Received: from henryl-vm.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Mar 2022 22:51:42 -0800
From:   Henry Lin <henryl@nvidia.com>
To:     <mathias.nyman@linux.intel.com>
CC:     Henry Lin <henryl@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] xhci: fix runtime PM imbalance in USB2 resume
Date:   Wed, 2 Mar 2022 14:51:06 +0800
Message-ID: <20220302065106.85021-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2e5f4998-71bc-1fd5-8a82-b7392e4f7615@linux.intel.com>
References: <2e5f4998-71bc-1fd5-8a82-b7392e4f7615@linux.intel.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff1da8f0-7cfa-490b-534b-08d9fc191e85
X-MS-TrafficTypeDiagnostic: MWHPR12MB1648:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16485D43988CBDE6829FAF03AC039@MWHPR12MB1648.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onD+pv7IC19cx7LHxEoL20FtnKGYllN4u6Qz9tMs4ldIRuSrloLtwA6Ra3Ysz72NwjNYQ9TXs9Mnoc9gM3lHcg76bl0aVx6eUwqdI6lpCOwQEKZBPl/Dir8h9KJu0RMm3XhSai88VKG6LUas/RzIC6+P32UarlBPXuqdzJ6JJ7tUryqXpMauXivuWjX/7Vr4tbUZO6h7KnXzP0DcIBdoiioihybVWYmStt/sbeEI93fmdb/X5xcO7gWOrMh6yoWDwldbjbnw45toaOUO49jew4S/UcmacO2eD5IzlIFUlzifucBrkVJVdYycjR2FiC85VQ2JppzrgxnlUinQr4DiYTU86cOTOimiue/obVN94j6fBv8HohgYrWZGBcf5tszluAUngZeRukiAERGsLLdVhoEKmQokdO5DY78wDd6i6VYyozSBF07pK1EN7WAPhk28GtggB4srSnkhcOFwFXlLVXxKMZ99uI3m+UEPXB4PqGv+rST97nwtn5K4JTJB+3IJqI9/nyCBy37hlEK2loJweFtkIbH9k3887MgO3KPuy4SeQw1G4bNOitW8+A79BJL09zF6W8cboKlOdkxB94nn+B/05UtpRnRiKKEcS0diGYt72Sczmo5hjTNQ1mcMsfcakbu9Peef2ZfUe6FSL4A8UwypW8voR3gK3Ie86xV7ZQESK77R/Gii+4nHlMoziF71X51HM3Hst6lufPKC88WrfHKYDI+4urcVn5pxbYoAU9cuMZhgpPFffzl0rMrebf6fcXggIWVaSAYfl+bYp6YJL16ev2YL0o2DCwoXhuzi5hDLVPOwwSRFRGweOpAVNoWTh6ojuV1O19e00uqMPC9EAA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(47076005)(86362001)(54906003)(82310400004)(6916009)(508600001)(316002)(70586007)(70206006)(6666004)(40460700003)(7696005)(4326008)(8676002)(26005)(186003)(1076003)(426003)(336012)(356005)(81166007)(5660300002)(2906002)(2616005)(83380400001)(36756003)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 06:51:46.4665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1da8f0-7cfa-490b-534b-08d9fc191e85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1648
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race between system resume and device-initiated resume may result in
runtime PM imbalance on USB2 root hub. If a device-initiated resume
starts and system resume xhci_bus_resume() directs U0 before hub driver
sees the resuming device in RESUME state, device-initiated resume will
not be finished in xhci_handle_usb2_port_link_resume(). In this case,
usb_hcd_end_port_resume() call is missing.

This changes calls usb_hcd_end_port_resume() if resuming device reaches
U0 to keep runtime PM balance.

Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status")
Signed-off-by: Henry Lin <henryl@nvidia.com>
---

Changes in v2:
- Add Fixes tag in change log

Changes in v3:
- Revise changelog
- Only call usb_hcd_end_port_resume() if xhci_irq() detected the device-initiated resume

[v2] https://lore.kernel.org/all/20220225071506.22012-1-henryl@nvidia.com/
[v1] https://lore.kernel.org/all/20220225055311.92447-1-henryl@nvidia.com/
 
 drivers/usb/host/xhci-hub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index df3522dab31b..5e7a4dfc59d2 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1088,6 +1088,9 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 		if (link_state == XDEV_U2)
 			*status |= USB_PORT_STAT_L1;
 		if (link_state == XDEV_U0) {
+			if (bus_state->resume_done[portnum])
+				usb_hcd_end_port_resume(&port->rhub->hcd->self,
+							portnum);
 			bus_state->resume_done[portnum] = 0;
 			clear_bit(portnum, &bus_state->resuming_ports);
 			if (bus_state->suspended_ports & (1 << portnum)) {
-- 
2.17.1

