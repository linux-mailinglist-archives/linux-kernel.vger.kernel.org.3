Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF515A6F14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiH3VXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiH3VXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:23:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176347E81C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:23:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w8so8225907lft.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=v8SwXnsLuxOdqwUfyzfH2fczR46LOWwgMZYtiUIQA3Q=;
        b=G8yiZ6d85yV+hqHcvHGVnVjyUQIk6mO7D+0QG/UIMzj6QN0wdR4nOztjIaWsTzycBK
         3saSVq/buexfCDjCAIXpjEqqBrO/AOF8+jDcvKsMlOWVshRaASqABOypsYBuUUa7GIs8
         Vtew8MwipYTwaoqYo9tGH1INg+cRscHkfIcITRVIIj9luExWOe3Kv9U4ACXaZ5lVchO1
         f0lIuzvv3id5kjuEnURKBD0wOa2lehh9G8JamW+/pnVxPtWkzqQSZsztJ+90LCSOpAgS
         D0GMmX7YPqsVkjQyJWvjuP0cqvvpp+4/F1c469u1GATN5lKskrAhAggRJrGvLnrOndBP
         Uz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=v8SwXnsLuxOdqwUfyzfH2fczR46LOWwgMZYtiUIQA3Q=;
        b=vvosJzL8nfqqLbm09AQgsiaNr2kuDCYeH1XLYJ6reHfFVOZKTyiyPmIaZ+p9HjJlf7
         Skw6eS5xmAHCRiVECLdpC4ewB1WOCKQLjd3yH/Vp755JqYeP3bGUw5FHusCWDT8NDuNj
         NzaLhnEJZRrw6TPB9kSrPnkGl8ftyuFT8iaLySLUtsJDscdhAMJWue6vILVDJo1AwjxE
         sHimyaGArBUTq++/ZD5s4Em/WkdE06MyVTmhgamuKYT8gkAPXhFEVm3fZTRVZ4qOHFYc
         uPUp+On9p1SNcJXgp0nBxpmPjx2psXGuvRmXhY+obZh4L3rBL96h6EyFMNH3BHswLArA
         4A/w==
X-Gm-Message-State: ACgBeo1XhAAFnVx+eSgqmmViDq96SZD9AL8GPNiLrFd2tRncJTtOWDQl
        8oGS4usu3nvTOd2CYcMuIABGAdTbY1t74G/yMSQ=
X-Google-Smtp-Source: AA6agR5Zz3JWdIKXMQsu+RsdW2izcbcRmRW3JS3g5/sVeJSMAvMFe7k3uWKZIBIGoA+XnhUqIPgCEXWd/MqvZd4Q7Uc=
X-Received: by 2002:a05:6512:328d:b0:494:8238:1c with SMTP id
 p13-20020a056512328d00b004948238001cmr911251lfe.416.1661894616217; Tue, 30
 Aug 2022 14:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830014356.5364-1-avagin@gmail.com> <20220830014356.5364-5-avagin@gmail.com>
 <20220830104310.cpacj4dxqpgucwh3@wittgenstein>
In-Reply-To: <20220830104310.cpacj4dxqpgucwh3@wittgenstein>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 30 Aug 2022 14:23:24 -0700
Message-ID: <CANaxB-x-TAJLNVKVwDm55wVrHo0YxewuU_+7ast+63Q18eT4gQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] seccomp: add the synchronous mode for seccomp_unotify
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 3:43 AM Christian Brauner <brauner@kernel.org> wrot=
e:
>
> On Mon, Aug 29, 2022 at 06:43:56PM -0700, Andrei Vagin wrote:
> > seccomp_unotify allows more privileged processes does actions on behalf
> > of less privileged processes.
> >
> > In many cases, the workflow is fully synchronous. It means a target
> > process triggers a system call and passes controls to a supervisor
> > process that handles the system call and returns controls to the target
> > process. In this context, "synchronous" means that only one process is
> > running and another one is waiting.
> >
> > There is the WF_CURRENT_CPU flag that is used to advise the scheduler t=
o
> > move the wakee to the current CPU. For such synchronous workflows, it
> > makes context switches a few times faster.
> >
> > Right now, each interaction takes 12=C2=B5s. With this patch, it takes =
about
> > 3=C2=B5s.
>
> Seems like a nice idea though I leave it to the sched people to judge
> whether this is sane or not. So the supervisor which gets woken will be
> moved to the current cpu in this synchronous scenario.
>
> I have no strong opinions on this patch. There are two things I wonder
> about. First, how meaningful is that speed up given that the supervisor
> will most often do a lot of heavy-handed things anyway.

I would not use the "most often" phrase in this case;). It is true for LXC-=
like
use cases when we need to handle rare syscalls. In this case, the performan=
ce
of this interface doesn't play a big role. But my use case is very differen=
t. I
have a prototype of the gVisor platform, where seccomp is used to trap
guest system calls. In this case, the difference between 12=C2=B5s and 3=C2=
=B5s is
tremendous.

The idea of WF_CURRENT_CPU is not mine. I spied it from the umcg series.
I took the second patch from that series without any changes.

>
> Second, this flag is a very specific thing and I wonder how much
> userspace will really use this and what's more use this correctly.
>
> Just to note that LXD - one of the biggest user of this feature - isn't
> synchronous iiuc for example. Each container gets a separate seccomp
> supervisor thread (well, go routine but whatever) which exposes a socket
> that the container manager connects to and sends the seccomp
> notifications it received from its payload according to an api we
> established. And each notification is handled in a separate thread
> (again, go routine but whatever).

It could be synchronous if seccomp events had been handled in [lxc monitor]=
. But
right now, [lxc monitor] is just a proxy. In this case, you are right, lxc =
will
not get any benefits by setting this flag. But we can look at this from ano=
ther
side. If we add these changes, we will have another big user of the interfa=
ce. I
think the number of gVisor containers that are started each day is comparab=
le
with the number of LXC/LXD containers.

>
> >
> > This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
> > it used to enable the sync mode.
> >
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  include/uapi/linux/seccomp.h |  4 ++++
> >  kernel/seccomp.c             | 35 +++++++++++++++++++++++++++++++++--
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.=
h
> > index 0fdc6ef02b94..dbfc9b37fcae 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -115,6 +115,8 @@ struct seccomp_notif_resp {
> >       __u32 flags;
> >  };
> >

<snip>

> >
> >  #ifdef SECCOMP_ARCH_NATIVE
> > @@ -1117,7 +1120,10 @@ static int seccomp_do_user_notification(int this=
_syscall,
> >       INIT_LIST_HEAD(&n.addfd);
> >
> >       atomic_add(1, &match->notif->requests);
> > -     wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> > +     if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> > +             wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLR=
DNORM);
> > +     else
> > +             wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
>
> (We're accumulating a lot of conditional wake primitives in the notifier.=
)
>

I am not sure that I understand what you mean here.

Thanks,
Andrei.
