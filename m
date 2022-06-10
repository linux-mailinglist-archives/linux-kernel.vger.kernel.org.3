Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF9546CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350240AbiFJS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350377AbiFJS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:56:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BE52C27A8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:56:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h19so164378edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tu0fTzyqzrDJCvJGCoSzfL+uIt2SiB12w9Df3WqdSV0=;
        b=ILPRMvLcgdxn/DJNTX08x1h2h3sgKMyHcZtrB0IEbwm4hz9uSYatcWVJtnDpcfS8IX
         3UNkjqU2QEwLI2xDs2BoFuu81wU+NJ5abcvTGRNZQxPzK87bsS1K1mXl7M2rpkSsPfAi
         kLRW+sbic7AqBlS8DWLRz/s978b5Hu1HTvHwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tu0fTzyqzrDJCvJGCoSzfL+uIt2SiB12w9Df3WqdSV0=;
        b=Mf10xGqi7bO9w9VHZGRQNe/WDTojCcr5XMMoOeulydOTVzqCLNPbBOZn9kDp1Wd4lF
         W+qptOBMtN2j10Pm+0zm/oP8/oEYW0OPSWuNjlsdj4ExiIiNonNxu0JbGTsstCbgp2Ig
         a2V8JRVvWpNbc5src0G9X6P3fECOqLO12j2UwPHwO9zMP7EvJm6JwDq0GZgjt3n8ww2E
         swgFWOoh/TjKo/JqRauAbp0UoDz1XHVExK1BN0cU/6IrxmkGG/9/WX8rv889A1JiHp4u
         5cqHBCatRXr6Iaub8t6tmxKZsWGKt6qvkeXSTmf1tz/IYo7bBvflCHrdY4QfP6b5OrS9
         SYCg==
X-Gm-Message-State: AOAM5300Ku9gaphK9THx6xBNOiVMEO0DTdGS2G9021+vi8ImQUJfdB1h
        vaXj92J16EpXP+ie6++HTIo3ARczzRgQ6a5cgLA=
X-Google-Smtp-Source: ABdhPJxZC8pRUMGTVRQcImX48QxyTNGB1f2Z+l30Q8JjkBo0vUCiuQ7oKntq2XRavxkocbQv/l1HwA==
X-Received: by 2002:aa7:da06:0:b0:42d:ca38:84ad with SMTP id r6-20020aa7da06000000b0042dca3884admr53314066eds.125.1654887367058;
        Fri, 10 Jun 2022 11:56:07 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090633d800b006febc1e9fc8sm12521647eja.47.2022.06.10.11.56.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 11:56:06 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so91686wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:56:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr1123490wmq.8.1654887366093; Fri, 10 Jun
 2022 11:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
 <CAJZ5v0i-BD=00qDK_mZ1=BF3DJeGA5CPLV+tUpEd2iEz0YHmsw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i-BD=00qDK_mZ1=BF3DJeGA5CPLV+tUpEd2iEz0YHmsw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 11:55:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whN=JSrmOGURKTXZLjn=dwmhXw1_BfWazNA6-idK1mVqg@mail.gmail.com>
Message-ID: <CAHk-=whN=JSrmOGURKTXZLjn=dwmhXw1_BfWazNA6-idK1mVqg@mail.gmail.com>
Subject: Re: [GIT PULL] Power management fixes for v5.19-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Fri, Jun 10, 2022 at 8:47 PM Rafa=C5=82 Wysocki <rjwysocki@gmail.com> =
wrote:
>
> This was sent from my personal e-mail address again, hopefully that's
> not a problem.

Not a problem, the signature on the tag clarifies this.

It meant that I initially copied your name as "Rafa=C5=82", but then I had
this dim memory that you at some point said you actually preferred the
kernel using the Westernized "Rafael" that you use in your kernel.org
emails (and in your sign-offs), so I ended up editing that up.

But just so you know - I randomly copy the names either from the email
or from the signature block depending on the phase of the moon, and if
you use your personal email you might end up being "Rafa=C5=82 Wysocki" as
a result..

                Linus
