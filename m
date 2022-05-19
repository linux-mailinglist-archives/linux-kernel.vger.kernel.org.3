Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C852DA35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbiESQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbiESQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:29:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39712D4137
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:29:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u7so6156635ljd.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hfE6dx+3G7Xhg3fy//ddTC1qoRqj08jbiWPXg96CPJQ=;
        b=rE0GDgG3Pt5dENINhb/kwvh/Pk69bR4+ep8u3JTbELATCir4elLVBe7ACfHSa9J/Xr
         Yy5cAs9KADlL439mw4LWNreCKNwmqzWvhxyIotrdVRBMjtb7QSz6aPVMg5XJ0AQvM0E9
         I388He++d+4oUsZDpchg0LM4rUE/uU60u3UimmQCZJujwBah/TXew3VXWWtj6AF/iCQF
         fidgCcCLX/RkNaehXoFzb0/rv6mo7Arj+cNKKV7PmUzAfTq6zINL2IAC1i3Zq2pXBV5y
         YT6WiXvjSVHbcBMOCfbh5SH4lQl+NdtW38ns+MrXjwc+BGAmXkBmXGxrYii1g6OlcRcA
         Pp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hfE6dx+3G7Xhg3fy//ddTC1qoRqj08jbiWPXg96CPJQ=;
        b=cME81ARQLDlLdYyA9EsRKefnQ4bxfVtpOgKTJOdkkYY50YNwsd6QeCjACBK5b71mz2
         32sxGi+1QEwZKzeSO61BNrt5Q2f3o3XmZbijYNaol0E8m3Foi2ubVa46ANh4J4djrOaM
         x/5N/TKKTSo59jsCku1PRbu6CftxCQRBAdQIK9bvvmrZUVhyg61qOskQS2scHTafQqqF
         a6oqQ4MefM/l1xFe97c3/WUttUXpqN2wn+fOtGt1UnSPdT7VYFAD9J+Yu62hyjY/fpNK
         qZ3ncsafOhU14eFgIW7hbjVA8pi1+TWE2rpQqpzGSBZpR7KQ8er9iP9QKvr4UtoWoyzo
         /AOw==
X-Gm-Message-State: AOAM532YWMaYQQkPeXwYznm9czkr3TcPWcv1ocZFXQuuT/5KlaVPorUA
        2NO10hqD3MXI1N5OwKgGfE0qqw==
X-Google-Smtp-Source: ABdhPJxGirHOdCIW97ARJn+QNyyJ8XqYYnMMhx5NlIeuy1e5/tqxYqZ13Mdoe3BHU/DnIuuUJao5dg==
X-Received: by 2002:a2e:7308:0:b0:253:cd16:a893 with SMTP id o8-20020a2e7308000000b00253cd16a893mr3110782ljc.259.1652977778546;
        Thu, 19 May 2022 09:29:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e9b82000000b00253cd476074sm527503lji.111.2022.05.19.09.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 09:29:38 -0700 (PDT)
Message-ID: <e018be81-f4f2-a26f-7c5a-7adddd9c56c4@openvz.org>
Date:   Thu, 19 May 2022 19:29:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] tracing: add 'accounted' entry into output of
 allocation tracepoints
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     YoPOhRctb8wwbmY5@carbon, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
References: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
 <20220518160447.20a7b96f@gandalf.local.home>
 <b728f944-e3ae-cdb6-5f02-2fb21466b2fb@openvz.org>
 <20220519100348.101d027d@gandalf.local.home>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220519100348.101d027d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 17:03, Steven Rostedt wrote:
> On Thu, 19 May 2022 14:35:46 +0300
> Vasily Averin <vvs@openvz.org> wrote:
> 
>>>> @@ -33,42 +35,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>>>>  		__entry->bytes_req	= bytes_req;
>>>>  		__entry->bytes_alloc	= bytes_alloc;
>>>>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>>>> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
>>>> +					  (s && s->flags & SLAB_ACCOUNT);  
>>>
>>> Now you could make this even faster in the fast path and save just the
>>> s->flags.
>>>
>>> 	__entry->sflags = s ? s->flags : 0;
>>>   
>>>>  	),
>>>>  
>>>> -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
>>>> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
>>>>  		(void *)__entry->call_site,
>>>>  		__entry->ptr,
>>>>  		__entry->bytes_req,
>>>>  		__entry->bytes_alloc,
>>>> -		show_gfp_flags(__entry->gfp_flags))
>>>> +		show_gfp_flags(__entry->gfp_flags),
>>>> +		__entry->accounted ? "true" : "false")  
>>>
>>> And then have: "accounted=%s":
>>>
>>> 		(__entry->gfp_flags & __GFP_ACCOUNT) ||
>>> 		(__entry->sflags & SLAB_ACCOUNT) ? "true" : "false"  
>>
>> Unfortunately this returns back sparse warnings about bitwise gfp_t and slab_flags_t casts.
>> Could you please explain why your variant is faster?
> 
> Micro-optimization, grant you, but it is faster because it moves some of
> the logic into the slow path (the read side), and takes it out of the fast
> path (the write side).
> 
> The idea of tracing is to squeeze out every cycle we can to keep the
> tracing overhead down.
> 
> But it's really up to you if you need that. I'm not going to let this be a
> blocker. This is more of an FYI than anything else.

Frankly speaking I vote for performance with both hands.
However I'm still would like to avoid new sparse warnings.
Christoph Hellwig just recently taught me, "never add '__force' before
thinking hard about them", but in this case I would need to use it three times.

I found that bitwise typecasts can be avoided by using translation unions. 

What do you think about following trick?

diff --git a/mm/slab.h b/mm/slab.h
index 95eb34174c1b..f676612ca40f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -882,4 +882,14 @@ void __check_heap_object(const void *ptr, unsigned long n,
 }
 #endif
 
+union gfp_flags_u {
+	unsigned long ulong;
+	gfp_t flags;
+};
+
+union slab_flags_u {
+	unsigned int uint;
+	slab_flags_t sflags;
+};
+
 #endif /* MM_SLAB_H */

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 71c141804222..91632a61e16d 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -13,18 +13,20 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
+		 struct kmem_cache *s,
 		 size_t bytes_req,
 		 size_t bytes_alloc,
 		 gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags),
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
 		__field(	size_t,		bytes_req	)
 		__field(	size_t,		bytes_alloc	)
-		__field(	unsigned long,	gfp_flags	)
+		__field_struct(	union gfp_flags_u,	gfp	)
+		__field_struct(	union slab_flags_u,	s	)
 	),
 
 	TP_fast_assign(
@@ -32,51 +34,57 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->ptr		= ptr;
 		__entry->bytes_req	= bytes_req;
 		__entry->bytes_alloc	= bytes_alloc;
-		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
+		__entry->gfp.flags	= gfp_flags;
+		__entry->s.sflags	= s ? s->flags : 0;
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
-		show_gfp_flags(__entry->gfp_flags))
+		show_gfp_flags(__entry->gfp.ulong),
+		((__entry->gfp.flags & __GFP_ACCOUNT) ||
+		 (__entry->s.sflags & SLAB_ACCOUNT)) ? "true" : "false")
 );
 
Thank you,
	Vasily Averin
