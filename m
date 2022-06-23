Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB7557D55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiFWNyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiFWNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:54:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54F313AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:54:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so33461192lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tfyugb+VK3SgQwCDhaT7lGAM/LqJxpybK+Hc9WzFhzQ=;
        b=mQzYdMV1CCi2YOP1mcnFFsH2intAb3xNeNh4JQJqOcnCrvbR3FHp1x8Y69dLYpT6NK
         QPsAOC73P/q95/mm+3RG7i6fcO2LNzzQeasKQG9g1tGBUfX9eyYiPI8ut2wI+5b9XYys
         CwL1HtPmzRUhyx1gxrB6LzROBvt81qCeaHVsyk1OqWIBETj+BDvrXT4BCtj/y2UExvLW
         7gFcUIbPjCSY85mR+fzeyubdtrMYJEKfIXl+I/yE2GaTNndWs+dixFP85jEUuZwYXNpf
         PKwTxKxqPobcDyh2Ql3zd52Bhd2zm58McIIkMEfYsHNE3rdm689o9R8tDvTw3BaIxJBA
         fIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tfyugb+VK3SgQwCDhaT7lGAM/LqJxpybK+Hc9WzFhzQ=;
        b=OWPHwq5ltVOJWdR7KVQZ9EUnQYZi8PzSuV/ZDhdQ1+OTXvlL9A6tyy0lsveASe0Okt
         CXIZLbRlFPjX+NZkOoltLyN9ELhvFHOdB1Gc5iBh5ZRkivZctmcjPmdU3P/YSJQVIgT2
         4pYKqhN4XHBpgOQk+j6Ez3nlCaP5saRkjE5sswZp/vgg8/F0tnB3GYcdnqLW540nOsz2
         l/ynV6EOK9RHMOCQexWbXKAllKUEmx8c+5QPEGP0rQrrSIMx3nXDu900UbzB7CWFFa8C
         g6Yk9BRIDSbqLElV+52FHtYCYestFJpEMNHLVF2v7hljwOJxYTH9Vt85OcpBgYmJy2a7
         MVYw==
X-Gm-Message-State: AJIora/AhS1fZ0lpoyT/O6+nGH/hsiJn1fzop/D0q9UmuZ+cTS+coICd
        3c+SAH6i5VDbShj/lTKdw2mRnqPs78FhVkgmS53BTl2iAO6Gmw==
X-Google-Smtp-Source: AGRyM1uFayviSfvWLDlRHgU6O1QCdl6DS51+zpC7nX7dalGdEzTq2NeLL8I42F7LNZxAdS3PrNXFat9Oy0e+B1LmL1g=
X-Received: by 2002:a05:6512:3054:b0:47f:7bb1:2fd2 with SMTP id
 b20-20020a056512305400b0047f7bb12fd2mr5547605lfb.71.1655992458169; Thu, 23
 Jun 2022 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080009.1775574-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220623080009.1775574-1-vincent.whitchurch@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Jun 2022 15:53:41 +0200
Message-ID: <CAPDyKFpg9Gs3qOeXWM2A1gSDEKA89i72NoTcF0M_a3jO-AC+dw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Allow speed modes to be adjusted via module param
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 at 10:00, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> During board verification, there is a need to test the various supported
> eMMC/SD speed modes.  However, since the framework chooses the best mode
> supported by the card and the host controller's caps, this currently
> necessitates changing the devicetree for every iteration.
>
> To make changing the modes easier, allow the various host controller
> capabilities to be cleared via a module parameter.  (A per-controller
> debugfs wouldn't work since the controller needs to be re-probed to
> trigger re-init of cards.  A module parameter is used instead of a

I think we could make use of a per-controller debugfs thing, if used
in combination with MMC_CAP_AGGRESSIVE_PM and runtime PM.

As runtime PM also has sysfs interface for each device, we can control
runtime PM for the card's device (to trigger re-initialization of the
card). In between runtime suspend/resume of the card's device, we
should be able to change the supported speed modes, through debug fs.

Would this work for you?

Kind regards
Uffe

> global debugfs to allow this to be also set via the kernel command
> line.)
>
> The values to be written are the raw MMC_CAP* values from
> include/linux/mmc/host.h.  This is rather low-level, and these defines
> are not guaranteed to be stable, but it is perhaps good enough for the
> indented use case.  A warning is emitted when the caps clearing is in
> effect.
>
> Example of use:
>
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   9 (mmc HS200)
>
>  // MMC_CAP2_HS200_1_8V_SDR
>  # echo $((1 << 5)) > /sys/module/mmc_core/parameters/caps2_clear
>
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   8 (mmc DDR52)
>
>  // MMC_CAP_1_8V_DDR
>  # echo $((1 << 12)) > /sys/module/mmc_core/parameters/caps_clear
>
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   1 (mmc high-speed)
>
>  # echo 0 > /sys/module/mmc_core/parameters/caps2_clear
>
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
>  # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
>  # grep timing /sys/kernel/debug/mmc0/ios
>  timing spec:   9 (mmc HS200)
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/mmc/core/host.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 2ed2b4d5e5a5..37971b7c7f62 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -34,6 +34,10 @@
>  #define cls_dev_to_mmc_host(d) container_of(d, struct mmc_host, class_dev)
>
>  static DEFINE_IDA(mmc_host_ida);
> +static unsigned int caps_clear, caps2_clear;
> +
> +module_param(caps_clear, uint, 0644);
> +module_param(caps2_clear, uint, 0644);
>
>  #ifdef CONFIG_PM_SLEEP
>  static int mmc_host_class_prepare(struct device *dev)
> @@ -411,6 +415,14 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
>                                  MMC_CAP2_HS400_ES);
>
> +       if (caps_clear || caps2_clear)
> +               dev_warn(host->parent,
> +                        "clearing host controller caps %#x caps2 %#x\n",
> +                        caps_clear, caps2_clear);
> +
> +       host->caps &= ~caps_clear;
> +       host->caps2 &= ~caps2_clear;
> +
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
>                 if (host->caps & MMC_CAP_NONREMOVABLE)
> --
> 2.34.1
>
