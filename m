Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F953245C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiEXHrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiEXHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:47:05 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BF8AE6E;
        Tue, 24 May 2022 00:47:04 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id c9so13054484qvx.8;
        Tue, 24 May 2022 00:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+/c66tcW1UPtlOwW1gPqYcJBORO2y8teG2WaFRyasM=;
        b=tZwGwiwI24HgZP6YekR6euldEA80dtYmPhfbRcyXYZj/gIrL+By/012768r0GwlKBW
         sHhYaxFJ5afhS20SXOOXih2DV7uUpQl8s/190lFUhmTzeNhImlL8IiF9cKjq8WE8iA4T
         ahzIbuevPoYRl6Yl+epdJaarUcwvbUNsaEdLBG43gm9jfmuHbVDzerTephOxTxvd4NDJ
         w8Crp9toKy1PWB4Dtc8qQ8XEbvu2FbmJpGWvmnqjz5s6GKhIQGcafZu14k4sC7M/0Vr7
         ukQpjeDm2dctd5pbyPhIYpeOmuhmlogpHu1QxU4ksgcqF2yGcGdYIbrs6CbsyNTwt94M
         iamg==
X-Gm-Message-State: AOAM532fCPGLPhZvYJmgWmFh1K+NrBdNORVkteK8DOkX4g3l6/YPdozt
        FjVVa4a2VEIUSCrwgWs5rOGmeiW05XQldhCx
X-Google-Smtp-Source: ABdhPJxZWFRAwaXpu56ZBrEgXW0hSOsydODsqj/8bkALBejFa6xmFYNO/wkf4obJ+HXIL09VoRjgjw==
X-Received: by 2002:a05:6214:1c8f:b0:443:8505:14b3 with SMTP id ib15-20020a0562141c8f00b00443850514b3mr20676020qvb.7.1653378423390;
        Tue, 24 May 2022 00:47:03 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a164800b006a36059ed59sm5643717qko.27.2022.05.24.00.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 00:47:03 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-300312ba5e2so6833467b3.0;
        Tue, 24 May 2022 00:47:02 -0700 (PDT)
X-Received: by 2002:a81:ad11:0:b0:2fe:fb00:a759 with SMTP id
 l17-20020a81ad11000000b002fefb00a759mr27306259ywh.283.1653378422664; Tue, 24
 May 2022 00:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065639.2432213-1-gerg@linux-m68k.org> <20220518065639.2432213-2-gerg@linux-m68k.org>
In-Reply-To: <20220518065639.2432213-2-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 May 2022 09:46:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTn6ysmjg5cr2RvYG=8f3azC1B4v=via0ePua_hv6TgA@mail.gmail.com>
Message-ID: <CAMuHMdXTn6ysmjg5cr2RvYG=8f3azC1B4v=via0ePua_hv6TgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68knommu: fix undefined reference to `mach_get_rtc_pll'
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
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

Hi Greg,

On Wed, May 18, 2022 at 8:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> Configuring for a nommu classic m68k target and enabling the generic rtc
> driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
> error:
>
>    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>    time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>
> There is no definitions of "mach_set_rtc_pll" and "mach_get_rtc_pll" in the
> nommu code paths. Move these definitions and the associated "mach_hwclk",
> so that they are around their use case in time.c. This means they will
> always be defined on the builds that require them, and not on those that
> cannot use them - such as ColdFire (both with and without MMU enabled).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

> --- a/arch/m68k/kernel/time.c
> +++ b/arch/m68k/kernel/time.c
> @@ -82,6 +86,11 @@ void read_persistent_clock64(struct timespec64 *ts)
>  #endif
>
>  #if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
> +int (*mach_get_rtc_pll)(struct rtc_pll_info *);
> +int (*mach_set_rtc_pll)(struct rtc_pll_info *);
> +EXPORT_SYMBOL(mach_get_rtc_pll);
> +EXPORT_SYMBOL(mach_set_rtc_pll);

Oops, this causes build failures for Q40 with CONFIG_RTC_DRV_GENERIC=n,
as arch/m68k/q40/config.c uses mach_]gs]et_rtc_pll() unconditionally.

> +
>  static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
>  {
>         mach_hwclk(0, tm);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
