Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FFA5852CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiG2Pgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiG2Pgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:36:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A018688A;
        Fri, 29 Jul 2022 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvwVkDxShns79GLs6f+LTJi6flKMLCocgeWAiFtfgjBWGkUCuCtxJzuxj2oRl/vRNkHTFtxvv0FF0zfkQkJdV4Ng4Q/DVtSF9vF9cRjOGvQ+VEU4znefmEqvjtPezmWGfNyMnHqqechFTMjqYhw/GCoEMYzz9CT6W1oBT8abb95QGenwFLU3dv1wd47MuDSKhct0v+1id3GFh/fJh8HNoONizawHujFcijmGaD4LTE5we4lWVuiSmDZUxrmsAA4dk4HoZYr7dJ+x7S2vYtDnDbZJ90yR7qyOxpA1/8T0szI9ON307JNZEpHnudU+U7NiQdUUSm3dbgcSMIi9LzF6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2FIhRaBuRAB0tkV6ZfOQqI0+Vk9NZvzVPc10iqR/Hs=;
 b=jONGWdMHbBx5QQ+RlhfLcnvg/2jA8moC05uJ0m0/e7ictxcmRC1IlEJb1xbtonUUBSeZyG0Qqs89gybv3fDXqTw+HtPNzMd5flKSrSu8zaDMMYrabxdw+c/rMk3XjXWbal+WyMV2LSZkbmu8B2a07PiIt8RobXWkDSQgjHWLLFN+/CO1wO4nDb0+hlcFEIrh0BQ0dIqt793uaDuMGn4sg0A1wrO7BDbHAOBBkaPuMDKb35vTNUYbY2ywvXKkZ09pLtCVoWLBJkjFWJKIDAcIhdTBAHZbgzAcSgq/9JZgF1TUR/sazlf5VLBinhKKpZTLV4T9eJlf1atpk4YElNuO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2FIhRaBuRAB0tkV6ZfOQqI0+Vk9NZvzVPc10iqR/Hs=;
 b=kPi3OxIAECY2chzmX+jckBXXt9IH776XBCrGsPi847YFtRY4NUcw4bo6ZWcq+K/+qrXlh5mbbd5YckjokovpPIToYWIDi/siEYAT9DKbJuf22XFRnm34jA6FY2C6oOvXtmPE+CBZKb7g3cDr1kEOO+gLwrozQ528txHJZYijUvU=
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 15:36:42 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::92) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Fri, 29 Jul 2022 15:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 15:36:42 +0000
Received: from ethanolx5619host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 10:36:30 -0500
From:   Jay Lu <jaylu102@amd.com>
To:     <jaylu102@amd.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <xueshuai@linux.alibaba.com>
CC:     <terry.bowman@amd.com>, <yazen.ghannam@amd.com>,
        <smita.koralahallichannabasappa@amd.com>, <robert.richter@amd.com>,
        <linux-acpi@vger.kernel.org>, <jayakumar.govindankalivu@amd.com>
Subject: [PATCH 3/3] ACPI, APEI, EINJ: Add support for new CXL error types
Date:   Fri, 29 Jul 2022 10:35:50 -0500
Message-ID: <20220729153550.181209-4-jaylu102@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220729153550.181209-1-jaylu102@amd.com>
References: <20220729153550.181209-1-jaylu102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d00e37b-4d3b-44a6-2ec2-08da717822ed
X-MS-TrafficTypeDiagnostic: SA1PR12MB6728:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QYS3gv9qkY3EwJP5Ja2N1GjXwvq+68dj+7SD+nnE4CYV0xHlbAd6qUXlmJSrblHc2qs/OVg2dd4NClh316FWJDYjBb/P1Lx52uYOkR/Iz5q76tyxaZxXLGA7i2XPfKcwALdYJuKkNS9IBjX7PFffrigAVHeaaUqAVtgNiNXFGOAn4eInhiAepSNKM2aYrzp9IZDeZhzfmmM8O0sfx+gzhwjPrZQ/DWz4RswcSCau8VM4GCoOMBP6Nha+zDRsuG26qjAUA/qhIMPrYF3wHj81Gpv6xg5/5U9KVfJ5Pzc3ENz+pCtoaxb8alY0j6b4DBhS1ecE3IwvykaZL5PpiteS9OVm7RdAH0mfhk5EtDCUXoSCLpBSSBFmNj0gPwvKGL5ibma1hOTk9K7INYPAR9ppP2vH+OnJ24UtmJ8JT4CoFQbWXpO9YBYX6RGLiceqv1DFWOCUdUFuoDuFQLMJk09Ek+yNfIZynSvUMiXQ/0U8CnMRlyTF++AqYp7caxEOuCHxJKbcEAw+c6b7wZMsFtJ0X54g9/KLx4kosQc1nG48zi52vYdWTAsaODRRKTN81bJCK3P0y9zQeBRV605vzHoJYL6j9Y70KF9R0ba8ad2FpwO/dAX+gCQdFtyyTuch9kMAUaK5ZRLGnvrwTBd8ban69lpm8Mqe7IIr9UyxjPEKLpNLkdW4Ss/OtKBwm00UG5EGAkFirCR/9XhoqA4UnUZ5iAX6udCNGsXXtfsNx7zpjI3NlxZQk8WkVvFy8ntszIdLB6kW4hHLcvbv+lZ2xRzPMU9Z7uz2MdiWdjUgxgK3VLjymzmcGeyi+ZwLD25o3jg7MhHlaIZDSuMivvVt0TnN0L8AM1E2MWbHB2yWFZRGpE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(40470700004)(36840700001)(46966006)(478600001)(70206006)(70586007)(4326008)(36860700001)(8936002)(82740400003)(83380400001)(16526019)(8676002)(36756003)(7416002)(54906003)(110136005)(316002)(2906002)(6666004)(5660300002)(7696005)(2616005)(426003)(41300700001)(1076003)(336012)(356005)(921005)(40480700001)(40460700003)(26005)(81166007)(82310400005)(186003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 15:36:42.0767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d00e37b-4d3b-44a6-2ec2-08da717822ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EINJ module allows new CXL error types to be passed through sysfs
interface, but it doesn't advertise new CXL error types in sysfs.
Update EINJ so that it displays new CXL errors.

Signed-off-by: Jay Lu <jaylu102@amd.com>
---
 drivers/acpi/apei/einj.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index a68103280f74..4aed0eab329e 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -582,6 +582,12 @@ static const char * const einj_error_type_string[] = {
 	"0x00000200\tPlatform Correctable\n",                           /* bit 9  */
 	"0x00000400\tPlatform Uncorrectable non-fatal\n",               /* bit 10 */
 	"0x00000800\tPlatform Uncorrectable fatal\n",                   /* bit 11 */
+	"0x00001000\tCXL.cache Protocol Correctable\n",                 /* bit 12 */
+	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",     /* bit 13 */
+	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",         /* bit 14 */
+	"0x00008000\tCXL.mem Protocol Correctable\n",                   /* bit 15 */
+	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",       /* bit 16 */
+	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",           /* bit 17 */
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
-- 
2.27.0

