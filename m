Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24C50EAA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245553AbiDYUg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiDYUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:36:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2099.outbound.protection.outlook.com [40.107.22.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B510F39A;
        Mon, 25 Apr 2022 13:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaIqsS4x5I62N5/ViB83lm8l5j2QUEdM1CTdVnPym9fCsDv/jIi61aR23Q34L7o52w2M+NA+pdVvcwqQGuHkmbcACbXB0QO4nT8fhFqimwULcSsc6OHydcYR9WAGiv+4XmnSDwfb2g+MDj2FLv2yXZs0ceX8fZZ4pZu2ujsz6p8N5QPRShkbxW6NIv+AxFW2Z6WFmUiE5ubcE+Bw5DwcUKVhtbmb6xEVuva+HxrdX254vPmlwx/v8QBgA0eqhAUekzh4n3cg8h/pQ2vH/P2oaUrTxyoPvWKuL0MhIstYolx1aN6PocRqSN1X8tqBFkA2REKIvGs/4HGTUbu+7PTXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/tZ7iYxVbxJK5MBPSQv4IMnY85smlEJ72SXz279xew=;
 b=KuvJYZGb+1eqjihMgOUgMuf2zp9DNSRig3XhzAL2ZXNjePEXj98WEZRmu511uxd9leaFQKULYiemSpuiqRQsDA7rANyitAIOR2Fvb4XIg1+GRl+7F5j3gQo2ukrYM/sPcGpQuxTRHCTnVuo0qIAkvf80jhv6lq/hIF8y9goeXNZO6yqP5jKeqpudNCeU5vKU56ZShZ1tkL+vZKpWGEcpz0ZGvzJVa3QqH98NwTtDFiFTj9JqlRb/+sk6QQUuuItQ1AC2vXJxBaw79Df6sTCboN4W1JhCL4Uy6giYCxaLcjrCzWRax7gpTCq0JN/NlaA2owR+yvixLIj5R+r6Jbj58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/tZ7iYxVbxJK5MBPSQv4IMnY85smlEJ72SXz279xew=;
 b=L6GoXe99UKKGTvWjLyvK7jko0GlbvoVIpBnSWHK/2YgvHqFmZD/2UMWC1SyJmYVYCBJHcpVhqLfcaq57yR834Ln8UjtYnETMm9H/t2Ejyw+Y9vB9fnq1cifFB7yk9LVmPYdJ1S8uc3LrEEdQDOs9q/OzQ3xOLNeC9WQKMYTpFfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM9PR02MB6929.eurprd02.prod.outlook.com (2603:10a6:20b:263::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 20:33:12 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 20:33:12 +0000
Message-ID: <e089bf92-98c9-bf60-6db4-3a91c165b5c9@axentia.se>
Date:   Mon, 25 Apr 2022 22:33:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] hwmon: (lm75) Add Atmel AT30TS74 support
Content-Language: sv
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
References: <e4c15f1c-b2a3-4371-d2de-8205d3dfe972@axentia.se>
 <7160dc31-1429-1206-ec4b-1d8cc0652b27@axentia.se>
 <20220425182938.GA4176298@roeck-us.net>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220425182938.GA4176298@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::14) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37203928-77e3-40df-731b-08da26fad164
