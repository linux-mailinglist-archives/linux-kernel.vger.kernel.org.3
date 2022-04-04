Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233FF4F18E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378748AbiDDPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357418AbiDDPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:54:38 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177504249E;
        Mon,  4 Apr 2022 08:52:42 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id e22so7759299qvf.9;
        Mon, 04 Apr 2022 08:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoKMmslTq9vAMf9fgCFPDKuPR8Y+Dj4j8nKqoiHe7eI=;
        b=orYEe3782pb7f3scdOPHBOTx+0G9AEkrzmuxJv9y1NWBUaqrgkk5IfLOELobgXdy9o
         j+URwLav6QWmpw0kt9hYjScd090q0FdIzjB+Ms2e6i846tNR0JqEIbb6YjHPrnxw5bOI
         UwJN6HGKi+dzUoIiqCBYQx+JY/14CyOoHwqDv01gRr5pOWJYBQ0HYq8U4Qrrp7BCjkPL
         sFw04VwsNJmtqvKPtd3ZTn4adXnEm1d2WnylaGbbuV8N2ssEAjH5tNVEodgrP+ykRrKM
         RVfwRKYUADHAdUd36rJdv0UOHRG7t6eFtw32mHMZSC+5dgayyui6NQTKDmd6HRv76h3/
         qALA==
X-Gm-Message-State: AOAM5312CkqCa5Mv4NNj0bn9ucWdz+zE7PbFFNR85PnWR2nLN0uKLu1m
        nLRrWaHwIC3BqynQyGUqDmNP3e3MDXo6kQ==
X-Google-Smtp-Source: ABdhPJxE9NZvLyJHKIRUcxfuOkTBItCEwNAampQqm0sgfoFr5hp1GXWROph/W0nr8XtNtPJe5VbSOw==
X-Received: by 2002:a0c:cd05:0:b0:443:cd52:7829 with SMTP id b5-20020a0ccd05000000b00443cd527829mr399048qvm.98.1649087560944;
        Mon, 04 Apr 2022 08:52:40 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id u62-20020a379241000000b0067ed2b0994dsm6592293qkd.54.2022.04.04.08.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:52:40 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id d138so10015512ybc.13;
        Mon, 04 Apr 2022 08:52:40 -0700 (PDT)
X-Received: by 2002:a25:c049:0:b0:634:6751:e8d2 with SMTP id
 c70-20020a25c049000000b006346751e8d2mr437586ybf.6.1649087560296; Mon, 04 Apr
 2022 08:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220404084723.79089-1-zheyuma97@gmail.com> <20220404084723.79089-8-zheyuma97@gmail.com>
In-Reply-To: <20220404084723.79089-8-zheyuma97@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 17:52:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXz0z2wARniaLqLqp-Oc6HMgoMpbL3D9Fg57W-wkLWBhw@mail.gmail.com>
Message-ID: <CAMuHMdXz0z2wARniaLqLqp-Oc6HMgoMpbL3D9Fg57W-wkLWBhw@mail.gmail.com>
Subject: Re: [PATCH 7/7] video: fbdev: s3fb: Error out if 'pixclock' equals zero
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

On Mon, Apr 4, 2022 at 3:50 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
> The userspace program could pass any values to the driver through
> ioctl() interface. If the driver doesn't check the value of 'pixclock',
> it may cause divide error.
>
> Fix this by checking whether 'pixclock' is zero in s3fb_check_var().
>
> The following log reveals it:
>
> [  511.141561] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> [  511.141607] RIP: 0010:s3fb_check_var+0x3f3/0x530
> [  511.141693] Call Trace:
> [  511.141695]  <TASK>
> [  511.141716]  fb_set_var+0x367/0xeb0
> [  511.141815]  do_fb_ioctl+0x234/0x670
> [  511.141876]  fb_ioctl+0xdd/0x130
> [  511.141888]  do_syscall_64+0x3b/0x90
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/video/fbdev/s3fb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
> index 5c74253e7b2c..b93c8eb02336 100644
> --- a/drivers/video/fbdev/s3fb.c
> +++ b/drivers/video/fbdev/s3fb.c
> @@ -549,6 +549,9 @@ static int s3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
>         int rv, mem, step;
>         u16 m, n, r;
>
> +       if (!var->pixclock)
> +               return -EINVAL;
> +

When passed an invalid value, .check_var() is supposed to
round up the invalid value to a valid value, if possible.

>         /* Find appropriate format */
>         rv = svga_match_format (s3fb_formats, var, NULL);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
