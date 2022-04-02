Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4FD4EFFD5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbiDBI5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiDBI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:57:44 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15000433A8;
        Sat,  2 Apr 2022 01:55:52 -0700 (PDT)
Message-ID: <935e4270-9e0e-4cd0-ffb4-9c1eb3d9c56e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648889751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jh4/4xiwAVxeKjatqqkOpOkkbT7wiLHO6bvLmoySlOg=;
        b=C+zNbHQKFMqvwKujcRLfBSHytPHteB/e6JbnV8hKMSBKdGQSrE6cmqxY4Z6TeDk+Ci7kf6
        Uys76ccGYm04plbhiiqaOgWh6I483lj8XrCEveuGm7eCjjqTIU1hBZWURlHZudFQCoakNo
        vrVpEHK1bLLh2udEtDv4gOthP2gVT7I=
Date:   Sat, 2 Apr 2022 11:55:49 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH nft] nft: memcg accounting for dynamically allocated
 objects
Content-Language: en-US
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, kernel@openvz.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
 <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
 <20220401120342.GC9545@breakpoint.cc>
 <7bfa2e2e-b22d-7561-661b-41ef7714caf5@linux.dev>
 <20220401193159.GB28321@breakpoint.cc>
In-Reply-To: <20220401193159.GB28321@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 22:31, Florian Westphal wrote:
> Vasily Averin <vasily.averin@linux.dev> wrote:
>>> Same problem as connlimit, can be called from packet path.
>>> Basically all GFP_ATOMIC are suspicious.
>>>
>>> Not sure how to resolve this, similar mechanics in iptables world (e.g.
>>> connlimit or SET target) don't use memcg accounting.
>>>
>>> Perhaps for now resend with only the GFP_KERNEL parts converted?
>>> Those are safe.
>>
>> It is safe for packet path too, _ACCOUNT allocation will not be able to find memcg
>> in case of "!in_task()" context.
>> On the other hand any additional checks on such path will affect performance.
> 
> I'm not sure this works with ksoftirqd serving network stack?

Please take look at memcg_kmem_bypass() called from 
memcg_slab_pre_alloc_hook -> get_obj_cgroup_from_current

By default memcg accounting does not work for any kernel threads.
If required thread can use set_active_memcg() but at present it is not widely used.

>> Could you please estimate how often is this code used in the case of nft vs packet path?
> 
> It depends on user configuration.
> Update from packet path is used for things like port knocking or other
> dyanamic filter lists, or somehing like Limiting connections to x-per-address/subnet and so on.

Ok, I think we can skip accounting in such cases at the moment.
I doubt it can be misused and consume significant piece of host memory.
So I'm going to resend the patch w/o accounting in all .clone callbacks. 

>> If the opposite is the case, then I can add __GFP_ACCOUNT flag depending on in_task() check.
> 
> But what task/memcg is used for the accounting in that case?

Thanks to Roman for the explanation in concurrent thread.

Thank you,
	Vasily Averin
