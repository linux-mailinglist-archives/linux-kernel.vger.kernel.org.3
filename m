Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DFC4CD459
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiCDMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCDMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:39:26 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2121.outbound.protection.outlook.com [40.107.22.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB112BF959
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:38:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9ou4bJCgkC1ioq2U7mic2eKf7/snxTPHtRed+U2D51luSUn5DW2m7mHVFzfYEDqIIemNYPOxbjn9LvzHcJxxc/+t4dzFiNRQZKwoEnCLbQow3WcuaJf7i9DWuLU6+9lHdjcOkB4Hf5WY/uuFFDk1RWhN10mgHXb2RWO/g+ee51poIkC/Kf8WqA2Tjyfl/anFMUxWgw6qudxtfaPHYt2Do96w4CWbd87cSyow/H3stel030ivhTIjtMU/ZRLfP7NdC049cx1quqpTm5+C+5WAG+d2pmPTRrOX5V2zaH7OYkgk058jwWjQ2LVGGqEuJDg6Lx+O2AIRz1aWHP+JZyGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djLTQhF8WjRFZdCwTB43wbPmLPIGLZ0W+tH0XVllpxI=;
 b=ZvNQptCHIFDS1z5OdT2NVrFc/JkbnlyWR/wCFZvXLCcwTKGMd5FrwjSfXZvBWyahQjJWu1yPhe/seKiYYgiiTUG6+idQ4Rph1g1IglIo9IIpOvvISru8VCUELppgwKu+1GY7w4I/mwgDvKwhX1R7orlyoJXVMJYShBGybI4EAncNBX7pqCbwqTRP6kq3/Akl1DhruH/IUjKPRK2zmdGDC9m6HCihZfWA7T2d6W2cj37/XiDpraBqYcjHpGYIxbfZRdUg2lvzQCv2I1LIHpDWFT1ZoBqMXpC3PDUIa0HKwSZF0fSyC9Q370bcoMojXH+uUoGqiP+aFJQGOEIw5A6I+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djLTQhF8WjRFZdCwTB43wbPmLPIGLZ0W+tH0XVllpxI=;
 b=ZB1Z+l6TcDt8g/q4hB0J2J5Aij0n8VUDbNYaSLo7fbOJVTawq+XkdWecO54XbTmk7fR2fLZWqCCcrsC/21XpRsoT/HkjR06Avmw2noAy2ZV2/2STSSXZhKPZm4K0JKlSMIak57RJu0gNjGrFJw0gJiMLD4eGqWV2fLIwJWIEdF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by VI1PR02MB3950.eurprd02.prod.outlook.com (2603:10a6:803:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 12:38:31 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::2c21:5ed9:a7e6:6cdf]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::2c21:5ed9:a7e6:6cdf%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 12:38:31 +0000
Message-ID: <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
Date:   Fri, 4 Mar 2022 13:38:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: sv-SE
To:     Tudor.Ambarus@microchip.com, saravanak@google.com
Cc:     alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, du@axentia.se,
        Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, Nicolas.Ferre@microchip.com
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0023.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::24) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a7b695-0b98-4548-a574-08d9fddbe3ea
X-MS-TrafficTypeDiagnostic: VI1PR02MB3950:EE_
X-Microsoft-Antispam-PRVS: <VI1PR02MB3950E1C571609F6FE7E0AE90BC059@VI1PR02MB3950.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6ysS9l9vCF67l+XZ8lxanNffLnVmOySAZKW2pVazhb90MuUnF1amA6F3QFKyeGbRCeEn81zAcSXfBal0i51eQR7tGKY79TPJ33rGf7DrM07IMZXAEA3gibpj04K5hwq2LdME5yQUNctIezurul6rWmtAHqRP+PthXLgzwLNLSsylexNzYmxCImyiLIU4vSk0brz03KKxiUcRX1H8dNjHlKQ/eGVGzZqWkvTQKWXmOaX81bBnd+xYdlQin0ugy0eIIFQ9kqA0WYumFqejdC1w3qoDesJE9rniIRdflceytYRiATK1zLwyD/y+EFfhDjJ558SX1HM+kgDbj2yvHWkk8MTP1g7+O+7GcIp4htJUcpZQPT/hMKPMNyaqbFEv1atQeimbx6CbKZOXVUOgF35ai5DNwK49lyS/MktymyX/KTCPWU3vq8rWgRzNO9eRnzoeUdjo9snnrdB/AQax1yV/g5rsRrF//4SP/2hGhecYM2PDVJ+bnDaWxhaiXDrWZIWYAGHTbez6Z1kUo4DZ01LBC2+bS+nIcJ9LElrxug3xgMRDr5liSA4E6yQW0QfVt+WXVvxNZHfF+CqUhmnGhwGanFH/jU/OyXDBToT53oTxFgXf7j2bAusfXsvJqTJ3NLqt7p55PbHlf23R58ivZqtZ7znwp1dRAPv9ic6C0aXJ5P2J03VZqgvP+fOrhsrDvHaXEZ78j8Fv4eASAR0oW+EFLd8tEOoOYl02g/5dbMtXewV+cN9OnwewQGGf3HHe4frp4uNDoD1f1x15jyZvAKygyCGE80LUULXzG1NIRcDEVqbwSbZAMPXOBjRT+JowJO3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(136003)(396003)(346002)(376002)(966005)(6486002)(2906002)(26005)(186003)(31696002)(508600001)(316002)(8936002)(6506007)(6512007)(2616005)(6666004)(31686004)(5660300002)(86362001)(38100700002)(66476007)(8676002)(4326008)(66556008)(66946007)(83380400001)(36916002)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFXdUpMekYyaGw2MTVWOEFaYmpTZWx3V2prVHN5S3dCWUhPVDlFM3lscVUr?=
 =?utf-8?B?b3doZkUzNk4vRTlzN1J0dmZ2OUExZjFBTlFZMHk3SHBNTXZ6MTZEeVdvOEdk?=
 =?utf-8?B?YVAvTFNpZEZlbTM1NFJjcUJVNm9TdkRYWFRUWU94M0thYVBvSTV4SWtvcHZC?=
 =?utf-8?B?Z0xYa3hFeFB2elpHUFgrSG43eml6ai9yeVB0cFY2RGQ1cXlXRUxhTnVEUGlB?=
 =?utf-8?B?cTkyVkk4L3g2WkVOSnJoeWdVN1h5dVp4Y01wdXU4ZXVVOTlZRTFKN1REVXFz?=
 =?utf-8?B?UXhtUVVCZ1hyYStEeVN2aW84Vk1mTDE1UmEvZ0hFOHNLdW1NSWx4cldsM1Zw?=
 =?utf-8?B?RWlaR25KcTMydlowS1ZPNVFJc1ZNMTZYZW1LSkNGMnlVZ1lJeUppRCtCOGNz?=
 =?utf-8?B?R0ZXamdOakZ1akpLS3BMYWoveDRTL09oVkpNZndTemROUjdBQkNyWHFzdmlO?=
 =?utf-8?B?VUxnaEdaR3oraVV0cnVxNjdqVTZSaHE5OFlYS3NlZitBQTZ3NnBJaWJuSlR0?=
 =?utf-8?B?QS9tWExlUWluZUxhY1dwZEdZZk83UHVERTdZY3E4ZnNDeFV2bHFvQzJPbTly?=
 =?utf-8?B?L1hCc2ZLcVFQQjRuWVpicVI1WDBKc0JqZUtqWU9JbDlKZnB4VTlYcDRiaTNp?=
 =?utf-8?B?M3NwT2M2bXJJVFVhL3N1M0tDazBZeHA1VjQyZnBGOEtWYVBLN1NZSkhLZFRK?=
 =?utf-8?B?NjlUL2lCVzBRbGtPcmUxR3RLMlU1Z3VDZnpmTElXanVxdGhhVGNqMzhnNklR?=
 =?utf-8?B?OWVBYVRYUy9XQUI4RytSQVV0bzZNTEdZVnM3MWxEdHhtRzdZK0NNSkNzdWVN?=
 =?utf-8?B?L0dxblFuMWo2MHJzdUphekJqSTdNSWQ4dWlHN295TDJ5czlUd0NRQXJkalN0?=
 =?utf-8?B?N0dYeTVwWW45L2RCc1haUXkvb3diM0taNWw3NHhlMVdDOFFkWXBDWHh4Z1Y5?=
 =?utf-8?B?YmZJS2tabXJCMjJzNkdzczV0YjRqeVZVYnoxOWJRVDVVZGJ4OEQyN25xMVFY?=
 =?utf-8?B?MlBlZjFVb3BoT1oyellIakNRU2hwME1uTGcvVUtXYUFyd1pidHdxNEU5cTA0?=
 =?utf-8?B?S1k1UEpTc0REbmhZVWJVS3FDM0dlRjJWODZwUFZYRHN6cnhUdGUxcVdrdzM1?=
 =?utf-8?B?Y1MwS3ZPRGxaZEo4ZG1FcnBuTXJCelRCK2hvVUw1T2x2WXhOVE05Q0ExR1g4?=
 =?utf-8?B?MFMxRDhSNXBUNjNmVjd4L3dOc3hqdWJjZFZ0Q205N1dXZ0RYSStrMGRuZWUv?=
 =?utf-8?B?UGFUbmxTZ0xuZjllelNUM3FDZWhZMzNHcHNKTDR6ZHc4ZitHQXk2M0RVT3pR?=
 =?utf-8?B?Q0FlQlV1am56MG0vSERibkYzMERVTEIwMVRRR3J4dVNRYTZBNyt1aUQ3MldB?=
 =?utf-8?B?TUZqMS9SQlNlWTN4ZDFqM2ZLOTF5VmtMSVhYUzdUWEZtWDBwaEdYSzEyb2dB?=
 =?utf-8?B?UXNvN090UmRkOXNDYStWR0RUZEFVNmRNc1hDT00zQWFDcG9CU2ZacEhPb2Vp?=
 =?utf-8?B?M2Y1aHpHWkxiV2RSS0RYVUs3U2dod2E0NXNUNUtvOStVNFhrdVFnaWlGdG9S?=
 =?utf-8?B?V2g2ZGt1Q1p6WW1jUGlBZmxHQ1NpN081MGYzeVdOaVF0Y2ZkaG5sa3ZyZ1ph?=
 =?utf-8?B?MVVxei9qOGpaakJIN3ZvVXdUaVBRVW56Ung5YWNqcDZ6Wm11bkVJR0dob0ZF?=
 =?utf-8?B?cFpTbVVsUGVza0I5VU5uTjNacU5GWTJWTEZnRVpJamJ4Rms4ckNCU0ZFUlI2?=
 =?utf-8?B?aWtqMUdTWFZGRzBYaS96bzdkUFcwZEcvTE81UkRjS1hGMlpKR3BiUW5mUDBH?=
 =?utf-8?B?a29ET2gxLzlnaVVVQnd5aVMwaytqMkxqaDlnWkpQb0N1cm5kUlFKK1B1eWg1?=
 =?utf-8?B?Z1FyaWpmRkpIZGZGTGswamk0V0hHMVBEbnJTOFdBZStDWmVNZ1FkMG5YK1Nq?=
 =?utf-8?B?blFaTGVzb0dpcUhFaGU3MFpJckxjQS9YQjJiTXVDdzJUNGwxYkFtaDBMenZY?=
 =?utf-8?B?eWYyOUQ5UWRKYWUyUTVNdUdPZER3QmlyNFFGbWllcnFRRnpyYnlTWlRQSDBn?=
 =?utf-8?B?a1ZpSnUyMU5TQUh1NnovZUhDcVpHOElrQVZsUDNQUThPdEV1T3VXZ09ZbmlO?=
 =?utf-8?Q?bxus=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a7b695-0b98-4548-a574-08d9fddbe3ea
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 12:38:31.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vznKev9D/gw9yj/MDosW+nDlqVfpb4bdKa9v9iHAAjQsjr8ttxV/pGZU6c5DPDIf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3950
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-03-04 12:12, Tudor.Ambarus@microchip.com wrote:
> Hi, Peter!
> 
> On 3/4/22 12:57, Peter Rosin wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 2022-03-04 07:57, Peter Rosin wrote:
>>> On 2022-03-04 04:55, Saravana Kannan wrote:
>>>> On Thu, Mar 3, 2022 at 1:17 AM Peter Rosin <peda@axentia.se> wrote:
>>>>>
>>>>> On 2022-03-03 04:02, Saravana Kannan wrote:
>>>>>> On Wed, Mar 2, 2022 at 4:29 PM Peter Rosin <peda@axentia.se> wrote:
>>>>>>>
>>>>>>> Hi!
>>>>>>>
>>>>>>> I'm seeing a weird problem, and I'd like some help with further
>>>>>>> things to try in order to track down what's going on. I have
>>>>>>> bisected the issue to
>>>>>>>
>>>>>>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>>>>>>
>>>>>> I skimmed through your email and I'll read it more closely tomorrow,
>>>>>> but it wasn't clear if you see this on Linus's tip of the tree too.
>>>>>> Asking because of:
>>>>>> https://lore.kernel.org/lkml/20210930085714.2057460-1-yangyingliang@huawei.com/
>>>>>>
>>>>>> Also, a couple of other data points that _might_ help. Try kernel
>>>>>> command line option fw_devlink=permissive vs fw_devlink=on (I forget
>>>>>> if this was the default by 5.10) vs fw_devlink=off.
>>>>>>
>>>>>> I'm expecting "off" to fix the issue for you. But if permissive vs on
>>>>>> shows a difference driver issues would start becoming a real
>>>>>> possibility.
>>>>>>
>>>>>> -Saravana
>>>>>
>>>>> Thanks for the quick reply! I don't think I tested the very tip of
>>>>> Linus tree before, only latest rc or something like that, but now I
>>>>> have. I.e.
>>>>>
>>>>> 5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
>>>>>
>>>>> It would have been typical if an issue that existed for a couple of
>>>>> years had been fixed the last few weeks, but alas, no.
>>>>>
>>>>> On that kernel, and with whatever the default fw_devlink value is, the
>>>>
>>>> It's fw_devlink=on by default from at least 5.12-rc4 or so.
>>>>
>>>>> issue is there. It's a bit hard to tell if the incident probability
>>>>> is the same when trying fw_devlink arguments, but roughly so, and I
>>>>> do not have to wait for long to get a bad hash with the first
>>>>> reproducer
>>>>>
>>>>>    while :; do cat testfile | sha256sum; done
>>>>>
>>>>> The output is typical:
>>>>> 78464c59faa203413aceb5f75de85bbf4cde64f21b2d0449a2d72cd2aadac2a3  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> e03c5524ac6d16622b6c43f917aae730bc0793643f461253c4646b860c1a7215  -
>>>>> 1b8db6218f481cb8e4316c26118918359e764cc2c29393fd9ef4f2730274bb00  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> 7d60bf848911d3b919d26941be33c928c666e9e5666f392d905af2d62d400570  -
>>>>> 212e1fe02c24134857ffb098f1834a2d87c655e0e5b9e08d4929f49a070be97c  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> 7e33e751eb99a0f63b4f7d64b0a24f3306ffaf7c4bc4b27b82e5886c8ea31bc3  -
>>>>> d7a1f08aa9d0374d46d828fc3582f5927e076ff229b38c28089007cd0599c645  -
>>>>> 4fc963b7c7b14df9d669500f7c062bf378ff2751f705bb91eecd20d2f896f6fe  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>> 9360d886046c12d983b8bc73dd22302c57b0aafe58215700604fa977b4715fbe  -
>>>>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>>>>
>>>>> Setting fw_devlink=off makes no difference, AFAICT.
>>>>
>>>> By this, I'm assuming you set fw_devlink=off in the kernel command
>>>> line and you still saw the corruption.
>>>
>>> Yes. On a bad kernel it's the same with all of the following kernel
>>> command lines.
>>>
>>> console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=on ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
>>>
>>> console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=off ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
>>>
>>> console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=permissive ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
>>>
>>>> If that's the case, I can't see how this could possibly have anything
>>>> to do with:
>>>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>>>>
>>>> If you look at fw_devlink_link_device(), you'll see that the function
>>>> is NOP if fw_devlink=off (the !fw_devlink_flags check). And from
>>>> there, the rest of the code in the series doesn't run because more
>>>> fields wouldn't get set, etc. That pretty much disables ALL the code
>>>> in the entire series. The only remaining diff would be header file
>>>> changes where I add/remove fields. But that's unlikely to cause any
>>>> issues here because I'm either deleting fields that aren't used or
>>>> adding fields that won't be used (with fw_devlink=off). I think the
>>>> patch was just causing enough timing changes that it's masking the
>>>> real issue.
>>>
>>> When I compare fw_devlink_link_device() from before and after
>>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>>> I notice that you also removed an unconditional call to
>>> device_link_add_missing_supplier_links() that was live before,
>>> regardless of any fw_devlink parameter.
>>>
>>> I don't know if that's relevant. Is it?
>>>
>>> Not knowing this code at all, and without any serious attempt
>>> at reading it, from here the comment of that removed function
>>> sure looks like it might cause a different ordering before and
>>> after the patch that is not restored with any fw_devlink
>>> argument.
>>
>> It appears that the device_link_add_missing_supplier_links() difference
>> is not relevant after all. What actually happened in the header file in
>> the "bad" commit was that two fields were removed (none added). Like so:
>>
>>  struct dev_links_info {
>>         struct list_head suppliers;
>>         struct list_head consumers;
>> -       struct list_head needs_suppliers;
>>         struct list_head defer_sync;
>> -       bool need_for_probe;
>>         enum dl_dev_state status;
>>  };
>>
>> If I restore those fields on a bad kernel, the issue is no longer
>> visible. That is true for the first bad kernel, i.e.
>>
>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>>
>> and for tip of Linus as of recently, i.e.
>>
>> 5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
>>
>> Which is of course insane and a whole different level of bad. WTF!?!
>>
>> I wonder if I can dig out the old SAMA5D31 evaluation kit and reproduce
>> there? I think that's next on the list...
>>
> 
> I have a sama5d3_xplained that uses a SAMA5D36 and has a 256MBytes DDR2 and a
> 256MBytes NAND Flash. I tried a test with a 200MB file, rootfs on sdcard and
> I couldn't reproduce the bug. I'm using Linus's latest kernel:
> 38f80f42147f (HEAD, origin/master, origin/HEAD) MAINTAINERS: Remove dead patchwork link
> 
> root@sama5d3-xplained-sd:~# dd if=/dev/urandom of=testfile bs=1024 count=200000
> 200000+0 records in
> 200000+0 records out
> 204800000 bytes (205 MB, 195 MiB) copied, 37.6424 s, 5.4 MB/s
> root@sama5d3-xplained-sd:~# for i in 1 2 3 4 5 6 7 8; do cat testfile | sha256sum; done
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> 2a4f1534aec6ace9d68f2f42fa28c1f1fe7bd281f960f2218797557aa41fe8de  -
> root@sama5d3-xplained-sd:~# 
> 
> I'll put the rootfs on NAND and try to retest. Maybe to do some other tests
> in parallel to have more interrupts on the system. Will let you know if I can
> reproduce the bug on sama5d3_xplained.

Thanks for testing!

Since you (probably) don't have the interrupt source from the USB
serial chip that I have, that is not completely unexpected.

$ lsusb
Bus 001 Device 002: ID 0403:6011 Future Technology Devices International, Ltd FT4232H Quad HS USB-UART/FIFO IC
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
$ cat /sys/bus/usb-serial/devices/ttyUSB?/latency_timer
1
1
1
1

Also, your file is perhaps too small? You leave approx 50MB for the
system, so it might be the case that the page cache can hold the whole
file?

So, can you please try that again with a slightly bigger file or if you
restrict how much RAM you allow the kernel to see?

And if you don't have the FTDI usb-serial chip, you should probably go
with the other reproducer, namely to simply copy the random file to a
different host using scp.

Thanks again!

Cheers,
Peter
