Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF94CE732
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiCEV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCEV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:28:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2792311C3C;
        Sat,  5 Mar 2022 13:27:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bi12so11229544ejb.3;
        Sat, 05 Mar 2022 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JsR7zrG3vxL7/XJnLXmd7BhQLLdAdgVDWSojck8Ik4c=;
        b=k357gdJWiPFAUbXLxtRrFpAeCeK/pP4d9f61XGg1A7xQDMrHVSEcwg3xvpzXo5yhh4
         p7F2vOHK4R7NJ0K4SB64LyKaYJngfMzpsZXBQMPZWpbnWOZe7tD2d2EeEjTgdrrVZK5u
         63aXOAllerV1NlxndawECf4kg/14UX+hBN75jWAJD8cDQp1VUBL2mA9pBzNzmhnQJReu
         qpyqeLiQxk6ntooIv6yz+nWRLJO75aZdrviKa3OQ2HCyIOQA01xt4k0Y7dOueeNtyhR9
         rcktTrF7YHTYnVoisA/qnxa7JKekLqKOlNhZLzZnhWaRhClx8gjhORwAt5JqzewfUxmj
         NZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JsR7zrG3vxL7/XJnLXmd7BhQLLdAdgVDWSojck8Ik4c=;
        b=EuAobb9f9YjIqQVgDSWCkmDcEVf79D2+Jtx6pkw6upz4UpxQzNcvBTQ3FY5sdduzL1
         Qo8+nnUgwV/tfK7Ftp3zTTS1i7Chk63CKjuTSznue44DJRPEFBZ5AYyZ5W6dhCS9ve1h
         5KPCw8NK6u6J545iphW8jce0q124hdhxP0Xnm+RVDX6g9PN357TOPdRLrZM3pdCkGWdd
         x3IpXPwOBahEPQ104FG+zisZzfTkp/QdHVkdrXhAHY9Mls22axOm3DTgpyD0BQ2Jh0Gw
         MCNkyqjbcHWjACEHKt1aZUcp2U1Bt+gEZPlMm2XQfRGqVo6E+0aFO1rHBU4Qsj2ypEHi
         /ZXw==
X-Gm-Message-State: AOAM531+5OULzd5yCA4USioRv4yV+QSDR4xkWJsM7EQqvTAj5mvk5Ubi
        JKLdpiJ1JQaXhXzP7fxEfsBZ3wp7uB0dMq+DE0FYpqEG9In+5w==
X-Google-Smtp-Source: ABdhPJyE40Mn6JcdNnjxW1HBwtFUxDfHOM3cw6oQRBCm0q87Zikh9cfGDj9UaNhF/WVIcB7JfkZRw/wcOwZP5caMfiU=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr3847317ejt.639.1646515651958; Sat, 05
 Mar 2022 13:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20220305154256.278394-1-brgl@bgdev.pl>
In-Reply-To: <20220305154256.278394-1-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 5 Mar 2022 23:26:55 +0200
Message-ID: <CAHp75VefVkNfGoFKtG3-3fF4TEiu33u-EaASEiTUmj_OAm-onA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix the size of the ngpios variable
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Sat, Mar 5, 2022 at 10:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> The ngpio fields both in struct gpio_device as well as gpio_chip are
> 16 bit unsigned integers. Let's not risk an overflow and use the correct
> size when reading the device property.

...

> -               ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> +               ret = device_property_read_u16(&gdev->dev, "ngpios", &ngpios);

AFAIU DT format you may not do this. The property is ABI-like and it's
32-bit (BE!). Reading as u16 will bring you 2 MSB (bytes) out of 4
from the 32-bit value.

-- 
With Best Regards,
Andy Shevchenko
