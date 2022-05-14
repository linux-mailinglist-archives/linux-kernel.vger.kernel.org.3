Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7252710A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiENMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiENMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:39:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50C10C6
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:39:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k27so12907109edk.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5cXtHmb/IUXktqrQxY9llflJTUdMFU1b4XNljcFDgM=;
        b=CfyAES3eL6TADn0/8LqBiAwwdph69XTaAC4S3SpgSI5TdIz++eFq8IiECQ6zt25L4b
         4jjIinLu6iEkJPrxd9XmZe9yiVkJbEjOeW/adCQlBtxigtdwCW2sP0uucNfdBRbj4Ve+
         xFcrXpcqBcf7Z/GinlV3BdlkGEojdcMEUmJZ799f85DNnTjAHlxSz803WrrgEt3RAC/H
         cCacuczQs90904zN8kMAqSLO+LRS+4txWr6zo6T0FqhXEOqUOSU6Ht72f/+FxYM8BkM5
         95kMTOYbW436cyEJxVo1P8Wedo/eN1mhKTZkFJD32AVBH4uJ8BMw3mmOGNVJrA540I1H
         3aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5cXtHmb/IUXktqrQxY9llflJTUdMFU1b4XNljcFDgM=;
        b=NQChCHACscLB8ZuFlT6Zv0MJ0/w04q49smrYjM9zvrSLWDBLaXhLyuuUhLTUcdgsP+
         2nmEDrZw8S+78EZ3LFZ9fvutsuekW7+x5KwBPoEVmA1qdkFMQbhxVPUfembxcr3Nosp8
         bDRFvzrQ0rWrFIGQ9Cpc5KILXw2wo+dG9MDUedFyBfgwJu6J2LtHe/A+vS4+XsEQYQkv
         S7QpN7WZ04D5bHMedAVkIty+6/BBl1d+jcWj4EA2e8nH5prc/yxXiPydtTJ8YFSkSx4z
         OQk13rimm53tTj9ByOXsXmRvIKNsr7ssVzqESaZK/zMR1sXOXKcQJAqkOjZzLOXOxZAc
         9+dw==
X-Gm-Message-State: AOAM530v9JAojMRvmDe6WMl2aNjgOTAD0ENWR1/yX6CZPUOx+0s9R2Yx
        8/9KPiQAP9pZ/8+i6EMvwfpn8oW9Pz7ErFdkKvGmpQRAPU4xLQ==
X-Google-Smtp-Source: ABdhPJyzfqHh31APT2uQr5GCB7txhShbQAe+l71x9MTK7m4W4CaJ9F+25jT2yvAOXqDWVL26ssp1tun8GuQ9hanHgn4=
X-Received: by 2002:aa7:da08:0:b0:425:af3c:196a with SMTP id
 r8-20020aa7da08000000b00425af3c196amr3558961eds.69.1652531984131; Sat, 14 May
 2022 05:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220511090456.3428850-1-zhengbin13@huawei.com>
In-Reply-To: <20220511090456.3428850-1-zhengbin13@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 14 May 2022 14:39:33 +0200
Message-ID: <CAMRc=MdpA+UgsDsWp7i_jKhN2TL89ZWBu2_NYdi24wo09yi1Sw@mail.gmail.com>
Subject: Re: [PATCH -next] ARM: davinci: da850-evm: add missing
 platform_device_unregister in da850_lcd_hw_init
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gaochao49@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:51 AM Zheng Bin <zhengbin13@huawei.com> wrote:
>
> da850_lcd_hw_init misses a call platform_device_unregister in error path,
> this patch fixes that.
>
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index efc26b472ef8..7b2a1a37e5c0 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -873,8 +873,10 @@ static int da850_lcd_hw_init(void)
>                 return PTR_ERR(backlight);
>
>         status = platform_device_register(&da850_lcd_supply_device);
> -       if (status)
> +       if (status) {
> +               platform_device_unregister(backlight);
>                 return status;
> +       }
>
>         return 0;
>  }
> --
> 2.31.1
>

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
