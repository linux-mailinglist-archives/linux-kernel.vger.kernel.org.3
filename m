Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A258056C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiGYUVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGYUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:21:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B721806;
        Mon, 25 Jul 2022 13:21:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss3so22496338ejc.11;
        Mon, 25 Jul 2022 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKPPpp7Tp2WHUddh1HgYEbccv4hJ/81Ko8q9iKh7koA=;
        b=GhwS8nqfltd/oDHfdoOH9F1CJGCSVLIEdKDa3fGGjB4Ruhodb/VcUtAloXCdDNrQE1
         NaPvLjb2J7OyqF7RfnELsfrvnSHHNWBZbw4Q/ZU0MbxYGUo2rhg5kDoOB0HfLYwCViLY
         cD4tcsChKk1sA2gPJ65j0h2Q9ty+kLHfelJZYDMBVyWIcpVuwX9HoBA0Gexk1miLKOHm
         Vpm97FXMaMfQUuZBxXfrr6kREU/jsIOPMiHOyed/4dfWesbcKzbMCAkYRhJj9hOh1Apu
         Cxq/sqHpF++ooE5gfcQ4llhES276hBbwRe4a7MLEDxMvhycU3NQxsR9zVCvB+aRXdCk3
         I9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKPPpp7Tp2WHUddh1HgYEbccv4hJ/81Ko8q9iKh7koA=;
        b=PB37LVpRwfReMpEPPcvvy5EFthuhcUMPVH1RjJni0yWWxncYLFZWUxjBnL+uFefo6m
         9SP9MNPwXmaYukD7+4QMMZtYNe59BCGXyZQWkSYtQpljIL98h4p4I/nYJRVyVO7zG30c
         bj1u2+994oiQxuhWamtaz7pPAmxNYfFiq4+ze/xTlEkjsUx10W4wXUWBCniUrEw/TMLZ
         eIFtSSrzGWiqZ03uRne7iGE7ZBQ51nDUNl7/OyRFl7ZoejPscYRiiEcArJmqjW+UHgPo
         XuEx1r4w++FlGuszEgwhdbKi2l0JiBxQ+BtBaOWDqKJ6UfWxs9FbuOZaWH4fNpolpa5S
         IhHg==
X-Gm-Message-State: AJIora+9iQcMz0P1oTi6DESxHOOlkwMm0Hug9PuwcaPDoGtmGW9E+9TH
        R1ub7aNM5+YLIaDaWgl5dSldu0n/saPXEVbOhJk=
X-Google-Smtp-Source: AGRyM1t0oBn/F44/T031na79bCXNwpyh8cyBQhS5/OyrxJ8LNapumWpF2v8YlEwlYl945vlAMoWY9Yhx0HNZo4V9kaw=
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id
 nb13-20020a1709071c8d00b006f20eb21cd6mr11196050ejc.568.1658780496634; Mon, 25
 Jul 2022 13:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220721073909.23318-1-srinivas.neeli@xilinx.com>
 <CAMRc=Mefhk4i8_1j2=JO63SwfHEb3TrRMj45+CC1i1DUr8VULw@mail.gmail.com> <CAHp75Vdr3yM_b_8bDgAhNLrHUuyoq2nkVcj84wdvTzvLLetkNg@mail.gmail.com>
In-Reply-To: <CAHp75Vdr3yM_b_8bDgAhNLrHUuyoq2nkVcj84wdvTzvLLetkNg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 22:21:00 +0200
Message-ID: <CAHp75VdWS9DKd=xs8Kitoo9GZCsiNf7gt5HjfZn-9zNXBdvMEg@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-xilinx: Fix integer overflow
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        neelisrinivas18@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        srinivas.neeli@amd.com, Srinivas Goud <sgoud@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:04 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jul 22, 2022 at 9:19 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Thu, Jul 21, 2022 at 9:39 AM Srinivas Neeli
> > <srinivas.neeli@xilinx.com> wrote:
> > >
> > > Current implementation is not able to configure more than 32 pins
> > > due to incorrect data type. So type casting with unsigned long
> > > to avoid it.
>
> > > Fixes: 02b3f84d9080 ("xilinx: Switch to use bitmap APIs")
>
> It doesn't fix anything,  I already reject one such "fix" during
> development of this patch. Thanks!

Sorry, not my day, it was something else that time... See below.

> ...
>
> > > @@ -99,7 +99,7 @@ c
>
> > Applied, thanks!
>
> False positive.

Reading again... You mean that

  unsigned long x = y << 32;

wouldn't work?



-- 
With Best Regards,
Andy Shevchenko
