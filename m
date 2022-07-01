Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF915633B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiGAMv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiGAMv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:51:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1DC31920
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:51:25 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0150C3F1E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656679884;
        bh=SOG/VBC//rJ6Enw3YOndmECtgLMXa+sFIIC3B/W9Q0s=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AU05GE0MHA7JLgEdJUp0bgVNRh8S2/Dkte/RZQ1hP2hQ4E2yZBYmBgGNWZU/z0FFd
         StmeP83ZLDaRe7EmBUNyfZPM++lo/1LTkgu3JDpGvJS0OradcDL57Qq5mnqCqzf0q8
         6akdi5HR8Utpjjyvs502mVpXfxB4RlQl90SzfjnPc16lbLgDNC09qk/AS7y3OyqK5y
         0FdOIsFMjuTWyvhcSyFV/E3ie0Ij9QVFBNjU5ssW6Hbx3kRbP6Dwi4Z//cJrON2VrP
         WPfuxFWiY7Xr2XMorX+RzhGyss/p5hOaNM6rTXfa3AytHycKx/cWDx1HljTJFgyEke
         OxA8zdzudpLVA==
Received: by mail-pg1-f200.google.com with SMTP id g67-20020a636b46000000b0040e64eee874so1242655pgc.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SOG/VBC//rJ6Enw3YOndmECtgLMXa+sFIIC3B/W9Q0s=;
        b=siAN5NB6U/RqR2YU9iDwi4QoD+yCdCdbd9hcszGOm4FTzl2mu0rGSqfogs1o6XN9qv
         jHJWqghvlpYbwNZYyjCMgQVFCWaC637pwlTk21KpLxe7R+9VP7W/UV4d3V6hLcpcnuq4
         flIMCGuzcOXXcdIRHjl2Ym0ht1c1UVZR1bE3/OAvmtevmO3ZtL0knErIZ9VAHh3+jKzH
         yvbHNL0FvwJD/P7zqDfsCyRqQkAlNpmZmHLW0aZ+fiP1vNXzU52+4lFpuP4vvut/Mf93
         wN+pexR8BfFQTdMubBh5B9Tg8WJ2ITEYKYqoq9cnK7jGEfg+Ueg8PgQ4Tee7C9R4grSH
         NC/Q==
X-Gm-Message-State: AJIora/QOVi8R/s8/ppyd9XHfQDW8t15MCxYI5orzdYNvkx77xK1tfCb
        +huASM+rEsjawIJ+PWEpieqq/YwmfytYwvOcwvfJcbqMTkrah3KCCUikS3urlrG0WQfNHQLuVkw
        +P0l/yujzx2ay7k34YxLmxAxPUm79+EWXRFhwapsQBZOcBnfnhNQ0X5WN
X-Received: by 2002:a17:90b:3b44:b0:1ec:d7a8:7528 with SMTP id ot4-20020a17090b3b4400b001ecd7a87528mr18493164pjb.231.1656679879891;
        Fri, 01 Jul 2022 05:51:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1Ie4n0kwk5q5OgJth6/oefXYVrmG3sbVp3cVySLsAEV7sjVKLA/tmnoU47zgjKdXY4iovOMA40oVR9GksqAU=
X-Received: by 2002:a17:90b:3b44:b0:1ec:d7a8:7528 with SMTP id
 ot4-20020a17090b3b4400b001ecd7a87528mr18493128pjb.231.1656679879459; Fri, 01
 Jul 2022 05:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220429104052.345760505@linuxfoundation.org> <20220429104053.296096344@linuxfoundation.org>
 <CAMy_GT9YbgqsoLbCDqhHpXNW6EejgK+YaE4YPxpxcmer+qn-1g@mail.gmail.com> <YrWbZi7jt1x83tRC@kroah.com>
In-Reply-To: <YrWbZi7jt1x83tRC@kroah.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Fri, 1 Jul 2022 20:51:07 +0800
Message-ID: <CAMy_GT_quYAnZBDx76TkjaDOH0jG6EL_Do0+MAc4VF4-189wEg@mail.gmail.com>
Subject: Re: [PATCH 5.15 33/33] selftests/bpf: Add test for reg2btf_ids out of
 bounds access
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 7:44 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 24, 2022 at 06:33:57PM +0800, Po-Hsu Lin wrote:
> > On Fri, Apr 29, 2022 at 6:47 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > >
> > > commit 13c6a37d409db9abc9c0bfc6d0a2f07bf0fff60e upstream.
> > >
> > > This test tries to pass a PTR_TO_BTF_ID_OR_NULL to the release functi=
on,
> > > which would trigger a out of bounds access without the fix in commit
> > > 45ce4b4f9009 ("bpf: Fix crash due to out of bounds access into reg2bt=
f_ids.")
> > > but after the fix, it should only index using base_type(reg->type),
> > > which should be less than __BPF_REG_TYPE_MAX, and also not permit any
> > > type flags to be set for the reg->type.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > Link: https://lore.kernel.org/bpf/20220220023138.2224652-1-memxor@gma=
il.com
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  tools/testing/selftests/bpf/verifier/calls.c |   19 ++++++++++++++++=
+++
> > >  1 file changed, 19 insertions(+)
> > >
> > > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > > @@ -108,6 +108,25 @@
> > >         .errstr =3D "R0 min value is outside of the allowed memory ra=
nge",
> > >  },
> > >  {
> > > +       "calls: trigger reg2btf_ids[reg->type] for reg->type > __BPF_=
REG_TYPE_MAX",
> > > +       .insns =3D {
> > > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> > > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
> > > +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
> > > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,=
 0),
> > > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> > > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,=
 0),
