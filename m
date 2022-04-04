Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229254F1EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiDDWXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350452AbiDDWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:20:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7471960FC;
        Mon,  4 Apr 2022 14:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiA73asseRJd+OAe+SvVOHkQM/yz2mwi1HJwbQqnRrXM/CaMI/ktj4mZVRWGTfPFMKKmZNgxx9189DaQyfHM3GQdogumrIqSCvF+lH18ZhT7Oynk86V0koI+IO0s/CxJizw0RsuMGpGkC1dbf6QFwTk7AO0IZVB3TqN8tGDbQRByHKqCBqC08b2Ye1l5dxfEgiSSfi7/COdmFhZUwvx8W3u3zQQvv9q8Ps77zkGu5QVaNbkoVYzXPPklPZgpnM6GpZ+PqBmJJX8CWlA/Z7wGzp+V0L77k8pD6brAXxzvxHymhISQM1JD380r/bjSXdYJQT1gO6LCWXtRxal7MZtvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMR4xWlYy//KFYEx4oDnOTHb6xFhYDBioq8yF6mfED0=;
 b=Ahrjh89PjoBHPQGSIQ3ua9KtH9QpsKX/YzVnEOxMxWv60N7kNZAm9XEOdX2swBwmJzkbt4TEoGgHtnLkvqT9s2eo472jYPta8FnfxfUUbwbRaWu+lJ5zMtbXRRg2Od0dRD77Ng4L9+c8MytjrxrvdKnhKsqa8yE/VlxmIa4pAJVu/cSI9gq5TDfn4VTyBq2Hp99KYTGOFhqbCUVWlxZofBt/tlNYcyVw2dmKhZxcuogt77XvGBBm3hxrxM060VsBvSRPk9933/JwedtvlBvjhkqIJ2piTKt7F8fxj6MBalThRqjmkuuSplGunW/HbfcOzFFfoZmOYRhiz5ZK0FtqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMR4xWlYy//KFYEx4oDnOTHb6xFhYDBioq8yF6mfED0=;
 b=Hzu/kXoKRz30mqfJIbBDFRLnQbQRhAh4/SeqlBMHvTR1DZBzqGpJDnHdWyFJNPsaG5IZCrONLxZbp2esXye1/10RAH3xMwSw0o6KkDKl0ubTAB5bZZaNH1zIPu2hpMCFOZ4aV3ls9Cl6U/JLULyVa3xmAJZGMf88zDl9Hr89dpg=
Received: from BN6PR16CA0008.namprd16.prod.outlook.com (2603:10b6:404:f5::18)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 21:47:11 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::1d) by BN6PR16CA0008.outlook.office365.com
 (2603:10b6:404:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 21:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 21:47:11 +0000
Received: from doryam3r2rack03-34.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:47:10 -0500
From:   Richard Gong <richard.gong@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>
CC:     <linux-usb@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <amit.bhutani@amd.com>, <richard.gong@amd.com>
Subject: [PATCH] HID: usbhid: set mouse as a wakeup resource
Date:   Mon, 4 Apr 2022 16:45:57 -0500
Message-ID: <20220404214557.3329796-1-richard.gong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4529ae9-744e-482d-312c-08da1684acc7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5074:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB507456B04F3DC5822E62A38D95E59@CH0PR12MB5074.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ButYMtxmQUStKbsSp307bimMuC6En89VqNaWVsmPygaihYtT8hmpWZK3kgH86zCCDV/DjWnD2bNCejRENqvxOITPBYJlpE1epJ454VujLAUkVkAH1JN930xGVLy4G41W9BlFJ+dXO3glFO+nUtD/QxvfhutEqcloEgDtQutzG5r+h8vKKhCDyNA3NCumymUxKnYRkUvMG+LoJ1ToOl0w1KfXJGRxwbNHHzZZ6HnGCHVU8ly654LxaA/SiDCYy7iqmB4jdJBNKbpY8LeiBNahTHK4MQ0uwtI7ZWq97GVbfoiJ7Me7SQbtb5BinIcjp1xsbreUyw3Yh+kEjGn3h8MLEhK3BZvwrG4nEZeewAQFblZzZUjoElj5oao08umUmNp2QTPRpSwTWDDX7f/lDbUilr4DT0Z6qLaKbs28NxY3zlskJce3ZQ++4T2p6D4bM1iy6WnAK0zg7J18Z2HAbC+lN0koqwY6wwGwMP3OcI9/8n+aYjoOIObE7D+KUU0iYMjr7Ht+WzgtZ7YfKllIvsJmmVXNpgbVJT9s63eZagI9NxVJGhLcHzJvMam6TR6e5cWbCTU8EArYRAJF0TMwOS2g3LNevKh08PWeAR+htGdbJMtLIzNL7GceqrMpeCkVfqiCVRu+60V5jBZPxwrYOxq/+s2D6p34iXF4G1CBjNN70h41n1yFPNRQJ9s61E6r32Ql9MOzy3+B4RS03iesLEC0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(86362001)(47076005)(82310400004)(356005)(81166007)(44832011)(5660300002)(7696005)(6666004)(16526019)(186003)(26005)(8936002)(110136005)(4326008)(8676002)(316002)(70206006)(1076003)(54906003)(508600001)(70586007)(2616005)(36756003)(83380400001)(426003)(336012)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 21:47:11.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4529ae9-744e-482d-312c-08da1684acc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB HID transport layer doesn't set mouse as a wakeup resource by default
so user can't wake system from s0i3 using wired USB mouse. However, users
can wake the same system from s0i3 with the same wired USB mouse
on Windows.

To work around this wakeup issue on Linux, the user must manually enable
wakeup via the following command:
	echo enabled > /sys/bus/usb/device/*/power/wakeup

The mouse is set to wake resource by default to ensure the same behavior
across operating systems.

Signed-off-by: Richard Gong <richard.gong@amd.com>
---
 drivers/hid/usbhid/hid-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 54752c85604b..571dded02b3d 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1183,8 +1183,10 @@ static int usbhid_start(struct hid_device *hid)
 	 * devices supporting the boot protocol.
 	 */
 	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
-			interface->desc.bInterfaceProtocol ==
-				USB_INTERFACE_PROTOCOL_KEYBOARD) {
+			((interface->desc.bInterfaceProtocol ==
+				USB_INTERFACE_PROTOCOL_KEYBOARD)
+			|| (interface->desc.bInterfaceProtocol ==
+				USB_INTERFACE_PROTOCOL_MOUSE))) {
 		usbhid_set_leds(hid);
 		device_set_wakeup_enable(&dev->dev, 1);
 	}
-- 
2.25.1

