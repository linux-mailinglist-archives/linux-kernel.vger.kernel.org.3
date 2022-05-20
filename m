Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E5952F5EE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353986AbiETXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiETXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:02:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C34190D08
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:01:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p26so12474381eds.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HsuQmVX1S4/poujuFgWOoQhM5djyPUzLhLRMnoVmU0=;
        b=WSpYMVc/Q7WW7i0Fu/ChH1mchkvzMg6Mes0wXDmuC6zGVDOfUJQAViLFA2BaYaFBah
         k6QsRec5MtSCjtc+dBuR9CtFl6XLttX0gbCESKpVkiMHL96chB+r4ZA2ZOQzAK7CLjfs
         fTmIMYFaK6diUvnDNDbkpv3yK9R7TWvcybT+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HsuQmVX1S4/poujuFgWOoQhM5djyPUzLhLRMnoVmU0=;
        b=fpccVCxM24Bcc6CniIITkFmq2d3jt1JCLgiv5Zj0IHkmrWOAqaRVQRbanDzEjqkfEd
         r/lQe7q1v8+AjsU3s9nm7sENpcgMT4zBaDXLU6yFOSrfaPGeTE+D/4VqkbtpE+e6YA8h
         IfUSykRCy0Xj6Zfqt5rgpb69zDp8U7/EeI+mMfDlAmjCoJ7pApwOCHl5sKJlpTXhneVK
         8sxFsCplayvflngn1eYp+0ilo/+Bd+y9bszKtzoPvJmf2VA6cFe9NBKwiQG+DYIbLI7j
         hGXgi8tqpVHSyynpi+Ui+ZhG88MDc9qIAsGjnb+5wzkXoE1Jn7ntpUh6KUcec2p5a5wa
         x/Ow==
X-Gm-Message-State: AOAM531HErPyCjdDLcK2+8sY2jttGJojKEzjT29PCoUv/8cFC1VYE1UO
        5OPtslS1UaaPIiyxwrhKvORQ9YGVG2Q/ne9GbEc=
X-Google-Smtp-Source: ABdhPJxBfos6oofNhfVQpH8pIpaniwOS+n2tsP79GSE1B/ynp+t6iNoTMwzejoxEwYSlPByCzpzPiw==
X-Received: by 2002:aa7:ca44:0:b0:42a:cd1e:ac6f with SMTP id j4-20020aa7ca44000000b0042acd1eac6fmr13156739edt.328.1653087717811;
        Fri, 20 May 2022 16:01:57 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906004f00b006f3ef214dd9sm3160133ejg.63.2022.05.20.16.01.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 16:01:57 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id m20so2131376wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:01:56 -0700 (PDT)
X-Received: by 2002:a5d:5009:0:b0:20d:846:f4da with SMTP id
 e9-20020a5d5009000000b0020d0846f4damr10145504wrt.301.1653087716219; Fri, 20
 May 2022 16:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-3-ebiederm@xmission.com> <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
 <8735h52ief.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <8735h52ief.fsf@email.froward.int.ebiederm.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 16:01:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UxzB=jZuNtg--BFfKm_=7_Bex7G5fbjkV6Vf_tJQ+dTw@mail.gmail.com>
Message-ID: <CAD=FV=UxzB=jZuNtg--BFfKm_=7_Bex7G5fbjkV6Vf_tJQ+dTw@mail.gmail.com>
Subject: Re: [PATCH 03/16] kdb: Use real_parent when displaying a list of processes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 19, 2022 at 4:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > Hi,
> >
> > On Wed, May 18, 2022 at 3:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> kdb has a bug that when using the ps command to display a list of
> >> processes, if a process is being debugged the debugger as the parent
> >> process.
> >>
> >> This is silly, and I expect it never comes up in ptractice.  As there
> >> is very little point in using gdb and kdb simultaneously.  Update the
> >> code to use real_parent so that it is clear kdb does not want to
> >> display a debugger as the parent of a process.
> >
> > So I would tend to defer to Daniel, but I'm not convinced that the
> > behavior you describe for kdb today _is_ actually silly.
> >
> > If I was in kdb and I was listing processes, I might actually want to
> > see that a process's parent was set to gdb. Presumably that would tell
> > me extra information that might be relevant to my debug session.
> >
> > Personally, I'd rather add an extra piece of information into the list
> > showing the real parent if it's not the same as the parent. Then
> > you're not throwing away information.
>
> The name of the field is confusing for anyone who isn't intimate with
> the implementation details.  The function getppid returns
> tsk->real_parent->tgid.
>
> If kdb wants information of what the tracer is that is fine, but I
> recommend putting that information in another field.
>
> Given that the original description says give the information that ps
> gives my sense is that kdb is currently wrong.  Especially as it does
> not give you the actual parentage anywhere.
>
> I can certainly be convinced, but I do want some clarity.  It looks very
> attractive to rename task->parent to task->ptracer and leave the field
> NULL when there is no tracer.

Fair enough. You can consider my objection rescinded.

Presumably, though, you're hoping for an Ack for your patch and you
plan to take it with the rest of the series. That's going to need to
come from Daniel anyway as he is the actual maintainer. I'm just the
peanut gallery. ;-)

-Doug
