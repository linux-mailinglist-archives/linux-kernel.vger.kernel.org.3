Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D054CC6A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiCCT7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiCCT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:59:23 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF291F68DA;
        Thu,  3 Mar 2022 11:58:36 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id bt13so12541467ybb.2;
        Thu, 03 Mar 2022 11:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjBP9R5sSBRCjbqotPuBU59YCmOLVJ0MXeepARz8oD4=;
        b=V/smNpGsI0+UZVnl3kGV8QXrCILPzUCTozdrCGW5BV1XB9t2mbO7YgYkDgdJOr/uQe
         gozWbktjOQSli7ne3ffVkxr4NdbK4ctkyWTT01MPpqkVvnE5xKwRbcqB9ZeGrszG1AEK
         4DqnMTALauS56Q2tYWXc0mZ2WqvKG05qOIzpr5VRkYMPh5Ex/pJgkPRMgz6oQJUdNgFw
         oBkWTPHR4R5/rIwjMe5yKCeIoe9USTIMTlEPBuCtuAuqVAmpNeLJGWrwI2TM7Uh6iBPY
         nZs6YNzBy3/SJaTcB2lasQJcU02hRh4BmWZi3TIqpiBE4RbTLl5THVEhB4iZLs8S0hFY
         ps8w==
X-Gm-Message-State: AOAM5324zFYgn5lKDZzRnvZ9rKdDaBF5QZ/pvdXz3baJ2W+ClFtW6jL5
        bnO78Itqcjiytl8591OkPy8ZuN6lLU8xQInizcw=
X-Google-Smtp-Source: ABdhPJy69ncq5Im8YOiTxphflVK10P7CEA+c49Q/8seTr19kjc9+9V/j2pyHi+8QAnbezgGR1Immb/MRT5YcuqB19vI=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr12746549yba.633.1646337515899; Thu, 03
 Mar 2022 11:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Mar 2022 20:58:25 +0100
Message-ID: <CAJZ5v0hsdRxnHs-1ra14ZQU6gmAiisS=Jc7Hpkkr-vZuWuOiww@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] ACPI: enumeration: Discourage to use custom _DSM methods
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Mon, Feb 28, 2022 at 11:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since we have _DSD established and specified (ACPI v5.1+) there is no
> need to use custom _DSM methods. Rewrite documentation to use _DSD.
>
> Fixes: f60e7074902a ("misc: at25: Make use of device property API")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../firmware-guide/acpi/enumeration.rst       | 48 ++++++++-----------
>  1 file changed, 21 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index d0022567c022..3b221cc9ff5f 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -227,43 +227,37 @@ to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
>         };
>
>  Note that this driver actually needs more information like page size of the
> -eeprom etc. but at the time writing this there is no standard way of
> -passing those. One idea is to return this in _DSM method like::
> +eeprom, etc. This information can be passed via _DSD method like::
>
>         Device (EEP0)
>         {
>                 ...
> -               Method (_DSM, 4, NotSerialized)
> +               Name (_DSD, Package ()
>                 {
> -                       Store (Package (6)
> +                       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                       Package ()
>                         {
> -                               "byte-len", 1024,
> -                               "addr-mode", 2,
> -                               "page-size, 32
> -                       }, Local0)
> -
> -                       // Check UUIDs etc.
> -
> -                       Return (Local0)
> -               }
> -
> -Then the at25 SPI driver can get this configuration by calling _DSM on its
> -ACPI handle like::
> -
> -       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> -       struct acpi_object_list input;
> -       acpi_status status;
> +                               Package () { "size", 1024 },
> +                               Package () { "pagesize", 32 },
> +                               Package () { "address-width", 16 },
> +                       }
> +               })
> +       }
>
> -       /* Fill in the input buffer */
> +Then the at25 SPI driver can get this configuration by calling device property
> +APIs during ->probe() phase like::
>
> -       status = acpi_evaluate_object(ACPI_HANDLE(&spi->dev), "_DSM",
> -                                     &input, &output);
> -       if (ACPI_FAILURE(status))
> -               /* Handle the error */
> +       err = device_property_read_u32(dev, "size", &size);
> +       if (err)
> +               ...error handling...
>
> -       /* Extract the data here */
> +       err = device_property_read_u32(dev, "pagesize", &page_size);
> +       if (err)
> +               ...error handling...
>
> -       kfree(output.pointer);
> +       err = device_property_read_u32(dev, "address-width", &addr_width);
> +       if (err)
> +               ...error handling...
>
>  I2C serial bus support
>  ======================
> --

Applied as 5.18 material along with the rest of the series, but I
dropped the first hunk in patch [6/7] which didn't apply.

Thanks!
