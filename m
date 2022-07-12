Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB18571D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiGLOpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiGLOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:43:45 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B11BDBB5;
        Tue, 12 Jul 2022 07:43:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 64so14265033ybt.12;
        Tue, 12 Jul 2022 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coKDGy3LG/pzJw/5Ba+mZia0etc8htd3qdA0mBwoUlo=;
        b=Gku7tM75sCcOnsW5gmmQaJQqu/YdWVcLpDihH/AY2KffEl1m0BgyreMwVjQD6ZHHUE
         UU/8W8HTbEveGbwg84Muss162f9qfB9Pf1dyKy/eNrm8mNGsboVeq5awDuPNvXW8nEYV
         NfsShs5wR1nL2traL6zHc1HX9R6EKavv+TM2xOxZMSm+RmlYsDQUtgGYTi7uazhgRpHG
         OHo/R5VOg1WJ2Z/k3jvlFdw2isQ6uYo+mRE/DgdGKyox0Hh+eCJwK6VjvjFMT/f+E7eM
         1A/y4Vso219JXUkK3mREY2W0e4lnm0OgcY+OVPqSQbP5+GqDwEDL629/JP7t+/SVuygx
         AO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coKDGy3LG/pzJw/5Ba+mZia0etc8htd3qdA0mBwoUlo=;
        b=k6j44E5ILsLC1u5QpVvFH1MVsKpkSJAvf8WaPqz5+ZTCPwZWuzlVn0MIlx/Az+efVe
         2JCH34lGah78wAntF6hujFTWUwjf9Imrb6kFmxN3nA7+dArvN/mEetdRHuQtJXD6GKkk
         zbzlq+kMIdrAdO2lcWA+PWajIImAycC2WmEVcUItyq6S9Sz1sZFqxjpPClrxt36owBZe
         CPqUOLs2pz12H7aX7CW7ZoAFvu3iieawAzF/woasqlVQ1ubgE4oE8wn4awNcr7iY/IDZ
         TD6yY+MYsS5satpyfueyiyK52gQxvn3/cO1VwwYua2kQsCKhFlBca2VyJDHMsybIS9JY
         YzxQ==
X-Gm-Message-State: AJIora+aDbo67x3tTHtdgJZQ8oHI0Amcxqm4ad6slEJUIf7HizqX3myT
        Lo+4FdCZyFL6rIlk2CO1gW7poTSDiXaEpV9F9Hw=
X-Google-Smtp-Source: AGRyM1vFZMoDBRYL342rw6lRXJa26nXlAWhIwYlJBklTEiX5huDMwLdHT/sItLUcdmlpLdS3mr1eTrz+kwvtlxJtcic=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr23385993ybg.460.1657637003075; Tue, 12
 Jul 2022 07:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220712143237.13992-1-henning.schild@siemens.com>
In-Reply-To: <20220712143237.13992-1-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 16:42:46 +0200
Message-ID: <CAHp75VeYHi8XTf3Y6HMmitVvuvF2uiWdSzpiKFji5SfV20HqpQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] add device driver for Nuvoton SIO gpio function
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
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

On Tue, Jul 12, 2022 at 4:32 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> changes since v2:
>  - move from subsys_initcall to module_init
>  - add 2 more patches to show how it can be used later
>  - v2 is based on [PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper
>
> changes since v1:
>  - implement get_direction function
>  - style changes requested in review

JFYI: You have a strange subject. Had you used `git format-patch
--cover-letter ...`?

> This adds gpio support for several Super IO chips from Nuvoton. The
> driver was originally developed by Nuvoton and i am just contributing it
> on behalf, because other patches i will send later will require access
> to the gpios. The driver is valid on its own.
> In fact v2 of this series shows a future user, not to be merged right
> away but to show what is planned.
>
> The driver supports several chips, of which i only managed to test one
> but did not want to drop the others.
>
> I hope the original authors will help with the testing and addressing
> review feedback. The changes i did so far mainly are inspired by similar
> drivers and some just concern coding style. If more has to be done and
> the original authors do not jump in, we might start off with just that
> one chip i can test and add the others later on.


-- 
With Best Regards,
Andy Shevchenko
