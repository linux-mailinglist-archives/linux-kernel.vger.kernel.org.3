Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820E2532F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiEXRFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiEXRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:05:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD17938B;
        Tue, 24 May 2022 10:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEalL9Jw2LCKmOmaRx0GqbRlGob++rH4tUrTOEEH7DIYCdfRVULo64SKG8ysPGCYe2V2SqFUxuqHxnBNPfJGRW/Zi91efe+TxZRmtvG6RNEawgz/7eDYHtvNw5PIShdodwL00mAlLhMqinhAnabFxtg5Ss5kMjw7MBPtj4FCC5OIXv9tFvd1JGR5DPc4HwmQqfXMbhdCYa5ERTaUCNEv7IIzi25M4v36+WNlCOKrkuALDnFa1yYdTISd1Cut5DSkS6VhukxtI0HGB3qUJki/PlqR5E1TkiAHukdIpLBcwVmWJ4ECbBjnx5hsh8Wg0OtYiYLwySiC4qASI5KJezi0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4imZihw8g7gXK33mtvmmsnM7DUpDf8Wf4kv1xV6lm0M=;
 b=TF2UU5BdsvSxq2LR3IQcLv/mFCnDhfYP6FiHXze1F+pWIoFe1TuIxSl/v8QDG9UdwPJE8Cota65emCw4C5J0bf+llF0BmqahKOTIvOMKYI9UrU5nXItghKElLZaahXFaGvTJib3HVttmfhR6NRTKT0qXOHTSGyCEsuk+LarNEfTaFEuXPUVVkxdZJDVsMVAHS2lcb4DW8MKhteLNK7D4ocQgLlD8TRoH7ULCOkRIGuVp209327+1jkAFVJfeBw2IpGygW2R5UszwszBjf/Hh2MPImRP9kpb7xiUybCEK4dvhLvN1FcOT2tKMyQlT2HoKptat25RfvMLaZKq+RFBi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4imZihw8g7gXK33mtvmmsnM7DUpDf8Wf4kv1xV6lm0M=;
 b=qBPgeQQH96rdEfgl+aXUImDc3+M3nuMS9V5cVFvvgcijGG0vkkg18FpWl9PX5sNiTphCo1zVTlKxmfIRhIsVD7Z7DTk/bAOhMB8a7uSamspkOmzmF9nu8uWPLcBUUy3ABrY196cjB8qDvbYs0wr8mzZHikpomxWDwFcyHvbAjmQ=
Received: from BN0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:e8::32)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 17:05:13 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::5d) by BN0PR04CA0057.outlook.office365.com
 (2603:10b6:408:e8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 17:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:05:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 12:05:11 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Drop mobile board support
Date:   Tue, 24 May 2022 12:05:05 -0500
Message-ID: <20220524170508.563-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af626812-da15-41b1-807a-08da3da7916e
X-MS-TrafficTypeDiagnostic: DS0PR12MB6463:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB6463F78A3AFC5144B19963C9E2D79@DS0PR12MB6463.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AbCZx/8GKjCtXOAfyUw3K7K7b7wOxYQJUyV8Ak91+FSq6AAo9rriV/f1GF4hOgPjI8rlSXlAiePCfhXYbGXum/Xoel+WtiGEzCpvpMOwvjBMQ4FlJ/n8rtxQY9NEXAeKv1YjOWgVxcAipRaZXkYo6X+G+pOPuiDJ2BJmcg5qJTwwRV4mDMHxcxyjODSAhLOoPRDOH6pH2/PFyCAYMCeYcONozpoDvKaS5z84KfU1tAJe+ND1DyglpgmWl9Zi3XIaojJqQCOckYPEoS46BoYu1D2mBXwemAy7ApFciOKN50T8Dj3wOt3doEY5bVauyBMhj+2VRcaRt+5D45uir6MEpT4lYpbhOq1t007xb5JMgYFr6ox29shpPsZYTEB9Y7pSk6pZB0ER5kA3B5gz8yVjLxbCK62Qj+QOdqoPJcL1ePN3jirYh5oZ07HbIV94XxE+VgIVcYSr25ieeKDbFutOvuOkvza+vWjZpVKU2biMUD0yi+nFV82Og7qZGWi2Fb/jbbDCyeWstov0HswXzDEDZemHqYTEf3wKLO3le3n/2aptVxeLTRNA3b10ZQ38ekD/yOEsTcIbXC4Uy/JXS1Dxr5OwyDr7ZNx/NyXWw1/loGXPpnofjZIkTXNXcfmrCL2gqRUXmxkCr2vrh1bIQbbRDd3lfssrD4XvgiDkndHe+YylGKqoTMzNMHNhWUXWZVs9d9yEhM+gjSZmkapiGC9h6Jh0/7mSuAY0IArUOtq4MaoxcZS7y4idvavx/8C5igB2rHF4KhsUEVG+3qX7G243lYvWsDrzWPDLQElzwJ2GGWRw+6OfnLf/Z8+gVpBkryg26T+byVJqkZp25HXlrR9yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(47076005)(70206006)(8676002)(86362001)(83380400001)(4326008)(70586007)(6666004)(44832011)(336012)(426003)(40460700003)(5660300002)(966005)(186003)(8936002)(2616005)(1076003)(6916009)(2906002)(36756003)(54906003)(26005)(36860700001)(81166007)(356005)(7696005)(82310400005)(316002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:05:13.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af626812-da15-41b1-807a-08da3da7916e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AHCI driver currently has a large list of boards that are distinguished
as mobile or not mobile controlling LPM policy.  This approach hasn't
scaled very well as new boards need to be added and all new boards do
support LPM.

Furthermore it was shown recently in some bug reports that some of the
controllers included in this list actually are used in multiple
products spanning different product types.  This means that the
assumptions about "mobile" or "low-power" support don't make sense at
all anyway.

This series drops that distinction and then also adds documentation to
make the module parameter for configuring it more accessible.

v2->v3
 * Add documentation
 * Rename parameter
 * Drop patch for users protecting from themselves, this will be taken over
   by Runa Guo-Oc's series

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1971576
Link: https://lore.kernel.org/linux-ide/1650534217-14052-2-git-send-email-RunaGuo-oc@zhaoxin.com/

Mario Limonciello (3):
  ata: ahci: Drop low power policy board type
  ata: ahci: Rename module parameter for lpm policy
  ahci: Document the loss of hotplug by new LPM policy

 .../admin-guide/kernel-parameters.txt         |  18 +++
 drivers/ata/Kconfig                           |   5 +-
 drivers/ata/ahci.c                            | 115 ++++++++----------
 drivers/ata/ahci.h                            |   7 +-
 4 files changed, 73 insertions(+), 72 deletions(-)

-- 
2.34.1

