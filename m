Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272675A556A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiH2UPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2UPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:15:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12C26F6;
        Mon, 29 Aug 2022 13:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKdgncO+f3gecHjaK8WJWjJGO0IpxkEnGvWkmF8jpAzj7zAYFWjmoUogF1e+7oIjhivV37vqRkvJaZG7jtnS5DmXB0gbWvPkmp7gRvHPUYDEesSVEN3blPgOBJG7SROM5xYzzMasCo9ygtH82wuPffxTEi6JNbhtRrk3FNNoLpD/dO7WNQKNk8pckp0bdCq3iSHCMS23HmZnN+gpR8fUkooYEhTU9Py2sPsnOp4MaVwCM+7qGCx0HTG+X8yqs5TK9BPijInbNTr2uZTXwfUUFopkHeugtfhf3fp5tht6swNYfENA//24+CbxwDwdzBO6crViifEfIhujsPoV6nVIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myf7UVzLQXuuWROy7+q3afa5QipZxyQf3IkFbsnP+yU=;
 b=XcUtLTWCAHYuAvNGmTCe7Ur+HycFzPcI8Pmv9O2QKLn0DenE9mGqQz1BSFPpof8W6bNTQNjwMDFE42JJP9jiGEmwKmOSF1ktGE2h8vq/ltsr2cndaxu7+ZliOXBMswo5TiWMV39ShGDBsSBlzbwhRI0hlZvBZkc+etcrCi1tlcRxeXaxjXkej9oqjHUqtMDXEu8EYgdFLoZbohRzxpdN+FoDy8MdMT2yl7VUJYOOn/bnWwV1t2WxK+E4J+UQQpKmtXID376XbDtWDcBCmqn6ZpFME03KhiwPGGHsyCLbKC4eNuZD9Zq8B62eOqBZsTKYIhU83mYrfahHtEWju9HUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myf7UVzLQXuuWROy7+q3afa5QipZxyQf3IkFbsnP+yU=;
 b=mJ4RFFwz1NZwWCavdwMNAIUTwgJh4jaiGwPSZbNKSVK4JWO2EKhN/J4/n3OE7xhgHwH2MSZHuZJk62npSatJ6YwR7O8wgzOsO5/2E1TkKLB80hIBr1uVQVt32yhImcxc2FZsxH7qhoZ8R+5xKFy4oTCRK1jRB100szGEc58C6Io=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 20:14:54 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ff) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 20:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 20:14:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 15:14:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Hans de Goede <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers that use struct wmi_driver
Date:   Mon, 29 Aug 2022 15:14:59 -0500
Message-ID: <20220829201500.6341-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca41e238-f1dc-4158-16bc-08da89fb2298
X-MS-TrafficTypeDiagnostic: PH7PR12MB5594:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgkoilx3ZZpUQ1RIWPUrUqhWyniJ7VV2ActElBQf8oxBJje6vEgJ7mYRGgIcZZzpk2f+sQKxHpN8+hkSFbqftRCTc6KnsP42svom8PRYsVgKSUUweOVXsaI0N4fIM+rNl9vOimygl7cxktqVgnazQe7+DuQHZI5oNhKl+4eXIFHewj9r2CVcFhXlOXY17kINOxIBb3r6a9PFb/F4z2d12cKSHRM3XKCTKYtRW0LhF2Q9GMFlMFnJOoF1+NMEWmO53YHzPVfa1lJ8vOIntfFbkDIrlBVYALrobhFLMrTjhb6EXko0hDwJI86fgzVj11IYYuyp33Bl+KyEWFkSztyFZBEzR6QydZ70ZhsHhCSfqvNiYkUjy7yX1pMvzefoWmJd6Yi5yDuZ4Th+OaYMm22vT1BjGB2dJBlwW2xViYw4sc3qS3BtIVKY4EWR0wVVxDNsxlRpon92cFoLZholgEWuOVOtLYlt//mMD6CnHrmNQX+4/6h7Ww+BZBTE/BXW7Xw3clEFOPQmnOyHO256bciQCe7Vgna2/5iiqqjuLARd1serpYjUw4N19YrjhxTj7cyVwBIOE0rZIl2JZycmiXuF2OoqISbZ1NK9LmABAxw4NGECNMTvtqmRkTAgr+VWK4uxsLQmn6Wbp0jZYyAilkS8K534qL9FLqquQpq8rXwSW9V85m+CSd7m5I1ZzeQ7iJjjgDmkzR0Uuv+CzC1JTF1lk0v86jULIB999i3KwCysOm00vXnsIe0YQdW/Ox3cjwUAb7WWmSGyLYeuEY4v0b8wJgDukM6muvW+d+AC5VRo2hebBc6nfETq7oh2uPKv1Sy6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(40470700004)(46966006)(36840700001)(2906002)(70206006)(54906003)(110136005)(4326008)(5660300002)(8676002)(8936002)(426003)(47076005)(36860700001)(1076003)(2616005)(70586007)(36756003)(316002)(44832011)(7696005)(478600001)(41300700001)(86362001)(26005)(82310400005)(81166007)(356005)(16526019)(83380400001)(336012)(40480700001)(186003)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 20:14:53.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca41e238-f1dc-4158-16bc-08da89fb2298
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI subsystem in the kernel currently tracks WMI devices by
a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
module however is available from many devices on nearly every machine.

