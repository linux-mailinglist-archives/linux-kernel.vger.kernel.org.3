Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1374857661B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiGORdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiGORdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:33:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF6D57;
        Fri, 15 Jul 2022 10:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8ppHVTZO70if2q1NNBdC00ls2rWd/GXpKHb3owrUiLyrptdkwhRkYQvG2D8k0Iyh5p6XMCc0SOV/yZ6QGqVLYVRXi8CtiPt5DpUvNakgs62KlXGieUlV+F8oX2Y30rz0vzH1v8pUm87n65PAQPUnVMG/LmfPSCZdv1MbSsPkmF0Iw5+t6RBAdHJsgmnj5JnjsXvOtFE6/gtVajry4H7CzQLy2tRlKdxyrNdFHggAakFqIra61rBGkY9isZgkK8LpZZgsXEpdc3vkG1PrTf3kV8/XVWLaxTGWwoI7C6PWOXB1vEF5f5buEa+8m5KNH/ri4y4LbM7yr3S59uMR4OUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t87lKdiK2Rpp5KBhSnM0JTjkzXf2avPjIUVmeVOaaKk=;
 b=c03uPcazNzP98g6ImCVWcxV703p0D4MIpCXA2TuTXQr9nw/32qy7HY2aX8QTOpnxehhCbVpTOLNO66has7dkuqDgbw6QAPIpazyk0aXceOrQg0qf/w9TACxPFdFdqkBmEuZIeZClOaybRWlLV3NUf62xS8sAcYXQWzDNVyV2fW2Fq+FLLsKURSgy57ECasi19dYklNkQIaraeLpGnqQj1Vl0CEc+sCbn2PD8PGbHEZNtRJWW4SuqQXntQEheX7mczcJiTdtVlCUmC8DhQi9mO0oRYvgnuGkmUEuJqc20WWCkiDVEc9fOCHHhihlsWv/quI4zeMHVmamIp3JpnlXTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t87lKdiK2Rpp5KBhSnM0JTjkzXf2avPjIUVmeVOaaKk=;
 b=bKjQedj0rGY33JGswPJHlzuF85JXY1KYqILbXVGl1jeRk0V9DignsJmgGO3JrWc4Xt9awmEZ0L98oMUCDMEFCnQ3YvBAI7XowUwlDDVdJtyjHzhRtbHQ/MuFyf9ipUkLemHtZ2aseijv6A/lK5Ye2jQ0jLoE4nD9+6NtDf34Zbk=
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Fri, 15 Jul
 2022 17:33:35 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::e7) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Fri, 15 Jul 2022 17:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 17:33:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 12:33:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>
CC:     <perry.yuan@amd.com>,
        =?UTF-8?q?Arek=20Ru=C5=9Bniak?= <arek.rusi@gmail.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: CPPC: Don't require flexible address space if X86_FEATURE_CPPC is supported
Date:   Fri, 15 Jul 2022 12:33:25 -0500
Message-ID: <20220715173326.3578-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 388ded68-60c1-4b32-6dbb-08da668824fe
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5bDBMqsh5Tjm5oO9OyQQM/ew1M0FktKgnIzTtbq3pxJMl6XAeMw8KG28rYalvaTeGtRVk+hRMky+ZPnOW/ojuQfDvpxSPN5RprCUrwd9txicbWAkOm1OLNkc+BhUxv4URZ6j9DzDu91suiNKrgeEKAs2Ik8qndBaPTuPa+uVLhBk3f/7CYGSPlHw+Q9oHT7QGTT9A99XaXAr/F5EzWT/GV+7JeRkp2AfPeO2mHREt/HQoP9cAQqH3ArODq83qa39htMO3bSWTsBhs+SQTU3SM7LGfIyu9QAwdAGKQYacEV4Oj7Ndk8rkOsMJ4i97OyaMhPlrrlFdHIw9doLASotzULawq3ErmJvnCe385/OghcxjEMbytHnWcpQqMD7nffZDxWg39Cdr+/V2nT05b3GTCmoXHrN4JqyYD4IBM+HrhPG5IkybyyH6DIA2Y4QuNwr6qZD9EMSAKobOPT8H+sRJInJ+zfqEcJ4Wu7lSKLBkEIQMH+U8wBQRFzRgvGyW8pj1xh40s0PASdsqaYH9TQQKPTsUOCBWPJE0RGsMN5Y+SyPMAh+er5+BGFo3am7dkbymtos/rmeDf+pfJXnRd7OBwVDNLQ95qXtekHMQrK/dKmXk5WiUxXdCP743+x0XaObeutp+ZxWDVjO9DTDBmLh2eW8skjwupXOTD52ee9QUr8FWMCnnNbF5htPOkc01RgI2X4aRH3NzOF0jB/SHcwo4UGwLS+kCQNduPil/oed/hT2CC82XrRP+A8zJgh3kxH71j2fN9DKuvBZiNEHZdda+1Zko19Li4doEjT4kxPkw7i0fQwIDIrZKmXjkDpUA4PTSC7ZREXK7YTHq8fXElg8vhW7ONprr60VCa6ZemXKHk5W07wRmLhF5lhcd16cjhiY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(82740400003)(66574015)(426003)(2616005)(36756003)(2906002)(8676002)(16526019)(4326008)(336012)(26005)(70206006)(186003)(316002)(5660300002)(966005)(356005)(86362001)(41300700001)(54906003)(1076003)(47076005)(81166007)(478600001)(70586007)(8936002)(40480700001)(7696005)(36860700001)(110136005)(40460700003)(82310400005)(83380400001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 17:33:34.7336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388ded68-60c1-4b32-6dbb-08da668824fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
changed _CPC probing to require flexible address space to be negotiated
for CPPC to work.

However it was observed that this caused a regression for Arek's ROG
Zephyrus G15 GA503QM which previously CPPC worked, but now it stopped
working.

To avoid causing a regression waive this failure when the CPU is known
to support CPPC.

Cc: Pierre Gondois <pierre.gondois@arm.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216248
Fixes: 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
Reported-and-tested-by: Arek Ruśniak <arek.rusi@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6ff1901d7d43..3c6d4ef87be0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -782,7 +782,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 					if (!osc_cpc_flexible_adr_space_confirmed) {
 						pr_debug("Flexible address space capability not supported\n");
-						goto out_free;
+						if (!cpc_supported_by_cpu())
+							goto out_free;
 					}
 
 					addr = ioremap(gas_t->address, gas_t->bit_width/8);
@@ -809,7 +810,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 				}
 				if (!osc_cpc_flexible_adr_space_confirmed) {
 					pr_debug("Flexible address space capability not supported\n");
-					goto out_free;
+					if (!cpc_supported_by_cpu())
+						goto out_free;
 				}
 			} else {
 				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
-- 
2.34.1