> > > +       BPF_EXIT_INSN(),
> > > +       },
> > > +       .prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
> > > +       .result =3D REJECT,
> > > +       .errstr =3D "arg#0 pointer type STRUCT prog_test_ref_kfunc mu=
st point",
> > > +       .fixup_kfunc_btf_id =3D {
> > > +               { "bpf_kfunc_call_test_acquire", 3 },
> > > +               { "bpf_kfunc_call_test_release", 5 },
> > > +       },
> > > +},
> > > +{
> > >         "calls: overlapping caller/callee",
> > >         .insns =3D {
> > >         BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 0),
> > >
> > >
> >
> > Hello Greg,
> >
> > When I tried to build the bpf selftest from 5.15.49 source tree on a
> > Ubuntu Jammy instance running with 5.15.49-051549-generic, I got the
> > following error message:
> >
> > In file included from
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/tests.h:21,
> >                  from test_verifier.c:432:
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:124:10:
> > error: =E2=80=98struct bpf_test=E2=80=99 has no member named =E2=80=98f=
ixup_kfunc_btf_id=E2=80=99
> >   124 |         .fixup_kfunc_btf_id =3D {
> >       |          ^~~~~~~~~~~~~~~~~~
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:124:9:
> > warning: braces around scalar initializer
> >   124 |         .fixup_kfunc_btf_id =3D {
> >       |         ^
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:124:9:
> > note: (near initialization for =E2=80=98tests[150].errstr_unpriv=E2=80=
=99)
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:125:17:
> > warning: braces around scalar initializer
> >   125 |                 { "bpf_kfunc_call_test_acquire", 3 },
> >       |                 ^
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:125:17:
> > note: (near initialization for =E2=80=98tests[150].errstr_unpriv=E2=80=
=99)
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:125:50:
> > warning: excess elements in scalar initializer
> >   125 |                 { "bpf_kfunc_call_test_acquire", 3 },
> >       |                                                  ^
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:125:50:
> > note: (near initialization for =E2=80=98tests[150].errstr_unpriv=E2=80=
=99)
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:126:17:
> > warning: braces around scalar initializer
> >   126 |                 { "bpf_kfunc_call_test_release", 5 },
> >       |                 ^
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:126:17:
> > note: (near initialization for =E2=80=98tests[150].errstr_unpriv=E2=80=
=99)
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:126:50:
> > warning: excess elements in scalar initializer
> >   126 |                 { "bpf_kfunc_call_test_release", 5 },
> >       |                                                  ^
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:126:50:
> > note: (near initialization for =E2=80=98tests[150].errstr_unpriv=E2=80=
=99)
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:126:17:
> > warning: excess elements in scalar initializer
> >   126 |                 { "bpf_kfunc_call_test_release", 5 },
> >       |                 ^
> > /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:126:17:
> > note: (near initialization for =E2=80=98tests[150].errstr_unpriv=E2=80=
=99)
> > make: *** [Makefile:508:
> > /home/ubuntu/linux/tools/testing/selftests/bpf/test_verifier] Error 1
> >
> > Which is introduced by this commit f59e6886c "selftests/bpf: Add test
> > for reg2btf_ids out of bounds access" on 5.15. With this commit
> > reverted, there will be another error in progs/timer_crash.c like in
> > 5.10 [1]:
> >
> > progs/timer_crash.c:8:19: error: field has incomplete type 'struct bpf_=
timer'
> >         struct bpf_timer timer;
> >                          ^
> > /home/ubuntu/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_he=
lper_defs.h:39:8:
> > note: forward declaration of 'struct bpf_timer'
> > struct bpf_timer;
> >        ^
> > 1 error generated.
> >
> > Maybe commit "selftests/bpf: Add test for bpf_timer overwriting crash"
> > should be reverted on 5.15 as well.
>
> Should the test be fixed instead?
>
OK!
I will try if I can backport the fix. Otherwise will just go for the revert=
.
Thanks!

> I'll take patches for either, thanks.
>
> greg k-h
