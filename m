Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70D953DCEE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351211AbiFEQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351208AbiFEQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:16:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1124DF46
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:16:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gl15so10877955ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOd91IrpVsMvaCem3N2Wlo4e4L7ezusJLGgTEZxYBBA=;
        b=gM5L49Q5RNeeLmx4jz/0qVJoD+bjMCPlzbAXCJbNiWO9sHNBhK0oC+q5dS9DI0hDF9
         aB88gWRVtT/asQV44soIAqkaWx/vgut/QdrGnnJ3lmg5okT37PQPXX7ZVKAR7WmBVVPZ
         kc7/YY3mLvNZdYMjYfi9IB27m25VBDCVJkLyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOd91IrpVsMvaCem3N2Wlo4e4L7ezusJLGgTEZxYBBA=;
        b=XZW2wOTolWYKkFJ6dosPBTPOeDK0X+AT/Ayl2oaVLmf1kv8KgyazN+zYar89TOGX/O
         +wmeqG0e50iwSsgIpJVLQmYDxia62Hx0DapM2p1k3uLZ862VYAe9QI/P43TT11wzF2Z7
         ZbVQQHfKRVMUMtxJ764sf7bP58mTYNIJSYSjwQFRHlw9/CF71Pi/ixqfQfdpoqKg5+4m
         posoKPWW/1z+NAGsWBjTvm7SgygkwjLjobwL/orIcE3+iNTfLw/r7wEPZ5BZAkio+0cd
         RLmzbiC4pPdJUg7AUyOl7k5lOOOOittaM2r4qya+nJc3SWWNtO0SdzEpPwERH8bUXMjm
         73Ug==
X-Gm-Message-State: AOAM530tcn8AFmUwrjGUOxIDrrvs/iJvWZDLJs98z3RkGzKR2fQkEXdv
        ePICDUgt7xB9MJRpnFwaiqSuNgI6M5xuj5Fe
X-Google-Smtp-Source: ABdhPJzrMtcCidyYds2KmxGpFX5JAowZE34TwkzowUeCUZ3QqoBftZ0o2XzRY4BjY50UMjuootqxug==
X-Received: by 2002:a17:907:7f03:b0:6ff:4721:3c75 with SMTP id qf3-20020a1709077f0300b006ff47213c75mr17694576ejc.508.1654445799706;
        Sun, 05 Jun 2022 09:16:39 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709064ad500b006f3ef214e14sm5196889ejt.122.2022.06.05.09.16.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 09:16:38 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so6728968wmz.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:16:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr13980053wmp.38.1654445797876; Sun, 05
 Jun 2022 09:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220603113908.78777-1-thierry.reding@gmail.com>
 <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com> <CACRpkda0KiyjV27WEP_MYpvWXyG787L9PJZaP_hnXh_DFpSj5Q@mail.gmail.com>
In-Reply-To: <CACRpkda0KiyjV27WEP_MYpvWXyG787L9PJZaP_hnXh_DFpSj5Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 09:16:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirNAe3ApyCWMAyz-QFaNX_oNCzc8SSX7a52pV=+OQ6Qg@mail.gmail.com>
Message-ID: <CAHk-=wirNAe3ApyCWMAyz-QFaNX_oNCzc8SSX7a52pV=+OQ6Qg@mail.gmail.com>
Subject: Re: [GIT PULL] hte: New subsystem for v5.19-rc1
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com
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

On Sat, Jun 4, 2022 at 1:11 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Another provider did come up, and were requested (by me) to work with
> Dipen on the subsystem in august last year, that was the Intel PMC in the
> Elkhart and Tiger Lake platforms and forward

Ok, I've pulled this now, even if I don't love the "hte" name. I
despise specialized TLA's that aren't some obvious "if you're a kernel
developer, you know what this means".

                       Linus
