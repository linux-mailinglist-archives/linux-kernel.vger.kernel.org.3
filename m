Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068B519DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348619AbiEDLTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348616AbiEDLTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1543D2BF0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651662926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfsp1KPatFeHo0O2sckSuiB1M4vvItv5MiLeuFPqA3I=;
        b=g5vPrioyyhf160Tqkm5iHv4qIXKoLhCSmDo62U6W0tvfFjVHnmRNmhxl2yrpjfmHwOcHl6
        /pGbszrd0DHeraNfc6/ujOQsAcxaEoQV+mxTj5OSXRJ3RBah0LxkXx4zEIBYA706PzFwVY
        tTjS8OUku066AwVu9iTq8zzZAcLNrp4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-HQ_Uaa03OuSjZrjI0prEiQ-1; Wed, 04 May 2022 07:15:25 -0400
X-MC-Unique: HQ_Uaa03OuSjZrjI0prEiQ-1
Received: by mail-yb1-f198.google.com with SMTP id d22-20020a25add6000000b00645d796034fso868331ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 04:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tfsp1KPatFeHo0O2sckSuiB1M4vvItv5MiLeuFPqA3I=;
        b=oCJKkewYbRGlez7l1IXn/q0uGDalLMTyuQDp3hgJoKzEgoUYGGkNGidF8HcUc0SBrQ
         twCVSJNsQyek2SJNUM/e4TFLZtRnl1F/Ivz3994FGF+VeGShYaRyecKDFbfbd447zMf0
         XPrBfqitNqhlvi9rW4/R8wfH1Fgd2pj+hQb01b/1hNn3FT5hjSK943x76A5BglwpJMwQ
         M1yMTcMl+xYZYRt3xDCi+XJgwEcWKAjG+mdf5RUTEiGcqO3caxwG25EIlNrEM70IE3MM
         arcqlljAVDV7rBVQcspPpA8i9Skrh74FRrKhWxa45V+mM1tOKTUh1rVSy2a54pMcf/3E
         sAfA==
X-Gm-Message-State: AOAM530ucOWZ/QHBSWhYMAo6yxZoLdBMNsYKat11XujY7EogV5kp3AmC
        Hwy8iraF10e3xoBO30WBgf56uDX79SduF6MJlvPxPU1FGZRgGzbdx+YcULb8XrQfHatJy1n1kOV
        SQl9SmdgbpWZIoIZ9N01PUXV3Th5/VNGloOjePsbn
X-Received: by 2002:a0d:e64e:0:b0:2f4:ddb9:b108 with SMTP id p75-20020a0de64e000000b002f4ddb9b108mr18263213ywe.245.1651662924460;
        Wed, 04 May 2022 04:15:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPWZsdNNOxGl9heDP9tVxbML+jdZGoOf2N93ydJMqIk5mk3Qh8ubgiapXK/U/JOPoOlb0OWV2vdN52+JaqdSo=
X-Received: by 2002:a0d:e64e:0:b0:2f4:ddb9:b108 with SMTP id
 p75-20020a0de64e000000b002f4ddb9b108mr18263202ywe.245.1651662924232; Wed, 04
 May 2022 04:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-4-cgzones@googlemail.com> <CAKwvOdkNZ3W9amcQKHOEfQLbdWC=4VDtrBdbOVHtWruipQnyKg@mail.gmail.com>
 <CAJ2a_DcY3=jz_zBQ7QZ_gycsvL1mn=TxKaWqWr3gGLhEAXTcQA@mail.gmail.com> <CAJ2a_De2o7+v2v4QDnXNB=q9N6J84iMz8QMe6vK7ojvxVhfqqQ@mail.gmail.com>
In-Reply-To: <CAJ2a_De2o7+v2v4QDnXNB=q9N6J84iMz8QMe6vK7ojvxVhfqqQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 May 2022 13:15:12 +0200
Message-ID: <CAFqZXNvgByrTLbGMRz20Kcu1473YMLmxGeQev53qM7jNSSYFbQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 3:43 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 8 Mar 2022 at 17:09, Christian G=C3=B6ttsche <cgzones@googlemail.=
com> wrote:
> >
> > On Fri, 18 Feb 2022 at 18:31, Nick Desaulniers <ndesaulniers@google.com=
> wrote:
> > >
> > > On Thu, Feb 17, 2022 at 6:22 AM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> > > > introduced a NULL check on the context after a successful call to
> > > > security_sid_to_context().  This is on the one hand redundant after
> > > > checking for success and on the other hand insufficient on an actua=
l
> > > > NULL pointer, since the context is passed to seq_escape() leading t=
o a
> > > > call of strlen() on it.
> > > >
> > > > Reported by Clang analyzer:
> > > >
> > > >     In file included from security/selinux/hooks.c:28:
> > > >     In file included from ./include/linux/tracehook.h:50:
> > > >     In file included from ./include/linux/memcontrol.h:13:
> > > >     In file included from ./include/linux/cgroup.h:18:
> > > >     ./include/linux/seq_file.h:136:25: warning: Null pointer passed=
 as 1st argument to string length function [unix.cstring.NullArg]
