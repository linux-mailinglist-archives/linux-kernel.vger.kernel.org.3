Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515D44B5D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiBNWJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:09:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBNWJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:09:14 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6013C395
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:09:05 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso20978705ooi.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U22U8uNB24DJ6j76hTyECruth37Sas7YuiuN1xBZATI=;
        b=Rgo9DqZ5dSPhH4Wq0GSTADHafTnKjcn/Qmce0uEobUoE8LAd+MYei7tl2R7iG3VudV
         To3x8+HsM/++UfKBrtitpN9DFDSB992Mcz03KCWtQdRvLF8Ma3Ieh6aHwCL3qju6kPfa
         t7/bPPG+iPl7SQ2FiJlW70X4RRnCuuFq56PpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U22U8uNB24DJ6j76hTyECruth37Sas7YuiuN1xBZATI=;
        b=O+vKfQKP/7QSljIo8/9enb+hIB0N7/zzaA0rF1HFBoo1vo/uB/zPvuWjL3RTAz8nco
         wOY55lJOWhQ64s6eXGBmdp8xxwRcDgS9vb8GEU9TjgEzvuSBzItFzxRU2SzZkQ9FQ/M+
         0XzOA0kL7hnqx6sQz/jcJnggtKpOfuvYcPWoMHC+CylRekNh3v8HCdBLSmNCna92iwzk
         H3xoAS8qKE4GlbVLoDuKHb1vCH6cggu6jFg+odKu+7hLPn7KdSDYJgG6Cp/fnr8LQ8qF
         BBz9SfXGUzqZkDU8z2WNI4cOv7UKeUbiLIWAKJ7fhUw8N9uGW3WoLWcoWsHlKBHwYlw6
         ChgQ==
X-Gm-Message-State: AOAM5324cqfQGsJShRqHAuDNOyNEIMk9xhRw0IdpkwyzThiTrW8XCFfD
        yxKkV/qdo2wwmtwb71kMEPU8185T9NjGwCcCt5Yh/g==
X-Google-Smtp-Source: ABdhPJxCypFkXLGm4DP4yUyaac3elld5nTXluLxOTb4KYdkVFTgF+p+VHgUvbvYz2/TyZ5BOrSv8g1zwmSB8zysDq50=
X-Received: by 2002:a05:6870:a8ab:b0:d2:cd36:7859 with SMTP id
 eb43-20020a056870a8ab00b000d2cd367859mr316799oab.83.1644876544500; Mon, 14
 Feb 2022 14:09:04 -0800 (PST)
MIME-Version: 1.0
References: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
 <CF5167CE-FA1C-4CEC-9EA8-5EE8041FE7C4@amacapital.net> <20220213085212.cwzuqlrabpgbnbac@wittgenstein>
 <202202141152.6296CD7F@keescook>
In-Reply-To: <202202141152.6296CD7F@keescook>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Mon, 14 Feb 2022 23:08:53 +0100
Message-ID: <CAP145piExdhYLaKcHaCOoXVageMqmB6eDV-iyzeNc+RgVc=B-Q@mail.gmail.com>
Subject: Re: [RFC] Get siginfo from unreaped task
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Will Drewry <wad@chromium.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 14 lut 2022 o 21:07 Kees Cook <keescook@chromium.org> napisa=C5=82(a)=
:

> > > I had a kind of opposite thought, which is that it would be very nice
> > > to be able to get all the waitid() data without reaping a process or
> > > even necessarily being its parent.  Maybe these can be combined?  A
> > > new waitid() option like you=E2=80=99re suggesting could add siginfo =
(and
> > > might need permissions).  And we could have a different waitid() flag
> > > that says =E2=80=9Cmaybe not my child, don=E2=80=99t reap=E2=80=9D (a=
nd also needs
> > > permissions).
> > >
> > > Although the =E2=80=9Cdon=E2=80=99t reap=E2=80=9D thing is fundamenta=
lly racy. What a sane
> > > process manager actually wants is an interface to read all this info
> > > from a pidfd, which means it all needs to get stuck in struct pid. An=
d
> >
> > /me briefly pops out from vacation
> >
> > Agreed and not just siginfo I would expect(?). We already came to that
> > conclusion when we first introduced them.
> >
> > > task_struct needs a completion or wait queue so you can actually wait
> > > for a pidfd to exit (unless someone already did this =E2=80=94 I had =
patches a
> > > while back).  And this would be awesome.
> >
> > Currently, you can wait for a pidfd to exit via polling and you can use
> > a pidfd to pass it to waitid(P_PIDFD, pidfd, ...).
> >
> > /me pops back into vacation
>
> Right, so waitid already has all the infrastructure for this, so I think
> adding it there makes a lot of sense. Here's what I've got:
>
> One usability question I have is:
>
> - if the process just exited normally, should it return an empty
>   siginfo, or should it ignore __WCHILDSIGINFO? (I have it ignoring it
>   above.)

Maybe ENODATA as return code, in order to make it obvious to the
caller that the siginfo is missing? In the end if somebody requests
it, they probably should have already checked that the child process
was killed by a signal, by using WNOWAIT with waitid() or wait4().

Additionally, there might be a problem with input params. The waitid()
can take P_ALL or P_PGID as arguments. If waitid() returns with 0, the
pid of the child process generating the event can be read from
si->si_pid. But siginfo_t is a union of multiple different structs,
many of them missing si_pid. So, such a flag (__WCHILDSIGINFO) would
make sense with P_PID and P_PIDFD only, maybe this should be
explicitly checked for?
