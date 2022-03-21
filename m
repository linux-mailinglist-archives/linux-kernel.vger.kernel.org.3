Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483374E300A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352145AbiCUSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiCUSfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:35:05 -0400
X-Greylist: delayed 762 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 11:33:38 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C76762A7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:33:38 -0700 (PDT)
X-ASG-Debug-ID: 1647886851-0fb3b00bc488b5a0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id bFwvDITkKmngQ9Uc; Mon, 21 Mar 2022 14:20:51 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=TnLfS5YUHN3LTRVR51dnyNj9HyvjTtJA6eggQNFB3nQ=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=JFvmKUVf2mQnkugOBlUD
        38WEillNpSOKksCRNZuuVfeQbk2AZRu6/Yveg6JA/b9OlGloywCkCwceTrv4HYtB9mG/jwf5/UpHO
        tFYwSlYG5Ciog0+6e/ePvrDRs4+Eo+S3WriOZYsMMwjWP1sRHisACqT4grWAJk3a2hmdEUAHwc=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11624553; Mon, 21 Mar 2022 14:20:51 -0400
Message-ID: <6d8b3c24-12d1-043f-aec8-cfdc5b2e2786@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date:   Mon, 21 Mar 2022 14:20:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Olivier Langlois <olivier@trillion01.com>
References: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
 <CAHk-=wgBMNC1ePTgqM6f0iBH94KE5_oHQYD2sqCbjev0KaZ6Kw@mail.gmail.com>
 <7fb2d8a6-951c-092c-ccaa-15522ae2ed01@kernel.dk>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <7fb2d8a6-951c-092c-ccaa-15522ae2ed01@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1647886851
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 10:59, Jens Axboe wrote:
> On 8/18/21 8:57 PM, Linus Torvalds wrote:
>> On Tue, Aug 17, 2021 at 8:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>> task_work being added with notify == TWA_SIGNAL will utilize
>>> TIF_NOTIFY_SIGNAL for signaling the targeted task that work is available.
>>> If this happens while a task is going through a core dump, it'll
>>> potentially disturb and truncate the dump as a signal interruption.
>> This patch seems (a) buggy and (b) hacky.
>>
>>> --- a/kernel/task_work.c
>>> +++ b/kernel/task_work.c
>>> @@ -41,6 +41,12 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>>>                 head = READ_ONCE(task->task_works);
>>>                 if (unlikely(head == &work_exited))
>>>                         return -ESRCH;
>>> +               /*
>>> +                * TIF_NOTIFY_SIGNAL notifications will interfere with
>>> +                * a core dump in progress, reject them.
>>> +                */
>>> +               if (notify == TWA_SIGNAL && (task->flags & PF_SIGNALED))
>>> +                       return -ESRCH;
>> This basically seems to check task->flags with no serialization.
>>
>> I'm sure it works 99.9% of the time in practice, since you'd be really
>> unlucky to hit any races, but I really don't see what the
>> serialization logic is.
>>
>> Also, the main user that actually triggered the problem already has
>>
>>         if (unlikely(tsk->flags & PF_EXITING))
>>                 goto fail;
>>
>> just above the call to task_work_add(), so this all seems very hacky indeed.
>>
>> Of course, I don't see what the serialization for _that_ one is either.
>>
>> Pls explain. You can't just randomly add tests for random flags that
>> get modified by other random code.
> You're absolutely right. On the io_uring side, in the current tree,
> there's only one check where current != task being checked - and that's
> in the poll rewait arming. That one should likely just go away. It may
> be fine as it is, as it just pertains to ring exit cancelations. We want
> to ensure that we don't rearm poll requests if the process is canceling
> and going away. I'll take a closer look at that one.
>
> For this particular patch, I agree it's racy. I'll see if I can come up
> with something better...
>

Continuing this thread from August 2021:

I previously tested a version of Jens' patch backported to 5.10 and it
fixed my problem.  Now I am trying to upgrade kernels, and 5.17 still
has the same problem - coredumps from an io_uring program to a pipe are
truncated.  Jens' patch applied to 5.17 again fixes the problem.  Has
there been any progress with fixing the problem upstream?

Reference:

https://lore.kernel.org/all/8af373ec-9609-35a4-f185-f9bdc63d39b7@cybernetics.com/
https://lore.kernel.org/all/76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk/

Tony Battersby
Cybernetics

