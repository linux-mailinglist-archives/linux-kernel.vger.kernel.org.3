Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37C54D817
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358491AbiFPCM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358485AbiFPCMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:12:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5435A089
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgJzCPmdSmAyB6Tvm3M+Cbl9jzsXE6XbndIM3PeODsbO0YZ5el/1N8M2jjlP2j1N0JsoXO7hxgbcM748vihNhJ3vh7yCgtSVtcMD6oWDkOcNxx9H0+4RuRnOBR2By6cDjwxEUx9WaI+qGbYnuK2l0sZVbK6akIscRkXygT/ewmB8kYXS7MKjJIxJhZ27i+GbRQz1xHkaMAKDYc75pRTWp8l1oAHQzQ6qcXscPxdjjjDTBXocHXxZOFeV1Wpw9GbUu+bbYTX646k2LqdwGdMiiY5Cajp7FySRYydPz3v5ZMnnUtqsbwMqzM6xuwg1A+d3p5dv9BY4fGR8WZh+ErmAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZehprhR8PUzC7n+G27ruxF3yl5Lev2A9ybCqC58PPQ4=;
 b=fHMBCriwYYucJiXrB90Uk7rsKu65bYLcLVjSF8za0bbOXyOsvqpxSdjFHe+uvrjtUk9uHOKoW3zYUkBPrLAehYHVMMLWH8SF6+HWlglWYSalmw2J4Peo4JRt2x7+pGkW3opJe7T0HILOGwDFoa2kpNXlPHAoayO4fmpQfH2cGJx+HO3s73xxc5iO3D2BJfWZU4+gnI+q+vPD+7KytOeSfylZ+tuq48erdIGIHbV9sEfaaFnmAUwJw5wRTep04mncpFRCDKge+ZGwnJ7TFDxTgVjd1aOxc5H4uGzeefTUv0oMF7B9ejZ6PJqOM/pRT6D5lDl2qL9QPJmu5c4WTwHSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZehprhR8PUzC7n+G27ruxF3yl5Lev2A9ybCqC58PPQ4=;
 b=OfnGZiSi0emLT3FxCXuRg73xWGnSw9AYGKBej4ICnMUgQDmg3UADMJS/r5XnkjRuuBLnTZ9YAN9OMyzL65YfSi6sV2o2jeUBwsZ8OvvEuJbF5K8INtUE1PIi9qU7Cr9/AbiI8mi7l1sl03kiFPTzG/4pjZCzloOBPZpXGaOthPmDXW53RpGff1n7lQQHXe8v+590/O36HzDCAYh6e1G2xyJa+SsWkvrSt2zFY1LnGguVRpje4jN+Ze+pM/hzHmfq4RZrT7YSzhzJRydUVbuMT+Xt9jPVI883AanZd12jN0opCeHoGjMHSysif/soxiR0nbMD47+yimnA5p3ainitIw==
Received: from DM5PR16CA0047.namprd16.prod.outlook.com (2603:10b6:4:15::33) by
 CH2PR12MB3799.namprd12.prod.outlook.com (2603:10b6:610:21::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.14; Thu, 16 Jun 2022 02:12:16 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::8b) by DM5PR16CA0047.outlook.office365.com
 (2603:10b6:4:15::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 02:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 02:12:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 16 Jun
 2022 02:11:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 19:11:55 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 15 Jun 2022 19:11:55 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] gen_compile_commands: fix overlooked module files
Date:   Wed, 15 Jun 2022 19:11:49 -0700
Message-ID: <20220616021149.327587-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9c08264-7fed-4a95-3ecf-08da4f3da24f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3799:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37990886B99CD9BACADC3109A8AC9@CH2PR12MB3799.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnpHg8+UW6mJ1Q+btmdQh+gHbZ+0t86yJvM2YMDeFmlxUtdhvTjyBbf4gvQ0zBHd0kCwCVpFuIpQxikdiUKNQkejmRHbEXB2zQH3T9YQQfka+O0GV/09KOg0IawUC6H5yWL/PUBukuqOWrfuZPICihW6iVh1BI0Da2PNsMq7O6lGVuMWqta2PYWlT6mmUTQ4xZUIOmyOBqBrS7DlVI0ig+pELcsSE2As7R7qjmYAdVLsJgKqt1rrgph7RsVCDkHUp+OML1ftwMjP4TguBfrJKIDPKd/F/7C8W3Sbs5FXlaTp+4SKn5vP+Td+MpfCYxwIJSEpJAjIxFRcIX/DMUuMOw8R1xMTbohLk7ZkGYCxKQNR5RlJhuZBJJn3nZyEgsVqlNmS7wT5oV+De1FaVHdqp4Yvg9c1zePFtJnxph4/efasfbvIhwpeKDx0RtRfKRGYg5PkmiN1ozTCvCoemAUHybeQGMtG9QYQMYH6bsz60kZfFsJsXiA0qapCrUlAA1p1KP3a6lIskDXMmC6qh6SROGt9fgggXCpeN5aI0RKZ9LQd+1zZSBp5X4IP3FYkY+svNnSHY6hT9nGKptboIZjPTjkWbg9f5s2DzqLdvei3ktYYM2t018UmGoLjZkSMSqd9YH0eHluPH8/nDLe2Ted4wjAmE7B0U2D0HRzMSyuTezXPp9PJk/yXL5bn4SZl4gnLvzf7aHu+vM6Khnck/2iLCw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(8936002)(508600001)(4326008)(81166007)(356005)(54906003)(1076003)(40460700003)(6916009)(316002)(5660300002)(8676002)(70206006)(70586007)(7696005)(36860700001)(83380400001)(6666004)(426003)(107886003)(2616005)(86362001)(186003)(26005)(47076005)(82310400005)(2906002)(36756003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 02:12:15.9642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c08264-7fed-4a95-3ecf-08da4f3da24f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Fixes: 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since v1:

Applied changes recommended by Masahiro Yamada (thanks!): corrected the
"Fixes" tag, and improved the python code for parsing .mod files.


 scripts/clang-tools/gen_compile_commands.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 1d1bde1fd45e..acf4ec28aaf1 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -157,11 +157,10 @@ def cmdfiles_for_modorder(modorder):
             if ext != '.ko':
                 sys.exit('{}: module path must end with .ko'.format(ko))
             mod = base + '.mod'
-	    # The first line of *.mod lists the objects that compose the module.
+            # Read from *.mod, to get a list of objects that compose the module.
             with open(mod) as m:
-                for obj in m.readline().split():
-                    yield to_cmdfile(obj)
-
+                for mod_line in m:
+                    yield to_cmdfile(mod_line.rstrip())
 
 def process_line(root_directory, command_prefix, file_path):
     """Extracts information from a .cmd line and creates an entry from it.
-- 
2.36.1

