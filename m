Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC04BF8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiBVNJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiBVNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:09:44 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9872151D37;
        Tue, 22 Feb 2022 05:09:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in7e2hBlQnwHx9qZVHRwdC90HWlCM2YeT+fc+Lo+YyiM6s/C23NAJ8CJWQ90l8TDJ8/4XcNisTTrHOKXDEE6YoqKHljQtUACW1dHw+7q3UfHegBFMaHbtmYhigtHwoMkj3JnGAchTkPnY4JWla5N371+I4lyXx5LYVU9keB9lMxo/ybRbdmt6FWLWXtGPA2hazDMC/jyfu5vL7YxtaEUQ9w0yVVbFFisI2VCGTeDi2dvqnXFMStgN5yRs67VKkXeMCjR/dhB+83SVPo76q6zuqy92bS3ZGVhvwhc5nbRLXxAxObh1HBpUMpDdAGh0jaMuYT06aMK4+RBjj0tN5Fwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/Z3fEjKOKMW0QkQ3btV11c3rlHNFDZO5/ZL6qw9eNU=;
 b=Xe5qTxECUkCBRbKaBkSY6qKjKVG47DohMWrCX+5/TXo/mChDbHuW9JzSEnMrlMVBTNtZUUctGlpUgoFby0wggbW84/lrovPA/d25HVjFmEf+XFebi205pMnHYFqqtJYFEci2m3MfrCWI0bRt46RCkf48arb/m7W6lXl3sNAdBrdSv+jAdCF+0dcmvJGBrrtmIYz3hwhFo6tC/gJ6u2ID3YaZkT1MDmA+fdhvIep4e8gx1pryCDF3eTk1Jl/yR6b+gTQ7WSxAks3VWBvpl9BZnlpNsZaOdM6W6p1uCnHFaY73t8havUnSxgehg+OmcyGLX9Nyj9z59/Qokn+E6rm42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/Z3fEjKOKMW0QkQ3btV11c3rlHNFDZO5/ZL6qw9eNU=;
 b=kOI3V2gmzeS7RuKmTWwEaAFh7Me52d3r/mcHWMGJt/HqE8DRMSOfkIxxlMzlcdZPRgjrbNwFegQ2Gm40eIxQlp9Id6gQLy/EgYy9l0aXA7uz/jXgZC4otn4mP3a2eFsG8VBgN28ZA/fKXRFeEUvShUZL8FAVRl1+99lPWZMbzbU=
Received: from DS7PR03CA0127.namprd03.prod.outlook.com (2603:10b6:5:3b4::12)
 by SA1PR02MB8350.namprd02.prod.outlook.com (2603:10b6:806:1e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 13:09:14 +0000
Received: from DM3NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::7c) by DS7PR03CA0127.outlook.office365.com
 (2603:10b6:5:3b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 13:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT006.mail.protection.outlook.com (10.13.4.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.19 via Frontend Transport; Tue, 22 Feb 2022 13:09:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Feb 2022 05:09:08 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Feb 2022 05:09:08 -0800
Envelope-to: git@xilinx.com,
 linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=35690 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nMUuh-000Eql-3Q; Tue, 22 Feb 2022 05:09:07 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 0/2] clk: zynq: trivial fixes
Date:   Tue, 22 Feb 2022 18:39:01 +0530
Message-ID: <20220222130903.17235-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79786b65-9d0c-4a92-6462-08d9f604867c
X-MS-TrafficTypeDiagnostic: SA1PR02MB8350:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB83508586CB0928CF5E597CD1AA3B9@SA1PR02MB8350.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ATcseBI5epKMnSO87i7wnq8b7jC/ymjV9icbcs7/IDs0y54XL2wSu9Ze4NuTon+wsB6ZJwDlKeAZrzQhpX7sdVntHAdXPqYfeaqtKcVg9+53RLSxDMr4j/sXYgpBLhNv3kFISHAgVgkMB/BsCvqDqa7bWGxgqHg+t8EHhXY0HBOtCM1wQzF3DqxspsqLITXuYIE6CPv6yT27J4T2YUDSfZApxM52a6Q82m4a1b/JSoGE+6NPui8GQeXWSfHSIiVKHBBZalmhlBb5NVmbWEOrsALVvJpF9IGDfdC0ooGfufu5dLD04GGCSRtnoMksqGg0BBp5XM6rbruKFSlCdqUvcTgXYX/xQaTwvlJ0+28QfSieNER1Q8iQHUj6SWkEOq/GSZuLgNE/9X8q4MdVQn4ofIQXekUQEf/XVRL2ocO9n4NlkKQt/ue2tcaF7YozfHWFVwgP59pno0qCwarLKWDLXY5E76V7LbVh/OOG+3k1EipWDhOQJ/Wq8qRoMzNdmztDyYiUSC9E8yCacuDwkEXOet92Q2QbQMfWwRC4wEWsFe8yEMHgBUBJtCLveBzYzN8k+hdvhmaEaa7MPbMpj650fPmnASHPAqtv44dvvK8caUiVGJp/p3cy3IdXQCEs6CMTlwEn/n72ykleYlCA0tOQcY8Rn1JilzLMb6eISMIhKY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(36860700001)(316002)(356005)(36756003)(6916009)(83380400001)(7636003)(107886003)(47076005)(450100002)(8676002)(54906003)(70206006)(70586007)(4326008)(26005)(508600001)(82310400004)(5660300002)(44832011)(186003)(9786002)(1076003)(426003)(558084003)(2616005)(336012)(8936002)(6666004)(7696005)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 13:09:14.5299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79786b65-9d0c-4a92-6462-08d9f604867c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8350
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patches.
No functional change inteded.

Shubhrajyoti Datta (2):
  clk: zynq: trivial warning fix
  clk: zynq: Update the parameters to zynq_clk_register_periph_clk

 drivers/clk/zynq/clkc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.17.1

