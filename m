Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9850F2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbiDZHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344068AbiDZHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:38:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689365F42;
        Tue, 26 Apr 2022 00:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFTjdMyFYnj/P3E6gI97K8eMIIuTZhaZRbQBng83SuYg5zjGmSjEGD+X86qg4RMH/bvCJylZQ1oMkt+3sWKTq9x0gMTTozcIyU3aX/oHeMXrro4rIGsVpsNEbjUpDoLNwLJamh4zcUKJ3zbXflHU0olxfbmbiyAa5so4qtMPdsFrB98rs4fPg5uRQKewXdyHT5OnnUyXX1x8kEy7Ylv+2mKGqWBrKtqg2YuwO//WX33vVev+nghuCAcnhAUubzK5qbiTjIf0f0HLnLXFDxhEULWlnLNXqpf2XGN+O4KVno1wIjcuIm53onJSdMH/m1CN7oat8BByeO1nBfXGmffjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHN/CT11Sx4FyizghcwzFhzPT98u+qyfx+VDzYsHS7c=;
 b=oVLUQiW+mla4fQuvUqaYpDLoDKTs9WAh0NSCj0pbQoo7AsuA4iErtoWB55H6M+VDSeYhJuBTVR1xWq91kHwZb3t11lvz2OMlJas3C+bCsTCVYmhFwbC336RPU2hG+At6+s0+/aTmHdz1X0e4AveyyzAmuKlJ5uwCN2LEJR7JZLHwvCHG1UVGTMxdHKBNJ/9kAvhAmmn4ZMSRlQZybwOFUZCRvUjPLO9WQNiUILhjFY0LhBRDzturzJZ3H5FxdXawycsuydqzSJlWxXDClmEi1wKljLUdyNvLnh8+cFJBvbzQOgasrDAfBOv/MynhWQavlBaBHUePZi5wP/2nCOYJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHN/CT11Sx4FyizghcwzFhzPT98u+qyfx+VDzYsHS7c=;
 b=mH+WgBmYLVOzZU0/nBGVO1kGIT7XLtj4g/uSfBibBQ9yN03oCSJq0fckJX0/I40CPSYfEBapP8gpfbF0kxuUzXSz6Xpe+1ZbKFRgZCnU74qQq+qCTS0Q1RBx3GjVSl/+UKzAoMFK56K5ZRbcBjJH2nb9F8A3NrZFgol5XH/R6zP6tZnqGT1gOVLv7ah3fuu/uRvh7jMDKCoG6clLuqmW7x+W36haaPpt+cdqmzXlvWn8jxyZJjseLlC+F5S9NGLGhF2p1rlALy7gaFxW4IJnDusM/3/s+n0G0tWtU8FXvqku7KYMuNTpw1bU0U31aHxmvOQNNMm09K8UXsNp6ZjFPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 07:35:19 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:35:19 +0000
