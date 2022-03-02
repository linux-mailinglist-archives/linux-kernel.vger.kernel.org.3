Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149BC4CA4FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiCBMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbiCBMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:42:10 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337BF73045;
        Wed,  2 Mar 2022 04:41:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD99ZYN+n5cTfvJ8v66zWIC5iPBTZAwTY9KZQVpnoEcqwC6ihV3TUpUbBlcuAj96MAYQJdKCXy3vJfIm4Dn2m5TiCQ0Ws9eOi6siWjCMLGgK+FTl7E3qhCsF8Cv5zxHmt0uOQbRXVm8lwO6pOXY8LmyRwjUpOdYi7o3HPXiQpg3IGlxFMXxTwI5XUHrMWVtdLB5XYHTIPj60OSzLMp7qWb6MoJepFREPgPRq0wn7lVNpTr+jy/EBJsHMYHRSde5SQiZV03PlccPZylLZiS2jXFihLWHu17vf1iVOTz2jMQobhPhbwbQbabJSc1h6TWDH7U9UUi0+y6gewbZhLGrqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUkAD8ddIEt/b361xSe0B4lDQ3sUQZMAWxVH4IPDvbw=;
 b=nEqicg20TY9LWsfipTDo6Uic4qlrMI6LSKAzC95/MX/aE5NfFPhJQ5JSR2KTzBK0XnwqgxvAR7NrvUuNXqD39Twj7kUhf5sq0oekUCraWF45GCHjARGPB/+7qjevOYQq5hKtIwcxPnht0aM5pPrfd8QtBtHJ/hCszL3AFClOSOWcM+OxXSmqi0tERvnMKz646LWxSaGZDmH7hRGHTXMc8cv8bCHZkg7dSi+S3REMdSMFaIG9uIFRup8/4sR6IHy72++KmAMy+8O024xLS2tzExnYypxIf/acb6HLX1owMhpLVCFTg0f6HI+1NL38LVhTD5WXDPK/2zaLFsKi6dtwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUkAD8ddIEt/b361xSe0B4lDQ3sUQZMAWxVH4IPDvbw=;
 b=3PYwhwmlEQ/A1HR0Ra5rVLcTMGovZHPfz78GpoUcPJN7ayTfeMu8BOblcfBmHGGvAp6msKiCmb46xbYjAlWr/2POfaPBIiQzTGP0yMYz91y/N2ASa/jzeVcs57cCv/oOulZYgLCBXNRqgKLwXHW3mi8H6iZjISqZ5Pb1SBgOIq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2689.apcprd04.prod.outlook.com (2603:1096:203:60::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 12:41:23 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 12:41:23 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v6 1/2] hwmon: (adm1275) Allow setting sample averaging
