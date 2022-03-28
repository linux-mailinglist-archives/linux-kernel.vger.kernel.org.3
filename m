Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF64E9D93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiC1Rab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC1Raa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:30:30 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BBC22B15;
        Mon, 28 Mar 2022 10:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn+hEelpX45pwWerAEETcDfAERcjDWhyrmymAxbEQtkZ08PLvq07jA0e1++oHKDsdO2waZW4Ppjyjk8324qOeo44KCJiNkABwGcusqH9XvbgEXJVYnd4YwM1pBMtyKO+Oyu13ulIGRoUqfHmx7DNplmgjHIKihwhpyzD9tuHFn8p1DK6q10MmBSye2YuGZIaSv855PCsFN/IgkEXnQZp3ymA6+WykumDl7YGnA2ZLPVao2czm+roRq1k1oc60157iEJZCZrNhKcxAtwwAkExS7sz6wC0hQbOEah8KDpWkqOiwylG52V5dJmUY0+AG6VR6SV/M6tLEPrudUPMlnEyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQPj50rciPaPQPIyTRgZvr8KCtgIs//AyIn+iR6C4j8=;
 b=blX94PvnzioxttrWViVg35Y11fJ4u6mU1CwjoTsAuJqnu20QyWJKdS+0xlYKMcOb36CDZZfjoaLkBY9PJzLnaboHRiA5ZSGryKlw28wj/emU8BlYr6DAwMFtYRezkdYICUyYNv8fR3WCTctKf+4H+nao2k657pRHWRUSOqo4G311YrltGUyZdjRIupAtHIsxLSQMubTtbu/as2bvvmjToG9vHu1KpzvoPlHyrUcqsk3L5xCQqLcKZLhlC2UgZDeeYOo2cH8YfSWn3aDNCDDOxE/Nuf27jFe9mWFEkhBQSj5qNIcTm9eTfTja2W0gr9r1RgMLraA1vhZxKypB33i01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQPj50rciPaPQPIyTRgZvr8KCtgIs//AyIn+iR6C4j8=;
 b=GM/hJ6IH0bGFiSJ4/w2AeSFHEHB9KavkNnlrURdLix2TpV1LxcNnikaluD7Dzx+A25+n7++Ya+klEn4uh2+w2vJmkVyLGktxKoLv+pOcTwfbzifzHJdw7Y9/zy8bnPozChrMt4C/TMvuEloJGyovxeilDJfaAzXXmu4PDCTIjE4=
Received: from BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::20)
 by MWHPR12MB1293.namprd12.prod.outlook.com (2603:10b6:300:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 17:28:46 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::5b) by BN9P221CA0015.outlook.office365.com
 (2603:10b6:408:10a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Mon, 28 Mar 2022 17:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 17:28:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:28:43 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <joro@8bytes.org>,
        <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>,
        <vasant.hegde@amd.com>
CC:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3 0/2] x86 IOMMU Documentation updates
Date:   Mon, 28 Mar 2022 13:28:27 -0400
Message-ID: <20220328172829.718235-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d841889-5488-44c2-15df-08da10e0698f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1293:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1293A2EA389C671D0CBDBA35F71D9@MWHPR12MB1293.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKMJ0V3HsYZSIJUOugiwQNGyymrx4uD9z99IRijPOtgpb3pbrka/Oz8tvStmpzWKfl78dun2cfxB/7luPNL/HRRuVLVZoqjXEk0+gDMycbNZNNqyOg3v2MvtvcvaUHQbGoZOvubooLGsCCTtaXk5mZo4q75jKRmwu0KfwTbXLpp9En1Ho62DOfwwB1uHvSLtHbwQL/nQEYJioQYVrWm8zyhBheycdstcno5q/zg8GpnpvHOjhufs39PDuBVzkj3kvdLFkJ3K4xeCtLzDn0Z0isUPeajUwUwJoYHzOUQ8t+aaHdiDt8nJHUz0z6EglFej/5aedQYpfyh6AjJNx8nVEw4d6KpVOq5hcgZPs6jE4H0O9QzqEcR1uccBge566HLyI2DnphricRvLw0nMlt3MQp3ux/lSNawTFQgL6QyvqWoB4y0Ui8Cwoyq0QeqY3GIgKwYCTo1WbxWW02BW7Hb7mObHkHq5EL2X9/vKKbtfTxNX8supkO1+nsBP7hO/Pg9YP+fp4axbwPr1g/UsW+p5CxnKx0orOMid68vf4ZGz2vd853pDnUmc6M5Axr7tCaaNuoNlYJ3UE2bQvKW9wLB0XnRP8vE++ulRjzq70L9O+c2AKuxgry4hvL8bsbHJvzlSsWChfpAi5DS+Sf8TVWH+fxfcpL87GdPmF38kRmAWd1QgTumXCIrnpRDHmweDxIrTpykY4H0tvFVztgSofEFqSjKUihK9t0Xc6ZWOCRafqm0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(4326008)(7416002)(47076005)(36860700001)(81166007)(70206006)(70586007)(356005)(8676002)(1076003)(36756003)(921005)(5660300002)(110136005)(316002)(83380400001)(2616005)(82310400004)(15650500001)(2906002)(40460700003)(26005)(186003)(16526019)(4744005)(6636002)(336012)(7696005)(6666004)(508600001)(86362001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:28:45.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d841889-5488-44c2-15df-08da10e0698f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was originally just a patch to add an AMD IOMMU
documentation page, but grew into some cleanup of the
Intel IOMMU documentation page.

v2: AMD documentation rework
    Add Intel Updates
v3: Further documentation reworks

Alex Deucher (2):
  Documentation: x86: Add documentation for AMD IOMMU
  Documentation: x86: Clarify Intel IOMMU documentation

 Documentation/x86/amd-iommu.rst   | 69 +++++++++++++++++++++++++++++++
 Documentation/x86/index.rst       |  1 +
 Documentation/x86/intel-iommu.rst | 13 +++---
 3 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/x86/amd-iommu.rst

-- 
2.35.1

