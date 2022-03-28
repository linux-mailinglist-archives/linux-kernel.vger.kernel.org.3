Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A484E8DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiC1GRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiC1GRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:17:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198429831;
        Sun, 27 Mar 2022 23:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuyfTbFAsZZq5pWS2XJXsDAHhNn2Jt7Qyq9C27WQhCcK2F8oy1BMek8u3uQBEhythNV8PleNeK/IycGx5QhYtd94boKvCG8rQMeOlMI7lxpyoSctrY3efdntEtqOi1MxkLFZc5lO+JP5CSTERY2jgGkOxJ9iOp2hhxXYzKG/HPgnAbNP1Nf11bmLWLMVeB5/vpkRA6abcwV5mU8LgFaQernaNsWxCKpG8X/o1DErztLxY8u7d0qeGF7a26ZsEikBFzHXLLpX+X2xL77WtI7XAIcM2O8X+vY5UQ6rJ+2u2qbzgkfAyeG+bN75eoaWLbnN7pwDieqDTI/FENnOxGmJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFugAI6B8RrsIWb50yazBzK0Q5kazWT6V8B7QX7uLgw=;
 b=fEZ+ytOa/IJK1xgjVp9Mc5zzmsDtAyqK3raeruqNpKnJKkpmeWkDqbMO603irKIkwbWWj4Xek5iDcyJG0Ewkiyczjw4oEJXvyEmru1/j2srak+ulfr4Hpc+7mx2r3mUB/M9z6sm928klFs0TBwvEboVtB+CkkrfnRia8vjoafZUbXq4YbPWKW6Smxhnb0W3YtZ0shtV3RcWPS3rAX6b7kQCBATI0bBCr8UXXeWuDWxqqSjKp4fm6li5RU+4mh/v3StoQRzdhMrGnyhtyVyx3EZdyfnDWLgga457FOkvUbF17ajmv/0eUBj9Zu5V58qqauYnZUjvKDrqXgIL+B05QxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFugAI6B8RrsIWb50yazBzK0Q5kazWT6V8B7QX7uLgw=;
 b=rz7hwoeMJV87y80asiF0j63e60SFfb+u4rZqEC0m0WW71mfg5CwEMoaQxBBvsxYEvtl/xxvSonvo8g6n2dwll8l3EofsHH77riBVs/7f4xRwHff1Iz9nuzd3BGmuC1QhCTz33aswzms2ApK+8FoUEZgblyiHO1ewSmtXFLrqodtg/BZ9qTzJPW38oB0K4SbNyHGC8L/gAvggPheAEqjofae6kuFgoKIbuwpQKxr8LSeqeTyWufjUCyjDcDCy2EKcolFMhcski8UoSQzjkTMu15wiLr6ACmwQnj4SnyU7OvETvJFP3smCYeuZg2XI1mj+hYAeYmJtKrt9mBS552uKoQ==
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by BY5PR12MB3697.namprd12.prod.outlook.com (2603:10b6:a03:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 06:15:48 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::2c) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 06:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:15:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:15:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:15:47 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:15:43 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <peter.ujfalusi@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <oder_chiou@realtek.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH v2 3/6] ASoC: dt-bindings: Extend clock bindings of rt5659
Date:   Mon, 28 Mar 2022 11:44:07 +0530
Message-ID: <1648448050-15237-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff197eb2-2888-41e8-7849-08da108266f5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3697:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB369760067D7B51344D9A3475A71D9@BY5PR12MB3697.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQJz9iiE5r6RsKkiH0F3a701+UWuLxYWs98fM6EuhuVap5VYMIdq1QwfB+V3wXAftiTZKVVbbYYI8z7hGUWlHxZQrQ3avRk46HsqH4W32iGW9ckd2XVOiLQ3iGvNsE/nqMYO+sflbYMfmlVqXbLuf/xWGdysQJ+jrAWz9F2v9wmfv7IqZQVTMi3EkhgSWIydRlPZggfY3q9SaZh5scLNrs+mUJLv9Og08o41ry3XURPMHYd4otBjkiMs/ntDUDIIFoW0k+ZUCJu7B4so+OkYznon0658af0S1pQNf7YSUno6M+jCQJZjta8FHG+/s9kwyLCQ6jBoJMU3aBm7ZZRMIoYmg4kqS3JEnXWs87K+fjZ0R0WBaxooMypefm7vI3n1uNZwioHo0LiOxgEBfT1r3+SfGGEUWIydANr0BoZr6HtLL9H/3rHKztsoB2UCFHOhwjb65ggEjKL1jAW7ARdwkDeC3ee0uQuIgFHbdSFIv2rTMTOtTahVs8DJgZX8niTWvMuDCwjT3tf9Zd3ICS43Q/o8UgQa7QFnjwCiDAsEIJ6ebybnd2r+wn4GuissM+wvYPfY4NgL/cbrhnRGb3N39dz90mX69ARanKTCYI8Qw17Y/gG0Xz9qKeBQQFmlEtUOAHqIIsRzz3JJCMrPcCqxcmhT3p1XvWEIuq0uDe96H25QtOLMJNzRDpSrYYiJleQLnFd2G6sZbiDbg5nWjpGHCg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(508600001)(6666004)(426003)(107886003)(336012)(26005)(186003)(47076005)(82310400004)(36756003)(36860700001)(83380400001)(316002)(40460700003)(4326008)(70206006)(8676002)(70586007)(54906003)(110136005)(356005)(81166007)(2616005)(5660300002)(2906002)(7416002)(8936002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:15:48.4252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff197eb2-2888-41e8-7849-08da108266f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3697
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5658 or rt5659 CODEC system clock (SYSCLK) can be derived from
various clock sources. For example it can be derived either from master
clock (MCLK) or by internal PLL. The internal PLL again can take input
clock references from bit clocks (BCLKs) and MCLK. To enable a flexible
clocking configuration the DT binding is extended here.

It makes use of standard clock bindings and sets up the clock relation
via DT.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
 .../devicetree/bindings/sound/realtek,rt5659.yaml  | 53 ++++++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
index b0485b8..0c2f3cb 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
@@ -29,12 +29,28 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: Master clock (MCLK) to the CODEC
+    description: |
+      CODEC can receive multiple clock inputs like Master
+      clock (MCLK), I2S bit clocks (BCLK1, BCLK2, BCLK3,
+      BCLK4). The CODEC SYSCLK can be generated from MCLK
+      or internal PLL. In turn PLL can reference from MCLK
+      and BCLKs.
 
   clock-names:
-    items:
-      - const: mclk
+    description: |
+      The clock names can be combination of following:
+        "mclk"        : Master clock
+        "pll_ref"     : Reference to CODEC PLL clock
+        "sysclk"      : CODEC SYSCLK
+        "^bclk[1-4]$" : Bit clocks to CODEC
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names:
+    description: PLL output clock
+    $ref: /schemas/types.yaml#/definitions/string
+    const: rt5659_pll_out
 
   realtek,in1-differential:
     description: MIC1 input is differntial and not single-ended.
@@ -97,6 +113,7 @@ required:
 
 examples:
   - |
+    /* SYSCLK derived from MCLK */
     #include<dt-bindings/gpio/tegra194-gpio.h>
     #include<dt-bindings/clock/tegra194-clock.h>
 
@@ -114,3 +131,31 @@ examples:
             realtek,jd-src = <2>;
         };
     };
+
+  - |
+    /*
+     * SYSCLK is derived from CODEC internal PLL and PLL uses I2S1 BCLK
+     * as the clock reference.
+     */
+    #include<dt-bindings/gpio/tegra194-gpio.h>
+    #include<dt-bindings/clock/tegra194-clock.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rt5658: audio-codec@1a {
+            compatible = "realtek,rt5658";
+            reg = <0x1a>;
+            interrupt-parent = <&gpio>;
+            interrupts = <TEGRA194_MAIN_GPIO(S, 5) GPIO_ACTIVE_HIGH>;
+            clocks = <&bpmp TEGRA194_CLK_AUD_MCLK>,
+                     <&bpmp TEGRA194_CLK_I2S1>,
+                     <&bpmp TEGRA194_CLK_I2S1>,
+                     <&rt5658 0>;
+            clock-names = "mclk", "bclk1", "pll_ref", "sysclk";
+            #clock-cells = <1>;
+            clock-output-names = "rt5659_pll_out";
+            realtek,jd-src = <2>;
+        };
+    };
-- 
2.7.4

