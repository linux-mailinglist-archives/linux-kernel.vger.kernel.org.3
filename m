Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF18058A12C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiHDTZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiHDTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:25:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A755FAE7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ED36B82717
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1283BC43470
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659641100;
        bh=PKX3OoDI0cvLHiN780Nvx2XfYPSh7QWOyU5r9fo/tus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Anr99FS/HhGiIMrQZqHjDTucQNYDYxoLB9XFxLjXEW60m622qaWVtRpAjd1F/rgMT
         3hZwi14NKFQlm/5pGx8ABy6YvrvYkNq5lSiZaMBNNwIBbwKqKclGzCXcYJBHkc02ZP
         NnQwbheBjHBH867YJPQEGGcpUNc6AvAdHUyyenFmgJZQOsfmpZULJDAb8M3dPM17lU
         7Gm5/z87SY9KhsZhJ8lST7FlQxOxYTEPZ8Ev1Yu0jm6zeMteXpgaCykQaj1v093C1y
         ofwyPth9JXp3z40dtBiqu7iT6cXFjsi6dV3h2kB+aq166c4Zm3XjGV5UOIEA7SFZyO
         ShfrU7hMNMAUw==
Received: by mail-wr1-f53.google.com with SMTP id z16so836497wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 12:24:59 -0700 (PDT)
X-Gm-Message-State: ACgBeo2Hn4+qLcBxQPZ2S/2ri056qghALGeGHtBVlHqiisoX4mbyFV+N
        z5THzYnj31+I5bqbn8yBppyOY5VuVzUzdzuLHPI=
X-Google-Smtp-Source: AA6agR5nJ8kOJ1KsbpBldJLoYbuUk4aeTJu478vDdBOLaBoPdwWyuN8lPQSm1sEovhlpc7uIzGpM5Z7/XraejW/ifUo=
X-Received: by 2002:a5d:6489:0:b0:220:6399:c7c8 with SMTP id
 o9-20020a5d6489000000b002206399c7c8mr2365846wri.655.1659641098259; Thu, 04
 Aug 2022 12:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian> <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
In-Reply-To: <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 4 Aug 2022 21:24:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
Message-ID: <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 8:52 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 4, 2022 at 11:37 AM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:cov_trace_cmp
> >
> > git bisect points to 3876a8b5e241 ("drm/amd/display: Enable building new display engine with KCOV enabled").
>
> Ahh. So that was presumably why it was disabled before - because it
> presumably does disgusting things that make KCOV generate even bigger
> stack frames than it already has.
>
> Those functions do seem to have fairly big stack footprints already (I
> didn't try to look into why, I assume it's partly due to aggressive
> inlining, and probably some automatic structures on stack). But gcc
> doesn't seem to make it all that much worse with KCOV (and my clang
> build doesn't enable KCOV).
>
> So it's presumably some KCOV-vs-clang thing. Nathan?

The dependency was originally added to avoid a link failure in 9d1d02ff3678
 ("drm/amd/display: Don't build DCN1 when kcov is enabled") after I reported the
problem in https://lists.freedesktop.org/archives/dri-devel/2018-August/186131.html

The commit from the bisection just turns off KCOV for the entire directory
to avoid the link failure, so it's not actually a problem with KCOV vs clang,
but I think a problem with clang vs badly written code that was obscured
in allmodconfig builds prior to this.

The dml30_ModeSupportAndSystemConfigurationFull() function exercises
a few paths in the compiler that are otherwise rare. On thing it does is to
pass up to 60 arguments to other functions, and it heavily uses float and
double variables. Both of these make it rather fragile when it comes to
unusual compiler options, so the files keep coming up whenever a new
instrumentation feature gets added. There is probably some other flag
in allmodconfig that we can disable to improve this again, but I have not
checked this time.

        Arnd
