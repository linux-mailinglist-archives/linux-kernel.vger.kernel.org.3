Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54053BF6F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiFBUM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiFBUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:12:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED90CED;
        Thu,  2 Jun 2022 13:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmAb2XvEpBiZcOTnN295du4ebQCX7vAcOYhWTZTbpF/zveHlnP+XzIofYZzgqR3M3Iz87EQ/36xA4oKkrrwp2SS5zDAvag6UdvLYZiHjqzBkBrX813DVE/ibG2kJq3eeP9pBWulXc8rXW+GWjIBlwr4sARPs77y3soWSFgbO03lOysTzHh289QADztBWLCpJhwtyfszSpkw9RJSMCxPaVs5Fss8YPwVeRgvoMPkZM7w8lobLwgjXro/4Z17SkklXfWRlPKJT5lgrViWPKfJGOB7mF3yQOXthCnEzNeQps8W+n/0uFfKV0Q2l7y9F5gQNMPm6AzUG0ufTImBYvonnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfcuSF487zx4NXZjRutDNaI9irrccV0HRpn5cReQJ5w=;
 b=EVhN8jBagNTJubvSHQ+y6Z5ilHtrSoZn545nvpc4Qoi0gnAcVG8sWvucz74lVFU6o3bmy8n5xtry1B53dpXpya0z/pUbyA8PJ5GD3Kj2X0h5sFY2XeuiCRIuQ6t1FU//mZeLdAYfH5m3FmDLWzvYcDyRWUMrIdJGlu9epTUL4ijL8xiA7IX44y4Mjv5+AzieXN0GuW39Kz8tsr+HD/MQ6RIy1zYrngZHTmmzbFJHPHciMhx4tC5i7gKK1lOR1GTcE7ZFWblHcbqVLRPu074cBJec2SzIKlnr/8qi6ezJWPsKa12BoMYYuEps+t5rIFYt1gP3imOTASQak1WMNTKytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfcuSF487zx4NXZjRutDNaI9irrccV0HRpn5cReQJ5w=;
 b=CjFn0viB+zh2/C8w0gtfLAfuC7d7GZCnB0uIiXoCe9vAPFRbS5Shcq6utmeyrjMlpiw1lQfbxKkVVhXSpC3K6gr+otMIWZhnSYCY6j5n1aJvhY2DYzzsblTUG04aUhyNcJIt01ZiGdTct0S93RU72AanbS3Wx658a9zIqEcwhnk=
Received: from DM6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:5:190::40)
 by DM6PR12MB4796.namprd12.prod.outlook.com (2603:10b6:5:16a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Thu, 2 Jun
 2022 20:11:55 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::cb) by DM6PR11CA0027.outlook.office365.com
 (2603:10b6:5:190::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 20:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:11:55 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 15:11:48 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:K10TEMP HARDWARE MONITORING DRIVER" 
        <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 6/6] hwmon: (k10temp): Add support for family 19h models 60h-6Fh
Date:   Thu, 2 Jun 2022 15:11:37 -0500
Message-ID: <20220602201137.1415-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602201137.1415-1-mario.limonciello@amd.com>
References: <20220602201137.1415-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e22f1424-1183-41b0-d113-08da44d423d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4796:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4796DF16C532E3FA72AE7985E2DE9@DM6PR12MB4796.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNrUYpSanHA0ER4fqqxvnwwBeyouN7rPyc5pbBquK4mugkyGqfwQaRODKMzPwL8JhjgD+zSvBIg2C7P1iiAD6zlUblTQZPAP4R8ps0hbheAiQL0jQoTljP6CCYRHH0lqv1PhiFmakGsHVqgnymqpCbqMTnBBMlS6I890/9YhsnxRH6KAlalJMK+lsSunzbDcKYe4tqkQvU0wEyein3tdTJZNxyt9NgdfAz2tMwHOxW4/GQxqpbDcSbJrGErJuRDz1fz9M6ebu12tQVdf21aAnI2JoCfuSCzCWs3x0LGwRmz9yymehyKeaNGMNw6Xvwfg/mzF9zK4116B2WQUl1gx5Me4ZNqn8TEBm5juAChJQ7ZcF56BsZeAaNS9O8BLXp5r7/HWLDc73N09AQIMo6a0afjJM1AqO2V4nfzDxGqXuzKDIx4p6cLaK9sgzBwTlGoDtQcmRQ0gR3yiGeOdahpof4LwVUVI4tog4mYJk7zpE/gkurUGhk6Qh5D6oOYPsBm14zamNvqFhiPezRKuocsS/8wPWa1pptIJTPilVH+htP3XNkp3Rpwv6ALiPxj6ZGIiU4MYKSX+NhOytvC9SokJeQ4DC9YgUr8uKN37pNwf9I/nVKlc98xAYhaIctHdpeYW3xqqIdDbzsePbdp7DZMBHlZeFFBOANLLgcNImeud+f2CINZtXck2pjimyHe+PhisRqyPuQ5ilGU8CB7mRg5jsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(8936002)(5660300002)(316002)(54906003)(36756003)(7696005)(40460700003)(70586007)(70206006)(2616005)(110136005)(26005)(4326008)(6666004)(82310400005)(81166007)(1076003)(47076005)(8676002)(356005)(186003)(16526019)(2906002)(508600001)(44832011)(86362001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:11:55.0158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22f1424-1183-41b0-d113-08da44d423d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for CCD offsets used on family 19h models 60h-6Fh.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5f37e2e7833e..5a9d47a229e4 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -449,6 +449,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x300;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0x60 ... 0x6f:
 		case 0x70 ... 0x7f:
 			data->ccd_offset = 0x308;
 			k10temp_get_ccd_support(pdev, data, 8);
@@ -502,6 +503,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
-- 
2.34.1

