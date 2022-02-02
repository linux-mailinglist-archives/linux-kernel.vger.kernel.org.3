Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6E4A6F72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiBBLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiBBLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:44 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6DC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:44 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id w7so24931959ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSfvq8RBJI3skKqCpQ6Ck1/CfN/oj4KZbsyg9UC3y1Q=;
        b=IqowrhAdwp+8jZ/Ozz+5UOA10md6cUs52ruVveH1Sc10xql9IAuHjeqIKodns4LBLD
         /mR36mUCo0c9eHUalbVQbwdv1t4SMXqA77kMp3XCl6YLtB+qxW2vHNcM0Q8ks61eskHD
         C7t24sx/WvGqIkDFxnXBUxf18x0eKDvcFuhO2oSvEaZLmezo0NN7Bc5nxfUh5vljcjvh
         XT2JjaVHJFBGNPvy3/QUahQglb12ZmlPgw+UqwnJ0dAQMSkD1bTzHLDqr0W40V02G2Yl
         M6ZRSdJ0xNZjchJsTTxCe3JNia7BzE6IeKlLHmG6xRjohO6kWw9fh+/Qy/xqssa7G2QN
         1VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSfvq8RBJI3skKqCpQ6Ck1/CfN/oj4KZbsyg9UC3y1Q=;
        b=jOqt9LWOjl863OUFoXCQBEEjPGFvOaCIun3GsSIYU5qyOSWdV8AC1g8aZ62NDXlx5r
         1BfASIyUFNO3dZcaZjzLjdM0RUhC+zNJARSLaGRjcbHd281g9BK3QvVg9Lq7/udgy4vl
         sObYnJClER6u9CZsUU5gGCSj2ISG9ccEKdVpVjX7j44sQyE0ofycF5hcKOIBGo959wvp
         teQvBe5RYFIBJ8dGyQLhIjnFOicX/BF51h9jT4w0iIkvNZkLp4ajGPUzGcTJFoWqtTo6
         W2VKxo6Kty8Qia2chCEGqy1eMGFLC7yBip7KQO/rGrdLEC5dDiDBbv+21Ro7QVy4Tu4G
         TCnQ==
X-Gm-Message-State: AOAM531MAaNC23LQ/BahJ6JO7PeMjkZYMePSYkQ8cY/8W2wOUgyL8qQo
        fiL41s4Aiaexc7ALtSFbTSGzizf4yUcSv87PmPc=
X-Google-Smtp-Source: ABdhPJz9fQw9eBSXaNvzBKPtdRYkvl8oct0t5msyOZRWGIIxam54hhp5IcH0iHCAno35FFWzDr+2jPXGnNnCoz61gEE=
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr15624212jab.186.1643799823768;
 Wed, 02 Feb 2022 03:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Feb 2022 12:03:32 +0100
Message-ID: <CANiq72nCq9ACEpni=ieOTzmwv25Ca1RkS8yScwa2B=VddKB5aw@mail.gmail.com>
Subject: Re: [PATCH] include: drop pointless __compiler_offsetof indirection
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 11:21 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> (1) compiler_types.h is unconditionally included via an -include
> flag (see scripts/Makefile.lib), and it defines __compiler_offsetof
> unconditionally. So testing for definedness of __compiler_offsetof is
> mostly pointless.

Sounds good to me.

By the way, there are a bunch of `#include <linux/compiler_types.h>`
around that could be removed.

> (2) Every relevant compiler provides __builtin_offsetof (even sparse

Indeed, even GCC 4.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
