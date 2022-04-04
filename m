Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521694F1405
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376593AbiDDLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376615AbiDDLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:49:33 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E63D1FF;
        Mon,  4 Apr 2022 04:47:37 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id s11so7424037qtc.3;
        Mon, 04 Apr 2022 04:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkI30un2e+aw5iEZT5SxMrRKH4N5lxurp/14o6OWyKM=;
        b=fCC2dFneILSnm5DV9D6VKz6qs14B5AdEQ1gxjpAvUe37gELThHGbyuMXa/ImGlIEve
         Phf4z6WO9JAoEHTEMsdsy8Q9OrwFbz5fSxsj2N1b8L/Vv9YV7dekyVrO44F7IzA0WYjx
         4CDpN4v0t26Je2kIeD8+OIsCYV5U8fUPhF0kKxJFugI9bWVrzL/Ni42nqT6XFMlp9da0
         e0uaK5CvZvDoJqgOtJvVzjHRXl5WpYODooWc3prYrFhNhApa4Ch2R7Dz4yhTVMOL6zVZ
         M85Vy01l3XTy99W9L8iPUg7SIAn3NTuMjHzBECGvK29P1OhMFCIn7jXiyBRi0r0zwHfe
         j19w==
X-Gm-Message-State: AOAM533EkJIpjPTQMAX1fYw2r1MYVXfIZHHIaHB2ffET7REZFKbFEAyB
        WHRN8Jip+YMgrFteYKV2q/z+CPmNKkzkcg==
X-Google-Smtp-Source: ABdhPJxfxEaxyN8Bxm2G0DLsPYOHGiYYi26ZUqCHFyu0+LfiYP4i7Hpceuka3oDJp/7TzfL4LldBsQ==
X-Received: by 2002:ac8:5c4e:0:b0:2e2:104f:7257 with SMTP id j14-20020ac85c4e000000b002e2104f7257mr16988105qtj.544.1649072856476;
        Mon, 04 Apr 2022 04:47:36 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm8536883qtx.58.2022.04.04.04.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 04:47:36 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id f23so17039599ybj.7;
        Mon, 04 Apr 2022 04:47:36 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr20536043yba.393.1649072855895;
 Mon, 04 Apr 2022 04:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220404084723.79089-1-zheyuma97@gmail.com> <20220404084723.79089-5-zheyuma97@gmail.com>
In-Reply-To: <20220404084723.79089-5-zheyuma97@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 13:47:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWs6DwoKmEBFiwwMWDNLFS4Ow6V0YWWSU-jy3mvK2M4bw@mail.gmail.com>
Message-ID: <CAMuHMdWs6DwoKmEBFiwwMWDNLFS4Ow6V0YWWSU-jy3mvK2M4bw@mail.gmail.com>
Subject: Re: [PATCH 4/7] video: fbdev: vt8623fb: Error out if 'pixclock'
 equals zero
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheyu,

On Mon, Apr 4, 2022 at 1:07 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
> The userspace program could pass any values to the driver through
> ioctl() interface. If the driver doesn't check the value of 'pixclock',
> it may cause divide error.
>
> Fix this by checking whether 'pixclock' is zero in the function
> vt8623fb_check_var().
>
> The following log reveals it:
>
> [   47.778727] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> [   47.778803] RIP: 0010:vt8623fb_set_par+0xecd/0x2210
> [   47.778870] Call Trace:
> [   47.778872]  <TASK>
> [   47.778909]  fb_set_var+0x604/0xeb0
> [   47.778995]  do_fb_ioctl+0x234/0x670
> [   47.779041]  fb_ioctl+0xdd/0x130
> [   47.779048]  do_syscall_64+0x3b/0x90
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Thanks for your patch!

> --- a/drivers/video/fbdev/vt8623fb.c
> +++ b/drivers/video/fbdev/vt8623fb.c
> @@ -321,6 +321,9 @@ static int vt8623fb_check_var(struct fb_var_screeninfo *var, struct fb_info *inf
>  {
>         int rv, mem, step;
>
> +       if (!var->pixclock)
> +               return -EINVAL;
> +

When passed an invalid value, .check_var() is supposed to
round up the invalid to a valid value, if possible.

>         /* Find appropriate format */
>         rv = svga_match_format (vt8623fb_formats, var, NULL);
>         if (rv < 0)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