> > > >             seq_escape_mem(m, src, strlen(src), flags, esc);
> > > >                                    ^~~~~~~~~~~
> > >
> > > I'm guessing there was more to this trace for this instance of this w=
arning?
> >
> > Yes, complete output appended at the end.
> >
> > >
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  security/selinux/hooks.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 1e69f88eb326..ac802b99d36c 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -1020,7 +1020,7 @@ static int show_sid(struct seq_file *m, u32 s=
id)
> > > >         rc =3D security_sid_to_context(&selinux_state, sid,
> > > >                                              &context, &len);
> > > >         if (!rc) {
> > >
> > > ^ perhaps changing this condition to:
> > >
> > > if (!rc && context) {
> > >
> > > It might be nice to retain the null ptr check should the semantics of
> > > security_sid_to_context ever change.
> >
> > If I read the implementation of security_sid_to_context() and its calle=
es
> > correctly it should never return 0 (success) and not have populated its=
 3
> > argument, unless the passed pointer was zero, which by passing the addr=
ess
> > of a stack variable - &context - is not the case).
> >
>
> Kindly ping;
> is my analysis correct that after
>
>     rc =3D security_sid_to_context(&selinux_state, sid,
>                                                   &context, &len);
>
> there is no possibility that rc is 0 AND context is NULL?

Yes, I think this patch is good. rc =3D=3D 0 means success, which in this
case means that a valid context string has been returned. Thus, there
is no point in checking for NULL, other than being super-defensive
about future changes to security_sid_to_context() messing something up
(if we did this everywhere, then there would be NULL checks all over
the place...).

>
> > >
> > > > -               bool has_comma =3D context && strchr(context, ',');
> > > > +               bool has_comma =3D strchr(context, ',');
> > > >
> > > >                 seq_putc(m, '=3D');
> > > >                 if (has_comma)
> > > > --
> > > > 2.35.1
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> >
> > clang-tidy report:
> >
> > ./include/linux/seq_file.h:136:25: warning: Null pointer passed as 1st
> > argument to string length function
> > [clang-analyzer-unix.cstring.NullArg]
> >         seq_escape_mem(m, src, strlen(src), flags, esc);
> >                                ^
> > ./security/selinux/hooks.c:1041:6: note: Assuming the condition is fals=
e
> >         if (!(sbsec->flags & SE_SBINITIALIZED))
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1041:2: note: Taking false branch
> >         if (!(sbsec->flags & SE_SBINITIALIZED))
> >         ^
> > ./security/selinux/hooks.c:1044:6: note: Assuming the condition is fals=
e
> >         if (!selinux_initialized(&selinux_state))
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1044:2: note: Taking false branch
> >         if (!selinux_initialized(&selinux_state))
> >         ^
> > ./security/selinux/hooks.c:1047:6: note: Assuming the condition is true
> >         if (sbsec->flags & FSCONTEXT_MNT) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1047:2: note: Taking true branch
> >         if (sbsec->flags & FSCONTEXT_MNT) {
> >         ^
> > ./security/selinux/hooks.c:1050:8: note: Calling 'show_sid'
> >                 rc =3D show_sid(m, sbsec->sid);
> >                      ^~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1020:7: note: Value assigned to 'context'
> >         rc =3D security_sid_to_context(&selinux_state, sid,
> >              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1022:6: note: Assuming 'rc' is 0
> >         if (!rc) {
> >             ^~~
> > ./security/selinux/hooks.c:1022:2: note: Taking true branch
> >         if (!rc) {
> >         ^
> > ./security/selinux/hooks.c:1023:20: note: Assuming 'context' is null
> >                 bool has_comma =3D context && strchr(context, ',');
> >                                  ^~~~~~~
> > ./security/selinux/hooks.c:1023:28: note: Left side of '&&' is false
> >                 bool has_comma =3D context && strchr(context, ',');
> >                                          ^
> > ./security/selinux/hooks.c:1026:7: note: 'has_comma' is false
> >                 if (has_comma)
> >                     ^~~~~~~~~
> > ./security/selinux/hooks.c:1026:3: note: Taking false branch
> >                 if (has_comma)
> >                 ^
> > ./security/selinux/hooks.c:1028:17: note: Passing null pointer value
> > via 2nd parameter 's'
> >                 seq_escape(m, context, "\"\n\\");
> >                               ^~~~~~~
> > ./security/selinux/hooks.c:1028:3: note: Calling 'seq_escape'
> >                 seq_escape(m, context, "\"\n\\");
> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ././include/linux/seq_file.h:152:20: note: Passing null pointer value
> > via 2nd parameter 'src'
> >         seq_escape_str(m, s, ESCAPE_OCTAL, esc);
> >                           ^
> > ././include/linux/seq_file.h:152:2: note: Calling 'seq_escape_str'
> >         seq_escape_str(m, s, ESCAPE_OCTAL, esc);
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ././include/linux/seq_file.h:136:25: note: Null pointer passed as 1st
> > argument to string length function
> >         seq_escape_mem(m, src, strlen(src), flags, esc);
> >                                ^      ~~~
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

