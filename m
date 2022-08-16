Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632FA5965CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiHPXAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiHPXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:00:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A7E7B1F5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:00:27 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-32a17d3bba2so189411587b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ia+gWUguoxZfAy1Dg2ZzsdLR8URymW2ftEEeLv7mHds=;
        b=Yd//NI6tGwsKJEtX6z8PRhifk+LuQiS1aOojM+MFA28Lu8+R5bhMsUQ6ynIAkNZrze
         8vyihr/nj/DOBXHTpDmnvCQvjYx6VSIZEH5ptw08LL2k7akIFrov9i68o0LNb/DVMF33
         I6R4HK28J6+SKN6RlbyxyG1U9sejG6tOZVHgYZ4zjQOjWTkSN04v4s3XVQZf6ObCcRJ+
         SDoYrq/sWZLEHUgrsh7Mwm1dJaFYvFFHIoq//fEip6zwL+ckjoLEhnn9RoxtjkemSZuO
         T9A2lm5sZDGXZcgIhlMODQxOm1mWr71ql/5sgS6Ly4ajPBuecTzbM99Sgdb5Yt7pw7jr
         v0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ia+gWUguoxZfAy1Dg2ZzsdLR8URymW2ftEEeLv7mHds=;
        b=sA9Rjm83mCt6KuTfLusRUtekCqrrLcA4uWsTrBCPjjADkaHA+5O3/e//G2why91fdX
         VN200rQhlqZZfyhe8/ravwOaVQbNUHuUNB8Zj2tc3eFnC8b3ytNambAOrIGCoGelvh+1
         0g/Ed+RC6dpyaBbCiI3oAKaCWiOtIsezMaHiyi86I8K8soUhkk3zAYYsT4zZ+x2tBFaR
         sR6D5XClMthRqebfh0ONiwJReeY0Kg+PbuRo4lbUJMM8uxYZAyerJBwVC1PI5xYdIOZL
         10BcDrDdj6+AooaJnH3591x/ywnc5OyEUQhPW7ERPrgvOCMSKl4xUpHPG0YWe4AYayWS
         Z3fA==
X-Gm-Message-State: ACgBeo2EsQ3LEx3wT9bLiTeRm4FeZ3gtn4EGg+oYFFqHf9MvHqsyWm2Q
        zsMYrn4pX1A8f70M5Tssave402UXiRK6komWwSq7wA==
X-Google-Smtp-Source: AA6agR7i3ics6rMa6+rNF6jz5fcfliKyCvfj8cEvE52wQyRLeSajtUCH09+uQDf4N+H9qe9ZFH8JjuCnjEKDRfxG/Lc=
X-Received: by 2002:a81:4806:0:b0:32f:f84c:f30a with SMTP id
 v6-20020a814806000000b0032ff84cf30amr11990225ywa.107.1660690826444; Tue, 16
 Aug 2022 16:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220816214945.742924-1-haoluo@google.com> <CAEf4Bza1SMFvzofz4RkBF=pByFHp+Z1v16Z+TMAQZ6rD2m9Lxg@mail.gmail.com>
 <CA+khW7hHGL1DAMSOjbJSj21wJYY=j4VrRJcFB1zv52Db20_MGA@mail.gmail.com> <CAEf4BzbBOrVU+BWySMk_v3w6019+5VpNXZY03JpmiwoQPnV1yA@mail.gmail.com>
In-Reply-To: <CAEf4BzbBOrVU+BWySMk_v3w6019+5VpNXZY03JpmiwoQPnV1yA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 16:00:15 -0700
Message-ID: <CA+khW7g41jBCB3ePKpTgTC4iuvpWw7gp+272UWSdT5uSC2tG-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: allow disabling auto attach
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Aug 16, 2022 at 3:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 16, 2022 at 3:16 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Aug 16, 2022 at 3:01 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Aug 16, 2022 at 2:49 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Add libbpf APIs for disabling auto-attach for individual functions.
> > > > This is motivated by the use case of cgroup iter [1]. Some iter
> > > > types require their parameters to be non-zero, therefore applying
> > > > auto-attach on them will fail. With these two new APIs, Users who
> > > > want to use auto-attach and these types of iters can disable
> > > > auto-attach for them and perform manual attach.
> > > >
> > > > [1] https://lore.kernel.org/bpf/CAEf4BzZ+a2uDo_t6kGBziqdz--m2gh2_EUwkGLDtMd65uwxUjA@mail.gmail.com/
> > > >
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
[...]
> > > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > > index 61493c4cddac..88a1ac34b12a 100644
> > > > --- a/tools/lib/bpf/libbpf.h
> > > > +++ b/tools/lib/bpf/libbpf.h
> > > > @@ -260,6 +260,8 @@ LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
> > > >  LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog);
> > > >  LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
> > > >  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
> > > > +LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
> > > > +LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
> > >
> > > please add these APIs to libbpf.map as well
> > >
> >
> > Ok. Which section? LIBBPF_1.0.0? Do the items in each section have a
> > particular order?
>
> Yes, 1.0.0 section. All the functions are sorted alphabetically.
>

Thanks for confirming. :)
