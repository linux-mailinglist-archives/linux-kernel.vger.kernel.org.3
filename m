Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8A56ACF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiGGUvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiGGUvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:51:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA652CE06;
        Thu,  7 Jul 2022 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=TTdDoMIncBueyDVjmYEyIZn/enGMqk78p+ra2MsjS+w=; b=sE7/kRbdlSv7EDNBiYq9turMip
        Y8jFHim2VJqGyNd6kV+yyl+ghqx0wWjY1oAiKWWvg1OEtRazc2fwps6uBk2W/rAY6QjFvLj3AdcQK
        NjzHVTWhmxPc8gfHjR0GL/zj+HVMZ1CmupVS4UZZqcjbz8BNmmW8+/IvXVqDA36+u3l3XcpEFhFSQ
        TWPZ0amSSofhK9YDY4uV5jWZHbMQjPj+zWVwcLWCoEupQm21QzaYFo6WKR5PF7M4AdVOVKeBkAytS
        btzrXPQ2hDd3Km43Qd42cgGLAXZBmv2WuEUPASG78hGx1ea8ym3uKyTgvrtiaQEfTl5URkscMo0KZ
        Pud0lScw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9YSz-000B7y-VT; Thu, 07 Jul 2022 20:51:18 +0000
Message-ID: <a2984435-6c8f-aee2-1e42-efc0b7cc4078@infradead.org>
Date:   Thu, 7 Jul 2022 13:51:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/6] HID: add spi-hid, transport driver for HID over
 SPI bus
Content-Language: en-US
To:     Jarrett Schultz <jaschultzms@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Antipov <dmanti@microsoft.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
References: <20220707165902.3184-1-jaschultzMS@gmail.com>
 <20220707165902.3184-6-jaschultzMS@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220707165902.3184-6-jaschultzMS@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/7/22 09:59, Jarrett Schultz wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> This driver follows HID Over SPI Protocol Specification 1.0 available at
> https://www.microsoft.com/en-us/download/details.aspx?id=103325. The
> initial version of the driver does not support: 1) multi-fragment input
> reports, 2) sending GET_INPUT and COMMAND output report types and
> processing their respective acknowledge input reports, and 3) device
> sleep power state.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>

Missing your (Jarrett's) Signed-off-by: here.

More below...

> ---
>  drivers/hid/Kconfig                 |    2 +
>  drivers/hid/Makefile                |    1 +
>  drivers/hid/spi-hid/Kconfig         |   25 +
>  drivers/hid/spi-hid/Makefile        |   12 +
>  drivers/hid/spi-hid/spi-hid-core.c  | 1326 +++++++++++++++++++++++++++
>  drivers/hid/spi-hid/spi-hid-core.h  |  188 ++++
>  drivers/hid/spi-hid/spi-hid-of.c    |  141 +++
>  drivers/hid/spi-hid/spi-hid-of.h    |   30 +
>  drivers/hid/spi-hid/spi-hid_trace.h |  194 ++++
>  drivers/hid/spi-hid/trace.c         |    9 +
>  10 files changed, 1928 insertions(+)
>  create mode 100644 drivers/hid/spi-hid/Kconfig
>  create mode 100644 drivers/hid/spi-hid/Makefile
>  create mode 100644 drivers/hid/spi-hid/spi-hid-core.c
>  create mode 100644 drivers/hid/spi-hid/spi-hid-core.h
>  create mode 100644 drivers/hid/spi-hid/spi-hid-of.c
>  create mode 100644 drivers/hid/spi-hid/spi-hid-of.h
>  create mode 100644 drivers/hid/spi-hid/spi-hid_trace.h
>  create mode 100644 drivers/hid/spi-hid/trace.c
> 

> diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
> new file mode 100644
> index 000000000000..37302d658162
> --- /dev/null
> +++ b/drivers/hid/spi-hid/Kconfig
> @@ -0,0 +1,25 @@
> +#
> +# Copyright (c) 2021 Microsoft Corporation
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms of the GNU General Public License version 2 as published by
> +# the Free Software Foundation.
> +#

Please just use SPDX tags instead of all of that.
See other hid/Kconfig files for examples.

> +menu "SPI HID support"
> +	depends on SPI
> +
> +config SPI_HID
> +	tristate "HID over SPI transport layer"
> +	default n
> +	depends on SPI && INPUT && OF
> +	select HID
> +	help
> +	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
> +	  other HID based devices which is connected to your computer via SPI.

	        HID-based devices which are connected
(or)
	        HID-based device which is connected

> +
> +	  If unsure, say N.
> +
> +	  This support is also available as a module.  If so, the module
> +	  will be called spi-hid.
> +
> +endmenu

-- 
~Randy
