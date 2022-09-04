Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A345AC657
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiIDU0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiIDUZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:25:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125272A971
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 13:25:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x73so2026513ede.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bIeaeXxAAEhPfe0SYYGIV7PuLZ8/qj+bkQMo3e3Le0c=;
        b=qBC12g5AQtAVGD11sEMYl5qpv8St+Zq1xd5SI3cxak4kegt9lp97Vh0dzMBMQWPZNs
         ULa9f6FS3gqOa2eWM8VfJe5+/6EDEsFuJrhD12HNv6vMM0bRXgfc59yPu9bFPZ8qvGhJ
         lqY2kXehXPrMrMqbrQLDd1NpAExRet50ihaTkXBxo9qwbTOhBCtDJGwp01zF3G1c4QVx
         NyeHTqKldS+yVcjvRogIkmTfQ+CaQvJ3mju2zHZ/Hlh47jez8MkNgwQLKQtAQmb84mWq
         ffARUALus+R6+eVgoirkSyC+HqBqGaDx/WXWJUyxr/+ugfAnPsXnwv9R8k18FRg9v0cT
         DCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bIeaeXxAAEhPfe0SYYGIV7PuLZ8/qj+bkQMo3e3Le0c=;
        b=JlK7NqyVqkjnLqz04n+1eEYnzZot8A4HcZ3r5KJlLo1BIx3v3NsR1WF7RbvVJjOmBp
         lj92aXXJN7CctzgngnBqlryrbgATRboVY2c2CF9xPzy9bhVyKarKCVAyWdAyNnbmm2Sq
         bfYLz6eEzXYS9MjtuWagsD6YV+cwthvRaXe/hTsPThi87zhNFDMr+WF0fl6mgPx2rjMR
         FgncfBtntMTmBYJUvGLPtyrG5SlZO3sgNhUCJfpCFWf8n8DKu79ktjPUiErE4Jz+TW/c
         xowgwZlpxr6fSoLJwbkRqbwTCbsE2nJZez5RdTRtV1IVcfryGfMtI6gbIldlLrU2yzXp
         B7Gw==
X-Gm-Message-State: ACgBeo3PiretwCijL8vPTP2HUM4ewyeOl27wz7KfO75Tk7avGSvHud1f
        PSrqgckU0Lk7UGqG6S5Ci1nQGMyxTy9dpc3puabspE17XQg=
X-Google-Smtp-Source: AA6agR6dysZ5aS5EYW7RJBAwkuJBz3n5N6X5gqI4/V0VvJQiPex7hlRdAZyKG5xoxuoHgGXtGnVQ19xIBhSXP4zMVgg=
X-Received: by 2002:a05:6402:524c:b0:43e:aba4:a42d with SMTP id
 t12-20020a056402524c00b0043eaba4a42dmr40801347edd.328.1662323154640; Sun, 04
 Sep 2022 13:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220902061434.46995-1-qingtao.cao@digi.com>
In-Reply-To: <20220902061434.46995-1-qingtao.cao@digi.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 4 Sep 2022 22:25:43 +0200
Message-ID: <CAMRc=McBYhKkzap28H9KxHT2Vg4w1EPsEJpfu8J3JZjTcuQ41w@mail.gmail.com>
Subject: Re: [v3 PATCH 1/1] gpio: exar: access MPIO registers on cascaded chips
To:     Qingtao Cao <qingtao.cao.au@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Qingtao Cao <qingtao.cao@digi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 8:15 AM Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
>
> When EXAR xr17v35x chips are cascaded in order to access the MPIO registers
> (part of the Device Configuration Registers) of the secondary chips, an offset
> needs to be applied based on the number of primary chip's UART channels.
>
> Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
> ---

Applied, thanks!

Bart
