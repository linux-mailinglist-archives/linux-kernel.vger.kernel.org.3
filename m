Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73350C8C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiDWJqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiDWJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:46:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59718F99C6;
        Sat, 23 Apr 2022 02:43:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p12so12658766lfs.5;
        Sat, 23 Apr 2022 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUBbhwe77dvZymIbzfQlDVdZ71HesftAxXVr2puB39s=;
        b=JJ0iSM3VYZoIZRIpbt+qdyzSNtOQgywj8kqmG8PHbdUkOo1KGNeb12i8bAo5u70z+g
         MZlgZxP1EneHa0ustMXWUaJhX43t0t7YNKNQ9vT+dHe+Ou16NacALKuV6sp1Wb/FjBE8
         x7ygmXnhuQDSBvdntnLZ1cQ0N3lvVaxoKWBTxw8eK68Ld/iywY+MUEsTIwWjUSf7Mb3s
         PsdP1LXHd3e6QviWp1u0CFm4op8u49bnJxJVttFXIEviXfXNOzAyAdzJjsOLThr5mNOB
         D6Us1ANF7hGKl1m30NOrVr6oDirV3Ow8BpF98EMpOWI0s8t5L4Jtqamb6mkcg/x+TKl2
         Nlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUBbhwe77dvZymIbzfQlDVdZ71HesftAxXVr2puB39s=;
        b=FMfM+GVG7y50x8DQuGV7uGpdA0eYn1vtjER4wnRqpqfIcS7GUD9s03rZg5AMpqRPMo
         r9/Rs3YwLDJOAsGzvaFF4IJHAUAu3A5sucbUcIT3CjMjqF1P+O1Tr+hFC4mcaf4Uieac
         F+eYxVTULvYSD+Mm+5W9+QV/L4RAlI/j3+CZIXSXLwyLTsuF6hWa/SmbKGv7XeNB+Gnv
         OnqFkawTfuKxmI9rpxepXx6tDPfXsKDP91wKLOlkKDGCjBBaMADTQn6qXhm16hEe6CzK
         ALKIl9CzgzZl7JENQNZhJu3yCeRSThoKp8BDncGwIdJq/0saNzBQxWiSBHFci6VNOUT8
         nc4Q==
X-Gm-Message-State: AOAM532L8qnjj+oW8Z+ZHB0r0681Rx6WQBpPY6gYJEBbGZhIR9FbDPNT
        hSWc/wbD4pmYbUzsCT5IIqa7z4+4b0aiMf5A4cLtmUI0Wpw=
X-Google-Smtp-Source: ABdhPJx3PiAC4IN3QA9lLfbfNKn0dxG4BswJ6Gg/KxmIdi8iEhBA2vkKHLCN9u7rTYARgcOzD0Rd2Yol9EVH3M2fhm8=
X-Received: by 2002:a05:6512:400e:b0:450:e09d:c9a6 with SMTP id
 br14-20020a056512400e00b00450e09dc9a6mr6411283lfb.243.1650707005488; Sat, 23
 Apr 2022 02:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
 <20220418143404.55c8fcab@gandalf.local.home> <CAGcnep8bH4Nncbt3t+VRLff35ZyD8JyzHcEgkq-u6TEq47jqzQ@mail.gmail.com>
 <CAGcnep_Gx+3KiUvDVronYKn_divU3OM-RQEOPZakv7MRYh4EJw@mail.gmail.com>
 <20220420114454.69ab108c@gandalf.local.home> <20220420122633.55d4ff6b@gandalf.local.home>
 <CAGcnep86pd2trfTovU8_z1msOstx7gKCdndm=pHLDGTy+_K7=g@mail.gmail.com>
 <20220421085047.2cb8edf9@gandalf.local.home> <CAGcnep9Ez-S962vukR_a=otzcSxDRo5HUW2vG_YCBanCfURGXw@mail.gmail.com>
 <20220422115234.613436e4@gandalf.local.home>
In-Reply-To: <20220422115234.613436e4@gandalf.local.home>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Sat, 23 Apr 2022 17:43:14 +0800
Message-ID: <CAGcnep_PH7FCnhjeON2y2--4pfMqmKuHqkP4puZ45PEzCDDQoA@mail.gmail.com>
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in multi_cpu_stop()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 22 Apr 2022 18:45:46 +0800
> patrick wang <patrick.wang.shcn@gmail.com> wrote:
>
> > Yes, and not just RISC-V. It's arch-independent. It's the internal change of
> > stop machine implementation.
> >
> > ----------------------------------------------------------------
> > Former stop machine wait loop:
> > do {
> >     cpu_relax(); => macro
> >     ...
> > } while (curstate != STOPMACHINE_EXIT);
> > -----------------------------------------------------------------
> > Current stop machine wait loop:
> > do {
> >     stop_machine_yield(cpumask); => function (notraced)
> >     ...
> >     touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
> >     ...
> >     rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
> > } while (curstate != MULTI_STOP_EXIT);
> > ------------------------------------------------------------------
>
> That makes much more sense. Can you add that to the change log.
>

Sure, I will rewrite the log message. And thank you for the comments
and advices.

Thanks,
Patrick


> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve
