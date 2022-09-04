Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7320A5AC3FA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiIDKo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiIDKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:44:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3491402D;
        Sun,  4 Sep 2022 03:44:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k9so7863471wri.0;
        Sun, 04 Sep 2022 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=UJo7N4S/gDgBACMLUO0jnBhvtI1gw2X7O4ukjYCbnTA=;
        b=MNukhhGVvX/IsGsjm065iUZ8PKagpMcK0/FALHyHQFvgVuGecRMncg4qlIwYP4d4cS
         fIZqATLRa0peFnbul5VAx46V1KW6cHqwY2qN1HmGDDIsEtXQN+2UVMY8TDxvsTzueIff
         GOLJPbsYQMnZ5nv45N1hykwKVSsdx3CnDwwBbK+V4YMC8Y2+2RvKLW4a5olJUxMcZhsJ
         3UeMvhxbPbR0ChwYdAZVkRXdKjDi1Zrd1aiwuc98GE5ZPq0JlkROccUQ+pwLXBq0ZKLr
         KsjoaLLearEjHoZQv+uHJEPSEhqQEmPr/tbl3NycrtuBRJ0V4C1WD+mAydl0a4pSIPmJ
         fcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UJo7N4S/gDgBACMLUO0jnBhvtI1gw2X7O4ukjYCbnTA=;
        b=WYa8rALF7ZroBqCCvwtSf73PLZU2Xu45kmHuy2skbOhGib5bUxR+b4igNhHu2IdROM
         NTaZleDsRxJHaPekGaLwFuHW21yvLHXDcZ0wAFNmrogVqqTQ/P6pMSpMfY2A/SC4eSvS
         mkjx9FFAdI29mP9XFP3L2d/nljJM0SOUQ62KPLUNDEmSUtXHnBFE01ecoarl3Ic1uQn0
         FaNXTd9ZUor+mvjGyDGDEcHms6sC6O1WElh2UOu4BMhnNoECxV7mZsg1Fnl0DvdnQTpv
         VPerXlM3qkW9+NkatC9MoQYJ7+Pz6nKbPIQvMEyX9MN9Niz7h5rUvcDLRUFQXShTsTM5
         ln3Q==
X-Gm-Message-State: ACgBeo1DhRuX8Lhdv6ioyoUJwqr2vZtssby68/nUViMaBvxUTyRcqTSs
        MR/ApmndnbFgou+D4YsqW64=
X-Google-Smtp-Source: AA6agR4asM8OZjXpaVZ8yD70TW59ovnZRggO2KfkuxgTwquzcgPx+bzcnBnhvQLjctWseUy9WCiFkg==
X-Received: by 2002:a5d:5989:0:b0:221:7c34:3943 with SMTP id n9-20020a5d5989000000b002217c343943mr20557508wri.441.1662288279024;
        Sun, 04 Sep 2022 03:44:39 -0700 (PDT)
Received: from gmail.com (1F2EF751.nat.pool.telekom.hu. [31.46.247.81])
        by smtp.gmail.com with ESMTPSA id bg32-20020a05600c3ca000b003a536d5aa2esm7969573wmb.11.2022.09.04.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 03:44:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 4 Sep 2022 12:44:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] sched: Change wait_task_inactive()s match_state
Message-ID: <YxSBlPb/oZ6x0jfw@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.856734578@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822114648.856734578@infradead.org>
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

> Make wait_task_inactive()'s @match_state work like ttwu()'s @state.
> 
> That is, instead of an equal comparison, use it as a mask. This allows
> matching multiple block conditions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3295,7 +3295,7 @@ unsigned long wait_task_inactive(struct
>  		 * is actually now running somewhere else!
>  		 */
>  		while (task_running(rq, p)) {
> -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> +			if (match_state && !(READ_ONCE(p->__state) & match_state))
>  				return 0;

We lose the unlikely annotation there - but I guess it probably never 
really mattered anyway?

Suggestion #1:

- Shouldn't we rename task_running() to something like task_on_cpu()? The 
  task_running() primitive is similar to TASK_RUNNING but is not based off 
  any TASK_FLAGS.

Suggestion #2:

- Shouldn't we eventually standardize on task->on_cpu on UP kernels too? 
  They don't really matter anymore, and doing so removes #ifdefs and makes 
  the code easier to read.


>  			cpu_relax();
>  		}
> @@ -3310,7 +3310,7 @@ unsigned long wait_task_inactive(struct
>  		running = task_running(rq, p);
>  		queued = task_on_rq_queued(p);
>  		ncsw = 0;
> -		if (!match_state || READ_ONCE(p->__state) == match_state)
> +		if (!match_state || (READ_ONCE(p->__state) & match_state))
>  			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
>  		task_rq_unlock(rq, p, &rf);

Suggestion #3:

- Couldn't the following users with a 0 mask:

    drivers/powercap/idle_inject.c:         wait_task_inactive(iit->tsk, 0);
    fs/coredump.c:                  wait_task_inactive(ptr->task, 0);

  Use ~0 instead (exposed as TASK_ANY or so) and then we can drop the
  !match_state special case?

  They'd do something like:

    drivers/powercap/idle_inject.c:         wait_task_inactive(iit->tsk, TASK_ANY);
    fs/coredump.c:                  wait_task_inactive(ptr->task, TASK_ANY);

  It's not an entirely 100% equivalent transformation though, but looks OK 
  at first sight: ->__state will be some nonzero mask for genuine tasks 
  waiting to schedule out, so any match will be functionally the same as a 
  0 flag telling us not to check any of the bits, right? I might be missing 
  something though.

Thanks,

	Ingo
