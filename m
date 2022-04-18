Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C8505F37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348018AbiDRVTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348046AbiDRVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:19:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED302DD60
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:16:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so13353270plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=JeF6dFxHRv4EIaBv8cKkcPRHUMeL96UEDwmtZ1fXv54=;
        b=1AAWVTECxaWbSUoiq2CXrIj0TOMxk8MORZkys4b66OJqIJFvlv/t3pbBduJouhwgD6
         A8ffXh8UjfLivM+dz7bCnGWwQVgKpcHP3wOBF7GNuGsdNzEpOLOkbPyvKIx1qCJPyqkT
         Bs0q/1cEorW9Dvv1rnODQhepQj4NTywKOGhFcdjy++gMwi2tWwjBzfaXgQwHPcpNckzg
         Yd5PMKo2Mq/ktgFwnrspyiAANqrepgBr8tuDRIxULjVU1u+5J/wq3i3Qm87A2/GypqeS
         VSR2c+Qh01K4cjsf0HYHZ7dgq7QchVLC+SXXMUfpUk1qNemN+tvMN/kOPXerdFvh2j6e
         Jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=JeF6dFxHRv4EIaBv8cKkcPRHUMeL96UEDwmtZ1fXv54=;
        b=78F+48vWVLpF7vlIi/UYKNYNIEK85Y9arVi0D1ERLuoTX/IOtXZO1BVi9sRH4pMByJ
         RmIoO8PXZYqcyC6SiYOT9Lrg/dB6iYmumlomOQFMx2N6wrZRjPhRX6ZeKaux3itObRtN
         gsj27fj7br3niHjbMJpBZE79FEPaL9vlEQKOeylxTMHFCQVnpaLX2wixDbRtuEd2todp
         v6A4H0Hoau7lgJUYex9Fh3EaB45S5HThzDRH/gdZ7Fyo/wckhoO3Z6fnG4fk9q7EKHa0
         7zCIR/uCgXdn6H7B92jbvYVlVDIBBRDZCDfB7ecaRpJCWsrdWvMtXfP2pBfxhzQdYhFI
         OJ7Q==
X-Gm-Message-State: AOAM533Vvp3nl89VjjpTEaZ7FLLH8M5rysXCpldSFmzI3M7cNHYv0Kap
        +3P3hghlqeiAc4z+qB5cldbs0g==
X-Google-Smtp-Source: ABdhPJxk7U7RL4Frks0mIAIQGhPEHMt9oGlyAXyk8mXVyo/6wjqAHCc5rBvlnVrXYP3t5eaew/lfig==
X-Received: by 2002:a17:90a:e00b:b0:1cb:9bbe:b1f6 with SMTP id u11-20020a17090ae00b00b001cb9bbeb1f6mr20461779pjy.62.1650316589081;
        Mon, 18 Apr 2022 14:16:29 -0700 (PDT)
