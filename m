Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF55A994F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiIANn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiIANn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:43:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69B13E12;
        Thu,  1 Sep 2022 06:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr8bqwYs+m68a3WwCBpfyTO1R+z3yfCC8/w995pTH7u/x8OSscd4cBp07stDcUyJEUyKhw/wh4RbZ/psfcWrILP/COwuUpbYo5kWYitx70Ez8dn5TA1uVPlOipa2WXz0bQDrglC9p8ZFVCV2yv9SGagS/wFN2O2nzp81KKn681p55pfegvQ1sxh5TYHolZAxyVx5inYyqNjyI+RUet01xV5cGegAWf1/qIM54nt96HCQm/ffDXJbHfVfBX8r4gVD+LDRk3y3RcrBzmlWegezq1IKYqB7vElbDue56CWgHjRhfFh9aEgtEZ/X24Xnp4txcd63P1jTWF09yIq3l9cdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK82SXN2hoRi/hTs3TXGqIqqleWuZaYYTtUP7H2Ux9Q=;
 b=YghBa3TO1xjEMcM3vCfm/UJhYrPke65jO2NsdPh9O6+Db87TnstK2UGxlYdEhbhrelhSRLgJtQP67onWBqcTp0PfT8omXw6cuPqm64MzH3m4hRYelelB3QQ8SQk7AenA8LAOmAah89o6hy7ZukRqMQeI2n01YeqOJvynfI0xn5/5ygD63GtL/oOo+7f9MZPNibUPaY737hAmZSUyoUtxVqa5aLFeeJTVzQR+xciR0p+zjXQdwq7+/hI53QTsM/1vq/CnPpFrUO6OFZBXXzf8EuWCkeiqwsee1cuAOV8ctKAd99j5/NJuwg86HPt4fNl6J7ftSrEHwKQO88hzJyF6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK82SXN2hoRi/hTs3TXGqIqqleWuZaYYTtUP7H2Ux9Q=;
 b=e0UOIQLaMYtlG6xrsGFRDEUYjT7uXp45uY9esc3NAlurEfvVOJdnhXSkhjNiXGJquqUE3Aqh0rHlfhl6Ow782lxmkiKqXyZx6JNUtqNeeU+xR3GsNMJ6H9UG1TszG2maQppURdo8IzvgBbuGP5yQ/lLxwMCb7p3EShB7n07bqsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Thu, 1 Sep 2022 13:42:33 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%6]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 13:42:33 +0000
Message-ID: <a15ab3e6-249d-af48-b4d5-25840b72a933@amd.com>
Date:   Thu, 1 Sep 2022 08:42:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] crypto: ccp - Release dma channels before dmaengine
 unrgister
