Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AAF57FC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiGYJRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiGYJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:17:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2097.outbound.protection.outlook.com [40.107.21.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E7B1D9;
        Mon, 25 Jul 2022 02:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJJULKK7eqeptibHci1d3BM9WWhivIYsK/UDkpzjtftoLyyQLTGymi9GN3tGLJJVkbI0Fo1f422mirlNjNNb88D84wEgjF5QQCgAR0UYBcVOwOQmTRrmX2U2cd3lj+zFrH2iHPLsJ5NHpv3+/doK8UmJDtfbpKE4MGCEoIvp6fSKVJelhHjrwxLqW8hB2kNpmDbIQE4UVcXjEkMr3aYDyov20GU39HBwum2KLeig4AsFNb6GuPr1FglYgzKd17iiQe1X9NA+1xNRlzgMLSBH5TIJpiGPlWIVy5UOondlV92Cu6Qmzl5OOu2ZpkfRn5OIf72GX9JHFJ/WV0V6WkWQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABfIQg59Rg4WnFKH2wQ7pynE7D9Q8BrVTEmXyiLyZ0c=;
 b=JkNc4BC1tL9JY6Pvw+rzqDHXKMh/yyiflJGODIK1oLbG2A+srIjhsJiCFKE4sjJ6t8kT0mX8dIy+6F0VrlN/vFRrrCHLdWHP7l1Gm0ZgYkMqqFMoZAxEY/DqiEssJSbgfN8qnFnu5yBHk39bDRV/+9ehA6cJS6KWb5XT9LxmSEqbEQdB6I3BsB/GVAWuNFJzPJUlPNq2C5T3/9M6xJVshk9vGQcU2W0vAuSGiAF1nye5Jgu3rEyNzoMJrKdOu6qbhor5GgenjkkzwQysveUB9xXFeqyu4VSRPEH0YPMIUQdENQ+WesmtASWgnfBSGl0BszFfdLhePxv7L8X3/b6Y4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABfIQg59Rg4WnFKH2wQ7pynE7D9Q8BrVTEmXyiLyZ0c=;
 b=Zs8rFFHqbotwiMuCYlmCbhNFsucDTMr98Ke3rjsaAgoUM4eFgoHlwvbfqTpn10wsTHGzR2SdjzpKcXL62b5IohP0Yhn6KyxVpSkjaiACfNMgnlNoHK0TueGfKnKl0RRTdET6q9C4VPkske89LXtiyJZNpW+TgkW8yox/BMRS8L4=
Received: from DB3PR08CA0033.eurprd08.prod.outlook.com (2603:10a6:8::46) by
 DBAPR07MB7048.eurprd07.prod.outlook.com (2603:10a6:10:19f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.1; Mon, 25 Jul 2022 09:17:50 +0000
Received: from DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::85) by DB3PR08CA0033.outlook.office365.com
 (2603:10a6:8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Mon, 25 Jul 2022 09:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DBAEUR03FT026.mail.protection.outlook.com (100.127.142.242) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 09:17:50 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 26P9Hl2M027302;
        Mon, 25 Jul 2022 09:17:48 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@vger.kernel.org, Joe Perches <joe@perches.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MIPS: Restore CONFIG_CAVIUM_RESERVE32
Date:   Mon, 25 Jul 2022 11:17:38 +0200
Message-Id: <20220725091740.28188-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27a82726-471c-48e1-a2f6-08da6e1e8c55
X-MS-TrafficTypeDiagnostic: DBAPR07MB7048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZrhbJQ6B30uVcMCYo1FjJ5LiWyclYdU3fyVYsvXX0X3bwCxy9B0k8pS/oA7pOnhFvmcldd4es6dRBtGypIKHzFFFn4gncN57h4ULsHosOBBaEFYz7Ynfc+/bzZVklFBuxFAUE03d1ETEww47Si6CVijaAO5n6txd4fGxOE89LwYwmkFdlF2Ot+Ew7Uzq1GoTqybI+Stg6IekUymbtr6da3szY9cmedLOw7gu7In4o+OdSpwsan0VHGh3DcXn9d0y0M9o+i+JarW4OvrQHBdrP4Y17LCbvBVVqe8SJxusaHicBzNAZvzM4S38B/R/4GRXX6LTgISlkzKjYYW78+uRqYo70Hd+edkMWF2C2xwrPzg954zcHBWqZkeh2NDXpMdWHR+4oGquZ9sH7tQ+uSN7JAKby0wpiNt1DGlYWvHcCttpE6jIU6b9XGuIiKxcl/NlZGzSvlNY5rKkLfocoWB4mJXgRHGUJgGFzLN+6bzQPf+BUATuz6dd+Zw/Y4JMo3mCFhd28zDHYYSV1OJVpyP3+f4XCIFTsm74Fh/pWmCWlII1Ga55UZ8e8Lsh9p4Rl3lzE+7AluBg8T9AS9BqIrpXDm5WvuhuLwcFc+TFRF4cd+URCt5i1xVzsi+7QIlo/txmn9lwxLP7zGvq3MIkIw23EqUfkPEMWt7kQ7gldoiYbhmF6uVotphUMtupkd5JYuqD+8sWp0fMoEHIglVjgPfetwFbxyn1DMytHF5huqdPzrao1eO/mVfiU1wsLv7NZ9Uyv9hkDu13RR/rAjeMQXOohT6NzNkLQNicHAfBDWW5nF0APIYU4bAq+YVeuvZT6t+zGWrStrKkkxhD4bYpb1iiA==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(40470700004)(36840700001)(41300700001)(86362001)(82310400005)(6666004)(4744005)(6916009)(54906003)(186003)(1076003)(36756003)(2616005)(2906002)(83380400001)(316002)(336012)(47076005)(82740400003)(81166007)(40480700001)(36860700001)(70586007)(26005)(5660300002)(70206006)(356005)(8676002)(4326008)(8936002)(82960400001)(40460700003)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:17:50.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a82726-471c-48e1-a2f6-08da6e1e8c55
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB7048
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

We have been using the option but the definition in the Kconfig has not
been upstreamed. Fix that.

Alexander Sverdlin (2):
  MIPS: Introduce CAVIUM_RESERVE32 Kconfig option
  Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"

 arch/mips/cavium-octeon/Kconfig                    | 12 +++++++
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c | 21 +++++++++---
 arch/mips/cavium-octeon/setup.c                    | 38 +++++++++++++++++++++-
 3 files changed, 66 insertions(+), 5 deletions(-)

-- 
2.10.2

