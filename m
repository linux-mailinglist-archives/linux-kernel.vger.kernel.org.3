Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4118752298B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbiEKCUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbiEKCT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:19:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A61F68F9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:19:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 31so542908pgp.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aIcSWreA+W0fIvQF/lKPGeaT+AYkn45ShR5b36w2q9o=;
        b=5/Lld5QMG+BiecKOlFA0wMezCYTbJ4Q/Gr1IDeFcKOgwH72fHR/jtrHCNGGMByZica
         LNS+OwfFslOxBaD726ya9nFnMOyGhUZBx/gHhRrRs8LHcaVctkHJOnukBmNOADOQO0+Q
         70dYgeXJ4F+cZ63RkvgS+xoV1jHAV5GCpiKIDz524T6jZfyKpEaXLlVVppELH0BwmFiu
         gEtI/8m0ldv/cso79j5SnOM6uZ3oy7YmlgAnC7mVCcM7jpqtjVaFuKQjpa5QD/MNV/YP
         KwD94fE0OA0ycX8EtoMtYCywvZX4w5sTdXxer+u6+FUVFTCi5WgJokQi5s9uq2OEk5A4
         kdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aIcSWreA+W0fIvQF/lKPGeaT+AYkn45ShR5b36w2q9o=;
        b=KaNQfxDwa+b31k+do32LnYjqOqs1KvcI2vUicPkU68pZnBxTKAJLgnaaXq8OGu2Rnk
         bVUWv4a0rdR/rYpMnM2XRlvLb1KvXJJ63DNf3ZamedKCDlbeLzQGh/bf2lCHsj64QKqR
         9wZcGcFxBsz0mvAmpPKe7pNSjgryn4h0VW3k7Wq35Ict0ifv+nVuNm7g3tdcorn2Pp6Y
         3z9jZXrLRki6zvgBJc6Wh2AtLP9rQv5vrSodEfzmKj0WZ9J6de6GdSzmmHq4dbHSFYKn
         PiuG1TDLz8c7LaOyGfWasO2yoiBJwUG1s4NYLLgEQ43/r6HNbEMGWToilKl+e/U5/fHf
         AEBg==
X-Gm-Message-State: AOAM5306V+Lozh8tTw6AJJpaEY4/xlbk+GHPRkYQNBjzoZdlPDPcoIC8
        w2ZI70RvVf0PjMoWJRvJCi+WzQ==
X-Google-Smtp-Source: ABdhPJzsT4kywaSzyEnClAPCSvzS5a9FdNsQR+tCDLD/YGZINPYPEdTQS9hI6/siAiDs/tS2I1v38A==
X-Received: by 2002:a63:197:0:b0:3aa:9c7a:b269 with SMTP id 145-20020a630197000000b003aa9c7ab269mr18813125pgb.158.1652235594538;
        Tue, 10 May 2022 19:19:54 -0700 (PDT)
Received: from [10.254.203.126] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id a20-20020a63e414000000b003c14af50617sm407288pgi.47.2022.05.10.19.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 19:19:54 -0700 (PDT)
Message-ID: <c44769b3-a132-63a5-fd40-4d483497dff2@bytedance.com>
Date:   Wed, 11 May 2022 10:19:48 +0800
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220510115922.350a496ca8b91686c1758282@linux-foundation.org>
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



On 2022/5/11 2:59 AM, Andrew Morton wrote:
> On Tue, 10 May 2022 19:38:08 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> We expect no warnings to be issued when we specify __GFP_NOWARN, but
>> currently in paths like alloc_pages() and kmalloc(), there are still
>> some warnings printed, fix it.
> 
> Looks sane to me.
> 
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -35,6 +35,17 @@ struct folio_batch;
>>   /* Do not use these with a slab allocator */
>>   #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
>>   
>> +#define WARN_ON_ONCE_GFP(cond, gfp)	({				\
>> +	static bool __section(".data.once") __warned;			\
>> +	int __ret_warn_once = !!(cond);					\
>> +									\
>> +	if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && !__warned)) { \
>> +		__warned = true;					\
>> +		WARN_ON(1);						\
>> +	}								\
>> +	unlikely(__ret_warn_once);					\
>> +})
> 
> I don't think WARN_ON_ONCE_GFP is a good name for this.  But
> WARN_ON_ONCE_IF_NOT_GFP_NOWARN is too long :(
> 
> WARN_ON_ONCE_NOWARN might be better.  No strong opinion here, really.

I've thought about WARN_ON_ONCE_NOWARN, but I feel a little weird 
putting 'WARN' and 'NOWARN' together, how about WARN_ON_ONCE_IF_ALLOWED?

> 
>> @@ -4902,8 +4906,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>   	 * We also sanity check to catch abuse of atomic reserves being used by
>>   	 * callers that are not in atomic context.
>>   	 */
>> -	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
>> -				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
>> +	if (WARN_ON_ONCE_GFP((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
>> +				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM), gfp_mask))
>>   		gfp_mask &= ~__GFP_ATOMIC;
>>   
>>   retry_cpuset:
> 
> I dropped this hunk - Neil's "mm: discard __GFP_ATOMIC"
> (https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name)
> deleted this code.
> 

This series is based on v5.18-rc5, I will rebase it to the latest next
branch and check if there are any missing WARN_ON_ONCEs that are not
being handled.

Thanks,
Qi

-- 
Thanks,
Qi
