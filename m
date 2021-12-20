Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0901347A610
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhLTIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:32:02 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:40903 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhLTIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:32:00 -0500
Received: by mail-ua1-f47.google.com with SMTP id y23so16283755uay.7;
        Mon, 20 Dec 2021 00:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgjLQvrKGuGeCYHnkgESw4n2mOzkXtzgjSJa+/vyJgI=;
        b=iJNu/vXH11pXz2aa+fzl7Q8mqkAXzQoCTrW5vMqiVB7TEpfdmcCb1Mq4FfDPz5OmTj
         4tOlpcfUDoyaxYqw0oIBHdcq3c4tg8CQI4EQ/Kazz1StDkCG2To3gFk6CHermNZ0OwLx
         BZqo05BPmGmcQD7aMD29zi9GI/ZyV0UJz4scRd9rsP9HKdg41P9f9eAktVyZ9gQkGnlo
         JvO398e84pn2T5+CYjo+OzA/ppola7FD/5qvu5J5Z6hmyBGH/EgO15+yEi7Xfh9cDQzY
         UfK6wak3+sIvaAIyYgAYAQ4I9qXzUzlx1n+vaJ4Nn3m4hOvhiT8tqD4I2ct+i2IUbfxN
         GeLA==
X-Gm-Message-State: AOAM532+rgFp6yp9syzc0rpGL4fkOXTYIjZSDiKsJVBkwfHnANI/OCJI
        7uv2mzSeGm5wRPM+fAlPJ+8Mp3x9rOtCwA==
X-Google-Smtp-Source: ABdhPJw417rxtNPSZg6m7k/o1pZCAYviPftsGzQn7e0RGN+WniR/Fkb2tujGSbTR17GWyNyeS/2UuQ==
X-Received: by 2002:a05:6102:3907:: with SMTP id e7mr4475513vsu.39.1639989119130;
        Mon, 20 Dec 2021 00:31:59 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id q185sm1658685vka.14.2021.12.20.00.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 00:31:58 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 70so5633966vkx.7;
        Mon, 20 Dec 2021 00:31:58 -0800 (PST)
X-Received: by 2002:ac5:c853:: with SMTP id g19mr1252601vkm.20.1639989118527;
 Mon, 20 Dec 2021 00:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20211218180035.200552-1-liuzx@knownsec.com>
In-Reply-To: <20211218180035.200552-1-liuzx@knownsec.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 09:31:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWfPG3tSJWGciDs3PoNguvdoGEM514TEcSQg3YL398_LA@mail.gmail.com>
Message-ID: <CAMuHMdWfPG3tSJWGciDs3PoNguvdoGEM514TEcSQg3YL398_LA@mail.gmail.com>
Subject: Re: [PATCH] matroxfb: set maxvram of vbG200eW to the same as vbG200
 to avoid black screen
To:     "Z. Liu" <liuzx@knownsec.com>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Rich (author of commit in Fixes tag)

On Sun, Dec 19, 2021 at 11:31 PM Z. Liu <liuzx@knownsec.com> wrote:
> Start from commit 11be60bd66d54 "matroxfb: add Matrox MGA-G200eW board
> support", when maxvram is 0x800000, monitor become black w/ error message
> said: "The current input timing is not supported by the monitor display.
> Please change your input timing to 1920x1080@60Hz ...".
>
> Fixes: 1be60bd66d54 ("matroxfb: add Matrox MGA-G200eW board support")
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Z. Liu <liuzx@knownsec.com>
> ---
>  drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
> index 5c82611e93d9..236521b19daf 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1377,7 +1377,7 @@ static struct video_board vbG200 = {
>         .lowlevel = &matrox_G100
>  };
>  static struct video_board vbG200eW = {
> -       .maxvram = 0x800000,
> +       .maxvram = 0x100000,
>         .maxdisplayable = 0x800000,
>         .accelID = FB_ACCEL_MATROX_MGAG200,
>         .lowlevel = &matrox_G100

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
