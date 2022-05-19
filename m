Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602F152D195
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiESLf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiESLfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:35:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B228CDDE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:35:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w14so8543061lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oxibleWjg5piZBF2UIB37tPZ8A10UXKI4apmU+0ZgSE=;
        b=8EB4pJ5d6ls+vf8cvcPsR22q2RxCetm5Iw2kafSsbt/+95CKUc0uKp5QkBhyrST1rt
         6lHoRg71vpeaZsk1OKWJUv5oDbc4vDrSGqQayY++4QB2v5fjP99+fSXmZImkVJclh3kD
         S1+iwmP44Yu9mSMNikOkMHFLdC3dG6TZF/UUW33LiEmsmu7kReeJyjxE4ExaolC+/IpH
         eH7yaRloZsgKADBBLdppr1XLrzBvtgj/QwFOf1FheHSdwvtFkYTpryFD3a22LKiRtgsl
         X3bN8EENiOaDuYZghe5I9Doa8KS82H/H0bFJUhUloRLebbtVRhn8zx7Rx4i4I3udKAvb
         vEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oxibleWjg5piZBF2UIB37tPZ8A10UXKI4apmU+0ZgSE=;
        b=DDipmUYK3/fgkl2TLerYKGIB8yF0y1PcwdiBSuWHkPUHkZ+LH2H7nqvH6x0BZgopxN
         eSdCrNMhqJiq8wGoW40CfhOlSpKfLUHQBejJCviAS+Qf/J0JSsS/lbGOhwuA3P3753/G
         IemrgUOmsFCI5bGozL00QYtqcBA+5JiJGOycPaFma+fThnMsLAgckXcV5kRWPqIyfbBV
         fEnQ84qYI66EbAMFm2WNTgBT9oKZGg80hTOYu//h4sTjzYC6Mfj2m1GfE8gw2PJDyrvy
         mT97+7LVKf5qcMeRDujfoaURHPQ7cwRuT6j2TOhIJ9ZQ9xwG3ZnSDrqVGoV1n4qBw0JL
         6/tQ==
X-Gm-Message-State: AOAM5335Zbi4PuPZeKroTwKTC2kSLDM2vyGXONPe2RdYid+ieylfhO0N
        FQZEtZeU4pryJFgSVEhpfFctXA==
X-Google-Smtp-Source: ABdhPJyBQ4HZaR0d2ga1ci2zALQ/cTNDEyY0EG9kBXrlEqKR9WuzxRCVaJLz8zEcc0SL+lFTe1PQeA==
X-Received: by 2002:a05:6512:686:b0:473:9d94:372d with SMTP id t6-20020a056512068600b004739d94372dmr3000734lfe.623.1652960150032;
        Thu, 19 May 2022 04:35:50 -0700 (PDT)
Received: from [192.168.43.196] ([185.174.128.243])
        by smtp.gmail.com with ESMTPSA id j5-20020ac253a5000000b0047255d21163sm260922lfh.146.2022.05.19.04.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 04:35:49 -0700 (PDT)
Message-ID: <b728f944-e3ae-cdb6-5f02-2fb21466b2fb@openvz.org>
Date:   Thu, 19 May 2022 14:35:46 +0300
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
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220518160447.20a7b96f@gandalf.local.home>
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

On 5/18/22 23:04, Steven Rostedt wrote:
> On Wed, 18 May 2022 09:24:51 +0300
> Vasily Averin <vvs@openvz.org> wrote:
> 
> FYI, the subject should be something like: mm/tracing:
> Because "tracing:" is reserved for tracing infrastructure updates.

Thank you for noticing.

>> @@ -33,42 +35,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>>  		__entry->bytes_req	= bytes_req;
>>  		__entry->bytes_alloc	= bytes_alloc;
>>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
>> +					  (s && s->flags & SLAB_ACCOUNT);
> 
> Now you could make this even faster in the fast path and save just the
> s->flags.
> 
> 	__entry->sflags = s ? s->flags : 0;
> 
>>  	),
>>  
>> -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
>> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
>>  		(void *)__entry->call_site,
>>  		__entry->ptr,
>>  		__entry->bytes_req,
>>  		__entry->bytes_alloc,
>> -		show_gfp_flags(__entry->gfp_flags))
>> +		show_gfp_flags(__entry->gfp_flags),
>> +		__entry->accounted ? "true" : "false")
> 
> And then have: "accounted=%s":
> 
> 		(__entry->gfp_flags & __GFP_ACCOUNT) ||
> 		(__entry->sflags & SLAB_ACCOUNT) ? "true" : "false"

Unfortunately this returns back sparse warnings about bitwise gfp_t and slab_flags_t casts.
Could you please explain why your variant is faster?

Thank you,
	Vasily Averin
