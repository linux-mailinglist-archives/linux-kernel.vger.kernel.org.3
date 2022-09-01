Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3B5A9E71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiIARsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiIARsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:48:14 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5D1D0DF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:48:13 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cv7so11510037qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XxzGcZxEvn6lqn3S+ejnJxVLBGgsRsaccRc4Cve+wRs=;
        b=eX+c4tvw+WP34P9+Oh9i7JI4DrcHsssLX1AvxveMSyuN7PeNb6jogtV+DB1Y1RUnx/
         ESMV3E/e1BKYQmnOIFBrB5oKGfevKZyyY/gw0nsWkh/TbVvDnXY6WT8cjvMw6DAY1NAy
         aLiUawpXGB5/QTab5VA/SAVvBjrjiOb064t/RmDy3xtm7HE85VaP95IWlkkPJTDvoheg
         fDoKUXFFZJ/PTE2vHHaw24TRhIl70y0DSnVs7C0U72n6SeEgQSMu2y9ScwCzH9UC6fQG
         nrNk/P3AYp6F8OM7kGikbrk9hi9Rn6H5PhF2S3CNC/JGMlkC/ch/K/iCB7QcoFR2t/EY
         8B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XxzGcZxEvn6lqn3S+ejnJxVLBGgsRsaccRc4Cve+wRs=;
        b=e6/lmXjdSGqMS0kZvAicQd1DRQNVwSlEJcZib4SwL2J3GeV3zb3kWgUCVMdA3RsoMM
         fZZ/wfNBlnOxVOwAfm9aPZF//vzi9LC+m8eUIpWiTpF+FNFGxCl6fvfRRv8iZi86oPyC
         y6V/anUJ5FmZ2IRLWPs7Ch+2Q0suPcr2PbEXlScyqMK0rbMgWskjh79OiJt8apb9UAru
         J1dYcziCPJoq/iuh2ut2RmU++Y2MDy4MrdET9cPYcdP/xZnQ/aD4fQasEuX76FuCnOai
         GHSszPk5sypZojuztl6fMS0h+P28YB8GcKwi7oSUS/NsHu/us3VX3CWgvueVsWxeMO96
         1gDg==
X-Gm-Message-State: ACgBeo3XwCHJvHjbxAY3I0mCgeGwykkGfECe4YCJYFmOeoRhPktMRsPM
        YHe/WSyy7XHwRWrPTBKOK4jEwAVKjUD4H8Ke4L9gu3v/3MA=
X-Google-Smtp-Source: AA6agR5W6544mL7LWhnEioeV9p9alWGGjlSQTDFcYNtuZrEzZjzNO9Xin13cgi9cinfMtgiZlyMHCL4An3SJpU2YsoI=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr16365873qvb.82.1662054492332; Thu, 01
 Sep 2022 10:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <1662030871-182688-1-git-send-email-john.garry@huawei.com> <1662030871-182688-6-git-send-email-john.garry@huawei.com>
In-Reply-To: <1662030871-182688-6-git-send-email-john.garry@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 20:47:36 +0300
Message-ID: <CAHp75Vcg79sZjv24DD3ZhYf9aC-zoEZ59gfagS1Jw1-GYhpQug@mail.gmail.com>
Subject: Re: [PATCH 5/5] bus: hisi_lpc: Use platform_device_register_full()
To:     John Garry <john.garry@huawei.com>
Cc:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Thu, Sep 1, 2022 at 2:37 PM John Garry <john.garry@huawei.com> wrote:
>
> The code to create the child platform device is essentially the same as
> what platform_device_register_full() does, so change over to use
> that same function to reduce duplication.

Thanks!

>  drivers/bus/hisi_lpc.c | 70 ++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 34 deletions(-)

Looking at the statistics I thought it was a scary "improvement", but...

...

>                 /* ipmi */
>                 {
>                         .hid = "IPI0001",
> -                       .name = "hisi-lpc-ipmi",
> +                       .pdevinfo = (struct platform_device_info []) {
> +                               {
> +                                       .parent = hostdev,
> +                                       .fwnode = acpi_fwnode_handle(child),
> +
> +                                       .name = "hisi-lpc-ipmi",
> +                                       .id = PLATFORM_DEVID_AUTO,
> +
> +                                       .res = res,
> +                                       .num_res = num_res,
> +                               },

...here and in the other cases you have a lot of blank lines, can we
just get rid of them?

> +                       },
>                 },
>                 /* 8250-compatible uart */
>                 {
>                         .hid = "HISI1031",
> -                       .name = "serial8250",
> -                       .pdata = (struct plat_serial8250_port []) {
> +                       .pdevinfo = (struct platform_device_info []) {
>                                 {
> -                                       .iobase = res->start,
> -                                       .uartclk = 1843200,
> -                                       .iotype = UPIO_PORT,
> -                                       .flags = UPF_BOOT_AUTOCONF,
> +                                       .parent = hostdev,
> +                                       .fwnode = acpi_fwnode_handle(child),
> +
> +                                       .name = "serial8250",
> +                                       .id = PLATFORM_DEVID_AUTO,
> +
> +                                       .res = res,
> +                                       .num_res = num_res,
> +
> +                                       .data = (struct plat_serial8250_port []) {
> +                                               {
> +                                                       .iobase = res->start,
> +                                                       .uartclk = 1843200,
> +                                                       .iotype = UPIO_PORT,
> +                                                       .flags = UPF_BOOT_AUTOCONF,
> +                                               },
> +                                               {}
> +                                       },

> +                                       .size_data =  2 *
> +                                               sizeof(struct plat_serial8250_port),

I believe this can be one line.

>                                 },
>                         },

-- 
With Best Regards,
Andy Shevchenko
