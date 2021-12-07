Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19C46C281
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhLGSSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhLGSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:18:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E09EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:14:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 481A1B81DEF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C12C341C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:14:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MHP/4O1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638900869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwNslQoXPinByXTpxhYXCGGWOZfKDlvX4xpCUUKUGgk=;
        b=MHP/4O1WTL9agl+VhJOpB0PrFdw1/yOZo463LhWX1q249s+FQOkEcy6ojBIto0w1TQlAXd
        8oqwiakQQFVmk5yf1wdeoflR7gHd45KRVwfa4JslOf90EUIpvmIb6vFi2SohXf7PQLW8DA
        B/DvKWzt4yNhjcXkMJVSi4FXYQu0FPE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c958123 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 7 Dec 2021 18:14:28 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id g17so43060085ybe.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:14:28 -0800 (PST)
X-Gm-Message-State: AOAM530RtgkEjlSw2QJlGF3uIy9t1uQ+CPMCfaYCo7qPxwrLXW/U6JnC
        59MX+e3eqlIJ3JbzHFFhtEZ3FDPOvFS6NJ0XoJ8=
X-Google-Smtp-Source: ABdhPJyWUkV7CzZNXSHc2Obko2AZj+qS0FHRB89aMRqph0qTGHM7qbAoy7MZjtiqYF3YOzSaY3MpumtRxnYrCQE0RCY=
X-Received: by 2002:a25:a427:: with SMTP id f36mr52388995ybi.245.1638900867702;
 Tue, 07 Dec 2021 10:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20211207121737.2347312-1-bigeasy@linutronix.de> <20211207121737.2347312-6-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-6-bigeasy@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Dec 2021 19:14:16 +0100
X-Gmail-Original-Message-ID: <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
Message-ID: <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thanks for this series.

> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1281,6 +1281,9 @@ static int irq_thread(void *data)
>                 if (action_ret == IRQ_WAKE_THREAD)
>                         irq_wake_secondary(desc, action);
>
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       process_interrupt_randomness();
> +

Adding a path from irq_thread() (and complicating the callgraph)
strikes me as a rather large hammer to solve this problem with. Maybe
it's the only way. But I wonder:

> on the lock if contended. The extraction of entropy (extract_buf())
> needs a few cycles more because it performs additionally few
> SHA1 transformations. This takes around 5-10us on a testing box (E5-2650
> 32 Cores, 2way NUMA) and is negligible.
> The frequent invocation of the IOCTLs RNDADDTOENTCNT and RNDRESEEDCRNG
> on multiple CPUs in parallel leads to filling and depletion of the pool
> which in turn results in heavy contention on the lock. The spinning with
> disabled interrupts on multiple CPUs leads to latencies of at least
> 100us on the same machine which is no longer acceptable.

I wonder if this problem would partially go away if, instead, I can
figure out how to make extract_buf() faster? I'd like to replace sha1
in there with something else anyway. I'm not sure what sorts of
speedups I could get, but perhaps something could be eked out. Would
this be viable? Or do you think that even with various speedups the
problem would still exist in one way or another?

Alternatively, is there a different locking scheme that would
prioritize the irq path mostly winning and having the ioctl path
spinning instead?

Also, just curious, what is running RNDRESEEDCRNG so much on a
PREEMPT_RT system and why?

Jason
