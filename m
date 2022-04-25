Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE29550E8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244651AbiDYSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiDYSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:55:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BAAB7C4F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:52:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a21so7384177edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK5Am2eyJZrP+TjI3mcdQmDmAbLxDAY93LxF4pkcc04=;
        b=wyIvNVCmjicmGVHNvEJ4sioRquKVXwPojktRypTwVjhsr5BzpZOC5ZTWMOte7j8NPt
         WqSCBs7AJuVeB0dA9oW3R5fECmYMDFYnqUdF5P7jm9OQBdMcgw5REROXS5cXf5qsUTB9
         dBRLLYur+w8P33MBKbLh/TDtqyvxYt1ZXYtf1vLaz5XUZIGNtjphodcWsrC8vk3jsNaC
         BFRCFQDme4/e/i4Lvef0eEkVVROZ9pGSC6y+qly37NWE1fV6ZGyRsSmcw1RR5z9X8ScW
         MAQi1kZc4VhVWbfmsgp8reqAy3FhenP/ZiAh8Ef+2DLlib6P7vj1t9xCmNJ9tg39sG5c
         WwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK5Am2eyJZrP+TjI3mcdQmDmAbLxDAY93LxF4pkcc04=;
        b=HuJrgPCqSJdxiywIczEzInAhNNzvFMDypl+LYFNXfA4nMvvPeP0dtmweQOdqDP+AiO
         Lm+mnP2VFw/84ri+5KEnMOHMDIaQBR9Iy5gv4QFTGp0OS9ukveGaYXvAx2jBgBWkw8f3
         vkFSudCrprbsq4tr7MfX5SxXGYEWzbMviUyxvcnQEqgY5JNtPEIeKZTgS3Fgm5ydo0sD
         1DcvIDZ33YzO3WwLok6RR4sVQqKJTFEg/cA6oNMf3BTMYi2jN5xEkeWdTZoiFU4B2Avw
         t8G7V32+J0mcRsbWgb1mQLuMFVeUZUzANFwgY+dwNwgIPctnoQN0Fwg1hqngopftjAoc
         oAgA==
X-Gm-Message-State: AOAM531RxP2x9TKB/vB16AvRszYVpNXCynqJBmBLZDAjv3o72jyxgLJq
        VnJ3ksoY8sTi90+HBsby3h15Jg/1IJv44Hfk1/ENZg==
X-Google-Smtp-Source: ABdhPJxc2e2Bg6/ErXa64ThnSjhabj49f/QSVMoWjqtgIyxc9MS1i/xehN1lPRQK2TXMBTtowv/7qeghfDfrfQtJ30g=
X-Received: by 2002:a05:6402:2932:b0:425:d7b3:e0d1 with SMTP id
 ee50-20020a056402293200b00425d7b3e0d1mr11534459edb.141.1650912766933; Mon, 25
 Apr 2022 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com> <20220414190242.22178-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220414190242.22178-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Apr 2022 20:52:36 +0200
Message-ID: <CAMRc=MfE0othcfwETf13_K3sOLKmUGwCnjapzVjLMk1cD+ihVQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] gpiolib: Introduce a helper to get first GPIO
 controller node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 9:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Introduce a helper to get first GPIO controller node which drivers
> may want to use.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/gpio/driver.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 12de0b22b4ef..83e2d72e51bb 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -766,4 +766,14 @@ static inline unsigned int gpiochip_node_count(struct device *dev)
>         return count;
>  }
>
> +static inline struct fwnode_handle *gpiochip_node_get_first(struct device *dev)
> +{
> +       struct fwnode_handle *fwnode;
> +
> +       for_each_gpiochip_node(dev, fwnode)
> +               return fwnode;
> +
> +       return NULL;
> +}
> +
>  #endif /* __LINUX_GPIO_DRIVER_H */
> --
> 2.35.1
>

Any chance you could name it get_first_gpiochip_node()? It's static so
we don't have to worry about the prefix and it would make the purpose
more clear.

Bart
