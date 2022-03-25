Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834464E6DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358358AbiCYFni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiCYFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:43:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB45BD18;
        Thu, 24 Mar 2022 22:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF09CPvYqDp8s6jttaQo3nzx5pDH7Heh0GepUaWT1diRmTmh0YFwCCJIxRpW7z9VMjsi2O1eShFKu3dpbTrsyZWRIPLe50Bk+A5NIbF90IFrLR45g3nFB0M4X0/7xsFcmTaNG8e/Foh1T9QahtRW5Aik+c+zuXBxEgyIS1nSVJNkkK/p9yMYrCUi5l0lhGSrFtLoWzDs9sPM3LMxvj0rgdzBvT8NRUSbrU9UecQcn0IHqvYb0Wo06Kn9HaUUzUoPVY+nT1LMGR2Y9k3re9sI3gRCAoh+WRev/aJILVXKY4AaR5ClBn/uKGx16HBioFLsSTf7UtO9dGywmU8dLICmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VakL2jyipt9kDK3hB7ZA0avAy5q3WjHxtNfz3IShezo=;
 b=XNHfrfDIpkqndsODwACUruSgfJrRpwyYzceS5Evm+llUbqQ8e4OLFpz/Se6tRvU+479NU2xkjXa9+e/P7U/Ah7Vb2SYpN0Ezm+NVetehvbMGLO7HooDwFCHjBXo2ZAveiJcIu56kpbIiBco0Y1dNv9/4cypgzmh9CPRDwpP+FuHQY1K4g/fUQDgyDmLwSpSxje/v15cfmULaS6VRfjpzAkrvlNX4BK1HSz9jbgdVRmDhxUi8iJKzhRoQ+Ux5RHzUzYaubGI8ttvTMBqt5XHBrly33h7yGvf7frfXTFjStIwqt8iEPZqemnZ/oXPUMqWHTeeiZ29EEFaR1pORqb2AxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VakL2jyipt9kDK3hB7ZA0avAy5q3WjHxtNfz3IShezo=;
 b=meTI9G4y+mKyKdBveHnYWWDiYU1gqcHnEP90iW3iuX/iFhNCjzi1qg6cI8rwPh3phAoJGHm55zAT6RUiALELDQScqGF1qEL+jhedBuvYrsjfs4QMRSzic5/W5S/3AWhkcZXYjqJfo/aD5LVP48Qnt9odaimqaohh+L0WCsr1aZY=
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by BN6PR12MB1667.namprd12.prod.outlook.com (2603:10b6:405:4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 25 Mar
 2022 05:42:00 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::dc) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Fri, 25 Mar 2022 05:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 05:41:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 00:41:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Improve usability for amd-pstate
Date:   Fri, 25 Mar 2022 00:42:25 -0500
Message-ID: <20220325054228.5247-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 442b59d2-6193-40b5-9e3c-08da0e222e7b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1667:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB166754966BDF5F18A4482F83E21A9@BN6PR12MB1667.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9mdmUw8rusEdECqrtsSsTv2topJiI5TlweA8J8UeGI8ILr3iZ+zFLcjGA3c4PlQah7HuCwvF6gn6v39lE4hYCLm4Ngm2/wJeJbyLQL4kHTTrWunmdIvj4/dCeQVr9cHqeaopLbhT+ooVqkfvxW1IT3oPACv75XtsXqVWLcA2N214TAbqEOqilD5eSI1eZ2QG8j3mlcrjbpDMeIkRqzfpvYRZH1d5SHM5CaEH4FgTz6jFFcqjF3Odj5KluyDfNFnwCl6KqKWraY+hJ1YI79H6HaI+JpnFf2Cp4VXKG+y+PDM77F8b+XZc2TCqI48KUSXN3oh8/DD62Xb/Xp7AgZ33iJSklbSAOtEo53LIUoWXRkdUF/Ayz9x0zdgVwa1eAedJLLifG8/tQmC/9OQ5DrZKjWVhvz/LhSPHqgikDkEfghTaPupi4jFPPj+RtkWJfwuVniSxa5JxOfWcmw2cp4zWYadPofExGGkx2UgoJ6MrhLT37LlUAwkM6eNe9DrGa3P+aOE/NnvnMVWnf05YF3TIXSpbt2MRxl0lCVwEv7E9IqNx7oyU21a5rNTM0SYmlmwnMTcB/9m1LaPr8+NxzB/lnLcMQ2ItJ0jNkxQldDdTBorng/pBtjGG0YFQNH54t0d6aZ8fY/SGPxLmq49ALjuyL02yUMUs8JludVCP4Di4QBWqLgTIV1U7/flwiI8MBwsQdfa1tgL1rBGCTHlmTLKuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(8676002)(47076005)(4326008)(16526019)(316002)(81166007)(83380400001)(70206006)(110136005)(54906003)(70586007)(186003)(426003)(336012)(36860700001)(508600001)(1076003)(26005)(44832011)(8936002)(86362001)(82310400004)(2906002)(356005)(7696005)(36756003)(6666004)(2616005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 05:41:59.6001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442b59d2-6193-40b5-9e3c-08da0e222e7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1667
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has recently been some news coverage about `amd-pstate` being in
5.17, but this news also mentioned that it's a bit difficult to use.

You need to either block init calls, or compile the module into the kernel
to force it to take precedence over acpi-cpufreq.

This series aims to improve the usability of amd-pstate so that distros
can compile as a module, but users can still use it (relatively) easily.

A new module parameter is included that will force amd-pstate to take
precedence and a module table to let it load automatically on such systems.

With the patches in this series a user can make a file
/etc/modprobe.d/amd-pstate.conf:

options amd-pstate replace=1

Then upon the next reboot amd-pstate should load automatically even if
acpi-cpufreq was included on the system.
Mario Limonciello (3):
  cpufreq: Allow passing NULL as the argument for unregistering a driver
  cpufreq: amd-pstate: Allow replacing existing cpufreq drivers when
    loaded
  cpufreq: amd-pstate: Add a module device table

 drivers/cpufreq/amd-pstate.c | 19 ++++++++++++++++---
 drivers/cpufreq/cpufreq.c    |  4 ++--
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.34.1

