Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7CF5A2D06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbiHZRBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbiHZRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:01:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B6FC9E86;
        Fri, 26 Aug 2022 10:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0+EtaKcvVnb+cmffabNnP4Fp4CBd42zbil6oxyhTYwJxNj+fTgcbQV+0l8Q467pXDQL+Wc1+iPCJBV9sQe3Sglh/JaDHUqp8Ts418KThnE3ZDBvb5tPPqju3U6Cq7Ux9NuLKe+GjKn802uFkMBZ2+j96EdrhoQ9CiE5po2UFYlzPpg90BmtNieEgS1/HEUVY3BD2r+jN/AwLToIUPk5rZ7ueHDKmFbOk1OvSzPKU/ouneO9mbxu4gWleWjFHHy1Chaykt6ynw6H+BkMh2+4su3Wx0C1Ek4SfvwiNiQV0P11hehj+YNZVUEkymP79tmeys6pZ6ePZKt6F3s0NPZHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DED61T5UkJy76XMNgi8aqJ78Tx1z+ZX3gqOWnGwEaTQ=;
 b=oVBStZNrg5LqcUQgXM/Uw7rm+4OhzTkmaxhkR4F7MIq2L8f9cBuiiPjJUrQ8lTuwlnWSuZwQCUQz9X23KYtej2HSRC0URvtxF43bBf4/iJbryj5SJCWH+JqctpQ855xOKFKSz9v/f0KJSJARMVOTecoBnm17cQ/tdwrEdUHGt3dV7Qk/yQyTeHk3TYbRxB5rD42Q5QVIx413TOoDJxQjBv0sVPN6Lw/l5fUXXwVbX43p8ie9fDt/hE2dB9NPW7c2SAlP4HDRPYZ1JqkXgNoQVQE2CzPHaibdeTp3gI7KuRQGoeTBkJ4h+IGKuw8ehUJhHcmMjOl8niGPC9f+sV78Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DED61T5UkJy76XMNgi8aqJ78Tx1z+ZX3gqOWnGwEaTQ=;
 b=3B1DymodkG0P9mgowBWhjL1TP2+RIuxPC9//4Cw+VVdyBFZJ/xYiacsoGy6R6SVyl1Vt4aZOffeFIZx9Xq57kqWHPru5eNEWkwuaQ1wy//JXOBamQsbyLX/tNIVIkru4zy04+WbWQndv1M1Hkgk+EiPFUPFzgWzl3b4ElCMLpEw=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by DM6PR12MB3660.namprd12.prod.outlook.com (2603:10b6:5:1c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 17:01:10 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::cf) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Fri, 26 Aug 2022 17:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 17:01:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 12:01:02 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Hans de Goede <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86: wmi: Lower verbosity of some duplicate GUID messages
Date:   Fri, 26 Aug 2022 12:00:53 -0500
Message-ID: <20220826170053.2124-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1755bffa-e6be-4524-caab-08da87849324
X-MS-TrafficTypeDiagnostic: DM6PR12MB3660:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzRLHIvZLRTnkbFSKzj2nbCob7xLzRqO+smiOs8pq1TmrV0ZATHmJo1s6M4pgROleupdhqw1WMmqLz9Au/uAC1EtHX96bsGJjbuS49r16/i3kBJRJPS3QMVfg+PWXAAp1CcOiI5yhHwhX/jTp3kzWO3pNiQ/aZig+kPmora2lo5uLecT2VU2tJNx1c8nv+aOwEfy7JXbwFz2MCSnC2vA5ZgR+B7v2lrxrA4ZOPk9RcFczOL1yL1oFcv3zyzKn0gyJOK/oGK6jywd2FzlmLZbtOoHU/d2ZgwFIu2wHZ3PIgvXhdn3kI4fbN11YN4jcByS7WBt4eURpvo4Qmvp0xCkurMjOrQSxLC6iIAEWy7P1NjyPrm92mxzQ0TsEZs9kbCgTHWPJuhiBCBym443AYuCUmkif+IAikVRkE6lK79MdtKP+lBEtGl3tSpfl5w74Y6lUmlbV2g3DiDF+as+TpwspN+ymgf+Tw0Hv0sNPe53L+HTTwUCfg4eSSDQJ0kSwGTAf2hv0gbJFllcBAfMr9WskGEIdOB1zBn2kgwGXKatAmbyMFGZyjG+2M7uHGEy8wsUaelIGEIohpdOROLyjsDdArTZLOv9ZsamAzqgaWMYYVEO+NydrNxXOY09pden5cPrSL2mQ+XbLOEwcjked4OGTyRrmuOYRMJ5yozzmmPsAqU+M0qNcwcssnN3l83PtgHX/to3subbbPRN9DINdGeRyy9CiR86MP8bul85Be8GRjsp7ZJCx74oNqbiSqWBfa0N0pVmeEbhHOZpld6iiTl5HJn/2ZILw/nbLh/LHiBJ0hdYR93rdIrwaNC7kgc94Pa+VvOkwwZmDoOdMKTpneWvoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(8936002)(26005)(356005)(82740400003)(316002)(478600001)(40480700001)(40460700003)(15650500001)(966005)(44832011)(36756003)(7696005)(6666004)(86362001)(16526019)(81166007)(2906002)(1076003)(426003)(2616005)(336012)(70206006)(82310400005)(36860700001)(110136005)(54906003)(186003)(4326008)(8676002)(47076005)(70586007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:01:09.8566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1755bffa-e6be-4524-caab-08da87849324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3660
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
machines it is a design mistake.  As there isn't an active need to
get the binary from each of the `wmi-bmof` device, special case it
and lower the message to debugging.  This will help to identify if
there are other duplicate GUIDs in the wild.

If there are and the information contained in them is desirable it
may be worth considering a design change to the WMI subsystem to
access those.

Link: https://lkml.org/lkml/2017/12/8/913
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/wmi-bmof.c |  2 --
 drivers/platform/x86/wmi.c      | 10 ++++++++--
 include/linux/wmi.h             |  2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
index 80137afb9753..af46e9e03376 100644
--- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -18,8 +18,6 @@
 #include <linux/types.h>
 #include <linux/wmi.h>
 
-#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
-
 struct bmof_priv {
 	union acpi_object *bmofdata;
 	struct bin_attribute bmof_bin_attr;
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index aed293b5af81..d7a1f4bf443b 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1157,6 +1157,9 @@ static void wmi_free_devices(struct acpi_device *device)
 static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
 {
 	struct wmi_block *wblock;
+	guid_t guid_wmi_bmof;
+
+	guid_parse(WMI_BMOF_GUID, &guid_wmi_bmof);
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
 		if (guid_equal(&wblock->gblock.guid, guid)) {
@@ -1166,8 +1169,11 @@ static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
 			 * we need to suppress GUIDs that are unique on a
 			 * given node but duplicated across nodes.
 			 */
-			dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on %s)\n",
-				 guid, dev_name(&wblock->acpi_device->dev));
+			if (guid_equal(guid, &guid_wmi_bmof))
+				dev_dbg(&device->dev, "duplicate WMI-BMOF GUID found\n");
+			else
+				dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on %s)\n",
+					 guid, dev_name(&wblock->acpi_device->dev));
 			return true;
 		}
 	}
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index b88d7b58e61e..59acdceb4411 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -13,6 +13,8 @@
 #include <linux/mod_devicetable.h>
 #include <uapi/linux/wmi.h>
 
+#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
+
 struct wmi_device {
 	struct device dev;
 
-- 
2.34.1

