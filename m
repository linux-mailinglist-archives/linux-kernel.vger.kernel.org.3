Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6775560921
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiF2S3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiF2S3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:29:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887E1C93F;
        Wed, 29 Jun 2022 11:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMemmpJccjm5t8qLuSeIgyQuDDPw1RwZTS3fLk4u1RPjReL8Rjr+AgxI/SNLRyRyZLnluA61BbvMy7ypUhsQZvXjJ85aUH81AhCrmErKlOtF8Q0CSY7ndZSk4gYZS61GNrYzFJE6mpRO9TtrjIvMyNhGLO5/6BjBE5tgJLfuADbMmpzE/O3Aliku5JP/ig78Y9/jN3Y6Z9Gqwlt9xTwijiemARa+l5gDRtVnj/6HDhweeVenSgPXQat6u+KKQjF65e3I8rYw9j2n0r7L8KDus5mHhqH+4hCp9iCiNTuPPQVoFc+xaEwBxu9q3XxZPc0sl+1jzjqPawZVK/Ekia4+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npopQAJP7ok2klS0KMbrSAbtluBKFRnqahZ2Y6aZHfs=;
 b=DH/E0UCKq8JjwLDYWhHzZt0Vx/xux9EWEuL0h5Q/TpDx6WKUBEa1Kz/66aIVtfhlSogAb7H+BqgK25iRUdqz+MAfMK3oSxIT4ligj1X3cPYoijNmEXY9ArmjuCGoQ8yzZmSh06Ah+DlO8VLtOaQIXeJXkYchIj3vf8oe8Ygn+pNIeQsfQLsOhXM5D3V86arOI8rNy+bcBurMbsUDceDmSHLdfuYlFkT++YsSYlEVJjR5PiZzmaUAPma1wjQrmtd38dq19zdLPCTiMtso4qHbbH756iNxYQxcYZYbvDAbMrykuGj61CfhPcqh2LZzw2AHr8XeRopuAAYQdbhcTQWSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npopQAJP7ok2klS0KMbrSAbtluBKFRnqahZ2Y6aZHfs=;
 b=lNqsCkQIFBIpLYY1biViGu6YGJgMtU6Q2QlVsq3jSxNmCFzfqn1exRyEk4S6n5CCqFOOdNZG7YM0FMkZS5LcZmXYDNa8/IsgfKTwIJQcBNCL7TEJC4Nw6FAa0VD6v7YOSZ5nbupzmMxt0tjl/NSne7OhPKhCQXf602iBPEHB/jxx8e+ajySq348ZWntR9qrPrjx/0jsBNkXNrdIGLY3+zcdY0pC7sGDJgCVP6fnCNwcRfu/X+uaE9XLfbXiSYZ6XzihW6QJW+S9wmI5hGnrHKl2xFADANPs27/ipk+0w08N9KCu6yUvFywKQOnDb79oa3T6v7KFHfbIPTd3SnPi0CQ==
Received: from MW4PR03CA0352.namprd03.prod.outlook.com (2603:10b6:303:dc::27)
 by BYAPR12MB4741.namprd12.prod.outlook.com (2603:10b6:a03:a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 18:29:29 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::76) by MW4PR03CA0352.outlook.office365.com
 (2603:10b6:303:dc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 18:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 18:29:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 18:29:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 29 Jun
 2022 11:29:24 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 29 Jun 2022 11:29:20 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH v2 3/6] clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC
Date:   Wed, 29 Jun 2022 23:59:01 +0530
Message-ID: <1656527344-28861-4-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02511e4d-2967-47e4-ccb5-08da59fd4da2
X-MS-TrafficTypeDiagnostic: BYAPR12MB4741:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjPqNozlMThC+kcBF4Q2LS4lO2vALQ/tsF/OuL3Yi7ub/pjdKWxW2EhgnltDep2bLth+bXKUi8AjTdRVZvmVfwdV+sVSAiVVcggoH8UmYpQewLnP6mDdSq/8qVPMxu/CsIhSzXnRrYzFPZM3zarbBTaQxy+R8dt5Fmfw6okobyYdtH1F4fwOdUHhk90OQtbyONFTpoq8fyqQYl8ROmCx72CBIbyG3QDWebWCcsSgvZLuGr3zpgD3Gb7t9ap6252tum2k9qvvXoTgzYos5c1WbhjXOI7G/ht2KR70Z8KCd8oZ9t5QZ5qUspr6OOv5GpChZRf6PwPz57OVF8PDkIHbUpyq+eYC2JV6z02B5Wd0tnEBWVDNfQaqRPt1XYJtczpsw1Ba2PpmaPXz6HdTI6J2ZLSB6EXVVhXkG0chP3HVvCchVYvIIuBBFqhVqWU9qM/9FtS1pDGtlmijE+aFjKDqHUIpwROfvbf2/tNOqxsoPfJzVI5EVMmAxrIRJXz9pPZk2+N+E/Wg9c/KPiIfE2cmcCqvNC9GyfVKf3CuTh1cqZ+o9t7leljvB0MWFYNJi8DvGLdm0bYb9PUgNHlx4Cgoeu2OyiQ4nQ0SrXRqr3tanjfzyN8rb6A4cx3pAWfdgT8nX9rfEpVwdygOlpiEX4dlfDaJGwYIelk2EdfiLyLKLHU6x4K6DymSTpIEC42n2qAJe5D9RfwYVP9NuuRHYOc4VF1+ND9nlOdO5cAqgn7VLocgGS/xw6aaoPVZJkj/x59whDn0iDYk2ROZnUbi9+1TEAvEgH4UYPoZnjSSGtifR8JiuBZELqfgIC0PzhoJQ1WD
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(40470700004)(46966006)(336012)(186003)(316002)(36860700001)(70206006)(47076005)(70586007)(83380400001)(4744005)(426003)(2616005)(40460700003)(82310400005)(36756003)(110136005)(40480700001)(7049001)(8676002)(26005)(921005)(82740400003)(7696005)(8936002)(478600001)(2906002)(86362001)(6666004)(356005)(5660300002)(41300700001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:29:28.6709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02511e4d-2967-47e4-ccb5-08da59fd4da2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4741
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer IP block present on Tegra234 SoC supports watchdog timer
functionality that can be used to recover from system hangs. The
watchdog timer uses a timer in the background for countdown.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 4515517c87a5..ea742889ee06 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -486,8 +486,14 @@ static const struct tegra186_timer_soc tegra186_timer = {
 	.num_wdts = 3,
 };
 
+static const struct tegra186_timer_soc tegra234_timer = {
+	.num_timers = 16,
+	.num_wdts = 3,
+};
+
 static const struct of_device_id tegra186_timer_of_match[] = {
 	{ .compatible = "nvidia,tegra186-timer", .data = &tegra186_timer },
+	{ .compatible = "nvidia,tegra234-timer", .data = &tegra234_timer },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra186_timer_of_match);
-- 
2.17.1

