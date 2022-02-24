Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92A4C20AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiBXAeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBXAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:34:18 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E79318F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:33:49 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n185so549746qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXLSRzCjsZCFoAyswTHwstLfgcPocf6IJntD36q7k5Q=;
        b=eXo4RTiBDfKvcK3zjsVQUbB5xRiFtVQPIcgfPkctoWbFm5mnw9b/rvv7i7W/blEnBC
         yIc5bKXcG1pxnlC0SRfWI5IDbeG0z3AZX3nQHmQHc113lD6Ol5OZ2tS74G+kNbIpat1S
         l2koJ9Bkk6iHOLOt0wQmQQ2nbaKX3GYVJzBJISlswiX/aKcziR17YdIj0OELDv5KI37/
         dvnuxypDL6azczfOlAZUUWle1zoc4hheSw3nVaAqiT9YpEGYVaSrD6iUaorNjL/zZVSV
         Ci3XLLXkSLWxebo0p8uOW6BT3b9e7L/3SBI7yIwiQbVWMq95CTdtytdFiiwQrPyOiCF+
         4Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXLSRzCjsZCFoAyswTHwstLfgcPocf6IJntD36q7k5Q=;
        b=12DpJbFk9GIkOTMQuxtUboQSddVZ9FkRfmH6ZwL+wa3hHs7KVHrT/rVOQGwcQ3DyZz
         25WZa8FloB7M10ZFpEETN9gwWzG44EHgDW2Ps8Qe9qwHlPzGo5OLjCwzk+8Qyrqc36DL
         a7vMfUqUeghpI5I87ijOseqIk5DkkcAO9tY8JTorz7fVg7ZEwBLRrHQFpCej578vQFP/
         bgmFAGoMmEjeLcLMQJe/46EL+VW9+CQt65WMvjZAgdlCXxBCtxbm0ksOIpFke3bX7yBQ
         kDSWi6Ek1DpJoFObwT6kX39R7rbbeydarHTSqebWVPtQdcZJ4xzJMPxbaC7g6YhCdnVC
         DMgA==
X-Gm-Message-State: AOAM531oVyGLNCdHEBY4nH/ByeyTA0H+kPJ75sVJV6DLDYWxDY1Pdkqq
        +iKQrTxxX39G/igj6y7uPqnJZ2FkTiYLz3Lp3Go/Ng==
X-Google-Smtp-Source: ABdhPJyH1H6InszUaBtbaqZ275mDiIyZuB59Sdfd5+Ui+46/fsxVuxWpwD4DpXN8ISi2NArkYmB9ZgKngl+DZhH3h3U=
X-Received: by 2002:a37:b287:0:b0:607:afb3:2c1d with SMTP id
 b129-20020a37b287000000b00607afb32c1dmr212265qkf.221.1645662828189; Wed, 23
 Feb 2022 16:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <CAEf4Bzb44WR2LiYchxB5JZ=Jdie6FEEi90mh=SCv07v4h4W11w@mail.gmail.com>
In-Reply-To: <CAEf4Bzb44WR2LiYchxB5JZ=Jdie6FEEi90mh=SCv07v4h4W11w@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 23 Feb 2022 16:33:37 -0800
Message-ID: <CA+khW7h4bL3qUst4nDy6LDmx73xVA_ch=PLc=o=v2iJNbGn21A@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 4:11 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 23, 2022 at 4:05 PM Hao Luo <haoluo@google.com> wrote:
> >
> > For binaries that are statically linked, consecutive stack frames are
> > likely to be in the same VMA and therefore have the same build id.
> > As an optimization for this case, we can cache the previous frame's
> > VMA, if the new frame has the same VMA as the previous one, reuse the
> > previous one's build id. We are holding the MM locks as reader across
> > the entire loop, so we don't need to worry about VMA going away.
> >
> > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > test_progs.
> >
> > Suggested-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
>
> LGTM. Can you share performance numbers before and after?
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>

Thanks Andrii.

On a real-world workload, we observed that 66% of cpu cycles in
__bpf_get_stackid() were spent on build_id_parse() and find_vma().
This was before.

We haven't evaluated the performance with this patch yet. This
optimization seems straightforward, so we plan to upstream it first
and then retest.
