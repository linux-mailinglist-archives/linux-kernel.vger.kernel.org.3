Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B14BBE54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbiBRRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:25:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiBRRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:25:08 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B9C2B5B8A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:24:51 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so4259307ooa.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e48rbRghZ1DHjEo5oAQPObeUfspj3j2bBv68xgwxZDg=;
        b=B6b07vv9/aGPNg6S485OaHdVCheTvWziFVBg71SY0DOhjK7WDiRUJjBrnomP+yCPKi
         beF4zz1XqIgM7q5h2UVDA+K8EpzE3Sl+CMTCJsteOe3Uff1qUlw2cMEnQbQdzGIJxrky
         h5S4rMM94onJIbUS4+dMB/YhGIoP9j4x5M9nwUrrPXfqWDeBDAMIELL3VvvxGvWgqMyN
         2sDxR/EXKyqEFQuyCKBLH5dt6DZfY+nJuWLYklzfI6v5JzlhIXSdACTerkZmhXouMGIK
         Sr3GDvB6hVLLANmcqhh1hmdwzXn9Dh8nOcvYbLVllThUGCpHBQn80TLrYsdpNN2UshO2
         C4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e48rbRghZ1DHjEo5oAQPObeUfspj3j2bBv68xgwxZDg=;
        b=D+ndWlFU3Erck1MEDLFtdOcaH0ux3vTpmMNGZ/O0Febseah3WG5bCFflbYUIgaqpKz
         AIbd6n127WdH+430NrB98wIsSmy9p+odfOnw3OnGMgSSgCxKQpN03+eRvaWHKZi3qEpT
         XcJf+K8lHYw+7q7e9GVEJcBoWZsaq53VZmzS332W+Kdmp7hW/PIPtpTtqs1IrX5y99GK
         iXY/q59kE56Rd9KHnhRnbE8pOeVqalLlugq93StiFFtigbfCdKUeBkoqIANTLh8tq935
         H5Zg32NOf0hh+QumSbQv6AjfNSFqYQyaIBs0YKVMOIHnHc4wuwLqNUruVp1fyxP/oY5Q
         oSIQ==
X-Gm-Message-State: AOAM533c2Bdn57yz7SPsVys4IOy0QgdqHwtCx9KvdRgyeEcXgmhAkxYq
        6dvJi67yvtAfnHNq+ATDx0bjs5qPkZdt22kkwk8gzQ==
X-Google-Smtp-Source: ABdhPJxeMGrNQo5p4UItQyXTMpqQBxLO8zARxmITPMT0p8OolI64JRzNUI3LaxZS0U2ddwM3nEFeutNzi0O3h5nsuGI=
X-Received: by 2002:a05:6870:3491:b0:d2:48b5:7a4c with SMTP id
 n17-20020a056870349100b000d248b57a4cmr4553827oah.288.1645205090740; Fri, 18
 Feb 2022 09:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-3-cgzones@googlemail.com> <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
In-Reply-To: <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Feb 2022 09:24:39 -0800
Message-ID: <CAKwvOdkioR+7aebgzPu2Exe0oD9rwAeHK=CgM6vAkpBWdHnF2Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: declare data arrays const
To:     Paul Moore <paul@paul-moore.com>
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

On Fri, Feb 18, 2022 at 8:13 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > diff --git a/security/selinux/include/initial_sid_to_string.h b/securit=
y/selinux/include/initial_sid_to_string.h
> > index 5d332aeb8b6c..915283cd89bd 100644
> > --- a/security/selinux/include/initial_sid_to_string.h
> > +++ b/security/selinux/include/initial_sid_to_string.h
> > @@ -1,5 +1,12 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -static const char *initial_sid_to_string[] =3D
> > +
> > +#ifdef __SELINUX_GENHEADERS__
> > +# define const_qual
> > +#else
> > +# define const_qual const
> > +#endif
> > +
> > +static const char *const_qual initial_sid_to_string[] =3D
> >  {
> >         NULL,
> >         "kernel",
>
> Thanks for this Christian.  I generally like when we can const'ify
> things like this, but I'm not excited about the const_qual hack on
> core SELinux kernel code to satisfy genheaders.c.  I understand why it
> is needed, but I would rather clutter the genheaders.c code than the
> core SELinux kernel code.  If we can't cast away the const'ification
> in genheaders.c could we simply allocate duplicate arrays in
> genheaders.c and store the transformed strings into the new arrays?

Note: casting off const is UB. I've had to fix multiple bugs where
clang will drop writes to variables declared const but had const'ness
casted away.
--=20
Thanks,
~Nick Desaulniers
