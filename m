Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252205A7E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiHaMyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiHaMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:54:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E6AB19A;
        Wed, 31 Aug 2022 05:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr4EBgustvDDcIqqu3RR8sLl3ztjVUl4zP2/uL9j+4kAM5xZVfc0kB5hL371Y0LkejXfB+I2QTsZCufP0gx3XwJ0xPrI9gFZjEl2ivlgrtIt3CSTbqGvHWS5ihGvHCmtmpPJGDIpLNw6wu5mUntdx2dz2+nZqOs7duPsTBw+n4yFWn1ry9UsGc8kTuAhyb5/GTl0Xki5W39bvVZhtVq6hA6053QoCJ4ohnHTtX//bw/KuWG2uDkWmCCg2dNAxT6oBIEhjmhowt9qUVbUcA3JFzo61sK+rCIZrE/zAA8R5Bup4fPhDQvHmPOYbZjWhTAbeXyYgkg9imo/sLg6vk7rTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfq/vvgrhMkUahgo3BybGDKQ4QQPrRyYTYag62nl+NI=;
 b=JTQ/PPewM4FB1OYGnpwFT0Rh0hEEDdvN3XbLqShM+18sA8w4bM6yxsyu/xhcjw3FjDnzHz1XQhNXQr5xJYzX0PgQg7Mi8QyQl10Ygg+YrJsRAZCecKFKSQXQ8+VRQPj2ddUrbQs2NnTOUU8YvI/q8ahIH5V0OhwMAlnJIwdMMBqND93Bl3ZtbF7ldifbkZEPJ0U2QUmswfKyDuvECQq2NgBYLLI4v84BHnmtKPuJvawS+70B1JClclHjB56Ks9sLego0ZBEcBruXTSkkrftcw6b3ZXufWl97SHYszewSv1BaSn8MirVqd8BsACVyel0aCihg4HsE2BAEWdoEOFog9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfq/vvgrhMkUahgo3BybGDKQ4QQPrRyYTYag62nl+NI=;
 b=Lmomuhx3ABaK2epE+bLz0V1z24eiYkItrDUqYtyobnrMUuN0ui+I+Rhtz5AwTbDmE1/oSJsfQxWH0MNTEG9ncc5VNEj/Q9IkRxQ9ptg2Ng8xKYLGRKW/m+T+emqhopIIV6pIWy2/42BhV1AayTC5a2GHv+jKWRTeM0A+JQuGhKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 12:54:04 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 12:54:04 +0000
Message-ID: <d5d1785d-b2a8-6913-78ba-d686d70f2a64@amd.com>
Date:   Wed, 31 Aug 2022 07:54:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: crypto: ccp - Release dma channels before dmaengine unrgister
Content-Language: en-US
To:     Koba Ko <koba.ko@canonical.com>
Cc:     John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220830093439.951960-1-koba.ko@canonical.com>
 <c3ea3992-df42-3a26-6d30-834368faf91c@amd.com>
 <CAJB-X+XMHYyQJLLuC24rAvQwNOOZUdMBhh12RC9UTOSCrCa=HA@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAJB-X+XMHYyQJLLuC24rAvQwNOOZUdMBhh12RC9UTOSCrCa=HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a650602-5ddf-461a-f23b-08da8b4fe267
