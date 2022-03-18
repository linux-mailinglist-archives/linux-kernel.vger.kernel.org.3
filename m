Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E04DE114
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiCRSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiCRSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:33:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E76120DB1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:32:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bn33so12369603ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBLfX2LSEiNhJ8oDOcJh1B00fiK59ApOZekhfSkPFtY=;
        b=VgZXaPqAaC3YW4N9oST8PmjWXw0TSZNWDVRh8fM9EjToU+Zs/ed98dGuNHb/i54YHp
         AYZS5QAWDzP3m1ZAGhm9kZ/lei9v44xXn7DxGd1XRyak5cRbMtaIBXH9w8ldrNz+3B83
         rir2bjRH/je3U8IBwnnIN+TvsEsyS5i2lN6a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBLfX2LSEiNhJ8oDOcJh1B00fiK59ApOZekhfSkPFtY=;
        b=xJsk3MrXsd5zTWzsfCyK0NCfnL5pH5j/a3XrmhuIsL2L4yxOnKfSXQDBqUb1umzwbT
         jFOiaOfueF3JTf2UsVOxv14QdPmX6zvaO1kWmIVAiJBL7kW7PDbwdcUF2HD1/9srKWTr
         dAwfPSylgblD4Qq9MWD5pyPoCIfvukCiXwOypcW87SJdztXkNWyRj93uomC1K2wUre0c
         ChIAMaQ1MkwkQ/5XyG2iklX+S6fykNoVOvoaqbTPj+xGn5eWX47wOpaJfZMJd5uINKuR
         aHIDV35d9YtLoK+DJPGE8xnVp6dR/Oac6D7izjSVX5H6aN4BWuGKkP4ksZLRcpwHj1JD
         WNIA==
X-Gm-Message-State: AOAM531TiJrzRU0zY/UmxuFgRw8CydnZeWMVxNiQeh2/qdOfzCEx9lqL
        gAnc1qiF+3dBonlWdKVa0DjdzVG5PjG6065a1Ww=
X-Google-Smtp-Source: ABdhPJxwmtHlM7WNbzTyH0bJ+ydu0xz+fPYn/84ixJ92+wOSCxSNV8DNeoIozK+e70WESFRDOhogrA==
X-Received: by 2002:a2e:9e81:0:b0:248:7c35:385a with SMTP id f1-20020a2e9e81000000b002487c35385amr7025647ljk.527.1647628333772;
        Fri, 18 Mar 2022 11:32:13 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id bt23-20020a056512261700b00443e7fa1c26sm957420lfb.261.2022.03.18.11.32.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 11:32:11 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id o6so12382601ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:32:11 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr6818296lji.291.1647628330932; Fri, 18
 Mar 2022 11:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
 <YjSROmYwwGhpsXMl@smile.fi.intel.com> <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
In-Reply-To: <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 11:31:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKiemDQXKCGztokhw_A-8SnE+7Q9Queb-rXUTbHPNedA@mail.gmail.com>
Message-ID: <CAHk-=wjKiemDQXKCGztokhw_A-8SnE+7Q9Queb-rXUTbHPNedA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bill Wendling <morbo@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Joe Perches <joe@perches.com>
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

On Fri, Mar 18, 2022 at 11:01 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Maybe we should reconsider our recommendations for signed types?

For 'hhx' is probably does make sense in some cases.

That said, for kernel work, if you work on byte values, I would
seriously suggest not using 'char' at all, which has badly defined
sign.

And 'signed char' makes no sense either.

So while 'hhx' makes sense in the general case, for kernel work I'd
much rather see "don't use stupid types".

So why not just use 'unsigned char' (or 'u8' if you think typing is boring).

                 Linus
