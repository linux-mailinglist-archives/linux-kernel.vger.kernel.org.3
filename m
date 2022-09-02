Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6035AA835
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiIBGnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiIBGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:42:59 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D177BBA79;
        Thu,  1 Sep 2022 23:42:58 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jy14so758600qvb.12;
        Thu, 01 Sep 2022 23:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ijNv5WqEEQFROPjZ7hs8XYIOd3yXWWZXXWp0NKKqDtQ=;
        b=C5o7qskSx+1+hp9CSvidJ3m4RcIrjIlaVRNx8Kr+rcLkWve7RXxSaVDkylrJKjpSaY
         TnsVP9BpFVCHJAbUvaPFKBS0Tqq7JUyaHvc5PMWjP4lwziqXzRy5fHdkDPmWOBpdgW+v
         ySg9NPKDBZ73phjgOv6IrVm/9Ybk9Z2kAxqZ+4/jw0IiVdqNj0iNYPONREliqIT+XNuQ
         L2+EHElOpmQkBLaT3mOpebzcxC/5FexnASQN7YjM2X6RNGl0OH/5bzW1j8d0eq3vE58h
         X5cHKv99WAQkmCEfA5BGTHEZkn4yVjh5Kgcc8wYlRvETdfL7+F2sQzlU4UOh2DPr5z2m
         I3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ijNv5WqEEQFROPjZ7hs8XYIOd3yXWWZXXWp0NKKqDtQ=;
        b=UDsioRIf227JBAPwnlj4A9A1kVrjsVq+d4YdwWIJyJ/QCvUmnM2Pw7LdY3nAdOm6Dg
         Bzjbc5M8IBQ0woLY9ytjekfHEDx3gcydDd7pFmuIjJm6x76NlyYXg0yHCHsM+8CHlGa9
         s5WGFFPcEiU8QB73IE8VtEMkR3viG3Uk++04TgO/0F0slgPpjWDHoSnuZfpF/r5EvC3I
         W8GeWpcHn5ciBwv8HVKUQe+h8zulcETv5Y1QFv3wVPHgXkNbm1fm8GOliGdJ68HRRFWj
         5ttbxYt+6jAFcLTBOii4bQ6gbvJ915nZDZnyUDopm93T5ZZA+E6w5iAIspBEN94JOaCp
         u2Ug==
X-Gm-Message-State: ACgBeo1TmgWls8edeXDeqoXbUpbw7Vq1MELJQ9Eh1cg99yoHwgjLtATL
        wTzy5bOR/kbJwTCRChHznNXqiMAwBo5C1rYAocJOfBG461A=
X-Google-Smtp-Source: AA6agR4vBazx/jplPCR7QUKsWHhJXKjqYpf8dvxM0kDkmBar9x+MzdDN2Ny5QwQEfhxOMQu7C6j52hiI2G+IQzA6YLE=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr18544602qvb.82.1662100977308; Thu, 01
 Sep 2022 23:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220831055811.1936613-1-s.hauer@pengutronix.de> <20220831055811.1936613-2-s.hauer@pengutronix.de>
In-Reply-To: <20220831055811.1936613-2-s.hauer@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 09:42:21 +0300
Message-ID: <CAHp75VfbNespbCZ81xcvA7zsr3K8nbb3LBrpXOjH04R-hEFumw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sascha Hauer <kernel@pengutronix.de>
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

On Wed, Aug 31, 2022 at 9:02 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> This driver implements a GPIO multiplexer based on latches connected to
> other GPIOs. A set of data GPIOs is connected to the data input of
> multiple latches. The clock input of each latch is driven by another
> set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> are output only.

So, this is for only one type of latches, now I'm wondering why
gpio-74xx-mmio can't cover this case (with probably small
modifications to the code)?

-- 
With Best Regards,
Andy Shevchenko
