Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CDF47614B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbhLOTAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbhLOTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:00:15 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:00:15 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id u16so21173150qvk.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U8Bjz5kiAXgKHGFmWBYILV50S8xdfFCTdtklcBxPuC8=;
        b=heqfMG03jIXSlLIoxD2kJ8twSDTNLNNjmzyTRHQFOJbFaX6w+YA1mbJwI4HzE8ZD9X
         HXlZC9mrdTozX3TomGoTe/DNr5VZ6vk+EUodMFav7obAjZVsz6iXVIqJ3cE9jSPcVL7X
         p8FLFrF5W+fRvTwnJKJGx1XUUzuhWn+lEphEKQ88p7OeO9AhMTLRZVZ2y6j+kxQFbhCC
         z4gS+Udd0F8q/XT+cIQZdThf23dqEA//gE9g7ojah69ZuvCoZqOe2KC1oUnW5mHc6H/k
         Y1DQB/rYu/VUZ+j7PVwcYodFHH3PvMk7BM1MQhY8CRT2YpchqSXFGkiqcwdcGIARcwoa
         Dpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U8Bjz5kiAXgKHGFmWBYILV50S8xdfFCTdtklcBxPuC8=;
        b=PHhs0g8fx9JiKjaZcHlZ5Bt8Ki8u4Qfmm2b1qdF2dorPpH0wl2SPeawUuEKcFZS8o2
         NkMo15ZQCIgIMsA0E2jIu8PL5aOAl2GSW0UCLy0MgDT12LgT/Ow61tw/P/CH+rAgJnuX
         D8G+2BfP6FvuStE2QwYWzeWcLuT8gU367TVHZf5Le37VWTgoHPKks0UguNeET9Qt7+sq
         Acmdg49Tp+3W8YHMr1eOG3kn1ruclR48/h9A3kWKh0aDAoin0a6RvlD7womN2Y9GQs7q
         sTXlqtaholBmYh1C7tJTRQ0t2Rf32Gs7XY7NCQSkigfe3byGNWt8NKXcj5SoZYFfrh7U
         V3CA==
X-Gm-Message-State: AOAM532+U9ANl6+XNS2rWwTkv0Q4fmqJvmmoFnFJBtNtRe4xXRvnaY4p
        axr0PhZkJeS5vNcVKZcBq73sbtmyXl6D3rgG
X-Google-Smtp-Source: ABdhPJwFwOWgUG4kh5qpHIkVqBPbrthFE0KBPG1RfaUj6MIJNvIi1RCtSflSZ/YA+6tvYxf2zqrPgA==
X-Received: by 2002:a05:6214:29e7:: with SMTP id jv7mr2508323qvb.122.1639594814041;
        Wed, 15 Dec 2021 11:00:14 -0800 (PST)
Received: from [192.168.0.111] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id k19sm1542842qko.73.2021.12.15.11.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 11:00:13 -0800 (PST)
Subject: Re: [PATCH] rlimits: do not grab tasklist_lock for do_prlimit on
 current
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211213220401.1039578-1-brho@google.com>
 <8735mww2w3.fsf@email.froward.int.ebiederm.org>
From:   Barret Rhoden <brho@google.com>
Message-ID: <456a056e-453e-71b0-0f9e-03511b9f56b1@google.com>
Date:   Wed, 15 Dec 2021 14:00:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8735mww2w3.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 12/13/21 5:34 PM, Eric W. Biederman wrote:
> Do you have any numbers?  As the entire point of this change is
> performance it would be good to see how the performance changes.
> 
> Especially as a read_lock should not be too bad as it allows sharing,
> nor do I expect reading or writing the rlimit values to be particularly
> frequent.  So some insight into what kinds of userspace patterns make
> this a problem would be nice.

This was motivated by slowdowns we observed on a few machines running 
tests in a cluster.  AFAIK, there were a lot of small tests, many of 
which mucked with process management syscalls while fork/joining other 
tasks.

Based on a cycles profile, it looked like ~87% of the time was spent in 
the kernel, ~42% of which was just trying to get *some* spinlock 
(queued_spin_lock_slowpath, not necessarily the tasklist_lock).

The big offenders (with rough percentages in cycles of the overall trace):

- do_wait 11%
- setpriority 8% (potential future patch)
- kill 8%
- do_exit 5%
- clone 3%
- prlimit64 2%   (this patch)
- getrlimit 1%   (this patch)

Even though do_prlimit was using a read_lock, it was still contending on 
the internal queued_spin_lock.

The prlimit was only 3% of the total.  This patch was more of a "oh, 
this doesn't *need* the tasklist_lock for p == current" - can we fix 
that?  I actually don't even know often those prlimit64 calls had p == 
current.

setpriority was a bigger one too - is the tasklist lock only needed for 
the PGRP ops?  (I thought so based on where the tasklist_lock is write 
locked and the comment on task_pgrp()).  If so, I could do that in 
another patch.

> This change is a bit scary as it makes taking a lock conditional and
> increases the probability of causing a locking mistake.

I definitely see how making the code more brittle might not be worth the 
small win.  If this is more "damage" than "cleanup", then I can drop it.

> If you are going to make this change I would say that do_prlimit should
> become static and taking the tasklist_lock should move into prlimit64.
> 
> 
> Looking a little closer it looks like that update_rlimit_cpu should use
> lock_task_sighand, and once lock_task_sighand is used there is actually
> no need for the tasklist_lock at all.  As holding the reference to tsk
> guarantees that tsk->signal remains valid.

Maybe do both?  unconditionally grab lock_task_sighand (instead of 
tasklist_lock) in prlimit64.

> So I completely agree there are cleanups that can happen in this area.
> Please make those and show numbers in how they improve things, instead
> of making the code worse with a conditional lock.

Unfortunately, I can't easily get a "before and after" on this change. 
The motivating issue popped up sporadically, but getting it to happen in 
a setup under *my* control is organizationally a pain.  So I understand 
if you wouldn't want the patch for that reason.  Ideally, the changes 
would make the code easier to follow and clearer about why we're locking.

If you're OK with two patches that 1) grab lock_task_sighand in 
prlimit64 and 2) moving the read_lock in {set,get}priority into the PGRP 
cases (assuming I was correct on that), I can send them out.

If it's too much of a risk/ugliness for not clear enough gain (in code 
quality or performance), I'm fine with dropping it.

Thanks for looking,

Barret

