Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831A52559C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358032AbiELTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357955AbiELTRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:17:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEC94CD50
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:17:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so12086660eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWa+zByd3DqEl7xqKDtnBELPWtqlzD2Sn/Omv7A9MU8=;
        b=LKho6slMxSldPIB6peqdHZRlB2Vp7kHnCG00qRWBMoZ387VfWdXFEZQu2j7Tp1wue6
         ItE9fq9/mgbEpMOM3U+VLSxLHmQUMaf5ESAk8jtqKGLTKRZvPo4AiqQzi0HDRx77zMd0
         IDv08q3kiygvsOMJDz9qYb6FNfFeqhVOLRnEG8T0xJ/NJSDg3DPrWNZzC2bFQfpFT8xc
         Pm57bWEL7XmFmOOt4TIX//hfZUPcHyvpvryVsrCEUrW/BPaO6Eq4w5ks12vGG6Wz9PoN
         7GQQ0InDnEydaftjtdyoO50iXvzCAVnqsnnIkK1StuAjcobaPQp5jKjJiTfeWQxXDvOa
         Ov8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWa+zByd3DqEl7xqKDtnBELPWtqlzD2Sn/Omv7A9MU8=;
        b=E5sFMBV2S2525XT0Dj92Uzr4QBSHAWZC+CEyEkQN7VsW9a+fbbidufMAhJ4f85j5Cd
         opnRq7cDe/FXRG3v1zDWa4ClH0s+rhoWhQm0zA1+uxmaOtGSDN+sf2KYT0XBAuZ31CO9
         WzTcFgCRRn6ZyJAlK35xDsz+UWkf4hXcDjddM7Ir2QzwjSu6zrhxVpoc0VA/IZaW7taF
         dZiiYfgpxPk6Fv+pFLP0jMMzAU9H+HHlYLMPyJFjEX0W4/XlPP0o9A9RAj6oettxhIQg
         2V4uZeewbx81hqysOBkEpuYS1lQlzvQ0UU2NKBTi5jHjB/AKgYRrCqK/l13QMLBDtOPu
         GkMg==
X-Gm-Message-State: AOAM530W4cbNMMFUkAMSRr8G3S5Hn/lV7P7ijtwPaTqFDg9BR524SOEA
        IsAotxyxpC23I9Q1HOwwzW0wftkai75pJD/sr0gErjRX2ie5s7kh
X-Google-Smtp-Source: ABdhPJxWdpaJocDevY+5k5pKJwbe+ouB2POclvYNDrEwrHQkx8SUIhM7YoqA2nFEjU7s5X5agQWRf1q2JUyJzPNiZUY=
X-Received: by 2002:a17:907:8a14:b0:6f4:4365:dc07 with SMTP id
 sc20-20020a1709078a1400b006f44365dc07mr1157244ejc.693.1652383049625; Thu, 12
 May 2022 12:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220504070941.2798233-1-elver@google.com>
In-Reply-To: <20220504070941.2798233-1-elver@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 15:17:17 -0400
Message-ID: <CAFd5g44MRx=bmu5kuFBKNW_KEYHLjsoVu93_hnrEkG8d3KDojg@mail.gmail.com>
Subject: Re: [PATCH -kselftest/kunit] kcsan: test: use new suite_{init,exit} support
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
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

On Wed, May 4, 2022 at 3:09 AM Marco Elver <elver@google.com> wrote:
>
> Use the newly added suite_{init,exit} support for suite-wide init and
> cleanup. This avoids the unsupported method by which the test used to do
> suite-wide init and cleanup (avoiding issues such as missing TAP
> headers, and possible future conflicts).
>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
