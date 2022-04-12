Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67F44FE67C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348411AbiDLRFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiDLRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3CD860055
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649782994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJnqd5OLUuO1wuqKum2XiCzy6QcFrih6opRw+UalRwo=;
        b=KOVyBbQyRVfgfioAapBUsG7Gasx9e5VJXX36BfbrGdh7Njg5SACTftrcos+8vnFP4wbxeq
        TBrQgl+s20srBq6E6S//2CRwNIocgE/vp4TLyoxaBWGC3mAqFtEUv0N2oJwetMky8GBwCf
        JLdSOE8Li3S+/L829FF1jIoriP8lgUA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-CUWgdZ7dMbOzoi92uRxYKA-1; Tue, 12 Apr 2022 13:03:13 -0400
X-MC-Unique: CUWgdZ7dMbOzoi92uRxYKA-1
Received: by mail-qk1-f198.google.com with SMTP id bi19-20020a05620a319300b0069c16295aabso4660267qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aJnqd5OLUuO1wuqKum2XiCzy6QcFrih6opRw+UalRwo=;
        b=ZJ3cG0CtX792zLZEGcJYl+kxOuJAxm2byqne01KV40fLvBEGC8N6LH8wq8L8J0rYoR
         bmKPOYZWIZdouYT8g8Jo9VQbundSj/FIB48fjkaAAP1EswvZBIDsT+buqzPlKjSXtVc9
         b4VRmFD7+u+e45QtdKyg+pknlXBG2mlYWGE0Hec00yogkrf/MwN0LYbQlOj/Isx7oHan
         kJHJfDiYdLFs+AYVikqpOthol1HlDkmGiBPSa4J7XFUMHtQUC2dCx3EXC/npgjwTZHaU
         51eCt3FYjzedrNsMXpFGceR7rtfX3PTmR7zJ5BTKHJRW8eoMf0ZfHQm1ywBSjWkb7G7n
         qzPA==
X-Gm-Message-State: AOAM532Jlv8SnrFgtUm1FdpkvG1CzIDL8aYrof/JWYy7t7i4aiT6Ksrv
        MrL6RJp46gyveTQtn2ziQcIQpj5CvR/rWI65Sp2tozFUq9ttlWbUVGIvAY5bTCrn98PRcZPh6Vg
        SgrNSatF4OxhqAgSvWBr5jj0/
X-Received: by 2002:a05:6214:20e6:b0:443:58b7:6f5e with SMTP id 6-20020a05621420e600b0044358b76f5emr31485078qvk.120.1649782992801;
        Tue, 12 Apr 2022 10:03:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdg5KZQe62/znwgWYn/y2eSNTlf6NeAEDFTRvzLHc0PSUqVGhSfmtNCwgLAZfPvgnWJu+0Ww==
X-Received: by 2002:a05:6214:20e6:b0:443:58b7:6f5e with SMTP id 6-20020a05621420e600b0044358b76f5emr31485038qvk.120.1649782992415;
        Tue, 12 Apr 2022 10:03:12 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id c134-20020ae9ed8c000000b0069bf8f9cfb2sm6474764qkg.118.2022.04.12.10.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 10:03:11 -0700 (PDT)
Message-ID: <b9c386c1-a826-8bdc-ed4f-1d8dab6e84da@redhat.com>
Date:   Tue, 12 Apr 2022 13:03:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
 <1a7944c7-d717-d5af-f71d-92326f7bb7f6@redhat.com> <87h76yff3b.ffs@tglx>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <87h76yff3b.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/22 12:20, Thomas Gleixner wrote:
> On Mon, Apr 11 2022 at 19:51, Nico Pache wrote:
>> On 4/8/22 09:54, Thomas Gleixner wrote:
>>> The below reproduces the problem nicely, i.e. the lock() in the parent
>>> times out. So why would the OOM killer fail to cause the same problem
>>> when it reaps the private anon mapping where the private futex sits?
>>>
>>> If you revert the lock order in the child the robust muck works.
>>
>> Thanks for the reproducer Thomas :)
>>
>> I think I need to re-up my knowledge around COW and how it effects
>> that stack. There are increased oddities when you add the pthread
>> library that I cant fully wrap my head around at the moment.
> 
> The pthread library functions are just conveniance so I did not have to
> hand code the futex and robust list handling.
> 
>> My confusion lies in how the parent/child share a robust list here, but they
>> obviously do. In my mind the mut_s would be different in the child/parent after
>> the fork and pthread_mutex_init (and friends) are done in the child.
> 
> They don't share a robust list, each thread has it's own.
> 
> The shared mutex mut_s is initialized in the parent before fork and it's
> the same address in the child and it's not COWed because the mapping is
> MAP_SHARED.
> 
> The child allocates private memory and initializes the private mutex in
> that private mapping.
> 
> So now child does:
> 
>    pthread_mutex_lock(mut_s);
> 
> That's the mutex in the memory shared with the parent. After that the
> childs robusts list head points to mut_s::robust_list.
> 
> Now it does:
> 
>    pthread_mutex_lock(mut_p);
> 
> after that the childs robust list head points to mut_p::robust_list and
> mut_p::robust_list points to mut_s::robust_list.
> 
> So now the child unmaps the private memory and exists.
> 
> The kernel tries to walk the robust list pointer and faults when trying
> to access mut_p. End of walk and mut_s stays locked.
> 
> So now think about the OOM case. The killed process has a shared mapping
> with some other unrelated process (file, shmem) where mut_p sits.
> 
> It gets killed after:
> 		pthread_mutex_lock(mut_s);
> 		pthread_mutex_lock(mut_p);
> 
> So the OOM reaper rips the VMA which contains mut_p and therefore breaks
> the chain which is necessary to reach mut_p.
> 
> See?
Yes, thank you for the detailed explanation, the missing piece just clicked in
my head :)

Cheers,
-- Nico
> 
> Thanks,
> 
>         tglx
> 
> 
> 

