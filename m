Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC44C213C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiBXBnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBXBnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:43:52 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39F7C784
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:43:22 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id c23so1058915ioi.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0+yvP+F0EsSuoYlT67FNUqaSTeigpT+q0Adpduwy5E=;
        b=PKlhuVKsNrEUVyGzqvCwpR8pOqGCDrmzI7od+f6QUwpI4cmRgdMiZkhC5ZyCbdVKht
         YDd6YnwP1YyLrazZS6FiQPbDdXWPhDuMTIgbXeHtIZTdWhdy6R2FcZh8vyYb7PN4QLGa
         Bf4Hs/73etduJ2HA/jcIzkMAmCVnSPpnrt41CtswnJO4g5BnMddF2fk2FnfNjBrYQxEg
         Pt1wVmjrz/iyWUmePS2L/K8+pz3Y5VUOf5kHlBTC2AGYOktfHzjue9EzRDvDo0BpYkGF
         Oa7GDG/lKeJffigWDZnuuvB9hut5Vlqah1bHh3Ut5kTCxtK3+iQi3CixsxR1VBGwIsbK
         yXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0+yvP+F0EsSuoYlT67FNUqaSTeigpT+q0Adpduwy5E=;
        b=r0DkuWkZxoZJC2ELpru3GDyMN4AKGiqTiDpMZHV/iBw5uOnK6xjzPNifU4Sm+trw5M
         0OOzkl7SPeFkpJdq+omP0I8TM+raF8abMmfyONFPpknbBrE4zHZAgNifD/saXGbtO6zO
         WLCrbwF/nksG6F0gzEm6BQoXVrxCv862Rs9YhrTK1AX2pnJKfGEyz6hXdOY2IHmvhZ8v
         u3KhI5ZkY4Od7TeodB/9uhHA9CQJGcI0cA9gK9NRQDhh+DVXrH1F8TtQNBo8nDdO1+YL
         2nxqAmZ3UfBAl5ojhqKtGeOpGEvZw8E0jZLH/QLY1Mgttk6fsokDoGmVGoept2lPUaJ+
         PJLA==
X-Gm-Message-State: AOAM5323zIU58D9qvqu5JBF1iHSrgNV2/PafftJOapmXzW+R0o64Qdx8
        ooBB8IhGBPKOjNkxutL4dAlKhlf/q9s0t/8KoooR9x+RDnepEw==
X-Google-Smtp-Source: ABdhPJwnnHMIdkfAYafPTW474UNEZq4sloTVO0KQ5JUKtN+zfBR0/VtawBwUv/EAyao0Tl6ABMKKCTTR57iai/snwLE=
X-Received: by 2002:a05:622a:178b:b0:2dd:cbdf:ae23 with SMTP id
 s11-20020a05622a178b00b002ddcbdfae23mr403443qtk.566.1645665123836; Wed, 23
 Feb 2022 17:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <CAEf4Bzb44WR2LiYchxB5JZ=Jdie6FEEi90mh=SCv07v4h4W11w@mail.gmail.com>
 <CA+khW7h4bL3qUst4nDy6LDmx73xVA_ch=PLc=o=v2iJNbGn21A@mail.gmail.com> <CAEf4BzaYxgnotk+J+czhAjXbfzEoOrnyiVMmmkjDDVHzYUs48A@mail.gmail.com>
In-Reply-To: <CAEf4BzaYxgnotk+J+czhAjXbfzEoOrnyiVMmmkjDDVHzYUs48A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 23 Feb 2022 17:11:52 -0800
Message-ID: <CA+khW7ir8DTkVUae64wW9ju8fj9=gW5NHgAJ65ixvYsbubVr-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
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

On Wed, Feb 23, 2022 at 5:10 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 23, 2022 at 4:33 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 4:11 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Feb 23, 2022 at 4:05 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > For binaries that are statically linked, consecutive stack frames are
> > > > likely to be in the same VMA and therefore have the same build id.
> > > > As an optimization for this case, we can cache the previous frame's
> > > > VMA, if the new frame has the same VMA as the previous one, reuse the
> > > > previous one's build id. We are holding the MM locks as reader across
> > > > the entire loop, so we don't need to worry about VMA going away.
> > > >
> > > > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > > > test_progs.
> > > >
> > > > Suggested-by: Greg Thelen <gthelen@google.com>
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > >
> > > LGTM. Can you share performance numbers before and after?
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> >
> > Thanks Andrii.
> >
> > On a real-world workload, we observed that 66% of cpu cycles in
> > __bpf_get_stackid() were spent on build_id_parse() and find_vma().
> > This was before.
> >
> > We haven't evaluated the performance with this patch yet. This
> > optimization seems straightforward, so we plan to upstream it first
> > and then retest.
>
> Ok, once it lands upstream, I'd really appreciate if you can retest
> and update us with numbers. Thanks!

Sure, will do that.
