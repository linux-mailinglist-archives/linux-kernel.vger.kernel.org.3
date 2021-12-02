Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932AC4661D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357079AbhLBLCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356693AbhLBLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:01:59 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73CDC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:58:37 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso8735890ood.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzqbKmhzTEjnI7ZTKD5CYs3ONkw0vgvO+4qQMNKWOhs=;
        b=jBAsyWHHtQdvdVwofFUKLl/vEvVJTq5ZKgdda+6KDlneA10k5qh543jBb7XRJB7zwH
         GDkgVoc1NgPTdGPxq5kGEPgjiyo6474g2dWFaiZvIv3RELjH+sl7cvBc0wNr2Io7gx4r
         TL1CljXVKP4lkmYZVs6qSk++UV4W09Nd3kzkeP0edvpDSlaFudb7WjujxQ6EfyB8HtZt
         LjVzXVyCIOOu2LUY1yoStp+YcWOPe8yFGWEQ1wI6U2fZGBRMlG5TwEBlzfDmwgDgOWs0
         yvZuXZ2cZnUNX10CjQpmCoKO9hUQHdyyhexybMfdEozrJSX0fNByluuAk+/F+osgP7Fb
         /3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzqbKmhzTEjnI7ZTKD5CYs3ONkw0vgvO+4qQMNKWOhs=;
        b=kn+TsF7wjZabG3WND6fXDiYMYJUostfDA7MiCPiIU8XGIjbEVTNP0h6kwnHhnscKdQ
         PfiYvpUjpJzimf1g3XmMGptp9vSZETyM5FJyRR4y9D+BbZ/G9j+q6WYPDyfB6H0pditq
         LuyTqKswKhlIj/vsw8rOxDtuxkHH8TG/UDa9mOYpWwF58nXCYa4qf2Dcrlt2PPXvwvNr
         v3nGWcMVOi2U00e6CtNUFQkzgMENOXVKrXFIgHMOWIAQ5xxl8eBxNR903+2oHJtsWuC7
         o0LlJHEhqqjMoUuM4YFT0lllBDJw25J66LkUhq3CUh4Utz3mytGkA0NCdt0Shlj/V8GI
         G2mw==
X-Gm-Message-State: AOAM532gHrlfWxHtcxnkziKpF6BOyFSNcXzFCIG5sRXmZ1bpXXoO1z4g
        KN2+9U+4AGH5UfnNlz4Wjel+XT0NBMeEphPfSctE2w==
X-Google-Smtp-Source: ABdhPJy0SYfwgINWHWi/WuELADe0lbasBO4rFHdE66HRkYYEYqLp965NMbMU98OEeGl+lXo3NMeRuBkV89kTsnLtDwk=
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr8131443oos.25.1638442716865;
 Thu, 02 Dec 2021 02:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
 <YadiUPpJ0gADbiHQ@FVFF77S0Q05N> <811af0bc-0c99-37f6-a39a-095418b10661@huawei.com>
 <Yaic31SbYFJ4zAl0@elver.google.com> <b641f1ea-6def-0fe4-d273-03c35c4aa7d6@huawei.com>
In-Reply-To: <b641f1ea-6def-0fe4-d273-03c35c4aa7d6@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Dec 2021 11:58:20 +0100
Message-ID: <CANpmjNOOVQjoczanQndUoDRMCOfV4FB6bnezEjskKh3iDzaQVg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Enable KCSAN
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 11:45, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
[...]
> >> for now and more explanation into changlog.
> > So what I gather arm64's final select line may look like:
> >
> >       select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)
> Yes,  that's what we want now.

I think we have all the pieces sorted out, so hopefully you have
everything you need to do v3.

[...]
> > I actually have a "fix" for the data race in rwsem_spin_on_owner, that
> > also shows where the other racing access comes from... which reminds me:
> > https://lkml.kernel.org/r/20211202101238.33546-1-elver@google.com
>
> There's a owner_on_cpu(),  we could reuse it,

That looks like a reasonable thing to do, but can't say if it is
actually the right thing to do. You could suggest it in reply to the
patch I just sent and see what people say.

Thanks,
-- Marco
