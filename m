Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6850D90C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiDYGCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDYGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:01:57 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10124.outbound.protection.outlook.com [40.107.1.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B6C3915B;
        Sun, 24 Apr 2022 22:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCJozGHwLxaLhwmmlaXboLCVPae6PBaf2yrF44N9En2AKi1IC42CupQIQi68jn51O5YQvo6W04Ir7hXv/QZSSUWYn2B/3tuEnL33esbe/Wq7VC55yfYoqmx7uare4TYOZaR6y852H2OBXBMRqUd3vrEThUmj9k+3gbLkdrF6tCXo0zkI6x8IU9FHRxGMQ5tFof+dFJrZ/oNZVaW3LpIeFJOCVPBj8KKWXvi4TQIYlPLg1JtwNS8S47h7EnMEJd/xlvUBGRdE0sJZPSLEP78/X79SQYmkcPfymoobc8DzO9WJA0UVtWlrKfZznFqpTSSDbp2gObZI0lnFRva6Xu1MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KPyPmhB5aBqZg54CTuI5fIov4H/L6CIXrxLkIHuWWs=;
 b=VOAwXdvpd5rjov46MEcFv5+A/uTQAFTpudxLBCIsSKdlIYIT4M5b/SS7WqgDs6xwK51EfnI7Ah5dooLoxZY/uBpwaDwJMhQSk8smQDeWnJ3EMX7ej/tcVVKU+btYTIwmK4XzMwJSy2XLx3klKV7H9CLJrZLrvnuXGkz51TS4tql19iDV7Rcde4WTjNv7Gg5TGDPSLu/ngMaKZdlxERK1HiqHXFFreqCq7MwPecNMETUn+uYbkc6uPTHaSvpw7CFj3a/IMMxrl2Z+BKsSK773HQSVFZyNs2XgTAAPK/+v2eWt11Voh90Y/4aQkk9oGcDfHpuEzsq4nMfWo1h931BtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KPyPmhB5aBqZg54CTuI5fIov4H/L6CIXrxLkIHuWWs=;
 b=gxhlssBUEkQcRoiKo94t1ACGuy2nZEjo302Cs7xMxMwKGyepXToU/KA1ks2JgGvNq0sPQRnfah5TGz/JFb3uaBV1u0IwuVJSOD+ZeE2i1g+gQxIrJGHLhi8lN/T71jvX0MhOxqhhgj7Kk/2g/+oxxXylMUIiTsqVA5n+pVfv/y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB7PR02MB3724.eurprd02.prod.outlook.com (2603:10a6:5:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.21; Mon, 25 Apr 2022 05:58:51 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 05:58:51 +0000
Message-ID: <e4c15f1c-b2a3-4371-d2de-8205d3dfe972@axentia.se>
Date:   Mon, 25 Apr 2022 07:58:49 +0200
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
Subject: [PATCH 0/2] Add support for Atmel AT30TS74
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::23) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34278c18-f7bc-49f9-4162-08da2680abf2
X-MS-TrafficTypeDiagnostic: DB7PR02MB3724:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB372454986924D1E975A116CCBCF89@DB7PR02MB3724.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3x2KNFwPftpiWSTPoTjyIMGW7LIdhHozv7HcMMnSawLPUDwTc/1sPmiEvWpVd7QTosjHRqtotp5/layogbYCi6vBgWaeZgyeX33JeC8kqhpIHy+DoH0Sxqg7M/stwGQsVyJO84Vsv3p7phvBOAC8PrWA6s/OqksmIE9cQ8N0AHcOxea8sMmmd1u49SjKqU0e4XecyQzkANK3rgpky5+kCXYg0TaJ9/6HjNyjb1VrLRVfLgnFgaf/T238VkIEtZxdF+obc9pqXXVOoD+Ki6NNuaiTnQro4gIz0qrZ8R691wmH6XH3CTtocVxTM+TkDGZutNOZTfVjwu+k1vh2Lpj4G0umveMlQGr+TmZBYp5kRHPI2liZEUF2beYcLb74Qm/4YZWL5xbNScDCYt7hPqzwSSHj9qUmgoTUZU/uHG+EZpvg7kiNyx1H6iZcS9rdZhpQoTF9XDICGeIFUzp+S6iBaxMgwilWQYKTZhocdRQKWqTCOe/pRnfCD3l30f2bPXycheZl51M8vhPZnczp29q3BVU/saR6sfS4i80M9uYYjNky4g/SWHUK4BQxAdA+W338NRFFuNHSwn7MXhpet5WgPc1S7VtUTG2fsVYYPhYuw5j6KPuvGubtzDbn5ugkk1rH6+Ya8Ve8WnTrMbh2VFAaIWVr1H/14Qwio8PwIgGaVLe1I3tBu5Z1tjt2mj3Mdnt12NSP1KasWkzvS15OCzbEr8GPxrCBMmRGpZ846kgzL10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39830400003)(396003)(366004)(346002)(136003)(86362001)(508600001)(8676002)(2616005)(66476007)(66556008)(26005)(4326008)(38100700002)(316002)(6486002)(6512007)(6916009)(54906003)(66946007)(6506007)(5660300002)(31696002)(8936002)(36756003)(31686004)(4744005)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGVpRzNLQ0x3cHBnazhsenYwbHBuSmhTWjJZZnVaK1pFd3lUOERVbDVocC9B?=
 =?utf-8?B?VVgrSHBzL1pKTWN6ZFpaSmIzSFkrcFhaUDBteTA1TGt2UCtQV2crVVE0UjZD?=
 =?utf-8?B?MmJ6bUJFbFZxU3lrRzZZL0dxdm1qS1M4WE1Ta2FJbTJkZW50ZFdPYTQyajVJ?=
 =?utf-8?B?d3VyNlhPU0hVVnI0R0R2cHMwSlU3UmNLVnhpaExjZHdiOGY1Y1ZhL2pHcHY0?=
 =?utf-8?B?NWlNU2JaWTVXS0JILy9VazlhWXZsUjFBV2RCY3ZKQ0JXQ0NvYXN1N0kwK2Fq?=
 =?utf-8?B?Z0lUTTlCbXdNekNsblk4QVIrUXdvWmRhRVlsRTNic3J1aVRZSzA5dks1ZHQ3?=
 =?utf-8?B?QjAzKzZzdXBHRitpU2dsRHV3dmE5V3JrTEl4c01iRFdVMlBydDZ4amVoK2hl?=
 =?utf-8?B?V1Rpb08wbmM1MTBZR0hJSEM0dnFHSlBUaCtlUFVtdnNjd0dIdUtzQlFKaEpo?=
 =?utf-8?B?VHd6UHQ5YnZCanhtY3lPMERMcG1hOFRqb011S1lnM2M3a3lPVjdDRkpZYkIz?=
 =?utf-8?B?RDZlTWdOMUZCZU9FWjc0elpFL1hta0w1S1A0M25RczZBZG1Ta3ZiYll4a0dB?=
 =?utf-8?B?WkFyaGsyRFVuU0hqUFlndVZaVUxQVVNZekc1SHVTb2x3NGt5UFMrbGxRMDZi?=
 =?utf-8?B?eFZvN3gwUEJTdTViV1ZqRVpnalRDUWlhd2VVcUw1M1dYd0UzcDEzZEpQNmdh?=
 =?utf-8?B?cEl6TlhpbHRYWHY4WVREekFHZitYTUZwaW45MDhCZDFMSzdEZFNoenFNbm9C?=
 =?utf-8?B?eGV3ZjZZaEdIZlZsVHUvSitTWXJEbHBwajkxM2dQYzRvdVZrN1crV1RqTkZT?=
 =?utf-8?B?WkVkSkdkYlN4TTY2d2lZa0RUVjQ5dGMzQ1R0NzBOUXdmL2Y3S0JxY0FpbEpz?=
 =?utf-8?B?TkNMYkRZdkwxK2FzQU5WNWptQzJGZlFGbDhSUnd3Qm1aWGNsK3MxV1BnNFEw?=
 =?utf-8?B?WmQrRDVIRGZNMXYxV1dpTDZSQ3ZwNW1jRnV6OEtSQ0ZXRXRzRzdZcllONzg2?=
 =?utf-8?B?K3VkN1c3bEFHcHYrUTFmUDUvS1pWUkRzY3ZqdnlKSjYzWWNZS0ZJOWx0clFY?=
 =?utf-8?B?Z1dldUVDUlJleW1jMFJRa085WllLYzM0VEV1eC9xbjRMbm5aNDlZZXUwRWZM?=
 =?utf-8?B?clpyRkdqUUR4WlJpUTJ6TXRRYWZqUkZGZDF2MjIxZ0xlYWZ0cEF3Nzhpa2dy?=
 =?utf-8?B?d3JnbStlS2ljS3lzOUZab3NGZDdNOGpYdkJKbURwYXVJa3BCS1NLT2RXb2Vu?=
 =?utf-8?B?RHBnbGJ1NEFoWHoxM3ZUSzlTNWNnVDg1TWtWS1VsSVZLNWczUjlZdDJ1M05J?=
 =?utf-8?B?aG5sTXd6L0lsV2o3SExsdlNZWWd4dkxLVUxEVlJHNUJUVXpDUXNnR3dRci9t?=
 =?utf-8?B?QlpNM1d0eWZacW5uQ3hxeG1ZaVNxNFVoZVVvUG96ZU1JTVlsdk1uWld5YS9p?=
 =?utf-8?B?NGhrR1NabDN6NFhtR0NCY2E3VGZiWlo2eVZsZmYwZytOamF5clg5aDZYV1JT?=
 =?utf-8?B?VFhQRkZKZmJ2NVg2Y1NwUkNHRW5MZzBtY28zZ0pGOG1xcUdFZTFVTk9hYitJ?=
 =?utf-8?B?cFA3bjFpQ0tPSVIyL2NsNlROUFNvalJEbWtkS2hnNmFLY3luNzFTS3ZwN3Ur?=
 =?utf-8?B?Z2hOVnMyM3lUOW1SMGV2QUVBUHNLaW1Mc251Vmw1VDIvQXdFVTk5NE43UEhs?=
 =?utf-8?B?MWFXMkNIVW9vVG0rWTFJRitLajB0SFd6SmVsWC9LVURtNG5wdFUwOEpEU2pZ?=
 =?utf-8?B?TXJjcllDcHRkcDh4eTRibUVJU3pKRGxGdWIvdVk4c0Nrb2lnM3Z0cXVBUkhR?=
 =?utf-8?B?OXR2R21OVkVVZnBCWk9WYzBqbExzYXluelZsdGNybCtXVFFqNFk0WkhFMGhp?=
 =?utf-8?B?aWYvNExEVU5WcFhNeklhbS9XMDFDZjVRd1E4Sm5ZL1pDLzdnbWtaRm5Fdmx5?=
 =?utf-8?B?RWM5UFB1WnhmVlR5Vjg0NTVRRmFiZU4vQzdRTXd5dWxxWU9wM3kvenlQcDh1?=
 =?utf-8?B?aW1ZanphTk9qT0JkV3dWMGdPeHNVbnkwcFlXMDU0Vi9DSjcySHRhTUhWYnEy?=
 =?utf-8?B?emlWR3N6L2hmeDJ6eFYwek5IdDZMS0JYd0lDaXp4RUlZbDM4bVZPRlZ1eWwy?=
 =?utf-8?B?WHhLcTAxM3NXMWpUZjNLK1NscDg4MytDU3JVT3BVNmdjT1RFVyt6RU1UL0JQ?=
 =?utf-8?B?WFp6OVltZG8wVkllSUMwWm5jRitjNjN6bCthNHZDdFhtcHJnbDYrOGJFRUJ1?=
 =?utf-8?B?NUlmQ0VVcHk1cjFJNGt2Z25PSkdKMXZLVktERzF5TS9xTGhwSWppUmNZU3Jh?=
 =?utf-8?B?QU9nejEycGMybjQ0dFlETC94M2dmbWQyaktJbENrVmwvNENqWm9ldz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 34278c18-f7bc-49f9-4162-08da2680abf2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 05:58:51.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3v1oiwlMDFv3BnAz15ybOyUFcBxwzavZZSRoEJqvQ0SYhMxrmZeJfygLpIHtgPYw
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

Hi!

Yet another LM75 temperature sensor. Add it to the list of
supported chips.

Cheers,
Peter

Peter Rosin (2):
   dt-bindings: hwmon: Add Atmel AT30TS74
   hwmon: (lm75) Add Atmel AT30TS74 support

  Documentation/devicetree/bindings/hwmon/lm75.yaml |  1 +
  drivers/hwmon/Kconfig                             |  1 +
  drivers/hwmon/lm75.c                              | 14 ++++++++++++++
  3 files changed, 16 insertions(+)

-- 
2.20.1

