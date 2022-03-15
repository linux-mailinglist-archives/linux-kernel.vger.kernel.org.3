Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE74DA0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350421AbiCORGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbiCORGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:06:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F6764D;
        Tue, 15 Mar 2022 10:04:53 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d07ae0b1c0so210248987b3.2;
        Tue, 15 Mar 2022 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+2Wx94qR8PPYpieBxCaSAJOgTPVSgK4NLclIZE2QSE=;
        b=VU2ZTPE4gsQsOfyPkhKPVHADz9GDZAE/HlAGRCEUu+xUDcx/Wf2ta1VdEEEq7t756w
         fsFJ0cvcNp7ucnzA2PC/KlAPaW93HjwlujXe8zJKny8YHiS2mmY0ny/OjLModqDJ1too
         2kjjl7r1KQj7a9CGx8+yfIBIUBTZSmgj5z4tjkaLbywUQvPosXlryEUGRtNQpwDX6MJ4
         8vVF5S8FVXCi7SmoZAhAmLCdLjMOjvk1D+lPRxi+Y5z5Gb0gOI1K5XjZBcoTnl5YmoLa
         OvdRqcIcOQ1YZ2m6FHLyU7jjtHldTA6Zn3uZjIlDmvRLFjJW0a49qj/5nwHdBXSyGiag
         sYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+2Wx94qR8PPYpieBxCaSAJOgTPVSgK4NLclIZE2QSE=;
        b=j/WJm1zNImPoSjbhnDpT9RAgu+Jt0kWusPxmLnGLSOldTRUL4wQsKTxImn0bzbll29
         ECU4FjJha67iXof0QP81rNVvWVY+HaXY7X0yhN73tP8H0oJx0qnD1VFoTKeH2ejJ9g+l
         QaML+6ZSlFkqOPlbqzhv1XfdLh8GPocSdJdd6LpWOIP20nLS5uCzeF3mcdp5Lq6XOSum
         rbMZSfIbaIzNMz9tzxMUxRYXB96LCI3nYyht2QRO8v8lMdlY2JiVhT3rFhob+V9gX9rN
         XViu/72EtB07PzlG442JjRRJrm2XwRfQ2DavS66uuylkPcj9JIAqLBuwUb4tz2PV1gfz
         FKKQ==
X-Gm-Message-State: AOAM533G1BqxXZE/tLJKv6x6LFy3Wq1oN1UArDUgBDiW6xmpgPOIxIvf
        8cXVKdI44ywK5K4Pqz2Il/l0dJXJyGye7YIu4Pw=
X-Google-Smtp-Source: ABdhPJyNXyKLd6XUld5HuAr0JLq083IQ0Kq+tt6eTffugaX0Zc++5S7Oc9JYPGLEx9Rc+UIeW91TAIkUVjWrceahyTY=
X-Received: by 2002:a81:196:0:b0:2dc:73c9:925 with SMTP id 144-20020a810196000000b002dc73c90925mr25025274ywb.481.1647363892467;
 Tue, 15 Mar 2022 10:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220315085549.22033-1-lukas.bulwahn@gmail.com> <20220315165228.GD4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220315165228.GD4285@paulmck-ThinkPad-P17-Gen-1>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 15 Mar 2022 18:04:41 +0100
Message-ID: <CAKXUXMy7TqCZjVMKwiQJj5bYUDpdGZE2hhbB2WfSA2AX1hM=zQ@mail.gmail.com>
Subject: Re: [PATCH] srcu: drop the needless initialization in srcu_gp_start()
To:     Paul McKenny <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 5:52 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Mar 15, 2022 at 09:55:49AM +0100, Lukas Bulwahn wrote:
> > Commit 9c7ef4c30f12 ("srcu: Make Tree SRCU able to operate without snp_node
> > array") initializes the local variable sdp differently depending on the
> > srcu's state in srcu_gp_start().
> >
> > Hence, the initialization of sdp with the variable definition is not used
> > before its second initialization.
> >
> > Drop the needless initialization in srcu_gp_start() to have clear code.
> >
> > No functional change. Some changes in the resulting object code due to
> > various rearrangements by the compiler.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Paul, please pick this minor non-urgent clean-up patch.
>
> Good eyes, thank you!
>
> I have pulled this in for testing and review.  If things go will,
> I expect to push it into the v5.19 merge window (that is, not the one
> that will likely open next week, but the one after that).
>
> As usual, I could not resist wordsmithing the commit log.  Could you
> please check out the wordsmithed version below to make sure that I did
> not mess something up?
>

Wordsmithing was good. I am basically still reading in your versions
what I intended to state with my commit message; +1!

And of course, you are a native speaker; so, I trust your English is
better than mine.

Lukas

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit a0c59d99e87c52d6832e1ad39421b4a4386cdfd6
> Author: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Date:   Tue Mar 15 09:55:49 2022 +0100
>
>     srcu: Drop needless initialization of sdp in srcu_gp_start()
>
>     Commit 9c7ef4c30f12 ("srcu: Make Tree SRCU able to operate without
>     snp_node array") initializes the local variable sdp differently depending
>     on the srcu's state in srcu_gp_start().  Either way, this initialization
>     overwrites the value used when sdp is defined.
>
>     This commit therefore drops this pointless definition-time initialization.
>     Although there is no functional change, compiler code generation may
>     be affected.
>
>     Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index e78b1c7929d6..3bc8267c5d0b 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -609,7 +609,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>   */
>  static void srcu_gp_start(struct srcu_struct *ssp)
>  {
> -       struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
> +       struct srcu_data *sdp;
>         int state;
>
>         if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
