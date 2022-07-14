Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2132A5756D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbiGNVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiGNVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:25:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB726D9EC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:25:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l23so5690737ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3t3I9dkeOpZv3dAGJjzgDy35dMg8T+EkyLmF6AEUuHY=;
        b=dfM/p2kaK73Hlj3gYy/B6pQeiTl6yNjenC/l7tWyHXO/NKnlYmKfPFxUnWCALi2Nza
         qBh/ZB/SDONX8G+QlzbRNpr4opolwhsauiPD4PEgBz6DTrBixKZNwJj2dqFTFIprdvAa
         fS3maq4vZY7wJ4sp0qBva9wRpI4kHMcIOecMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3t3I9dkeOpZv3dAGJjzgDy35dMg8T+EkyLmF6AEUuHY=;
        b=DMcHMFaayaBaDVw1O4Ri2UmMnTgRTOkMFMDxPckxC4BxoJvFmiUv+PyTZ9NnZeyrz+
         skXrkCUdWvR/pzi7CY3hzLpv8kl2iJhEbGeBl9qVPqrHV02ZsHbKKpmUyjRhUUo376bi
         sXGhGCOLMukpevtA3fcraBsxe/ojbNTT+kK2gFwC9CYpfUi/bFsBOxDJJ+l7gnNbVHA1
         FPh3MDRVmD1F3t8lGMOFaN1dPKqenRzGSpaPOLa4uZmP0eODFRRPw4iOBLqmyAT0tFue
         fUu8BkVB0sd48FnN/VTCjYxNQsd6yrDSBSGeHvZQym+IaIiI2P2mMwe5BU8/2tmQ41Yt
         h/xQ==
X-Gm-Message-State: AJIora8XOpYQRr7nKvNqYCoHLPdp4aDpWy6dq1Y2pmS2moKtUpm/gvvZ
        ZZi9JU/iZzhjHTRLcbE8Kh1zIdDIDqZkbLdHvNg=
X-Google-Smtp-Source: AGRyM1uHBfZl+iOUm171ntNLSBgD+QiJ4EkHH3bXMAwFC7X3PJRXwwlYaso0DIjuQMcJQJKG7+7gQw==
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id sd5-20020a1709076e0500b0072aa1410962mr10503011ejc.545.1657833900284;
        Thu, 14 Jul 2022 14:25:00 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id e25-20020a056402089900b0043a46f5fb82sm1694718edy.73.2022.07.14.14.24.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 14:24:59 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id o8so1789499wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:24:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:3a2:e9bd:fcd9 with SMTP id
 g9-20020a05600c4ec900b003a2e9bdfcd9mr17595143wmq.154.1657833899118; Thu, 14
 Jul 2022 14:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220714205646.4023495-1-ndesaulniers@google.com>
In-Reply-To: <20220714205646.4023495-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 14:24:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnndsMXO=32vFn9-Osw4r8-NvROV1rtsbxjw9Uvj1WPA@mail.gmail.com>
Message-ID: <CAHk-=whnndsMXO=32vFn9-Osw4r8-NvROV1rtsbxjw9Uvj1WPA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 1:56 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Linus,
> I still think we should add explicit checks to gaurd against divide by
> zero.

I mean, that's what UBSAN_DIV_ZERO is supposed to do.

The fact that clang then messes it up, and turns "I found undefined
behavior" into "I just crashed the machine" is why it needs to be
disabled.

Please conmvince clang people to fix the sanitizer.

  san=C2=B7i=C2=B7tize
  /=CB=88san=C9=99=CB=8Ct=C4=ABz/
  verb
  make clean and hygienic; disinfect.

note how "sanitize" is meant to clean things of undefined behavior.

The way you do that is by warning, and giving it defined behavior. It
really is that simple.

Clang seems to warn and then just turn it into ANOTHER - and much
worse - undefined behavior.

In other words, clang doesn't "sanitize" anything at all. It just
moves the mess around and makes it worse.

                    Linus
