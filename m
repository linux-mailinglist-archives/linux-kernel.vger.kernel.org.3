Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DF4F93FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiDHL2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiDHL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11533B8202
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649417174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5RmUko8chmmbpF4Ji2OPWgXGC1cKNF9K4kHmP4gvcU=;
        b=P5zY3GpyF4yN3YEC5tAxIA3h48Y/9+P9baPI2vJEMSGEuWnZQpDp/meZKsO8lQ/LtIfyPw
        Q+Th9sGPezKz7ylxRZYFPdZ0+wWQHdSGirNkJ8cP2r0LiIdPtdyPxhiqrPXEu68QmwGZSk
        G5f/fyZ934q8F/SKAMXOJa3NrKnUrsE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-WMVgRzqJPAWLodKk2O69AQ-1; Fri, 08 Apr 2022 07:26:10 -0400
X-MC-Unique: WMVgRzqJPAWLodKk2O69AQ-1
Received: by mail-qt1-f200.google.com with SMTP id g22-20020ac870d6000000b002e20a1508ecso7458180qtp.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N5RmUko8chmmbpF4Ji2OPWgXGC1cKNF9K4kHmP4gvcU=;
        b=ZQf2P31I1ZPrfyssJBuhQQpbVWoTghXuDTp0rdbEzxC59srd+MdCxJ13f5/JRsbKKi
         dB/qpcUESCUp2uzAdwMXVOzVbUjd8lehPKF+Wg6KqRp2Ndk5wW+CTGqg5BVLENdASQKk
         Fw/rraHqx42RE06lVMvX8A6IEvA+ijt73Xknxj4xchQeSkOyTx9ixhyzngmAxphiRKtZ
         T+vZ1NJ/AC+HcUFenvBZ+qZP8hfLV3S9nDkhkWJ+Y10f47DZeDwwWB/uzdSKNDu4CBS6
         G9pkR4x2lX13RbHSfEYKI2vzf4mv7ZJGWqMUJqh9MXWVDXwQ36X+dWdLroH9rGl/jEIO
         Ag8Q==
X-Gm-Message-State: AOAM531D0h0IlM250MUuLjweuDbYxFl9Vzqn/7j871pxg/IU4f9u+ElV
        +u2kNYXqcn5M0qEszBHCYvZiEBkdygtc8iJaDp/RAo2N18cRMMuHlsIjXx5r6rTMJPJlbGVwEhn
        PD2BpgLhggOOS+tcXCeYWS1c3
X-Received: by 2002:ac8:7f08:0:b0:2ed:c19:978a with SMTP id f8-20020ac87f08000000b002ed0c19978amr891912qtk.103.1649417170304;
        Fri, 08 Apr 2022 04:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxez04CIpHitABz4fWGxSWgbvqTgZzsGnrGwOJR0AO9QT/DXc8WFgXGa6ZHPQMrSCvSSlD2/w==
X-Received: by 2002:ac8:7f08:0:b0:2ed:c19:978a with SMTP id f8-20020ac87f08000000b002ed0c19978amr891893qtk.103.1649417170042;
        Fri, 08 Apr 2022 04:26:10 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm18310028qtb.28.2022.04.08.04.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 04:26:09 -0700 (PDT)
Message-ID: <465ab95b-3e71-5901-c184-812dc595af2f@redhat.com>
Date:   Fri, 8 Apr 2022 07:26:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <87tub4j7hg.ffs@tglx> <ddf1755e-fe69-b60e-ee07-e78d663b11b2@redhat.com>
 <YlACJMp7AFaVa/Gt@dhcp22.suse.cz>
 <676fb197-d045-c537-c1f7-e18320a6d15f@redhat.com>
 <YlAHfU7VEI0wYAb/@dhcp22.suse.cz>
 <2293c547-3878-435a-ec1c-854c3181ad14@redhat.com>
 <YlATveUBFmWFY+SI@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YlATveUBFmWFY+SI@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 06:51, Michal Hocko wrote:
> On Fri 08-04-22 06:36:40, Nico Pache wrote:
>>
>>
>> On 4/8/22 05:59, Michal Hocko wrote:
>>> On Fri 08-04-22 05:40:09, Nico Pache wrote:
>>>>
>>>>
>>>> On 4/8/22 05:36, Michal Hocko wrote:
>>>>> On Fri 08-04-22 04:52:33, Nico Pache wrote:
>>>>> [...]
>>>>>> In a heavily contended CPU with high memory pressure the delay may also
>>>>>> lead to other processes unnecessarily OOMing.
>>>>>
>>>>> Let me just comment on this part because there is likely a confusion
>>>>> inlved. Delaying the oom_reaper _cannot_ lead to additional OOM killing
>>>>> because the the oom killing is throttled by existence of a preexisting
>>>>> OOM victim. In other words as long as there is an alive victim no
>>>>> further victims are not selected and the oom killer backs off. The
>>>>> oom_repaer will hide the alive oom victim after it is processed.
>>>>> The longer the delay will be the longer an oom victim can block a
>>>>> further progress but it cannot really cause unnecessary OOMing.
>>>> Is it not the case that if we delay an OOM, the amount of available memory stays
>>>> limited and other processes that are allocating memory can become OOM candidates?
>>>
>>> No. Have a look at oom_evaluate_task (tsk_is_oom_victim check).
>> Ok I see.
>>
>> Doesnt the delay then allow the system to run into the following case more easily?:
>> pr_warn("Out of memory and no killable processes...\n");
>> panic("System is deadlocked on memory\n");
> 
> No. Aborting the oom victim search (above mentioned) will cause
> out_of_memory to bail out and return to the page allocator. 
Ok I see that now. I did my bit math incorrectly the first time around. I
thought abort lead to the !oc->chosen case.

> the only problem with delaying the oom_reaper is that _iff_ the oom
> victim cannot terminate (because it is stuck somewhere in the kernel)
> on its own then the oom situation (be it global, cpuset or memcg) will
> take longer so allocating tasks will not be able to make a forward
> progress.
Ok so if i understand that correctly, delaying can have some ugly effects and
kinda breaks the initial purpose of the OOM reaper?

I personally don't like the delay approach. Especially if we have a better one
we know is working, and that doesnt add regressions.

If someone can prove to me the private lock case, I'd be more willing to bite.

Thanks for all the OOM context :)
-- Nico

