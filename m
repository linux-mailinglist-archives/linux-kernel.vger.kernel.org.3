Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1566350D911
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbiDYGCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbiDYGCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:02:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10112.outbound.protection.outlook.com [40.107.1.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC03916A;
        Sun, 24 Apr 2022 22:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvUniLugxS4WTZOqWutO1Fby7i6NQmdAa4cGRMSHTvgc4aJaBeIjS8t8HWU0zFDvgUdYgmrXHYGmG3SRDP7iZYdC6r1lTN1MZL33etPEcnD5ELO2J2X0+nn0OkP01RXr+9LUqhpsmNR978qxJyH0j3Kz6y7+wOLhelduLYROasvEpTzglcpzvVukcfZTLEjvbmLRCpIl82sInYAiZG8zi4ejvDfPmGXNQYdBbh1vMsvqw+8lqmA6h9ICYZvWgsHe/6AWjgviWRiOLHvnJS+NuSjx7MAwVjxpGsxJUEiMOksIPiTT3ce3l+uYkSBoFUJ0HgSgH1Z7kumJmncgs35RTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yItIVB2LjgAgrsdgjwkeY+n4Y7Yuh6A6wEQyQUjd/y8=;
 b=LCk0PUP2WULOsed5YavnaAPy/8wBLdBMohmHduK4cLQQ3J5/IaqnOpKlA0eAnnPHnYAMKKNyliUjdJ8I+6/xz2NcGTCBrTyoTDA99QHSO2xuBEDdLb8K61Ry7PNyhyJAbXfbHfj/JrR0hupiWpyZCLvmh4iGx5f8pqyWI60WVyVNDgHUYHp2O4/0ee0374w4GHd8v+dxVtjfXvlUUILCw8J3Mds6mb6UZ6NDX1txfStEeHhgHH4IBhRtNer8t/46uZiZN1YQQziR+r3v6SCVhft3bBewofXH0dPGa/Sc/pd7HHQ87fmafQRxZeBNIPxMq8Z1m4KdW4g+2MH/tQ0g5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yItIVB2LjgAgrsdgjwkeY+n4Y7Yuh6A6wEQyQUjd/y8=;
 b=OOXTPUJtThFIHx5wccQuiyLoM7Ku4o6v7ezXPVgw+EAsr7fgVWgPMIQazMQkTPBegd5gctZVep75pFZlsPK8zZkvW0/atxMa63QGm4vx/zOpgMdoGfnnVp4km67ZeWw6n4uiS8GA2HgeT/fLkkRRD04PYAbTGz0EpQitwRx3ar0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB7PR02MB3724.eurprd02.prod.outlook.com (2603:10a6:5:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.21; Mon, 25 Apr 2022 05:59:19 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 05:59:19 +0000
Message-ID: <7160dc31-1429-1206-ec4b-1d8cc0652b27@axentia.se>
Date:   Mon, 25 Apr 2022 07:59:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] hwmon: (lm75) Add Atmel AT30TS74 support
In-Reply-To: <e4c15f1c-b2a3-4371-d2de-8205d3dfe972@axentia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae2193c-7b50-44dc-7576-08da2680bcff
X-MS-TrafficTypeDiagnostic: DB7PR02MB3724:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB3724FFED0472543CB3ED9B7FBCF89@DB7PR02MB3724.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /opChjL5QfFqSSNk4Y20qW6a/IajDIyu86Y9DQOXDBVQeMhvpLkJZy5xPM+1YB+ZHUvokGpv1onn5iN0xCl8h07yenfL2SlHOWkVn5t5CuW5tUOjSV98MBZZhJJqDAz7ImOmnXXoMrAlBQOnJXZAQ6y1ggmFF2jD2oNadHDfOirc1O4czT8MmprPN4gclbCLg1dbbfM+k+4FPrRnqopMLfzo/N5nTXaVz0wIsSJk55RmpIIAasNNHXI+qPevitsRW7BY/4gWlYNzH85ENbPc9cXMblsIaP94iGqA9derrcA19BU3JWqBLr7pv2/aGSpoXBfhbWeU6lV5HnUOTbgwq6IG09DVP6TLGw+HdidfloxJjwBmbW4U0pQIwStFuPDUDkbC0FIfGyc+q+tVuArhmJ+HM+7vYT/sRQ7oM1GUMoDK5AQ5Cq/zoQXr2Doca8cMeYIWKYU5t+EkLPOb38tOswtdAqe/4tLwWnQHPMVdmzLS56WuY0E9YwpSQX54C3g0VtSYMWXlIer0f8xMKeJzrUaMIyRuuoHtT8yuNNBAojiCyn9xs76jR1l42OJgnWtzgFJi7kYIJCnCgTubbSg/jZjXCELrakxcwaE9orUBEE12tbT4YxcAYAopW3ztTGplEEJloNCZnXwpM1Z1pFvJiEYksoxQ/XpgQ5RVtiSh7daMJmVMxE5v9PspM640qbbKUOiWv0ippyNtJ0GmWf3NZkO7e5bEGYPmXDWe8+bs100=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39830400003)(396003)(366004)(346002)(136003)(86362001)(508600001)(8676002)(2616005)(66476007)(66556008)(26005)(4326008)(38100700002)(316002)(6486002)(6512007)(6916009)(54906003)(66946007)(6506007)(5660300002)(31696002)(8936002)(36756003)(83380400001)(31686004)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk03ZkxDeWJhQkF1TFpNcW5PbFZ0VkU5M3kyMWdUUDgrUEFXa3lJRmR1MDFk?=
 =?utf-8?B?NVEwazlvQzV5aXpreHowQlF5SlJJUWpRa2VWZytqS0orVDlOb3ZkSEF2RDV5?=
 =?utf-8?B?WFZ6M0ZObkE0d0dOZGZzNzZkQjR6dU8zT2RwOHNTZFAwamRFM0lTWUdjaHJt?=
 =?utf-8?B?OE52TFM0bEwrZjZQOGZVMzNUb3NaVHJ5UDdhQWdxdHVvQjVMek1CRFJiQmRT?=
 =?utf-8?B?OEtyYjN1QVNiN3d6bmtlOGk5VW1uWG9iRGlwZ0prN0JKYU9jditYQVNkQmhu?=
 =?utf-8?B?dVdnM0M4ajJlUXh6QWVZamM0NnQvKzVDQStxOVFQbUl5Y3FwQ2t3RjhObkxM?=
 =?utf-8?B?S2VXL3FrQjltUTVadlh6Sk5wNjRtMlhjeUR1dE5pcStVNG1ib1hqZlJkdnpB?=
 =?utf-8?B?WVUyaldoa0VkZ0oyc254aUNaQ1JUN0NXOUVSSEpSTVpvMzhoc0w4QWN5UnVL?=
 =?utf-8?B?WENxa09oWkdBM3JhZ1BvYWxsZENJb1gwTFFSc2RwZnB2MTdCUXdSVEFwT1BG?=
 =?utf-8?B?bmpramZjZVVEZ1RIbE41UDB0ak5MQXcvaGR0bEJ5YXdSZ3pFbWhDU2dETnQ2?=
 =?utf-8?B?d0dNSDlwemFQcHhMTS9WVHgvbkJHcmF1ZkloWEY1OHpOOHU4cTUrSldvSmJR?=
 =?utf-8?B?aURpenp0SGNLNktJQWdQUUpXYzEzUU9wbjUrUE4vRy9hL3B0V3R3ZzZsTEkv?=
 =?utf-8?B?MmtKVGJpRDQzcjZMOW04RFdNL08vZytoT2JiWTB0RmQwaUxTSFNEaTNZSzlE?=
 =?utf-8?B?VXg4NGgxczdiQ0lGTjJrSkNVT3hBNm5YSWhoMTl4NGlBZi8vU3VFQWhUNlFl?=
 =?utf-8?B?SFNHdlBHMVlsbWVTRVJwNHdyNEpXVzNQVHBhZnJ5eTdObUR6RnJkNnFWbENx?=
 =?utf-8?B?QnJQbE1vclJBbzJjeGhWVnZOTlB0Zm8zUGYwb00xZ3JwZXFmc01mVWY2L3I3?=
 =?utf-8?B?U1UyYTFKeHlwT0VlU2FEbFFSZHhzV0RYMVVoMmhnUkorSi9Kd0pTWVdOeFNL?=
 =?utf-8?B?b01PZ0VvZU8xWGRrZnNWZ3lwVWxsZFNHZkJDY0JuZ0Q0My9OYkVyL2hKdElV?=
 =?utf-8?B?QzZ3NTZwN01FL3dOSFZncU04OEpFdWZoUm1xbHdISkVLWmgrcjVWd1J2NnRL?=
 =?utf-8?B?WXhKc3BtT0Y4YnNWY0N5L3lyMFdFRVlIcVFSYUlpYXhWNkhib1RFK0l2K01X?=
 =?utf-8?B?bHhoY2REa2l0WCtwVzV2TldPVXRsU2RJdkUvNjZsOUhNQ1pweDkrUGlwVWlM?=
 =?utf-8?B?LzJJRDZMTjM3U1RGb1VPcDJ1NnFyL0NSditBUXB1ZlpGMURGcEcvNm9ZYko4?=
 =?utf-8?B?OUtxcThZV1o4aUhPakNSbnovRy9STVZCbG9hRVErZlFndDFLQWJmb3pJMDdE?=
 =?utf-8?B?RWJBOEt0NGM3MkpsS2ZjeGhqRm0ydHYzVzlaTUhxN1VjdTZTazBRWWlqN05T?=
 =?utf-8?B?aXN5RkFob1BMWldWZ0MwSTJvRk9COVdKRXhORExVQWRnNXh6T0dmNUw2dGto?=
 =?utf-8?B?TGhISkJ2UG5YSGFvR3Y4K2N4a09Rcm14aDRScnVMK2YzZE5nZWFNajFCS25Z?=
 =?utf-8?B?M3Rmb1ZPeU1ZelpJM2w4VmNkSXd1Qm5JR0x1WjhXWmNsUjExczdYbWhxN0VH?=
 =?utf-8?B?T0ZFOXVzT1YybVZWcDVEd00rMHFlU21WbHZXbnliQTFJcnIxNXdrRExLWTlE?=
 =?utf-8?B?bDNpaVZUYkFsbGszQUJJUjdFRW5qWGYvbTJGVkZuRVE2Mk1yR0hCMjY1T1hE?=
 =?utf-8?B?OUZZV0J0VVJSNUtPaWlCblc2MkhlVXBzQUc1Z3g5OFlxYjk1UitOUll2Rnhr?=
 =?utf-8?B?MTNDMjVUSnRaTGVXa0V1ZjZlUXlJN2xwYkVZc0k4dFFFUHR1TnJraUNSM09w?=
 =?utf-8?B?UGRZOTZZWTVDQllNbkJqZTFRVWFzYmszazV5V1Vsb2NsSlZzUmVGVkJSa24y?=
 =?utf-8?B?dVVLYUxrNFVoMmUvY3FxMUpDRGFrOFFKaTdPNm82VEJwWXZCVndkT3dwcElF?=
 =?utf-8?B?NzBmdlk1SEVhQVg5UEN0OUQ0NFpwQVkzTVVGMVhqZ0R1ZzMxZUtyaUZncU5K?=
 =?utf-8?B?Mng0b1NwZGl6MU1nY0NTT3VxaGNFcEViUUlCS3V0c2VsanY0VW9HQ1ZMckhs?=
 =?utf-8?B?V28zRlRwZ3JDMDhGSDRSU2IxbXBHajNBdFRGK2pBTFU3Zk5VdzRKcm5MUk1k?=
 =?utf-8?B?UzhhdUswVUZtTGd3aXJtKzJaQ0JJOXFlYnU2OGdSNUFENXVuaW1ib0QveUF6?=
 =?utf-8?B?MzJqbC9MUjE1Zjh2NFFDYWUxb1lnV0dzeVlGdWdxeDQ3M1ZBYnB6UVZxWTFY?=
 =?utf-8?B?RGdHZmlWTDJwb0hHNWE4S01ZNTdhd1JYaG5BeEI1T1RNY0s4UDF4Zz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae2193c-7b50-44dc-7576-08da2680bcff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 05:59:19.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yydI3sfP/ZGE0wXjppI7MOVHSyjMnsPIILC6Iu33vhnqU7r+yGvz9YExShSb+hEU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atmel (now Microchip) AT30TS74 is an LM75 compatible sensor. Add it.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
  drivers/hwmon/Kconfig |  1 +
  drivers/hwmon/lm75.c  | 14 ++++++++++++++
  2 files changed, 15 insertions(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68a8a27ab3b7..d8dc58b2c55a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1248,6 +1248,7 @@ config SENSORS_LM75
  	  temperature sensor chip, with models including:
  
  		- Analog Devices ADT75
+		- Atmel (now Microchip) AT30TS74
  		- Dallas Semiconductor DS75, DS1775 and DS7505
  		- Global Mixed-mode Technology (GMT) G751
  		- Maxim MAX6625 and MAX6626
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index afdbb63237b9..66dc826f7962 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -26,6 +26,7 @@
  
  enum lm75_type {		/* keep sorted in alphabetical order */
  	adt75,
+	at30ts74,
  	ds1775,
  	ds75,
  	ds7505,
@@ -128,6 +129,14 @@ static const struct lm75_params device_params[] = {
  		.default_resolution = 12,
  		.default_sample_time = MSEC_PER_SEC / 10,
  	},
+	[at30ts74] = {
+		.set_mask = 3 << 5,	/* 12-bit mode*/
+		.default_resolution = 12,
+		.default_sample_time = 200,
+		.num_sample_times = 4,
+		.sample_times = (unsigned int []){ 25, 50, 100, 200 },
+		.resolutions = (u8 []) {9, 10, 11, 12 },
+	},
  	[ds1775] = {
  		.clr_mask = 3 << 5,
  		.set_mask = 2 << 5,	/* 11-bit mode */
@@ -645,6 +654,7 @@ static int lm75_probe(struct i2c_client *client)
  
  static const struct i2c_device_id lm75_ids[] = {
  	{ "adt75", adt75, },
+	{ "at30ts74", at30ts74, },
  	{ "ds1775", ds1775, },
  	{ "ds75", ds75, },
  	{ "ds7505", ds7505, },
@@ -680,6 +690,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
  		.compatible = "adi,adt75",
  		.data = (void *)adt75
  	},
+	{
+		.compatible = "atmel,at30ts74",
+		.data = (void *)at30ts74
+	},
  	{
  		.compatible = "dallas,ds1775",
  		.data = (void *)ds1775
-- 
2.20.1