Date:   Wed,  2 Mar 2022 20:38:16 +0800
Message-Id: <20220302123817.27025-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302123817.27025-1-potin.lai@quantatw.com>
References: <20220302123817.27025-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a5d5d12-d36d-4585-9824-08d9fc49f55c
X-MS-TrafficTypeDiagnostic: HK0PR04MB2689:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2689CA435EBBD7A61F3801D88E039@HK0PR04MB2689.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqjenFDmNQASfVsijyQ5ASI5dv49BdZ1XBWOvtmjjl4kKsD0kow1eomXW/tDoKG/+9kBZdfg+aNdJfYsiT8uq9VrrSib8SL3Eb3GX82JuwLHw7YKkA1mgybKCJSZ/OktkmGI9YCWyb/W/KCUooHhnBmD3VCOLviIcfBnEH//9PqtbMP+0aa5NPdcrFTnb19X4X0/vdHBQLt5NoIE3rgGKxUmq3TO/iJ33ZEGd2xDuLpw1WYvRu/7OHvbAn18EufkZFDphS764VVTx/TvhVpPhXkXpXFQzsxSvEzNDZU3XoXWV040MP1YrHkbq5V+gsO7YxmEg9k+zft5UPAhk0u+PyE7l31BjYCMqlQNamKtYiw/sDsnTot//xDkXHT/KtzOprfbPWKqDotsSVBnwll5IDAABP8fZFzp9gzozLaoY9N9ZQxkCTvbH3Lo+H2AFE3CMPd69vXCQEaLzmvidpb+MTGkYCCrBr/2hFB40B+JrFy1t99v8IdEndNHspRaHDxqLE8o/auIeTEaxvRmzyGpBKidOr3CnAmFnQvPhbJHllVycPzeNCZNRr3pWt6fnObLKAriEBDz2McKe39Fl3P3sfkExOzMVO/RWVxbPTi5iy2reSmdqVwsbQIoKoAKBGaLYA2vjuRbaMLh00jjSVsJHmF8jXrwd96g8VVU+++kzJ8L/a9vgHShjDTX9TO/zpv9Hkdu3OPEnvmga4oupHdUCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(110136005)(44832011)(36756003)(6486002)(66946007)(6512007)(186003)(2616005)(86362001)(1076003)(26005)(6506007)(66476007)(2906002)(66556008)(316002)(5660300002)(54906003)(52116002)(6666004)(38350700002)(107886003)(38100700002)(8676002)(4326008)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f/XkWxQVQrN6FSFUDLl3hP4GKg0pEos6mYsIp9m/X+7pRtQJjmbeo4UiAbk+?=
 =?us-ascii?Q?N2Av4O2unmnYZRJOih5ohQpg4KxiYN+paUaCkDIqLcq5bDX1WG0WMQrK28c2?=
 =?us-ascii?Q?gr3KzhngEzncML+KeaLy0/cthVAaCIYtpQiSPnmzEl5fX6O7z4Q4U0L2bDIC?=
 =?us-ascii?Q?AEBLsEcpoYLTlxFB+2dKwmLBBwliNjT0c1KalrmzMpKI8dnKzYDNJYWL4rSK?=
 =?us-ascii?Q?+YNVT7S7zaaohryI7gXJGpvXdLrez+FGM5ni4K8GEcJubZhW4UnreZuCorz8?=
 =?us-ascii?Q?f3OTnG9puK1md66F9m7H6iPEhbSCFY66MGZ20rgxjsxzP5f4tSuJUkYND8kH?=
 =?us-ascii?Q?3xE7uqaByXxNl6aNu9bn0fAY9bqAdoKNp94R7MtJe+4sPpDCpIUQl96xh8si?=
 =?us-ascii?Q?xBuIwmtazUHDd4ejW/v5gBgLZjW+vCiLuVqyvl7NLzqmMA5+WSzIaBu9jS3y?=
 =?us-ascii?Q?hJVzY9ADj3yw+1ZMJ4wZJv9qQi22+9pd1zCiFXeqGWV5N3NOq/yX51rlAHlG?=
 =?us-ascii?Q?6cIzBRML0GxvAb0/62oP4m2l1/F34nYX4q1Yt3exeCiu1hgNVtrzLvsu7Cey?=
 =?us-ascii?Q?r1iWsp/N1syFmZUjDxW3D48xX9lHEwUg5QHBjhP0DqYU6JORwd5Sdw+XMShV?=
 =?us-ascii?Q?yYxxu0tIBmlFN3k96iFBYSFhpOT/vQ3YmqBThJCOvgFANEzv+Go8/CIGRWIw?=
 =?us-ascii?Q?HvElUOgS1eFhcDK/cx+m511ykA5XHL+0O1HnUgBPQr2rusgFbhD1HHIgZN65?=
 =?us-ascii?Q?1fO+t3/8e4C4fJaLupvY7oVU/Ru+BsxrQhNJNc3mexo2nUiv6XMgO4rR/h4+?=
 =?us-ascii?Q?xFErhk5soJGAe8KE5Q1IQVPmJLv6yA9jnYDgxItxKGaJRd2eSqnBQMhI8EbP?=
 =?us-ascii?Q?oy2ZG34P4JRgKjgXIgczCCQ0uiDwmlI+PmYP50ruOEk+svzyHJm1E5OwBjUB?=
 =?us-ascii?Q?zgGJKd9tKCElZ2pala6sOOy7lH11abrdeTZ9cjsp1cVGCJW4DwJubwpvDNWy?=
 =?us-ascii?Q?1QpN40oAb0ZKdslu1VQUzba0URO9uRx9v7GML/M+ZAhzV3zPBbD/Z/FS16R2?=
 =?us-ascii?Q?2p5AtxV3FMZJxNw4pSV1UTR1AbOoXwBx0zZ3cEx64nfS/7ipOmoPOO5Yugdb?=
 =?us-ascii?Q?1OZuqBYs8P8gYKfOrK1EheqBcZUaQgyVjL4OOQBgaxbHlVrZmcyfQB0INaZu?=
 =?us-ascii?Q?Z2K0WVldqv/FkdSrQ6MyGu2gRtbRJiuglwOa0+vsqdoe2K3mmmGZPBI5j1mR?=
 =?us-ascii?Q?Vf3NKOyh/rn0vj9dwdBL9LlW3QPYPltnY9SM/d0fmKAPQiQrIQ5bY+AfPCdh?=
 =?us-ascii?Q?zQxRH2TD8zHWSKkpPd6/6+q1lARGYnC8Je8mgRQAKsO4fuVI4sYMTt34q5B1?=
 =?us-ascii?Q?fcNsmBBOSD+YxRGyIKEGgMTXEEVOjxgtQf0qe79RQ7t3Y8rgXtEkDacrUgHG?=
 =?us-ascii?Q?wR7j2WHMrYiJRB/mgWW+npa81fgiEyAtXVbmU56Q+3DNvLvUZqunBRJNf9ZO?=
 =?us-ascii?Q?v28yHJGYhzXznMcegeQ6vL4BS9CYO1g/afTzGm8un23TcAxd1S/8Yd41fHFX?=
 =?us-ascii?Q?7n4G8bEwa7yAm0JduceSJVsVewI5PBA4RXCo1SsTuedF60ZDBE4ft7J58Y/j?=
 =?us-ascii?Q?tCo7PoCsN5PNKexphevY+qo=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5d5d12-d36d-4585-9824-08d9fc49f55c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 12:41:23.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W14LFd3i1BzlzTXFrohq9Fm3BcItQ9FScXv5Ixfb8QCON4vOVI6Crnh/iskHRL2jYj2eUEpk6B5MDv1iZ7xkUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2689
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver assume PWR_AVG and VI_AVG as 1 by default, and user needs
to set sample averaging via sysfs manually.

