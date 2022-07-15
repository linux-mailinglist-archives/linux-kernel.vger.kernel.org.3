Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC15765EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiGORWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiGORWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:22:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648179682
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:22:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r6so7150608edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cayr6gn0WZvykjHh/EvjvKv6RB+Cd+x9DmY92YQuFR8=;
        b=hy/4MlnGq4qDMH7OxmXHU8OlzyjNTTjPRuu4JX1D8JV3TD4oUR8E+KzdOmjcNQ8MDC
         5hbC6PT48Mmh0muZM4U7qQab7GAZ95pFUoZR6SG5BsO549qrmg7OiYOipH4KvvrhITsT
         PPV30Wi/6DUGo8FSufIw2ToJFUd3xkwsnlYXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cayr6gn0WZvykjHh/EvjvKv6RB+Cd+x9DmY92YQuFR8=;
        b=Ecg3OP6IeY1Ydzy/wcNZpe8DDGlPbMCr49kkOzEPX0Kay+U7Bzuvq/M+y/CR0JXVkR
         Uog9r8Fm1l6ALVBK/LSTJ8yxCDCkqYR4oJZPQD8TK1nO4aLTKL4khElzA//J1JGXZ8F5
         wTdvvSDQsNuzRL/7+frDbfVdD3EJ4c1IJf+bYpXkpGu3fou6qXkcqUpOMA/nP3iOvN+6
         YReVSForuAmwI0aQ3YWoEufqCL5XylKDgrKFxvbhJtULbSvgTNJ8dlD52F0bqRto9IF9
         CP2fDr+1X/uGJzGbaC0z79rM2mrm66gptGeRG3uc1YApf3D1r3Tc+zII7rO4P2eVY+b9
         uBPw==
X-Gm-Message-State: AJIora+Y1Ip4fWiVqwd5/Kx2dXTWAdOhVtqWsjzbGiRJ1Nhzs+uZcIuV
        Z+F/XSzW1mrUSzmWnw82FizIEn5wMPOrz/uyhWg=
X-Google-Smtp-Source: AGRyM1vti5s/CaTHUXAgj+WYbXbpV5zYLhEF7tB0cs+7PxTVrZeLFspX8BdW/BJaNZ+eNcqSgNAbjQ==
X-Received: by 2002:a05:6402:5189:b0:43a:c55c:cf00 with SMTP id q9-20020a056402518900b0043ac55ccf00mr20358269edd.390.1657905770312;
        Fri, 15 Jul 2022 10:22:50 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090630c300b00726abf9cd8esm283776ejb.125.2022.07.15.10.22.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 10:22:49 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1247936wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:22:49 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr15095435wmq.8.1657905768908; Fri, 15 Jul
 2022 10:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3jSNJfJxkbqJ4Bfa0bkhNsF0CY+bGJMGKJOaFPm_Me5A@mail.gmail.com>
In-Reply-To: <CAK8P3a3jSNJfJxkbqJ4Bfa0bkhNsF0CY+bGJMGKJOaFPm_Me5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Jul 2022 10:22:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjOm8RMb7kvpcVT6=MEc+ACUL-QkvhF=8osQcs=e-Dbg@mail.gmail.com>
Message-ID: <CAHk-=wgjOm8RMb7kvpcVT6=MEc+ACUL-QkvhF=8osQcs=e-Dbg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for 5.19, part 3
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 5:29 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> ARM: SoC fixes for 5.19, part 3

Hmm. I'm not sure what you used as a base for your pull request, but I
already had most of this and your shortlog and diffstat didn't match
at all.

But the "for you to fetch changes up to d332a1f6b4c4.." part did
match, so I assume I got what you meant for me to get. Maybe you just
hadn't updated your upstream tree?

                  Linus
