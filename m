Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019684FC2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348733AbiDKRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348726AbiDKRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:02:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C4EDFF0;
        Mon, 11 Apr 2022 09:59:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u18so8563397eda.3;
        Mon, 11 Apr 2022 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSODxI5rAnqM80EDxdMFwPMs5KtqtdCptsA1K17lu/c=;
        b=n/zHDZ+3Bfl1LJHIrS5bnb++6zzYtWgjjx/mkvUq8+cpd0T4xuvMdao0SM3gVI3SZq
         sBH3TYrJPYtWAt1W/Z+o0gLSyyA9rLCi/K+0obqCBpox3mnfM84k7b6GnEnOasYY/VMx
         vTcjgynQw5K0/CNqYIPCJm1p0F3TSxk2Ef5H2aIZYwxe+VyUO6p0vRFNOgmMg/lV1JsL
         y8E/6QqXSfGHbZyOwd/uEEpydbWbtUJG0swemY/fPAEPV7PyuYbnLs1VObOKKaFVjxXN
         xmZmbzQNUcrqvoskyMUruh9ckUEfpy4lPRm9zfC5P+Uflt/fQNLvGp5/uhsq8dJtORn8
         n+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSODxI5rAnqM80EDxdMFwPMs5KtqtdCptsA1K17lu/c=;
        b=C/fXQY8C6/elvZ5ahZGeUL2X98uWjY2iaXA0ykbTru4rVD5898uHN0HB7GJwHG/wyB
         jQWNElZxwbMpafTM92q+OkF8i5xUu+69KuiIgxVNDLqpIWamQ7tSB2jEIyYJX4sUce7L
         fnxDv1dINa76f+72NSl8TqviJJix2WKNK3ARDZ5Ku4rBvyQQwRBr+IbFzHlVO3CIqHnr
         JRzFLHbILewXrFkcX8jb3qxS8Q1VHv6bqBd9cdaUhZrAsWNhNdK88mtFq2bqvnE99iSL
         iFl0Epdcjg+ilDayAyFAzLwc/1jWBsk5q6ZVIsd/qhgfuhbrCTBV3XOzokyvy/ZBAbMt
         yRBg==
X-Gm-Message-State: AOAM533PtabNRvmqsSfmLris04IdEjiZ5WcMoKJ9wWswSRkdaBkgPtWW
        S25qMVoYGr6c0hf792wunUOxHUqt7zlYL6d2WTn/dE0OALU=
X-Google-Smtp-Source: ABdhPJyQgi2P6l2/eSg/AH3FXatW+Wqx7HAXFr5ol7gZpCIammkTobohJESsf/j35fHy0n5TSHNML1ecCmcfyK/E3G0=
X-Received: by 2002:a50:cc9e:0:b0:41d:7123:d3ba with SMTP id
 q30-20020a50cc9e000000b0041d7123d3bamr11224277edi.296.1649696396112; Mon, 11
 Apr 2022 09:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfyxspOScEt1qffshdrDYuQp50O5HFbr2cUV7MYsg=JdQ@mail.gmail.com>
 <20220411144602.127262-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220411144602.127262-1-andrei.lalaev@emlid.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 19:55:43 +0300
Message-ID: <CAHp75VePiCm6wH7aXcbnrt-4nntqx99s45wYk3+C2AKs=Usang@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix bounds check for valid mask
To:     Andrei Lalaev <andrei.lalaev@emlid.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Apr 11, 2022 at 5:46 PM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:

...

> > What does documentation tell about it?
>
> Documentation (devicetree/bindings/gpio/gpio.txt line 152) tells that
> "This property indicates the start and size of the GPIOs that can't be used."
> And the example (line 178) at the same file shows that the second element of
> a tuple is the count: "gpio-reserved-ranges = <0 4>, <12 2>;"
>
> > Does it need to be fixed?

This question was related to the documentation contents.

> I think so, because the current implementation doesn't reserve some GPIO ranges.
> For example, we have 20 GPIOs and we want to reserve GPIOs from 14 to 19.
> In this case the "reserved-ranges" looks like "<14 6>" but the
> "of_gpiochip_init_valid_mask" drops the range and this is not expected behavior.

On top of that, it would be nice to be sure that at least all current
in-kernel users (meaning all DTS provided so far by the kernel) do
interpret it as start,size. Otherwise this will be an (unacceptable)
ABI change and hence documentation would need to be fixed with
variable names in the code.

-- 
With Best Regards,
Andy Shevchenko
