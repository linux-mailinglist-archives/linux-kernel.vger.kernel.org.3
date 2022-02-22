Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311754C0522
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiBVXRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiBVXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:17:13 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC48CDA9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:16:46 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id r13so24493322ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KzvH9ZQaXdUgSyIdwCtFzNEtbBoZxdQVld6HVvqC3h0=;
        b=S/IydQVZc46d4zetWnmQ5U0e/PzMQNOi9DIjYeoinrNryqb/zeu17/TuDGbIX/KWpC
         72p/RUQcIO43sVlxpFBZmQdfy6WJtCivMolKcubjDm1vgXMy8k/BPNGr/UPBh9C4W41h
         4OMcW3ugJLilxrgRaLIAK4YLgo1M1xTJxv0gptrzQotyWQ8BVbQgyOuu/RAZGlM5Bw8P
         JmKxduxWoEh8ZNP3EI0O00LrNVhJlX3v4Rw2jBvCxgmBre2DuzWvIcOX5LuS+YxoHWGU
         YdMkjRgsLGwFaosBa6vzrp7EVsu7uc8gPip0/Bri8/5SM/66BSW/Pl4hxH3OB0jOdfoL
         rEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KzvH9ZQaXdUgSyIdwCtFzNEtbBoZxdQVld6HVvqC3h0=;
        b=Hb2d3BKrnh+k0LyynM3KOWiO6MZACbFGdo54Pcyy3ZcYiyUup4ZNJv7rt8G+JY9MD3
         z1tv4VShGYCCGGsgv4onuZF5UAGKvoWSI1MEVU84+KAI2QmnZIJlgY1zL40+HCpS9MBd
         VEyiMIVjJwVA8AeTKSp8J2BSQ/GPuT2+/66n1yb7tbKCWDQEQsHrpoH8z3qeb7C4DEPP
         lTkKLIkFDa1kL9keK3tibqu/OFdDyjtK2qf+xOb1mGk2b7h0cDaSVQupdTM1huguUb1s
         J6KltsbGryP0jSDouv5+n+/D1vpP8AcE1kqP+9zxJIpD42QqA4dzv0Vq5//RqiNexnog
         SJhg==
X-Gm-Message-State: AOAM532TWom5Zd38bbreYYWsKTf6gbZ2mQO85vY1pphsSsuFBkrXspEX
        RLQtLOIJz9yYXIxcEtEYM5jYcN1rmX+aOq/Eio+9
X-Google-Smtp-Source: ABdhPJyC5JfFslCe0iSc7dk6uE4kYr0sXtIjOP3+4cJ8OXdGFLZZdB3wUVrWstGC2q8isedVNDR8Em5of/ldksyZE6c=
X-Received: by 2002:a17:907:2a54:b0:6d5:879d:aca4 with SMTP id
 fe20-20020a1709072a5400b006d5879daca4mr419389ejc.29.1645571804662; Tue, 22
 Feb 2022 15:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-3-cgzones@googlemail.com> <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
 <CAKwvOdkioR+7aebgzPu2Exe0oD9rwAeHK=CgM6vAkpBWdHnF2Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkioR+7aebgzPu2Exe0oD9rwAeHK=CgM6vAkpBWdHnF2Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Feb 2022 18:16:33 -0500
Message-ID: <CAHC9VhSKZes9g_GHMKJdhd_BEt7GT4FKOLeMJ=o=FU8TtOZ-gg@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: declare data arrays const
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Fri, Feb 18, 2022 at 8:13 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > diff --git a/security/selinux/include/initial_sid_to_string.h b/secur=
ity/selinux/include/initial_sid_to_string.h
> > > index 5d332aeb8b6c..915283cd89bd 100644
> > > --- a/security/selinux/include/initial_sid_to_string.h
> > > +++ b/security/selinux/include/initial_sid_to_string.h
> > > @@ -1,5 +1,12 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 */
> > > -static const char *initial_sid_to_string[] =3D
> > > +
> > > +#ifdef __SELINUX_GENHEADERS__
> > > +# define const_qual
> > > +#else
> > > +# define const_qual const
> > > +#endif
> > > +
> > > +static const char *const_qual initial_sid_to_string[] =3D
> > >  {
> > >         NULL,
> > >         "kernel",
> >
> > Thanks for this Christian.  I generally like when we can const'ify
> > things like this, but I'm not excited about the const_qual hack on
> > core SELinux kernel code to satisfy genheaders.c.  I understand why it
> > is needed, but I would rather clutter the genheaders.c code than the
> > core SELinux kernel code.  If we can't cast away the const'ification
> > in genheaders.c could we simply allocate duplicate arrays in
> > genheaders.c and store the transformed strings into the new arrays?
>
> Note: casting off const is UB. I've had to fix multiple bugs where
> clang will drop writes to variables declared const but had const'ness
> casted away.

Then let's just memcpy the array in genheaders.c.  I'm okay with
genheaders being a little ugly if it helps keep the core code cleaner.

--=20
paul-moore.com