X-MS-TrafficTypeDiagnostic: SA1PR12MB6680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QPNMl0pRTaXftSZg4/Ap0vgudU5sN0RC+n2PVE+RIZ1Vyo2H+3LEE8NQWuijDsPtbcBhwwyr+T1L0yS1yxsrFQcl1p41IrAHMnpA9XW9JZ+8zgMTzW8qxad9D2DVITP5+9Pz/xKw7Fy9oi3R+xjpN208hlMzQMWnWrQCHWctbM8aHwUTHVGfqQG3+UHakTNbPmTfXLc76aVMQ4ntKGE4epjqEmJV4mgDn07THBRcbpaww699TI4AZFjVC+EwNSBt1hVd3G0qUdoz6nt7rl9uEawVH3eBfNGpS+WIKuA1o+kz9bWNayX4rlU8x1qWo9rL09x2BHFIDgPER20CJfvHPlheSNNnVTYDZbWhx85pjSLN9XppTA9t5Lc/Lgw+QYrPu/bZUqUYchtqqlHZcPl8B7AIlKmmIBXF5meBp1AEO4pvs917BYhL8S2ZKimCvVI4aGe6An6vxxcS3r/BSqZgVFnWcIQJWfkb9wcnyurqRa4MVmDHJwWVwsq+XztRelB5c/eFiFCRJHhypCsr7oxx9ZkPdNa6nDtIYulRteAJmnf9gHcYurl97B8CCHbOItEuBwXO4eAzVhlqDDw7hBrrnXep/DTA16YauVaIWw1YktYdC8vDOVkarxZMt5nnaxXA/AgsdXSt6MPNZCh0GIQpabAAOSYm/RZOcwOsfnCpMRhqTPeIS+HMb620a8PVtbudPbNpM7vvhGLg0FjGCPZ9XBtpde5/IIEzox53Reyb47qKLU7OrNO+S6CgNzUx8idpjttSp5fzdSyouKrNZJlVfg1GzFy0hWYP47b0CkWdMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(6916009)(54906003)(38100700002)(36756003)(31686004)(316002)(53546011)(26005)(2906002)(6512007)(4326008)(8676002)(66556008)(6486002)(478600001)(31696002)(66946007)(5660300002)(86362001)(66476007)(186003)(2616005)(6506007)(41300700001)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEVnN01KYzZVMWtBR0lsQzZlZTFQR2MvZjJML2doWlBlamh6RStML2V5OW9F?=
 =?utf-8?B?MEY4M1I4azJHdTlmK1dUY1J3Nll1Tk52cXdwTlN3aWlzaGp3UVloZHFtOHc5?=
 =?utf-8?B?NnN2Q0t3OGRYM1RFNGVuSkdDYTBuWjVQWW1SakF1QzJlMEVETGdmUWxVTGxi?=
 =?utf-8?B?V0hua1d1SHFmOG12bEQrMVkwR2NFSFNFeE5WSlRQZXFKWWJXcXNlQ0NnQ3pR?=
 =?utf-8?B?UVZORnVhQkZUOWtlajVkeGNkUU1GQ0JrVWxVbUIxejBCMzFMUzlaQ1dycENC?=
 =?utf-8?B?L1o0ZzBkeDJyY2VaUE9VaUt6SzMwSDRoUzJYUXpTa3RkbTdyT0NWTWFiVWY0?=
 =?utf-8?B?aWpHSkNZTEtuRWp0UHNza2dFNFJKaU91THczNG1QM1BISFJpQ2NGRzFjVFVs?=
 =?utf-8?B?YTQvbXZOMzV2RlN5Y09oM1ZrSzlvd1NYTFVWL0p3cW85RkJiczl1QUswU3BQ?=
 =?utf-8?B?TmRsZllvODFvZEluMThCRTNuMFY2THJqdEJOclpiTE9wWkZjakN5UDIyRHZ2?=
 =?utf-8?B?Qk5WZk1QZU0xQ2dKeWZSRHQ5ak9tcnVQOG5HNFFDZ09xcVhzYStwTnpjd3VZ?=
 =?utf-8?B?d3U0eVZlekhYVEtZZWh2ZFcrbWhnS3NMQVJmc3BBV3A2eklEQlYya0tEMytk?=
 =?utf-8?B?L1Jyb1Budmcwc3F4V3ZpeDFTbGg4bTVCV0tDQXh1MmdGdkVUZTFSTmpIUmV1?=
 =?utf-8?B?dHAzOFdmU1RaR0JKREtuRFNBK0FrK1ZHeUJsVXEyRGREQzVZSm5QdEpmMW1O?=
 =?utf-8?B?VytSRmZtalBKU1p5cUpMaVB5U1puQVZUbFQ3dTNSazFjUzFnbFN5d3RpRkVu?=
 =?utf-8?B?NTJlRmoyZWRoV0dtUWttbVBXd0tBdDIzTGsxWFZKMjNqQkMwYjBiaWRxazB5?=
 =?utf-8?B?dk5lS2ttS2hzcVBuTUNYVWFIYVJ2Z2lnNmVOUitZWkZqTkNaVFUxWjRUVXFt?=
 =?utf-8?B?aVFKWG1CdG5WZUxrSHZtbVdTMHVIQ1JpVmhBTEpEZlJiYUkzaWxNMTlWMEh2?=
 =?utf-8?B?YU05UzlNa3pCWXdXbXJtVnpXS3JwZWd1eExkVzVMS1Q4QWpwZ0Rnd2c5UEp3?=
 =?utf-8?B?Qk1zQm5PanlMaUF4cmdObkM0eEFwdlpuMWpIMytvWFV5MzNMbnZkREpCZ1Vm?=
 =?utf-8?B?MVJWcTBMeHpYOFlwdXh3bTFYc0QvbTdiNnArNGt1WXJWSGRZaVViSTZnQ2h3?=
 =?utf-8?B?OU5BeWlxL3VyTjkzNEZyMTRmb1BoemcxU0t1T3krZUEwVU9zMmhOVmNQRW5l?=
 =?utf-8?B?SWs3b2RsVDQyVFpZRzVlK2Rwd0FwcU5xMDJibHpnS015clUzZ2tOQUthL3FU?=
 =?utf-8?B?VWF4eklsYjZnL1I2a0RmdUlHZ3drS1lDL0lJWm1PRERGUTJBR2FlYmRRTTZh?=
 =?utf-8?B?LzcrRDU4SlJwUjArcDd5UjIvSmVqN3hYNmdaRHZNQWpyLzNlbitROVlWeG9s?=
 =?utf-8?B?WUtYdDRlL2FTd1VUUWNCcHQ5WDUwejAwN2xVejZiUEhCdFZQbkh1Njl2UXRI?=
 =?utf-8?B?dnNqZ1NlQmZySTc1a01icmdWYURKc0E3WS9vOHVxY0w1dVJxQ2FqR3grbXli?=
 =?utf-8?B?WHRXZjdubVMvSllOTUtLOTFNdkxFa0hiOTVsR0k4aU1pa1VxdTlEVng4TVdT?=
 =?utf-8?B?bGdzS09XZm90RTlsT1QyYkc1ZDFaVjhtYndQRFFrK0N6NWpYSFdRYTJML3Yz?=
 =?utf-8?B?ejA3RTFLMStyVGVKWEtYeDZmbElEcVhtb0hicWZhSHpCRGZScUdHR3lYNGlm?=
 =?utf-8?B?b3ZSWVU0UUlSVXBpVGxvOGl1THMwa2tTUDRNeHU2ZHAwbW5BVlV1QUN1WW9Y?=
 =?utf-8?B?aTYyM2wzcWk5OXJWa1l3YTVVQmhLaXcxaTMycDFqOFlCUXlobzRUVlFLK1FN?=
 =?utf-8?B?UVNmdXIyWXExM3k5aHQway9tTWptNStSYnFyaFg1UFR5Mm1uK1ltMGtVYTlu?=
 =?utf-8?B?NjZqN01lbHlqNlZJQ0huSDZ5T282SXkyT3FSTU5OYjA0N3NkblpucjM3WERq?=
 =?utf-8?B?M0p6Y0pLL3VHMittNWVHenBValRmWUd5empGWUI0WkdQY3NPN2NkSkVmR1Zl?=
 =?utf-8?B?ZWN5aTloSGZFbVowNzcyQ2ZtdXRkUWRrcnhWTVFJU0dCV0swNDQwaklrU2NU?=
 =?utf-8?Q?5ZKa6yeoCVq61dxPqZ/7ME+Oz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a650602-5ddf-461a-f23b-08da8b4fe267
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 12:54:04.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UB0tWowtsIuAocfQ8GfuNP2znfMZi3WkzgEdiAgAb/2k4xMa0e6RX+6XfdRVShihnUU2u/poSWXaQWOYNgKNbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 00:39, Koba Ko wrote:
> On Tue, Aug 30, 2022 at 11:32 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 8/30/22 04:34, Koba Ko wrote:
>>> A warning is shown during shutdown,
>>>
>>> __dma_async_device_channel_unregister called while 2 clients hold a reference
>>> WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110
>>> __dma_async_device_channel_unregister
>>>
>>> Call dma_release_channel for occupied channles
>>> before dma_async_device_unregister.
>>>
>>> Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
>>> Signed-off-by: Koba Ko <koba.ko@canonical.com>
>>> ---
>>>    drivers/crypto/ccp/ccp-dmaengine.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
>>> index 7d4b4ad1db1f3..ba3eb1ac3b55d 100644
>>> --- a/drivers/crypto/ccp/ccp-dmaengine.c
>>> +++ b/drivers/crypto/ccp/ccp-dmaengine.c
>>> @@ -641,6 +641,10 @@ static void ccp_dma_release(struct ccp_device *ccp)
>>>        for (i = 0; i < ccp->cmd_q_count; i++) {
>>>                chan = ccp->ccp_dma_chan + i;
>>>                dma_chan = &chan->dma_chan;
>>> +
>>> +             if (dma_chan->client_count)
>>> +                     dma_release_channel(dma_chan);
>>> +
>>>                tasklet_kill(&chan->cleanup_tasklet);
>>>                list_del_rcu(&dma_chan->device_node);
>>>        }
>>> @@ -762,12 +766,14 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
>>>    void ccp_dmaengine_unregister(struct ccp_device *ccp)
>>>    {
>>>        struct dma_device *dma_dev = &ccp->dma_dev;
>>> +     struct dma_chan *dma_chan;
>>> +     unsigned int i;
>>>
>>>        if (!dmaengine)
>>>                return;
>>>
>>> -     dma_async_device_unregister(dma_dev);
>>>        ccp_dma_release(ccp);
>>> +     dma_async_device_unregister(dma_dev);
>>
>> Seems the right way to get rid of the warn, but can there still be a race
>> where the channel is grabbed again after ccp_dma_release() and before
>> dma_async_device_unregister() is called?
> 
> After tracing the ccp driver,
> dma_device is held by the ccp device.
> the only function called ccp_dmaengine_register is ccp5_init/ccp_init,
> ccp_dma_release is called in ccp_dmaengine_unregister/ccp_dmaengine_register,
> so there's no race condition in current codes.

I'm referring to some other piece of software claiming the channel, like 
the raid driver or the AMD NTB driver. This just seems racy to me, but it 
does address the WARNing.

Clean up the kernel test robot complaints and submit a v2.

Thanks,
Tom

> 
> 
>>
>> Thanks,
>> Tom
>>
>>>
>>>        kmem_cache_destroy(ccp->dma_desc_cache);
>>>        kmem_cache_destroy(ccp->dma_cmd_cache);
