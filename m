Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BD25A9A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiIAO1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiIAO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:27:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010A1128;
        Thu,  1 Sep 2022 07:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5GdupvA7/fBOkhdcscTMKDPyoXRKpglb/f0sGCa1bg3AAHghPbnFIGFT0XN9wrqBkiNw//7RXlkCDDWDnE19G6KHDj2BIp6hn0v4EwlLnkccNL0pO+dO8NMkZv3BIaZKiU8CQSvavgvAMTDEPeMthgfM+RbAmCqYJAayLfmardyeirII07DDgaSDJtfDZhPlhAtr6NWDDwtDNGGsugbgTLR0CpJxzW0KJjJH5yncQNcfVDYtLg3WtAV4qVO4sYCYA4ojCVcaNq8CvCHyCHfFl7izN8bflezfhBZ/Ug2QzrOr3BYcvyoE8gJ0/aNodeAdbJ2cXFn5d3QWMyG2HBXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzZ90INEMEiIBG2Gf0pzTUFzLi0sLbVEbd90+2+PRx4=;
 b=PN9JiA9Y8mhhyFRgZaMiXHVI0HHprClGri5keAGUZNBGD6mrotHZLrjFMveOPdYgJsnSOBzhqnhm1Cshq130Igr4qlVDxjH/sB/IgKoV/J7VKS8vmbsG4CHA0o7puFSk1fJGCJTWMhNkbYnZOooopVdcSXI7YMDoz8EzQ0JksXrM1Ff/b+M5B2BkghmTd2dol/D9sK7NVjyGRmxCvbT2b3jkVR+XQU3rtSWumT7L/uph9jgOtCFVRLLPsYCrntNeFUY4oSjY7BsMDar5H18UmA52+Xq+5d+zjHgjZu1RIajuJ0h7l8/Ue+E7WOQCocrjoY9r+MwLZCr9q4g6jVAAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzZ90INEMEiIBG2Gf0pzTUFzLi0sLbVEbd90+2+PRx4=;
 b=K+fB4eUzSPkLAiOH6IQHpH+CsCE6Y6pkW/Xhzt8WWLaFUm4bzNZbOK5KA4OzD9EbKIkbphi8FbYG1rrtFDef89bED/LTMRXzXANRLjLTTLCv6/MBfn3kM+eooJYnX3jVARySh+1jpZUoQbznXyaWyv0eRlji+kHQ+ATBjG2DkFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 14:27:28 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%6]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 14:27:28 +0000
Message-ID: <a3c7bbd2-d5d6-1e04-8d3e-1dca12e82369@amd.com>
Date:   Thu, 1 Sep 2022 09:27:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] crypto: ccp - Release dma channels before dmaengine
 unrgister
Content-Language: en-US
To:     Koba Ko <koba.ko@canonical.com>
Cc:     John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901021628.1130985-1-koba.ko@canonical.com>
 <a15ab3e6-249d-af48-b4d5-25840b72a933@amd.com>
 <CAJB-X+V-D0Es+5=KJQYdv6DKVK48jYzyU_4y6qvfY=H55y6oHQ@mail.gmail.com>
 <CAJB-X+V+ZTxKt_hs_jXYhPkKhbK0brqByo6H536BD=PJf4kH=A@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAJB-X+V+ZTxKt_hs_jXYhPkKhbK0brqByo6H536BD=PJf4kH=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5855c090-beb6-42bd-09d4-08da8c2618c8
