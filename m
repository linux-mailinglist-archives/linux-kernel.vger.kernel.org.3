Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880634BDC29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380127AbiBUQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:17:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380109AbiBUQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:17:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5CBDECA;
        Mon, 21 Feb 2022 08:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5tx1Vr4tz3n/fJtUZ02Gb/hS1wswipCm8+GQpmfRONWcDUCWYmSlU3jzta3jahwkzUEdIUcKfnrZVyoOcEgihr8CWRmvRlqGvpKj0+UQhZSNnKkxCXEBAxx30NU9UUPDHZ+V5D9FmdRQ3zoJ396bJWuEsIZl44mH3EkOfxUP5S6UPr3tzZbz4lcsGn4mgcil97ZVFtRDoxTA3FQvK8y6o+pLDfaqiCPFZpsTIYX+lepsc8z5b23WIEgNobiKuDkNCIgHNv+vAP+cXUh1MqUtCwHGTj1ZHWYWLHog49jNH0l1Msm4q++KEKmxng6dfVde4MybNU7RELHVKtCFexByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CXzvkWov1jZCRLnfN0btciH9XVwe0p8QUplTQKvEBo=;
 b=PvUhPyska4Mx3I7ZQRVd/amqNHMFPy9ZDYiCBHdK87F0rFbdgTmWvablQsZ615akfP8EIQV4tSw2/yL23nhzmNmZvhboRsJm3ofE1Fq7AEw56OKRvJRjCesghxkj076DIEUbon/bu3IHbmlNb10ysIQSIw9Q8VZOoMzibALK/L9PU0LLNzqjOXm5YL5zTBor+++LMPS/iFS7+4wPCGK52PJnRH8E8IxCm/qRNWcf8bO3GGTR9VBoaozk5hNTH7/3e9ooE8RwpNhKyH3newUf9owTkL4c+gBVjc4/6BFZAUZ13ymRUB4/bGP28CFRyTx14I1owxl1KW2gZz6tE5dmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CXzvkWov1jZCRLnfN0btciH9XVwe0p8QUplTQKvEBo=;
 b=L80w8m+SbaGzvVjaJ3fRG4c4a3JeA1oeN27e9UMXD1zLFVyVSs7hYd714WBwzWKVjPZFDzNlLvyB3i58s0eyDn7Ln98WEwpEBxqgXv+a9RMOYeTcvIdLCZIkQzjOK6WgAA4CeCtEh0l77P9Dwm83g8jwVVF14S1WPZd17EGeM3uYyHqOOZGiMzmQdnongAELqnN7p4I1+04Gh/Coh0a7buxcYAYNnceRHe8k5czJcUnWCDuXsxPRQ65xG7Y68/VG8tbL0B0mrdNHYy0yI7ofwRNexT/duj3SG7B4aQ0nizYBAfeEGFRjLGtkdk3KCfKX2xGg/24jOPKT8MOqms4BWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 16:16:36 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 16:16:36 +0000
Message-ID: <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
Date:   Mon, 21 Feb 2022 16:16:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
 <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0461.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7a5368-68c3-4100-dda1-08d9f55588af
