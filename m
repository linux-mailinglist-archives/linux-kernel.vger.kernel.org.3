Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC1258867E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiHCEZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiHCEZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:25:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D8356B8F;
        Tue,  2 Aug 2022 21:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSnb2GHtA6TeFjhEi9A6cFZUlR1DcT85Bt6dzztJmIuXy0h2VO8yds4LA8lC3og4/Vnvi2Ekkx0MvSLhcDEJd11PfpzPTLGUIAITx9G3ET+Qq4R4rfHAUC1ivWonPAVr1c2d9nIwaq0Z8KzouW0VKIIWm//4AOxgYhJ9ChqTQxTy22+guSkTSdM8dra/qAs/i8s2vr+uiDd6vDY+31nrPOWSNrQ7keKAMOI0wCu8h6Pqof1196wbNDDA0EeDZeywgDKuX/SNHvG3EyEO0CJCMGwEzqpv/m0w0QL2g8ELIjlVIthQ5Uv7dKRi3QGKnfWIx548B1TekMrZeJoun7dwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKkoOIjQg6Sky9w/+BsCFXw0eehOURQZHY/s1kbc8O8=;
 b=Z6A1IZD3wXo/EwqG7gWHg1AjdEUKNI9tVUxIrA5iiIzkWIQj/MAve9Tawd7a+nSOp3QWf4uhlR3ezZNI48Oj69yDX3MFIMEEIDfC77pVK5faZpNDam1M7R9/4el69LIXlqSKGr3tmczStEnHiymwG7wa/u9mA5gSOKQRlef1EGEk3ahxr3t30pVo0yMEAM2PXHBlFBWrtQ91rBk9y2BmS5ohgu2se41qTzU/jvt8AsU8grWGPBVfT+5yyPwRIC+5eULMemZMY/dsoaYp+nx5TtQ/z+XYlGzxxmu6opiaT54CZe1tZifW3FqW10nqGCbbyLFQTayHsELHUAsDjkNYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKkoOIjQg6Sky9w/+BsCFXw0eehOURQZHY/s1kbc8O8=;
 b=zfZFc0dwXym2jO6VyWyKdGRFMqXAU++OdsmB4Cni3yiaolIq6FsHxAuzZ1odo3VaM4LYs5IGXyiyjVvuaxR5u7jEnEOCdCrhymFgMy2dAgRiEuJAY8weu4bdjk3B9Bq+14F5yS34/05CL26zbrkzZ2x6R8RLLWj73QcSoyNe3eA=
Received: from MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28)
 by DM5PR12MB1529.namprd12.prod.outlook.com (2603:10b6:4:3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.13; Wed, 3 Aug 2022 04:25:39 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::8) by MW4PR04CA0083.outlook.office365.com
 (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 3 Aug 2022 04:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 04:25:39 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 2 Aug
 2022 23:25:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Pavel Krc <reg.krn@pkrc.net>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] gpiolib: acpi: Add a quirk for Asus UM325UAZ
Date:   Tue, 2 Aug 2022 23:25:00 -0500
Message-ID: <20220803042501.515-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803042501.515-1-mario.limonciello@amd.com>
References: <20220803042501.515-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4f7002-910b-4db2-c550-08da750838a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1529:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYgUQoWwW1cHOWfUvEgb6F1PW9MZ5WdBzab4i5dyIo93yZFcvOLjEF5/YBxDPJBJAgq2pJnx3OizAMqbeNXpFYlmC+v0gz0niyun9sNcDu0uofria9HUH745HHUWioCWw+dzhRB2x2LeEHhoua1ZnTP40v2Q+o+GL3p34Xcta5Q9xqXgs5TS0yLMtpjuKUqgcHZTPFEo9GMLFXlqzcZt6msdSQIHos3fSMAnQyjEZLwGx9fn2Ec6g098lc/BWhFv3Cj+TJctMCus0qi8USbqANzwJbeDpLzSLBtEySMxRRL+q4JBjfYhF3HCMLGUE6eY4cxo3c2RA1Hz5aX8HMEWQZ+CIAfr5IBUUNi2FhbpY8BkuqElPmMTBy2y7IWPKlI6Fmr5kI456XBpjfhbSQKciEcHKqh18/Abiswwt0lhtPlpFRNjHwUKT4+brGfNiA/ffYOKg8nEsKLv0XcwL+X3xdHANzQrTa/jHA07vBS2phbAsmIBcfQB1zFGhOuQFt9Byx8VasZ8Kw6+zfWRvGNc+kkMJyYUF92PvAio0fH/ouE5SJf384mX78jyDI4YIhiFRwIQcAv0k4uTq7tXKwKpwLvDLofcOy0wC4H5ZeIU/PZCBfWN2FqFGtbp2ZBjKw8ltIoObTVWPdaDJmniTr8UdDbBpLb9+YWTvRR8Sn9oz1eJo/tuyoMKUIH2vcOfRHtqFuOnGnNFWgKmdNkcuCDAu/6ik6SW9pi0T7Mt63gnbKkPbWE4U1AHqPebOdYGFgzWYNh46KZU6249hBB3KNbYkgfx5bJLZSeBA1FqpP14FnglP2SMSiLgSVJFRqIcz9EjgK2re+PjQoijhqi+HhLGBpgHu/XlfueylP2FizL2AJvxIrwP0aZE1LdKSo004dhL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(40470700004)(46966006)(83380400001)(8676002)(36756003)(4326008)(8936002)(70586007)(81166007)(5660300002)(40460700003)(36860700001)(86362001)(2906002)(2616005)(336012)(426003)(186003)(70206006)(316002)(40480700001)(54906003)(1076003)(47076005)(110136005)(16526019)(966005)(82740400003)(82310400005)(44832011)(356005)(478600001)(41300700001)(26005)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 04:25:39.5047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4f7002-910b-4db2-c550-08da750838a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asus UM325UAZ has GPIO 18 programmed as both an interrupt and a wake
source, but confirmed with internal team on this design this pin is
floating and shouldn't have been programmed. This causes lots of
spurious IRQs on the system and horrendous battery life.

Add a quirk to ignore attempts to program this pin on this system.

Reported-by: Pavel Krc <reg.krn@pkrc.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216208
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Drop Tested-by tag
 * Add Reviewed by tag

 drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index f993f6f728ad..9c8ab1dc6087 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1573,6 +1573,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "INT33FF:01@0",
 		},
 	},
+	{
+		/*
+		 * Interrupt storm caused from edge triggered floating pin
+		 * Found in BIOS UX325UAZ.300
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216208
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UAZ_UM325UAZ"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@18",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.34.1

