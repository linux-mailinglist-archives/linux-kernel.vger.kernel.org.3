Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12625A0E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbiHYKpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbiHYKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:45:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECA61DAC;
        Thu, 25 Aug 2022 03:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP5nr/lfM6040qk3/8DfnAvRNOKygS4dmeuIlgaFPTZuBVIkM85DxvRIif1HAgVbk8HRN9UuFPpv4jS6+E4G6EJDgr3WyZjPNdQkxi+FTmnqkNLCUAus/PlxC5RJ6NUDArk2PDcl5XbAyGQor5UAj2Pq8JuWKS957tOGYrqPzlgEKju+5q8OzwcWbA5aiuqPXNrndruSOHhltaCaz9l2O4QrKiRnLYhVJEw+YqXDcpnwqw8WeZFXBXc90oKauCR9h4RGaDzZfIsWF0VZMuby+t0yFzgNQ2fH2ZjD2WKOqRhrOoWK8sAG5+WnXc3j4UBUj+cn6kt+yIIMkG/nHFtDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoeqWO5jn+/1Y3EBaDcSz5dtAsOK/vG3RHWEKr4jE9U=;
 b=Qewlv3IahLhiY3O4pvhHyg1Crz5hG8idgRVZgKW3010A0tE2TfiV6BEjx8wZG1H5K2SPh65oTTYSzT1OGQWjvXDcmAx91jMkbfT+UuXQlz4L51FvigOjHyR/Gmj0RceePkzyc+2/oPaV85i5Sq12KUIZQRPY5z2os0u8/bknkV3Wy11WaTr912Oe/DuOV206FGaCsApeB0GE3uSoPR6q4nsU1erqDvJl6NtQxSpM4t9ACwVDItjZrQyuit8oEtxLP2HNdAcR59Nv1PL/qIp5rM18rYxdTkIsOJzRF0CvV21vJ0twQHpTRK/uaYw+Z+FnhIlx9A9eog8R9Hvv1pXz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoeqWO5jn+/1Y3EBaDcSz5dtAsOK/vG3RHWEKr4jE9U=;
 b=ek2sm03decBl8no0wuwVy3QPrOjfd7Kj1/Fvp5O89plyWBOzVgcGKaYKiQLNShh+V0wfMM7MfHAvk8JMUKLWAuRZd3bnWTWXEF2tzckpAAV9h+Vl0TbKkssK4Z/YHadulEEGfMaTO1sH14v77MN+EvuSSdnlv6IGdRNHzHRrlLZPkfd/FjV0T6iwgkAgfUWBckgpkPHps6gUh7q7SvuBAF/3mRYXJXHgUm7yEn/rXVd4eDKNrSiKrTJxW/LkKrSL0EFk+O6UWwK3VRT86nlRCok3cjwqhGN3RuZQ8f1wzt0omgn1D2NjsDV0mYtt6KgLyAeOSOW7ItdvFfhxTeJO7Q==
Received: from DB6PR0801CA0062.eurprd08.prod.outlook.com (2603:10a6:4:2b::30)
 by DU0PR10MB5386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 10:44:57 +0000
Received: from DB5EUR01FT078.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::7f) by DB6PR0801CA0062.outlook.office365.com
 (2603:10a6:4:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 10:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT078.mail.protection.outlook.com (10.152.5.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:44:57 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 12:44:56 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 25 Aug 2022 12:44:56 +0200
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
Subject: [PATCH v6 7/7] platform/x86: simatic-ipc: add new model 427G
Date:   Thu, 25 Aug 2022 12:44:22 +0200
Message-ID: <20220825104422.14156-8-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825104422.14156-1-henning.schild@siemens.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5abc5d1c-0bd0-4dd6-1803-08da8686da6e
X-MS-TrafficTypeDiagnostic: DU0PR10MB5386:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXl2oPvr/K7P4qmKD+OxyyTOkZbi8qLKlol38RSKFeCCQF/toDWB9PdzJd89lImnpfbBhS+PihFryafi7aWYTHpUh041QsZpGmNwd3tTwykRBOU2Ar3Z96ZHXpN58/EVI7UEK1NlOUDJj7UGLQyg8rOkaKhV4ks2kDKBZv7tNHhdMuvcWZ4cdxNxOUTzb9h81O4THYN9/s9jFb7NFWMztFXD4pjETmFVQ/GBVYXPVyker4WTaHKQqolDDTCl7QvgS9tIs6NfK/ivhi8nxmv8KLfOrDt4HusMCTo/GGgW4kKR1F0Sg4ZdqZWBYvyyTjUlA3ip4vx5Q6w+wb9gfqtC6PLG7UffwJ7IpIJIQGwJ5XV9hXcaI2JRprbKL7HRS/B/nXzNy1oU9M/5ECKQ6UaGffAeCNPFmRZ5uVAdc2JfOTQvz9rgYvWUBKx1kLouez+VCjt3LO7Dxtg/695AOn9pNDPfHkxAckGETncHW7HekWs1EpKhoRYqz3MnNpk6YjY8313Aru5MwX0ue0VqBH9JIsxA8YQ/+fX45MNu0YBS08NEj1s3KAAaqbmi+Bc0ksLD4R87wz3PKZ+0w2ZZWO8bH7pW8Mwysfl6luXcEoRZzWv9EJwcQKDXVn15P8VHgg8wZFNL4Kc47egoBEoFhkn5AN13X9cpnrKslRvj5XQyI0X7kmKjF6t5+OZtX4QsH/EaTly6oDu7qOJ5WjwyQkv57wD6lYdnl3TlWiXAOo01uKwtpcBupsgKI3txcuzK5+NmUZpG0qZ7knplYnEweMsHyJci38hkfT1bmOa7SwySJJhdk1ffx06C2W753gFHcnM3XflwYh1fcyawPG1pfBDASw==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(1076003)(6666004)(186003)(70206006)(8936002)(41300700001)(82310400005)(4326008)(8676002)(26005)(86362001)(70586007)(107886003)(36860700001)(16526019)(336012)(83380400001)(44832011)(316002)(47076005)(7416002)(2616005)(5660300002)(7596003)(36756003)(956004)(40480700001)(7636003)(478600001)(356005)(2906002)(82960400001)(110136005)(40460700003)(82740400003)(54906003)(921005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:44:57.4109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abc5d1c-0bd0-4dd6-1803-08da8686da6e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT078.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Siemens Simatic IPC427G. A board which
basically works like the 227G added in a previous patch. So all there is
to do is to add the station_id and make it take all the 227G branches.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