X-MS-TrafficTypeDiagnostic: MN2PR12MB4045:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB404515E638D006650AC4FE78D93A9@MN2PR12MB4045.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7SsL/ipEOVcNBU/hJUTkvl8DJ+/WPPGgop+l1ppG8jD2Tuvze+rZ5CVlD3l5UdjpkugHnoRoJ6h7XbwiGSISZyVaQVcn483hncofxRKq7jxBwzGV2dopab9dEP0WW82vJTbmXcw1cfFtYuPLoOz3R8/2GhBhsyDZTxyxRpJLBBvUy/C7ft8r0dd86HuY0DwhcEEr3WcvEZKLmX9Xlbsd9z4vVv9tJoZxy8LV8egeodN6d7VORf5uMxY7r6q+JlLozk1ZCCUZBfKx0oSp0hvpivpKvn02wgE5VLEUpT6Q1ibvqUr1n3vJdA188csYe0AoE8lVHHs3xpMrO96oFHc81zxOzCwoL5Qu8JxhCxPoKuuSFRh0LH/QGXGeGiUyj78Le/kgQ6dlb2JtsXLW5wmhHFL8cps80s7Vpi0C0hf5nbM0n+ZXMZO004OR69t4Oj4b2EWLnU0jcb+d2JuVmBq4lUi5WQ7guCGHIa8kkRrk6FQbg2sEXm33ZTObjIff+aFrrzEmo9FAkCXF8oujXFvc5MDPDeKWK4m38+0hX2KGYtDCwcWYHw6FKp9BXriydZutPeyKVAucQ0xC3XLCxs4t7gHkZz/6ejgpgY2FqCVkfZPwsFiljI2VBFMzR6pBPiaQx4kgYc3Unmfq3B6Th1RPZIgJdt1c+u6eSRFGlrNlEGYr+cz+r/y3sW6qbDjEK4R3GeVOsKgRc2DEsfawaDFmvG98/j1V58RQ/pRPbdSo7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(6512007)(2616005)(26005)(186003)(6506007)(6666004)(508600001)(53546011)(6486002)(4744005)(316002)(5660300002)(31696002)(110136005)(36756003)(86362001)(31686004)(8676002)(66556008)(66946007)(4326008)(8936002)(66476007)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxpODRZMkNhRWQ1alYyVENJN01oTGVwRmtHM3c3ZDVXUUpwZ0swcGhLamFZ?=
 =?utf-8?B?ZlZVVEZBRmRwREtUMTZWSERFUXJpN1MwUXRsYmp3UHhsNnBRNThjdWlOZ3lh?=
 =?utf-8?B?WGMzekFFazZ6bXBOQmRKQmFqeVdmVStOU3RXbm0zYWZIZTZ0MmVjM0FvRXhR?=
 =?utf-8?B?SXBON29jN04vbnl4VlZYQ1pPSDdKV3FyZVBpUWV5L2xlbjlxYkVjcysxaENG?=
 =?utf-8?B?UFJMUHdmYk5kbGhzbFZQQVgremtIZmh5WWVZeEJtcG41TUFPeXE5Q3JnZmxG?=
 =?utf-8?B?dFpiRW0yMkpLRm1hRnRJU01ZOXF1aUtLQ2R5TjlieUdTMEQwTk93UFVSTjVU?=
 =?utf-8?B?WWp5MnUyNzJDUmgzc2RUOFk0QzEwQnViNm1KWStBVWwxeVZFMWZJREVZcEtC?=
 =?utf-8?B?aHFuTnRPYjlyZHNuR2xFMzdqUDRLUHNPb2pTSnprK0xYVTlOTVlMYWpMaUF3?=
 =?utf-8?B?UWZ5Q0FBZU1vTWZTNmhwODBUWk12eUY4K3RjaWo2VktnYm42bFp0aWo3d2lP?=
 =?utf-8?B?NXd0ZU1ORS8rdER5UzJJa0FvVSswZE11VnZJMWI1L3VQcXBCYnFoSkt6NmxW?=
 =?utf-8?B?cWpLdkVlZ3NGdnY1T1NMUk92NGd1cU5kemwyNVI1NGZSRjVJZmZxTkcrdVVD?=
 =?utf-8?B?ZXdQSWVuS0g2ZGxZUTU0WDZQMS9nMG9ucGhScHhkb1pERXIvWm9BS1JZa2F0?=
 =?utf-8?B?WlNWSG5McVUwZmt0RE9ORGk3Zmw4UEM0RmJxZm04Z3Z2Nmo1NkoxVmtxSndk?=
 =?utf-8?B?cEp1RmQzVTFzSFZ5b3FlaHo3ZVhkd3lnWDJSSEljMkgyUnM5Qk5GQVFrbEpE?=
 =?utf-8?B?NXYwRE1yVmNMODRQWEZpSkVFMEJITnFPRTlVYU9BQmpTVGVmNUk5VnNVWXZM?=
 =?utf-8?B?dE5RQTZjeGFTQkk4Y2huUzFheVRxY3VkV2VJcGFDaGlPcXBZNDZ5dzhIYmNS?=
 =?utf-8?B?QjhIVUQwSWRSaWJRTVFuemZXQkpacmN0KzNkbnJXaXYwVjlWdENyVGE5eU9H?=
 =?utf-8?B?MnppOS8xUmxyelZndXNzNmNPYVZTSEZ3UVJGaWlRL2l4OWU4K0IzOWY0UHEw?=
 =?utf-8?B?cVhqL2VMeU5hNlpzNTliOVJMdUdtUUg2QnVKRUFYZlVFZ1cxUlE3d0g5Y3lS?=
 =?utf-8?B?TTJUdENHakxIcG96VjQyQlNub2NPaFRJdUhMTnA2UUt2Rk40Y0REWEtZNlZv?=
 =?utf-8?B?UmFpMnc1OXVDYTdNR3VNTmJhTjdZVUdsRDFxZ2M0SkEyaDhNdkhHbEFxbjJT?=
 =?utf-8?B?UFFudzhBZUVEbmZobTh2TWNHTEdOL20wTjRjcG9UbUNMNTlyMG5YUXlNZkk4?=
 =?utf-8?B?RC9BRDdaM2VxQmc4Tk1HZHpzN3ZqM0JzOUxvVWNBZ2twQ2wrRm53cXJ1V2Ry?=
 =?utf-8?B?QW9ackM3WjNuNkxHaDdmZVowUGdTOWtMblBLM2NhR005bXhHeGNTM1hIZlpV?=
 =?utf-8?B?K3V0UkNkc2U2OG0rTFVRSUdNNEJiVDFLZFBxQlRBeFJSclpsVzRQKytiQ0RB?=
 =?utf-8?B?Ym5IMlcvS3N5eWwxb1VvREZmRlUyMVl2VDlmREJma2hUSlBhOURPUkg3TWFu?=
 =?utf-8?B?NXNsY0ttWWdYbkpvWmhzaTZKRmlYeXg4a21MZ29HSU9FOVZBUnM2REZOTFRP?=
 =?utf-8?B?SGNkb2Z5VnpwdW1iRTFYbGpYYzZURDFkcm40OFdzVHJjQitIU3pyZE1Sbjcr?=
 =?utf-8?B?Y1NMV1Y5SDdLQytSZ2poWWphTXpKZWlLdC9GYmljS1RiN3hnUW5hbmwyemhG?=
 =?utf-8?B?S1poVzNPUjdBa2JqSG8xYzZTL1N5Ny8vcVJhS0FTZmJPT0pOZUZ2YnhoNkpx?=
 =?utf-8?B?cjRBelJwTjljc2VNZ0cwNWx1MEwvVGVhYkdkdkk0NUdvek95bit2SXhrMXRo?=
 =?utf-8?B?QVpyd2Y5UVJZRUdDZGtqd21tdHBrMGEvMHVxRmFVYjJ1bWNsaVArYzhaSmR2?=
 =?utf-8?B?VUdNZndOR2ZmV1NaVWJlUzdDU0VzQkNvTHNyaEw3MktxWGFsQTd5cDJoWm8w?=
 =?utf-8?B?QnM3cEZwWW00T3lhWXdYU1F6cE12N1pVemoySmVqdy83WmhURWJqaG1KZVNh?=
 =?utf-8?B?ZC9nTmU5RElOTFpSVDRURGVtQUZaa1hNVWhhVHdCS1RYTnJmK01XY2dybmVI?=
 =?utf-8?B?SU5zVXAxMmZkOE0vSmkwTHZkUnZwTk5aRFZUQnBMcGFsNkFGMU1mOW9waUdh?=
 =?utf-8?Q?HBVKrQLG0rXrXZLAC08uiIk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7a5368-68c3-4100-dda1-08d9f55588af
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 16:16:36.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY0r9TEoqQUXX/2zau4Rd3qre3/wdHrR/gSbIurexVGq5o/pKxzIGVHJjEPwUlEeOAd5La8TLLAlk3l8iUh/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/02/2022 16:02, Guenter Roeck wrote:

...

>> The platform I see this on does use device-tree and it does have a 
>> node for the ti,tmp451 device which uses the lm90 device. This 
>> platform uses the device-tree source 
>> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451 node 
>> is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
>>
> 
> Interesting. It appears that the call to 
> devm_thermal_zone_of_sensor_register()
> in the hwmon core nevertheless returns -ENODEV which is not handled 
> properly
> in the hwmon core. I can see a number of reasons for this to happen:
> - there is no devicetree node for the lm90 device
> - there is no thermal-zones devicetree node
> - there is no thermal zone entry in the thermal-zones node which matches
>    the sensor


So we definitely have the node for the lm90 device and a thermal-zones 
node, but I do not see a thermal-sensor node. Maybe this is what we are 
missing?

Jon

-- 
nvpublic
