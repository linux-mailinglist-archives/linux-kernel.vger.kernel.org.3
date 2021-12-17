Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE9478847
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhLQJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:56:45 -0500
Received: from mail-dm3nam07on2078.outbound.protection.outlook.com ([40.107.95.78]:4999
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhLQJ4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:56:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPHX7s/GXdcp9QRbkCBlWfdhi9lRmofxjO+sAKr8c1o+gkb53XZH1lvwp6OlYupD8aTFkbC7PgJ6avU+hGWYBa6dLBQkgq3pQKSO7ce13LH4Bz+0hfaMXk8iRFbupidlHERpVQGZi6ST0Ii6hmRZj+Ry+ctsnE88J3HoZ8V0bLmt5LB5yQ+gnl8lVGMJxQVMSFa0WZmsU1e/69wvTdHESpHYr70eof4xRlpVuEsfa8UCmvYRgHDyhg2vz19xotXLqMW/sYVBcPEuH83RHPWRiajDsha/vd9aQqv9fENvBYtUpgX92OXXbGOxDCn5t5ikuweKYES6oZDLuyUk0bhu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZybGgRaNDjmTu26//9eDFA9G2SdOQAMHYsXqj8Zy7os=;
 b=P+MjIyqRwjftpNhbLvM1LuYddmAO63AGdVxUa674gmUkf19OxJg3vxgKF+IQS0UzdMN50sIjKdbVktWuyKblzZmZ+iCUgJmGksgbMuyfYZQu5uiJW6oRpHTD+ts15mz99NIOhrMB81JzF1g4TsB0v8Sh/XMtdUxTOnRGdHXI+uwhHFACoLVPdSLYYS6oQOlE4ILOOugJdFketq/Pdo3c3GjOZif7milcjaY8RKljI1Ngg06w131k8yDeZ/1T4L1rXq//AnG4laq64dWKLl+ZfFnMCOxktmqnYEfV+HvASmPDb+TLVsAhImnAJZKj46KwCOVlcms2thBiffa0Qf2nQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZybGgRaNDjmTu26//9eDFA9G2SdOQAMHYsXqj8Zy7os=;
 b=aMEvL2d5VCKoqsg0poWnOEu/rW1SDpdaJEaHuyN0aUKWERqPCrkTDBZ+hCD6vN7EsRWblM3h+SL5zwowVMYXpKsnSDqeSsApdq8AkWJ7FN+vrdM6HWhM8yNLC4AoJ+CejbfaxHNTUNheXAJhcrWMW33Hdr6nq6F07pAH+TPR9tA=
Received: from DM5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:3:12b::11)
 by BYAPR12MB3031.namprd12.prod.outlook.com (2603:10b6:a03:d8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 09:56:39 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::40) by DM5PR04CA0025.outlook.office365.com
 (2603:10b6:3:12b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Fri, 17 Dec 2021 09:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 09:56:38 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 03:56:31 -0600
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <logang@deltatee.com>
CC:     <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        "Sanjay R Mehta" <sanju.mehta@amd.com>
Subject: [PATCH] ntb_hw_amd: Add NTB PCI ID for new gen CPU
Date:   Fri, 17 Dec 2021 03:56:20 -0600
Message-ID: <1639734980-9748-1-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 307850b6-f6ee-4772-1ec1-08d9c14384d7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3031:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3031DD50B35E2D8CF482FB88E5789@BYAPR12MB3031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwMHXirmIoYFhRBy1bkd+2f+BL038zq0UChT19megutovfNcJXMipc+CoWmqFzaqaqjPmHwxtLAwfKU5ItY+WDfB074lS1EWHBBu7btUpCzmtfKzcWolcws1TyH672CYphaJ0pUTIbvaWbH6+19uBc+jUkvK4DbpQvp4/BojesiYUVe88VFfJIGBC9JWufvM0VpQ4csvmMFRGLKtMcRrT081K1FzjPyQTD9mGeatXtYie/pYpW/G1fVjWVWvFbKOsXZhNBDiuXObf7c1FxSn558M9eVSidBKKBM7DOsVcR3eMlUGa6AScMpLnxqq9r1tdqqGb3P02c8AWZZMQznAOThDLMqHJQcU3sn6HP6PbkqQATREN2T83LaUCVxdvJiXAeWOcJLcCOHTfhKCguwgsV7uwA9uhtJt+3ya+zoPF53C7wkYriwb+LsjLc24y7os57kzmjHjmMhTQ1N18MU2tkj3PlaD+7jBvfd8QEhLs3lLs7bnNJM8PdECKBYrP9pE3gQj9wvwJa30GhfdBPWQMdRflkkHK1L6p2uSeBhjuNic/tLNM/OxavjcglDdsypfcHnx6CR1/CNsMHjZPNvgJlSCyjC0vrfa8vPfxeaR6F6STHDeDo857z/+gPKTqELKWmWEO50dympTqmWtY7Fcn9BZG13ZCZkMS6wovWe+YqJodtUMnUh/N3K3ejQVrAmr+ijCQNHGIAc/4vlRQQvhrzOGoEnXGhS8BJuAQvQhz4Uqf2DLaugVCsVdoBEBI0+r9oOZhdhBb/Bq2jF4gAJnnG33aqwBOXNfHM2U+y0McZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(54906003)(2616005)(508600001)(40460700001)(336012)(36860700001)(5660300002)(186003)(26005)(16526019)(8936002)(8676002)(7696005)(4744005)(86362001)(426003)(47076005)(70586007)(70206006)(356005)(82310400004)(36756003)(6666004)(81166007)(110136005)(2906002)(316002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 09:56:38.4427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307850b6-f6ee-4772-1ec1-08d9c14384d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3031
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NTB support for new generation of processor

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 87847c3..04550b1 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1321,6 +1321,8 @@ static const struct ntb_dev_data dev_data[] = {
 static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
-- 
2.7.4

