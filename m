Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2E4D1CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348213AbiCHQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiCHQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:11:06 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD245046F;
        Tue,  8 Mar 2022 08:10:09 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id ay7so19308302oib.8;
        Tue, 08 Mar 2022 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5O1imAWZVdMyV+q57qh16bTvNuecO9mwzzUYs+YBqWU=;
        b=KO+bSPR1W20jFFXnZzcF2bPOkRsBW4DSjh8CdK39vyINQGS+JiT95bNA1wQfSZ31ZC
         zu7HOoLYhOV9IM5sDyK8Gmlmlzja5bJorLjgPIXSyKSve3tIHt05JZ4ktW/6O68s8l1R
         vFgYtFhSE55YvaHgm9NcSX9IvIFQRk0IDpjvMUPvulpb88mf3984D1nHV74ulK/MJlb9
         O49V7ytXgR5QqgquHg0WiEf0J/oznALGr4iGMtmqEU8hqWzZh9+Cd8UVi3BzQrTtBrAR
         5u90pWgLi/G31/6Y47UcOIbW/qIwRxrry2fNiLAxrAkB6pLqUDmGjKII2MpcDHyybndb
         hM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5O1imAWZVdMyV+q57qh16bTvNuecO9mwzzUYs+YBqWU=;
        b=7CssoATwmKMZvQgd8ExFIK5rlD6J0SGIAD1gvSQdf3hG7A0THgfZv/f0ampbGIcNWh
         08Uz3hoJZEu0dXaqLt7qgCiDfcM7x15EabPw3FM5PxI+QDzpGoKBF0c7wboBHGGZ1iA9
         s7drBWV3fsfP1vK8rAA7jVAlfVs4jLNM+gGqrQ1k47MQh9ZBcHxiJ/6QxIepdIM+hvM2
         i1cXSIdT6f5SF1VNBFJuzJIQ4Dz1NUkwaJ8tRK3kZAZ3ouIlM3GOX6oUDqGstwtba73+
         kkEYGzlJLIsQhGtq8/CCrifNKSoLvdu9THF1/CIiCn479BJdE/BqeIZIiBCFQVflFqnU
         7Zfg==
X-Gm-Message-State: AOAM530uB8wzwgrkLHi9aTdakY8aHTR0JNRZwRxPYG654jJHb01kQ3/i
        Mc2ZYnNQoopH3C1Z/LPoFsNadHwxIUc1QManVl4=
X-Google-Smtp-Source: ABdhPJw3M9r/GuIu6pvif5A7WP40yGexb4Vwc2H2Qq4vIMCja1rYYA0sn1nHOxSb/sA1AhQERfyHmNbY50vYG3jomSA=
X-Received: by 2002:a05:6808:11cc:b0:2d9:a01a:4ba6 with SMTP id
 p12-20020a05680811cc00b002d9a01a4ba6mr3107703oiv.205.1646755808836; Tue, 08
 Mar 2022 08:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-4-cgzones@googlemail.com> <CAKwvOdkNZ3W9amcQKHOEfQLbdWC=4VDtrBdbOVHtWruipQnyKg@mail.gmail.com>
In-Reply-To: <CAKwvOdkNZ3W9amcQKHOEfQLbdWC=4VDtrBdbOVHtWruipQnyKg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 8 Mar 2022 17:09:58 +0100
Message-ID: <CAJ2a_DcY3=jz_zBQ7QZ_gycsvL1mn=TxKaWqWr3gGLhEAXTcQA@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
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

On Fri, 18 Feb 2022 at 18:31, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> On Thu, Feb 17, 2022 at 6:22 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> > introduced a NULL check on the context after a successful call to
> > security_sid_to_context().  This is on the one hand redundant after
> > checking for success and on the other hand insufficient on an actual
> > NULL pointer, since the context is passed to seq_escape() leading to a
> > call of strlen() on it.
> >
> > Reported by Clang analyzer:
> >
> >     In file included from security/selinux/hooks.c:28:
> >     In file included from ./include/linux/tracehook.h:50:
> >     In file included from ./include/linux/memcontrol.h:13:
> >     In file included from ./include/linux/cgroup.h:18:
> >     ./include/linux/seq_file.h:136:25: warning: Null pointer passed as =
1st argument to string length function [unix.cstring.NullArg]
> >             seq_escape_mem(m, src, strlen(src), flags, esc);
> >                                    ^~~~~~~~~~~
>
> I'm guessing there was more to this trace for this instance of this warni=
ng?

