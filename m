Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3814EA2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiC1WSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiC1WR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:17:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150295481
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:13:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so22312966wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c2rDBwbFTkCmCH7rcNPRABM5zIBAnbo13PAPu8ohgmY=;
        b=DwcVfIsIcOJ0GPiMwt6DG2p9BfDbKkf2M226tZ9hZhd2YuGqT/e5r1qpmeRjV7Klsn
         OQ2O9FGbsbrgWSfP7XnjPBbTHJVIhNT8xAsLHsK39wlF85wIalCk6RRHolEsoHmLPQov
         VHDrPq0sOWmKJ+QtijvvzMghFDu+wNtyKfwYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c2rDBwbFTkCmCH7rcNPRABM5zIBAnbo13PAPu8ohgmY=;
        b=DpaloLRS5dOQe5y6F8SkYu+pFJsKygL0JN7om8cAkzsqig+nh2ydrgyGexo6PaZb4S
         Bn6Fv68MHPwRY2Ze6pgzCBW59CwkLNJJnM1IzGY280/X4p17VKlqoyx6MYH84zDk0Mi7
         KrG/UYcfrQYN5uEfbJfoB+SzeDrTeXV1BN98ufheWq1RdsoBmdyBJBljFCF/HlyUpGY2
         cn7sn4JgGOrXKCapETwFxwNNkyG06bYDpCaRaKJ8Gu8dVfO6TpMc7Ryqy0mxAPV/CvB2
         Ol00sAh7JsNJdOSMBDTLjkq+Px37nFLgg6slZkt1uKp4K1styxP4OwWjNoOy/eS8gZ3+
         lF8A==
X-Gm-Message-State: AOAM531Y7OSkSaxrzF/QYpWRXOx85ntOCEmGf0TkglthaATsnaCnEjHi
        Qin0MC/bRF7qNKO6wDkAi47HkiLc8RO87ARIVTk=
X-Google-Smtp-Source: ABdhPJwhjXF3RwLIU4GfcdOdt8gKMr+o0X5DVlV8VN3KFbj+PtldlURvmjq6iOjWP1/nrRa9fw5rTg==
X-Received: by 2002:a05:651c:988:b0:24a:c21f:7057 with SMTP id b8-20020a05651c098800b0024ac21f7057mr13482856ljq.16.1648503711386;
        Mon, 28 Mar 2022 14:41:51 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j15-20020a056512108f00b0044a3cc8769dsm1752872lfg.123.2022.03.28.14.41.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 14:41:50 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id bn33so21031221ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 14:41:50 -0700 (PDT)
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr22077785lji.176.1648503709507; Mon, 28
 Mar 2022 14:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
 <CAHk-=whzqAB6kfHUcX2uhfPnNiWJRq=UmeA1TbgGi3XA+57j3w@mail.gmail.com> <YkIqyb6lhn5uU2jb@latitude>
In-Reply-To: <YkIqyb6lhn5uU2jb@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 14:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxvNGEUUN5fj203KJL8qXK3jv359Ketc-HJMJU9wN6KA@mail.gmail.com>
Message-ID: <CAHk-=wjxvNGEUUN5fj203KJL8qXK3jv359Ketc-HJMJU9wN6KA@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v5.18
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

On Mon, Mar 28, 2022 at 2:38 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> It was =E2=80=94 but when it was noticed, the fix went through the IRQ tr=
ee, on
> top of a refactoring that happened there (the switch to generic_handle_do=
main_irq):
>
> https://lore.kernel.org/lkml/164751044707.389.16417510835118111853.tip-bo=
t2@tip-bot2/

Ok, that ends up at least being identical to what I did, so thats' good.

> When I added the pinctrl-wpcm450 driver, I changed the pinctrl/nuvoton/
> directory to obj-y and exposed the pinctrl-npcm7xx to CI bot testing.
> The bug existed, untouched, since the driver was added a few years ago.

Ahh. Good. So not a heisenbug, just happened to be hidden before.

Thanks for clarifying,

                 Linus
