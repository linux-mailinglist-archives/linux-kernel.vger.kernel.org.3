Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09E580113
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiGYPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8380C100A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658761257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVVcg4fb1qpmYjQBoT0WAZjG7ETXCUBRzVPgF3AP/2Q=;
        b=RAGnDgy96Mb0GLbueRQqjWdWZ3xlW2+iQB0ELom9FM2dLhUyTHeZgyKGTFqTD/GNp9IjIV
        5CIr1vZJSheoS+9ugx+xKoGoA/iEUuuw7CJb2O+kagslTLmkcSzegaXBv/JHpAhwCBOTLM
        iNxET8gN1FPp4c+/gqzBlpI8lfhRFR4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-Xr7cTTvXNci9987HNbpCew-1; Mon, 25 Jul 2022 11:00:56 -0400
X-MC-Unique: Xr7cTTvXNci9987HNbpCew-1
Received: by mail-wm1-f71.google.com with SMTP id r10-20020a05600c284a00b003a2ff6c9d6aso8821867wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kVVcg4fb1qpmYjQBoT0WAZjG7ETXCUBRzVPgF3AP/2Q=;
        b=aH1/XMs7hiEMUdLjkxU0fFffM+fPjnNxZOiAiu0KJUuoGJkMMRXhiEjqN0zz/UwFtX
         rgKmZb5TRhESUk7I4zqToVWpJYlUHzLAVq9QFFYqR2xXYeYc0LXJP3WUDDl0Po4Cr/Xm
         Urz3zisodUM0ZgJDPyYiMF41SfHM7WH0inD06MxokA/eEcwDupeUfB9vm/KkGhIjCNTv
         Twua6OFaTIx45mBz5iwdvNmRVjmL8x5QkVcuJIkYICLWUBkadknGgDxe69CDqkFBO7Ez
         +9yT7aROqY3EPujlOMvpv1HacUyyMsqs30P6bEWdh1jEXF17hf699wTs8ED62dNXuRRo
         EASA==
X-Gm-Message-State: AJIora8GpedKP5Y/NWcjbqGY5mZ9y6PqZ4DJO9eB2wmEV7qKobU7kdJA
        FbULUpOWxFA9JaQg2swMg+MTDYurXYYmR5ZQaHtfYO5Xb945FIKMKl+3nCVMbkHo57OnqTSwWT6
        m4GvKNKyKCKD/qzUks5wzy3Tk
X-Received: by 2002:a05:6000:18ad:b0:21d:9aca:379 with SMTP id b13-20020a05600018ad00b0021d9aca0379mr8105079wri.312.1658761255119;
        Mon, 25 Jul 2022 08:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vHj9hSR4P7nAWovsNOY3+EKhR4EvHmFRD7pnEKNTPWIbVlNZx3abdHWsfARuHjlsZgEa59Kg==
X-Received: by 2002:a05:6000:18ad:b0:21d:9aca:379 with SMTP id b13-20020a05600018ad00b0021d9aca0379mr8105055wri.312.1658761254832;
        Mon, 25 Jul 2022 08:00:54 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c0a1500b0039c454067ddsm15483817wmp.15.2022.07.25.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:00:53 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@infradead.org>,
        Chris Mason <clm@fb.com>, Eric Dumazet <edumazet@google.com>,
        George Spelvin <linux@sciencehorizons.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Len Brown <lenb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [Question] timers: trigger_dyntick_cpu() vs TIMER_DEFERRABLE
In-Reply-To: <20220725104356.GA2950296@lothringen>
References: <xhsmhedy9fsg5.mognet@vschneid.remote.csb>
 <20220725104356.GA2950296@lothringen>
Date:   Mon, 25 Jul 2022 16:00:52 +0100
Message-ID: <xhsmh5yjlfd97.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/22 12:43, Frederic Weisbecker wrote:
> On Mon, Jul 25, 2022 at 10:32:42AM +0100, Valentin Schneider wrote:
>> From what I grok out of get_nohz_timer_target(), under
>> timers_migration_enabled we should migrate the timer to an non-idle CPU
>> (or at the very least a non-isolated CPU) *before* enqueuing the
>> timer.
>
> That's not always the case. For example TIMER_PINNED timers might have
> to run on a buzy or isolated CPU.
>
> And note that even when (base->cpu == smp_processor_id()) we want to kick
> the current CPU with a self-IPI. This way we force, from IRQ-tail, the
> tick to recalculate the next deadline to fire, considering the new enqueued
> timer callback.
>

Right, tick_irq_exit() & friends... I'm still figuring the different
dependencies down there, but I think I can roughly map the bits of what
you're describing.

>> Without timers_migration_enabled (or if TIMER_PINNED), I don't see
>> anything that could migrate the timer elsewhere, so:
>>
>> Why bother kicking a NOHZ CPU for a deferrable timer if it is the next
>> expiring one? Per the definition:
>>
>>  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
>>  * system is busy, but will not cause a CPU to come out of idle just
>>  * to service it; instead, the timer will be serviced when the CPU
>>  * eventually wakes up with a subsequent non-deferrable timer.
>>
>> I tried to find some discussion over this in LKML, but found nothing.
>> v3 of the patch did *not* kick a CPU for a deferrable timer, but v4 (the
>> one that ended up merged) did (see below). Patch in question is:
>>
>>   a683f390b93f ("timers: Forward the wheel clock whenever possible")
>
> Because TIMER_DEFERRABLE timers should only be deferred when the CPU is
> in "nohz-idle". If the CPU runs an actual task with the tick shutdown
> ("nohz-full"), we should execute those deferrable timers.
>

Ah, that makes sense, thank you for highlighting the difference. The
comment *does* say "come out of *idle*", not *tickless*...

> Now that's the theory. In practice the deferrable timers are ignored by
> both nohz-idle and nohz-full when it comes to compute the next nohz delta.
> This is a mistake that is there since the introduction of nohz-full but I've
> always been scared to break some user setup while fixing it. Anyway things
> should look like this (untested):
>

IIUC that's making get_next_timer_interrupt() poke the deferrable base if the
CPU isn't tickless idle (IOW if it is tickless "busy" or ticking
idle). That makes sense from what you've written above, but I get your
apprehension (though AIUI "only" pinned deferrable timers should be
problematic, as the others should be migrated away).


Thanks again for your detailed reply!