Received: from ?IPV6:2600:380:b43f:ca46:9ddf:3bd7:e35e:5d? ([2600:380:b43f:ca46:9ddf:3bd7:e35e:5d])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090a4a8e00b001cea3feaf29sm11986176pjh.56.2022.04.18.14.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 14:16:28 -0700 (PDT)
Message-ID: <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk>
Date:   Mon, 18 Apr 2022 15:16:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_fs-writeback=3a_writeback=5fsb=5fino?=
 =?UTF-8?Q?des=ef=bc=9aRecalculate_=27wrote=27_according_skipped_pages?=
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 1:43 PM, Linus Torvalds wrote:
> [ Adding some scheduler people - the background here is a ABBA
> deadlock because a plug never gets unplugged and the IO never starts
> and the buffer lock thus never gets released. That's simplified, see
>      https://lore.kernel.org/all/20220415013735.1610091-1-chengzhihao1@huawei.com/
>   and
>      https://bugzilla.kernel.org/show_bug.cgi?id=215837
>    for details ]
> 
> On Mon, Apr 18, 2022 at 2:14 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> In my test, 'need_resched()' (which is imported by 590dca3a71 "fs-writeback:
>> unplug before cond_resched in writeback_sb_inodes") in function
>> 'writeback_sb_inodes()' seldom comes true, unless cond_resched() is deleted
>> from write_cache_pages().
> 
> So I'm not reacting to the patch, but just to this part of the message...
> 
> I forget the exact history of plugging, but at some point (long long
> ago - we're talking pre-git days) it was device-specific and always
> released on a timeout (or, obviously, explicitly unplugged).

That is correct, it used to be a tq_disk list and each queue could be
added. This was back in the days when io_request_lock was a single
spinlock around all of bdev queuing, so quite a while ago :-)

> And then later it became per-process, and always released by task-work
> on any schedule() call.

kblock kickoff from schedule, we never do task-work for unplug. It's
either done in-line if not from schedule, or punted to kblockd. But not
really relevant to the problem at hand...

> But over time, that "any schedule" has gone away. It did so gradually,
> over time, and long ago:
> 
>   73c101011926 ("block: initial patch for on-stack per-task plugging")
>   6631e635c65d ("block: don't flush plugged IO on forced preemtion scheduling")
> 
> And that's *mostly* perfectly fine, but the problem ends up being that
> not everything necessarily triggers the flushing at all.
> 
> In fact, if you call "__schedule()" directly (rather than
> "schedule()") I think you may end up avoiding flush entirely. I'm
> looking at  do_task_dead() and schedule_idle() and the
> preempt_schedule() cases.
> 
> Similarly, tsk_is_pi_blocked() will disable the plug flush.
> 
> Back when it was a timer, the flushing was eventually guaranteed.
> 
> And then we would flush on any re-schedule, even if it was about
> preemption and the process might stay on the CPU.
> 
> But these days we can be in the situation where we really don't flush
> at all - the process may be scheduled away, but if it's still
> runnable, the blk plug won't be flushed.
> 
> To make things *really* confusing, doing an io_schedule() will force a
> plug flush, even  if the process might stay runnable. So io_schedule()
> has those old legacy "unconditional flush" guarantees that a normal
> schedule does not any more.

I think that's mostly to avoid hitting it in the schedule path, as it
involves a lock juggle at that point. If you're doing io_schedule(),
presumable chances are high that you have queued IO.

> Also note how the plug is per-process, so when another process *does*
> block (because it's waiting for some resource), that doesn't end up
> really unplugging the actual IO which was started by somebody else.
> Even if that other process is using io_schedule().
> 
> Which all brings us back to how we have that hacky thing in
> writeback_sb_inodes() that does
> 
>         if (need_resched()) {
>                 /*
>                  * We're trying to balance between building up a nice
>                  * long list of IOs to improve our merge rate, and
>                  * getting those IOs out quickly for anyone throttling
>                  * in balance_dirty_pages().  cond_resched() doesn't
>                  * unplug, so get our IOs out the door before we
>                  * give up the CPU.
>                  */
>                 blk_flush_plug(current->plug, false);
>                 cond_resched();
>         }
> 
> and that currently *mostly* ends up protecting us and flushing the
> plug when doing big writebacks, but as you can see from the email I'm
> quoting, it then doesn't always work very well, because
> "need_resched()" may end up being cleared by some other scheduling
> point, and is entirely meaningless when preemption is on anyway.
> 
> So I think that's basically just a random voodoo programming thing
> that has protected us in the past in some situations.
> 
> Now, Zhihao has a patch that fixes the problem by limiting the
> writeback by being better at accounting:
> 
>     https://lore.kernel.org/all/20220418092824.3018714-1-chengzhihao1@huawei.com/
> 
> which is the email I'm answering, but I did want to bring in the
> scheduler people to the discussion to see if people have ideas.
> 
> I think the writeback accounting fix is the right thing to do
> regardless, but that whole need_resched() dance in
> writeback_sb_inodes() is, I think, a sign that we do have real issues
> here. That whole "flush plug if we need to reschedule" is simply a
> fundamentally broken concept, when there are other rescheduling
> points.
> 
> Comments?
> 
> The answer may just be that "the code in writeback_sb_inodes() is
> fundamentally broken and should be removed".
> 
> But the fact that we have that code at all makes me quite nervous
> about this. And we clearly *do* have situations where the writeback
> code seems to cause nasty unplugging delays.
> 
> So I'm not convinced that "fix up the writeback accounting" is the
> real and final fix.
> 
> I don't really have answers or suggestions, I just wanted people to
> look at this in case they have ideas.

Unless I'm missing something, this exclusively seems to be a problem
with being preempted (task scheduled out, still runnable) and the
original patch did flush for preemption. I wasn't aware of the writeback
work-around doing those need_resched() checks to explicitly work-around
not flushing on preemption, that seems like a somewhat nasty
work-around...

So as far as I can tell, we really have two options:

1) Don't preempt a task that has a plug active
2) Flush for any schedule out, not just going to sleep

1 may not be feasible if we're queueing lots of IO, which then leaves 2.
Linus, do you remember what your original patch here was motivated by?
I'm assuming it was an effiency thing, but do we really have a lot of
cases of IO submissions being preempted a lot and hence making the plug
less efficient than it should be at merging IO? Seems unlikely, but I
could be wrong.

-- 
Jens Axboe