This patch parses the properties "adi,power-sample-average" and
"adi,volt-curr-sample-average" from device tree, and setting sample
averaging during probe. Input value must be one of value in the
list [1, 2, 4, 8, 16, 32, 64, 128].

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/hwmon/pmbus/adm1275.c | 40 ++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index d311e0557401..3b07bfb43e93 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u32 avg;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -687,7 +688,7 @@ static int adm1275_probe(struct i2c_client *client)
 		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
 		    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
 			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
-			ret = i2c_smbus_write_byte_data(client,
+			ret = i2c_smbus_write_word_data(client,
 							ADM1275_PMON_CONFIG,
 							config);
 			if (ret < 0) {
@@ -756,6 +757,43 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
+	    of_property_read_u32(client->dev.of_node,
+				 "adi,power-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of power samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, true,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting power sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
+	if (of_property_read_u32(client->dev.of_node,
+				"adi,volt-curr-sample-average", &avg) == 0) {
+		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
+		    BIT(__fls(avg)) != avg) {
+			dev_err(&client->dev,
+				"Invalid number of voltage/current samples");
+			return -EINVAL;
+		}
+		ret = adm1275_write_pmon_config(data, client, false,
+						ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Setting voltage and current sample averaging failed with error %d",
+				ret);
+			return ret;
+		}
+	}
+
 	if (voindex < 0)
 		voindex = vindex;
 	if (vindex >= 0) {
-- 
2.17.1

