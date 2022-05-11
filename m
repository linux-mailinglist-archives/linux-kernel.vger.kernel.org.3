Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B48522A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiEKCur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242384AbiEKCg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:36:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E662A12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:36:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so782697pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7t9UcsXwVYVSYCIK3NACYHQqA+B/CoJMpZoDVJt307g=;
        b=KIzyRIfP1t/fKgS5DVcd9/4E4DAVHgKfNtr3m35zCsC23uMy7PhbbdYcIKWT/PSVJN
         VWtl1q4ft/NYUAW9XiIweKWNtzi/KWkoHv5m+FV6AcbBAfuxHYeBoa/qNxdrZGw26qm8
         edNhDUV5knhAD7JWjsoejkliLyzX57R3cSN3XY6V3utrUbKK0jBcxygCmkGcf8BQvbb2
         mqY4IC5MzPy7ciF6dv8+NgThoNH7rb6U5mqybgajhhk6xad5JPVyP0T8UO9tgUx5ZUKc
         KP1zvGt9tXzbYTH+SxFYsaP4OrKyghb2Vtx7qZkHKBTQfPoon6Abjq2C+Qoj/dE43WNd
         ihmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7t9UcsXwVYVSYCIK3NACYHQqA+B/CoJMpZoDVJt307g=;
        b=mnRFDM9ZQLbxMOlAveaM3azk6sfft03uwWQZc6oY7DPVhvZQ4ZBvZrz4oBUggn+ToX
         X1MsjqKKXvnyhIqrcSZ8E65kn9vBaUyvQ5lpdn9ns8cM+eIsj1Q76in2Jh5GBtJUoSYF
         gRbL3QaTlwt8KApHCVmXaetDAmwy6xVCaaK4hp89f4ycydhbk8GtjXD/KIVusqp4r/Bt
         EbQvNJAfY9yJF4aZtYQ0szUJftGofaT1j++AG75dsDp6p/ECL+9Jbd4bEpfXiiILFj9t
         5qLlbdJXGkez0QQM7MTQAukMSJx6qtTMNUR5MAv8C9GArCcVfVM4lUvojk6w7dEAYmg1
         gjCg==
X-Gm-Message-State: AOAM5327xYso+qgHoLwLeR0ypwYi9Fl98bPwm2Ut2BNk4i+vUzdBxLxt
        y1L0zQGlH4bfdgOLXewrvd8oyg==
X-Google-Smtp-Source: ABdhPJxTh/LcvNMMEoQZO0pKwBDLiPRwF4uEXSoj63PgVF8fCV7RowiyCtUIUh92JHNPPEC3BNdtHg==
X-Received: by 2002:a63:505a:0:b0:3c6:d5d1:eb2 with SMTP id q26-20020a63505a000000b003c6d5d10eb2mr8148519pgl.122.1652236585505;
        Tue, 10 May 2022 19:36:25 -0700 (PDT)
Received: from [10.254.203.126] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902a50c00b0015e8d4eb2b7sm311852plq.257.2022.05.10.19.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 19:36:24 -0700 (PDT)
Message-ID: <ebb3c657-c914-7d71-c4c9-6e8fe2d2e0c0@bytedance.com>
Date:   Wed, 11 May 2022 10:36:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] mm: fix missing handler for __GFP_NOWARN
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
 <20220510115922.350a496ca8b91686c1758282@linux-foundation.org>
 <c44769b3-a132-63a5-fd40-4d483497dff2@bytedance.com>
 <20220510193215.14ed7e3fb70857738e10c0a2@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220510193215.14ed7e3fb70857738e10c0a2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/11 10:32 AM, Andrew Morton wrote:
> On Wed, 11 May 2022 10:19:48 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>
>> ,,,
>>>> --- a/mm/internal.h
>>>> +++ b/mm/internal.h
>>>> @@ -35,6 +35,17 @@ struct folio_batch;
>>>>    /* Do not use these with a slab allocator */
>>>>    #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
>>>>    
>>>> +#define WARN_ON_ONCE_GFP(cond, gfp)	({				\
>>>> +	static bool __section(".data.once") __warned;			\
>>>> +	int __ret_warn_once = !!(cond);					\
>>>> +									\
>>>> +	if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && !__warned)) { \
>>>> +		__warned = true;					\
>>>> +		WARN_ON(1);						\
>>>> +	}								\
>>>> +	unlikely(__ret_warn_once);					\
>>>> +})
>>>
>>> I don't think WARN_ON_ONCE_GFP is a good name for this.  But
>>> WARN_ON_ONCE_IF_NOT_GFP_NOWARN is too long :(
>>>
>>> WARN_ON_ONCE_NOWARN might be better.  No strong opinion here, really.
>>
>> I've thought about WARN_ON_ONCE_NOWARN, but I feel a little weird
>> putting 'WARN' and 'NOWARN' together, how about WARN_ON_ONCE_IF_ALLOWED?
> 
> I dunno.  WARN_ON_ONCE_GFP isn't too bad I suppose.  Add a comment over
> the definition explaining it?

OK, I will add a comment to it.

> 
>>>
>>>> @@ -4902,8 +4906,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>>>    	 * We also sanity check to catch abuse of atomic reserves being used by
>>>>    	 * callers that are not in atomic context.
>>>>    	 */
>>>> -	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
>>>> -				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
>>>> +	if (WARN_ON_ONCE_GFP((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
>>>> +				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM), gfp_mask))
>>>>    		gfp_mask &= ~__GFP_ATOMIC;
>>>>    
>>>>    retry_cpuset:
>>>
>>> I dropped this hunk - Neil's "mm: discard __GFP_ATOMIC"
>>> (https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name)
>>> deleted this code.
>>>
>>
>> This series is based on v5.18-rc5, I will rebase it to the latest next
>> branch and check if there are any missing WARN_ON_ONCEs that are not
>> being handled.
> 
> Against git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm branch
> mm-unstable, please.  That ends up in linux-next, with a delay.

OK, will do.

-- 
Thanks,
Qi
