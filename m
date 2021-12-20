Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846E847B46F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhLTUhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLTUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:37:08 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7DCC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:37:07 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m9so15030651iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=anVhGwYWrcR6XnvgqwrJzl+Q8GX4SPCEF32mOxVKLvU=;
        b=V0TJnSwYoeOMsn8+H7tP3gKTQWabyphRFA6RyIBo6kqXzJhyFmyXlTGpX+QXrcOtMh
         h4oXmiC9VzA2UpvMLyHTzaTp4AlXcZwqDLTJlSgcc3HjHfBLtEXItTwtkCTU7K0ZZcMZ
         qN4p8JxRWEE5r3sxPULpcEPyHJcLjOIXDjjsrAfG59lo8LlQpjYgbgSGyqFc3zct5PxX
         x5AS7vFsoslrQwle3RhviqjNkR6HGCKLTkEDlc05cuv3p5jGjzhum6Q1IHdDCISJCfiZ
         kBM87NTP7ARAxTwy8O1h9nPO+6cPsNr25OqM8noigj8EC3cdMFykmJEdr0qBVYLnYMLq
         tr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anVhGwYWrcR6XnvgqwrJzl+Q8GX4SPCEF32mOxVKLvU=;
        b=UDT0Zrd8skSYbJgDd36xv/i13ls8hcCZr6/xGgCTc2/HSjMrSil+Ke25JRd6+d60O9
         RymjEXeIrtsy31Lk3YxeFJQi6cOfuWEeyAHj09i/pu+T+vYrey0bUnDgHPWgtsub+Mnn
         Y0FEu0bVQTxntKSrS08B143hOgA4fC06TinSKGSnQNubDSqnxxMN79QWQkQLHBQSrXzZ
         QeWkFG9Du8GjOjYGuloInzABiO9+5VEemtKKon/7w+Rb0Lt1Bs7bsLXZg5P2Gxrh7z3P
         8lb1AUFAsWkTCV3XYzPI/AgQM6eH2PvS0X+jx2f1bVy+MAhuELxRLSvWugQbjKmyVRyH
         FM5Q==
X-Gm-Message-State: AOAM531pOY0e/tw0AoXIiUNdWIbV/J+h1N2qR5s8imKvDd132E39y2nn
        zk2BVzzLJ1uzBrf7HzuVvo2lPg==
X-Google-Smtp-Source: ABdhPJx19yIQ0/PB0Xav4WFYrh11HvT8LaA2qrMie0y/PmO3t3n88roBNKuMfRNfVbjYavyGemF/iQ==
X-Received: by 2002:a05:6638:204c:: with SMTP id t12mr4977579jaj.169.1640032626638;
        Mon, 20 Dec 2021 12:37:06 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w11sm10203700ilv.18.2021.12.20.12.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 12:37:06 -0800 (PST)
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
To:     Wander Costa <wcosta@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20211220192827.38297-1-wander@redhat.com>
 <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
 <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
 <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk>
 <CAAq0SUmQ5aXtr-tVYLry7zZwTHG6J=X7QV9q0man7pXn7uZjQQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f2f5003-e1bf-15ce-32cd-a543634ba880@kernel.dk>
Date:   Mon, 20 Dec 2021 13:37:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAq0SUmQ5aXtr-tVYLry7zZwTHG6J=X7QV9q0man7pXn7uZjQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 1:34 PM, Wander Costa wrote:
> On Mon, Dec 20, 2021 at 5:24 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/20/21 12:49 PM, Wander Costa wrote:
>>> On Mon, Dec 20, 2021 at 4:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 12/20/21 12:28 PM, Wander Lairson Costa wrote:
>>>>> The running_trace_lock protects running_trace_list and is acquired
>>>>> within the tracepoint which implies disabled preemption. The spinlock_t
>>>>> typed lock can not be acquired with disabled preemption on PREEMPT_RT
>>>>> because it becomes a sleeping lock.
>>>>> The runtime of the tracepoint depends on the number of entries in
>>>>> running_trace_list and has no limit. The blk-tracer is considered debug
>>>>> code and higher latencies here are okay.
>>>>
>>>> You didn't put a changelog in here. Was this one actually compiled? Was
>>>> it runtime tested?
>>>
>>> It feels like the changelog reached the inboxes after patch (at least
>>> mine was so). Would you like that I send a v6 in the hope things
>>> arrive in order?
>>
>> Not sure how you are sending them, but they don't appear to thread
>> properly. But the changelog in the cover letter isn't really a
>> changelog, it doesn't say what changed.
>>
> 
> Sorry, I think I was too brief in my explanation. I am backporting
> this patch to the RHEL 9 kernel (which runs kernel 5.14). I mistakenly
> generated the v4 patch from that tree, but it lacks this piece
> 
> @@ -1608,9 +1608,9 @@ static int blk_trace_remove_queue(struct request_queue *q)
> 
>         if (bt->trace_state == Blktrace_running) {
>                 bt->trace_state = Blktrace_stopped;
> -               spin_lock_irq(&running_trace_lock);
> +               raw_spin_lock_irq(&running_trace_lock);
>                 list_del_init(&bt->running_list);
> -               spin_unlock_irq(&running_trace_lock);
> +               raw_spin_unlock_irq(&running_trace_lock);
>                 relay_flush(bt->rchan);
>         }
> 
> Causing the build error. v5 adds that. Sorry again for the confusion.

Right, that's why I asked if a) you had even built this patch, and b) if
you had tested it as well.

-- 
Jens Axboe

