Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53F4D3C1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiCIVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiCIVfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:35:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F78097294
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646861693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=927c9dWmNajL2UTfWn7WpFfstn9tLvhIfdsXOeydQr8=;
        b=WCCFXZ/283nFDTkFl916aQZ8Wx7hi4Hfpg2+W2Q4Mqe6EX23P2Z9nUTyCbHL250i21HxJl
        H+S7kFLA2Iw5S+yLrPjt8uUQodRhUKLH4/Xacv4HH92vQ3c/peJ0TSLyiF6nNK/JW7IXEd
        JWVDnK+fOm+xG1ri/SwcJC8yvHYJK4E=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-ijfBUcc0PceV7-MnYw6OMw-1; Wed, 09 Mar 2022 16:34:52 -0500
X-MC-Unique: ijfBUcc0PceV7-MnYw6OMw-1
Received: by mail-il1-f197.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso2058198ili.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 13:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=927c9dWmNajL2UTfWn7WpFfstn9tLvhIfdsXOeydQr8=;
        b=emRSkXfUjpi/LuWiQhlAnxGrtHNgOqjiBvD1ef/LDLrtvJo4+uBDCbMX9LHtpNUM42
         JU2yD/gwuKn9VBPPJEXCm4G8DIxnDugUg4DRxb0FpPiHO+0iH78MqveHQPQmgvbiJtVC
         b28xspXbzEw2blSEuCYHNjMO3wHQDKL/xR5CVblmEPFKddd8ftKraQHE4Om+D97lJzY1
         zpuNrRK1f30sVXrNG81n7nhk5TbCrNJQkgLOMg691ltd51CtK4aiwhrYLeDSlolvfVXq
         aWy7IONsKxx35keb1rM25ScuizZIfqw+4Actd62OONwlnrgPR1ZNe68ol3KRxijpMzFc
         q9Zw==
X-Gm-Message-State: AOAM531CODLyxjJPsGvGlpscOq6XLZBuDDgTqYld/KmKyRDOGLTae2rk
        VCKf8CfK3hRUKZsnwPJEWs7KwO95ost/0+jT5FYVD1vljVD4oxQQDIvrd+pf1UqriTekH7REODB
        Uf+4l6sYw4H753AamF1ECcmIP
X-Received: by 2002:a02:c913:0:b0:317:d63c:a93 with SMTP id t19-20020a02c913000000b00317d63c0a93mr1259616jao.39.1646861691562;
        Wed, 09 Mar 2022 13:34:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6d1RYO8Law6M/yywQ22Fp3Z929x69jerj3sDELnRBTFBmWaaGTlAivN9HvsoM5yGTP179bw==
X-Received: by 2002:a02:c913:0:b0:317:d63c:a93 with SMTP id t19-20020a02c913000000b00317d63c0a93mr1259593jao.39.1646861691337;
        Wed, 09 Mar 2022 13:34:51 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0::11d7? ([2601:280:4400:a2e0::11d7])
        by smtp.gmail.com with ESMTPSA id m4-20020a0566022e8400b006463059bf2fsm1516800iow.49.2022.03.09.13.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 13:34:50 -0800 (PST)
Message-ID: <3a7dd0c4-db90-62e4-d7c7-246a4e3b9325@redhat.com>
Date:   Wed, 9 Mar 2022 14:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] mm/oom_kill.c: futex: Don't OOM reap a process with a
 futex robust list
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, peterz@infradead.org,
        Joel Savitz <jsavitz@redhat.com>,
        Waiman Long <longman@redhat.com>
References: <20220309002550.103786-1-npache@redhat.com>
 <YiinJ3A6WoTJLN8d@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YiinJ3A6WoTJLN8d@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/22 06:09, Michal Hocko wrote:
> On Tue 08-03-22 17:25:50, Nico Pache wrote:
>> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
>> be targeted by the oom reaper. This mapping is also used to store the futex
>> robust list; the kernel does not keep a copy of the robust list and instead
>> references a userspace address to maintain the robustness during a process
>> death. A race can occur between exit_mm and the oom reaper that allows
>> the oom reaper to clear the memory of the futex robust list before the
>> exit path has handled the futex death.
> 
> The above is missing the important part of the problem description. So
> the oom_reaper frees the memory which is backing the robust list. It
> would be useful to link that to the lockup on the futex.
That is basically what that last sentence in the paragraph is saying. perhaps I
should change clear -> free to be more verbose. Do you mean provide the race in
the standard format of:

    CPU1                CPU2
-------------------------------------------
    page_fault
    do_exit "signal"
    wake_oom_reaper	
			oom_reaper
                        oom_reap_task_mm (invalidates the private|anon mapping)
    exit_mm
    exit_mm_release
    futex_exit_release
    futex_cleanup
    exit_robust_list
    get_user (tries to access the memory we invalidated)
> 
>> Prevent the OOM reaper from concurrently reaping the mappings if the dying
>> process contains a robust_list. If the dying task_struct does not contain
>> a pointer in tsk->robust_list, we can assume there was either never one
>> setup for this task struct, or futex_cleanup has properly handled the
>> futex death and we can safely reap this memory.
> 
> I do agree with Waiman that this should go into a helper function.This
Ok I will do so in my v5.
> would be a quick workaround but I believe that it would be much better
> to either do the futex cleanup in the oom_reaper context if that could
> be done without blocking.

The futex cleanup is protected by two locks: a sleeping mutex and a spin_lock,
and both seem to be protecting a different race condition. If we create a
function like futex_try_exit_release that does a non-sleeping try_mutex call we
could solve the issue, but in the case that we fail to acquire the lock then we
leave the race window open. So from a correctness standpoint this approach falls
short.

 If that is really not feasible for some reason
> then we could skip over vmas which are backing the robust list. Have you
> considered any of those solutions?

We did explore some other possibilities such as using:
'&& !vma->vm_mm->owner->robust_list' in  __oom_reap_task_mm which did not work
for some reason but should have the same effect as this patch but with wasting
cycles checking all the VMA under a given process for a robust_list that we
could just check for in the parent caller. The only benefit I could see from
this approach would be that if halfway through checking the VMAs the robust list
gets set to NULL, we could then clear the other half of memory more quickly with
the oom reaper.

Unless you know of some other way to determine if that VMA is the pthread
mapping or a way to hide a certain mmap from the OOM reaper then I think this is
our best approach.

We have also considered implementing a lock between the futex_cleanup and the
oom_reaper that would have a similar effect to this patch but instead of
skipping the oom on a robust list we wait for the cleanup to finish then
continue ooming. Not sure if we want to introduce that complexity though.

Cheers,
-- Nico

