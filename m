Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562C74B2686
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350326AbiBKMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:54:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244509AbiBKMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:54:38 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEBE5E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:54:37 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso10123015oop.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ARFSsbWyOdD6EMO2DQy2Ws/csG1j53wTkmfHHdDFXY=;
        b=Jkshpjqe1FTAHoJawiFQhz9yzN0NpI9FvO/qjTRn08FgZgcQ5HA+Ush/Ai2Vyzbdn+
         rCSlVh4dWpG6MiPoiRYhkDDaZTqOQOUJUnKkO71u8+Gg4+x25NOgSS5214ix2N2FyxH6
         qFYkARezeP6Oy8q3v726X20mHNEIXMs36eI/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ARFSsbWyOdD6EMO2DQy2Ws/csG1j53wTkmfHHdDFXY=;
        b=fSJYUzc+2ED8J3f3pHzFNOQTSrGVVLLH0o0IStvwSn0pO7TmzWKjcKwDL58ICV1362
         TvYVTbZAMj/zIMyvdjGOO9AMUDQNKsBXYENgL1AatJzH647wWGe5ovwJMUsUEvkTbsG+
         QuIIuALvrKRE+kljn5pvDRRkZnEAEJ81knGRMAxpAu9xDn/tKK6X+AqEW68PQyvaKkpK
         +8XBBE2j27EL/9lVmSWZ0btMoa6/CoAaPQv2CswZfFREk9DjxSRmKZpMyKlLwQpn3Dpm
         Y8EBkXPpbNXlbDBRpfNQi1MXrzIH4j+QuR6//8JNzY3zBVT4SFN8rpnCogNDPS/VPnw5
         2Zmg==
X-Gm-Message-State: AOAM531C4izpK5LCym6eHEXpaFhFbnCsN60a2fgzsE0EEUpnFxIwuYuH
        cSewte/WzZwzrUTKpIxtOkvU7YPxl8aMZovWjp/8YA==
X-Google-Smtp-Source: ABdhPJycTC6S1obSOSqlJkcCCMqLgeX+Z0N2ENm2rG5bJFgvf8vbjfUK0WI9KAZNGfsCwuNWO3LYwP7aBsccMpeLNeE=
X-Received: by 2002:a05:6870:8c13:: with SMTP id ec19mr71565oab.262.1644584077154;
 Fri, 11 Feb 2022 04:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org> <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org> <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org> <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org> <202202101827.4B16DF54@keescook>
In-Reply-To: <202202101827.4B16DF54@keescook>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Fri, 11 Feb 2022 13:54:26 +0100
Message-ID: <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's mainly about the exit stuff having never been run before on these
> kinds of process states, so things don't make sense. For example, on the
> SIGSYS death, the registers have been rewound for the coredump, so when
> the exit trace runs on x86 it sees the syscall return value as equal to
> the syscall number (since %rax is used for the syscall number on entry
> and for the syscall result on exit). So when a tracer watches a seccomp
> fatal SIGSYS, it sees the syscall exit before it sees the child exit
> (and therefore the signal). For example, x86_64 write (syscall number
> 1), will return as if it had written 1 byte. :P
>
> So, it's not harmful, but it's confusing and weird. :)
>
> > I am trying to figure out if there is a case to be made that it was a
> > bug that these events were missing.
>
> I don't think so -- the syscall did not finish, so there isn't a valid
> return code. The process exited before it completed.

A tangential point: please ignore for the purpose of fixing the
problem at hand. I'm mostly making it, in case it can be taken into
account in case some bigger changes to this code path are to be made -
given that it touches the problem of signal delivery.

When I noticed this problem, I was looking for a way to figure out
what syscall caused SIGSYS (via SECCOMP_RET_KILL_*), and there's no
easy way to do that programmatically from the perspective of a parent
process. There are three ways of doing this that come to mind.

1). Keep reference to /proc/<child>/syscall and read it upon process
exiting by SIGSYS (and reading it with wait/id(WNOWAIT) from parent).
This used to work a long time ago, but was racy (I reported this
problem many years ago), and currently only -1 0 0 is returned (as in,
no syscall in progress).
2). Use ptrace - it works but it changes the logic of the signal
delivery inside a traced process and requires non-trivial code to make
it work correctly: use of PT_INTERRUPT, understanding all signal
delivery events, registers and their mapping to syscall arguments per
CPU arch.
3). auditd will print details of failed syscall to kmsg, but the
string is not very structured, and auditd might not be always present
inside kernels. And reading that data via netlink requires root IIRC.

I think it'd be good to have some way of doing it from the perspective
of a parent process - it'd simplify development of sandboxing managers
(eg nsjail, minijail, firejail), and creation of good seccomp
policies.
