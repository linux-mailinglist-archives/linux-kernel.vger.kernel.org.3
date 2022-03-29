Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1A4EB1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiC2QnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbiC2QnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:43:06 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4140A2498A0;
        Tue, 29 Mar 2022 09:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBAWmemTLGJwT4KsNqRU9ulDTKbOc3yLpyEdcSibBvw9XcHJk44Bx5zQorVBv3TIUR0ZgknV+IVHaGBDlSkg6E+KqrLigCKBvuBvs/Ac6HFyLFkzsak14wP6es4uMMlgvM8GJykOWn4woDc0CpsGYgsr8cnabK/MykOnXr37c3C4iMdr1z401+URv6vKspofx5JYBn+UIixMV6qjbHOJvtFa1moXZ8rppEHIdPfJ0bxKfphKAOJH2d21GwXax/V71palQfNRCpFigU3QWfZjAOiFDKqGCnlT2ssqTj7pUIkK56+vGXBz62f82/fyTsrouGxKlTsYLytJQIIBgy7/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1N1qO7aio8brqBvpKzmvUDP6BmrBjafXD1z3mxtikA=;
 b=FsCPhVboaZob4IzXYGdBZwlkKTnR3B+Ud3ZDlfjrV7+8PLAOk3mPvmbP5Ny78qOVQwLT8f4U7QDl51Dw2/sG3gAnS+Xfz2hhfWUdeZm86SOExmrjlFJ+Sc90Xyev5WqSuQ/5/b8YnZNEkn9h4RTmJ5FEsaC0uM/zG3VvL7EqyHPkpG78WE01+S/OnZeMCkqy3WuCIxxB/DHBPp9vPq+6wKvbzshUHPAO+LLa39+zYbFoi/x69NWvk4A/vPNZwjvtF92MfbVkBCokmWenXX3dgzftRTxAC4ukjLGXBvp+pAKzkKxxXjW4HoNMnSqq28ZkJOppzN0Czko5iK7/45Bvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1N1qO7aio8brqBvpKzmvUDP6BmrBjafXD1z3mxtikA=;
 b=qSELbPg4wtdjXzFcLLHSnJEWUemp2d588pU0UaJP3u8TbdmNJkjfgfGM1N84/QIpLA7wlQCcQ1wRJVl+OoAiNf+5pelYNmKlR8tOIs4V+8iBHN0VbVflLDg/S5neB5Z4evt7eeqHStU2tuRYUQeHfViIV/iTjDteAMAyVLegLCM=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 16:41:20 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::1) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 16:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 16:41:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:17 -0500
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:17 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 0/4] Export PSP security attributes
Date:   Tue, 29 Mar 2022 11:41:13 -0500
Message-ID: <20220329164117.1449-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784ac7f0-fbb2-4ef2-451f-08da11a2f362
X-MS-TrafficTypeDiagnostic: BL0PR12MB2371:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB23715178E7A0FE809EB3EEE9E21E9@BL0PR12MB2371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maNqqHhqE59GS+QdqiKQ0mRCviPpldaSJuUmJZu0gk2dxNVjYmDbPfXUs+ZhxP/svX3SGv27P4esTd45+nOVHThyK9AzCYIzUXlpdVW4pzKeH0gVROI2CVBy2BPbpOBtnDH8G5vEg3CqjWULER4sLrARn7zrQujCxi7DvhgjRBAZOvT1L23x3eJwKQhUelcprSxuIQiq8NKpq7JJIabgel7NrIiF3QVjsUZAkn8NELx06B7aguMhxgW2lB33C+ojuXKOAzP2XHZH/BV78OG4YRvpG7+CnR1/5VW2QEV+LXrlku97YTiWSWOXxtB0jE3IvaGfPO+KeA+7vgveNAEJ5XoxLbP670SjpcPm2yqg7qKTU6Tj2SoIuIGjLYvc8nPJLTd1qHxW62O3nESyTSCkKXXkuj1LSl90w4MZf+62bj52pVJQK8AKF7s29nSm4mwpMn6AeaO/c/ztmYORlE/qPfQJ/ReCaZJwizQtpEnujXE/se5wgWG9E+iErBzdxHfpaDWa5SUGWOqcIQJt2OezXY/ql1WvhVWQlBdgCz450NOgwOLqAilxWx4ojsXk5YT7ILJDvpQFi28MfT0FamoOgPiVgNZ2HIbNyKTitsreZotJRquOLyjBM1d5OJFyHgdH9eajVDpzK3jRRlbnueG1dkF2cQU5IR8W85Y78tcRANA+k1INi6N3C8Fc0Y9/jWXpCW1EQgqndG5tiLJQq0MYcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(356005)(81166007)(40460700003)(5660300002)(86362001)(70586007)(4326008)(70206006)(54906003)(8676002)(7696005)(6666004)(44832011)(8936002)(316002)(110136005)(36756003)(2906002)(508600001)(47076005)(83380400001)(36860700001)(336012)(2616005)(426003)(26005)(1076003)(16526019)(15650500001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 16:41:19.0305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784ac7f0-fbb2-4ef2-451f-08da11a2f362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select AMD SOCs include the ability to export capabilities that
have been activated or detected by the platform security processor.

This information is useful for both system designers as well as system
administrators to ensure that the system has been properly locked down
to their expectations.

Software such as fwupd will also be modified to use this information
as part of the calculations for a security level score that may be
presented to a user.

This series also adds the ability to detect that TSME and SME are both
activated simultaneously to notify a user.  Previously a user could turn
on TSME and SME at the same time, but the kernel was unable to detect
that TSME was enabled in the OS.

This information is evaluated "too late" right now in the kernel to stop
the kernel from enabling SME, but if that is desirable at a later time
some of the early code can be modified to read the same information and
make that decision.

v1->v2:
 * Add cover letter to explain background
 * See individual patches for changes from v1.

Mario Limonciello (4):
  crypto: ccp: cache capability into psp device
  crypto: ccp: Export PSP security bits to userspace
  crypto: ccp: Allow PSP driver to load without SEV/TEE support
  crypto: ccp: When TSME and SME both detected notify user

 Documentation/ABI/testing/sysfs-driver-ccp | 87 ++++++++++++++++++++++
 drivers/crypto/ccp/psp-dev.c               | 46 ++++++------
 drivers/crypto/ccp/psp-dev.h               | 22 ++++++
 drivers/crypto/ccp/sp-dev.c                |  6 ++
 drivers/crypto/ccp/sp-pci.c                | 62 +++++++++++++++
 5 files changed, 202 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ccp

-- 
2.34.1