Message-ID: <14750f67-2f5e-3139-b1c4-a80bb4b892b8@nvidia.com>
Date:   Tue, 26 Apr 2022 13:05:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v8 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220425075036.30098-1-amhetre@nvidia.com>
 <20220425075036.30098-3-amhetre@nvidia.com>
 <777b30fd-59ba-56ec-4f66-4d82118ca921@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <777b30fd-59ba-56ec-4f66-4d82118ca921@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::30) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dcb1865-19e5-4a6f-4b2c-08da275750a1
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5663:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB566365B13F859736B6932C8FCAFB9@SJ0PR12MB5663.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0ixBNeNAXeY7Rj87kXr4FW4WlDf2N43TURTFQ69iYlfXmkTaQgyV0K8DzjaVCxcZ590D8MQjiwaL+B9VZ8CtAWPPpU5nOA/GLXnOi/+HGCuouPg8XT6+wLtg8NtaVbAp9lNT9KONlsy/DeNmbi65PP6GMuFrdO/xtPztZD42vlsT6bYAuxerlkoaKVyGE+djdEFGVLHzP39FRON8ZmdpKfQ3AaFep2I32TJ7OfvmgNbYqYwKxMPeAajP4Isid9h8AItSsfOSoxQ9vAXImAt4JLF/PXK83WvTeZdM/vS1ipwIIGcn2K572T8VDt1kU/70W4G2KNnrFIGD/OmnGjeQCVhN0oGRNZ28VSlLBYDO/w/rFnihUhoOpEndG/8Uz17yNiV1WvAcy70bcexUQny3t/ZQdsKOJPmPwmDO5GOTjR3AMYG+J+inN3ijntVE/bbU7Cm4+dafFA1sZdBshB+AMn3ZQTf9A/Tmq7+I6tgC9dXCMJxjk06ZkqAr1C/Ti8XY6CC9ROOKjLqM+MFPHAgWPBLoNWf42OJB9YTbHPT7BdQ7OTQyP7hMsCIBiI/XfrtMaoPY4kf0gS5I443/caxa3HGlN3vNJ51+jDTFlLpjqTVE9+M57/AaraVSYvF7vYUfZIIsgI+cHWqg9F5oI5DE24xPQjBUOap5iujOpNQNGvcWkZzZ/Xt8aBd2IoKNfH3y7jCsNJMpsJ1mKD4sOKqD9DRaIHXtSfAC30OdU+wEHKpwTig1QjDBPysnf/Op6BYrtJighqvxzgzwFTzKeIVfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(6506007)(6666004)(6512007)(55236004)(107886003)(53546011)(6486002)(186003)(26005)(508600001)(5660300002)(2616005)(4326008)(31696002)(86362001)(2906002)(8936002)(8676002)(38100700002)(921005)(316002)(31686004)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9pbWV0MmdkRlFwejBCNDFpbUVWZ1pNV0gwZDhiajdEMEpLWXI3bEtGNE9K?=
 =?utf-8?B?bS8veUJWVEhwbkwrbzJKa1RYZmdLckhoYnhGZ3Awa3RRVWwvUGgweWZIdHI3?=
 =?utf-8?B?amRNV0Q5VS9OaDVLZmhsMCtvREladmNXaVo4WUJ1LzRwTjl4ckcybVg5MTNX?=
 =?utf-8?B?a1B4T2hrOVRja3dlZ2UrOWV6ZXpMak1RSFBTMG1uaVRhTWlBbS9aNzBEK3Zy?=
 =?utf-8?B?eDB5THhxTGtQVmFQV3ZmaVBBMVloMWh4T2FwVGsxSk5EZEhHdndYei9Ga2dm?=
 =?utf-8?B?a1YvZzExQUswMkd1MU10SWhSSFRLQ0VMV3J3VjdXMERHRWZVUWJSV3NIZDFI?=
 =?utf-8?B?bzNqQXZMRUNjTlpEdENNRGJITVI4Q3lQcmZCMW41OFVUQkpWcXVKeUV0ZCth?=
 =?utf-8?B?ZHAxRkk4Q1dSZTd2a0NScGhBRXdBelo4R0VSRlRWM1FBK1ZJTXIzb1J6UGVl?=
 =?utf-8?B?OE1mYUFla0hnSm8xUHNqZVdMbEwyRzkyd2lEU3JuYlBCZGdEKzJqTTgxK1g1?=
 =?utf-8?B?R2F1WHY4VEhnUjg0R2Riei9nS05KdE9PaEdteU5lQXBuWkhDd1pJREFaN1Nw?=
 =?utf-8?B?ZVJybWFiSzVRMjhOYWdyUHBvOGpVRGpYZVh1ZTJqWEEwTkQ2QUozSUtiYTR3?=
 =?utf-8?B?TWpKZjJzWkU5UkdxdzUvS1YveUx1TUVGajNEWUxFVGFublBUOEFVQnk4QVox?=
 =?utf-8?B?Nm1lMHdCUm5iMVFHRE5pa0Voc0ZZVWVwaTFJNWd0akJhdkVtelQyM0hld3lw?=
 =?utf-8?B?cmowcTMzVU00UzlKaHk4NS96TFpTOXdWYUxDaDluY2hYWWp2eldoVFhzS1lG?=
 =?utf-8?B?ZDl1STNsZFIySG1Pc1ZIZ0RyV0NELzY0eXNqQjVFVUgrSUFCWEtxY3ZJS3Nt?=
 =?utf-8?B?UHNVc2Y4TVlkZFo1SXpTYmZsalRlWHZhMVdnUjVrTXEzaGdDUlIzOWlyYm1R?=
 =?utf-8?B?Q3FFT3Rvc2lTeG13ZEg2Yi9XUTQ1QmwyV2pZTGFXLzBKRUVXUzh4OFEzQzVX?=
 =?utf-8?B?T0N4ZzRqWlk5bmVOVjB5TWJRNXFwQVYzZmNDb2cxZ1hqN0FxY21OSU5UVDFL?=
 =?utf-8?B?UXBNMW9JNjlJallXMStjcjR0ZVlndmF3d3grZkNNN2Q5M2d1NWg3S2h6WGNt?=
 =?utf-8?B?VU5JU2laaENHNUFDNitHUEQrVXlVdnplZWt6S3dIakpxRGJoT0QvQklyTGJx?=
 =?utf-8?B?YXhEbnhRcjAraFVxS252ZkZSTFdHVnBYUkFlZVBsNDc1dHlDeW00TG14YlpP?=
 =?utf-8?B?MmhRT2Q3Q0ZKYkEzYWN0QmRPMTBtc3JJd043V05WanpkMzc4bENqc01IRS80?=
 =?utf-8?B?UHJvNDFDK20xZHhQL29WdUdHRkthblNLODM4K1ZRMGxURjdneHlMZTVINS8x?=
 =?utf-8?B?Z285MzUwcnorUWY2Y2t2WDBsekNQUTk5QjBrbDhHcnFiYnRRWXBZQzNrOWdZ?=
 =?utf-8?B?eTVPdkkxRVZjeUwxR243WHVkNHQySUpMODBYaEd2bXdxajg2NmNZR2V0L21L?=
 =?utf-8?B?b0ZNWDNhWVVuRDNNNXR3RzJSZm1PdFI3TFNuWm5WL0NlUFhlTjFBWkd3SU9X?=
 =?utf-8?B?d2Rpc1RIZ0dQdDk1YTlPUG12dkRaNjRpQU9FUzBLN29NTVhQOEdLbjhWdzBG?=
 =?utf-8?B?Vjg2WUQvOEZldndUMXBYVXRUbTFKWG0wYkpDbVh3VlRGcWVwNWx6TkdTaXpr?=
 =?utf-8?B?bmp0bVlyaXUzejNjRW1QRnpvbEhpeDhTeFBTUWhoREc4eVYxbmVSZ09GZm00?=
 =?utf-8?B?M1ppb3BzT3JHOGhGTFBjOUZ1NGxTUTFobnFuUVJWNVBiL1ZkNGdsWnFkMmZ3?=
 =?utf-8?B?Z3lNSUZrYjU4b05YMERZU1dvWXl6SGU5djN3TFREL2RNRFNFMTV6eGVaWUVy?=
 =?utf-8?B?Vng2S3ZyTXlRbHphTFQ5SGJqN1psa3dOZVM0T3R1aWhWc2xzQm02K1RTdmJ4?=
 =?utf-8?B?ckVnaWJzVEFoTmRUWEZ6S3JrYlNxY0tFM2YxUkRHeEIrem9GV01LWm9hbyt2?=
 =?utf-8?B?b3BxRmk3dTk2d1MvUnNMVkg4UHNQdWVLUTdyMHd2VmN4YXJZaCtESXpDT0Ew?=
 =?utf-8?B?M3dTc3pJa1hWeVYrSHF3OHNibW4wRk1ZMjJ6MW1GNDRNRCtkY1hrWkpndjhE?=
 =?utf-8?B?aFRvYzhKcElTTWRRT0pHVlRIRGV2Ry9VV0Q1L0R5Zk9SNldqb1Z3RHByVWVq?=
 =?utf-8?B?Tk55UFYwZlU2UXhqME5ScWZpTk9NaGJGRzJIdjhJdVdiSGxFNmk5bVNGUE8z?=
 =?utf-8?B?YlU3b04vTmkyZG5teDFkTnZGamZ4RU1ZMC9za0I5dkZuL0RmMFlhUTdFSkJx?=
 =?utf-8?B?M1hSbEh1cmt5SkZUOERsSzRhaXluVEpXcmNFVTBJTkU1T0JXM2JoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb1865-19e5-4a6f-4b2c-08da275750a1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:35:19.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gZu77hZFrTgCWfrZSNRL36vdmKa/0+HJYbTKfPw6+jOF590YKPH5Eyx0P/Ob2f09TLoDHwBUhOgJL0A5tw9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2022 1:09 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/25/22 10:50, Ashish Mhetre wrote:
