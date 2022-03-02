Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484944CB1DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiCBWK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiCBWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:10:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F0C9A20;
        Wed,  2 Mar 2022 14:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReJ875eHhGgvgts2QPrXUl2tvSkJpV9GP0os4cxm+/VGShnZKiQmfdBAeX9tiZ99X0TYzVG4ZbJn6RpwO4kna0VIVu8ecJUzVcz+O1G32DeqfPIX7LrUvEuVjp4cISC9q0Rs7UfQVkCW/M1smO7+yW1icqxONlGGBeUiGxYEpuwlsTsR7B7tsDyKI7vCKOwkUE+MrnunybOkB1tLXcPdkjSCndTfpv8+l3A50MXe8SA96G6O8rqEbu4BfiXWnwfx6LejR3xg+ikq4lUnVOmYb/F+VJtrhw1bQo2gcQfDwZYcoilP6Tx0LTFSBOsco+bQm+r8hmvIQDWPExMED41oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spa9pu8/1SaHXsaj9AeAFRMW1FYo419JQ+uIyb6cJ5o=;
 b=H3a4BRKQToxw9AiDq0Tol+vYhk+4VB5KPnWbyBh7DC4n9bK1/i11rLfpK+dgT9gZdHZoo4lNCjLx5ScsxNmgVfvJFVW/9RbVe5yHFlMuxx+2BAgDCXMvUVHmnnI0P8xGxmAm9CkFjxyEShbbdgYbqaPTBxEdes9FdIggX9aXEdI0/ZwESfu27oiSQvpgPWJk2R5zNgmTgEG27Nq2SDdzSHARfWLRtrbOpIKImC49sr7iB8hKc912HaH2WLj7k+2lFULESEOkPqs0bEPRGbPzX1967T5lOzDsKLVhChocKjfntG7lhFI6hanzgSxq4y9ioGgXgcYxOuCv7njeymzVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spa9pu8/1SaHXsaj9AeAFRMW1FYo419JQ+uIyb6cJ5o=;
 b=SxU87e8EfOHUkkd2FdxhPrY1Khhg5xwEcSNOpuWt7rDEF3aKKTpyrAPYjN3YCzGjZS0ZD4HkKB6HG8XlKANlaJrvkFr64TdfBrsjynlf17a0XcoslmlHna2spTkCR3sMScRjokJhMusWOER9ClpebbPqtqAltQB4odIq9UWqL7s=
Received: from BN6PR22CA0039.namprd22.prod.outlook.com (2603:10b6:404:37::25)
 by BN6PR12MB1443.namprd12.prod.outlook.com (2603:10b6:405:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 22:09:21 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::85) by BN6PR22CA0039.outlook.office365.com
 (2603:10b6:404:37::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 22:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 22:09:20 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 16:09:19 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/5] drivers/thunderbolt: Don't make DROM read success compulsory
Date:   Wed, 2 Mar 2022 16:07:07 -0600
Message-ID: <20220302220709.3138846-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302220709.3138846-1-mario.limonciello@amd.com>
References: <20220302220709.3138846-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30e43578-4ea3-4075-98fe-08d9fc994d7c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1443:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1443CDE6FAC9B4E011DFDA42E2039@BN6PR12MB1443.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVYhvtG8W1TZkJtOZBWVvTo+uB85n7U3GYAyUgUyjJ5XK8NqaVV/pdAKnyL/ArPupy+gV2XALKL+RD9kB3FNaaj8e4J0iwB2TRXJn0V3V3/LVmJ2NJBz/GOwQ36kdTHYkjNUAszPi0PvFsApfwc4Cu7MIyQRDrES0EF4pkv8tTcVpUpi6WJGlnPmYCbcQXClykAVy7t8N1LQNNy7Za9iteuSOit+TeAYV27yPEAhOKc5ZMMqOFNFE9DYvy7OVzilQuGdCm5Ar46yvzArG7nlgJnaf4KWmgeQt9ZpQECOLgokXU9Mv5q0ps4PdzmBdh6kEvPrsvnEA+BxbtnOQTR1LuxEbAVHVwDIVMafmAKNm/La+ku7awqZLOYcX0ZIe5XQBKvbVA7fOZjhc3P4sVI5S6/eBBJaSmzRlV1O9obpntEO+k0GMUhw4gndzr43a3Mi42MXzlgn3B0ircZlVWjW6/mqGc0iHG7DGT4IRjzxkg6SghWrDWMtirtId7o9xdkx5aj1Dl1kjDE2RxL6fR19R9YxIx9L5pboWmFYIvg4KxF2WKcej782UUIw3FaddQu7Q9XDUMnA4DJvsX3ZLx3O3Vvf3xdSfREg9DmigmBts3fopZpQ+zt/RQHr0EOblDT4olcVdko1fnfr1ObKVfRQ9FMfV8+OvE+rKfo62V4Dq1zQAoE3iqHe6lMN+d2yo8CFIeQ3M0LLV0f72xHtYzZ/iKTPQ7tvVywMgbvidHFavsUDUiSEw9kW07vemrIGDsCHr4x3Qvcu0vUnzDrgajDRr/BvsH5CqUezf9/pz2cs8Rs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(86362001)(2906002)(44832011)(36756003)(82310400004)(5660300002)(966005)(40460700003)(70586007)(6666004)(8676002)(70206006)(4326008)(36860700001)(81166007)(356005)(66574015)(16526019)(47076005)(26005)(186003)(54906003)(336012)(1076003)(6916009)(2616005)(426003)(83380400001)(316002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:09:20.9217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e43578-4ea3-4075-98fe-08d9fc994d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB4 specification doesn't make any requirements that reading
a device router's DROM is needed for the operation of the device.

On page 207 of the USB4 1.0 spec it does mention that a CM may use
the DROM to make decision though:
```
After enumerating a Router, the Connection Manager may read the
contents of the Router’s DROM. If, after reading the contents of
DROM, the Connection Manager decides that it does not want the
Router in its Domain...
```
Other connection manager solutions don't necessarily read it or gate
the usability of the device on whether it was read.

So make failures when reading the DROM show warnings but not
fail the initialization of the switch.

Link: https://www.usb.org/sites/default/files/USB4%20Specification%2020211116.zip
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/switch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 294518af4ee4..ac87e8b50e52 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2784,10 +2784,8 @@ int tb_switch_add(struct tb_switch *sw)
 
 		/* read drom */
 		ret = tb_drom_read(sw);
-		if (ret) {
-			dev_err(&sw->dev, "reading DROM failed\n");
-			return ret;
-		}
+		if (ret)
+			dev_warn(&sw->dev, "reading DROM failed: %d\n", ret);
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
 
 		tb_check_quirks(sw);
-- 
2.34.1

