Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D34FC90A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 02:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiDLAEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 20:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiDLAEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6AA12ED40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649721725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8c5EjZJFWQjGO0KtsK/b2yAf9oKCDamxmuxgZSqrg+g=;
        b=I0b79ZgvMO/f0ryG08CpWrW8AGXtFSuRzQFEXKtxEUKmIkZaGrLMyX6FVn5RYUaeMRHz3O
        9YznV8VA0xiT61ObqUASqVN+wxZUJyyTfUOIWt+RxJQjJr27VQEwTv+c4q+KnJMRkPEIIk
        wPm3G5vFnCKerAd/MNVliWnwHOEaur4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-yL1V72xtNfaBypn9qcQ3PQ-1; Mon, 11 Apr 2022 20:02:03 -0400
X-MC-Unique: yL1V72xtNfaBypn9qcQ3PQ-1
Received: by mail-qt1-f198.google.com with SMTP id d18-20020ac81192000000b002ebdd6ef307so8346994qtj.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8c5EjZJFWQjGO0KtsK/b2yAf9oKCDamxmuxgZSqrg+g=;
        b=ygYJ66fu4TMTJ0DjncPkCEMcx6ljHxHU/d1sE9F6YG/XwzuM+i4G0KR/o9kRGqxbQ7
         6hCdsx2poKoZn2uuhHRzC7AoKB0n1qzGs0wfLcu2EBPOQxv9nYQD2rYROnmBfpb9/LCK
         n53/Yi9WyYHVAjZU8fTtX6G/+aBqBQ2m5ff92/qtqddYyVPepA5kn1OPlm8OD3f4cP5Q
         XDtLinm0eVqsZTwwQ0KDaCMrAmWA7AAHnQIv1yMt8+0ATPuRKoDXTgyFgSjW8aCtKBC/
         zYehLZGeMTTDxvn+CWJSSIcuyvyRjsut7bnGrpx54YuvjAxJ04duTeD7Hgplmnb2FHZ9
         hI6A==
X-Gm-Message-State: AOAM531OVotAnxuXDTnXuFgU8Ef+iaP07bYscJLPIKHXIivgS066KGaL
        WU6wpYe0dhKUcu8zxsBECGwH+AMfst8lZuTNZG2HZ5egJJrMe0+OLqTKui1s0w45VaRToAmW8k5
        gUZCa1au8pY8rSpm2dYNeT+Ht
X-Received: by 2002:ac8:58c5:0:b0:2e1:cca9:b3f3 with SMTP id u5-20020ac858c5000000b002e1cca9b3f3mr1521228qta.100.1649721723344;
        Mon, 11 Apr 2022 17:02:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRyGmd8uhOz3BleD/jMRXTkNltGHNdY2kfh6XYh8L18wcb9jFXAm4k21+nuZ3n/yFAlENfPA==
X-Received: by 2002:ac8:58c5:0:b0:2e1:cca9:b3f3 with SMTP id u5-20020ac858c5000000b002e1cca9b3f3mr1521196qta.100.1649721723101;
        Mon, 11 Apr 2022 17:02:03 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id i62-20020a37b841000000b0069c10d27571sm3770984qkf.70.2022.04.11.17.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 17:02:02 -0700 (PDT)
Message-ID: <a8c8c25b-1b20-88d7-38ad-8a1f6f95ff41@redhat.com>
Date:   Mon, 11 Apr 2022 20:02:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
 <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
 <87sfqni77s.ffs@tglx> <YlPPRrGrX2ECe8QY@dhcp22.suse.cz> <87wnfwf4e5.ffs@tglx>
 <YlPv8elVxqa4XZnd@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YlPv8elVxqa4XZnd@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 05:08, Michal Hocko wrote:
> On Mon 11-04-22 09:47:14, Thomas Gleixner wrote:
>> Michal,
>>
>> On Mon, Apr 11 2022 at 08:48, Michal Hocko wrote:
>>> On Fri 08-04-22 23:41:11, Thomas Gleixner wrote:
>>>> So why would a process private robust mutex be any different from a
>>>> process shared one?
>>>
>>> Purely from the OOM POV they are slightly different because the OOM
>>> killer always kills all threads which share the mm with the selected
>>> victim (with an exception of the global init - see __oom_kill_process).
>>> Note that this is including those threads which are not sharing signals
>>> handling.
>>> So clobbering private locks shouldn't be observable to an alive thread
>>> unless I am missing something.
>>
>> Yes, it kills everything, but the reaper also reaps non-shared VMAs. So
>> if the process private futex sits in a reaped VMA the shared one becomes
>> unreachable.
>>
>>> On the other hand I do agree that delayed oom_reaper execution is a
>>> reasonable workaround and the most simplistic one.
>>
>> I think it's more than a workaround. It's a reasonable expectation that
>> the kernel side of the user space threads can mop up the mess the user
>> space part created. So even if one of of N threads is stuck in a place
>> where it can't, then N-1 can still reach do_exit() and mop their mess
>> up.
>>
>> The oom reaper is the last resort to resolve the situation in case of a
>> stuck task. No?
> 
> Yes, I keep saying workaround because it really doesn't address the
> underlying issue which is that the oom_reaper clobbers something it
> shouldn't be. A full fix from my POV would be making oom_reaper code
> more aware of the futex usage. But this is something nore really viable.
This is *kinda* what this approach is doing, but as Thomas has pointed out, it
has its shortcoming. Additionally, it has just come to my attention, that this
solution does not cover the compat robust list... So there is yet another
shortcoming.
> 
> Btw. this is what I've in my local tree. It hasn't seen any testing but
> it might be a good start to make it a full patch. I have decided to use
> a timer rather than juggling tasks on the oom_reaper list because
> initial implementation looked uglier. I will try to find some time to
> finish that but if Nico or others beat me to it I won't complain.
> Also I absolutely do not insist on the timer approach.
> [...]

I will spend tomorrow working the delay solution and testing it. Thanks for
starting it :)

I appreciate the comments and help from everyone that has participated! I'm
sorry if any misunderstanding were had, its not our intention to upset anyone,
but rather to learn and work a solution for the problem we are facing.

Best,
-- Nico

