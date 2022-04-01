Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF754EFC1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352752AbiDAVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiDAVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:22:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4661A61DB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:20:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so6329684pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARJke9nZG+KA8VPMsISAyE/VOgAvAqXDYBGJaZ7PwJ8=;
        b=IoQ+IF9pZjOdaAlwkJjoyDj7+lMyZs+JDSBQ/f/zmQenv8LZcZg+67JU01CD7IjRA5
         1ZeQta99Mcnx702ajs2EQ5D0ZhGBxlqPul0LrbJHAQoXQ4Zd7HJBv3qjc4eXXXzva3h2
         b16zajdshzILmURKHLCwYwLxxeR6C6hjh3humefOsYMgK7DxgqmumqBeCsu3W6stCnnu
         P9UIFB150FqbSk4y2lLf8NpLEaP9pbFaxaItPtQQUxgDzL3/2/i0rsSp7vOg+yOuIyXa
         XC+92WVzoL+4ZX2gtjMODQ3vYZOsEv6pKoTLMTIcHhZZ/CJSyezo7QvPJ+46I6cshP+i
         eXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARJke9nZG+KA8VPMsISAyE/VOgAvAqXDYBGJaZ7PwJ8=;
        b=HQrGaSfGPZuQ/37DDLwFOJgBuJw/VSjVMW+7qgAHm003J8EiIn5+P6D+3/qX6EfT9w
         x/g3qgygjOBIxXqgeaNaodjd0Ciy9d43TQLC0LcjOiiRlyFP80BBzHYAS1UyAmTfRngp
         ONOcQug+VYPthuSAQ0T1MjGpLnR15ak+4ujqOKML1sKExgcUaYbGspmkpdcEen8AgsH+
         pd1EoTo0mJgYN8sPRfu8aBsPDb1VAVRsdvBWhA6iOUs/5e8qYb9l/TU0YQXKq0jy9DWA
         X8tJC9ngVyKSAPl6iI9lNLJujg0vf2rnwrRZW7TKWMuTY/ImNqW0T0Fr3fQnenptZC4W
         Cg5A==
X-Gm-Message-State: AOAM533UXH3lSwVqIsgwMs50nWSNLJOAbrjZvdOCq1YE7IbqJrFiqd9G
        2erkIPLM8GBJVfbckt51pt7XHmFPweMI8+vIbAZ0Hg==
X-Google-Smtp-Source: ABdhPJzkRMV+HQin5EQjw/rNb8X84/R0SpjwlSVAwYntQcfKZagwnekcysJAr6HB0PyKdXMBXYnecrXWulXDtgaGHLM=
X-Received: by 2002:a17:902:cec2:b0:154:6df6:1e6a with SMTP id
 d2-20020a170902cec200b001546df61e6amr12477128plg.58.1648848038983; Fri, 01
 Apr 2022 14:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220331154555.422506-1-milan@mdaverde.com> <20220331154555.422506-2-milan@mdaverde.com>
 <f2f8634f-7921-dc7d-e5cb-571ea82f487d@isovalent.com> <CAEf4BzbYmOVRvCU-f6XbNJQb_ptM+BPjAcMD9XEN_wTKRHUWsg@mail.gmail.com>
In-Reply-To: <CAEf4BzbYmOVRvCU-f6XbNJQb_ptM+BPjAcMD9XEN_wTKRHUWsg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 1 Apr 2022 22:20:27 +0100
Message-ID: <CACdoK4Koj0_OHtrorOXGVf1gAQOq6tcNQmCfAFLWSZadiJpnvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf/bpftool: add syscall prog type
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

On Fri, 1 Apr 2022 at 19:40, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 9:04 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2022-03-31 11:45 UTC-0400 ~ Milan Landaverde <milan@mdaverde.com>
> > > In addition to displaying the program type in bpftool prog show
> > > this enables us to be able to query bpf_prog_type_syscall
> > > availability through feature probe as well as see
> > > which helpers are available in those programs (such as
> > > bpf_sys_bpf and bpf_sys_close)
> > >
> > > Signed-off-by: Milan Landaverde <milan@mdaverde.com>
> > > ---
> > >  tools/bpf/bpftool/prog.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > > index bc4e05542c2b..8643b37d4e43 100644
> > > --- a/tools/bpf/bpftool/prog.c
> > > +++ b/tools/bpf/bpftool/prog.c
> > > @@ -68,6 +68,7 @@ const char * const prog_type_name[] = {
> > >       [BPF_PROG_TYPE_EXT]                     = "ext",
> > >       [BPF_PROG_TYPE_LSM]                     = "lsm",
> > >       [BPF_PROG_TYPE_SK_LOOKUP]               = "sk_lookup",
> > > +     [BPF_PROG_TYPE_SYSCALL]                 = "syscall",
> > >  };
> > >
> > >  const size_t prog_type_name_size = ARRAY_SIZE(prog_type_name);
> >
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> >
> > Thanks! This one should have been caught by CI :/. Instead it complains
> > when you add it. This is because BPF_PROG_TYPE_SYSCALL in the UAPI
> > header has a comment next to it, and the regex used in
> > tools/testing/selftests/bpf/test_bpftool_synctypes.py to extract the
> > program types does not account for it. The fix should be:
> >
> > ------
> > diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> > b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> > index 6bf21e47882a..cd239cbfd80c 100755
> > --- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> > +++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> > @@ -180,7 +180,7 @@ class FileExtractor(object):
> >          @enum_name: name of the enum to parse
> >          """
> >          start_marker = re.compile(f'enum {enum_name} {{\n')
> > -        pattern = re.compile('^\s*(BPF_\w+),?$')
> > +        pattern = re.compile('^\s*(BPF_\w+),?( /\* .* \*/)?$')
>
> small nit: do you need those spaces inside /* and */? why make
> unnecessary assumptions about proper formatting? ;)

No I don't need the spaces, I'll remove them indeed, thanks. I'll send
the patch next week.
