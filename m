Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C922F55DA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbiF1HYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiF1HYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:24:00 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ECF2CCB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:23:59 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id p31so18807075qvp.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2rxzJ0m2+KTfhV/auXcP+l+48yjXUELQK7ZtTv6xyU=;
        b=tuWbHzuOXf+V0jscGZYet6AO2cDiU1kdSJvQGrpgon1mlT1vggkRdGQTkddUINALkK
         X4USxAwXNDX/TBrGZ2/zcstRHMS6aa9Kcit4l9I4P6S0lGnOlbDC92KlUQSqbWYa1pqw
         mRI1XzvMpSTSOftzpTjBoRggvp9UHfdG6G3w3M1acLCIVvfE8bcDrfb4ROHMRi/bZMLO
         zRJpWhsKBEinn56b8wPFpXx9EZ5S/tSrEirSK7SPm7/EAxbtZU7b5CF5gWYmPX6nzAc7
         cdRIwsBOyTYIwErDfACD/QkOvfDND0EGWJb3UHY9AGS9wMfbW5GKobUUXCpSM2VUIFiv
         GCyQ==
X-Gm-Message-State: AJIora9TJVBI/i3qRl4Hm8CqPj2baju8DknGptDJFIFwaJBl/zYpifX4
        zuvtEHu2TDBh14S5tnXDJ0RMWP8GSGtymA==
X-Google-Smtp-Source: AGRyM1sM5X/QKDkeTKQgbCB39F3JjPJ3P+xucOtAveRKzyRLIYsSEtCIc9wwLlewcg+J3TEls0EIOQ==
X-Received: by 2002:ad4:5fcd:0:b0:470:3e9c:6274 with SMTP id jq13-20020ad45fcd000000b004703e9c6274mr2540785qvb.104.1656401038667;
        Tue, 28 Jun 2022 00:23:58 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006a65c58db99sm10729903qko.64.2022.06.28.00.23.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:23:58 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-317710edb9dso108062577b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:23:58 -0700 (PDT)
X-Received: by 2002:a81:a092:0:b0:318:5c89:a935 with SMTP id
 x140-20020a81a092000000b003185c89a935mr20749995ywg.383.1656401038063; Tue, 28
 Jun 2022 00:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220628021802.4102976-1-yangyingliang@huawei.com>
In-Reply-To: <20220628021802.4102976-1-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 09:23:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjtSk9DX9_OpZfma4RuU7yfz==1C6NOPy7ZmecsyYiuQ@mail.gmail.com>
Message-ID: <CAMuHMdVjtSk9DX9_OpZfma4RuU7yfz==1C6NOPy7ZmecsyYiuQ@mail.gmail.com>
Subject: Re: [PATCH -next] m68k: virt: platform: fix missing
 platform_device_unregister() on error in virt_platform_init()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
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

Hi Yang,

On Tue, Jun 28, 2022 at 4:08 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Add the missing platform_device_unregister() before return
> from virt_platform_init() in the error handling case.
>
> Fixes: 05d51e42df06 ("m68k: Introduce a virtual m68k machine")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/arch/m68k/virt/platform.c
> +++ b/arch/m68k/virt/platform.c
> @@ -35,8 +30,10 @@ static int __init virt_platform_init(void)
>                 DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
>                 DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
>         };
> -       struct platform_device *pdev;
> +       struct platform_device *pdev1, *pdev2;
> +       struct platform_device *pdevs[VIRTIO_BUS_NB];
>         unsigned int i;
> +       int ret = 0;
>
>         if (!MACH_IS_VIRT)
>                 return -ENODEV;
> @@ -44,29 +41,40 @@ static int __init virt_platform_init(void)
>         /* We need this to have DMA'able memory provided to goldfish-tty */
>         min_low_pfn = 0;
>
> -       pdev = platform_device_register_simple("goldfish_tty",
> -                                              PLATFORM_DEVID_NONE,
> -                                              goldfish_tty_res,
> -                                              ARRAY_SIZE(goldfish_tty_res));
> -       if (IS_ERR(pdev))
> -               return PTR_ERR(pdev);
> +       pdev1 = platform_device_register_simple("goldfish_tty",
> +                                               PLATFORM_DEVID_NONE,
> +                                               goldfish_tty_res,
> +                                               ARRAY_SIZE(goldfish_tty_res));
> +       if (IS_ERR(pdev1))
> +               return PTR_ERR(pdev1);
>
> -       pdev = platform_device_register_simple("goldfish_rtc",
> -                                              PLATFORM_DEVID_NONE,
> -                                              goldfish_rtc_res,
> -                                              ARRAY_SIZE(goldfish_rtc_res));
> -       if (IS_ERR(pdev))
> -               return PTR_ERR(pdev);
> +       pdev2 = platform_device_register_simple("goldfish_rtc",
> +                                               PLATFORM_DEVID_NONE,
> +                                               goldfish_rtc_res,
> +                                               ARRAY_SIZE(goldfish_rtc_res));
> +       if (IS_ERR(pdev2)) {
> +               ret = PTR_ERR(pdev2);
> +               goto err_unregister_tty;
> +       }
>
>         for (i = 0; i < VIRTIO_BUS_NB; i++) {
> -               int err;
> -
> -               err = virt_virtio_init(i);
> -               if (err)
> -                       return err;
> +               pdevs[i] = virt_virtio_init(i);
> +               if (IS_ERR(pdevs[i])) {
> +                       ret = PTR_ERR(pdevs[i]);
> +                       goto err_unregister_rtc_virtio;
> +               }
>         }
>
>         return 0;
> +
> +err_unregister_rtc_virtio:
> +       for (--i; (int)i >= 0; i--)
> +               platform_device_unregister(pdevs[i]);

I think you can easily avoid the cast ("casts are evil"):

    while (i > 0)
            platform_device_unregister(pdevs[--i]);

> +       platform_device_unregister(pdev2);
> +err_unregister_tty:
> +       platform_device_unregister(pdev1);
> +
> +       return ret;
>  }
>
>  arch_initcall(virt_platform_init);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
