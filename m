Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20834E1A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbiCTGIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiCTGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:08:11 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0401BCC515
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:06:47 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22K66XMY067405;
        Sun, 20 Mar 2022 15:06:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sun, 20 Mar 2022 15:06:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22K66W6e067290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 20 Mar 2022 15:06:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
Date:   Sun, 20 Mar 2022 15:06:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
 <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/20 2:15, Linus Torvalds wrote:
> On Fri, Mar 18, 2022 at 9:43 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Since flush operation synchronously waits for completion, flushing
>> kernel-global WQs (e.g. system_wq) might introduce possibility of deadlock
>> due to unexpected locking dependency. Tejun Heo commented that it makes no
>> sense at all to call flush_workqueue() on the shared WQs as the caller has
>> no idea what it's gonna end up waiting for.
> 
> NAK on this patch for a very simple reason:
> 
>   static inline void flush_scheduled_work(void)
>   {
>         flush_workqueue(system_wq);
>   }
> 
> and now grep for flush_scheduled_work().

I know there are in-tree flush_scheduled_work() users.

> 
> The *other* system workqueue flushes may be rare and "that subsystem
> should just be converted to do its own workqueue".
> 
> But flush_scheduled_work() is literally exported as an explicit and
> separate interface,
> 
> The fact that the function has a big warning in the comment above it
> doesn't change that fact. At the very least, this patch has to be
> preceded by a couple of other patches that fix a couple of subsystems
> and document "this is what you should do".

This change was in Tejun's todo list
( https://lore.kernel.org/all/YgnQGZWT%2Fn3VAITX@slm.duckdns.org ).
But scrubbing the existing users will need some time.

This patch is intended for

  (a) preventing developers from adding more flush_workqueue() calls on
      kernel-global WQs.

  (b) serving as an anchor to be referenced from individual patches

.

> 
> Because suddenly saying "hey, we gave you this interface, now we're
> warning about it because it's going to go away" without actually
> showing how to do it instead is not acceptable.

This patch avoids emitting "WARNING:" in order not to disturb kernel testing.
This change is not as urgent as security fix. We can wait for several release
cycles until all in-tree users update their modules. I don't want to send
blind conversion patches, for what the proper fix is depends on what that
module is doing. For example, commit 081bdc9fe05bb232 ("RDMA/ib_srp: Fix a
deadlock") chose just removing flush_workqueue(system_long_wq) call. This
change is expected to be carefully handled by each module's maintainers.

> 
> And honestly, I don't personally see a good conversion. We literally
> have all those "schedule_{delayed_}work{_on}()" etc helper functions
> that are *designed* to use this system_wq. People *need* the ability
> to flush those things, even if it's only for module unload.

Users of all those "schedule_{delayed_}work{_on}()" etc helper functions
need to be updated only if flush_workqueue() is needed. And even if
flush_workqueue() happens only upon module unload, there is possibility
of deadlock.

> 
> So I really think this patch on its own is completely broken. It'd not
> pointing to a way forward, it's just saying "don't do this" with no
> really acceptable way to not do it.

If you want how to convert, I can include it into patch description.

> 
> Removing flush_scheduled_work() needs to be paired with removing the
> "schedule_{delayed_}work{_on}()" helpers too.

No need to remove the "schedule_{delayed_}work{_on}()" helpers.
Those who don't need flush_workqueue() can continue using these helpers.

Those who need flush_workqueue() can convert

  schedule_work(some_work);

into

  queue_work(some_workqueue_for_that_module, some_work);

.

> 
> And I don't see you having a good alternative.

What alternative are you expecting? We already have alternatives.
This change (replacing system_wq with module's local workqueue as
an example) is a matter of doing

  (1) add

        some_workqueue_for_that_module = alloc_workqueue("some_name", 0, 0);

      into module's __init function.

  (2) add

        destroy_workqueue(some_workqueue_for_that_module);

      into module's __exit function.

  (3) replace

        schedule_work(some_work);

      with

        queue_work(some_workqueue_for_that_module, some_work);

      throughout that module.

  (4) replace

        flush_scheduled_work();

      with

        flush_workqueue(some_workqueue_for_that_module);

      throughout that module.

if flush_scheduled_work() cannot be avoided.

> 
> So until that clear way forward exists, NAK.

We know that allocating a !WQ_MEM_RECLAIM workqueue consumes little
resource ( https://lore.kernel.org/all/YhUq70Y%2FtKGGNbR0@slm.duckdns.org ).
This is a step by step conversion if flush_workqueue() is unavoidable.

Again, we already have alternatives. Why NAK?

> 
>              Linus

