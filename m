Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8855D242
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbiF1BYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiF1BYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:24:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F050760F5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnuBvgr/OCzMiyPjqOwF2FQVWV3ioA7gIm2vdY/FeZ0HOtfstYcPA66peg8f2pDAWuZdICQMToA6fZ1a7T3gs/M6nay2qeQ3QetPgPPx6e7SBb4I4Nid6ukAKViI4AlXFWSHVnRwo7URxAz5V5x+mYdjaQbtTqEmkbuxmCwZbwqgcdlv8OMySuDq4xRSftAO0SLBqoR6zNeHyybdtgIhBuCmit1uZ+e9s5NF2V46WDu0FtDY1tKIY7G2LyBX2Hr04kBYUJJIuQ1sJjFo3sqXY3DEO7JwdpxSXRizeJvQOG5ltgCJ7ehECUOKoJBjbtyGT+0A1rnlZ6DCfFqHoOpAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAMRenqPSW7+Ofh9sizJRojoXhFhn3UYruuqoaKcgzE=;
 b=C+JmpjDaNgHlNFROrKOf03MASVFU7FShXjkhOr48D0b/oHXvAwyLGOQxpOYholS4ByhgRsUX6g550H17L5NjfZ40OcOZjuR2CFm68ZbJdCn83NezINLPTS1B/1SNTUGkTS7OqrjC1h0EhVrc9J8QJfNxNAevzbhLsRRAwO/ZSi6HJFyXpz7RhRp1dFweXwRI2bI0TON0JlUHwAxIfFKDkiiuK4UIfdGoJry16KQ3TVehc8dAhE9jbLYuC15HvX80LJM6ypkRykZ/ZnOVa/5LSI6UyH3TVLTWu7Osl+ktgNypco9BbFcQ4zZDW53dixShqDb641pcH2kYaYiyL0DaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAMRenqPSW7+Ofh9sizJRojoXhFhn3UYruuqoaKcgzE=;
 b=OLqvHqjuPtgMFYb3/31CVxXPlNmLdmyQGGnuGg+pT6UIIyk+xqEAS91G4iQVfocrkitfXAWnOVMXc91m+2WEvNDJ0liSytiQwR1h2x0WxhyIWRnpUGjnAakNMaWz0RTo5oC8biRdSjm4eUpt1JP4V+JZdM13pmLSV6QJBgTbiP1r5Luv91OFNjQhf4iS/07Q9lZXPc4jhTdqPVOlAAuIAATVmCwK9hHmPghS+k7RdL2xPzX5WDUamzvTSX+sfn64lQFQ2rYLn419r5xs8rfOoYwSe528ExWTjBrvCjt0SKRNt8RBFAcyLBRBuF28yZVya53dSUTM9jmyu5VlobJnJQ==
