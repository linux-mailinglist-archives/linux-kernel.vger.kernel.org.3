Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462A34A7A30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347489AbiBBVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiBBVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:22:24 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86CC06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:22:23 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z7so972687ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wuDa52cDIJ8DIOvRv+VwSSr1tZwFekRYSng4dxWGIo=;
        b=RX8WbXQJNzT8YobsQ7pN+17muhyEYapyF2D2WcDwMvaDo1P8HG1Ud8/UakbAkuxVog
         nml3I2ULWZThFrpimwx88tbOp5t7nyYt+43mPTpfKM59rS4+yfOBZMPIeQXQSz2sGGNP
         MqvheDLz/Ol9fUoyLOg9hoJ8QP2B34C6ef97chssdqjHD3VHFA2leoPnsZQA9e2t8GcT
         STAnpYPr+tTgrCIXUncGPiECiNr/RQbOVqqNYdYDvAz+yR+DK99rr01jFDYuARgaVj6d
         LKWEWSGgb2iO8CL0iXqwJRg4xZCy6fWvAY8qZsLIBjKsVELmOFUiobtxr7mCisqVXJ0m
         +JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wuDa52cDIJ8DIOvRv+VwSSr1tZwFekRYSng4dxWGIo=;
        b=ThnscMfb5a893qqGtomBz3+ie12Ux+R1q6tMUTnnXy2YRuGc1sjrwo+V6jKoVOVZyW
         mTnzY4y6MsachbP1pXPzk5Srop23yvvhGNnmOOEy1zT3kLjvnzdeUq6pFEyH4+RiNmax
         +fvebkVWDiE86hr760eGkO6XYdPz3PWN0fkdt0F9IaOfDPSRNHJmbNYriLw+6cpIejGS
         WUs/ecGgxs2eqcB8U8iLRLrkDFuuWEvERzRuZ0+KnZtAVMktS1g5mRIXk08Kt8JISI7v
         8dcK36UZpNai22O8XB+LTQS1V9wSDto29C//ipXPY+BMQvtDzebbCnTyCePHxuhm5iAk
         xA/w==
X-Gm-Message-State: AOAM533RILkwqo5S2zArxdLZRTZ8EjRnH0kIQoS/ylwbfhGSOTT+oIw2
        MDT5PwLxKpbooHUuZlQ5Bpnnvs9AadbW0FaTCjUqZw==
X-Google-Smtp-Source: ABdhPJyG5Ks6tJj9Y9UQ16rXkmZ1tEB3sUgYszm3BP1C9UdQ8c+nNKEyd56xb8gMk43byZ/OQvWw4beJKF6O0l/0Xz0=
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr20984195ljc.526.1643836941590;
 Wed, 02 Feb 2022 13:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org> <20220202003033.704951-5-keescook@chromium.org>
In-Reply-To: <20220202003033.704951-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Feb 2022 13:22:09 -0800
Message-ID: <CAKwvOdm1O+cKn5C86C2cB7hUCupv+Mf0w1d1pcaUNniYvc5jEw@mail.gmail.com>
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -179,7 +179,7 @@ config FORTIFY_SOURCE
>         depends on ARCH_HAS_FORTIFY_SOURCE
>         # https://bugs.llvm.org/show_bug.cgi?id=50322
>         # https://bugs.llvm.org/show_bug.cgi?id=41459
> -       depends on !CC_IS_CLANG
> +       depends on !CC_IS_CLANG || CLANG_VERSION >= 130000

Are these comments still relevant, and is the clang version still correct?

In https://lore.kernel.org/llvm/CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com/
Miguel notes that diagnose_as only exists in clang-14+.  If this
series relies on diagnose_as, then should this version check be for
clang-14+ rather than clang-13+?

https://bugs.llvm.org/show_bug.cgi?id=50322 is still open, but doesn't
signify why there's a version check. It makes sense if there's no
version check, but I'm not sure it's still relevant to this Kconfig
option after your series.

https://bugs.llvm.org/show_bug.cgi?id=41459 was fixed in clang-13, but
it was also backported to the clang 12.0.1 release.  Is it still
relevant if we're gated on diagnose_as from clang-14?

Perhaps a single comment, about the diagnose_as attribute or a link to
https://reviews.llvm.org/rGbc5f2d12cadce765620efc56a1ca815221db47af or
whatever, and updating the version check to be against clang-14 would
be more precise?
-- 
Thanks,
~Nick Desaulniers
