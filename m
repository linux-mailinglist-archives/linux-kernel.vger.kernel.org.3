Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674ED54C1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352503AbiFOGdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353906AbiFOGd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:33:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0262B241
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGdC0/3RkFf95ePV1tEK/1rfwlooRJTDF0FOAThuZV9e62Sa7bY+7cCZGbQgoumLO/40gknH5FRijM9VWDSwVMtLaHSoHQv4C4oVcwCBhfg/RhY6mBYNSQ2wBucO9uBd0K+7eIXLdMo+tattcxGVbMYmVlni0M3EO53EqP44rwhbVL5BfsBmd/NrOJ1LqoZv2WX8onrVbkm6Cl0/YvtP6Q49eaVWdEDQfSuvUHUMHQuT7GWfCucVstXcwKuXZITpm+XRlxHk1AD6T975eP3xh6NVC0yqkUESYfry7L+acjf1wUd3vlrRdZFzZkxD8YFYbu+hWThij6+XNl7jrHekPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkCpnN11D0i+VaS5uX5LfjIG9UiDM4zf7cNZMCXhGn8=;
 b=GRDuYzsz8zPV5M+CN5juiJaiw9Xt5vtfgsyh0TpA2NB0fmUYV0DDPfGlDay0w8j+F1fCkhkrQ6VeWsDLi3mHOYVpgOdTt+xrSfQzxbcuXQaFvmaP+SYBrFpHL0aPxnGNXKYAYOPszPf3fJpm349Q7JLhLsw5FzSgi0L7HXoprwplsmbP89tOQ1lXJtsG0MSGxkus5atXTYo+K6RK5KMBP6ynw4qMIPfaLZvfEnem5wDkbFSySv/Ha2ysB7NK4Bz770OxnGyCMEs1YFoRMCWNMOxeGV1nLJdqWxOIhS2pt014WMEnvSVNt3drhFi8TmHk64lwmkdeOrM+trcx6g8/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkCpnN11D0i+VaS5uX5LfjIG9UiDM4zf7cNZMCXhGn8=;
 b=l0ihUiI8z6W4MRShvj7jvSDhOFLqAAT8popiM1owkqtJ7jgTZQfoNtfO37SjdThh8OPVSySXaQ7RQqpHNVadIASMn1XWiX4NTb51RLmM6klp/5xMBJNR5de3PcqEyxfQjp9IOYULdmve6Dh36wPjRQN+sUEJvk9xFitLckRFHsfjgv7Z3NZpmjf24WjMREGBEeZ1LaChY6WIKLCHS8dDkpcuPCeK+n88jXz8m8cg5to1ehGfn0h7YCIVCgo0HxvRhA5yZbOPeYn9ffThaSS/Bi/XeIT7wvyxihvE1H47TvUgWfRvmCPecvXzDM6FhSTBi8twKGAyKtAN830HpguleA==
Received: from BN6PR2001CA0037.namprd20.prod.outlook.com
 (2603:10b6:405:16::23) by MWHPR12MB1629.namprd12.prod.outlook.com
 (2603:10b6:301:3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 06:33:21 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::d3) by BN6PR2001CA0037.outlook.office365.com
 (2603:10b6:405:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19 via Frontend
 Transport; Wed, 15 Jun 2022 06:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 06:33:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 15 Jun
 2022 06:33:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 23:33:18 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 14 Jun 2022 23:33:18 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] gen_compile_commands: fix overlooked module files
Date:   Tue, 14 Jun 2022 23:33:15 -0700
Message-ID: <20220615063315.279489-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7261c02-c64c-4a9d-6b5d-08da4e98f074
X-MS-TrafficTypeDiagnostic: MWHPR12MB1629:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB162947BBDF068B86681F9435A8AD9@MWHPR12MB1629.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMHRYXzg5+acTB6e4lYsbS2w6Qk16B3JDiCDeSZuo6p+91Fn2g4IVqrAMwmmpwtf1HjB1iIrzJou3J4uMZwWqr/eyFc2r3/ZrMlpnXTcjFneUGPgVjDQpik4L7QhFx19wBHVioDLMBe3/TVyQlPfMjTP6B4pecKJ65iBVmPCTNB3nTaUCVn0uTU8UmdsmyQnYYyhY4SVdxRR2h1uRIYu0QuLfExTjHdzTA3KDboOFNhEHkUolEeqTM81d1PA2GMMcjEgTvu1borAAkLeu9YLj/kX+C3NJAUhOXr2kWM9PzSlzvEvy6UgIo5NR6GJBy6R3y/A6Yzj38hLHx9uGSmVTN88jWo6Ouyv5KmhJCiryi6YkBXep4XPMtZu7tVREkc/OK+atkmqh7WWg+hfBYBSfHXOyNc2EKF2POIPyviufcupq0lhto6tlKX1+Rd8ySpJGAGpmf8vc0s8OrrY6+McFSPcFZH7xPP/cnFEf3tMZhmi/zN3LejMeFsezNzy7v17ff9toDXiN95ZrvpwR9LLCNJNU5s4fOjGjTBKtbvGdSWBBvteCw4MMh2lieHcUUgoiSs4c/915hYxXQNrhBK0Mb3ugheVLc5g4O7g1aF/gqi0UYof8Y7a6POJP5Ia/qLMEdLDvO6H7nNbBNp/RZ7YYkHNH6mb/aiQ3VMYF9FAFKwBKe6Q2YnszDOo9Q7KWX3tURwwXDLM+ugH2mwv+shqHA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(6666004)(508600001)(8676002)(2906002)(82310400005)(7696005)(4326008)(86362001)(316002)(36756003)(54906003)(26005)(83380400001)(6916009)(107886003)(81166007)(356005)(47076005)(2616005)(1076003)(40460700003)(186003)(336012)(426003)(70206006)(8936002)(70586007)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 06:33:20.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7261c02-c64c-4a9d-6b5d-08da4e98f074
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/clang-tools/gen_compile_commands.py incorrectly assumes that
each .mod file only contains one line. In fact, such files contain one
entry per line, and for some subsystems, there can be many, many lines.
For example, Nouveau has 762 entries, but only the first entry was being
processed. This problem causes clangd to fail to provide references and
definitions for valid files that are part of the current kernel
configuration.

This problem only occurs when using Kbuild to generate, like this:

   make CC=clang compile_commands.json

It does not occur if you just run gen_compile_commands.py "bare", like
this (below):

   scripts/clang-tools/gen_compile_commands.py/gen_compile_commands.py .

Fix this by fully processing each .mod file. This fix causes the number
of build commands that clangd finds in my kernel build (these numbers
are heavily dependent upon .config), from 2848 to 5292, which is an 85%
increase.

Fixes: ecca4fea1ede4 ("gen_compile_commands: support *.o, *.a, modules.order in positional argument")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 scripts/clang-tools/gen_compile_commands.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 1d1bde1fd45e..53590e886889 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -157,10 +157,11 @@ def cmdfiles_for_modorder(modorder):
             if ext != '.ko':
                 sys.exit('{}: module path must end with .ko'.format(ko))
             mod = base + '.mod'
-	    # The first line of *.mod lists the objects that compose the module.
+	    # Read from *.mod, to get a list of objects that compose the module.
             with open(mod) as m:
-                for obj in m.readline().split():
-                    yield to_cmdfile(obj)
+                for line in m.readlines():
+                    for obj in line.split():
+                        yield to_cmdfile(obj)
 
 
 def process_line(root_directory, command_prefix, file_path):
-- 
2.36.1