X-MS-TrafficTypeDiagnostic: LV2PR12MB5992:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhD3uRSab4R+KBdyevINpgIM5c8oLnj68etqJ2es0JQnsWMDUCRSU3p2nNMgZ8Oy9b5CxRInVzZ0kWodx3Xg/lgV7ybbwAeY4hxPJEyCoTCLeDy1OA508urDzvSi1VGNnqNzNNbBaPJidSW3jNg8/x3a22O5BbKQE2AQGiELpQ6XWWq/qVlS9xsPY2G+HoDdQOrcXMHgiMDNHgti7FHczKgIiQpLu+nd6rD3PI/4IZeYQCPibDvGbhku9Dx7dk8DeMoiNwQmG1KXE9EpnekoNlgELTy3LS0Pg69/s5pdQ/e1fxbSXNDc7+0oLP/zUXbcQ+4CaQ5pORIQdBCAUB+EtTQhOrE0cbLhhXNS2VfXEe9LoNInugM3xNVPaM/ru8BcYlLbLNT5SY+n+pv5LqE1U8KlrdZ0edjGoOh7DOIqT4xn91BkUfWaRjtLJQZ8J9Ic0SX8g59HfivZSNCoo+zQlzq8A70ecCEEK6OQU3+e/MxIYwta4gkSaDidADj9qRY/WaazRhpTU26YSiCw48iDHadzRy4JMrRLh+/kt/Jpm5BUNAeEe9taxa3BGvAwR9vcO32YJd5GqhhpQEnVo1bULT0ezJz9YW/mWXt/vLtmf45yVpofmRnvZNGvGKxfiTwSF5B7JpuyjqXZtTtKNT8Qp3rDp/hUzo6LtbPAOm2adqU57jtilX+Uas0yqmlp8dUqSWSd8fIFaC/TRYdByKgtM/Yg3cLngm4oZusFI5igdHqMpCZRD/LzdSg0fQ2moqi4tySm4/usSr5do4S+20TvvRickekMctIdGTtqPWZ5Dko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(2616005)(2906002)(54906003)(5660300002)(66476007)(8936002)(6916009)(8676002)(66946007)(66556008)(4326008)(36756003)(316002)(31686004)(6486002)(478600001)(6506007)(6666004)(86362001)(53546011)(26005)(31696002)(6512007)(83380400001)(186003)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJaNW4xaFZUUVFqKzM5Y1F0RitERFQ5cU91eHF2TnFwd243SllQUzB2dU96?=
 =?utf-8?B?bi9DRXJGT3FRL00wM0lmK0V6MlNKbjIwamUvTXpqRDZZTHE5U0lZcEFMSUc1?=
 =?utf-8?B?VUx2dFUxNC9CNUlvQVVuekF0elVzN05KR0xOd21UWkc5VXZ4UTJxOURTYXF5?=
 =?utf-8?B?eGJmbnczYjNkN3Fid1VhVE9WVW5tS0pxOEJpOFJqY3o4bExJcXNLQlM1NmFO?=
 =?utf-8?B?TlNKeUIxSlJUd2ozbXZSdmRDUUlGdkJ6ZnJlck5yVUsxVUZEVWQrNGRGaFQx?=
 =?utf-8?B?Ujd6cUhFMnRXclpUeWhiZTJwUlNReFdUUUdHYzlmTDVyS0dSaGtNQnhPYmtn?=
 =?utf-8?B?R0xQVVJrdlVhSklOMzFJd1RtU0xJMW9JY3VZYU0rNTcxcHJId3pubTRjclhI?=
 =?utf-8?B?aHZsY0pKSllQd21BMmJJQXdIcmhhQnpRRHd5aDhMT3UzYVoyTlAwTmVjQkpI?=
 =?utf-8?B?TmVpdC91ZWQ0bWplYldrSHJnTDRiQUdqYzFRaGRYQXUxSDlwVXdMMnhKcUlq?=
 =?utf-8?B?QXdWY1ZOVU5nVkowUHFMdkYzaWlSbGFMZ1A0VkNnNGhHSzh3WXpvK3M5TEVu?=
 =?utf-8?B?VVpUdDdRcndyL1dxM0xmRlA2aXJqcVRPVzYxZGQzamYzNy9iSWg0WHRjYkF6?=
 =?utf-8?B?cmt1RzlGZDJqU3FuczZEUmU1cGtsWFZSTHQzZjVVRzArZXNlNWVtT3VmYlFm?=
 =?utf-8?B?NEMxZk9xRVJML01YYlMvbG9XQWlFU3dKZDFBY2c0NDFsNzVuK0w5b2hpNGNU?=
 =?utf-8?B?QWNtRm1FZi9RQ3A4YkNrejVjeVpOSG9tWW12UHdmUXFUSlRyYVY0OTJzWWw5?=
 =?utf-8?B?U1h4d3hoa0N0RVVWNTFHSzJaVnBzdWdUTWpjY3BRWndpV3IrV083dWg3M3lS?=
 =?utf-8?B?cUJHbU5mNnBtSUwxRDZaL2RQd0h4cmo0MmRDNVJybGRkaytiMmRLaFVDd2pq?=
 =?utf-8?B?ZmR0QkhlVG9NekpZRzF5NS9TclczUHRlVkszd2xXSFFOb29ROXFqUzdobzNy?=
 =?utf-8?B?Vmc1OWoyVW85aGRpT2lyVjd5V3g2dzd5ZFd2YW9FWnY0bFBCaEZmdkgrY2Fl?=
 =?utf-8?B?UGVlMzhjV0x6UVQ5YStDcjN6czNvc2wvdnlXeFhWcGlaODZTL09RSVNHMnJE?=
 =?utf-8?B?QXJuSDdMMWJBMy9SVklnYzlTVXdHZWxSRmp6WW16TTJPbDJPWHVTbllnZ0RH?=
 =?utf-8?B?a1VzeHA1T3RzV0tvRTFFNFdCTWVoZk5LQUhsLzJhYWFVU0dlSGoxMVhYcXoy?=
 =?utf-8?B?dVRJTVBQcHYxenQ1cXk5VEpDTHd5dnM5MjFXUnZVM1NWZFRYVVU0cWtmWEdY?=
 =?utf-8?B?UWRPVkt2cXk5T0p4aHJwMGs5RXZkblBhYkJTOWROMHRSN1Nyd2x6OXNnZCtO?=
 =?utf-8?B?Y1Y1Ynh0cFJ1YlFtRnRjamhZZm1pT3A3RldHNlRxSnBPbUJneXZhM2pNM2F6?=
 =?utf-8?B?V2VLL3VWeG52ZlFCRGxFanB3NXY1Y20ySjh4STlQS2N6VWRWazMyMTM2OFF1?=
 =?utf-8?B?Yk9iSEpISzRUZnF4WWRDWXQ0TzlIRE16NkRhU0VTaC9JdEl2L0todmF4VzVz?=
 =?utf-8?B?OUw3dGUvWEZmelRxa0J4bWxWMmNmTmJ4cXVmZmkrM0Qzd1JqTzBMdjdjZ3VO?=
 =?utf-8?B?Y2tYRThOUU1rZk9IQ25ST0RlYkN0WFpvZmdLaVpob2Vha3JydUd4ay9FSE5I?=
 =?utf-8?B?bW9yMDMvSnBOK0JLNHNhdCtYQzZNbjhzdUJnSEVhMVRXS3ZHSDZqa0lYL1pr?=
 =?utf-8?B?Ylphd1dLTkJCUi9tMHpjWWVleUsvVk10MkpndFMzWEVaaGo5UlFjNGlKdE00?=
 =?utf-8?B?WWozaE40ZFJGeElXY2xxRlA1V3BxZC9rSEpETXNURVZMUFpTcE5aS2tQVGY1?=
 =?utf-8?B?Q3BMb0NLL204bHlOV2tGQW11M09TRnlpTnJBc3dDUVNITml4eDl2bnNua0kx?=
 =?utf-8?B?Y2RjTE9idlFSdlJXUFQ0d29tZGRzU0Rqa2p2cGZNdlpYbDJRMXZNZEg2YnRx?=
 =?utf-8?B?L09RYm84eVRwaWQ0bGp2Y3NXTTFVRzRscVVIeXBoNDZlVkxDNkNnV21lbUYz?=
 =?utf-8?B?ZFJmTHhBZklRU0lidkp4ZFNqcW1NcE9XRnc0R1RVdjRGWHYzZ3R1blpBd0VB?=
 =?utf-8?Q?TU0lkWJIA8X8dlchW3BbBidJu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5855c090-beb6-42bd-09d4-08da8c2618c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 14:27:27.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XY/u+wJVVX5JyBBSBzOiFVkWECmABXHxTK93XdUk8ve9ZiciMppzdfRkfAxJ33GU8xQpShL0ua6iTp/oAsDTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 09:23, Koba Ko wrote:
