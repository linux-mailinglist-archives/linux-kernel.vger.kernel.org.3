Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECAB59329D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiHOP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiHOP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:58:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D511A380
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOl4vfps+D3Gz1u+WZ7afhLCi9hHSwlyA17VoYQ7u8OVZR5M/dLn/HqVSQcFPZxX0vzCDSlSqd94xN+cIhgqYt0vxmadk83f3QcRGFWXyEbirgj9U+JVZMwNuXBTbWoB5cOCtRqCp047XhPJcjhyEmFLgFTj8f3/aw7TlKZe0xXjFXp+geS/6N2yLpt6Yf5TrCYejBomqjnmcIrayAMgp5sxEACrSkUqnUGO9fvR3msqTIGnDZ6ahhWVM/q3dabgKEvqu3M4R6ealZSHhtCjREt9N4nsBLeMMeY0QkIaWMqpYGbGdT/ONXVTBwVciIhSh5YkwLlFKJ1JUwbOya1r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRPb2APBU3caXuBHcOS2Ps30Ry4mKwSNRtfqvLeAvxk=;
 b=Mz82mMs9srn0F5FpmhigzwO4pZ+whQPz/rTM3jSg9LdDREj27k/IMZONwPx69jSF0KL2GvEP852ua1AD3+Ed71dmIKdOcZQvJJMLvGNpXFRquxBsPF6QMm7m4rRCa0WSCvKpm6FVkjff3AcATydNtju03vZA74FJCNew7jvh6/WP0PSNmigREfhE9C718ux2Tgilihx1ab5PKPhY9KheJkMZcLXnNyZwxlIhAR09+QqtfjO+kwqMHAfgvz6c9SeJmBL0dnALZoCzP6Gdq3FFZi4oOXYwWlg+xotNyx+F4cEvasMa1K7lPPEpojvJsnAVVn+jeHrMihGGl4/Gw0lQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRPb2APBU3caXuBHcOS2Ps30Ry4mKwSNRtfqvLeAvxk=;
 b=nNShnHFrVqGnqN/9pT4jVgafVVWRzAHMSOsMTxbEIyHZ6Csc/T47FdAEyIQgFFvrbfvPCVGMo6VNiD7d5MWu3Ms7oT1KG6wFw0t5xXkvx/fqGlEQFD7CHuc0h9ZbCC4WuA7xyV6/ynWXGpSzgx7I4SAihrQhJNOi88qyq8ubkeE=
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by CY4PR12MB1861.namprd12.prod.outlook.com (2603:10b6:903:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 15:57:59 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::3a) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Mon, 15 Aug 2022 15:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 15 Aug 2022 15:57:59 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 10:57:55 -0500
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
Subject: [PATCH v3 0/2] Provide SEV-SNP support for unaccepted memory
Date:   Mon, 15 Aug 2022 10:57:41 -0500
Message-ID: <cover.1660579062.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c57c63-f63d-459c-6b74-08da7ed6ed5b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1861:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIqyNpwIEX0cNyyHivnzm4i+u95UkZM8Kt1eLtSxYrScDgu5aEhL0kzcnvyeaD0JFvWjxOa/9LXH4yUM5RjWvFOQ5NcZ+VOHof/GbLAcL3PcD4LHi9OntTKClyH6KZBu8Nucmg3cVD0m3CaY4Yl9CTsBuoqPHRdXVu56oKs+X+IeNB6J6d1FoEKhECUqNYhw8PglnkbrCiC2HmNvwWLbxPtkZ66W7FviDHgunKmR+ZHBpEu791H6XznLLhwFki9zGBV66bc0CZtXgjIg9qlVtjit73VF2uQA7CWbfmJBfb2Kei2TQNc3c5jrNhEa1OcQOI0RXIbIIIiSq6CUo9hbwUKcUfnyLdxn2qHM1Jk5Bf/D8hQ1IFIqeQH4JEW9G3qlkmqHtFy4O/6juEkkdk7JvBcoA32gGr9qctrlnm+BrfEWbFsHBR0Tia8Wo1cnv+8JWLOBO1s41WztcbzAstCvlvjMq9APbNObFINVgCHHC/sr9X3C4bwx5Jnfj+rDDL4VAJX/8oHf01v6Rpw1i7E81B4G50E9Ohh619vC+BwxUAGUDHhnSIeVFmqkT78+2XYZlNQ3tUyc9I/ZTwrS/KzRoB7r7wHPipbSu40zux61aRC7bEd9uV/5HoCHzXKjM0tCeE8eWhsTV7PdGDuI2CIrvB2LwEJkKzbvLtC8OXOI0cE6wEFbVUykwnv7vOtVwNa1W1XmV+HELrWqfGndhJzG+H4K3ayDS8HdN/Y9XGSBnbPrTS/+SAtSLTA8Kr+Y2peProLW+jwLESmgd2PFEvWee+vukyOGEv5cCLmzPdPFszxmhdxfCdzwLMQ92H/jvwsMh6KmSKcbc53Lv+fdPaojgcv4WbrfM9prLdw8vgTK0sdV6a6y/qK5xVC3P2AtihKu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(36860700001)(86362001)(82740400003)(336012)(36756003)(47076005)(186003)(426003)(2616005)(26005)(7696005)(83380400001)(16526019)(356005)(81166007)(6666004)(316002)(54906003)(41300700001)(478600001)(8936002)(966005)(82310400005)(110136005)(7416002)(8676002)(70206006)(4326008)(70586007)(5660300002)(40460700003)(40480700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 15:57:59.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c57c63-f63d-459c-6b74-08da7ed6ed5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1861
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

Changes since v2:
- Improve code comments in regards to when to use the per-CPU GHCB vs
  the MSR protocol and why a single global value is valid for both
  the BSP and APs.
- Add a comment related to the number of PSC entries and how it can
  impact the size of the struct and, therefore, stack usage.
- Add a WARN_ON_ONCE() for invoking vmgexit_psc() when per-CPU GHCBs
  haven't been created or registered, yet.
- Use the compiler support for clearing the PSC struct instead of
  issuing memset().

Changes since v1:
- Change from using a per-CPU PSC structure to a (smaller) stack PSC
  structure.


Tom Lendacky (2):
  x86/sev: Put PSC struct on the stack in prep for unaccepted memory
    support
  x86/sev: Add SNP-specific unaccepted memory support

 arch/x86/Kconfig                  |  1 +
 arch/x86/boot/compressed/mem.c    |  3 ++
 arch/x86/boot/compressed/sev.c    | 10 ++++++-
 arch/x86/boot/compressed/sev.h    | 23 +++++++++++++++
 arch/x86/include/asm/sev-common.h |  9 ++++--
 arch/x86/include/asm/sev.h        |  3 ++
 arch/x86/kernel/sev.c             | 48 +++++++++++++++++++++++++------
 arch/x86/mm/unaccepted_memory.c   |  4 +++
 8 files changed, 90 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

-- 
2.36.1

