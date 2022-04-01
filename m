Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3B4EFC2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352081AbiDAVfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDAVfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:35:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE0013A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:33:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so3680210pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPUOt269UZx0fP/hcR9t05VLgduxdLJMOsB45EbEuuM=;
        b=TBnXvmiM1XKxbsASblG7IqI4HZnjRUmSQyliD72UlcrYAd7Ec2hH8DV26z3NYobNkc
         /7B2cBARUlkAcsELj9vBUeqJm13FbqkQvw5JKG4xjrXnMQqDjXWpzUf2mPu585+SpIgZ
         KXM43VPi+LKLbG3Y0RM4AasfwxxwIwJte4YyM3q1WRfWC0E8+ZyiiWypIX+7+gb1R3ZL
         h5U/QWG+oZDE82ST6gr+Ie1WUkj7N0dKpsGcjSKaDDaXd69QlqBLEFouY7YHGfbn5Opy
         eAlQMHuPGBOqZx8WUzETvPit6Yg1HjWyo6ldmBJ1AX60k1t08dAUOf9Nzu4gIi98gAlI
         0Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPUOt269UZx0fP/hcR9t05VLgduxdLJMOsB45EbEuuM=;
        b=cK5e6fcTeF9z//2homLcxeRv4QaJYFFcxseKORkEjzhndlpxMOqL0+nkAw4twVYxhB
         eYMBr0tTxC4G0h7pNbsdSqIpvxCZkFe/FcuoiwWdHEjgycHZMQ335s512V4RwQyKwx+d
         rBF7rAuhjcJYwaHhmniqdVY6v4/WliBm5Lxj3vY8Onoqt4Ct2aCNdoTvg1n4ZGN0epb8
         vJe3c5/MkLxdS/I797yN7ZeyCE6Z+h5L31a5lG2KUro2X6ulOQk6rioFhGuXmaDzvEpf
         sGh+O77MpPNAlEaDcpEiaMfGyfzWpdoHZQdotOBSoJ4RWqxEOc5xc/zlNk9ZiyiG6lTN
         L2zQ==
X-Gm-Message-State: AOAM531tFyubR9ReAND5duWPIPFue5tmmxcfaAc7G0rtc2gLhZ6D2FvY
        QM+8h11XNkbeLuNDdv7nQzLIUo1eqnmOR7EJFcm76Q==
X-Google-Smtp-Source: ABdhPJw5Abq6FL4cAVZAWaHZLdJogCtOBAxKooOTnZofkq1g6qvBl7rvy5TJDGMaSIB7JzT6LFfGjVlYeROYkFJ8xlU=
X-Received: by 2002:a17:90b:4a01:b0:1c9:a552:f487 with SMTP id
 kk1-20020a17090b4a0100b001c9a552f487mr14253315pjb.68.1648848808052; Fri, 01
 Apr 2022 14:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220331154555.422506-1-milan@mdaverde.com> <20220331154555.422506-4-milan@mdaverde.com>
 <8457bd5f-0541-e128-b033-05131381c590@isovalent.com> <CAEf4BzaqqZ+bFamrTXSzjgXgAEkBpCTmCffNR-xb8SwN6TNaOw@mail.gmail.com>
In-Reply-To: <CAEf4BzaqqZ+bFamrTXSzjgXgAEkBpCTmCffNR-xb8SwN6TNaOw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 1 Apr 2022 22:33:16 +0100
Message-ID: <CACdoK4JbhtOpQeGo+NUh5t3nQG8No8Di6ce-9gwgNw3az2Fu=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf/bpftool: handle libbpf_probe_prog_type errors
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Milan Landaverde <milan@mdaverde.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 at 19:42, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 9:05 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2022-03-31 11:45 UTC-0400 ~ Milan Landaverde <milan@mdaverde.com>
> > > Previously [1], we were using bpf_probe_prog_type which returned a
> > > bool, but the new libbpf_probe_bpf_prog_type can return a negative
> > > error code on failure. This change decides for bpftool to declare
> > > a program type is not available on probe failure.
> > >
> > > [1] https://lore.kernel.org/bpf/20220202225916.3313522-3-andrii@kernel.org/
> > >
> > > Signed-off-by: Milan Landaverde <milan@mdaverde.com>
> > > ---
> > >  tools/bpf/bpftool/feature.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> > > index c2f43a5d38e0..b2fbaa7a6b15 100644
> > > --- a/tools/bpf/bpftool/feature.c
> > > +++ b/tools/bpf/bpftool/feature.c
> > > @@ -564,7 +564,7 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
> > >
> > >               res = probe_prog_type_ifindex(prog_type, ifindex);
> > >       } else {
> > > -             res = libbpf_probe_bpf_prog_type(prog_type, NULL);
> > > +             res = libbpf_probe_bpf_prog_type(prog_type, NULL) > 0;
> > >       }
> > >
> > >  #ifdef USE_LIBCAP
> >
>
> A completely unrelated question to you, Quentin. How hard is bpftool's
> dependency on libcap? We've recently removed libcap from selftests, I
> wonder if it would be possible to do that for bpftool as well to
> reduce amount of shared libraries bpftool depends on.

There's not a super-strong dependency on it. It's used in feature
probing, for two things.

First one is to be accurate when we check that the user has the right
capabilities for probing efficiently the system. A workaround consists
in checking that we run with uid=0 (root), although it's less
accurate.

Second thing is probing as an unprivileged user: if bpftool is run to
probe as root but with the "unprivileged" keyword, libcap is used to
drop the CAP_SYS_ADMIN and run the probes without it. I don't know if
there's an easy alternative to libcap for that. Also I don't know how
many people use this feature, but I remember that this was added
because there was some demand at the time, so presumably there are
users relying on this.

This being said, libcap is optional for compiling bpftool, so you
should be able to have it work just as well if the library is not
available on the system? Basically you'd just lose the ability to
probe as an unprivileged user. Do you need to remove the optional
dependency completely?

Quentin

PS: Not directly related but since we're talking of libcap, we
recently discovered that the lib is apparently changing errno when it
maybe shouldn't and plays badly with batch mode:
https://stackoverflow.com/questions/71608181/bpf-xdp-bpftool-batch-file-returns-error-reading-batch-file-failed-opera
