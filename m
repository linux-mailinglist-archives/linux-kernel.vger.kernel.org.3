Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B653DB92
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244067AbiFENb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiFENby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 09:31:54 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C0935846;
        Sun,  5 Jun 2022 06:31:52 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id x75so5868106qkb.12;
        Sun, 05 Jun 2022 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6blk1zWjTfRbXW7KJFjVY/jp2csjnWRYFdcTz82ZD7I=;
        b=6QyxyWhCzgYo3Z/WlrPnxxq2EAvOzvncD6jY0c4atO8NRmnBOcfcU2ZK+2b/i+65kv
         2qjeC9uXMoGaI0rI+hfe9QkJqd2L2qKy5HUCyd3fyMXbN5Dktjhn9V7FnDptRqg7YDZE
         /39idy8zDvZOG+vibVzITCozfixk8KWLL10Ms3mrkO6Le4FWTeXCpKRJv1fAP5sAcJi7
         pn2ZoXrh185m6zMLllEwCatgB9DfItJSu3CbWQxApwRledqLqhUKpMGcnvgqcUmG0VGQ
         FcIM0AxUJ7plviOjRPVQFtZrqjA+aZr+ZMML8WjAczre180Yl0qsCXisFMFc9waG6oX3
         i4IQ==
X-Gm-Message-State: AOAM530f/WLLcAWKFG26KIBax1+Eq0ATHSBODed4kn/nc/GIyUNP5XKc
        oR21Mv4vXb3IwCS4JDx09mX63E1ff8xZBQ==
X-Google-Smtp-Source: ABdhPJxyPriFtfQBMJdLEIBuEyHonyaXljDVWGtghfxaxZgpfPiRseCObq/jvtPAyn4JRau1g/mUXA==
X-Received: by 2002:a05:620a:142f:b0:6a6:b667:49e0 with SMTP id k15-20020a05620a142f00b006a6b66749e0mr1362358qkj.167.1654435911580;
        Sun, 05 Jun 2022 06:31:51 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a29d200b006a6a904c0a5sm4045329qkp.107.2022.06.05.06.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 06:31:51 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id r82so21432567ybc.13;
        Sun, 05 Jun 2022 06:31:50 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr20826776ybh.36.1654435910661; Sun, 05
 Jun 2022 06:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220302033716.31272-1-nizhen@uniontech.com>
In-Reply-To: <20220302033716.31272-1-nizhen@uniontech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Jun 2022 15:31:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcFcX-g_XJaMcy7U1FR==2s_CDAVmBGz9rPTP96wX4GQ@mail.gmail.com>
Message-ID: <CAMuHMdWcFcX-g_XJaMcy7U1FR==2s_CDAVmBGz9rPTP96wX4GQ@mail.gmail.com>
Subject: Re: [PATCH] USB: host: isp116x: check return value after calling platform_get_resource()
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     ok@artecdesign.ee, Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
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

Hi Zhen,

On Wed, Mar 2, 2022 at 11:38 PM Zhen Ni <nizhen@uniontech.com> wrote:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
>
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

Thanks for your patch, which is now commit 134a3408c2d3f7e2
("USB: host: isp116x: check return value after calling
platform_get_resource()") upstream.

> --- a/drivers/usb/host/isp116x-hcd.c
> +++ b/drivers/usb/host/isp116x-hcd.c
> @@ -1541,10 +1541,12 @@ static int isp116x_remove(struct platform_device *pdev)
>
>         iounmap(isp116x->data_reg);
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       release_mem_region(res->start, 2);
> +       if (res)
> +               release_mem_region(res->start, 2);
>         iounmap(isp116x->addr_reg);
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       release_mem_region(res->start, 2);
> +       if (res)
> +               release_mem_region(res->start, 2);
>
>         usb_put_hcd(hcd);
>         return 0;

Please note that platform_get_resource() cannot return NULL here,
as this is the .remove() callback.  If we get here, .probe() has
already verified the pointers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
