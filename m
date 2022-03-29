Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528134EA4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiC2CBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiC2CBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:01:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105882DABC;
        Mon, 28 Mar 2022 19:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDGlRmU4fiL2Vs4PAjHdZf1xmMMUc5hPe4L0j/sigXntABXGMwWdEPRfeaYvKsMGpACInVWOfnj0ydMg1f9EaN4lLIMfl2OnL6G3H9Z6qbqvAo91dQWULcTjXf2PUEveVAeDOBBwBc2mk9hupfaew5aEfdPhVD7AQM6cIdNmKbniUC97SWJZeW3T9zzoSMmer+uithI+9h1joV1/4S4E9QlkaVpOqq+2dCFlchaxvGmS4989AfG5KVBjUKg0xrczhn99mzOV/PNzodezN+hb6JTx0UZFyCL1rlg3kHyiT49DAywFrTCFPKf5ddLJtE2THBaglrQoOW57ij9oqjhzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R9CutUOCPj83R0gfrxiFPsR2YFMa4Uon1fvdCtIkLw=;
 b=EALR4oO/n4S5zta8bYtFS4fiMx1QQjU9fLAWdf2QGMKpCj3JtD7lsbeqd0GEQy77dtdmXOgtZPOXK++Dn654MRFIkA2Tlv3QFn84ZFIOYDk8dW17I1zwMIusfJ0EwMriBdR1VINTMe3CDNA1FbiOHHak2to/VRtEFeUBrwGaxYJTOSYL5sA7sBagrWKS0/UPzUIgYPrV34jcrukypE6uPgb6J572GlT1EDB/f2eVTDcHClQtltiHCzudaW0sPpCEpLG+ySh8nvujP2CdM9qT8InbuEyMgppDdvlHmfrX2axIQp6uAaIq7R1YKI/30O9q0XWjGye053EDufcZTf8PdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R9CutUOCPj83R0gfrxiFPsR2YFMa4Uon1fvdCtIkLw=;
 b=k6xjCa8LaY1PSVSSWbKLcPwaKtg3POA4RZZZKEXq9ApVXXazzSMOUtT+n9RAzV9pQsrOU/EDJ9TgAiwwgnjY/SJ0seIHSmIqfQslgKIgzuHcSXhJ+I7Te65P90Ma+0GLX2bXKhTJH2iimy6AvZuVdSdxhAEyN0gw/RsXs6YStd8=
Received: from DS7PR03CA0246.namprd03.prod.outlook.com (2603:10b6:5:3b3::11)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 01:59:58 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::7c) by DS7PR03CA0246.outlook.office365.com
 (2603:10b6:5:3b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 01:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 01:59:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 20:59:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] Improve usability for amd-pstate
Date:   Mon, 28 Mar 2022 20:59:44 -0500
Message-ID: <20220329015947.565-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c8167e-01e5-4128-dbda-08da1127d394
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4575069DA5BAB57CA9B209DBE21E9@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM2ERgQ9+Qfn4VgRP9gQbPoa1tDhY4tYsYpFaOEXDKh0jpPiDEDSmFuaHPpTGKxKMrM/izAw76syabhDBRq2IO7oikZvAgmvWpIPq3zGeozayMXpCV/bWEEBA2MR3rDi+dZt/ImflT3lk0FHZb3mJfg1qU8uXPh3eIe/xMU6t8hkxBeqGvpCe7jFcvDV3bOgkiyHUJJeq5SDFe6xsV4PLdbVcY6j/sGJVTDhskbyxrVRx1bWmISsgtXHROuRFoLI2u/PnREIQsD/e/oWUXZY/XI9f32wWlxTpKAV6CwqnuXmeokcJ8vo6vNWypoHuEagzDWcoFtR1tbVCv2EH7ZcN1NSvoi0naLqnQr7nLTa7WMpZfPTIwd4MtfIVvOlk7LE3PHOqKk7MZgO+Sc75n7gFLfzM1gKF/4sipJE+Q2pF4R4kXTFAD6mMtKiAr6QEpoZ8OugsDbRMdliUcwI9jLg3KnjYFDUYe7iT0HY+w09PTgjaETqmFfDYrLaniKdjj7kr7lxT1rPjBY99KcinwECTOGjDpekjq61gSydhAP3Zzws7mYP2jf85C7urh9dQN73uRbXlbp9gJlwCiwqwOc9Xwp9Me9/XDDv8QJHCCihm0BDOGUhmKsj3kQ7iXwM/7JqJGGmOiuITw0afNmxUWANaeSF01BHWo4P5aq3hbzsK0UcpRTNs11C2JBhFfYg+ZjeEJyGp9RGoDW/RPPmpVEOtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(6666004)(316002)(44832011)(8936002)(70586007)(8676002)(40460700003)(82310400004)(70206006)(336012)(2906002)(16526019)(2616005)(26005)(426003)(186003)(1076003)(86362001)(83380400001)(36756003)(36860700001)(5660300002)(508600001)(4326008)(110136005)(47076005)(81166007)(54906003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 01:59:57.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c8167e-01e5-4128-dbda-08da1127d394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
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
  cpufreq: Export acpu_cpufreq_exit for other drivers to call
  cpufreq: amd-pstate: Allow replacing acpi-cpufreq when loaded
  cpufreq: amd-pstate: Add a module device table

 drivers/cpufreq/acpi-cpufreq.c |  3 ++-
 drivers/cpufreq/amd-pstate.c   | 30 +++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.34.1

