Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8653896F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiEaBL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiEaBLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:11:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E093996;
        Mon, 30 May 2022 18:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD+eRIytNOtyuUJjQFO0IdTmmyaz6P1C+EldQLVHO/D9hU/6BOBRmKevftt5UkoaQC7QGPhdw/hkjMozlFQSmuWk84pElcQmpqV0WF90D4wOZCQodrnuY5ggB5L1kaIGHUqEJpe1SaUpkA8ZZJTvwPokQu2J1mrJkpggv/cd50yx1nQjvx28heyCzaGCKDUcenLBlCEq/MmRx66WpKohcgVlVv5MbdR2AqgpIZlH9u9EOsaw9PKw7ruKRWjt5PnDJbJRu/viE1k7f17vb8uRrNlT4xm3mUd9A5V1CUi2kNJWHeS+KHxExrBEuMb1efMqXwulTIL0wyK65rZmX8+7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjqpm39znF19RIwUEXykENaEek6zWNOvFFvtZH3gxtU=;
 b=kB1RdPlsdH/Yfe/1fdItSA+R5zvrDF459DjhlNTvdjV0L3VkC0ESDKlPs/ovvB0Xl5tmPn5wEfkOIOSGgCu/j2Wp5U5TeTeUou50mkYk9ZvARDpZpRliS5mFR6mJKsip/c/1C5PyzbwlsFcGoha32YrRPXtlzKA7L5C0E9IyAHwD20Y1ThDhyUt0V8mQbbTYVisrXSz/1U0GiNDV4vNmDH7d41rq0b0Nc1ri3NBm0SfrHKsd6v/xf+n5gNFFJteayG7gTL9EnY6ag6sMs7xVwEwReDR6yXNbnAxNoLaN53NRAxi1Du/Xy0kdfd5g/GC5C0XH+0H6Q6JMM+IzIS1L/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjqpm39znF19RIwUEXykENaEek6zWNOvFFvtZH3gxtU=;
 b=BiW8K+S3JOEY4Q4HdCDknDvadw2wecyYdw5RuoPf1lC4UmbLqEwo6r8v9j4JAv2eIfO45w9/mFoUrpEVepUlGWpoFYnfbJ4CRkdmEjcoIhZx54hWbnTjRdaEw601wUOUYfce8wzJsWrKwlmKf/QFBSmfIprp/80QoePREK6PnrI3Bf+gr92u+P/Z3/7eRHtIFCNY2r/pM4ruITIzyktmuWUjKraxVYLeGfQdtXztWgI13glOrO2syFLnR4Ofp27drMHwABuKIolW1oFIJFcCPdnUSF7Q53uPQLHLKfBeirW9IYAbBCoA8M1DOLmmXadTtCHhK6lmaypXDUhi00S5rQ==
Received: from MWHPR17CA0083.namprd17.prod.outlook.com (2603:10b6:300:c2::21)
 by SN6PR02MB4158.namprd02.prod.outlook.com (2603:10b6:805:2c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Tue, 31 May
 2022 01:11:14 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::21) by MWHPR17CA0083.outlook.office365.com
 (2603:10b6:300:c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Tue, 31 May 2022 01:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.160)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.160; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.160) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 01:11:14 +0000
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB01.corp.JABIL.ORG (10.10.32.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 May 2022 20:11:13 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 30 May 2022 20:11:12 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <ben_pai@jabil.com>,
        David Wang <David_Wang6097@jabil.com>
Subject: [PATCH v5 2/3] dt-bindings: vendor-prefixes: document jabil vendors for Aspeed BMC boards
Date:   Tue, 31 May 2022 09:11:00 +0800
Message-ID: <20220531011100.882643-3-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531011100.882643-1-David_Wang6097@jabil.com>
References: <20220531011100.882643-1-David_Wang6097@jabil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 794adf28-2625-40c0-df5d-08da42a27502
X-MS-TrafficTypeDiagnostic: SN6PR02MB4158:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB4158ECB14A1B71B2502B31EBEFDC9@SN6PR02MB4158.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DMh+uXaNLNk4zOJulsNehDBj463gCxyIT3e5Z7SCtQm0xpe0G4zoUdLdTBg3KByS54Lkr+IlI+VqTFImS5S5FZezjMu6CUl8ltLbFrq55LoNiCiYgb2k7/RQNzm16uI0VHCyyELJoXhTmuOGG5PV7DU35mMUdmjWUqJtdLZ1Mc+YHtU68cS5A0EYubwOXsTyCxawXdl/lvsLg2W4mJGFUSxxz6GI5SUSSQoRilh9zWjKif9td+xTt6nsAcRruAyPP0gNS7Yz1mBpLiUjE7tU35b53/Xk7gpKyTPzkY+GNa/bG1OqnaAFR3qsfnnrsnclCsgj0pLaech2nZzxHPA/Ib36svq2vho0mY2u1a5GNHteBDQPwLpYh84i2p7vzN7LWulWINRUvxoe9YYT81rrDmw9BdCVmVP/E5DL7hDdg4zR3a23H2asCsc71p9t9Qn0D1NxqhOVbyccAu1IlDYIWlK/vxGIReDS9XGobdOJW3O38872PD0RbgkX/IuElqp5zk/Vc+n5jSHBMrvw3ZzueyUWQk1V3Gv6bmmjRGbnVw3APKAlrbvQUFw+hZ3cx51teZJ6Vz8ySW2C3Pvs1iHO4onT9CygcObJwZMyhyp4fiqscN7KEj12h1rJPYcR6ajrHmpM4QJg9CiXLmYUGppdSPsn+91hxeb5yVX1Ha0y3Bpc6/p+4VC61kkoZcHUBpBXE8tfKlx/9A12yX9f69S8Q==
X-Forefront-Antispam-Report: CIP:8.14.198.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(336012)(2616005)(47076005)(36860700001)(86362001)(2906002)(6666004)(82310400005)(110136005)(4326008)(36756003)(54906003)(316002)(8676002)(70206006)(70586007)(107886003)(81166007)(4744005)(40460700003)(1076003)(186003)(356005)(508600001)(8936002)(82960400001)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 01:11:14.0510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794adf28-2625-40c0-df5d-08da42a27502
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.160];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Jabil vendor prefix for Aspeed SoC based BMC board manufacturers

Signed-off-by: David Wang <David_Wang6097@jabil.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 169f11ce4cc5..013ea02fb39a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -638,6 +638,8 @@ patternProperties:
     description: Jiandangjing Technology Co., Ltd.
   "^joz,.*":
     description: JOZ BV
+  "^jabil,.*":
+    description: Jabil Design Service Branch (Sanchong)
   "^kam,.*":
     description: Kamstrup A/S
   "^karo,.*":
-- 
2.30.2

