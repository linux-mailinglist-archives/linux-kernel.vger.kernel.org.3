Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A368B46E619
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhLIKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhLIKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:04:59 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF05C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:01:25 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so5590665otl.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwZ2q+ht+X4UdZ54dnQJfViFXAccYyFB0RjG6X/nT4g=;
        b=Ky/1aN74gCrR3pXS2bYGqEQoF4ja5H0lxuwpC8B3clyAJ1ArBBnxap6FkYSqx4EF6w
         a7Zsv/MfSIZoBnUCQdPJDWYlflLWTIkQcBaPh7sLxU9OvIc66FxM/5ob4S7wlqDJHBto
         rIr6wsn5M9AS8M6xV36qDOblL8rVqjuSgpAjtajm4HfNK9bmTLinUoNnPkoizHMKPi+Q
         DRJbIT/T6JW2YgjZlVR5sMpkB3pldk0uJ4WEkwzsTcXL4bbiswSDo4pcT7PIwbUU0xNm
         7wh0uHoa9uWCnFriuyTEHLZJnpfnRkl7kHYWZInxbOFUQeobjiQXABA/PZGUy//wIVNY
         SOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwZ2q+ht+X4UdZ54dnQJfViFXAccYyFB0RjG6X/nT4g=;
        b=2kCAF6Jo7IyW1Qv4jVWN1HmBHi0+PD3QDZ5rkSEDHvTfAMUlVxKinGQGqLyG4b8lTF
         0kObboqyGlAmr+DoCQL2WnbJeECemdPLgdBb/5s4p6HsQQKd2NUcBDPMZM1qqO88UVBM
         riLzKpYF+DYR30JDtqzbf+bs8aUJYQ808KCEGlxsKWmYI1fJKjdoxeKkJoikCDZPxC7M
         uwM5Wo39N0k5mZvI6VCuR6ku0JOguLfz8DgXm7c10dyqU1rWxuUPhfmMYKCh14B8qu09
         PRGKrWGSNE4jme+GRCfNyuPWmtY/09A1JBRHcZ3fIDOaP+9GZdcdNrf3oKONzg7uBvry
         dB3Q==
X-Gm-Message-State: AOAM532zrfS08Q87jx5xsjGfkxbSlgIoafNcxtgZLEKqZXxHxKfCY94y
        3CBvcpEDwbXhwZsE0fTx20V9EIhhLKmFJLU3P/NXLw==
X-Google-Smtp-Source: ABdhPJxZa3GYxRoilR/JLH9hzVT1QQ/EaqVeqSnsU3JR99zq35sqaqG5sQLyySDdxueSZkcU22FFVYWhsFTUKcZws7A=
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr4211892otb.157.1639044084792;
 Thu, 09 Dec 2021 02:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20211201152604.3984495-1-elver@google.com>
In-Reply-To: <20211201152604.3984495-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Dec 2021 11:00:00 +0100
Message-ID: <CANpmjNPaKMsgfDo5PE_dX794otFXbJvGubxG44C8-QL66UVaUw@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix generic Kconfig dependencies if ARCH_WANTS_NO_INSTR
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 at 16:26, Marco Elver <elver@google.com> wrote:
[...]
> At the time of 0f1441b44e823, we didn't yet have ARCH_WANTS_NO_INSTR,
> but now we can move the Kconfig dependency checks to the generic KCOV
> option. KCOV will be available if:
>
>         - architecture does not care about noinstr, OR
>         - we have objtool support (like on x86), OR
>         - GCC is 12.0 or newer, OR
>         - Clang is 13.0 or newer.
>
> Signed-off-by: Marco Elver <elver@google.com>

I think this is good to pick up. Even though it has an x86 change in
it, I think kcov changes go through -mm. Andrew, x86 maintainers, any
preference?

With the conclusion from [1], I think we decided it's better to take
this now, given we discovered KCOV already appears broken on arm64
(likely due to noinstr) and e.g. syzbot disables it on arm64.

[1] https://lkml.kernel.org/r/Yae+6clmwHox7CHN@FVFF77S0Q05N

Thanks,
-- Marco