Yes, complete output appended at the end.

>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1e69f88eb326..ac802b99d36c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1020,7 +1020,7 @@ static int show_sid(struct seq_file *m, u32 sid)
> >         rc =3D security_sid_to_context(&selinux_state, sid,
> >                                              &context, &len);
> >         if (!rc) {
>
> ^ perhaps changing this condition to:
>
> if (!rc && context) {
>
> It might be nice to retain the null ptr check should the semantics of
> security_sid_to_context ever change.

If I read the implementation of security_sid_to_context() and its callees
correctly it should never return 0 (success) and not have populated its 3
argument, unless the passed pointer was zero, which by passing the address
of a stack variable - &context - is not the case).

>
> > -               bool has_comma =3D context && strchr(context, ',');
> > +               bool has_comma =3D strchr(context, ',');
> >
> >                 seq_putc(m, '=3D');
> >                 if (has_comma)
> > --
> > 2.35.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers


clang-tidy report:

./include/linux/seq_file.h:136:25: warning: Null pointer passed as 1st
argument to string length function
[clang-analyzer-unix.cstring.NullArg]
        seq_escape_mem(m, src, strlen(src), flags, esc);
                               ^
./security/selinux/hooks.c:1041:6: note: Assuming the condition is false
        if (!(sbsec->flags & SE_SBINITIALIZED))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./security/selinux/hooks.c:1041:2: note: Taking false branch
        if (!(sbsec->flags & SE_SBINITIALIZED))
        ^
./security/selinux/hooks.c:1044:6: note: Assuming the condition is false
        if (!selinux_initialized(&selinux_state))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./security/selinux/hooks.c:1044:2: note: Taking false branch
        if (!selinux_initialized(&selinux_state))
        ^
./security/selinux/hooks.c:1047:6: note: Assuming the condition is true
        if (sbsec->flags & FSCONTEXT_MNT) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
./security/selinux/hooks.c:1047:2: note: Taking true branch
        if (sbsec->flags & FSCONTEXT_MNT) {
        ^
./security/selinux/hooks.c:1050:8: note: Calling 'show_sid'
                rc =3D show_sid(m, sbsec->sid);
                     ^~~~~~~~~~~~~~~~~~~~~~~
./security/selinux/hooks.c:1020:7: note: Value assigned to 'context'
        rc =3D security_sid_to_context(&selinux_state, sid,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./security/selinux/hooks.c:1022:6: note: Assuming 'rc' is 0
        if (!rc) {
            ^~~
./security/selinux/hooks.c:1022:2: note: Taking true branch
        if (!rc) {
        ^
./security/selinux/hooks.c:1023:20: note: Assuming 'context' is null
                bool has_comma =3D context && strchr(context, ',');
                                 ^~~~~~~
./security/selinux/hooks.c:1023:28: note: Left side of '&&' is false
                bool has_comma =3D context && strchr(context, ',');
                                         ^
./security/selinux/hooks.c:1026:7: note: 'has_comma' is false
                if (has_comma)
                    ^~~~~~~~~
./security/selinux/hooks.c:1026:3: note: Taking false branch
                if (has_comma)
                ^
./security/selinux/hooks.c:1028:17: note: Passing null pointer value
via 2nd parameter 's'
                seq_escape(m, context, "\"\n\\");
                              ^~~~~~~
./security/selinux/hooks.c:1028:3: note: Calling 'seq_escape'
                seq_escape(m, context, "\"\n\\");
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/seq_file.h:152:20: note: Passing null pointer value
via 2nd parameter 'src'
        seq_escape_str(m, s, ESCAPE_OCTAL, esc);
                          ^
././include/linux/seq_file.h:152:2: note: Calling 'seq_escape_str'
        seq_escape_str(m, s, ESCAPE_OCTAL, esc);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/seq_file.h:136:25: note: Null pointer passed as 1st
argument to string length function
        seq_escape_mem(m, src, strlen(src), flags, esc);
                               ^      ~~~
