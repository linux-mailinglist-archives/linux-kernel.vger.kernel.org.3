Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED3573961
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiGMO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiGMO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:57:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E8F3E75E;
        Wed, 13 Jul 2022 07:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCWTyYeLTwLCaJXq3T85zOsbL+ub7uKuQsofd8QBgd9e0eV63QB4lw6yxRFvdvPM/NKaQLHyKoUWsYI3LGAnB4FNNSTlt3yyfIHmZiWW7/czg4NjHn5Kk4rzSiqrrmA30Y6YwYHKsLAAv4WWnpZpb8iPWRbWf06UXZ2uk8lPhcsZIin/RszBFvWqOsXbynJBpjLHqM+3ZJDV5+LB5sv1QLbX7Q6e1JGkA43SETitNAHxbpH1kIIdRpEu5HSFyjuovY7LoVr+ewYDQqYJp/skoq2S00jjWutSrptSiiHPRw5PDO1xtcD5bypqU1pQec2TCwwKHoQ5EmKf0lyY8x72kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TdE5gMnaZ4RpqJ1/gBId6MFgb8G9NdwWxJ4JaBL//E=;
 b=H/Yr05lThtHvGER2zlFZkd7RBPgi6Erq/piFjaovDFfHRQgU5baA672D90+vF3rttFIVwmxSdo9nQQ5uX38/drLByZuH7fz9Ytm0g5iggwIYKzUZEtwCQ2v4RGodAAMDDLbxXdYpCHh5xVanQbjlcSZiQ86s8+IpsFwC+L77vlrxS7SONmYKroC6YdX4OYwikbKwzNEQ1TgVaKzpa1MCl3XPJfKJ7aARcBegK4WCQw7jXgTu39f/XIa07MiMChSsLCmPHJLJD3S0nr/3mt9vxuSeV/Fz+3sxCA4a2VROZwoMZlca4f0GCIaQT05oLkXLs2ux9MN3uVRmdqzWVJfjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TdE5gMnaZ4RpqJ1/gBId6MFgb8G9NdwWxJ4JaBL//E=;
 b=nfCd6IbEx84dfBcL78qDBxwvs0sPHOftIw6Gk35osmtNFusexogIxO+lyVcIq8vy9dgomWDegSIkobIoR/vrNTJRYRr5K8mYXRK8lyqTg0iN4kWi7I7to0kwUuMF858mvgMqV2jbl7kdt3dFq1qrGQ0yMGyJfnvSf5k5i9EUA1Y=
Received: from DM6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:333::9) by
 BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 14:57:39 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::a8) by DM6PR03CA0076.outlook.office365.com
 (2603:10b6:5:333::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Wed, 13 Jul 2022 14:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 14:57:38 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 09:57:37 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bjorn.andersson@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <konrad.dybcio@somainline.org>
CC:     <agross@kernel.org>, <david.brown@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 0/4] thermal/drivers/qcom: Code refactoring
Date:   Wed, 13 Jul 2022 09:56:52 -0500
Message-ID: <20220713145655.3844109-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f947ae-2aef-43c5-2eba-08da64e0075d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAEH9tBGSaeiuwRUyiC9RH1/v/WAypf+sNmLRfte8Uiwapf50cVEvImrpnsfRBWSkVqyrpUAyN6d8fvNpTqEuYFufpSb8HSq8LDOVrUQoFwogM95dUIjGsh8UWUhn73FWPs0HDNEmgfxix8GQQAWl+OSVQ2aWs7T8tMvPxm8u2OG0FyTve8ieFIFvEmbDgScmkaY2Cluw6uvW0wHTWL0rOcok2bVayaRMWrveRR8e8mLYkEy7Wf1kawYuwJpMS2vzIktkN2X5/j6iDBaoTRJ7d6zVC+eLoqIwwSf+9uIzVIgA9K/y76p3PnQ84YFxnPWgHjTPBWelEbDql7pXnfr7v06LpyqMQv6bhEtorZktRSdQzlW+65AJM7CdCqL66wXegK+4rWj/bfhje6fbVNaDdx8O4xMXKus7b0S2bM4JVkbZVcLWZYnwAX2YuX31jzj6dixJfGKbAyDvDQ6fexXbN36k6xFxEmv1gCOCQ4slwlg2wB4DuYvL7p7UMB7cHFYEiIITNq3O/9mHZhknsG+xx4Lgi+K+wVR62PGgFV76eZqt5mH/FNL3uQ5krrw/5NUJWVGw/Xxs2UrmvCOdNljQ9cxJYZFTyTsh7w5PjIiWTf+PjxWItC/EGkXHLw+P7n8Fgv5R10N8xrq66mA12/x+fYVDocuxucTE5ouj1mekfZPgx/yUOquoKOCHsmwrf2q9nSrWdrCnh+mZXQeA+4tmcXg3NbqhbPxYl3B5EiluEY0o83MQOEpNt8+8ALTUuvySRInn+SmdjH5ec3yuf31Yt1qknXdMox6Zo5u5tZsb8EgSpQuwZrELjGHZWlijsGVuOyPjJGMFqBueCDXfWBSwjVeAzqh1e1I9UJnrtVqoPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(40480700001)(83380400001)(356005)(86362001)(82740400003)(81166007)(40460700003)(36860700001)(82310400005)(8936002)(5660300002)(478600001)(2616005)(7416002)(41300700001)(2906002)(44832011)(54906003)(6666004)(110136005)(316002)(16526019)(4326008)(8676002)(70206006)(70586007)(186003)(36756003)(4744005)(426003)(26005)(1076003)(7696005)(336012)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:57:38.4408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f947ae-2aef-43c5-2eba-08da64e0075d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset refactors the code of Qualcomm thermal drivers, with simpler
return values, logic for two functions, and a constant array for maximum
number of sensors per version.

Carlos Bilbao (4):
  thermal/drivers/qcom: Simplify returns for tsens-8060.c
  thermal/drivers/qcom: Simplify function code_to_degc()
  thermal/drivers/qcom: Simplify function calibrate_8960()
  thermal/drivers/qcom: Use array for max num sensors per version
---
 drivers/thermal/qcom/tsens-8960.c   | 33 ++++++++---------------------
 drivers/thermal/qcom/tsens-common.c | 15 ++++++-------
 drivers/thermal/qcom/tsens-v0_1.c   |  4 ++--
 drivers/thermal/qcom/tsens-v1.c     |  2 +-
 drivers/thermal/qcom/tsens-v2.c     |  2 +-
 drivers/thermal/qcom/tsens.h        |  6 ++++++
 6 files changed, 25 insertions(+), 37 deletions(-)

