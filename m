Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27650EAD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbiDYUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245666AbiDYUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:50:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70097.outbound.protection.outlook.com [40.107.7.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17510FB44;
        Mon, 25 Apr 2022 13:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpL21KUzGc1y/6Kev7HBXw/6AUuGSg5eFrEeeC5go3pcQDshdJx6uL4bFJkc7Srp7ic5jnDsnkoNCWQOoxXzHLbPPqmFM/8h5+t7aBIyH7olp3rfzRCw+IFZQvCB+Prl04W6pHXbQS5JsDzjsoYS7Znvx3LFEkOQ+Oh9IyTaEbmLkFzQxtI2X5AN1Y5DSDarVzvtEh6H+MSLVbWMHqWyzeuzkUB5TFwW8mj5pCUNPQI+z8/Fjg4/n9jDWhGLh2qBltem8r5BaMQjZ9NpSIISfqWl1jJSkvIa5smPj9LspW11VsJADEwKvycCfWdiABZa2oi0f8ODLthfeCbyklL5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHG346M6BIcdzB3bq+gIvCZySB47kX4UwfX0Kz5ND6w=;
 b=X2CaHu01C6x/2bWDznLUu1SpFPzd9ZeNGRvaAeegajs9trM1ZfYGBNeJeiR16mn2iH18oLlAK+308DRL7puQ5VEj+lubH7fZ5Gvj8WvSb42N6Zz+3/idp6eai1w3+lhDQTqapHZN22TGAj/fThviJ/nUd5Oz8vw8W7zhPIbn3LnxSipStdU+eS5JIQrjyavBcyg6jfq6pm9/zCIs4q+2HzT4j/gvYnBsbcL0Ux3mqPU7YWhfiRq/uGFXXOOs0EilZL7+RZfVWY9O8RvCw8hn9C9fqVp7nP25eb+szZquy/7ma+XHRCjz/gc2Ep0FKrbegzgNd38/f0REhVrYMg1HxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHG346M6BIcdzB3bq+gIvCZySB47kX4UwfX0Kz5ND6w=;
 b=aGOzAsP5Z78rljVXWREL7fnW8rblYQ46mbQOIKtrSUnaTtegYX1H4oFptShxlWFKCK1YuRg8BZQndo71IhsaBtQg5GDytOBv5GGB/+O54sh1jorjyNFYEYSXWGnqeIopHLppqlKf+yqUoCKBPX84GtjFXci+9sUP6z7GSGlIBV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PR1PR02MB4937.eurprd02.prod.outlook.com (2603:10a6:102:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 20:47:10 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 20:47:09 +0000
Message-ID: <a09a49a5-3d01-21f7-02ed-b191d70e7609@axentia.se>
Date:   Mon, 25 Apr 2022 22:47:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: sv
In-Reply-To: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/2] iio: dac: ti-dac5571: add support for ti,dac121c081
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::29) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 316c0a45-33ce-4d63-76c7-08da26fcc497
X-MS-TrafficTypeDiagnostic: PR1PR02MB4937:EE_
X-Microsoft-Antispam-PRVS: <PR1PR02MB4937D93FBCF50341DDB778F8BCF89@PR1PR02MB4937.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFBzAOGSJabL4npnFXWhQsbhu+r1kCJCMq1IVPVhens/mHpxBK0rZVBkoSwD3wQ+eE5sP+DPNUftLWQoGgedwRy0LvLabX6AT1JcC481zvkysxBOLuHsARRs2ShjWQT65jhbZPtPWkXG0sEX5cUNnEBNK553HBGBeIK9M8pHNXB+ydS+dKED+As5dBGL5X2gqHxiiuLtrQrPloPAud3wDzZoei0gkX/YG4tjtpU1KITkyxdcgsXdiJn3E/iOLvq1beWoUQWoBtizQ/VRR5++swh8cW+JKF9Vq5qgiPVjCOa3Tru0N2XIBGjrX5rNMvK8l+rZOpKtAeNh+99lmO/0aybWldkNw1HfJp53jDrwas7KekPcc4ffwEWoq0BJ5rWPcFd4ibMZ45k4hpqle1S+mt/M60kEXOBpT7zfztj+bKJJbo3rd9hZnvDbgwkZocAgL9qSkwLR1RdFvvqBnpiHpfwL5++SF6HTrP2ZvxCgfI0PI1EgxMogGktE3IRSfQIYY7J+X6mpznOlBz12POkiTT++YGBaPpz+vWy58CDbw3q67O0nnBgkIa4dd8imI4l6vTGHSEvQiMuLDipYyx3P4OCycN+3FnT6hAxF5V9bKRsJ89GRwLnDtF2IuXbHm+gXDp5mthkKwWPeF0NPKADrKDNydwczTzNYZL4j5ctjarEjXmVf7cVJpio9yVojNrdsdRBO9XYaFZjrsuKXX05gytUA5F2APcTYWrHd31YLcTd/UDgTFCjIqkWh/aS+yzQmAQCmQXTXyDp3Bivw0niw6bm88+L0TKfMH18B2XlywSjPaNFFxWdGJyZkPKYexsg2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(346002)(136003)(376002)(396003)(39840400004)(83380400001)(5660300002)(38100700002)(6512007)(6506007)(316002)(86362001)(26005)(54906003)(508600001)(966005)(6486002)(186003)(6916009)(2906002)(8936002)(2616005)(31696002)(4326008)(8676002)(66946007)(66556008)(66476007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzgxeXQ0dWNPall4VWZyeUYrUjlldEtVMmZ3SDNQeEF6MmlkN2NhZ3RFMVIx?=
 =?utf-8?B?NEttZ1dsR0NDUFplY1pEMzd6dHhOeVJadmxaSlREOVd6czNKQXVyTzVrVDVY?=
 =?utf-8?B?MlVMTmhabE4veVNvZlNrYVFyZ090WUtwQldJTEJiK096clRBcUo4cXFXbHU2?=
 =?utf-8?B?YjBrdGdoY1ZCOGJhTmIxVjM0RDdPVWxieFpheGVDd0t5bnY2cEpSaVg4dExy?=
 =?utf-8?B?MFpaVEJ0NHptdDBoeDd4N2QxeHUrbHpSeTJ5cVU1UEpSTVB6eTZvRUhyOFpl?=
 =?utf-8?B?VDRXUTNFbnF2MWJ4QWFxM3YvYmlMelBPcTBiS2U0dmtBdGQwRG5ucW5aUnc4?=
 =?utf-8?B?K0kzeExrRGlZazMvUC8yd3kybUNZQk9Cem1VOFVTVzQ0Ym9sL0lvUEYwamF3?=
 =?utf-8?B?SSsvdU9QRTVKcXNNUXRDQmV0a0pCSkU3djdpK0FpWWhiY1BnVS9xVXlGcVFT?=
 =?utf-8?B?REtlU3BGSU9SVzJCeVBITTZFR2xZaGsxYmpFWFJ3OXNZMkwwY3lkL2VVaENv?=
 =?utf-8?B?U0JjV21tbXMwY0VKQmRSU2hoTmFRd1liTlFaSm5VS0EyRW1ZL1RubGw0MDd0?=
 =?utf-8?B?eHUzZVVjbzN0dnNaRzBJK2hjbkhSNE9lSVRsek0veURsRFpDVkxtUTdyZFJR?=
 =?utf-8?B?TVg1endJa2FTS0tRRElqUG5SOXd0UnZWODRiSktOUnFuK2JIS1BNTHEySzVu?=
 =?utf-8?B?L21tOVBTR25nNjA2SnVGbnB3TE1pcWxZbVJkNEVUaG13Z2d1SDkvQ1BoTTBF?=
 =?utf-8?B?V0FBZWZQdzR0dmFSYjJRaFE4eDBSOFViUmcrYWxXMWk3eHRmbXdEc001QlN3?=
 =?utf-8?B?OEF2N3VvYmo0eXIvakJKN0xpZkNpYWp2MjZNN041OEFJSUtKOStSZFpGSHR1?=
 =?utf-8?B?bVZMYnpNVCt2OVlPallhaEF4OEpnTkQrUjY2TWVjOTV3ZGRSSEkrZVVaMk84?=
 =?utf-8?B?c3RhNDFCTk5XL2tQMlBPOFovb1RzUW9wU0V2TW05WDJvMkQyc2Y5TDNGMWk4?=
 =?utf-8?B?ekQ5elo3d1N0Z05pQllEMjgwYXM5eWdVRjJoSURYbTJnTDdSbVg5U1N0S3Iw?=
 =?utf-8?B?ZThzMzdnYW1OUDBkU2hucktHTHVuWkhEajdnMUNKYUFycHM3VTdHbGxqdHJF?=
 =?utf-8?B?YlU2eW5LWTJqeGxSWFUxNmRTUFAvSGRBbGtNaXNYZTdrMVFrdkpDby9LdVJO?=
 =?utf-8?B?eFoxcVBteXZKaTlPYnppNm9KQUUxdklHa29qaTFGaWlTazVPcG5MSUdiTHhH?=
 =?utf-8?B?ME5vdXB3K2IxUTZ3QjlFSCtEYk80M3djTUxSMitYTXJ0QXJFbnZDVjF4SnZD?=
 =?utf-8?B?RjQ5WWIyZjgzTnNNb0RNWWVDemw1cFBqT290V3JNRUJaK2tET1U2RmhGTmhC?=
 =?utf-8?B?SFd3VjZ3NnhsT3p6V3RVSGYvWEhyOHpoK3RYbDFaY20rRExaSVYzcU4yZWVk?=
 =?utf-8?B?Rm82cmVJMTIzRkdEcG1YeE42dnQ3SFlsa2wzeVRLRllxSjFyL21iZG9RenVV?=
 =?utf-8?B?R3M2Y1FWbGtObzZCLzhneE5oeGl4QnFUWU9LblJXWnlUYzZjSVlPV241dHdx?=
 =?utf-8?B?bmdUU1V1ZzVpSEJNemRWdjlhdWFEKzA2d0tOWjM3T3VwK0Z4STZBMFVnS0xx?=
 =?utf-8?B?WHdkUys4V0NTRkhUbmdmTG90QjlEcERQdE9JM0hyRXkyMlErMzRuNnFvSU5J?=
 =?utf-8?B?aWhUeHNMdzJ3VklLSXkydVRWVHRHNEpXaFJFY01yV1VhZ1BPc0x5RjUvbVlX?=
 =?utf-8?B?UEwzUHJOcncrS3FkZEQzaXdvQlE3OSszWmJlRzVObGRWUmNFZVhTeW0rblB3?=
 =?utf-8?B?SHlVT2hoOHBmQ0h6QXpTTmxHdm5VUXg1ZzFwMjdPbWtwTVFqQ2FkOVVqd3Ux?=
 =?utf-8?B?WlB0UjFmYkNISUpJY0N3bk9NZ0swZ1hRRE12TDAwMy8zNVJHTG44dytYdDdi?=
 =?utf-8?B?Rm93WUgvVjEwYmdsaGFrS2NXRWlHZnFjTEJOMzk1aU9QOWdzZWhlYTVoMzJN?=
 =?utf-8?B?dFhQRldYSE1jT2tMMlBCNEdBUGo2WGlnNjVScTMxOVl4WWxQZFZmOXIvVGkr?=
 =?utf-8?B?b0NjRVpkRG5hYWRLSFpMbWxzWUswNmRHMHZIY2g1elBtWmVvd05Ca0p2c05h?=
 =?utf-8?B?MXFIOC9aWjZyd3pTcHl1dDU4dXhJbisrY2c5eGxsZFBTMDRYMFZDZFFXVmNT?=
 =?utf-8?B?ZFdiQkVNc2drbnZKWHg1LzVSL2FTTW1ZNFZRZmRoVW4yMXA2cmVoRTlsK3Zp?=
 =?utf-8?B?djVZMFcrbUNSVkhQYWJQUzBGUTdndGJWU2ZEMnlVMktHMjh6elZ1ZE94UENJ?=
 =?utf-8?B?VTdPbWZpdC9laGVKWFlRbGptUEl6aU8ycjh6a3V5ckpXeW1kZGh6UT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 316c0a45-33ce-4d63-76c7-08da26fcc497
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:47:09.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlmRmCY85ELnNjrq9YTiCWJj8CbLln7lPcWZBGdmQo8zz//SUupM6vkCP20G34mm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fits right in as a single 12-bit DAC.

Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/dac/Kconfig      | 2 +-
 drivers/iio/dac/ti-dac5571.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index c0bf0d84197f..d6248b188645 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -417,7 +417,7 @@ config TI_DAC5571
 	help
 	  Driver for the Texas Instruments
 	  DAC5571, DAC6571, DAC7571, DAC5574, DAC6574, DAC7574, DAC5573,
-	  DAC6573, DAC7573, DAC8571, DAC8574.
+	  DAC6573, DAC7573, DAC8571, DAC8574, DAC121C081.
 
 	  If compiled as a module, it will be called ti-dac5571.
 
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 4a3b8d875518..ce542bd8b69e 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -13,6 +13,7 @@
  * https://www.ti.com/lit/ds/symlink/dac5573.pdf
  * https://www.ti.com/lit/ds/symlink/dac6573.pdf
  * https://www.ti.com/lit/ds/symlink/dac7573.pdf
+ * https://www.ti.com/lit/ds/symlink/dac121c081.pdf
  */
 
 #include <linux/iio/iio.h>
@@ -394,6 +395,7 @@ static const struct of_device_id dac5571_of_id[] = {
 	{.compatible = "ti,dac5573"},
 	{.compatible = "ti,dac6573"},
 	{.compatible = "ti,dac7573"},
+	{.compatible = "ti,dac121c081"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, dac5571_of_id);
@@ -408,6 +410,7 @@ static const struct i2c_device_id dac5571_id[] = {
 	{"dac5573", quad_8bit},
 	{"dac6573", quad_10bit},
 	{"dac7573", quad_12bit},
+	{"dac121c081", single_12bit},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, dac5571_id);
-- 
2.20.1

