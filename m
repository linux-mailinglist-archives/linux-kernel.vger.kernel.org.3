Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684D15AFD73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIGH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:26:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB674CD8;
        Wed,  7 Sep 2022 00:26:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s23so8217631wmj.4;
        Wed, 07 Sep 2022 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=AU9jIKk+0h8ttZnRp33BBGtBNG5irk59lqDDStwccxw=;
        b=o2XFkV5YJyM2Y77cYaZx0C9+FoDVcTA9LUFoMJXSkHLRuMJUt8b0x7Q+7Tmlmp7t0g
         5s04Kx9YdO8aq+em8aN3UFVi+2Mly2JLTm+bk9KzYW5UYUOxmgF0jZYQfH00G9u5DXQa
         TLFccjCZQoErKRJ+jTk93X6foXOSk+FGyhu6P7JqpitD1VY5SKa5XO5n/wgpeLpwdHlG
         qx3rJDV9sZSR6WmB6EgwJUKAWtDiDSfasP+PRuJC002Sm1okhCJgNbY6zBmUtXlpYIji
         DknFG+7uiKrWc5xOyiSpF9XsAPUq9wQH/1fKMTRYuA6yw1erQ4KBSYzoCTavTFlXV1DL
         YW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AU9jIKk+0h8ttZnRp33BBGtBNG5irk59lqDDStwccxw=;
        b=Ja+RDtyTqNpcJMzSKsI9J/IVUQxkfKt9Mf5oCVDhRcWr0UeoO5bCcF1onlranx4P0k
         cZkL9mmAWr1bvnKJt93oz2TK2ikYSrIlY+LDwYNHJl4GWURcxHVAOJelCcOS5NfolSx0
         jfrA4n9ywU8Zxw1V/f6KuQqdRVcCZ+fHQ8u2hrJV38rygQqsqMFML2LtfV6Jz09sdUAq
         Q6nIlYops8fLg8u67RXLOMMs2c5VnC63fPM6Q67VNsXKbRLbG+wn7ulmZqljipQJrJYF
         kMQDvL/+wAk/JxEPWK25o9vtL+cx02Q9k1KbwszndJaIEytfGcBiygR+ZqoADg8wIyF3
         Dr7w==
X-Gm-Message-State: ACgBeo3ds/LikNtQkPHU9IdwRUWmUVRpU3QrK2N1x+1ZvvWsJc3OFxds
        NYzMQbf3W3E6J6KLDsmmtno=
X-Google-Smtp-Source: AA6agR6b9zfoq4j8CIHOCQua3fR8YoXabzdd6pLg3yOHSEKfJhtp4yVPmxyDETeIqzVv9AQEETVFDg==
X-Received: by 2002:a1c:7214:0:b0:3a5:ea1c:c55b with SMTP id n20-20020a1c7214000000b003a5ea1cc55bmr16449906wmc.190.1662535588436;
        Wed, 07 Sep 2022 00:26:28 -0700 (PDT)
Received: from gmail.com (1F2EF41B.nat.pool.telekom.hu. [31.46.244.27])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0021e51c039c5sm15802567wrq.80.2022.09.07.00.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:26:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 7 Sep 2022 09:26:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] sched/wait: Add wait_event_state()
Message-ID: <YxhHknM8n/b3W7wr@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.989212021@infradead.org>
 <YxR18Qs8vqTpPFV5@gmail.com>
 <YxcqR/hSTwLnk3RK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxcqR/hSTwLnk3RK@hirez.programming.kicks-ass.net>
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

> On Sun, Sep 04, 2022 at 11:54:57AM +0200, Ingo Molnar wrote:
> > > +/**
> > > + * wait_event_state - sleep until a condition gets true
> > > + * @wq_head: the waitqueue to wait on
> > > + * @condition: a C expression for the event to wait for
> > > + * @state: state to sleep in
> > > + *
> > > + * The process is put to sleep (@state) until the @condition evaluates to true
> > > + * or a signal is received.  The @condition is checked each time the waitqueue
> > > + * @wq_head is woken up.
> > 
> > Documentation inconsistency nit: if TASK_INTERRUPTIBLE isn't in @state then 
> > we won't wake up when a signal is received. This probably got copy-pasted 
> > from a signal variant.
> > 
> > > + *
> > > + * wake_up() has to be called after changing any variable that could
> > > + * change the result of the wait condition.
> > > + *
> > > + * The function will return -ERESTARTSYS if it was interrupted by a
> > > + * signal and 0 if @condition evaluated to true.
> > 
> > That's not unconditionally true either if !TASK_INTERRUPTIBLE.
> 
> 
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -942,14 +942,14 @@ extern int do_wait_intr_irq(wait_queue_h
>   * @state: state to sleep in
>   *
>   * The process is put to sleep (@state) until the @condition evaluates to true
> - * or a signal is received.  The @condition is checked each time the waitqueue
> - * @wq_head is woken up.
> + * or a signal is received (when allowed by @state).  The @condition is checked
> + * each time the waitqueue @wq_head is woken up.
>   *
>   * wake_up() has to be called after changing any variable that could
>   * change the result of the wait condition.
>   *
> - * The function will return -ERESTARTSYS if it was interrupted by a
> - * signal and 0 if @condition evaluated to true.
> + * The function will return -ERESTARTSYS if it was interrupted by a signal
> + * (when allowed by @state) and 0 if @condition evaluated to true.
>   */

Reviewed-by: Ingo Molnar <mingo@kernel.org>

> > > +#define wait_event_state(wq_head, condition, state)				\
> > > +({										\
> > > +	int __ret = 0;								\
> > > +                                                                             \
> > > +	might_sleep();								\
> > 
> > Like most (but not all ... :-/ ) of the existing primitives have.
> 
> Yeah, I'm going to leave it as is.

Will queue up a cleanup patch, should I ever notice this detail again ... :-)

Thanks,

	Ingo
