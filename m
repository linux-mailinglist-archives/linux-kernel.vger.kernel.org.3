Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5714EFA36
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351439AbiDAS6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351435AbiDAS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:58:21 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A142C1820CB;
        Fri,  1 Apr 2022 11:56:30 -0700 (PDT)
Message-ID: <7bfa2e2e-b22d-7561-661b-41ef7714caf5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648839388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3k8fi4T311KT50tlpF6UO8/BI3+eJ+YR/Vc5gwSxgA=;
        b=j3QWdD8BpelClcotn9PxiOT7q9qwL9wa/pM1ZegEjEiSEprSrzMKZtvMjIxcH7F7KHvXe2
        kQZCsGmP3ViKpGmvPFax+Q16WuvUrO3Cq6xUavupSXb59dsSCeD8gMYvKe+3jdecLAxilF
        6R6Dad+1HoxZLXBFzrqVd2RdGbH2sWk=
Date:   Fri, 1 Apr 2022 21:56:26 +0300
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
In-Reply-To: <20220401120342.GC9545@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 15:03, Florian Westphal wrote:
> Vasily Averin <vasily.averin@linux.dev> wrote:
>> nft_*.c files whose NFT_EXPR_STATEFUL flag is set on need to
>> use __GFP_ACCOUNT flag for objects that are dynamically
>> allocated from the packet path.
>>
>> Such objects are allocated inside .init() or .clone() callbacks
>> of struct nft_expr_ops executed in task context while processing
>> netlink messages.
> 
> They can also be called from packet path.

>> @@ -214,7 +214,7 @@ static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src)
>>  	struct nft_connlimit *priv_dst = nft_expr_priv(dst);
>>  	struct nft_connlimit *priv_src = nft_expr_priv(src);
>>  
>> -	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC);
>> +	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC | __GFP_ACCOUNT);
> 
> This can be called from packet path, via nft_dynset.c.
> 
> nft_do_chain -> nft_dynset_eval -> nft_dynset_new ->
> nft_dynset_expr_setup -> nft_expr_clone -> src->ops->clone()
> 

Thank you, I noticed this case but did not understand that it is related to packet path.

>> @@ -235,7 +235,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
>>  
>>  	nft_counter_fetch(priv, &total);
>>  
>> -	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
>> +	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC | __GFP_ACCOUNT);
>>  	if (cpu_stats == NULL)
>>  		return -ENOMEM;
> 
> Same problem as connlimit, can be called from packet path.
> Basically all GFP_ATOMIC are suspicious.
> 
> Not sure how to resolve this, similar mechanics in iptables world (e.g.
> connlimit or SET target) don't use memcg accounting.
> 
> Perhaps for now resend with only the GFP_KERNEL parts converted?
> Those are safe.

It is safe for packet path too, _ACCOUNT allocation will not be able to find memcg
in case of "!in_task()" context.
On the other hand any additional checks on such path will affect performance.

Could you please estimate how often is this code used in the case of nft vs packet path?

If packet path is rare case I think we can keep current code as is.
If the opposite is the case, then I can add __GFP_ACCOUNT flag depending on in_task() check. 

Thank you,
	Vasily Averin
