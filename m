Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560765A3FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH1WVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1WV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:21:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA022F64F;
        Sun, 28 Aug 2022 15:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evuPUiw9GmXLbhn1wWdT0dwEcW5C71LD5bWTd9s3un8mFZIxBLB+XrcPbsJ+sG/SAhMWOyRp4bQcT0NCn86hw1zbrGpsgBN9w2/lYQcHekdUHdf+YotWfk41tzKMEEUvnHEawQ/ie6RwXvBqWw5WPXmNS0HZofs6i4ImCshyk90AWMJTT/RlhSF+UIs4U4Yjm/pAVlEKPWo+lBK2mk5jx8/Em+lVh9vQK4xaIOIxnbEsBN7Jyn49hkxdjd+ocWL7QbUSjxqTrPntV847ra6R5f5XSmywPaiqwOGNK1fXx+Ldbtlr9bECXDRDbN5/tun8Hm8KqiuGdOcrblRz/pse1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bMNnGaEMxu/zy8vQlob6uygehzmobgWYlyjSufmD4g=;
 b=aizjAKo15LKiupXMGqhvezET7KdoK2I9nvqE20avj99hGCNXrsUJZQalkob11KIALOnIF9egHsNzpHBwws7yWuqT5H+FzfQZC4TptmTk9uZNltqU1u6JqqbuWdEr6QOr2WUCn+WcbN6WXmVZjZFga8kXR/mE/06T+cdZhDvaucYm4T6/O5X16oMYYovIGbL+eac9TGJuMfqxcquW+PR0j2+6FjYSuYjSi18iQB2u0K/Lyrz5ZieDsY7jez9g/H+dtT9JYnfQ92/G73EwPNY9mkoNWXAkb0T8Z8Qqeocc0yZNpyl+NL40gkzvjCE9SAVWo9962ODi/G4WB3hPyynzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bMNnGaEMxu/zy8vQlob6uygehzmobgWYlyjSufmD4g=;
 b=YzcrtF5d3zNyuxcGYLZcmdl1GOTHdXTWMpnGhqy/1/vB47Z786eTv6VcVUK7NgzwxkeLoqrmNVN5bUd/f+oTIdYmEhq1TxuUVRKhxp3iXeT+c2Nsx+OFX1hdGkjnPXOZOvqhscOKEXsaNG7twRxOJCglZJ7W1+ZqqfGU7OrNmTI=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by BY5PR12MB3875.namprd12.prod.outlook.com (2603:10b6:a03:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sun, 28 Aug
 2022 22:21:21 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::17) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sun, 28 Aug 2022 22:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sun, 28 Aug 2022 22:21:21 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 28 Aug
 2022 17:21:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Add some extra debugging mechanisms for s0i3
Date:   Sun, 28 Aug 2022 17:21:17 -0500
Message-ID: <20220828222121.4951-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e385a6e-a724-4a22-e4f5-08da8943a2e1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3875:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLQt1Gje9mIQbZnNtztzEwDVViFa7fLfgqtWS5RX6h4DLzynDxTzWDS2a0oQk0xFfVISF0ZC7Opzk3wVB5Ru+lFNECEHyU6Bho9eV8bEE9SIwZOZlKt4awn6okbWs5TkdECu8ROUQSELnYUkQhzg8h4jB80YpV+QlD2C4frzJ1ne3sUUj20h+bWut+YszblrNyt0Pw5OJiDkU1bXYDkI3ZQUSCUdl1ursD0QZ/iR7rp1lme8HyCODoVcRoDSD7Ac3cQWvM31/LWCRBJ2XLMKWlYq2jHT/+Fjej2LUu8IL099lrxFrpWj9F2hAhVX8n5aWaaZ0bD98MOw5vEXZDAT0qyDlmlPo8Gq05tIgcaKqaeFUfVDPkAMtTQssX8FkJgfS2AW8RGJMy8bxZN4KBEVsZytmP61hCk5fYro/BSSnBOA39aQhkddSN/aWm/4mKTJkMBvjPgNPXitQLFEuMeOhLtp5Jz72iXmf5liN2zf1tnLNO5xIGFe0L0ak0PXfjh3clL7vNDGXsHQL0o8R6J345Teb5fObRmE/dUfo139Bk467NYU7kkdwGJWikRMqjhWh+C+KvfA9ohnE7henGoeN8jw1suybSR4Y/1/j+E7PmzZbLU1aJWXwJeTmrxTmGiqsAPjugHyuhYCsRSHYrjxtReAlWH6Xa57M4Blh0y+GMRsU6T7/kff8PTAdnXLQwCqU+nSpj6C6b+LTwf77Q9jQPkeCeBlejlYhORlPxSORyq+2oOqiYrokUcFDpQti9LkbelYz2hVgJMdmi4By5vM6xt+ZPTlvXsGnqO8o1satYECuJb5JYAFbaLuo6fIlo3v1RqHpmSgpAbGSeNVLVsblw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(40470700004)(46966006)(36840700001)(26005)(86362001)(82740400003)(82310400005)(478600001)(6666004)(7696005)(41300700001)(40480700001)(40460700003)(83380400001)(81166007)(356005)(16526019)(336012)(186003)(2616005)(1076003)(426003)(47076005)(36860700001)(2906002)(54906003)(110136005)(5660300002)(8676002)(4326008)(8936002)(316002)(36756003)(44832011)(70206006)(70586007)(138113003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 22:21:21.3780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e385a6e-a724-4a22-e4f5-08da8943a2e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently there have been reports of problems where the system consumes
too much power after certain interrupts occur that would notify the
kernel of some event but those events aren't marked for wakeup.

These problems have been root caused to the timing of the kernel moving
the cores into ACPI C3 relative to other events from the previous wakeup
not being settled.  Linux will more aggressively move the cores into C3
for s2idle than Windows does for Modern Standby.

To aide with debugging this class of problems in the future add a new
set of optional debugging infrastructure.

Mario Limonciello (4):
  ACPI: s2idle: Add a new ->enter() callback for platform_s2idle_ops
  platform/x86/amd: pmc: Add defines for STB events
  platform/x86/amd: pmc: Always write to the STB
  platform/x86/amd: pmc: Add an extra STB message for entering s2idle

 drivers/acpi/x86/s2idle.c      | 14 ++++++++++++++
 drivers/platform/x86/amd/pmc.c | 33 +++++++++++++++++++++------------
 include/linux/acpi.h           |  1 +
 include/linux/suspend.h        |  1 +
 kernel/power/suspend.c         |  3 +++
 5 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.34.1

