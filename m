Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E563A509EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388828AbiDULjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDULjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:39:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F521274;
        Thu, 21 Apr 2022 04:36:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h11so5412627ljb.2;
        Thu, 21 Apr 2022 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49W09Hi0ucwvaw7LH7H1/53UY+k/F0pMUfAtsI++SNc=;
        b=J2i9Nhq/c/OtxShDiuXluRae/uPut13A3FKFPsBpIFlxjxQoJBe2WjD+I55CJSt2cq
         PW/x/ZpJ+6ZBQmKi5x8izRtoRmmwzEmXz6Bbqf9/qklakN15Df2pcd1jHc8wV1K0FvKB
         uQmVDKHi5qIZ+kcehvmvtbYuOHuCmU6EN8sxGQxYUivEoaUt5tgm1fwLs7SU5tCYOa7C
         kVFc7/wM897Aspp2J3Z9FgSiaOCmZsSnzJRux1mHR1vWXHoYG6Tr0a76pbZNUcZZBIw3
         wGrRxbKzcbsFIuIH2L0eW5tNm1PM+u2qsT+DODkBKDKjlLC5cskbK1y1UqwHsggYYtDx
         23YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49W09Hi0ucwvaw7LH7H1/53UY+k/F0pMUfAtsI++SNc=;
        b=3Y03O+U1bzvn5mjPXY0DIB3G995f0IPANCrU9BEAUEdO00WQGurTqVmlMAgLUAwt6m
         mJX3ufykalZfFjK68OtYdJ8y4J4rg9Icr93QEZTzrCYtV9MxtYC3QST6VOAbKOi+Oq2P
         bpC5Zw1ehr4Hykd6pMPBvADtReYNs49ZxZZ3ZKgvvwp/WqD7XCuq4OaolVcnUBUhm9RN
         BjhWVy0bNRu3EI+ML7uH+hU19Btm5VGL4BSyNAzEmIczGXJ0LEtb61b54614TOWoIL8l
         HuASrbCQN4HqabHJw+FXU87CwFw0oAouWtJ7nDIN57rO0Frgu4K+OoKAGN+8gl/JH2jG
         rQgA==
X-Gm-Message-State: AOAM531SVL3O1AgKrr52RQ6kmJ62HMoaQ1SrjhHSiKGFIIp055fvcTSC
        wly8fXHmJuqhILxzVRYZqQhB+E24thTSj5YUFxeDJd0P
X-Google-Smtp-Source: ABdhPJxtZZmSrVU+QMOhFjZ7npnYbSW9iSMdkFiT6QxY//Qz0oOTsr60Wj4SIFxuyh86dCjwaAKaxIsiufEeSOwB32k=
X-Received: by 2002:a05:651c:1422:b0:24e:e14e:b817 with SMTP id
 u34-20020a05651c142200b0024ee14eb817mr3608722lje.98.1650540977969; Thu, 21
 Apr 2022 04:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
 <20220418143404.55c8fcab@gandalf.local.home> <CAGcnep8bH4Nncbt3t+VRLff35ZyD8JyzHcEgkq-u6TEq47jqzQ@mail.gmail.com>
 <CAGcnep_Gx+3KiUvDVronYKn_divU3OM-RQEOPZakv7MRYh4EJw@mail.gmail.com>
 <20220420114454.69ab108c@gandalf.local.home> <20220420122633.55d4ff6b@gandalf.local.home>
In-Reply-To: <20220420122633.55d4ff6b@gandalf.local.home>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Thu, 21 Apr 2022 19:36:06 +0800
Message-ID: <CAGcnep86pd2trfTovU8_z1msOstx7gKCdndm=pHLDGTy+_K7=g@mail.gmail.com>
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

On Thu, Apr 21, 2022 at 12:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 20 Apr 2022 11:44:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Interesting. On x86 when we used stop machine[*] it was not an issue to
> modify the code that is being executed in stop machine. I'm curious to
> exactly what the issue is if something does get traced in the stop machine
> processing. Why does it crash?

I looked up the commit history. When x86 turned to breakpoints, stop
machine's state machine loop had no calls during waiting. So there
was no function being called during modifying code. Which means
there were no other cpus would load those instructions to be updated
in this period. While the stop machine currently will call other functions
and the call chain is fairly deep. So it may not quite be suitable for ftrace
now because it can not make sure the instructions within its own call
chain are updated atomically.

> > [*] You really should come up with a better way than stop machine, because
> > the stop machine method is really disruptive, can you not use the break
> > point method for updates?
>
> Talk about dejavu!
>
>   https://lore.kernel.org/all/mhng-62c2ef00-fb64-48c3-a2bb-43b2799161bf@palmer-ri-x1c9/
>

Right, breakpoint should be better.

This stall happens on my qemu machine too, maybe it's qemu related.

Thanks,
Patrick
