Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D25A2796
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbiHZMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbiHZMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:18:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B285DDB6B;
        Fri, 26 Aug 2022 05:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E30IL6xAbx15qoAGJT3b+CdvRgj8OkYDwlnDiguLiwmwSBWD/9JLeLthLJv0NS7lPsa685Hu2EKuiFkb/Q2GkSQsOnH/cZS9vrUrr9eJSb3J9JSG09/TgtPBG9aRx9SCurWWZuoEDRne0P9580/UguRI9UJCjgdwLBwZu8UfEy5HzrFHrIxkjJD3SNpu4n6sVZK8SInIMpMvSrjKXKkSbi/bm3Wh/aEu6OOYvepRZ2jhU2Ngdf+S0YkZkVo7Lz9bKMRsVJ6BOldDDPg+ZRFaHnBkOSMUQeKEH9eYuFzJrhKQCdxGVStl3RHqZapew0EHLsKC4buWa4MMn4Iivp6BUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxhY9JZSd1Y90JwEIwx2s6qbPQVuceZgd++MixZLL7g=;
 b=nmkoV2eJlnTW9C/q6SzhHc+LOnhrgh6JAlaBCJ0gtxUiSr76q2oHagGPAkaMOk9RL4mDopAmnQB0nywA+gk2zzoNDwUPDjP4XBM1xNY9evJ4GuVURxj5szG6ySkilDI8KVwM5mlHe29y0SRu4MpKxSOPlTWOGo0FJJHmQ7L0Kavx1Y7n6zfSMLdR46xnQs3XNmrkEnDm54Zkfs8HjY0zdXJ0zLk7IcbS4NxwQaZszD/8d5lLoZbnJlvdiuZyQbbMeQhJYnefUnXO/U/8Me9zFZi1ARsmR6b5myQ2dlO7GTvsJq6BeYqPhua5I9Xi9fje8dikYhkD9PLGV5mCFksNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxhY9JZSd1Y90JwEIwx2s6qbPQVuceZgd++MixZLL7g=;
 b=ZhpkVYex261zpMEkhhM+lAi9WU0XJcy/4SIxBK7MqnfBBVnwvaz9yCLayRiv1vdG8Q09DQCIbYuuLpxA+U1XjVh83CzpQ4Q2XpHKdsiRlp/TyWLjPCsU/XUofrD3E5dfyywTBGIVdPDbJI0jEO6Bi0mzDZVxmEss9x7LEPT67+IAO3ijtFHHwg3hiTouPBhIpYAiwXqfnIw1JEixOJ/Ag8Tn9G+etDDnKug/FpDkYIEIO9FEEJZvBYf38OCfHEAM/RPVOzC42aGbiG1eN7Hz8zd1CvvGh4NWgkQwfWs2qSW8SEzyadZCnjsNY2+pykizPHeDhKefnKZJWfl9zdk/2g==
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 12:18:02 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::41) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Fri, 26 Aug 2022 12:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 12:18:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 26 Aug 2022 12:18:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 26 Aug 2022 05:18:00 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 26 Aug 2022 05:17:58 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 2/2] arm64: tegra: Add user PWM support on Jetson Orin
Date:   Fri, 26 Aug 2022 17:47:46 +0530
Message-ID: <20220826121746.32003-2-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826121746.32003-1-spatra@nvidia.com>
References: <20220826121746.32003-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7261b63d-270c-45ed-89b3-08da875d055a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hzxw1BNuMdKol7MyI5xZ6st9ip+rRUPd4mzJskngYfXggd3W5cmTr3RRSy5N9vIO6BTQsPeFcwPffn8e22mUXvdfsWBFOj1nCTukeDriUOIjtaoPREfIKIP7Qu0oiKndCthO1ch6gjHxZvv+8AADJahJWZHhNveiE0JgxTI/FrzA++pXfccTF2/lBPgBCS4oA8FfSwLb+rJI1T/buMYopKgzJ7Tsx5fNmfnxEbQQq8xL/2YcoIxsV7/YKGp9EM/N8q2p62/mlCvD2WSeHm0q+l/SCtyHWb9WaiO3vqv+9F7bT8OThQrohLBoZRELrQJGEtA4N9hN8O7vWcBgX7syyUNOzggwJY1VXAzjvuRZmhYy53oeGCEkcIWh6qIKCdGPGrcCU33iDZ5TsBnaPP/GTJudvVA1lmB/UEclAeE8uo3Gi3MTRdAMbBAe2N1hVdiXHEhOqw5g4z/0Dz6nHF7TDa8GGgn42jWPPPLmUx85u1miXjBOtDjmy0QDH/ThNI6rS8ljK0CzFtfRyH1hfLfAY6on3jqthyk0TiogV0OqlHUkuzu9CcWPPqzowleDwUwIuB2TBtl2gd2mZDZTRBX/EFm4FOddHf/4hdoQKRAh0PjVt6PSTN2eUQKOj92jaccOxe1RYq6RPK1AlNTsL50cXIRcmzUXrSh8l/XYAlmcd4b2sl3Jg9w09mn/Fb+7fvaM7sOhQwNq+g/m18FZIS/9L3DLxLy/cUQ/GbZHY4byFmXjCJ1OvRQ2mW+wE6UPfd9mFimrLy3fDC0AkxdjB2Rk44cOknN2JqBWVtP6uk/pjqrri9mBl28VzNkJCX5sJiT3R8D/i0vZ/A0RMyjMPdMZKQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(40470700004)(46966006)(36840700001)(82310400005)(1076003)(2616005)(336012)(426003)(47076005)(186003)(8676002)(70206006)(8936002)(5660300002)(4326008)(36756003)(107886003)(6666004)(40480700001)(478600001)(26005)(41300700001)(7696005)(4744005)(356005)(40460700003)(82740400003)(81166007)(86362001)(36860700001)(2906002)(316002)(110136005)(70586007)(54906003)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:18:01.6624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7261b63d-270c-45ed-89b3-08da875d055a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable in device tree and use it to drive the PWM controllers on
40 pin header of Orin dev-kit.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
index a85993c85e45..e76894574d32 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
@@ -2,4 +2,18 @@
 
 / {
 	compatible = "nvidia,p3737-0000";
+
+	bus@0 {
+		pwm@3280000 {
+			status = "okay";
+		};
+
+		pwm@32c0000 {
+			status = "okay";
+		};
+
+		pwm@32f0000 {
+			status = "okay";
+		};
+	};
 };
-- 
2.17.1

