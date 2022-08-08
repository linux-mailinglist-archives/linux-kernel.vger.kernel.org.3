Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE87258CC93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiHHRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:16:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A99582
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLzHT1Nb2ZZv9c0orRvnWYeaJm8jzUP7ufrWz4t/ci+xPUUw6s+ueoKV9XqvKFdheeosuo5iXqtNab9Gme4zZrGkaF+qbCzbPq66udjg4Dh2azGB+uMyUN2ar/AB7b43cxjXy7RorQQ/dPwq6sjsiozktMh0SZg6ndods1dT2bwj3r3t6z4329x66NZDfdMzSlA0l8OCX9dMwPad0noLmKIJzFVfWLkomq53bx1FK+dsZh20rgfZ+stqZJX4MeR2p6bCLJFtDYBz/FD0NliL7fbaod4BPi6ePFqmhvoZczWkC0ZrRxomwqw1eRoo2XpHRuOlIsQnkoARK9xvao6zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5AAYZGPlatQ/A3ks7oapl+jCwDQNQx53L1cqZcRhns=;
 b=WsW1J2AYYaDD3bM2oG2N/HqxRHmvcRnajf0GU/OcoFmsV+KbNWWI2TV9MX5uf0ZU//839DlbAJDrPdjpNCmIscDqViyZGvoDfHWxPVth9mk+IsEtbD20GpuiC4rq5hZXmPJqmNahtTHUF+mWLqb1XyYO+t1xcGY5UMB/wUFNOiYGxCAAUdX2KxvzuIg3sKsAqk12WNjJ/acW2b0XCVxHPECyPZiGM1oyP9Lzed40B41QplbtDe2sth9gQ26XHJDPxJL7/LprRWiJarTHmjYmlHB/cOw6BRDbl6U+ERHnzrB3ZkEI6pV4vmT7gFkIexA4lSUmXO6a1RbQnLHanD8cGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5AAYZGPlatQ/A3ks7oapl+jCwDQNQx53L1cqZcRhns=;
 b=WsPmzvM9L8CMcloNaj+f0VOVyvYpLxKciX8Eq3yQTLKMl6MAogNtesg+u25Jl0cOZTz+NOi9q3MJSwXhkeSLbBgMCrPLWtbPZ/oVx4rjAz/q5ejWh6+DZN7On0QVnOupnZaoqOwgVdd6G9E0itkyt2Xl94B4d01sL4K7bEI6/yc=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by CY4PR1201MB2549.namprd12.prod.outlook.com (2603:10b6:903:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 17:16:37 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::9c) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Mon, 8 Aug 2022 17:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 17:16:37 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 12:16:36 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/2] Provide SEV-SNP support for unaccepted memory
Date:   Mon, 8 Aug 2022 12:16:23 -0500
Message-ID: <cover.1659978985.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdf8752f-9911-4e49-4e29-08da7961c05e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2549:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XHIrsQldx/ai91AyOREqs7BEW/nXgCpqgb0G98aXjT54XSmVtgkjkZJ2By1xQr3emwmnT36W5U8CCx1PpMQ4nM8feNpHlsOL5NSh98PPDKtqy7ALsihYuTpLP0eBNh5h8xYdnuLJvE94j7AazuPgNeM/1BJxmMQscRhgZiSnnsaIpD9fq6M14DnSeoTSjHcTkjpF5nk7nctWO3LF4FOq/vSKm4IT4KbcsUWF9wr1x0To3omkEu+NvKDEZgbac0XfHdjqbyejlw52Ab/71OJJLlCbE0kq0fhbkmmCAJngcp8dwCRtc0mh38X7whTgg5PcnKojBRmSBvVyLeKAThWtlMRhjfjsNHowZ/SM13A2Qg+tjugAYVfl2hNUzblsvH1OeCFjQrHFHsZ/F9cRKjyirgK8i1sRKjDWaKGxw3D3XGCKhyf838bMcJ+213TUXXz4Dm4nOzW60OeCaMQ74Rd4hZzCYP5n5p+i+j739vajGz94PDuHeSVj/CP8ngaXUXJPGJkneFPbMq5SJjWbIUWTGsOGrDRfizF9udcI/S8srwpBYtyfQRDuil9w/4zz+XGo6aGYRjgs9KJzG4c1+tOwX2gKSJntcNbXVXyJlpniIEPvrcdOUyPDeHcedcKvb257m/wuYfsckgz6ANsMKIm0hdUdkXvagPg9fGS7LkxSu68+JBOKd3WywLI12re4OgBKLYmWoXxTjNb8yx/rXyoenuAs3LtupTL1BBSx+uQCrqhGhHT6W7WwJxrDIgKlTdD+I4G/c7dmwTEMaMb7226EZrD91m3ffQldPpGOEv9Y1hvNEF2nWYXOVlDNDLuZ7qFK+2ERBw+qKt0jzOKkIAXuj6jauWKbHv+jQsWXys4jmge2c9TKAXAqL4Mc6vEzkoH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(40470700004)(36840700001)(46966006)(83380400001)(26005)(36756003)(2616005)(186003)(4326008)(336012)(316002)(86362001)(426003)(16526019)(41300700001)(966005)(7696005)(2906002)(6666004)(110136005)(47076005)(40460700003)(478600001)(82740400003)(36860700001)(70206006)(7416002)(5660300002)(40480700001)(54906003)(70586007)(8676002)(356005)(81166007)(82310400005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 17:16:37.1447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf8752f-9911-4e49-4e29-08da7961c05e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2549
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SEV-SNP support for unaccepted memory to the patch series
titled:

  [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory

Currently, when changing the state of a page under SNP, the page state
change structure is kmalloc()'d. This lead to hangs during boot when
accepting memory because the allocation can trigger the need to accept
more memory. So this series consists of two patches:

  - A pre-patch to switch from a kmalloc()'d page state change structure
    to a (smaller) stack-based page state change structure.

  - SNP support for unaccepted memory.

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-unaccepted-memory

---

Changes since v1:
- Change from using a per-CPU PSC structure to a (smaller) stack PSC
  structure.


Tom Lendacky (2):
  x86/sev: Put PSC struct on the stack in prep for unaccepted memory
    support
  x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                  |  1 +
 arch/x86/boot/compressed/mem.c    |  3 +++
 arch/x86/boot/compressed/sev.c    | 10 +++++++-
 arch/x86/boot/compressed/sev.h    | 23 ++++++++++++++++++
 arch/x86/include/asm/sev-common.h |  2 +-
 arch/x86/include/asm/sev.h        |  3 +++
 arch/x86/kernel/sev.c             | 40 ++++++++++++++++++++++++-------
 arch/x86/mm/unaccepted_memory.c   |  4 ++++
 8 files changed, 76 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.36.1

