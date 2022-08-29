Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBE5A51C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiH2QaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiH2Q34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:29:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FA6472;
        Mon, 29 Aug 2022 09:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRkvyvT/YQN9atMunPddCGmCHC6JHf9OahPeKqK/zJL79FCJTDbHYN7l7rm5bw/MTNrs4F+lhu6kCsrJV0ZnqB2OpZWA69vhwCdhj5F5t2C3YHNFPxL7I9N9/VxxfUzvdo+YOL5D5wJdbZu2HuAG0edsblWiEcDS3nZeWXXYYuUtikA9WIxrzRYeo3GTjT1ns7PdxqNGSJbD2ZjipmYzncgoerRY7iKUYvAbyrBrWrBfljKgmRYlmvqd9uUuWP2G8EKLFfQnK0Xj7cgGeTiXRldePrUFeohHVQ/myBpF3gwpHja145ez6xUEaBxGv1Y8IcwGBugFrmp5TgL/73eCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi0v7uUIEnygesPe114SRlzMP8pF8bPFzmJOUL0kKTE=;
 b=K80F91tq1gWESU6f6ta3F+BPi2t9B5144Rc+JgdsUqpc0t1BIHrLNtAUk5EbvtSMeDuCYahwIdb/nOLvffw9Wx+e3D73Dwm4HoPJszHxYc5ER0YP3L9fLJZx0YZPswSNEIDYbGvDdR8NAyzkNtTfFBtgjJBrAK2bds/U0HFLoE3vIxUBRxYUQvwthCEHb5kJ2dDU9nHSYKGji3a4+U5887RpkHkEZU2G3vyaunf+D/JnlGMoS+FXGMmFawfuAgr/9Kpqk5aPEHeDb5ra8g7cNLdb2HuK0SJ0FKIULB9jc6r0jKEjT24jW+24Qf2M3ANSVQA1rofLiRmZpDBRNjrvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi0v7uUIEnygesPe114SRlzMP8pF8bPFzmJOUL0kKTE=;
 b=LuZSO7MhAoAqIoToDS0ZdN0yqGnQ3CwNuA5SmGZBWQ3PHHSb0Z/7wNTi8l2mEcc48EV/Ih87f+GiF6c+c+KLI5tiLEA71Ip4PUhnfjzc/eEFph2H2wEpMzPcw9tu111aCaSnHqHLt8KleqAsqZQhEVbT9kSM512N/WKR0ucMiOo=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Mon, 29 Aug
 2022 16:29:48 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::95) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 16:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 16:29:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 11:29:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Add some extra debugging mechanisms for s0i3
Date:   Mon, 29 Aug 2022 11:29:48 -0500
Message-ID: <20220829162953.5947-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3e25b9d-20b4-4c04-6aa8-08da89dbb05f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHk8bSF2fIZ+0N7h0wWQwt7CZyJq5EjlKaoN7O0imyzKKPl+kot5X7sZOB30yUgrMv0BFgcEs1QwytxTj1eqsAuyiag20/+oT4dzkBhVTI79o1FogE2sq8pSKQ68a5OzA4kAJAKxzq3/QVKUIJmM5uipXeM5T1welnrwqezCpwoOwNX53ogcxbd8+WUveXrbaprWNlr6ZaEem6YDPnrOUz5YuizzXNd8Gnmt79uuGF8J278uOuJLY0QNXIUG76/gkYW/PhcQ69ci7JFCbOopm5xC2PLQQ6d+KpWrI1XhxNX/QbgzcMubKXAugq3cW8euO/mAzNb4U5lgJVunF+2GV3yoQd/qIzwQugV4NTAFqjcXkBwuwpNByzJP/brTi2u0HROaIrvU+nYFecDtVcL9RwlimAh/0lw8FZWqWp8L5srS8A9poGzXIMxPmzc8YXHw00jsnzlfSspAOvwfdrOMRsOSh9BtecFQ9eFKlHjgtYXUvqGZA51vQrRE57+ghupSUOjDGQX7Q+AB3Tdwld7OVAL8V8JVOdINEa8Vjv4ImbeHnXmqVYQkkUJ8KF9ORWpceqC/NzssNaxv8o4X3hCyKwdL9+8FGZsc4+zAvrNqeJNPB6S0Dt8DOPS64LFFwoplGhTEI3SydfVUggwg9LGrgqY/M4fulwv94/XZQ8MS3VS2TcTvrxr+N5Pxuhwxjp+MJwO8Bia6358YjZC/cbn4T24Jg2+FBKJ147ZCsWScYFxmYpSo5ccQiaaA4b1z9Obs9jp/xCVUNFo5Zrmc0+b4P7o4aBvS1EOHqT/REnvkhoXRb+azfiS6YAVJNecLshQlpmB0DtpcMXXFsrN2n07rXavXWibyqEhLKfwCQqUOdQ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(40470700004)(46966006)(36840700001)(70586007)(4326008)(110136005)(316002)(54906003)(70206006)(82310400005)(40480700001)(40460700003)(44832011)(5660300002)(2906002)(36860700001)(81166007)(356005)(82740400003)(8936002)(8676002)(36756003)(7696005)(26005)(86362001)(41300700001)(478600001)(83380400001)(16526019)(2616005)(186003)(336012)(426003)(1076003)(47076005)(138113003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:29:47.4357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e25b9d-20b4-4c04-6aa8-08da89dbb05f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
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
  ACPI: s2idle: Add a new ->check() callback for platform_s2idle_ops
  platform/x86/amd: pmc: Add defines for STB events
  platform/x86/amd: pmc: Always write to the STB
  platform/x86/amd: pmc: Add an extra STB message for checking s2idle
    entry

 drivers/acpi/sleep.h           |  1 +
 drivers/acpi/x86/s2idle.c      | 14 ++++++++++++++
 drivers/platform/x86/amd/pmc.c | 32 ++++++++++++++++++++------------
 include/linux/acpi.h           |  1 +
 include/linux/suspend.h        |  1 +
 kernel/power/suspend.c         |  3 +++
 6 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.34.1