> On Thu, Sep 1, 2022 at 9:57 PM Koba Ko <koba.ko@canonical.com> wrote:
>>
>> On Thu, Sep 1, 2022 at 9:42 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 8/31/22 21:16, Koba Ko wrote:
>>>> A warning is shown during shutdown,
>>>>
>>>> __dma_async_device_channel_unregister called while 2 clients hold a reference
>>>> WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110 __dma_async_device_channel_unregister+0xb7/0xc0
>>>>
>>>> Call dma_release_channel for occupied channles before dma_async_device_unregister.
>>>>
>>>> Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
>>>
>>> I can't find this Fixes: tag. I did find:
>>>
>>> 54cce8ecb925 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
>>>
>>> Not sure if Herbert can take care of that or if you'll need a v3.
>>
>> Sorry, it should be 54cce8ecb925("crypto: ccp -
>> ccp_dmaengine_unregister release dma channels")
>>
>>>
>>> With the change to the Fixes: tag
>>>
>>> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Should I add acked-by in V3 by myself? thanks

Yep.

Thanks,
Tom

> 
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: Koba Ko <koba.ko@canonical.com>
>>>> ---
>>>> V2: Fix the unused warning
>>>> ---
>>>>    drivers/crypto/ccp/ccp-dmaengine.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
>>>> index 7d4b4ad1db1f3..9f753cb4f5f18 100644
>>>> --- a/drivers/crypto/ccp/ccp-dmaengine.c
>>>> +++ b/drivers/crypto/ccp/ccp-dmaengine.c
>>>> @@ -641,6 +641,10 @@ static void ccp_dma_release(struct ccp_device *ccp)
>>>>        for (i = 0; i < ccp->cmd_q_count; i++) {
>>>>                chan = ccp->ccp_dma_chan + i;
>>>>                dma_chan = &chan->dma_chan;
>>>> +
>>>> +             if (dma_chan->client_count)
>>>> +                     dma_release_channel(dma_chan);
>>>> +
>>>>                tasklet_kill(&chan->cleanup_tasklet);
>>>>                list_del_rcu(&dma_chan->device_node);
>>>>        }
>>>> @@ -766,8 +770,8 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
>>>>        if (!dmaengine)
>>>>                return;
>>>>
>>>> -     dma_async_device_unregister(dma_dev);
>>>>        ccp_dma_release(ccp);
>>>> +     dma_async_device_unregister(dma_dev);
>>>>
>>>>        kmem_cache_destroy(ccp->dma_desc_cache);
>>>>        kmem_cache_destroy(ccp->dma_cmd_cache);
