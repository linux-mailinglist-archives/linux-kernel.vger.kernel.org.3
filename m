Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F89D477AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhLPRbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:31:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34500 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhLPRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:31:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B0EF61ECD;
        Thu, 16 Dec 2021 17:31:36 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 4364FC36AE4;
        Thu, 16 Dec 2021 17:31:34 +0000 (UTC)
Date:   Thu, 16 Dec 2021 17:36:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] iio:filter:admv8818: add support for ADMV8818
Message-ID: <20211216173658.4b0d3c6d@jic23-huawei>
In-Reply-To: <20211207155445.247444-2-antoniu.miclaus@analog.com>
References: <20211207155445.247444-1-antoniu.miclaus@analog.com>
        <20211207155445.247444-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 17:54:43 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV8818-EP is a fully monolithic microwave integrated
> circuit (MMIC) that features a digitally selectable frequency of
> operation. The device features four independently controlled high-
> pass filters (HPFs) and four independently controlled low-pass
> filters (LPFs) that span the 2 GHz to 18 GHz frequency range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/admv8818-ep.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Some trivial stuff with headers below, I've tidied up whilst applying.

Thanks,

Jonathan

> ---
>  drivers/iio/filter/Kconfig    |  10 +
>  drivers/iio/filter/Makefile   |   1 +
>  drivers/iio/filter/admv8818.c | 668 ++++++++++++++++++++++++++++++++++
>  3 files changed, 679 insertions(+)
>  create mode 100644 drivers/iio/filter/admv8818.c
> 
> diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
> index e268bba43852..3ae35817ad82 100644
> --- a/drivers/iio/filter/Kconfig
> +++ b/drivers/iio/filter/Kconfig
> @@ -5,4 +5,14 @@
>  
>  menu "Filters"
>  
> +config ADMV8818
> +	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass Filter"
> +	depends on SPI && COMMON_CLK && 64BIT
> +	help
> +	  Say yes here to build support for Analog Devices ADMV8818
> +	  2 GHz to 18 GHz, Digitally Tunable, High-Pass and Low-Pass Filter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  modiule will be called admv8818.
> +
>  endmenu
> diff --git a/drivers/iio/filter/Makefile b/drivers/iio/filter/Makefile
> index cc0892c01142..55e228c0dd20 100644
> --- a/drivers/iio/filter/Makefile
> +++ b/drivers/iio/filter/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ADMV8818) += admv8818.o
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> new file mode 100644
> index 000000000000..52eaeed0209d
> --- /dev/null
> +++ b/drivers/iio/filter/admv8818.c
> @@ -0,0 +1,668 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV8818 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>

As with previous driver this seems like a lot of headers for
a simple consumer of clocks.
I'll drop all but clkdev whilst applying.

> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/sysfs.h>

iwyu also spotted this isn't used.

> +#include <linux/units.h>
> +