>> Add support for reading MC_GLOBAL_INTSTATUS register which points to the
>> memory controller channels on which interrupts have occurred.
>> Add helper function 'mc_global_intstatus_to_channel' which returns the
>> channel which should be used to get the information of interrupts.
>> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
>> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
>> Add error specific MC status and address register bits and use them on
>> tegra186, tegra194 and tegra234.
>> Add error logging for generalized carveout interrupt on tegra186, tegra194
>> and tegra234.
>> Add error logging for route sanity interrupt on tegra194 an tegra234.
>> Add register for higher bits of error address which is available on
>> tegra194 and tegra234.
>> Add a boolean variable 'has_addr_hi_reg' in tegra_mc_soc struture which
>> will be true if soc has register for higher bits of memory controller
>> error address. Set it true for tegra194 and tegra234.
>> Add helper function 'mc_channel_to_global_intstatus' which returns the
>> bit of MC_GLOBAL_INSTATUS corresponding to channel of which interrupts
>> are logged and use it to clear that interrupt channel.
>> Update variable type of client_id_mask from u8 to u16 and add it for
>> tegra186, tegra194 and tegra234.
> 
> The formatting of the message could be improved. At minimum adding
> newlines will help readability. For upstream patches it's very important
> to make a good commit message that is readable and concise.
> 
> The commit message should contain:
> 
> 1. A rationale for the change, i.e. you should explain why it is needed.
> 2. A brief description of what patch does, explaining only difficult
> parts in a more details.
> 
Okay, I will update commit message considering above comments.
I'll keep it to the point and remove unnecessary implementation details.

>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.c       | 134 ++++++++++++++++++++++++++++----
>>   drivers/memory/tegra/mc.h       |  43 +++++++++-
>>   drivers/memory/tegra/tegra186.c |   9 +++
>>   drivers/memory/tegra/tegra194.c |   8 ++
>>   drivers/memory/tegra/tegra234.c |   8 ++
>>   include/soc/tegra/mc.h          |   5 +-
>>   6 files changed, 189 insertions(+), 18 deletions(-)
> 
> Otherwise looks okay:
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks Dmitry.
