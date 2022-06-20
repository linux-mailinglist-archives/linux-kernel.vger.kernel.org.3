Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9C55264C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbiFTVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiFTVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:14:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B125F0;
        Mon, 20 Jun 2022 14:14:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p5so5452466pjt.2;
        Mon, 20 Jun 2022 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwzY7ZoNzHZiYaOkZYbeMk59nca74GZ7jo+Vq5dW0fA=;
        b=azVvsKHuwAEP/JqQstjln6KsFx9oxCG+uJHophdI4atoKRPRDJm8dSTzgDSemPTcFV
         sLQrRCDvGKNepxmXhH2TuRVKCiVyD6Z8HXd6xEpCXSpT5SK7IcT3ZcbYX4EfaYFYti5q
         CfsI3BgJqeQqk9dQRrjCwle9MtcUnzecbU1cliCbnC3mb0lSwoLExyXFWyJLONsIqiOU
         0wvyyzh6RmbB/3mkgjAhPfA7a3o7iWjGWh/SYqLEIbIBndf4BK4c233xHI/agAyUFz/p
         IL1MyXjw9bEyaYcqagFvU3x3hmfwhiVu34LJDBWKxmZdagQj2hjKPvbiG7eb7ywz73/E
         hDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwzY7ZoNzHZiYaOkZYbeMk59nca74GZ7jo+Vq5dW0fA=;
        b=BUTs3kzaEqCtBBTy1JEbDyNSdrEKo0qf3e73po3xeVMI7ivh0dZEiodBAQcQxzHiEO
         rEePoD/Cb3tMgsSG/+yn1OesXf8O7f7SH0s8WmIYzIwCXWbqrtCtXz6d1vyZDloIVNlR
         CG/WY5LldWMpHL/P3aNKbAG7I4j8xENBXnEln6XMMI6FGvV7L2KaZXY/IqgbUbj75fZw
         rY4EShXlajRfAtn8/t00j/sp7vUXrS9tAIUYFFPySpmAajUf0SuagGlVq0nHfEwNxKbh
         vZkte6NP/6V0SKQzQs7c3fvfDnRWhTis3j2u0y5DYc8jhYtnS2QlekFp0lu6PL6lv/j0
         ZkLQ==
X-Gm-Message-State: AJIora/RJSYxwf0xNamwD11IC0UZOR1EqKLn+Z4rpwJ/irpeZTKO04b6
        BaJYswQbRvErynBSg8cSYi7mOzvzuwLM/b1mO9E=
X-Google-Smtp-Source: AGRyM1t2Ym72rFNRQyWXwqPQ8nzNQCvliioqTL8D7UzG+jUTcTDtmmsl6j+XYxYjZHjkK72fm/HqxzxOwatacFXUaZw=
X-Received: by 2002:a17:903:32c4:b0:163:e765:5071 with SMTP id
 i4-20020a17090332c400b00163e7655071mr25412607plr.153.1655759644403; Mon, 20
 Jun 2022 14:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Jun 2022 18:13:53 -0300
Message-ID: <CAOMZO5CtjkjsbOTaNF7+Hwswsn-fs2WNK=zyFL53JnBBpS8=0Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, May 30, 2022 at 2:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> First of all, the additional conversion from vIRQ, and this is exactly
> what is returned by platform_get_irq_byname(), to vIRQ is not needed.
> Hence, drop no-op call to irq_of_parse_and_map().
>
> Second, assign the firmware node instead of of_node.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index bca79a93cbe4..25292bb8a13f 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -17,7 +17,6 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mxs-lradc.h>
>  #include <linux/module.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>

#include <linux/property.h> needs to be included, otherwise the build fails.

> -               virq = irq_of_parse_and_map(dev->parent->of_node, irq);
> -
> -               ret = devm_request_irq(dev, virq, mxs_lradc_adc_handle_irq,
> +               ret = devm_request_irq(dev, irq, mxs_lradc_adc_handle_irq,
>                                        0, irq_name[i], iio);

I tried to apply the same change inside
drivers/input/touchscreen/mxs-lradc-ts.c:

--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -675,11 +675,9 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
                if (irq < 0)
                        return irq;

-               virq = irq_of_parse_and_map(node, irq);
-
                mxs_lradc_ts_stop(ts);

-               ret = devm_request_irq(dev, virq,
+               ret = devm_request_irq(dev, irq,
                                       mxs_lradc_ts_handle_irq,
                                       0, mxs_lradc_ts_irq_names[i], ts);
                if (ret)

but I still get the following warning:

[    6.135583] ------------[ cut here ]------------
[    6.140366] WARNING: CPU: 0 PID: 1 at drivers/base/platform.c:449
__platform_get_irq_byname+0x74/0x90
[    6.151053] 0 is an invalid IRQ number
[    6.155201] Modules linked in:
[    6.158444] CPU: 0 PID: 1 Comm: swapper Not tainted
5.18.5-00001-g3e38be7e4832 #108
[    6.166537] Hardware name: Freescale MXS (Device Tree)
[    6.172040]  unwind_backtrace from show_stack+0x10/0x14
[    6.177503]  show_stack from __warn+0xc4/0x1cc
[    6.182356]  __warn from warn_slowpath_fmt+0x90/0xc8
[    6.187549]  warn_slowpath_fmt from __platform_get_irq_byname+0x74/0x90
[    6.194698]  __platform_get_irq_byname from platform_get_irq_byname+0x10/0x30
[    6.202286]  platform_get_irq_byname from mxs_lradc_ts_probe+0x19c/0x380
[    6.209216]  mxs_lradc_ts_probe from platform_probe+0x58/0xb8
[    6.215383]  platform_probe from really_probe+0xfc/0x288
[    6.220907]  really_probe from __driver_probe_device+0x80/0xe4
[    6.227145]  __driver_probe_device from driver_probe_device+0x30/0xd8
[    6.234010]  driver_probe_device from __driver_attach+0x70/0xf4
[    6.240137]  __driver_attach from bus_for_each_dev+0x74/0xc0
[    6.246195]  bus_for_each_dev from bus_add_driver+0x154/0x1e8
[    6.252359]  bus_add_driver from driver_register+0x74/0x108
[    6.258131]  driver_register from do_one_initcall+0x8c/0x2fc
[    6.264198]  do_one_initcall from kernel_init_freeable+0x184/0x210
[    6.270588]  kernel_init_freeable from kernel_init+0x10/0x108
[    6.276756]  kernel_init from ret_from_fork+0x14/0x3c
[    6.282224] Exception stack(0xc8819fb0 to 0xc8819ff8)
[    6.287444] 9fa0:                                     00000000
00000000 00000000 00000000
[    6.295988] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    6.304631] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    6.311392] irq event stamp: 128211
[    6.315220] hardirqs last  enabled at (128221): [<c0069c44>]
__up_console_sem+0x54/0x64
[    6.323632] hardirqs last disabled at (128230): [<c0069c30>]
__up_console_sem+0x40/0x64
[    6.331821] softirqs last  enabled at (128200): [<c00098e4>]
__do_softirq+0x31c/0x4bc
[    6.340041] softirqs last disabled at (128191): [<c0020f04>]
irq_exit+0x150/0x18c
[    6.347913] ---[ end trace 0000000000000000 ]---
[    6.364587] input: mxs-lradc-ts as
/devices/soc0/80000000.apb/80040000.apbx/80050000.lradc/mxs-lradc-ts/input/input0

Any suggestions?

Thanks