This originally was though to be a bug, but as it happens on most
machines it is a design mistake.  It has been fixed by tying an ACPI
device to the driver with struct wmi_driver. So drivers that have
moved over to struct wmi_driver can actually support multiple
instantiations of a GUID without any problem.

Add an allow list into wmi.c for GUIDs that the drivers that are known
to use struct wmi_driver.  The list is populated with `wmi-bmof` right
now. The additional instances of that in sysfs with be suffixed with -%d

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Change to an allow list for wmi-bmof and suffix the extra instances

 drivers/platform/x86/wmi.c | 45 ++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index aed293b5af81..2997dad79e8b 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -105,6 +105,12 @@ static const struct acpi_device_id wmi_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 
+/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
+static const char * const allow_duplicates[] = {
+	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
+	NULL,
+};
+
 static struct platform_driver acpi_wmi_driver = {
 	.driver = {
 		.name = "acpi-wmi",
@@ -1073,6 +1079,19 @@ static const struct device_type wmi_type_data = {
 	.release = wmi_dev_release,
 };
 
+static int guid_count(const guid_t *guid)
+{
+	struct wmi_block *wblock;
+	int count = 0;
+
+	list_for_each_entry(wblock, &wmi_block_list, list) {
+		if (guid_equal(&wblock->gblock.guid, guid))
+			count++;
+	}
+
+	return count;
+}
+
 static int wmi_create_device(struct device *wmi_bus_dev,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
@@ -1080,6 +1099,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	struct acpi_device_info *info;
 	char method[WMI_ACPI_METHOD_NAME_SIZE];
 	int result;
+	uint count;
 
 	if (wblock->gblock.flags & ACPI_WMI_EVENT) {
 		wblock->dev.dev.type = &wmi_type_event;
@@ -1134,7 +1154,11 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	wblock->dev.dev.bus = &wmi_bus_type;
 	wblock->dev.dev.parent = wmi_bus_dev;
 
-	dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
+	count = guid_count(&wblock->gblock.guid);
+	if (count)
+		dev_set_name(&wblock->dev.dev, "%pUL-%d", &wblock->gblock.guid, count);
+	else
+		dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
 
 	device_initialize(&wblock->dev.dev);
 
@@ -1154,11 +1178,20 @@ static void wmi_free_devices(struct acpi_device *device)
 	}
 }
 
-static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
+static bool guid_already_parsed_for_legacy(struct acpi_device *device, const guid_t *guid)
 {
 	struct wmi_block *wblock;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
+		/* skip warning and register if we know the driver will use struct wmi_driver */
+		for (int i = 0; allow_duplicates[i] != NULL; i++) {
+			guid_t tmp;
+
+			if (guid_parse(allow_duplicates[i], &tmp))
+				continue;
+			if (guid_equal(&tmp, guid))
+				return false;
+		}
 		if (guid_equal(&wblock->gblock.guid, guid)) {
 			/*
 			 * Because we historically didn't track the relationship
@@ -1208,13 +1241,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		if (debug_dump_wdg)
 			wmi_dump_wdg(&gblock[i]);
 
-		/*
-		 * Some WMI devices, like those for nVidia hooks, have a
-		 * duplicate GUID. It's not clear what we should do in this
-		 * case yet, so for now, we'll just ignore the duplicate
-		 * for device creation.
-		 */
-		if (guid_already_parsed(device, &gblock[i].guid))
+		if (guid_already_parsed_for_legacy(device, &gblock[i].guid))
 			continue;
 
 		wblock = kzalloc(sizeof(*wblock), GFP_KERNEL);
-- 
2.34.1

