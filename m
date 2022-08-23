Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F112B59ECC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiHWTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiHWTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:47:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3179605;
        Tue, 23 Aug 2022 11:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAX0MBZlCRhbw2jt9Nm8/ec2UaX4BfPKVQrCTPGa1s5zdRxf/a33/x+ki+dX2nvYTxzn0Updqaj+7goROMHuP3TLqKNSbnUHpVgEw1FGfb+jBawYQ6J2q7jbZwZgC/Se2l1nuUwelJ8X8mLTpx1wrES8bqfUfAUEd3IPy39Ftcncq2cUvX1uwgt5b4sWQkos1WuORAqOp5uLc23s558iWzSLB8JrzyQ2qEa4VIb++Y1HIdwre440LASXKs6LP/Dn5YnbJl3YCVm4NT/1vG50lGhGKbjTeViJh+fDYRHcxBMzDsGwUQHNxIN0zCGr0yWWur+RKi97JaFAUME06EsHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOjihs+/5T2UmkgRK9u9+nEiv7mkIeFTpusPatRYh1Q=;
 b=am0iiL1EyQoDNz8Z3+UFfsH8tvEsXwklCRKoPHXANPnSpk5Qv5T/qk2rJgR0PHJOynYPbPUB4PVtJhx0qKxy2NQOw8UIE7mEuyd4Yw2/assVMXW6vSq0YpBMkjko6B2Z8AoQZIIa23tnmVjA1l1037DdDt/arBevdhvIegoHpdpZbs2VjysIUf1W8rZAtL87Uhq2hKiy56jjqCp9rCbvf6KYI2B4wTKPNVhYZM4YYtVbZ8qBsPrdXGHbgk5r4fdCLt782Fgca+p2Z6lfn/6gg9kcI7LmzCDMCEvR/r0Q7BnwY6m0/5iAumz1uXswsoI9Xk4EtXlUZ51L1rBAQkE8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOjihs+/5T2UmkgRK9u9+nEiv7mkIeFTpusPatRYh1Q=;
 b=ZnlDteVLvCUqHfb0AULKkYnDmTKIQMWaD03mhmvvNqvE19cRS8acqOCwXYvQIzKALMNC5TYDXduam4YsUyy99l6vdrYLdxzeguukjZUvvfypoJKplhY3UruvHndHw/rno2mmBHW0W8P4xlJ1vATesjebMsKNfLt5l6LqBrGSy7U=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 18:51:22 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::25) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Tue, 23 Aug 2022 18:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 23 Aug 2022 18:51:21 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 13:51:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <nouveau@lists.freedesktop.org>, <hdegoede@redhat.com>,
        <ddadap@nvidia.com>, <Dell.Client.Kernel@dell.com>,
        <kai.heng.feng@canonical.com>, <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Remove Linux specific _OSI strings
Date:   Tue, 23 Aug 2022 13:51:30 -0500
Message-ID: <20220823185134.14464-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0313c3af-145e-46e6-aa8e-08da853878d1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+Ly+QvEZ+EIZ5HREmUtCVoKujwI6AFSUbujz3IZVxHSVImxlhfntxqcQE+dThO8LJOeg27ZtEdpbsoEUW+inBoJ4wpQJoTAAOgHX7z+E2A289ExDrCUdbxgVidli2Af5aXM1+EmFpK1nIkwOkJJeKh1dx5ZdaC8w9VMbOH4AY2wwBLMo8pEq/oj0cTcBjnMIlEBGh1sNZGhbboJkuZSLcxaWU7xo7TP/cNTmEuqxlZHZRpELNP7H+lOUU6Gtt5DDiZ0JUa/9bN0Wh0y+ReNDkn6f6MCKZnX3e2f1gJ1mcB38WpgohozftYjzf6MtoGwfUO2rRIxWe/dYCJhi+HFBdFWHpbpR1px1Grw/1XrPBvfWAPHi7Rgak556T7rycLS8hueePA+dVoU6jtSlHczKHO0c4mczuoZku6FOtro69Gd7civdR0GaWP9wwVaoVNhOQqABPeUw69fEtBUEVC9XFCfI50y763Q8PB9kUSV0Ftv+PpBenH0kks+jafXu3wP65ShXPLlA+F7x0RBLNikf/YIRoApVXDmH6j3cDvvBb4LRSx5lIwoFmQ/Ah5qYALxhI/2LLu/AQDXZsaAULbS1eObyPfyyO9Jhbvr2BCJItUbhtx6KEU5w7aDJ9CvFfDHP2kPcPkAiwsAGUrKBpjsqKFx7oPi0a8LgqqlvvQKKQn11xW7+vbtIOekG3QwBM+IA5nBcAxIqH+xYm8qeuKapf3baf8+FJA+Ye0ibdhl2CPNtM71WprXMd/SMKC64MwQ086/KrGQgXRVd3wnCtMlkw2aTA6rdCXH8jdZrCB9nGrYZjxrsiYm1Bz8h6eYgxRt+AsEK0QqUYAeuYwACANgqxNBM9UDO5AyT6HN8PePqm4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(40470700004)(46966006)(36840700001)(426003)(478600001)(7696005)(41300700001)(8936002)(1076003)(83380400001)(6666004)(336012)(26005)(186003)(2906002)(2616005)(16526019)(44832011)(40460700003)(5660300002)(7416002)(40480700001)(82310400005)(966005)(316002)(47076005)(54906003)(110136005)(8676002)(86362001)(81166007)(70206006)(4326008)(82740400003)(36860700001)(70586007)(356005)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:51:21.5984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0313c3af-145e-46e6-aa8e-08da853878d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 _OSI strings were introduced in recent years that were intended
to workaround very specific problems found on specific systems.
The idea was supposed to be that these quirks were only used on
those systems, but this proved to be a bad assumption.  I've found
at least one system in the wild where the vendor using the _OSI
string doesn't match the _OSI string and the neither does the use.
So this brings a good time to review keeping those strings in the kernel.

In an RFC discussion of removing the strings it was clarified that all
3 uses in the kernel now have been fixed. As they're fixed, this series
removes those strings and the documentation encouraging their future use.

Link: https://lore.kernel.org/linux-acpi/54f3e05187c4e923b3a746beff3be4071ed0f2e1.camel@redhat.com/T/#m38f84a467f7f13302add169cbe0df8135ef15c62

Mario Limonciello (4):
  ACPI: OSI: Remove Linux-Dell-Video _OSI string
  ACPI: OSI: Remove Linux-Lenovo-NV-HDMI-Audio _OSI string
  ACPI: OSI: Remove Linux-HPI-Hybrid-Graphics _OSI string
  ACPI: OSI: Update Documentation on custom _OSI strings

 Documentation/firmware-guide/acpi/osi.rst | 25 ++++++++++-------------
 drivers/acpi/osi.c                        | 24 ----------------------
 2 files changed, 11 insertions(+), 38 deletions(-)

-- 
2.34.1

