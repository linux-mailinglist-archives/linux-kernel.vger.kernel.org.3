Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7B4B128D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbiBJQTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:19:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiBJQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:19:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC72397
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:19:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z19so11359238lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JKW081rgGpaiP4kwWeXuyBtPDTahlHH6s9OhRPepRUE=;
        b=P+OBlYOROMsamaTxRHS41/nKtUTb4mUW3k2CPzOjp/XYHUPtBGs6jPd01VgUDErVf8
         Unk8sJzZKBtnswkppHfrYbVkSkJ5cczyJC0cjllbYGH/KBMcRytWaEGxYdY5uMmWDM0h
         JK/pVSXO60FPuFXurMeTKq/F7uU/KUZ8yVFMzfXLGQr6NE6QpvcS10pcWo1oEzXwECfO
         4gHx3+unCa+lHixMKdaAPxdC53UEfTLeAdNUqoVlTGDMZ82noVy4gzGK3DWPhJrrCgpK
         lFAC1wuCcD2jaDGDXO8SztoVlPo+ZtD+Uv+3h6obQjaL6lXaJZW/75Hey0myJA7ugfhL
         nmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JKW081rgGpaiP4kwWeXuyBtPDTahlHH6s9OhRPepRUE=;
        b=3VrqCD2Yks/fmEi5ETRS18x3APxLAm/BbD39iXRwOsMMiuAQ5rR5aFMPl03AZiRmad
         RWnmV6za2LYqXiuBRjGDx+XLcdzAmP990aMkTdfC8iEvGK8zFkgtQxVQlPkEM5LfJ8So
         Abhe4E6GY5m2uN6TXM2EeDRC0ISwrNNo1kJdNYTNKBS7IoTLPWIV0rgzWP2rInwAAu06
         If6TnrUPn4Vfupl6UyUJz21MbPHQv1NYvh5EHYLcVo8xQ1bw/Wdju0dCZ2td5RWD1LIu
         MFIUVBsbofcK8C9O96ZufMJc8DgejJ1lVueWfqnIwZioC1sRpyv8QnF/pJD3ev3Yv9xb
         2plg==
X-Gm-Message-State: AOAM531lvwx0kKenKb/Dn8gM5+1U3b/lT/jZ8+m54lrRnxM4it3kr3u8
        SWWLj3giAblHrffseYn4ekZtRLWtYsv1rFuKLXHapw==
X-Google-Smtp-Source: ABdhPJzSeIXpEi5a/UY7UA0L0H6R5yPxcX1+X4e6O0HqF4FM449Qca/ijPlTHh/bLWKtIu6cm6R4AbBxxmv0naarpTw=
X-Received: by 2002:a19:ee04:: with SMTP id g4mr5504587lfb.157.1644509945581;
 Thu, 10 Feb 2022 08:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20220210025321.787113-1-keescook@chromium.org> <20220210025321.787113-2-keescook@chromium.org>
In-Reply-To: <20220210025321.787113-2-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Feb 2022 17:18:39 +0100
Message-ID: <CAG48ez1m7XJ1wJvTHtNorH480jTWNgdrn5Q1LTZZQ4uve3r4Sw@mail.gmail.com>
Subject: Re: [PATCH 1/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 3:53 AM Kees Cook <keescook@chromium.org> wrote:
> Fatal SIGSYS signals were not being delivered to pid namespace init
> processes. Make sure the SIGNAL_UNKILLABLE doesn't get set for these
> cases.
>
> Reported-by: Robert =C5=9Awi=C4=99cki <robert@swiecki.net>
> Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls d=
o not get changed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/signal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 38602738866e..33e3ee4f3383 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1342,9 +1342,10 @@ force_sig_info_to_task(struct kernel_siginfo *info=
, struct task_struct *t,
>         }
>         /*
>          * Don't clear SIGNAL_UNKILLABLE for traced tasks, users won't ex=
pect
> -        * debugging to leave init killable.
> +        * debugging to leave init killable, unless it is intended to exi=
t.
>          */
> -       if (action->sa.sa_handler =3D=3D SIG_DFL && !t->ptrace)
> +       if (action->sa.sa_handler =3D=3D SIG_DFL &&
> +           (!t->ptrace || (handler =3D=3D HANDLER_EXIT)))
>                 t->signal->flags &=3D ~SIGNAL_UNKILLABLE;

You're changing the subclause:

!t->ptrace

to:

(!t->ptrace || (handler =3D=3D HANDLER_EXIT))

which means that the change only affects cases where the process has a
ptracer, right? That's not the scenario the commit message is talking
about...

>         ret =3D send_signal(sig, info, t, PIDTYPE_PID);
>         spin_unlock_irqrestore(&t->sighand->siglock, flags);
> --
> 2.30.2
>
