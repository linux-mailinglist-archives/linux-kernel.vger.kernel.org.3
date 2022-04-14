Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51AA501999
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiDNRGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiDNRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD14B404;
        Thu, 14 Apr 2022 09:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpttIjVeKs3+t0BgDMICf5feUoJKhx0XrO0uX/chvD5WXxOzyJsGsVBsd4j34AS5Y0zBglzb2qfLgRI6lvhfOSwjn9WZ1vnLnd/kkmh07po5L+QHAFrYu7imzBeECfKziHn3WWhKDOvAzTqF4NV7et9aYbo9eeU1yJC7ytCR+VfJPJnWFbHkTgHvhurTsEaIA3vscAmm0+boBzv1Uz0HEZALEPl3QyNsrf90vG+DmhpDxZpjmjbstUl1uBCMIrApJ/fI4tXlCP9LqKK7DvOFV+E5+qmETSGgJmxgtaWH1xBQ34/Z0WGOgg7j4nFByoNfnbjmTNosj/GqduC2+wiNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/XRSrXUeXyaJHAJgD1WJ9FnTtw0VhYx7EtixnJ6jk0=;
 b=T9hgI3f8wGxhX6pm01O8/5OquoXxsCh7LmQMUzB9f72wfofilquPBSOlpSgzMqvGpWGSK+Gr6v8BxLi7OymkAIR0mCadsVd3dxfiFTUqEQutExOrkgOYQ57tHwcS2QFXu0fvDVe5IsAuJvJ+eD3klW2AHordYhcIc9kenQNtXGaXYnPKxaPvzhIlh++umGiB0rdRB7JssjUQUau44hPbq7zjl5DGLIOnGNVOESzfdu0BoYXkdQrwGvnkOz79uIV0YKn5FkqYM8TMxzRuTezDht0uTMAZBBMPHqgLoRNLBeTPLbOnMcR/O3Ache1RBCCeDYgGaCwwVg+grg+kphcZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/XRSrXUeXyaJHAJgD1WJ9FnTtw0VhYx7EtixnJ6jk0=;
 b=a5VN18WxqChRMKIFVLxD9/Km4GmQWKNW2Oo1ToQOh5gbmeTGTfogvfrLoSShVQd6gumsmpr7l47t4QEEPy9OwnkhZEWvXrKqR8ClqeMjfEKXN0jOiOIQGChgzyI6fnko/PaxKpFIW0/yszJJyvF4bO9K0yyRNDrJRGw2L3w/GHU=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by MW2PR12MB2571.namprd12.prod.outlook.com (2603:10b6:907:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 16:48:13 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::51) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 16:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 16:48:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 11:48:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 0/6] Improve usability for amd-pstate
Date:   Thu, 14 Apr 2022 11:47:55 -0500
Message-ID: <20220414164801.1051-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b18cdf78-41e4-4293-e6e7-08da1e36909a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2571:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2571FC997BBF09B3C9870169E2EF9@MW2PR12MB2571.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7uzFdYaqD5hFNwiOAXVq4XNWFHqOWb3rm6DIQIsRtx49Q1cc1iprjvqeST60QXwJFKDzo+5hNRmKh9qF52gAAfoEStGS1+Qs7l39z6DFZktVK5i4GCbGk67qrOiQNvyLv7kfU4BPOx9hu5y8pr6UZKwrsKYcfDT3HuszGoTSbHcTRBANQMeJO4Sh3R2t0pZEfx4xC6uoA2jjLXo0svuHzvpPMYIkdBcTTMOoJYR6gec0NrMm6xRbL+cfNMofD/MAkQ278oSX5ZsRrxQQv+SGsoCKmgDxK3N4VEfCAd4qAXIqclf97l4JfKXVlKIQMNpUm8ZjADyr/fOBSNOw2sA0Su2lDABvcmChYl/Jhn5mEdQtPSJCyKpKVC+Y4a7TdCgrJcEXwoej2gZ+70PxgCx4VKPXjy2/6G4egpL97bNRRiWRSvzpeoaJWiWbZTUbI0E2JJM4Mv8ie35bXQRGWSIi1OjR1l2dwwABoe8miTYZD54u2A8UJJtPt/KA/MGGnZTRmHmVX04NfQKBUedeJaDnjSKM+3bSqrdZDcBdnca1DLcySRJtqhRyJMJhjOZi8n7B7VYx/lCSBO5B0mj1RSER7YyhgnQm5MmGRn7aWp60qeaCZH+4sXXE6z4jG2ZDFWvMTL2bugmWFlI9H2cE51hBPrLwTxxwCs1QqOX0KJ47D8p77B7n2Re1+634HVQNLH+vyLmxaWMV3rLfvDvRCKjiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(54906003)(316002)(47076005)(6666004)(336012)(36860700001)(86362001)(36756003)(40460700003)(81166007)(356005)(110136005)(82310400005)(83380400001)(426003)(508600001)(1076003)(2906002)(44832011)(70206006)(16526019)(70586007)(5660300002)(8676002)(186003)(8936002)(4326008)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:48:12.8859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18cdf78-41e4-4293-e6e7-08da1e36909a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2571
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
precedence and a module table to let it load automatically on such
systems.

By default with this series it will replace acpi-cpufreq no matter the
module load order.  If users want to prefer acpi-cpufreq when amd-pstate
is a module they can make a modprobe configuration file.

/etc/modprobe.d/amd-pstate.conf:

options amd-pstate replace=0

Mario Limonciello (6):
  cpufreq: Export acpu_cpufreq_exit for other drivers to call
  cpufreq: amd-pstate: Only show shared memory solution message once
  cpufreq: amd-pstate: Move cpufreq driver check later
  cpufreq: amd-pstate: Allow replacing acpi-cpufreq when loaded
  cpufreq: amd-pstate: Add a module device table
  cpufreq: amd-pstate: Default to replace acpi-cpufreq

 drivers/cpufreq/acpi-cpufreq.c | 10 +++++++--
 drivers/cpufreq/amd-pstate.c   | 39 +++++++++++++++++++++++++++++-----
 include/linux/cpufreq.h        |  3 +++
 3 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.34.1

