Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB64EC677
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346828AbiC3O03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245102AbiC3O0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:26:24 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9252B27F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:24:38 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1nZZFU-0004Nk-HQ; Thu, 31 Mar 2022 00:24:36 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kEnTz9AB7j594d5zirVLoMS5a5W3p3Vab2t0y5WVYfs=; b=LMZmUbV0pDHHcVPCZfEwhogPN2
        JHPGSVulOHcyBWzilCjDf38r4qukc422I5Aqw6qvIqTub9tJBQWwr5b2lrZoFiIPYj9IwJpp4gx35
        0Ij0tap/RXSimDNAeuR894rDAEDqsNAupnxuxg3LnKWKQsfu30hj1MP1ejYXWsLwYRGY=;
Message-ID: <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
Date:   Wed, 30 Mar 2022 22:24:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
Content-Language: en-US
In-Reply-To: <YkRebADER3J9ooPM@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/3/22 21:43, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Mar 30, 2022 at 09:19:52PM +0800, Brad Campbell wrote:
>> Hey Mika,
>>
>> On 30/3/22 18:18, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Tue, Mar 29, 2022 at 10:06:35PM +0800, Brad Campbell wrote:
>>>>> Indeed, I did not add this to the "discovery" path yet.
>>>>>
>>>>> I wonder what happens if you change this:
>>>>>
>>>>> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
>>>>> +                                   first ? 0 : 1);
>>>>>
>>>>> to this in your tree:
>>>>>
>>>>> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
>>>>> +                                   first ? 1 : 0);
>>>>>
>>>>
>>>> Here's where it gets all "Apple..y". On the iMac this does the job no matter which
>>>> port the chain is plugged into. Boots and displays correctly first time, every time.
>>>>
>>>> It turns out on the laptop, one port works and the other doesn't. Changing the order
>>>> simply changes which port works. So I assume the EFI sets up the first display using
>>>> the first lane if it's in the first port, and the second if it's in the second.
>>>>
>>>> That means had I managed to perform the first test in the "other port" consistently,
>>>> it would have worked there also.
>>>
>>> Can you try the below patch too? I hard-code the lane based on the
>>> DP adapter number in TBT gen1.
>>>
>>> Let's first figure out proper solution to this issue and then look at
>>> the other one.
>>>
>>> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
>>> index a473cc7d9a8d..97d36a7bb527 100644
>>> --- a/drivers/thunderbolt/tunnel.c
>>> +++ b/drivers/thunderbolt/tunnel.c
>>> @@ -865,6 +865,7 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
>>
>> This one works from cold boot on both machines regardless of the port the chain is plugged into.
>> It fails on both machines on any hotplug with the symptoms of allocating them both the same link.
>> I added an extra debug into tunnel.c and verified that.
> 
> Hm, okay. What if you change this:
> 
>   link_nr = in->port == 11 ? 1 : 0;
> 
> to this
> 
>   link_nr = in->port == 11 ? 0 : 1;
> 
> Please also keep the debugging you added too so we can see if it now
> uses both lanes.
> 

Nope, that did the same thing. I wonder though. I'm testing it on the laptop and that reports :
[    0.442832] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)

Changing "if (in->sw->generation == 1)" to "if (in->sw->generation == 2)" on the laptop solves that.

I can't test hotplug properly on the iMac due to the radeon training issue.

The laptop still has the issue of a cold boot working in one socket and not the other, but hot plug is working correctly.

Regards,
Brad
