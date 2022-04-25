Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D350D915
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiDYGCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbiDYGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:02:20 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10099.outbound.protection.outlook.com [40.107.1.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE03916E;
        Sun, 24 Apr 2022 22:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiuWCk5TJwwA9KcbCHR+NCa553YGsAf623+hv3krgTWAvs/vlXBlfbUypheMFqxFtzu5fMxfQ4AGd95dPginnbtQCbwyblCxUpt7n21yb5EzIiSjJoxB4rSIM7HMHhpLC45Jp9ZlqOmCDpR+6+e66DbvspXKJTltMfXdRXxnwcj4s8IcKw1JONXvtMRJQhkgbr9la9hS8+OiAqfeSwc4IrHqFi4lsYNuWEanmm0PE9wHmavv8RPy7RSNcvQjC6sBR6KbTHfAPlk6y5fpGJyCc/OBvT1y21ScY2urJA1fDiY/jIC0IiEIRTksrwZKcalbUBUuj0TG6wrNWT5o0vaRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2dNgtOadiYM4cu3Xxe/ycKGIHQtX48G5nBtFRcM1u8=;
 b=ladDeM07v5GBhg2bRYIfcUkxR7UVsATawyJi+dE/56Eb5HVnJSxgnWi1VHicQdGoAqbU5yNSjgI4u++LgnSZ5xhkjq5HNe+fA6vAqF+N0qlhtjo2ZttU9nCqjm3pVOpcRMDO+I+JOskCAzpkxIdaUW+QH57LZpOQyeXmpCTnYisX3a4pJFxejuMbf7Chky6BwHhxn+Xt4Dp6ijGgliRzEkB4e3gXGvOMggrzja61HO5J51L/nrfBCmA1ehto1GZG98OwVSnOeVDuVjq+yZKC2BBB6/uagvSRYqTnM1USso/AaaXXQ+jmDvAAuvAGwYbH2hXkct/L3lw4GFy6t4KbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2dNgtOadiYM4cu3Xxe/ycKGIHQtX48G5nBtFRcM1u8=;
 b=foa7Q1ACu/kzDKMlsXb/btPJGcjgGN+dMv9Dd9tdvzmic77kITfSLMc5k1Z8Qp9WlZVzhiFP5NFCNUeCwkCY4CVubJTTHwmxgF6g1JkKaZ+odpqerY9ygefKg5bhDLBKeWkvidCHZIv9ibZycAUhZM4oPJac/XYySVPfDRKwsZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB7PR02MB3724.eurprd02.prod.outlook.com (2603:10a6:5:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.21; Mon, 25 Apr 2022 05:59:14 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 05:59:14 +0000
Message-ID: <abe35ea9-1929-941a-6391-2ce1bc047161@axentia.se>
Date:   Mon, 25 Apr 2022 07:59:12 +0200
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
Subject: [PATCH 1/2] dt-bindings: hwmon: Add Atmel AT30TS74
In-Reply-To: <e4c15f1c-b2a3-4371-d2de-8205d3dfe972@axentia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0035.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::9)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e413d7e0-de00-41b5-5816-08da2680b9cb
X-MS-TrafficTypeDiagnostic: DB7PR02MB3724:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB37244BE34601E62129594584BCF89@DB7PR02MB3724.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aKbmSkKAY9b9tFxj7M7wk6aPlCSLPw5yp8ZB01CLUaF4KntIagb9+Tsw3grk7s51DEsFJNTJgxp2qPoJKX93G2H+yVWoBtA0cctgkVYKdyrLtxnDQL2jvlIn3phSMTJhFbUxWUNzEJbaiARz12OQRRVMzl59KIg4DI2S93CqAFNyUlU7lwRjOaSqeWAwAw82kGsnPVtyQec/TN72ukrOUps3GKG3E38rZpYCu4WHQC7ZrC/5YgmtCmGMDNm8VdeY7uMlEJfNCh2gh86QoXBO/VpxteHNGWMzNRKu1DZFVDol5+mQLos6cWXKVFQt7S8/9pPuaXsZ4konNYWs/z5wspDZBx8pQNyZyhN7ytzKtgTxGdyQ4Rv16qHcWhGagHa7jvFbsBPlgvR4zxsFjY1eJFZnXZSFlkhts32rtYBcGHF9XvYotU4VtgjcbMUYvas5zHXmgQJ3TNGMaF1mD3eMkZ/YYP/OiTfowGC8PSpxQhvzmZImlhyw5cn4e6O2QKgQ7Ur1Vy754RJWtbL83V+KLpXbttTVjgVagLMldvt2Vp3lW/yeM2NdkBsPGmOAT3GdEFWOWgVZI3w509Y0be8LFs/7pYlty+V9hw/P36+EtTQTBjyTR8CAxMCSuC1COmbmV+O2etRGWA6McMjj9yUSMAu4la995IFT6GXgFytq9nE5+UcoibXVYj5owMxMeonSEeOcGjU/EcfW83N/+dWFxhVvnPbdIxbR0YzxhyzWqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39830400003)(396003)(366004)(346002)(136003)(86362001)(508600001)(8676002)(2616005)(66476007)(66556008)(26005)(4326008)(38100700002)(316002)(6486002)(6512007)(6916009)(54906003)(66946007)(6506007)(5660300002)(31696002)(8936002)(36756003)(31686004)(4744005)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJwMUR2V1JvdDRESENLeSt1NytGNVk1RmlsWmRibVA3OWxXWVF2YllpVzF5?=
 =?utf-8?B?RSsrV3hkejgyNXkrMEZ1YjByMFUxK0ZiY050NWxPNG41Tjl4YXJ0QnRHOVZN?=
 =?utf-8?B?NUhYbHluQlp2N1VydjF5R1g1TEVXQmEwcUNTLzVsRVgyMVJ2SGY5L3ZGSjdE?=
 =?utf-8?B?anpYK2Z3bVlBb2lYcFc1U0hnbFFZeCtYalZpaHJGbmxtMVMwL1R0TjN0eTE0?=
 =?utf-8?B?S1NWZFF4cHJEMjFxb0VkakJ1L3loNDAxbWt5YmZ4S2hLR3g5b2NRRG5SYnVr?=
 =?utf-8?B?NGNMTTIwUjNJdXkvcGt1Ni9QN2hTQU90ckloOGpLY2pHNm53TWtsRktxOGlp?=
 =?utf-8?B?Ny9LaGRZRUQwQjErS0JIQUJVU3VYYUZTRW1HMW44a0dKUmt3TSt0REFRQ1c4?=
 =?utf-8?B?TE00VDY4M0tyQXE1VVNNTHM5WjlrcmUxdG5FYTFNNXFXbFdvVklaNlZPemhK?=
 =?utf-8?B?SnRLWFd6cmMxaVpzbi9EZ0VHODVpRWJMNmI4V0RNTG4zZm56SjFXOFpMcFNx?=
 =?utf-8?B?RzkrTzZ0RDBWQU9PVjlMdjA1U0QrK0NYUS9GYmRIQnBVdXZER1Q1MVg1Rkpv?=
 =?utf-8?B?T3Rja1VmOGZ1amNKUFJJU2ltNFJ1ZHBxdzZtWVV0TDViMVRobWNNNzltNngy?=
 =?utf-8?B?Z0RsYXFDSlBrZ1cwbDNVSjExTUlldm1RbERuWnZUcGEyNHdrMmIxM0NVRXlR?=
 =?utf-8?B?WUI5bXNyM0VGcS9nV3UweW9GS21xTklaZkg2cmVmZ05wRTdFeEJRSmhVVU9l?=
 =?utf-8?B?QnZCblUybHIySlIxN0xpZDJsS3ZOaldsVldWV2dLL2xDRWRQSUp6cXI1Vmlw?=
 =?utf-8?B?ZjA4Z3REV0kvbktBRU9ESGw2NDJNeENqeXRhMHVvRm5jajJZZS96YnJEMWZ1?=
 =?utf-8?B?aDBLQVZnbEFIU3JlMEFtbHlCbDVUVitMb1BEOHk3WktQMXhEZGppWXNKbzlv?=
 =?utf-8?B?ZTRIVldPOEFVV1h6SkRtUXgzeEczT0RZRjh6Z01jNUxETU92eFVjaGhna0sz?=
 =?utf-8?B?ZG5nWkJxaU1Pb29pd0ZyT0ZaT0hVK3RMWEhuYjd4Q1daYU41SmZEQTRkbVhp?=
 =?utf-8?B?WGIwNGtqNkZpekpkRmxDeWNmYmdGNzBJQ2hQVHRhVlBZRjJ1UHJkcXpnWENu?=
 =?utf-8?B?ckw0eEd3T1lCUEtiNGtrT2JGaCtNTkNhMjFBTC9BOXk3Z1JtTkdIdnlJVWJw?=
 =?utf-8?B?ZlFZc2dkYTdkMERqK3dnUnVjUjlSYUQyendSNUtuNnUzVExrN0ttQ0NIOGo1?=
 =?utf-8?B?cDU0UEZCNnhQTDlpZlFOY3MxUVhKR0x3QkMydCtXTG9GU1NBQVdmclRNS2NL?=
 =?utf-8?B?WkN6WWc2eUg0UUxCUFJnRjVib3hhdUhUamF6R21XYmJRMmNnMTlHTkkvd05n?=
 =?utf-8?B?SW03NDBSNHRBYXZkTGovSXJUekZGcXNzNGFndDkrN3k0ZEZNZEFoRmZnL3p1?=
 =?utf-8?B?MXlIYTNRNlVtWFVQUHBwcS9ETFN5RzVvaGJudkRBeWN3dVJ3L1RhOVFTellF?=
 =?utf-8?B?dExEMDllaGZoKzhwQ3dvUUxiNUlhMGZHWlBsMXlqSEJIZGhSUjBpQ0wySzJJ?=
 =?utf-8?B?c1NSZ09FbUFDZFFqVHNubFhhSGloTStJb0tYTVNrL0RjSGc4U01GNDJydTBm?=
 =?utf-8?B?OW56QlJzdXRDVDYwbFV3a2JCcFpkeitqdjZtTzJmRjJtQlhqTVE4cXlwWTFs?=
 =?utf-8?B?eDlEdTByOURhNmRVamJFSkFwaVdnSUJmOGJGanVGYklNMG1aVWc5WkJiUHJM?=
 =?utf-8?B?VVhnNU5sMytEZ0RoSHl4U2YvYmk4K1ovVDNocVJ6ZHRlNVRseTQwd0FtdFht?=
 =?utf-8?B?MUNiUG85SE9xa1ZXQzRMSjlMSUNPQk9jbXNKaXNqY2hnTUwxMHRoZ0J2NStG?=
 =?utf-8?B?STJvZkxhUk1HTm82bnA1Nnd1Y3BMVWExL2RVTCt1MHNMYS9IampyWkwrM21Y?=
 =?utf-8?B?RlFvbTJNV0R2QVpTQTZFOEF5ZWxqQ1dVWWttVEFML1FCdHk5d2ljOEh2QWx1?=
 =?utf-8?B?Q0tIVUhQSEY4K2VMNlo0L044YjVDQklSWnNXRzRXQlhaVzVRU1A3UnZhVHoz?=
 =?utf-8?B?RGxaemNZVGVhbjE2NU8zSFFRemV0RjBUNWhDYXJMcHRoMDBES2NydmVVaHEx?=
 =?utf-8?B?UDlIdXVmaXFCOUxtWXFlVTFhNTFSU21KT1ZlaHBkaVZBRHNaUVl5RFMxYm5m?=
 =?utf-8?B?clFpdEJJbHorbXg0WUhjZDJwdnF2YjJrMWVQUGRmTHZnSklTak8zWGVXdzBS?=
 =?utf-8?B?MGcwNkhVWjM1cGgwby8zU25EaXhOOGt0Qzl2M2NxYUFnTzZEMWpXY1VwamNT?=
 =?utf-8?B?SGZsbmF5eUdjKzFLRXpxbUQvTkh6RWVWNHFPZkl2OE1jQjU2S2xxQT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e413d7e0-de00-41b5-5816-08da2680b9cb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 05:59:14.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0+HVS0Ae8GSro1qlF2NBpvxdoIPMjKoA2CwrcdzB7BmHnn/bYPgKT8EvxBEuAhe
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

Document the Atmel (now Microchip) AT30TS74 which is an LM75 based
temperature sensor.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
  Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
  1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index 72980d083c21..8226e3b5d028 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -14,6 +14,7 @@ properties:
    compatible:
      enum:
        - adi,adt75
+      - atmel,at30ts74
        - dallas,ds1775
        - dallas,ds75
        - dallas,ds7505
-- 
2.20.1

