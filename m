Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF42477D12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhLPUHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbhLPUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:07:32 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4313C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 12:07:29 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z8so40202064ljz.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 12:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOChCZL70qQ4dA6GolbcX8krlnTn1XDy9KNUU4VRGKQ=;
        b=ZdPc918BbIaT0Ch/ePTz/FS9sLXJEvwKdWDkFNWtmB9RXTPHNsw3hO9TnNXRe2U7Pr
         hP3G36LfQG0+zRhrRAhpi7ydAu3s4nT/rqsmhW/uWUqddV6OnhWVoadpJ6Qm6iJPeyHg
         6d/Mn3watLH+f4YxOlHp8gpFpV7p6SYQo+tguleVs2IOwFgtv2lwkb+8pssQQJraj1Gp
         I8e4L16WplGOrKXDretl3FDUr57rHlv8+0RawF8xnLPosVg1qCUjrQqwROcDcpafH6Ud
         UHPyGeAiuDhoEWQbkgBDn1wut98j8OIK/nrFjMggvjrUacK4LSUU7WyxXxUxEqzSVv4M
         MN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOChCZL70qQ4dA6GolbcX8krlnTn1XDy9KNUU4VRGKQ=;
        b=ovTEi2D+mx8q9DpATlePFDlsaDBVuSweYoosMu1oXwJbzmMEkSAOxWS2WnL63o3u8b
         iUw0A1sfwt4rdbG+dKUKJNfOW/K2io6NoZ4QmzIeGd8Jpii0Ot/H44QC5XT5Z93umbGg
         tnbAfalAqHwBvvAgbjYkNFy2IUpcREg4+C6l5Z0LXy4ZkcMbshTvMzbadu8bbtWGYTTr
         A2TmT7NN3x/5lzkzvXPbwkmggA18QifUq9ueLB3i7JNE/74pVwZbsGqhtRzq6sJsLm8x
         CQV4j72Gx8ddribUtN1wq0YRL4WzuHhUnFIbTWcjaEy6FfyFCBga56SGisclHQsjNS/T
         /ydA==
X-Gm-Message-State: AOAM5301FylTaL8Y9C5yGH2R9sbUzNcK9/jP+L3AriP+WUPBDCXYhrtn
        8ibK9zoYYnozuUKZoEuBVl5nkSbUW1djOZREu3WuKw==
X-Google-Smtp-Source: ABdhPJz7OEknT4eD+5r4J9ViSLA6s557E2FmjE3IjoD8EEz4rLxFEKVzupbJCu5a9CdFh+HTKMoOVBXvFByv3pNcb7M=
X-Received: by 2002:a2e:90d0:: with SMTP id o16mr16362588ljg.339.1639685247787;
 Thu, 16 Dec 2021 12:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20211215211847.206208-1-morbo@google.com> <20211215232605.GJ16608@worktop.programming.kicks-ass.net>
 <CAGG=3QUGmNRYOXYGKarULHwZxP6X=TNhcvbDKOFNMB4PQY23ag@mail.gmail.com>
In-Reply-To: <CAGG=3QUGmNRYOXYGKarULHwZxP6X=TNhcvbDKOFNMB4PQY23ag@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Dec 2021 12:07:16 -0800
Message-ID: <CAKwvOd=Ffmi5W6X=8Kho=v77ApSOZk3bG6rFeyGtovpJMS+p7g@mail.gmail.com>
Subject: Re: [PATCH] x86: use builtins to read eflags
To:     Bill Wendling <morbo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 12:00 PM Bill Wendling <morbo@google.com> wrote:
>
> ()On Wed, Dec 15, 2021 at 3:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Also note the thing was extern inline, and there's actually an
> > out-of-line symbol for them too. The out-of-line thing is explicitly
> > using %rax due to paravirt muck.

Oh, shoot, I wrote that.
d0a8d9378d16e
That was before we had __attribute__(no_stack_protector). Once the
minimal supported versions of both compilers support that, I'd love to
revert d0a8d9378d16e.

extern inline is the thing that makes me most nervous about moving the
kernel from -std=gnu89 to anything newer.  I should check whether
gnu99 uses c99 extern inline or gnu inline...

> >
> > I'm thinking you wrecked that bit.
>
> If you prefer, it could be written like so:
>
> extern inline unsigned long native_save_fl(void);
> extern __always_inline unsigned long native_save_fl(void)
> {
> #ifdef CONFIG_X86_64
>     return __builtin_ia32_readeflags_u64();
> #else
>     return __builtin_ia32_readeflags_u32();
> #endif
> }

Yes, that would fix the `extern inline` issue. I wonder if this is prettier as:

return IS_ENABLED(CONFIG_X86_64) ? __builtin_ia32_readeflags_u64() :
__builtin_ia32_readeflags_u32();
-- 
Thanks,
~Nick Desaulniers