X-MS-TrafficTypeDiagnostic: AM9PR02MB6929:EE_
X-Microsoft-Antispam-PRVS: <AM9PR02MB6929D19CAC7B95E7773548E7BCF89@AM9PR02MB6929.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHm+VQA7MTjXwAxu93Io+gB12fx9SATZ5xPN+MHlb5jMbjuSAVp6kxP3HExm05y/xxJhRpuxkqOesXp6YKaK4YI40Q6mKfaK2W5BiiXNxKwSMk8bu+pmYEHNEi/6e/fORXsdqrwaHPxIvMD8+9zEXR4PS98uDSdYxMxipI7Ke47lpl5+469KcfgkpFyp5V9PjLvhQvSBCFqCdGJq/3YMqc5pZ1nxf8Wttd/GyMlYvC8NcOXvaIBiuSTfCUIW2ss2UIOJo1p/Jdn0sn9yRPlADfsUx85Jg7TP2DzIgiZeCwy+wXIwqBq2tV1FBtLrIvWHoPQaFpjsJTgbAREucEM8ScTYTh66gcBbdpKBew1ufKu5ZAb/AstS6LkUYCIVie1k8dFKQzDLfbqnKqapBzGpTlSQeqihULZewGBOlLKULvYX+xalPAy0MIdGN4asP9pJAxXi0rn9ycqZFmujYr2XM0+cPW2ofxLJ0vp+0cMLrWgrV6PtGa0l5y6cnnmolHLW3qWonrCp+UJrxUiHVt0K2jMwB7fnbK1LjcMIqizN1z4HJd9C60dyyTfyRsWw329OFoqSRO2lcTkZ2M1cZjiQbtk1BPlPHXJUfA8om+C6LPUwlWKPzpw5BslYGubYrRKs8v//pv7cPgn/Yait4b71Mx1JNlQolz++F/Y/avyOZTWE+egCNdpUaD7RFBIkhAiPjcA6SOpwVI48ojhhpt5Ps7dqa86BsowIkUU/LMOJpwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(376002)(136003)(346002)(39840400004)(26005)(6512007)(6486002)(66556008)(508600001)(6506007)(2906002)(5660300002)(36756003)(8936002)(31686004)(38100700002)(2616005)(8676002)(4326008)(66946007)(83380400001)(66476007)(186003)(54906003)(6916009)(86362001)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2M3ZENXWlRJRGxVVE1aTE42T2dHQkw0Um4vTDFJSDlHeHh2VC9panZMaWpF?=
 =?utf-8?B?S0s3NHJOTzR2UTV5eG4wdUc5SWZMK2MzYVRGaGFSV3VkbHNCbThwRjFTeUNC?=
 =?utf-8?B?QlFOM3JMdGEyTGVwaEt2VkMycFFYSWFPOW5HVkVrZTdVOENxdVlyT2VjWjF3?=
 =?utf-8?B?WUoxTVdSWmRjeDdhcjdRMkhhMFR5NVArcVlzL0xPZjg2akQzOFJOTldjNFBM?=
 =?utf-8?B?SHhRYmhSTnRwcWtpODBXNXUyYXU4T1hSWm5YcnZsSENkakNpQVkxQ2ZYNEhp?=
 =?utf-8?B?NnY5YWR4R01hVytmYVhzUVBjbmlwR3BNSWJ1RzlzVGVWRy85MGFKYVEySDN2?=
 =?utf-8?B?akdSNGkzREJBc2VSNEJKWTFJQ0pzMkUrenlmMDBSSEY0aVFlK3VyVlJNNXVu?=
 =?utf-8?B?d1hjOUlSK001dElZRHVHT1l0T0lUeVp5NTdzTytCOXlSVkxBaFowWjM5bkFZ?=
 =?utf-8?B?NnV5c0VRVUlncUpWT3dnTTAxMVNTOE9CNE13NWZrQWF0QWZwTzZoWVVxQlFB?=
 =?utf-8?B?SGpJSWQ5TUR2UjBFcWVPUUI2eGJIRXdoemxtaDZCSUU2Y0Q2NHJ2R2tQcEIv?=
 =?utf-8?B?R2FsbTdEZkZiY3psMS9FYkgvRFpiOGZIMEFPL25odXN6T0dEdmFmV2RzeTRr?=
 =?utf-8?B?ZUMvQ0EvcTUrSU9YTWpCZ1N2WXdEODA4ZlBGeXJKYjVpc3VJcVJXajNVWkZJ?=
 =?utf-8?B?bFNmS0FDRFgxMzJYcjl1TFBsczgwbHZrMUJnbElIK0NmSThFVzdFQ1I3ZGdS?=
 =?utf-8?B?YkdqbWF0TUNyZ3A4SHdxNkxWUVZldTg3M09qVmg0ZW9kV2Y0TFV5cUhUNnVZ?=
 =?utf-8?B?Ui9hQUY3U3FoYjRVcFNRR2JFdHErY3h5Wk9CaEhYQUlIYjdMa2d5bm1DTXND?=
 =?utf-8?B?OU1sRWdzQVNXVldlVTc4d3hRcnFwZzBhbzZDV2FJdVByT21FcWZkWERKY3I0?=
 =?utf-8?B?RzVPYXE2VHY3NzBTdlMreUNvSEJCazNsbWZER25ZYXdyZUhPM2ZTN2pQRmpZ?=
 =?utf-8?B?enBKWVhtSGpVdnFEQXRST2k0R085REdMRHFkYkQxZ2w3a0tFVCtuWFYzemI1?=
 =?utf-8?B?ZlI4Z2t2d2pQVThNQnpmSkhndkFhUFJvQlBkL0N0NzFzc1pSNm8zOVg3QW9j?=
 =?utf-8?B?ZXplYlcrVFFHWEVwYXRrYkU3RUc2WUpVMVhNeEhpR2RsSkZIY0ZKaktDU3Vq?=
 =?utf-8?B?NEltL0JjVzVSekNURW1TK0FqYVZEQVhBT0hIWFUybmt4NjVuYVFjc1RMaGlT?=
 =?utf-8?B?VzMwWlpobUdzcEErbnRwRERURE5JcjN4YkNDVlNqa1lDWFZ5UHJxZjNkWFJp?=
 =?utf-8?B?VThIVkZENWZjcDN3Q1BiVVMreXoyTWR0WEttUkdqMVNjRHpqQW5QbW9vdlJC?=
 =?utf-8?B?bU4yNmpQcThjY1hueHI0RnVZdVhJZzhsWk9ZQU44NktJUUo2TEZ0aXpsMnJ1?=
 =?utf-8?B?Q1hWT3owTmxERm9Bb1FEU1pKU0NOcmk1K2Iwem5OZGRpNjRsd3RVaWVscUVP?=
 =?utf-8?B?SVByZE1FMzNnWVdoV3EvaFRXUnFuTG4zYWtvOC9heU9XM0xDY0w3Y2k3S280?=
 =?utf-8?B?dG81SjhSU0tNQ29RTHNOVGZRaWE2ZlU5MHJDVDdHQXhVNXFHeWlOT00xZGsv?=
 =?utf-8?B?RHhpR09kcE5qMS8wMENHMkRDNGZsV1hMMUY1RU5STnBESkV5UTRNbldoYVVw?=
 =?utf-8?B?UFY4aWw3bVVuSzlQSkhkM3N2UEFiVFVNT1h0YWtlMlJWd0NDMm5DMHZOeU4z?=
 =?utf-8?B?SWJSYzBIZXBCdndlS1VGSk5WZTRWNzZRUHV6YVBBcjRYTk9lSkhUaDVRbUw1?=
 =?utf-8?B?TERxcDdJMVNpSk9CTEVRSnI5eWpJQXAyQzRYUXV4TkVTcEs1SEczQkFDcTlQ?=
 =?utf-8?B?VDYyWlRMRXo5K0VqQXhGTnYzcnRiQ2ZQQ2hsVEZjREV0Yk44aGhuMS9sa0RZ?=
 =?utf-8?B?Z2E1SUlMMDRtbkFQT3B5OFBYQ0hjNUNsN2N4eDdKUkVnMThBNnEzb3gxYUdv?=
 =?utf-8?B?TXowQ0s0TkZKNXZ1dzI2ZXJKeXZPanBmd3VhWW9rRkhwbG92N3JraEMvM2ly?=
 =?utf-8?B?NTh4QnR3cFk4RkV2ajRmL1FUaTZ5aC9ZN2VKY1lkQVlVc3ZwckdiTXl6cHVx?=
 =?utf-8?B?VmRTUUdwTzVJQ09VMWlZUkthcHNxV2MyeEhSRGxoRUpBYnRuTlpMdkJnL2Zk?=
 =?utf-8?B?aGI2NHZManRpcjlNaG9QcEl3Z1ltcW0vc0hYam02R1RtaDRqcmVTcjRBdDY1?=
 =?utf-8?B?RVF1MS9CMnkrWEVVckIyZjZmVXBCcm91STVBVjdjTGFmZXdGL2M2c29pMGpI?=
 =?utf-8?B?UmF4a2pTN2djSnlwWUJZTFdFV2huK0c5NmV6S1hPdlAvQnpDeXZRdz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 37203928-77e3-40df-731b-08da26fad164
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:33:12.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sKUPhZ33DQpuoy64qESR/MZpY9HUlEFV190kSEs0SDhs4kaTc0GpcOmoT06cegL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6929
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-04-25 at 20:29, Guenter Roeck wrote:
> Peter,
> 
> On Mon, Apr 25, 2022 at 07:59:18AM +0200, Peter Rosin wrote:
>> Atmel (now Microchip) AT30TS74 is an LM75 compatible sensor. Add it.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> This and the previous patch of the series fail to apply with
> 
> error: patch failed: drivers/hwmon/Kconfig:1248
> error: drivers/hwmon/Kconfig: patch does not apply
> error: patch failed: drivers/hwmon/lm75.c:26
> error: drivers/hwmon/lm75.c: patch does not apply
> error: Did you hand edit your patch?
> It does not apply to blobs recorded in its index.
> 
> when I try to apply with "git am -s -3".
> 
> This is probably because MS Exchange tries to be intelligent.
> In the first patch, it added a space at the beginning of each
> unchanged line. It looks like it did the same or something
> similar here. I tried but failed to fix it up.
> 
> Please resend as clean patch.

After some experimentation, the culprit turned out to be Thunderbird
and its "flowed" text messages. I'll disable that and resend.

Sorry for wasting time...

Cheers,
Peter
