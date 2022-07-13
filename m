Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1C5733CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiGMKIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiGMKIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:08:07 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B07FA1CC;
        Wed, 13 Jul 2022 03:08:06 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31c89653790so106951107b3.13;
        Wed, 13 Jul 2022 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XicFWh548yhev8fLUn0ntz6L95VUQXkSA0mKYWVRMO4=;
        b=S/B1jN4BpYl8UksrkGmxDgTB5l8YqJiUeXobdbVONSfhDqpnqMTiZx7Zuxgxd6UHa8
         Vh6VAjo88TkG+GfN/inSNXHM46byjTgTDeni87b8t1IUAr5wm8wKHCJSnUjkzMMhLIWl
         zucPQIfG3EMx7T/u6nDNBZqycqIFmu2cPxI4m6TozPf//xDuT3z4j+6gnRqTa1OkWdBp
         p/oknD/1VPLsekVbPSiBqwzA3G7Pc0aQ8AaiI68Lm2+ZBQIyR52fgYNPDAkmqh/gFzWY
         YMH+TtQmzXBB1RnBcid2GK+8seuREcV0vfjNFDecPalxFvpXhHycNJSDhDoCVJFZHFuJ
         +ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XicFWh548yhev8fLUn0ntz6L95VUQXkSA0mKYWVRMO4=;
        b=DbLMnshxljx7IbSLOchdd61M96ERBx+TRJLesgebj8EwyxKjWFYAvY/85h0EZEhplW
         duDK7u0cNk7GG7wdmXY3WgYbDcX+TLklHVJwfbz0P+HroyLJhTU+Wym6GHefXVeAZpxn
         y5V/6j28s47sRD+3vXmDbZ9Tyy+u8aje9TWdv9Nb3o/X1D7ZjOQWpXqAe2AcEuL5qONp
         yLkxCpVM6MpnN5wxUDiyynWTt6iChrTGW83ZguFQhOEkReLBLjsFEeCV+to7gnk8xi7e
         O8X9Monmwhi+893HwgBk81hD9lARSTACuquzBgYn2mFkRdtylq4YcCJpgJRlhodTDOcp
         Fi1Q==
X-Gm-Message-State: AJIora8dTHoW2+nY5hUWioHkxuY9sbSUDYJT9Ef3Xi3IaxFxzqY/7N60
        s02Vz4qDJVVo6BYyU4LV8vYf7RyVuhIdns8DiEY=
X-Google-Smtp-Source: AGRyM1skebGqLCdtqQ0gR3sr5HfxmQ62b9sCRARYJ2PJ/e6xhdoT7jLTiFXxsLm5uRD9Laf6c5ZPmZAhBC463J1yXnY=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr3174506ywa.277.1657706885696; Wed, 13
 Jul 2022 03:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220713013721.68879-1-warthog618@gmail.com> <20220713013721.68879-6-warthog618@gmail.com>
In-Reply-To: <20220713013721.68879-6-warthog618@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 12:07:29 +0200
Message-ID: <CAHp75VeTyS_77LCp6Uab18M3hJ0dtf5jiSSrPN4tHaBHFEUTkg@mail.gmail.com>
Subject: Re: [PATCH 5/6] gpiolib: cdev: consolidate edge detector
 configuration flags
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
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

On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Combine the polarity_change flag, struct line eflags, and hte enable
> flag into a single flag variable.
>
> The combination of these flags describes the configuration state
> of the edge detector, so formalize and clarify that by combining
> them into a single variable, edflags, in struct line.
>
> The edflags is a subset of the GPIO_V2_LINE_FLAGsb relevant to
> the edge detector, and is also a superset of the eflags it replaces.
> The eflags name is still used to describe the subset of edflags
> corresponding to the rising/falling edge flags where edflags is
> masked down to that subset.
>
> This consolidation reduces the number of variables being passed,
> simplifies state comparisons, and provides a more extensible
> foundation should additional edge sources be integrated in the
> future.

I believe that you have checked this from a locking perspective, so we
won't have worse lock contamination, if any.

...

>         struct linereq *lr;
>         struct gpio_v2_line_event le;
>         int level;
> -       u64 eflags;
> +       u64 edflags;

I would at the same time move it up before `int level;`.

...

> +       int level = -1, diff_seqno;
> +       u64 eflags, edflags = READ_ONCE(line->edflags);

Ditto.

...

>         u32 debounce_period_us;
>         unsigned long irqflags = 0;
>         int irq, ret;
> +       u64 eflags;

Ditto for similarity.

-- 
With Best Regards,
Andy Shevchenko