Content-Language: en-US
To:     Koba Ko <koba.ko@canonical.com>, John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901021628.1130985-1-koba.ko@canonical.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220901021628.1130985-1-koba.ko@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0121.namprd11.prod.outlook.com
 (2603:10b6:806:131::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee78bd8e-1bb7-4817-8994-08da8c1fd2da
X-MS-TrafficTypeDiagnostic: DS0PR12MB6464:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8R/Iaf5an3qqQKb9J1jz+Gfoc+KdGCmbtb5Bg5K6n4YjX+cMyVESjJ2IxhFkqKl9CypBxrbDibqhnyB11X4+Qpf83HEtJ75i+n46I6HGNhscM3tHJBETvygAWBa7VRUMMwdXw5iiYCSiDDg7EeJJzQSXCsrMYOE6P8hmw49/Ytp5wVeYV7V4MnywPg1z5ObRdrKoVmdxQtC7uJdUJSiPIk1pWmkGoqRAK4coHoU48BGCJXM0Na/ZoDJIliBDQB8VvGdV+JBGVJfLSdrcwNQ6nSKoiqKgXqrYjjRoBdBesHiX2vgpHkXFNUhV+jkqcNTzhbR+gj5KzPOjexFjE1UodCMCgV89VHBb6nT7Nw22KuwTA1BzP0EYFWS0pev5aOrUjDy8vOp/H7an3TKkZ9+korljvAIhlKJ3S1Lvabn3D/0S56oAeJzyVMf+pPXYFFNp/epfyeChx+pz5Ekolm8caviF8sIbAjB6nudKq6QWvowgSIyoZyyIiZe22eBV8V1415Xd4SKW0oOi1TWG7tKiZvW8KeMf4Widn/ZDxOm84U0zR7kJlCBSaOJhv0taDuG1hO0XyQriPcOzXuFngtSYf9Zz60SzfuA0EGdNd5CXi2JyHjyPMUMv1DI3LbVmEjbnLK/odzhjJzPIl05ArcCvAAr/tx/8yfSUK4ybg/Oqf/VlH311RgolGCq0wk4UhqEV+7v9Ytb055w5sAn7a2mbEfbRuz/W7NLeJeSGip3w28HyzpT3W3MZUIpjs+EUK0y1ALFPcQ6Hg3P3vT8s2r6MXoCv95FMWcukAZ7az7pqgfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(53546011)(6486002)(186003)(2616005)(83380400001)(86362001)(6506007)(478600001)(31696002)(41300700001)(6512007)(26005)(31686004)(36756003)(38100700002)(66556008)(66476007)(66946007)(5660300002)(110136005)(8676002)(316002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3NIZGxSdUhUSjlGcy9TdGRmS2RGS1cwcFFyRkxMeG5BeDBnamIrMjljclZw?=
 =?utf-8?B?YmE0K24wSU5GRjZiaC8rK242Q3hPWVg4MlYybVM1d3VMYVZxVEovaHNiVnh5?=
 =?utf-8?B?MTA0L1djWHBsSFdNMTBUc205NGhSU3NGa2FNRWVOQ1E2eTd5RVZFaGV2SzdE?=
 =?utf-8?B?OFBhQml0VlhOVTVobjQ4SlJzaW1VQWg4L1JRSnhLS1JXeU9LSFFpRVVvaHRL?=
 =?utf-8?B?RlluTktQTks3aVc0RklMeE4ybyszQWt1Q2tYdHRCVFlrNUtvZktGcnZ1Wmlz?=
 =?utf-8?B?WHhNeFlqbzZhT2I1Wk1zK2U2ODA0QzlEQzdSQktUYzlYVldZTjVYRVZmcTFa?=
 =?utf-8?B?ZFptQlkrNmRxa2tiMmU3Vno4ME90aG9rV0luSlZwbHZjUXkxVFBBS1lDVGo3?=
 =?utf-8?B?SDYvV3pqazdnMDRkOVFZVlRLVTJGQTF2bkx1QTlhdTdRVG12eEtmc1NmekJz?=
 =?utf-8?B?K1pWeC8wTGl0eEdHaGtBbWJxMVh1eFFnc1BlZ3U3ZTBEL2k5MmIvV3ZsRUxN?=
 =?utf-8?B?MW1rNyt6dXo5ODlEUGdtcGtySEJ6eGU5NTZNNEEyekZBVVRtSDdZSFUvNjM2?=
 =?utf-8?B?dzlLYWxaU04zL280M1RPb21WQ1dZUVZ1Uk5pR2taWjIrRmpVWmgzbWtRMitO?=
 =?utf-8?B?T2drbmlWRE9FWlB4MWhKMzBqVEYxYU1pOUtSMzhKL3g5RmhHdEpHVEFlSlBW?=
 =?utf-8?B?Z0lMUVcxcU1vMFBnY2dsRkhMOEVyMnkvaTMyL3JRUVFNbVVXSzJIdTVKNTZh?=
 =?utf-8?B?VUNsQktVVGJlcHY3RVhiZ0R1NzRuUnZMQnZneHZ6QkszRXQ1eFczVm5ENVhi?=
 =?utf-8?B?MlZZMVVnZVNPWXRnWThlREdPb0c3ZUNQMWxJaGNuQndhU1kwVk11Q0Y4TEdk?=
 =?utf-8?B?ZWY2UmdENEpyOFBjRFdLd2t2T2FjY0toT2dUeDd3NG5KN0M2SWdhbWl4Mzhu?=
 =?utf-8?B?ZHA5aU91QXBjc3hoYXZHU2RJcEtpTEpQbXFVUXNIQmIrRHgxanJjOXBHU2FY?=
 =?utf-8?B?ME0vZnp1RC9VeS9lV3oxWmlCNVhTYXBVaXVSZnVtYjFQeUVuRkFoWURrajQ5?=
 =?utf-8?B?L00yWW1TVklEbVFZeHlOT1BYYU4rYTdzNmdXT0JBMmdIekV4eThaTnhkcEc0?=
 =?utf-8?B?WWFCOEFtTktYcTFpdnl6Z1RmamNaZXZwTWtCL09USXJTTnZHekNFbzZlMHVG?=
 =?utf-8?B?T2tRZ252RHByODk0bUJhRzduaWNLVFI5eFFlOXNNaVRtNGJSYyt1d2ZHOS9j?=
 =?utf-8?B?Rk9kcXBMZWJGL3RmQ1Jwc25KQTFad2FwRzlOdGR2K3lXa1FNUW9RUmUvSVlS?=
 =?utf-8?B?Vi9PSk9UVWprVUtYNjdVQklOZFR4WC9ST3hFcmVBS0wyN2JLRWhCamdOZzZS?=
 =?utf-8?B?dk9ITDVBOS9ZWjM3UWoxOUFIZHJJb2NUcDF3QkdGVXBLVWxCeWJLdFFqd3py?=
 =?utf-8?B?WnlKZ282bnZWT1YzRWpkaHFNWi96QnVrWFFNdFVYNW1YdnJjcS8xNEpTRmVz?=
 =?utf-8?B?QkR4bU1UZi9zbVNGbTB4NUdoR0RkNC9kMU9RQVFEUTFEc050amdWTElDYUlz?=
 =?utf-8?B?SkYya25udTd0cjRtVlFSMzZuS1dnSmtBMnZxUG0yMjVMWExPZk5PQzg2eUZr?=
 =?utf-8?B?bEs3a3lJTGZNb3orVlNvamppb2FmK2w5Z1F1NDhzM1BKY0JKSTdoaFhvcFpi?=
 =?utf-8?B?aUtWRVh4WEQyUHdHeFh3NStOcmlweVE5enNvNG9SMTZCQ0hNSC94c05USGtS?=
 =?utf-8?B?UEdpR1FFYzlVM3MxZHlFREorTzlDSmRTTnk1TTJDZlFZd25HYXl4MVdnWE84?=
 =?utf-8?B?RVpVWTFXc29CdTVKcUxMT1pVdWtmRkZtK2xDSmtzV2hoeDlwWTZrV2w1aGpv?=
 =?utf-8?B?SnN5M21ENWZSWkQwWTVFVjFaMExKL3g4SmZSMWU5di9sc3E2bGNjcEpxS2Jl?=
 =?utf-8?B?czNiWG5Eb2w2Q3ZrNU1USy9TVUxDMkhOSCtqdjR2UmlYazBBeDhqaXE3VUVB?=
 =?utf-8?B?TnR3WitYNEFlZlA3QTE2NjY3MDdJd3BQUHErd3Q2U1VQdk9LN2RUQmRCVFho?=
 =?utf-8?B?SEdaOE13NWF5S1pXTE00VHNjTmZkS3Fid2N3VTZkM1lLcFFOR2V0ZWFwdlBT?=
 =?utf-8?Q?C8pTdsiqZKHcu2c5I3zeuW5/4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee78bd8e-1bb7-4817-8994-08da8c1fd2da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 13:42:33.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74fXldM0xgNtU5/bcAmD5/Mjs3T6aEnxM4Mi4SZDeMvMwqdo6OtYsEwcHoT8x2sYh3PT1zz1KyW8fQiyCa8yNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 21:16, Koba Ko wrote:
> A warning is shown during shutdown,
> 
> __dma_async_device_channel_unregister called while 2 clients hold a reference
> WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110 __dma_async_device_channel_unregister+0xb7/0xc0
> 
> Call dma_release_channel for occupied channles before dma_async_device_unregister.
> 
> Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")

I can't find this Fixes: tag. I did find:

54cce8ecb925 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")

Not sure if Herbert can take care of that or if you'll need a v3.

With the change to the Fixes: tag

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
> V2: Fix the unused warning
> ---
>   drivers/crypto/ccp/ccp-dmaengine.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
> index 7d4b4ad1db1f3..9f753cb4f5f18 100644
> --- a/drivers/crypto/ccp/ccp-dmaengine.c
> +++ b/drivers/crypto/ccp/ccp-dmaengine.c
> @@ -641,6 +641,10 @@ static void ccp_dma_release(struct ccp_device *ccp)
>   	for (i = 0; i < ccp->cmd_q_count; i++) {
>   		chan = ccp->ccp_dma_chan + i;
>   		dma_chan = &chan->dma_chan;
> +
> +		if (dma_chan->client_count)
> +			dma_release_channel(dma_chan);
> +
>   		tasklet_kill(&chan->cleanup_tasklet);
>   		list_del_rcu(&dma_chan->device_node);
>   	}
> @@ -766,8 +770,8 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
>   	if (!dmaengine)
>   		return;
>   
> -	dma_async_device_unregister(dma_dev);
>   	ccp_dma_release(ccp);
> +	dma_async_device_unregister(dma_dev);
>   
>   	kmem_cache_destroy(ccp->dma_desc_cache);
>   	kmem_cache_destroy(ccp->dma_cmd_cache);
