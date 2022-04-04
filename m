Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127F4F18E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378736AbiDDPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357418AbiDDPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:54:14 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69944248A;
        Mon,  4 Apr 2022 08:52:18 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id kc20so7782720qvb.3;
        Mon, 04 Apr 2022 08:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3vs63IC1K0uTiORv1QjqWD3HYAAr5eIqR2CDFPF9J0=;
        b=bs8HT2woZ9zZUjvs+v0jgUzAjNHMF2DxTJa2qCzwhenqWvYnBCvm/d05RcQOchrTzl
         FFTZZASiESxHBtxy2KGj8NvQSyVcnofSaa7QlEAV6yzkOXEk/LGFGOtLW2kjTScMzACY
         1C++IkdDZBBgyCNIdLqqVrWpVLK6x24UuCpTid2N2vvg1G8rwXMmSGegLsr5kbZcry3j
         SpkLWAG6dTFvoICIkECpnh3tIeTAJDy3orhLIGeZ1HHRuYfFKMELmi+fh1io10SsB8m0
         CHqZs65l2jIGnoEcso9GKG6emUQEhNpDmeXPePoLfNFrmKVvEDJ0rAUNBDSrDJY89n+h
         VTGA==
X-Gm-Message-State: AOAM530DH8+PaDKYyESL8Ik9SBoMUgAiCJL5nmJmzOQ+0tEMp1HPNf3a
        7ldxfC13FCFLnybt+bVLPDnv1qfaZEZbUQ==
X-Google-Smtp-Source: ABdhPJwHhm14nbRRysQUT+2cpvW25cR7oWmtyjuun6ucCzxVsejyBeGgTi85BsV1NRawMbqXwJMncg==
X-Received: by 2002:a0c:bf12:0:b0:42c:536d:52d7 with SMTP id m18-20020a0cbf12000000b0042c536d52d7mr183374qvi.33.1649087537741;
        Mon, 04 Apr 2022 08:52:17 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o28-20020a05620a111c00b0067d3b9ef388sm6219572qkk.98.2022.04.04.08.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:52:17 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w134so10564401ybe.10;
        Mon, 04 Apr 2022 08:52:17 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr386892yba.393.1649087536915;
 Mon, 04 Apr 2022 08:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220404084723.79089-1-zheyuma97@gmail.com> <20220404084723.79089-7-zheyuma97@gmail.com>
In-Reply-To: <20220404084723.79089-7-zheyuma97@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 17:52:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW4ynAyE9sey17f1iP_0nSJexWOB+nYdfRFXPbQXfCksA@mail.gmail.com>
Message-ID: <CAMuHMdW4ynAyE9sey17f1iP_0nSJexWOB+nYdfRFXPbQXfCksA@mail.gmail.com>
Subject: Re: [PATCH 6/7] video: fbdev: arkfb: Error out if 'pixclock' equals zero
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Apr 4, 2022 at 3:10 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
> The userspace program could pass any values to the driver through
> ioctl() interface. If the driver doesn't check the value of 'pixclock',
> it may cause divide error.
>
> Fix this by checking whether 'pixclock' is zero.
>
> The following log reveals it:
>
> [   76.603696] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> [   76.603712] RIP: 0010:arkfb_set_par+0x10fc/0x24f0
> [   76.603762] Call Trace:
> [   76.603764]  <TASK>
> [   76.603773]  fb_set_var+0x604/0xeb0
> [   76.603827]  do_fb_ioctl+0x234/0x670
> [   76.603873]  fb_ioctl+0xdd/0x130
> [   76.603881]  do_syscall_64+0x3b/0x90
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Thanks for your patch!

> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -566,6 +566,9 @@ static int arkfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
>  {
>         int rv, mem, step;
>
> +       if (!var->pixclock)
> +               return -EINVAL;

When passed an invalid value, .check_var() is supposed to
round up the invalid to a valid value, if possible.

> +
>         /* Find appropriate format */
>         rv = svga_match_format (arkfb_formats, var, NULL);
>         if (rv < 0)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
