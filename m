Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B044A911B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355969AbiBCXVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBCXV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:21:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B93C061714;
        Thu,  3 Feb 2022 15:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cUD7tLHcV6IQh2o2twU3Pkvh/VRccN5GmyjQGBHH8gg=; b=j1hcRYjsbe7oRcBGHgM831q9BS
        g5Kwi6MjCaAlAn+ZuetCnbRFamGfQaj/eT6TDqaLll/f5dFfphrUtZr1tLg/GxuRC7MyVyDEKtmPz
        ynTuxtfVulgVc1D3i8ft92FbL481k1OFD72xbi77SU/Hk0lIXyyRSqf9Jytejx0Ss/mhUg7WR/n4Z
        75LmXHxjhXpuDSTZ6kHcEk1LT1/9+n3ih6bBnj1Oa7MKmv4BXNQDF+ypAI+k5d7zyh/kruU3MrmrR
        9xnrKYGhuv1Sx0h3pieinb1B/R2+kvPKuLleLz5Jo8P1KB8DoDx6bItLqfVcxkSCyGNZghb63Ef2P
        z3TZ/nJw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFlPf-006f0z-KZ; Thu, 03 Feb 2022 23:21:17 +0000
Message-ID: <3ff7c232-ebf7-9e70-cdc4-b8c96945152f@infradead.org>
Date:   Thu, 3 Feb 2022 15:21:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Huang Ying <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220202145437.2dd20b71@canb.auug.org.au>
 <20220203150645.9e41e470422eed26d4d77790@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220203150645.9e41e470422eed26d4d77790@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/22 15:06, Andrew Morton wrote:
> On Wed, 2 Feb 2022 14:54:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Hi all,
>>
>> After merging the akpm-current tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/admin-guide/sysctl/kernel.rst:603: WARNING: Malformed table.
>> Text in column margin in table line 2.
>>
>> = =================================
>> 0x0 NUMA_BALANCING_DISABLED
>> 0x1 NUMA_BALANCING_NORMAL
>> 0x2 NUMA_BALANCING_MEMORY_TIERING
>> = =================================
>>
>> Introduced by commit
>>
>>   49ec6eb41c49 ("NUMA balancing: optimize page placement for memory tiering system")
> 
> I assume this fixes?  (With gratuitous grammar fixes)
> 

Looks good.

 --- a/Documentation/admin-guide/sysctl/kernel.rst~numa-balancing-optimize-page-placement-for-memory-tiering-system-fix
> +++ a/Documentation/admin-guide/sysctl/kernel.rst
> @@ -595,14 +595,14 @@ Documentation/admin-guide/kernel-paramet
>  numa_balancing
>  ==============
>  
> -Enables/disables and configure automatic page fault based NUMA memory
> -balancing.  Memory is moved automatically to nodes that access it
> -often.  The value to set can be the result to OR the following,
> +Enables/disables and configures automatic page fault based NUMA memory
> +balancing.  Memory is moved automatically to nodes that access it often. 
> +The value to set can be the result of ORing the following,

except for that ending comma...

>  
>  = =================================
> -0x0 NUMA_BALANCING_DISABLED
> -0x1 NUMA_BALANCING_NORMAL
> -0x2 NUMA_BALANCING_MEMORY_TIERING
> +0 NUMA_BALANCING_DISABLED
> +1 NUMA_BALANCING_NORMAL
> +2 NUMA_BALANCING_MEMORY_TIERING
>  = =================================
>  
>  Or NUMA_BALANCING_NORMAL to optimize page placement among different
> _
> 

Thanks.
-- 
~Randy
