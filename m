Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F006657A77E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiGSTxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGSTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:53:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173252E4D;
        Tue, 19 Jul 2022 12:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh7Xea4UPg1DZM6PuZKSLJPrGbg1DBHQ3ZOlexx61/BvgMFcA0uRIdzy6vuXrKYKCFyaNqZRc3UpDbkVZ4oZXYOcBVxrd+nCipuaAGmsviujw6ICCInLUzFnKDJ7pXAWRfndqsTwiiz5ctPGTmUaCVoFFYkixiK4XVVHSd3LKPo8XTYjHnMKmvvvdt+4afQ1GyVfoASIE9wyenWFJlhQOfjbAJk+GbmlHX0NmxP5JrDIXXbqwSWiU6iSI238D5W4kT3ns4L73A9X42E6WfPlSgsAEbFLN0xJJ1OPWgc9qQIcMFP3En3nVy8N3CDSszwC76l0zWWulEuHL/VJhECloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf/4mS8pdAWtPeU/haIICWZ4aiTjbd66LzJo/hVfQMw=;
 b=moVWA3Hzl1tXQ3kYcEft12Z90MPitwdax6FknqDJh2YCbVxPTrPvFEOSDPZcAgIEx9qsMVXtCpftmB6+hAxqqe9YSLqe7bRVhvqgdBI/0JVSTEAlnQL1y4ViYn04qYMSnLfPMFxbCR/jcFX2lYZLTGZtRITJl2i1C1BHsf8A+9aTBkJrcz+YM75sujqmv/jizR/FTvEDI7b+MS0v4ZirrLUYKyZsGmwPWoQYhg3G51tC2b/rLVILWByofvgjfd5fYauQDqoUQyDnHEYUlqcxJxRG3HvrR1mv+ajbT0OqzJFSN56U+v1SCeQMTub8+v08rrU5eII18bDADdbLFoYRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf/4mS8pdAWtPeU/haIICWZ4aiTjbd66LzJo/hVfQMw=;
 b=Hf5dJr4lW4JdniQzkV6E5+1zzrXNfY2IuKKRsS+FrCXG277yQtkBOcE4rn2hNw3DUCkMPaUqKJHhxrfwqIQ7PaCMRpvghkol0w2NNWmP6a/wQDW9j0JmZgbx31CRG9CyChqiTGfaUyE7/tgDURrMJVmlLQ2kQGZqjILO0m1m3DU=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by CY4PR12MB1621.namprd12.prod.outlook.com (2603:10b6:910:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Tue, 19 Jul
 2022 19:53:02 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::84) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Tue, 19 Jul 2022 19:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 19:53:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 14:52:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 RESEND 4/6] hwmon: (k10temp): Add support for family 17h models A0h-AFh
Date:   Tue, 19 Jul 2022 14:52:54 -0500
Message-ID: <20220719195256.1516-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719195256.1516-1-mario.limonciello@amd.com>
References: <20220719195256.1516-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba06beea-d486-47c0-281a-08da69c049e0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1621:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vINKayfGZz29dm60+axq+u8x4EANwyW5hEOLiYQFCFu9FAbxQX5RLh7gZZXHwZxDDcXTbxlJ6LgyFOiKYZtWJ47t3GpSHGO7VLeUzdazfKR318uduKFhBXSarXfH+yahAJ/6CVHQbByksoOFf/YFBxsaZDmmXyZV3fbbqTF2MsDqtMUs/cGRk1l+6oDTuL/iSMzJRdSw0nZkrvf7Ee15DWBySWO2ga1p573vJ27A2ycRDRB0+2teOwEd196GE881f8tR4ddZ49cnO5wQDSLYO2ydHA2MYnP6NTiUpk4ULwH/QAC0RL0zpcd7QETBQbRzJDZT7NyNwOKYqlUqQN3wlC4vKqRIz/DDCN1kUdcl8xNV1D8lceEt2reOwOSL6qBvfp8NJeEXh0g6AGNG84DP1g5xpT747VIvhCgjvT5lglL2Bj/5d0M8Ew/SPuLHwOidwPIOJAQWC8SEu4r7XipbBJ4BxNXxTQxUAc1UYOqWK/Lc7WPyN3h1N2rbTJRfxNRXYDWGpMZ0maCdNbritxC9+xZPsAHxQ5K4+NcUMvbUZqyTniDsMZyBfCIP221+c9uLusun50gTkuZHFbmvHC4gy7RcYLNgoxT52Jxip+Mz2KlvZN2hEUdO5M/2dFj+7EWW4Z4616d4UB6R78QQXOSc2PP9ES2kaY8KKEj1lwuJ/QO3S+PEaVJiwgxH52EsrxXY7nuhU1aegS9sN+JTCsl8LgxAWU9HkB0/ryOlgiP5/o44rhZZ7cM2BDs9EVIJGtpQ94FIxL0Zl9LvXZHHznYvC1YkD1oUNN03SbMvgA6Apos+luP1T0kHHN2xximm17IjFZb7EIo0A8ql/z7GZg6xvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(36860700001)(4326008)(40480700001)(54906003)(316002)(5660300002)(8936002)(2906002)(40460700003)(82310400005)(44832011)(70586007)(8676002)(16526019)(70206006)(36756003)(356005)(86362001)(41300700001)(6666004)(7696005)(81166007)(336012)(26005)(2616005)(1076003)(186003)(82740400003)(478600001)(47076005)(110136005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:53:01.8536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba06beea-d486-47c0-281a-08da69c049e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1621
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for CCD offsets used on family 17h models A0h-AFh.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 4e239bd75b1da..5f831e74bc51b 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -428,6 +428,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x154;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0xa0 ... 0xaf:
+			data->ccd_offset = 0x300;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x19) {
 		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
@@ -489,6 +493,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
-- 
2.25.1

