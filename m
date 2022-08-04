Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1862589B8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiHDMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiHDMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:18:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D71B2A731;
        Thu,  4 Aug 2022 05:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10ED9B8252E;
        Thu,  4 Aug 2022 12:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4E3C43140;
        Thu,  4 Aug 2022 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659615505;
        bh=VPy4gOhLAIpcEpCpUQviQR/3l5W+JOweTJEO9bhx0MM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sBCR6LBGmB88ZHFVlbP1xV3YYJDnOXIY2oBtZF9ENc9QRCvsVI0f0vpi9nbNmbeJc
         WTIhRsZIbjakfGYlAS+/7nrvT/FAe+PycOjJicMf0+VmbnCtDz0bqn9UfQ4E7GTSxT
         yR2Xsd1COT1p6uvqMuJlpynT2jEVzLRFzZetLN7cM0Ni9vExvHUjaZRcY/uQ4gpvJm
         2vHhKke/Gx1Lok4j+c66Guq6F7+5Upcw6z/beeaaUwriYO67nq0Zfbe/LB46nOp0hK
         JKjzt1FEQwd771WpQ3hl8OUiujdOujIC0HbYSuvwZ6WIVKScfoiM3/P0gcH9NMWMlZ
         L6cLSNmWvFffQ==
Received: by mail-vk1-f175.google.com with SMTP id l13so5968233vka.12;
        Thu, 04 Aug 2022 05:18:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo1IcaRAjExtewGNK7QJi42UBgSiX9N7rDk9FO4V34NlQcMheSrp
        ARPF6H7qZ9eTLmIdQwjntyYhu2Fp3xMlILsfmQ==
X-Google-Smtp-Source: AA6agR6r3Gwd/3cMDJKLUspCXNMYclDrolN1aI8mXCLLEHHB0WH8YkK47F3HReZYbVrZbg4WFEluJ4z1fiMkfoy/SPQ=
X-Received: by 2002:ac5:c959:0:b0:377:adad:62cb with SMTP id
 s25-20020ac5c959000000b00377adad62cbmr608849vkm.26.1659615504466; Thu, 04 Aug
 2022 05:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220804061133.4110734-1-victor.liu@nxp.com> <20220804061133.4110734-2-victor.liu@nxp.com>
In-Reply-To: <20220804061133.4110734-2-victor.liu@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 4 Aug 2022 06:18:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+B5PMOmZO4hz5DyEsA4V=UkrNn-6b58h8VbcPa2iaQ1g@mail.gmail.com>
Message-ID: <CAL_Jsq+B5PMOmZO4hz5DyEsA4V=UkrNn-6b58h8VbcPa2iaQ1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drivers: bus: simple-pm-bus: Populate simple MFD
 child devices
To:     Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 12:10 AM Liu Ying <victor.liu@nxp.com> wrote:
>
> There could be simple MFD device(s) connected to a simple PM bus as child
> node(s), like Freescale i.MX8qxp pixel link MSI bus. Add a child match
> table as an argument to of_platform_populate() function call to specify
> the simple MFD devices so that they can be populated.

There could be a simple-bus under it as well. You should just use
of_platform_default_populate() instead.

>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v3:
> * No change.
>
>  drivers/bus/simple-pm-bus.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index 6b8d6257ed8a..ff5f8ca5c024 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -13,6 +13,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>
> +static const struct of_device_id simple_pm_bus_child_matches[] = {
> +       { .compatible = "simple-mfd", },
> +       {}
> +};
> +
>  static int simple_pm_bus_probe(struct platform_device *pdev)
>  {
>         const struct device *dev = &pdev->dev;
> @@ -49,7 +54,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
>         pm_runtime_enable(&pdev->dev);
>
>         if (np)
> -               of_platform_populate(np, NULL, lookup, &pdev->dev);
> +               of_platform_populate(np, simple_pm_bus_child_matches, lookup, &pdev->dev);
>
>         return 0;
>  }
> --
> 2.25.1
>
