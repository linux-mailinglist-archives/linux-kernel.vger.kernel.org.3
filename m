Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B922508A98
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379589AbiDTOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380254AbiDTOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6549C45783;
        Wed, 20 Apr 2022 07:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CStNmSy3nl5ZvL7dc+tffoEgtaIw6G/sn+FoqOqHL+5Fg9lFFjWA40hicUKVFIoOj5LdZyfTXgRk/+FCUBpy2+6zmGRybAUym9jqKbJj/jbRlBOdyjbp+qnM7ON3/jOrURzjJHH+vSHv9NyuxiL353AlHf1IScc6BzGBC23DVxPlaXMpTUp5qJNaluo1/36OEtyob7u4Uua9W8Lct8dihMJz+Q4WQYQLDY80/inB5GCB6wG8xBKNG4tT9iWZlnrH7tRx5dKI9bIaoAuMI4CZcNNeY4LmSGlUboG0H96v4x3/ds4Abr3sWq+MZ181gxZBGwPqnDs4brcwutuhz3jvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztl3nDsYub7t/6+KbSrM6Z07arLY4BUgZOkZlmMD9Xo=;
 b=e9coObp1ZXKWRZo7liFgGEedh4NFr/savfthPCkog2bMldWGQ+YTndlAuj0B18hGOmTxxafu3gPt6ODBvQWKbkTz+ZFzd0U9fNImHQi6eT5b4MLVf55LefDG0o9HvBebgCwDt3OhoS7stBzYavWY4lSwMY7Mq9IIrn+cCPy9U88EVGY6acMDyPkJdBRk/uK9mcjFdTTmUecjVj3xIT2JSO4ONkUNPDT9OndZ+fCkuYNLLd86SnZIheU5q1PuZCyVibsCpjzQkQW3L2GA0F8BcsLoqkG97iKBqCbq/7VaKjy5U/Gt6aPUl/V38sVpROL4V7/rN7vdnwlgipvG6I9Smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztl3nDsYub7t/6+KbSrM6Z07arLY4BUgZOkZlmMD9Xo=;
 b=wjMYyarbFUoMjwMFF8uVyWeE5Rfdt4KtC2tzLE2hW7bdhC/VWewvb3Uq/1FjqL+whQK6ViMUEMHS8ID542GrmJ99cm5r2zbByagwqoARBxZK5DqdnQMa41i/SvBFV91domC+3QmMJxk1tc8M4/+wcBCM1zz4o/V8yuMGTQ3a4bU=
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by BN8PR12MB3380.namprd12.prod.outlook.com (2603:10b6:408:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 14:14:28 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::81) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 20 Apr 2022 14:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 14:14:27 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 09:14:25 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <jroedel@suse.de>,
        "Michael Roth" <michael.roth@amd.com>
Subject: [PATCH 0/2] Provide consistent name of the SEV Guest driver
Date:   Wed, 20 Apr 2022 09:14:12 -0500
Message-ID: <cover.1650464054.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02bf770c-6e56-4f75-222a-08da22d81461
X-MS-TrafficTypeDiagnostic: BN8PR12MB3380:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33806489BA92A3BC4B974CDBECF59@BN8PR12MB3380.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsWw07WgCcHue5Es9c/4fFHWqGpw7Ky/hze/+t2CxEgrGYj4qcTWLWSroLTaJE4RaSVAW2atFdiUil6Nyf0yeUObhoeP/1b2d+njQIi0Sf9urDEOQDr4IMyilyWMpJCxa5Mrm4JKliBAb40O8RbDU/LFa8+Osd5f6kOy84osuzzWq3f8+yQ8T4mzWjgfWEDbuObgYF8bVyNDTVQH6cGF5c2eFB6i0m3PN5s012SS8HeHWoeS1yywEOs0TSV62Oob3eczdM2v9lEcCKwFKHJ+X5yfzebQ6yZe29kE5dU/ENGXrn1eIZQlpmqbOHpeXrGkmVh6UHuteEJVy7Jzulh5z+w+9SJ0zPbrac7I2vk8S5C8gmD0VlrgPEb40moVCRpHxTTGRN3Gk3BrhwAhnxJp7O+6sEmBmwesXeDmbvwbFHMWa71Vtw4MNhGn9qWaz9RdvDI16GN1E5OkWjrbMU7zqpboGAZQbWjx/oSkD8SAQYkrF2wPUjmi7xqNYN0XTVCRZbfAVQwT601ALIAnx/cyF1EaWyyydP+od900V6oZejPZ4wsDmld0alZvR5sWCx9yg5/YU9oLwVY9r8rhAuD8V1PkPbxEcSOeA8gEYORacAGUrJTclzpIOlL43PisjplqATsr+FcrU2xXwi5LbofsY+IPQHl40YW6hNOjmtvOLzR+SDxIXiIKJrpE+mByTWnHi0bXak2WfuOlMGmOU73ycw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(5660300002)(316002)(110136005)(508600001)(356005)(86362001)(54906003)(7696005)(2906002)(83380400001)(6666004)(70206006)(70586007)(336012)(82310400005)(36860700001)(26005)(186003)(4326008)(16526019)(8676002)(426003)(8936002)(47076005)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 14:14:27.4505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bf770c-6e56-4f75-222a-08da22d81461
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series renames the SEV guest driver from snp-guest to sev-guest. This
consists of changing the driver name field, some functions and structs and
renaming the driver directory and files.

This provides consistent naming between the driver name, the module name,
the misc device name and the file names.

---

Patches based on:
  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

and commit:
  6a0111882747 ("Merge branch into tip/master: 'x86/platform'")

Tom Lendacky (2):
  virt: sevguest: Change driver name to reflect generic SEV support
  virt: sevguest: Rename the sevguest dir and files to sev-guest

 Documentation/virt/index.rst                  |  2 +-
 arch/x86/include/asm/sev.h                    |  2 +-
 arch/x86/kernel/sev.c                         | 10 ++---
 drivers/virt/Kconfig                          |  2 +-
 drivers/virt/Makefile                         |  2 +-
 .../virt/coco/{sevguest => sev-guest}/Kconfig |  2 +-
 .../coco/{sevguest => sev-guest}/Makefile     |  2 +-
 .../sevguest.c => sev-guest/sev-guest.c}      | 41 ++++++++++---------
 .../sevguest.h => sev-guest/sev-guest.h}      |  0
 9 files changed, 33 insertions(+), 30 deletions(-)
 rename drivers/virt/coco/{sevguest => sev-guest}/Kconfig (87%)
 rename drivers/virt/coco/{sevguest => sev-guest}/Makefile (50%)
 rename drivers/virt/coco/{sevguest/sevguest.c => sev-guest/sev-guest.c} (94%)
 rename drivers/virt/coco/{sevguest/sevguest.h => sev-guest/sev-guest.h} (100%)

-- 
2.34.1

