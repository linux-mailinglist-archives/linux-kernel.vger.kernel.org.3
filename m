Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4AA530831
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiEWEDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiEWEDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:03:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF2637B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:03:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u23so23458839lfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bW8c38TBHTmvyMlXrqCJyQD8PokjGer3+J4297zdGvw=;
        b=mcaThTE5dBITBMOf1I3i4Cl2+VlmZiPovGLxnCuy5cWkgcunGL7C/YxSF0y6DggkXv
         R0uVzqeGidlnUs7ovAgpLar5Iu8ez3btY9/fbIDvmLRJHG8X1K6W+rp9vYVPwmgpwcwI
         UPbSkzH/KoX2ArYCODZl8ct5UU+oojXM0wIEvlfRYCYqUqhRltTtgguRYvpEIDvND1g6
         sch/HcigSO1OuIruiaxkxpgiJ1eQJi9idVtVIWYemUE8jugwPxHNGf8fumqbIxL+I+hT
         NnouJ1Xwi1pCkLBA8r7gL/5k729DtAssUzqQKqXOdmQjx42wHjPJl0hrxzGs1DsJD8e/
         Y8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bW8c38TBHTmvyMlXrqCJyQD8PokjGer3+J4297zdGvw=;
        b=U+s6I1e7JHT0Bvb4FXdIX/4fDBX/9/8s8iq6KgctLDhyO6KQ+SDitw9GeBqsUY3bjA
         PA4ke7QFiYtJvdhiwPsqnRzHqyug6q4MPM8LIkRd6lK+nKOOSOe0SmzVyIZtpe34h1pg
         ntqirWkf59Q/oqsch9/7ZCSdqb5xzTB9X0O4SDeTY4bgOSh8YRlaDFQhIzvRg4qJOwOP
         EXpcIxrcG1uee6yEOZrE/CJO1wGPzQXlZtD1gxdOO3EwgNcgey93GWlUxD4C2A2rshj2
         HAwyMgOpsuHupNEnfFdQ1Qvon3TuQBeoulCg+/Oc4TWdZ6Su0Tc2HZ15OXcUK2r+D0vB
         dZAA==
X-Gm-Message-State: AOAM533eH5vabe+UiGd4R36nCkgAIj8I+cQC2b+L1oO0WcHBcKG3MRXp
        m0yH5mq1uvd3ZFKabzE2S/N08w==
X-Google-Smtp-Source: ABdhPJzIdI/x9LBEDi6uVpcUNQbRCydpymBuic4N4Er1ZRdfASJDu7LBkXgCVuun8mCeH9K6wUW/JQ==
X-Received: by 2002:a19:6516:0:b0:477:c159:e6b5 with SMTP id z22-20020a196516000000b00477c159e6b5mr15395297lfb.615.1653278617345;
        Sun, 22 May 2022 21:03:37 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id z4-20020a195044000000b0047844f5301asm1382188lfj.290.2022.05.22.21.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 21:03:37 -0700 (PDT)
Message-ID: <100d8ba9-80e4-4ba8-0568-a77f0dbd4f78@openvz.org>
Date:   Mon, 23 May 2022 07:03:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
 <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
 <YomzXwN9rvCGAZJ0@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org>
 <20220522160943.5e5950e0@gandalf.local.home>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220522160943.5e5950e0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 23:09, Steven Rostedt wrote:
> On Sun, 22 May 2022 07:33:08 +0300
> Vasily Averin <vvs@openvz.org> wrote:
> 
>>> slab_flags=SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT|SLAB_STORE_USER
>>> instead of just printing 'accounted=true/false'. This patch is too
>>> specific to SLAB_ACCOUNT.  
>>
>> Any extra output degrades performance.
>> For my task it's not important to know SLAB flags, I just need to understand,
>> is current allocation accounted or not.
> 
> If you do save the flags in the event, you can report that on output with
> the __print_flags() macro:
> 
>  TP_fast_assign(
> 	[..]
> 	__entry->sflags = s ? s->flags;
> 	[..]
>  )
>  TP_printk("... slab_flags=%s ..",
> 	[..]
> 	__print_flags(sflags, "|",
> 		{ SLAB_CONSISTENCY_CHECKS, "CONSISTENCY_CHECKS" },
> 		{ SLAB_RED_ZONE, "RED_ZONE" },
> 		{ SLAB_POISON, "POISON" },
> 		{ SLAB_HWCACHE_ALIGN, "HWCACHE_ALIGN" },
> 		{ SLAB_CACHE_DMA, "CACHE_DMA" },
> 		{ SLAB_CACHE_DMA32, "CACHE_DMA32" },
> 		{ SLAB_STORE_USER, "STORE_USER" },
> 		{ SLAB_PANIC, "PANIC" }), ... )
> 
> 
> And you get the flag output looking nicely, and all the processing is done
> on the reader path.
> 
> That's if you find it useful at all.

Thank you for explanation!
Yes, we can do it however I really doubt that any other slab flags are of interest to anyone.

Btw. in this form slab flags array causes sparse warnings,
because SLAB_* are defined as bitwise slab_flags_t.
This should be translated to unsigned long similarly to gfp_t flags.

Thank you,
	Vasily Averin
