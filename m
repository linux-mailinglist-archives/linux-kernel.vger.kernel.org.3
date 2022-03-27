Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A135F4E8A79
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiC0WX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC0WXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:23:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA60DE0D6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:21:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so21755646lfj.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+XGXg2Rv7JERtxGIutirLnuoE1LsDWr7jV2Cgxp6Qg=;
        b=gFAofLg0jrpLSfWOSn6NF8CK/5FJeiqmvdtprA+Ls1Mv6ONwz0i3nBjywYz0dzLHzf
         W/CiYgXmm+GTA48OjFKdGNGGbYL87ct6SDyeJZPV+KZ73BJy1mRn+IXxWXx04TQZltmb
         lX69SAdTaAFtQrCmfgUk8ezpJltZM3CTyzlaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+XGXg2Rv7JERtxGIutirLnuoE1LsDWr7jV2Cgxp6Qg=;
        b=ah+SKS5Wdd+AZk8btMr/Vb3BS3dr3HRkcZ2eqKv0oHRYrMW3XWDWRemaL+exSiozdV
         yTgRnq8j2bmzlxA6aG6zeyWdxh2ROkA7mEnaiWo7QJ1JVKsCicaAidVGNggJhCbVIvsn
         LVTf6QZLWN5mZx6by0KFS/4EKSbOe2gbnrL9k3pZuDSCZlvDWt6ILKgtUwt5dc0xqMen
         Hew9xTqL4lxNga08oJbNMpND2wwl6HQTL0FIHjMy+zRjKHicR/UQ9nnjsQ2yf9yjywQ9
         ydD599ET81EFiigcDA501jTidH2b1l1PBADgZ3YNPINGL61bnxPwPnDxeQvWvGWPY7E2
         dyUg==
X-Gm-Message-State: AOAM530MQdmPMViqhXC4Wy0QTIYkFSAmlIieASMsY634D+2gqvriiAHZ
        r+sn/gsm9ncNLpPYP83TdwYLqEeOJek3cec17cU=
X-Google-Smtp-Source: ABdhPJwB8bAi6JGmTMPTdihi/NnZybQWWgef0uGFsIpyPR313yG6ac1sru5gm/tlhnoZrVg7tk/HoQ==
X-Received: by 2002:a05:6512:3981:b0:448:40e5:cf90 with SMTP id j1-20020a056512398100b0044840e5cf90mr16387427lfu.656.1648419697573;
        Sun, 27 Mar 2022 15:21:37 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s21-20020a2e9c15000000b0024917f4e911sm1522943lji.80.2022.03.27.15.21.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 15:21:35 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id bu29so21881421lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:21:34 -0700 (PDT)
X-Received: by 2002:a05:6512:3ca1:b0:44a:93f1:45cf with SMTP id
 h33-20020a0565123ca100b0044a93f145cfmr2930787lfv.542.1648419694374; Sun, 27
 Mar 2022 15:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
 <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
In-Reply-To: <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 15:21:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
Message-ID: <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Fedor Pchelkin <aissur0002@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 2:53 PM <aissur0002@gmail.com> wrote:
>
> I am sorry, that was my first attempt to contribute to the kernel and
> I messed up a little bit with the patch tag: it is actually a single,
> standalone patch and there has been nothing posted previously.

No problem, thanks for clarifying.

But the patch itself in that case is missing some detail, since it
clearly doesn't apply to upstream.

Anyway:

> In few words, an error occurs while executing close_range() call with
> CLOSE_RANGE_UNSHARE flag: in __close_range() the value of
> max_unshare_fds (later used as max_fds in dup_fd() and copy_fd_bitmaps())
> can be an arbitrary number.
>
>   if (max_fd >= last_fd(files_fdtable(cur_fds)))
>     max_unshare_fds = fd;
>
> and not be a multiple of BITS_PER_LONG or BITS_PER_BYTE.

Very good, that's the piece I was missing. I only looked in fs/file.c,
and missed how that max_unshare_fds gets passed from __close_range()
into fork.c for unshare_fd() and then back to file.c and dup_fd(). And
then affects sane_fdtable_size().

I _think_ it should be sufficient to just do something like

       max_fds = ALIGN(max_fds, BITS_PER_LONG)

in sane_fdtable_size(), but honestly, I haven't actually thought about
it all that much. That's just a gut feel without really analyzing
things - sane_fdtable_size() really should never return a value that
isn't BITS_PER_LONG aligned.

And that whole close_range() is why I added Christian Brauner to the
participant list, though, so let's see if Christian has any comments.

Christian?

Btw, do you have a pointer to the syzbot report? I see the repro and
the crashlog you attached, but it would be good to have that pointer
to the syzbot original too.

Or did you just do this by running syzkaller yourself and there is no
external report?

                 Linus
