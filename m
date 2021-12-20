Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F57947B48B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhLTUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhLTUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:49:49 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:49:49 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id s11so8560422ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vjo7+P7EMdLtVW9zkgulM327WgaMXZFZ1eKa5E8+XyU=;
        b=0sOYQ+GvP5tLIyXXF0j55JVRVp9npKK9qrro4ookkDFT3dCulewA2xL2YgbnwAAyVc
         D9NLYAOix5ghFsQAPUrJBSP9Vn9TkWc8SYIuG9QDuMsYXUvtFrwj16+ANdNkzky8sgKA
         sNLqon4fkBvkzEnan8QJ4iGXKmY+oG2+bMT7m+lG4878s39YLISDmd98jygllzp0jCi7
         4KEQMERtAVzHGDQZBuS4EM3poINYB/gQ5HQwXCVaQ92z+ye/e3e3od+5k1m1a+j0oap1
         yYF43tS95gQAYLE4qBgOhtBJNEPxA+56/ExI82AslxRp/UtVJCLsUfWsVcy4oBRH3IjU
         dwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vjo7+P7EMdLtVW9zkgulM327WgaMXZFZ1eKa5E8+XyU=;
        b=QCp5LWxQA0JZV6bNBAlZSEaRIUMDdXgRvYAfrCQCtkIwTqY9CYVQokXbVPNJBXTuzp
         p7c6bskr97aZuSn67u1391tGLu/DMN2ELBEKzWP9ywF4IYb1T5c+Abgd+nXZx9fjGPoV
         Z+8AQd15vKBKlxgIlg3DXM8WoaYrRPtuQkPqt7fPIdCQ3FbBEaTWO2+6bOxA2ng8tGkn
         Vz4GUL9K0btOxfXi461fLpbdGaEHhJ3KjLquYGAnpQCUr6pyow0jtHEu+J27y76lWoUb
         XmaJMVTkfuXv3AZDk5Nro5n0pSEOLSTbtmfCj3x1NHBQeILfmu7WMucIYOIj9C+B0sOH
         Iqaw==
X-Gm-Message-State: AOAM530Fylf9cQcBlnk8AV3HBRuC013hlgiwUGGalATghCHoNDXnckmk
        AMnianWtH36meW4Do9ABwhQsdw==
X-Google-Smtp-Source: ABdhPJyqeIgbJ5ckS0Y2+OKH7hdpkLiiIrLZet0xmaf+WpTP4eWa5UG4c4D48KEvVjtrTRsUNzVVmw==
X-Received: by 2002:a92:db51:: with SMTP id w17mr9892600ilq.213.1640033388421;
        Mon, 20 Dec 2021 12:49:48 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j5sm6393743ilo.77.2021.12.20.12.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 12:49:48 -0800 (PST)
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
 <2f2f5003-e1bf-15ce-32cd-a543634ba880@kernel.dk>
 <CAAq0SUkZ_Zm_KZc-S02xAuR+td0T1nx=cPCs6D2cb_xt6EsUEg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <76333783-cb3a-d1b7-5e40-d07014c4e2c0@kernel.dk>
Date:   Mon, 20 Dec 2021 13:49:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAq0SUkZ_Zm_KZc-S02xAuR+td0T1nx=cPCs6D2cb_xt6EsUEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 1:43 PM, Wander Costa wrote:
> On Mon, Dec 20, 2021 at 5:37 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/20/21 1:34 PM, Wander Costa wrote:
>>> On Mon, Dec 20, 2021 at 5:24 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 12/20/21 12:49 PM, Wander Costa wrote:
>>>>> On Mon, Dec 20, 2021 at 4:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>> On 12/20/21 12:28 PM, Wander Lairson Costa wrote:
>>>>>>> The running_trace_lock protects running_trace_list and is acquired
>>>>>>> within the tracepoint which implies disabled preemption. The spinlock_t
>>>>>>> typed lock can not be acquired with disabled preemption on PREEMPT_RT
>>>>>>> because it becomes a sleeping lock.
>>>>>>> The runtime of the tracepoint depends on the number of entries in
>>>>>>> running_trace_list and has no limit. The blk-tracer is considered debug
>>>>>>> code and higher latencies here are okay.
>>>>>>
>>>>>> You didn't put a changelog in here. Was this one actually compiled? Was
>>>>>> it runtime tested?
>>>>>
>>>>> It feels like the changelog reached the inboxes after patch (at least
>>>>> mine was so). Would you like that I send a v6 in the hope things
>>>>> arrive in order?
>>>>
>>>> Not sure how you are sending them, but they don't appear to thread
>>>> properly. But the changelog in the cover letter isn't really a
>>>> changelog, it doesn't say what changed.
>>>>
>>>
>>> Sorry, I think I was too brief in my explanation. I am backporting
>>> this patch to the RHEL 9 kernel (which runs kernel 5.14). I mistakenly
>>> generated the v4 patch from that tree, but it lacks this piece
>>>
>>> @@ -1608,9 +1608,9 @@ static int blk_trace_remove_queue(struct request_queue *q)
>>>
>>>         if (bt->trace_state == Blktrace_running) {
>>>                 bt->trace_state = Blktrace_stopped;
>>> -               spin_lock_irq(&running_trace_lock);
>>> +               raw_spin_lock_irq(&running_trace_lock);
>>>                 list_del_init(&bt->running_list);
>>> -               spin_unlock_irq(&running_trace_lock);
>>> +               raw_spin_unlock_irq(&running_trace_lock);
>>>                 relay_flush(bt->rchan);
>>>         }
>>>
>>> Causing the build error. v5 adds that. Sorry again for the confusion.
>>
>> Right, that's why I asked if a) you had even built this patch, and b) if
>> you had tested it as well.
>>
> 
> Yes, I had. But I had two versions of it. One for RHEL and one for
> torvalds/master. I just picked the wrong branch when generating it.
> I apologize for the mess once more.

Alright, fair enough, mistakes happen. I think the patch looks fine, my
main dislike is that it's Yet Another things that needs special RT
handling. But I guess that's how it is...

-- 
Jens Axboe

