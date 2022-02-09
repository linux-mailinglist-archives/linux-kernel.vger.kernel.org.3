Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF84AF15A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiBIMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiBIMVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:21:51 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB7C03BFDD;
        Wed,  9 Feb 2022 04:19:13 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id b2so1054269vkl.1;
        Wed, 09 Feb 2022 04:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gm3cukjz1mz6yI7/iDNj2u6cqTBPO6YHmLIpXAkxQ1U=;
        b=EFxrvIqYtJbPBxeheCqBayPErekNhlAdJ5gR44vBOXfELJPNREL8+mehhiS9aTpSFK
         70qbZWQuWXW6au82vdh+CO2VUspt4QE/SsPFP9oq1hQvfo26fkNC1G6w7ColvQpOR96j
         Wh8CdFERppWyldr7sgZdWpz3bgJ2/wc1ozywlQuRPj4BGpaZNwIxlRGL9g8LWH40Apsc
         bRtQ7Y/bHhl/72LdTpfLbbkStIJxhJyhQjgGhwDDlxfoEbYQExaYC0H5lSd/DldWc04/
         FQIXGhkZ243WMp8/9AG3YMCvneJFJOsdOZDJrPnUhd/pfzl2vId917GyZZqYvcDZudI/
         stjg==
X-Gm-Message-State: AOAM532Qc7m8YwajsgIiiFoU7G3Cp60ZsOp3AwU825oEILqJa1JigngC
        wOmnHwzneGE+SF31MuKWaEfyTMRPtWKUig==
X-Google-Smtp-Source: ABdhPJyOwP07a6rwLpDizJUhCR3UH6FuGZnQxyNuvk7/+RVtD7/gjatbx0ryvy4oHhV8hMcq0D98Dg==
X-Received: by 2002:a05:6122:886:: with SMTP id 6mr664626vkf.37.1644409152985;
        Wed, 09 Feb 2022 04:19:12 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id l187sm3294991vke.6.2022.02.09.04.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:19:12 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id b2so2300398vso.9;
        Wed, 09 Feb 2022 04:19:12 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr600764vsj.5.1644409151869;
 Wed, 09 Feb 2022 04:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20220209090314.2511959-1-javierm@redhat.com>
In-Reply-To: <20220209090314.2511959-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 13:19:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
Message-ID: <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Feb 9, 2022 at 10:03 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

[...]

> - Fix a bug when doing partial updates (Geert Uytterhoeven)

Thanks, the text console is now more or less working as expected.
There is still an issue with the cursor, though.
After doing "echo hello > /dev/tty0", the text appears, but the cursor
is gone. "clear > /dev/tty0" brings it back.

The execution time of "time ls" has improved. It now takes 1.21s
(0.86s with ssd1306fb).

The logo is not shown, even when I create a 16-color or 224-color
version of the small monochrome logo I'm using.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
