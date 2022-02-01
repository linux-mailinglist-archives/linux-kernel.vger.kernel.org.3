Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E84A5DED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiBAOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:05:34 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:34544 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiBAOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:05:31 -0500
Received: by mail-vs1-f42.google.com with SMTP id g10so16198632vss.1;
        Tue, 01 Feb 2022 06:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSPo3aBmqMYxhq4BWMLe/VmrA5tIsKRk8/D0WbRUEX0=;
        b=E469wnrglsv/5lUnnjwNHsuo0i/nqaCZWJBvZ/jmUKChi199tWT+p0UDVmeYxl9m4h
         HudXTF7Jmaa7KYXO6n7LGjZw/XLnnbbEyaWbY3SmsIVhBz4SpCe5/rAQrWBcLwUnahCP
         0Ai7lebpPaY1gL9jba/fr0dvgnCd2on/DHnIiUVj30rfgdjdXbe5mOuTyzl+y+8hl9yX
         Ei4K8c9py61aemhQt7lM0MoAI3UArAZZoroc/m7ah66Hc3PxwUohSZy0fu46rjpXuTUR
         9ruu1AbH/KZuoRaXKQjrhB4+p6PI8PhfqHBgXjzTApnfM8hnhLCUvrXLM33wWX6QmSO6
         WP/w==
X-Gm-Message-State: AOAM533ink1/fkuKZC6uZ3R2KMwQ6Lhi1RioUMx62+KwZky4rTSJ4U4E
        Cddan8ZwdmR8ROMFDzY7DO/hnHlJ0aKz3g==
X-Google-Smtp-Source: ABdhPJx96EuRHP9t8PKBo0FLoPjfnlqNdEsQDKOd+RhryytPVh4xP6KsOqKyjWqoOntttfe/kDr08A==
X-Received: by 2002:a67:3285:: with SMTP id y127mr10180336vsy.37.1643724330082;
        Tue, 01 Feb 2022 06:05:30 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id g22sm4294795vsk.26.2022.02.01.06.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:05:29 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id v6so16200097vsp.11;
        Tue, 01 Feb 2022 06:05:29 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr10246425vsj.5.1643724329652;
 Tue, 01 Feb 2022 06:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20220131202916.2374502-1-javierm@redhat.com> <cc093cd5-fba1-5d84-5894-81a6e1d039ff@suse.de>
 <73dbc5c7-b9e2-a260-49a6-0b96f342391e@redhat.com>
In-Reply-To: <73dbc5c7-b9e2-a260-49a6-0b96f342391e@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 15:05:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJpoG=XChpqNotfEDrWCxFUqyhjW2JW1ckAyKcWXvAUw@mail.gmail.com>
Message-ID: <CAMuHMdUJpoG=XChpqNotfEDrWCxFUqyhjW2JW1ckAyKcWXvAUw@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Feb 1, 2022 at 2:02 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 2/1/22 10:33, Thomas Zimmermann wrote:
> >> +{
> >> +    u8 col_end = col_start + cols - 1;
> >> +    int ret;
> >> +
> >> +    if (col_start == ssd1307->col_start && col_end == ssd1307->col_end)
> >> +            return 0;
> >> +
> >> +    ret = ssd1307_write_cmd(ssd1307->client, SSD1307_SET_COL_RANGE);
> >> +    if (ret < 0)
> >> +            return ret;
> >> +
> >> +    ret = ssd1307_write_cmd(ssd1307->client, col_start);
> >> +    if (ret < 0)
> >> +            return ret;
> >> +
> >> +    ret = ssd1307_write_cmd(ssd1307->client, col_end);
> >> +    if (ret < 0)
> >> +            return ret;
> >
> > Can you write these cmds in one step, such as setting up an array and
> > sending it with ssd1307_write_array?
>
> I don't think so because the commands are different. But I'll check the
> ssd1306 datasheet again to confirma that's the case.

IIRC, I tried that while working on the optimizations for ssd1307fb,
and it didn't work.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
