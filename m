Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116359E41F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiHWN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiHWN0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:26:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2236152408;
        Tue, 23 Aug 2022 03:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkDZawPpu95EOeyTz97gzk/BkkJr8IBcEQqZR3HH+XSJjMYUigHwgYG6Vv94LT4G5eLTbYy4QoT3AC3+EfAmL1I82Y+yWxhs/50wKCUZYIruBxDV2OkTHVxwVL+5V8ggqKD9LD4BaNKJSsJWf2qchVCMYUFe4pdDg/nuYMs2S8/ziTMlo+gFQ2izqQuXIJQ3z/FMxcue19h7IY7HBdB8PWlY7N4W+iPehcK7+QStWWMb4bdP6ujqYRucvD5xwVr4DEzPD68+m7xd0yoIHp7+VcrvW03L+2TnROKz9c4CV46GaWP1pO2mR3rgh0OZAYCXJfiBC8UsvIQUGHbtxekkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig+9ZYMBm2YHvnFvLRT991etlN1SNWpA3AH0N8kLqgg=;
 b=AZwmqC2mSXz4gc5CQvnsxBXoa2iFEkn1HUeYohfjSjL6CnB4CjumK2ptoCjPsVX9wuBnPCLtgj/b/kTzciWrjK73qq5qghsE36DYYq/b1P6fBt8EE99IhGAJs/myX6/+8yMb41sGUrgvmSwR95LJSxHe7U19EU2uPfPaJtDWm6j1+va4lRbY+ZKmofS5/+b2JPEiXmSbHl+dOSzXfEk1CFOpD8LKZsRVbJ7T4n9n846zw1BpsDJ9li1Cc/UfjGXs7YqGuKqBPSL3aUyOmnlR2zgK2BSqITixyj8Xse7URvixgc7HBS1t1rXEMGr38y0EYlpIq8llROGG3rjxk5rJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig+9ZYMBm2YHvnFvLRT991etlN1SNWpA3AH0N8kLqgg=;
 b=Cb6Jq7ZfhntfWuUus8vCzU2/c7zR/vZeKBX/hd5a9aPTHFz6PykBCNaDK8w12vjy5Q+sF+ihFug7hYtrGlwlEqe0Ng+7s0oWTcnCc0O2WDw+DdJ+jujSE8VThpfU/JE6H1LBBa24E5topuR2zeuko2w9uJVYdKbwmysjDzpmTOysr2WNjmkpyWOzXBQvQfc2RLMSYcblXMihzmWxCTr7CWtxNCHa686r6Bfa08qADlz/oFN05DClvcJSCivyOt8ZcSyqUZXmvsx96HukIXdOi1c1q2s2aJWRhDoFU9bGRm0btiAiSx1Kk2ZlSh3QTF70BsJGOmz9jbRvffsXfJGoJg==
Received: from GV3P280CA0046.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::17) by
 VI1PR1001MB1455.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 10:24:08 +0000
