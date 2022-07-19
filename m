Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B957A782
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiGSTxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiGSTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:53:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4452E77;
        Tue, 19 Jul 2022 12:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ3XeF+rJp7Efe8EVfimRSZ6SJd68EiFQznpguLvEh8jGslU7lyEradM6YwFRr0JxZf42I0mlNKxOO/uD9qWFKRMHcA0oUHugu4oPS2mQ0YJCmEGDHKvYhH3qEqmlKwk3KvDglEuofJlXD19o8mLP67UfUN1umZKBCHfHu3V3X+qKfckD9JpX+laecvgTJgXslyCuSNZHcfTm4DJhZPkOm64TE8IKBL153wyfhvSUjQkYbCrGzH6cAxL7CnId7PrX4btnWbEF0cB6dTiwBJFjiqXnl5pCPOcze3ohrzW0tDU9oiVCFTsyh7n4H6WsowgCIAOvE1o6XpDLaZv32bsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8zwTczDi24eqFhyqMZ4iz1NlLs4MT8GsAknQpqYlV4=;
 b=JcEoP9hZroBUr/CFe/dKXrpWb/IVlJLWelwXq6aG0o/gTEv3vWfIcEM25BE6RsNHVgdRVAQeBzKzPHozdxWLsIpeimKhV6E+oJL2TbrGvKfrKzxB+N10vwfux4oe2b+C0lW47YTTgg/f0tMTIS7MRk4ssstz2U6dUoCmEh8tKRHq2hZ4kE7pP+C7HuWLO/NpcL18GxcD/3uIkY9dh9Fh2tlnOpDjFOaUNOIyTsw810Ys11gneTkYgLEOIa33usqKHaOuQ53wR7P5XfDz/zD94Qu5ZHhoT5cKzpZjhbMrXr9RbzYbvSRGexU4YJnHULdtWbh1En5lME1YiN+ON20o0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8zwTczDi24eqFhyqMZ4iz1NlLs4MT8GsAknQpqYlV4=;
 b=xLJ3ZyShUzINiVm18+QVtmJ439FMahc1JGTXBxFf2b0RwDTbUrCS4ntGZs25HE5THfemXM42P4bhbWBdL6oQ9Ce+jL+PCYgxZ1DIBPSbECYL80Y9NishGMfQMsa5Mf8vPJlgarOHrcmJq9G1sJVTdcn59Xpc7nGSV+KeGPJqHkE=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by BYAPR12MB3558.namprd12.prod.outlook.com (2603:10b6:a03:aa::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 19:53:02 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::d) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 19:53:02 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 14:52:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 RESEND 5/6] hwmon: (k10temp): Add support for family 19h models 70h-7Fh
Date:   Tue, 19 Jul 2022 14:52:55 -0500
Message-ID: <20220719195256.1516-6-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e020b19c-931b-4b42-bfe0-08da69c04a3a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NjnU67EMdDG6fTxpLhVKNOewfIqxSuDFhXImsVZf0UhsS3rgqqJmFwnTcXq/m8g1Co84lK91fY3xN3r26LhVOmMToDlsCrC7yphkvnFSnQBg1Z75F31+b1hDFZ7zICbqu43cNVnx+dcDST9MJXTleN92IYczo3E0A7b5HPutzxnQD6rzLK4mimpVDIZhAQjVmOnaWZg/IfTxwY2rI+Ckljqbz7IJ+MKCKuvax3w+i2z6UFR1VmzUAgJptYvLpSPaSFjNPTXNoXPi/L7D8pc9uygwrAgab7IZj+rnQ3oZrvqXKmeqypnMmhhZUZvwsGd0QY8uMJ6LYZtLUmWTdZ/kqBKFvPve8Y2entG58v5D4G6A2Q8ZTg2XDenxsmVlqPVkzmnSYcmxW5SOT4YsxdcJN7B57uPlYU3nw0yECZdSJWwfg/a3HRJNUtrUJ4daMgbSc3qCOdxtjL3ZPmaeOpVb/Eyl0XvlAXJ90HWm34N43hjBtw5Sy0VcFpHGsoJEkGOJw+nH6vOqM3lBV/Xue5Zn1DVkoANydQ5vP6LJ1j2bSg3ETY09v+3/iIcCjp1ygjNMpWHXWU67oIw8u4mrhDgmYOBNEsRQ5Kh1V/XoFAJ9cQnbK7/OQHn5D7MHCNWyVqWYmdLmIpJYWasfiEaJYAnhSmwauD35WDfQPw30u2xkTCGO0C0SbbGoZdhNAqFy2Wv88K5903OGl/SLRd9e5rsc7ZjdxI1Jmhjwn/dXXP6DKeFbZZMHG1ZgqAQ1FwVysatlRitOTd6rAcKNbsBBSNC6Vb7yZbprpokIPfNdMBWS37NdZ43dnts1eeTcJDAak26WO3iWX5KVZNuhBeJDAQjEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(40470700004)(46966006)(6666004)(7696005)(2616005)(36860700001)(26005)(1076003)(41300700001)(186003)(47076005)(336012)(426003)(2906002)(82310400005)(54906003)(16526019)(40480700001)(40460700003)(44832011)(110136005)(356005)(478600001)(4326008)(70206006)(70586007)(8936002)(8676002)(82740400003)(86362001)(81166007)(316002)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:53:02.4473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e020b19c-931b-4b42-bfe0-08da69c04a3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3558
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for CCD offsets used on family 19h models 70h-7Fh.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5f831e74bc51b..5f37e2e7833e7 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -449,6 +449,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x300;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0x70 ... 0x7f:
+			data->ccd_offset = 0x308;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		case 0x10 ... 0x1f:
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
@@ -498,6 +502,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.25.1

