Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31B64C59CE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiB0GSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 01:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiB0GSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 01:18:04 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AB82DDE;
        Sat, 26 Feb 2022 22:17:28 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o8so8634200pgf.9;
        Sat, 26 Feb 2022 22:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ow8n9bnT7hSkaP9jr1cS5lcPgbno/KHHbNMAFcjqosI=;
        b=pLWATeuoF6Rho2C/qM1ObggjqCTCKSIYrmdUZXDGKsszkUsAcjDi8VTX5dBAAheyrc
         2eLojOdeb2kcq1mma3uEI8OUkGk26ttPxm8x3MSBLv08iAAlkpKYBpjC/08jQI8CI6g7
         mNTlEeepAa7CPOnQwdggaSjivRcEMvtwVnkI0rwbjzZqdq3Yk+OshYxU4s/sij/K1dcS
         CYYILFIBcnoy7ZXwgSbgGYPV5U2DYKSXKjk/BuAA0Gdr7+/snYtbGwJMnqjfG25q1NiG
         YE0EA8C6V7uyinJ7fGojLVAL7sWjiuk5pgwHshd1MK98BogSKQHXMomLJq7bf/rjT7dB
         HxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ow8n9bnT7hSkaP9jr1cS5lcPgbno/KHHbNMAFcjqosI=;
        b=CAiT0Eilt3VU2TQO6kkNZcpv5KOtQtmzXABY18eDW7+5/7GaW49NwtHK4z7Hb1V0Kh
         c3v9u6Hsjz9dyNofglmJ+BRcPP8QkZs87GZ3Si03+KoqhQ+JacY5UA3Bqmgf7YMoqsrx
         ZhLJ8A3wPEKpoBgf9Lccm0+3P61yjky19Z2XxrOP3yqpoumSwd2bSytjXQQ1tXz6JQAx
         5CewMHSMuJxT107M7szde5HNycy7OtAIMnn/7lCDxmNHk+IIIyKw9Y4vu+smUBt23l2a
         xlzL3hOY7V0UDGMQtAUgolpDOv3uaFVAKlYhaX0Bo/DgWeCYhqY24MRKNRz/qNqukaPA
         Cf4A==
X-Gm-Message-State: AOAM531soG9hOyp/hln9wxSXq0xpcFYyWabl6l5OA0fq0Ppd1+Sh5lNF
        a5fOVNaiBSRZnKMO9s8CokkMfxGJNlmm+Vn3+b8wZibshQ==
X-Google-Smtp-Source: ABdhPJy1AveXJn8qgloASy8DlTcYT+KqBr50ybb+b17ayKSx1dDtKKCqD4uBZzJB1bfxpLxka+6SDhFJU63Wx843Tfo=
X-Received: by 2002:a05:6a00:1991:b0:4e1:a7dd:96e5 with SMTP id
 d17-20020a056a00199100b004e1a7dd96e5mr15890456pfl.2.1645942647724; Sat, 26
 Feb 2022 22:17:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMhUBjmetJqbERvQ8513b-wHuV68hqLTuUVWiORyJyXP26gO7Q@mail.gmail.com>
 <YhpBPQuqPNmqasxE@ls3530>
In-Reply-To: <YhpBPQuqPNmqasxE@ls3530>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 27 Feb 2022 14:17:16 +0800
Message-ID: <CAMhUBjn_cGF_Htap+iJri991tXPQiqwn_EPY6XuPu+bH07m=eg@mail.gmail.com>
Subject: Re: [BUG] fbdev: sm712fb: Page fault in smtcfb_read
To:     Helge Deller <deller@gmx.de>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 11:03 PM Helge Deller <deller@gmx.de> wrote:
>
> * Zheyu Ma <zheyuma97@gmail.com>:
> > I found a minor in the smtcfb_read() function of the driver sm712fb.
> >
> > This read function can not handle the case that the size of the
> > buffer is 3 and does not check for it, which may cause a page fault.
> >
> > The following log reveals it:
> >
> > [ 2432.614490] BUG: unable to handle page fault for address: ffffc90001ffffff
> > [ 2432.618474] RIP: 0010:smtcfb_read+0x230/0x3e0
> > [ 2432.626551] Call Trace:
> > [ 2432.626770]  <TASK>
> > [ 2432.626950]  vfs_read+0x198/0xa00
> > [ 2432.627225]  ? do_sys_openat2+0x27d/0x350
> > [ 2432.627552]  ? __fget_light+0x54/0x340
> > [ 2432.627871]  ksys_read+0xce/0x190
> > [ 2432.628143]  do_syscall_64+0x43/0x90
>
> Could you try the attached patch ?

Good, the patch works for me, thanks.

Tested-by: Zheyu Ma <zheyuma97@gmail.com>
>
>
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 0dbc6bf8268a..ab45212ccf66 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -1047,7 +1047,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
>         if (count + p > total_size)
>                 count = total_size - p;
>
> -       buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count, GFP_KERNEL);
> +       buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
>         if (!buffer)
>                 return -ENOMEM;
>
> @@ -1059,25 +1059,11 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
>         while (count) {
>                 c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
>                 dst = buffer;
> -               for (i = c >> 2; i--;) {
> -                       *dst = fb_readl(src++);
> -                       *dst = big_swap(*dst);
> +               for (i = (c + 3) >> 2; i--;) {
> +                       u32 val = fb_readl(src++);
> +                       *dst = big_swap(val);
>                         dst++;
>                 }
> -               if (c & 3) {
> -                       u8 *dst8 = (u8 *)dst;
> -                       u8 __iomem *src8 = (u8 __iomem *)src;
> -
> -                       for (i = c & 3; i--;) {
> -                               if (i & 1) {
> -                                       *dst8++ = fb_readb(++src8);
> -                               } else {
> -                                       *dst8++ = fb_readb(--src8);
> -                                       src8 += 2;
> -                               }
> -                       }
> -                       src = (u32 __iomem *)src8;
> -               }
>
>                 if (copy_to_user(buf, buffer, c)) {
>                         err = -EFAULT;

Regards,
Zheyu Ma