Received: from HE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::e) by GV3P280CA0046.outlook.office365.com
 (2603:10a6:150:9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Tue, 23 Aug 2022 10:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT029.mail.protection.outlook.com (10.152.0.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 10:24:07 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 23 Aug 2022 12:24:05 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 23 Aug 2022 12:24:05 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 5/5] platform/x86: simatic-ipc: add new model 427G
Date:   Tue, 23 Aug 2022 12:23:44 +0200
Message-ID: <20220823102344.17624-6-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220823102344.17624-1-henning.schild@siemens.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.432500-8.000000
X-TMASE-MatchedRID: DRSU/fc/F+JM7wVZoURWlF0WokuUDzPm55gySjxbin5+J3gtIe0gA0+c
        rEA4+nhZ6Mw4RnkAvRLIk1roNguAzWxgjTXTl/F39YmJ+rCjjhEh4UgUH4JX7APZZctd3P4B2Ll
        btF/6zpCeEPi9wVyFrqzIaRs+qc7T7pA1TBPNQ93oszdb+c82BXBgpI59xlp2x5sgyUhLCNt9LQ
        inZ4QefPcjNeVeWlqY+gtHj7OwNO0LH2qjGZLbHROhkFlKRCzwLsiJq/wF5KQuSJb6i9HMGxiCF
        Are61nE
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.432500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 7F726871172C5A8D85E1A005B314EAA269C188B499D1A4300ED37D24E2E1A0702000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 196fec99-1354-4693-1260-08da84f19cda
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1455:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deGXeoZulfYVusQsOMffLGUbURMRtW7T63B4Dx0b4Gs+GE6NNkSeK9gEkMXKW/JdSh1DYWDLrVBWcu0aEQKAxyGQ0kyYkvs7OLI2b3V1X5Bs2bid8Ckx/ziwQiCrcizjhU2aQrMwhP7G8Aq5smZOtHg26e7/GUVoV2RrIAZJI0y6rBpaHMZ4f2Uv/kevEPtnnWmZQIR+Lt+UHz6gxPV5PoU4Jh2LxgkACGuQ3RB0IVhZ5wYnNLMPZs8Bv7wkRoUOZLAeS2Cq6ILVc1kcrAScjLRtLr3l7UwR3aIeHPP23+8vptxrAADdGyp7Pn4pQKeVQRGMmzsvFTAgt6c0+bYHcnToGeA6ea/ifgdI50spMqh/Fm2fisjyn98rVoqv7IYoqWWkFsdblMd9VhcLoha09CoN1GgVcZyl8RaL70e9H+WYqVRBwago/TgjXKjh3N3TfcQbP1h7hz1YSRHqyj+3ldGzNQ/TajrjPLmFCp4s/AASkEk5ERpqX0NTroP9fOfelETTYvfcy6MuFB8P6Q2Vf4iMkYHWm3xJu5HEyTsD99d570PEUKbTzSG1HNdBeTa4hSTRUm1j+6XQ+fHpabrIjbgMcJvRjCU16U5fnOKLIZ8T0UvyYQVIil6TmzDL8ILpO6vICi3u1A8NCRB9TqqYlf+nLEop8zUi0pTio80RSaU5tarrcsOuyXZZ5wtviRo0gqoXbdafRjUmkJfimAWkj0/92CUBvgrvUoS+pCvMjBPmeLOggwiHrZrV3BmH4u8G8aCr+NV1fkcmxov0zXKPoq990JqXCbWHPrLBIfgZljUg/djZGphlwcUVODfvJ7Fwdz0cSmhSZSM3uMYtJ4h2QYqsxw3bMoSmE9TErkfaggxyg5+oN8KBLubiaqwexXcYUugNxOWOoLFVHgqRFwMPgg==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(40470700004)(46966006)(36840700001)(82960400001)(921005)(356005)(107886003)(6666004)(86362001)(81166007)(36756003)(83380400001)(26005)(16526019)(956004)(2616005)(336012)(1076003)(41300700001)(186003)(47076005)(478600001)(110136005)(70586007)(82310400005)(40460700003)(40480700001)(54906003)(316002)(4326008)(8676002)(70206006)(82740400003)(34020700004)(36860700001)(44832011)(5660300002)(7416002)(8936002)(2906002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 10:24:07.8931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 196fec99-1354-4693-1260-08da84f19cda
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1455
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Siemens Simatic IPC427G. A board which
basically works like the 227G added in a previous patch. So all there is
to do is to add the station_id and make it take all the 227G branches.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c            | 11 +++++++----
 include/linux/platform_data/x86/simatic-ipc.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 8dd686d1c9f1..ca76076fc706 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -41,11 +41,12 @@ static struct {
 	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E},
-	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
 	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
 	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
 	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
+	{SIMATIC_IPC_IPC427G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
 };
 
 static int register_platform_devices(u32 station_id)
@@ -82,6 +83,11 @@ static int register_platform_devices(u32 station_id)
 			 ipc_led_platform_device->name);
 	}
 
+	if (wdtmode == SIMATIC_IPC_DEVICE_227G) {
+		request_module("w83627hf_wdt");
+		return 0;
+	}
+
 	if (wdtmode != SIMATIC_IPC_DEVICE_NONE) {
 		platform_data.devmode = wdtmode;
 		ipc_wdt_platform_device =
@@ -96,9 +102,6 @@ static int register_platform_devices(u32 station_id)
 			 ipc_wdt_platform_device->name);
 	}
 
-	if (station_id == SIMATIC_IPC_IPC227G)
-		request_module("w83627hf_wdt");
-
 	if (ledmode == SIMATIC_IPC_DEVICE_NONE &&
 	    wdtmode == SIMATIC_IPC_DEVICE_NONE) {
 		pr_warn("unsupported IPC detected, station id=%08x\n",
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index 7a2e79f3be0b..632320ec8f08 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -32,6 +32,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPC477E = 0x00000A02,
 	SIMATIC_IPC_IPC127E = 0x00000D01,
 	SIMATIC_IPC_IPC227G = 0x00000F01,
+	SIMATIC_IPC_IPC427G = 0x00001001,
 };
 
 static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
-- 
2.35.1

