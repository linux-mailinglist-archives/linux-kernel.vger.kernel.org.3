Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538004AD0B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiBHFcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiBHEwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:19 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8027FC0401DC;
        Mon,  7 Feb 2022 20:52:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u12so5761605plq.10;
        Mon, 07 Feb 2022 20:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ew1U/3yWFK9qaVvbicYusCMj7KN9YvrsYhCttMifx3I=;
        b=OHoZCzybVgaq8gokte/f1mDPDifUy7060utrv1uH+qDMnXFnwKC1koURQfs9jdG3c4
         GHKtYpYqlG+/vZMcNf7lNGCt3h2BbmL+SaVuOgXHzset6dq3xaFN1fj/M0bOweJzBkFH
         WgGfPGn+xDL+lZjarVrwGIxlFvu0AKy2YLl5IWBhEY/uFZ12iYIlfC5Ms2NdSABs+S7a
         18naLhhk1eMDBq5nuiSNzfu1zEye8xPk6o2AfD0TtLbVpK+75+3k2allbgffi4YL8pc/
         NSOB1IBSoLQ8/hRAtGtmnK3r1WAND0E+RiR6Pq3VQr2TFjaNhDnEna+kgZTKUHC+lgqd
         vA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ew1U/3yWFK9qaVvbicYusCMj7KN9YvrsYhCttMifx3I=;
        b=XjV4MX7e10M3vWr2ySQq/+SdXBoJIZCmySj5M4w9OaqIf363n+UUnX2+hmOSNfpa+R
         g4CFNn+ZUnK57nOtNzPU3yPd0PARQOIQC9zxKwEYowxyKSnuM6aK2m8rHTOO3CzCnEG0
         eKDfbsfKD1rjxoxz8bQCFHTKRDelKEybcApYWhyxP/v8hyF3PMc1IRovJ+rQV8P3/xC9
         prA8Jr3YfP9U2Ux/mxYDEiwis84jeUJYJ4IFC/A9I5Zjr7yOueSBpZ2urXTdoEnajqLc
         5loJfsyUoorGb0FEfq7sINzdjOa2x+0f0BVQBXjM40I3kwZyKHhlIiIy0DNhosu64AYA
         POmw==
X-Gm-Message-State: AOAM5322A0rkEfVIAFHrCJ6QYKoMUTV028JWUOr/FNa2IVt99sh6LlW6
        snUM3ru/SyuyrpoUuN6ElosGBV6NfSe/yaNdhWA=
X-Google-Smtp-Source: ABdhPJywMwMzR7Y0wWfngjVeA0aLVyWnqlHeN7UaxowTXS9CeLFlWiJQfJFBL8exuhHvI6y66J9ik/OtLlEiSRFNSnU=
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr2521452pjx.104.1644295937718;
 Mon, 07 Feb 2022 20:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20220203060641.119522-1-vimal.agrawal@sophos.com>
 <20220204083933.136096-1-vimal.agrawal@sophos.com> <Yf2fB4mzdLiWtoki@bombadil.infradead.org>
 <CALkUMdRv0tMuLpi3Syw7MndBTa9b0xRLGdb6QvM8Q69zXnmUkw@mail.gmail.com> <YgGYL1MKEX9t/ciO@bombadil.infradead.org>
In-Reply-To: <YgGYL1MKEX9t/ciO@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Tue, 8 Feb 2022 10:22:06 +0530
Message-ID: <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
Subject: Re: [PATCH v5] modules: add heuristic when stripping unneeded symbols
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        nishit.shah@sophos.com, Vimal Agrawal <vimal.agrawal@sophos.com>,
        Dirk VanDerMerwe <Dirk.VanDerMerwe@sophos.com>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Actually I had it  under (!best) in my first patch. I had to change it
> > because it was resolving the address to symbols like __this_module for
> > init address at times which is not correct for text address.
>
> Can you say that again?

I hit this a few times later after the first patch. Basically there
are all symbols in symbol table and best could be none zero ( means it
matched some symbol) but it may not be match to .text symbol for text
address ( esp. when --strip-unneeded is used as there are very few
symbols left after stripping)

> OK so you're saying sometimes "best" is not true when we use
> INSTALL_MOD_STRIP="--strip-unneeded"? This is news.
>
yes, best can be non zero and may not resolve to .text address when
--strip-unneeded is used. without stripping, it will definitely
resolve to some .text address closely matching in case of no stripping
but it can go wrong with stripping. I have seen it a few times post
the first patch during testing.

>
> In particulr you seem to be suggesting that if --strip-unneeded was
> used "best" could be incorrect for !is_module_text_address().
>
best could be incorrect even for text address when --strip-unneeded is used.
e.g. in my case, it is resolving .init.text address to __this_module

> In any case, you completely changed things in your patch and did not
> mention *any* of this in your follow up patch, leaving me to question
> the validity of all this work.
>
The Only change I did from the first patch was to move this hunk out of (!best).
Yes, I missed commenting it in the code.

> I tried to reproduce and couldn't and sent you a configuration to test.
>
Give me sometime and I will check with the config.
how does your nm test_module.ko look like after stripping?
it shows following for me:

vimal@ubuntu2:~/linux-next/linux/lib$ nm test_module.ko
0000000000000000 r .LC0
0000000000000000 D __this_module
                 U _printk
0000000000000000 T cleanup_module
0000000000000007 T init_module

> If your heuristic is *better* than the existing heuristic *today*, that
> needs to *also* be clearly spelled out. Your patch does none of this and
> the commit log clearly does not reflect it.
>
I wanted to avoid major change and fix only this particular back trace issue
else I would prefer a check in existing heuristic so that .text address always
resolves to .text symbol and .init to .init symbol and .data to .data symbol
always which is not the case currently that I found lately.

>   Luis
