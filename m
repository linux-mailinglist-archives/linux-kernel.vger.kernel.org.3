Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EA51A02F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbiEDNH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiEDNH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:07:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E2377E0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:03:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651669429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qnTydrMS1ksmehjR1Sl6xajLYwWe+zoyDgYNW/GZj1w=;
        b=RO2BH/TcggPsRNijCcOP8zR+Lo8UVQQ0WcBGQQ/AxGOcA/VecEAn7o+osJsn81GlCUVOB4
        b8W0jiLwk8gz2TW1ST2HNCfZ9cnHW/o7t9BiKRVbUDTmP2VONzBwTuxCe8hS0EPtmnpljB
        /BEQkR/pUkO8tEoEktLRKgbHv+aY+qdPFGu64mJwbLqiFKFA5OJV5S5K0eCO1gTDNv/+rh
        2JLbGmvjfHY39k9xE19cA2WrCcC4QodI2NoXAhSnRvyAI3yULTj86MmNJMH4dMs70zMyRc
        Kxuq9678kGZncg0zbeyhWcWHSh7Jf+IlEATiA0UNV+jW4YSEE/0/jere4EMztQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651669429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qnTydrMS1ksmehjR1Sl6xajLYwWe+zoyDgYNW/GZj1w=;
        b=Eyd/snTxo2U0d7A7rEeZjUIVMAZ6f+1uWn05fdJ1zNJyUxFJyfUIRXpa6uolhIJsaU0SBF
        lxshDIpJBoLXkADQ==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 13/13] task isolation: only TIF_TASK_ISOL if task
 isolation is enabled
In-Reply-To: <YnF+lbxJXiQMbS/a@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.333646565@fedora.localdomain> <87zgk7x93h.ffs@tglx>
 <YnF+lbxJXiQMbS/a@fuller.cnet>
Date:   Wed, 04 May 2022 15:03:48 +0200
Message-ID: <87k0b1jvpn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03 2022 at 16:12, Marcelo Tosatti wrote:
> On Wed, Apr 27, 2022 at 09:45:54AM +0200, Thomas Gleixner wrote:
> It seems to be inline with the remaining TIF_ bits:
>
>                 if (ti_work & _TIF_NOTIFY_RESUME)
>                         tracehook_notify_resume(regs);
>
> +               if (ti_work & _TIF_TASK_ISOL)
> +                       task_isol_exit_to_user_mode();
> +
>
>
> And there is even:

I know that the bit is defined, but that does still not make an argument.

> By looking at the code, we see the sites where this bit is set are:

Again. I'm able to read the patches myself.

> Would you prefer an explanation, in words, when these bits are set, when
> they are cleared?

No. The point is that contrary to TIF_NOTIFY_RESUME and other TIF bits,
this is going to end up being sprinkled all over the place.

With the current vmstat quiesce that's limited, but it's bound to
increase and spread simply because the whole thing has no semantics and
it's all headed to be adhoc cure for the isolation itch of the day.

Thanks,

        tglx