Received: from DS7PR03CA0146.namprd03.prod.outlook.com (2603:10b6:5:3b4::31)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 01:23:59 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::37) by DS7PR03CA0146.outlook.office365.com
 (2603:10b6:5:3b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 01:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 01:23:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 28 Jun
 2022 01:23:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 27 Jun
 2022 18:23:57 -0700
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 27 Jun 2022 18:23:57 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3] gen_compile_commands: handle multiple lines per .mod file
Date:   Mon, 27 Jun 2022 18:23:53 -0700
Message-ID: <20220628012353.13995-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d22a9a02-2a03-42bb-0f60-08da58a4e08d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4z6jmrUcxp2n+Kskis9AerUGyVdz6uy/0hgtmmnPEU9P7OLUAX2cIujYBTpLyq/BbmWMLaBlRcg2Hc7qJRl+Dxj5yK0x0slSg8EmgBy2ulnIwTcod5a2Vx56v9V1BeP5NNWAf9fB1ofTzGB5twxI3PozHfJa5cG/tokD8OqzdSLANC3soIE7ShgYMtcQ7Ou6myhb0DebCXUMdQqSo0tu3lUwQpG148xBE1+Q4cpEcspffXlphxh74vZs7F8jKv40Lg6cEI3kBBPAePAkLfkaUoctgCstBL8dGtWfyE3q5cKshGgYl4/rxDFvA0VC6jCUUfT/K/E7aZ+fHplTXA6pqESGZ1ueeAw6m88IdOyHbmuT+jdR8kXSBVLqGmlQHDfgxhgFFD2Ikz0PAZq/ZIPGzlf9gftTXVzgFiW/LPO9fAXkda8rAAl03zoOn6OpArs2R4eEpnfu5tGc+0Ue3Lo/C0SgzcQ9iRkVFCGSj68nY2Xy3sSFjgdOtrXHLNtcHT7/TP1ojnptnfmLZyFk5VAVk7D5JLRs+CMbrXsdRDhfTfihYxzB3v3xOTVtASuek46TwZWmKWtnhjdZOZoD1xZZz78d5EDVKJjgB1lvQWH+x2Hr1DKnPcIWez0C9IZr9pXaxITYe3m1i+XKn2W+YCn1Sdq+MBpbT4BetZMwzLvLerj88MX6r+Rqb58SFvAe3aByWxtK74m8X4n0C0jrLnH7LZmz27IZiz8N/pWDN4cTClM8VmLd9L1zg7HXK/xGYVyQS3PAPkUO8ut3JaaZ0Fo6MQEfYhYo2Cd/itL2SpoLYNihHtrW18PDud8oOTG5izq4s42X9mE+y7M4//KKbN408NtQ0RS3qpez1F5boSMuod00/LKSXRsysG5hwbG+OhcLI/ECeuba9uaCa15VfSk9jLODD9QmuZgXySe4yAhpYFsFTLXZyEvi9qSdOFv15vB
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(2616005)(86362001)(1076003)(4326008)(316002)(83380400001)(81166007)(426003)(40480700001)(478600001)(54906003)(82740400003)(6916009)(336012)(82310400005)(8676002)(26005)(107886003)(186003)(70586007)(36756003)(5660300002)(356005)(40460700003)(36860700001)(70206006)(41300700001)(2906002)(8936002)(6666004)(966005)(47076005)(142923001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 01:23:58.9693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22a9a02-2a03-42bb-0f60-08da58a4e08d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/clang-tools/gen_compile_commands.py incorrectly assumes that
each .mod file only contains one line. That assumption was correct when
the script was originally created, but commit 9413e7640564 ("kbuild:
split the second line of *.mod into *.usyms") changed the .mod file
format so that there is one entry per line, and potentially many lines.

The problem can be reproduced by using Kbuild to generate
compile_commands.json, like this:

    make CC=clang compile_commands.json

In many cases, the problem might be overlooked because many subsystems
only have one line anyway. However, in some subsystems (Nouveau, with
762 entries, is a notable example) it results in skipping most of the
subsystem.

Fix this by fully processing each .mod file.

Fixes: 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Link to v2:
https://lore.kernel.org/all/20220616021149.327587-1-jhubbard@nvidia.com/

Changes since v2:

  * Restored a blank line.

  * Rewrote the commit description.

thanks,
John Hubbard


 scripts/clang-tools/gen_compile_commands.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 1d1bde1fd45e..47da25b3ba7d 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -157,10 +157,10 @@ def cmdfiles_for_modorder(modorder):
             if ext != '.ko':
                 sys.exit('{}: module path must end with .ko'.format(ko))
             mod = base + '.mod'
-	    # The first line of *.mod lists the objects that compose the module.
+            # Read from *.mod, to get a list of objects that compose the module.
             with open(mod) as m:
-                for obj in m.readline().split():
-                    yield to_cmdfile(obj)
+                for mod_line in m:
+                    yield to_cmdfile(mod_line.rstrip())
 
 
 def process_line(root_directory, command_prefix, file_path):
-- 
2.36.1

