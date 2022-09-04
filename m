Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760FB5AC3B7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiIDJzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiIDJzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 05:55:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCF1AD8A;
        Sun,  4 Sep 2022 02:55:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id az27so7731324wrb.6;
        Sun, 04 Sep 2022 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=CX6HyoXoNrpwT2zqgVQd1bn03u5+Dy2MPfI5sUj0GEQ=;
        b=fd7uRQSzhyvkRgFe34gxiqFihsATcR/JD3WsAWdqwYljihTT8Gn9Di2CXiJmWKoOOL
         9V4fEUpC/c3iSZwVcQU0IuG1ZfUi5BCXpmuutkuuJg49cg3GO2dKWFxwHTgwNp+aPysd
         au60dNAr2jNDZjHtJODm5cyfU7UN+5D0Webr6N+xRnIkWQMsLZuP8+KxGZrc/g4P6Aiq
         nlKQtxq7KQQ5m1xtBSalVKAtRY1GxxaH+/gpamKwVNUMHq8ZBsncqguIO9fWfGbBU+AB
         tMSVeIM/UsCRILIBtyLmtOnc7tvogaMGNsff1dzg+Yy3LqubpvlWxaayfKaB9szcaoCe
         fEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CX6HyoXoNrpwT2zqgVQd1bn03u5+Dy2MPfI5sUj0GEQ=;
        b=isE9InWqLEldmHQQ2NNpWBOP3IRPwAvdzdJ5HsbgpEGW0zFAQ/fdGSz83tkKBL8Vlz
         quxE+2dFFd+JdnDfHvxCBBacMSukrhBN6ObWtnCL4uFUK8daMW6/XsIQGWrnrcDaloed
         XGtsFQcQFEM+SA0E3qsRfz+2ouWeGG0/PHnaxfwSYcfJ93Jmn/RG8UJvCirBzQrdGoRm
         M3t/fkThlHYIAsi8OKdam4jsUeL9kptDD2zImEaqLZs3IiEYZb3M5MP4Y/71LmA8QnzF
         bsGSMM3etINcNYgnj810u4sf6mjO1Ufhc9euABimDdqOFxK31h6Xpv5ctY3ixjS8DL+Y
         zfEg==
X-Gm-Message-State: ACgBeo3G8u2NEx33SDEFSSNIXbyylS1+hJx/MdF0cKueAUEw3Hn34aJ1
        VB4JEsNX6TMbVvKDiNd9WOs=
X-Google-Smtp-Source: AA6agR5CBJYThzh9FyBWSfNYoYmprrRAlNbCf5SuASa5Me4mWcaDtXXWFeWXJZ1L2uBCfi+W7k4bPg==
X-Received: by 2002:a5d:6e10:0:b0:226:ed14:e340 with SMTP id h16-20020a5d6e10000000b00226ed14e340mr11166252wrz.122.1662285299969;
        Sun, 04 Sep 2022 02:54:59 -0700 (PDT)
Received: from gmail.com (1F2EF751.nat.pool.telekom.hu. [31.46.247.81])
        by smtp.gmail.com with ESMTPSA id w4-20020adfd4c4000000b0021badf3cb26sm7092108wrk.63.2022.09.04.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 02:54:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 4 Sep 2022 11:54:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] sched/wait: Add wait_event_state()
Message-ID: <YxR18Qs8vqTpPFV5@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.989212021@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822114648.989212021@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Allows waiting with a custom @state.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/wait.h |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -931,6 +931,34 @@ extern int do_wait_intr_irq(wait_queue_h
>  	__ret;									\
>  })
>  
> +#define __wait_event_state(wq, condition, state)				\
> +	___wait_event(wq, condition, state, 0, 0, schedule())
> +
> +/**
> + * wait_event_state - sleep until a condition gets true
> + * @wq_head: the waitqueue to wait on
> + * @condition: a C expression for the event to wait for
> + * @state: state to sleep in
> + *
> + * The process is put to sleep (@state) until the @condition evaluates to true
> + * or a signal is received.  The @condition is checked each time the waitqueue
> + * @wq_head is woken up.

Documentation inconsistency nit: if TASK_INTERRUPTIBLE isn't in @state then 
we won't wake up when a signal is received. This probably got copy-pasted 
from a signal variant.

> + *
> + * wake_up() has to be called after changing any variable that could
> + * change the result of the wait condition.
> + *
> + * The function will return -ERESTARTSYS if it was interrupted by a
> + * signal and 0 if @condition evaluated to true.

That's not unconditionally true either if !TASK_INTERRUPTIBLE.

> +#define wait_event_state(wq_head, condition, state)				\
> +({										\
> +	int __ret = 0;								\
> +	might_sleep();								\

Very small style consistency nit, the above should have a newline after 
local variables:

> +#define wait_event_state(wq_head, condition, state)				\
> +({										\
> +	int __ret = 0;								\
> +                                                                             \
> +	might_sleep();								\

Like most (but not all ... :-/ ) of the existing primitives have.

Thanks,

	Ingo
