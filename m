Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F95637F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiGAQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGAQal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:30:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8133135F;
        Fri,  1 Jul 2022 09:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4974CB830A5;
        Fri,  1 Jul 2022 16:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B34BC341C8;
        Fri,  1 Jul 2022 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693038;
        bh=cFeQkiG6enetQ6lbFo12SK/2ylH3uFnDMr/9MeqML0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XNWHpi7MFAkm4mdgV4xFKVo2xXjl0NAzm0m8df8TA+N11Tlt8ttCaB4enNU7lMFUM
         enBDfzX59pC7zHhnyBgAiFT00+uYqhQIk95HAPtQYH4wL/H1N3I6RTP77pUYjlSGwJ
         SeI8lI4g4Zc9XAZxvIiVNnsDpz9v9by7jv0ScRbWjLeUZoxMcKu81o0Jc2ZzvuYwU3
         8GROYo9reHT+jCoa/LdRlgzZSXOlOOnWiePTDhcobXIY/PUFc/mQov2XdDM5/gfdz1
         KJxB9hUIQz67exTNY9be8/Q0i7ViyA0QGF4pT7CBVc0lO1tiBfPHPy4A1lPxlR0EB+
         RnMt23iSHdO8g==
Date:   Fri, 1 Jul 2022 17:40:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Florian Eckert <fe@dev.tdt.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <20220701174011.14d17f43@jic23-huawei>
In-Reply-To: <20220701042919.18180-3-nm@ti.com>
References: <20220701042919.18180-1-nm@ti.com>
        <20220701042919.18180-3-nm@ti.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 23:29:19 -0500
Nishanth Menon <nm@ti.com> wrote:

> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12bit data, of which the LSB
> bits are transmitted by the lower resolution devices as 0. We don't need
> to mess with ADC108S102_BITS as a result for the lower resolution
> devices.

whilst not strictly necessary I would prefer we did as it may reduce
storage requirements, computation complexity etc for userspace (particularly
if they are 8 bits).

Would affect scale and shift so slightly more complex, but not a lot
so still a fairly simple change.  Just add resolution to your config
structure and duplicate it where necessary to allow whatever resolutions
we support.

> 
> I have been able to test adc102s051, hence adding just the missing
> ones in that family.
> 
> Lets reuse the driver to support the family of devices with name
> ADC<bb><c>S<sss>, where
> * bb is the resolution in number of bits (8, 10, 12)
> * c is the number of channels (1, 2, 4, 8)
> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
>   and 101 for 1 MSPS)
> 
> Complete datasheets are available at TI's website here:
>   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> 
> Also see: drivers/hwmon/adcxx.c
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> This does add on additional sparse warnings around casting .data value
> to const from int for the of_match_table, and a bunch around the .cls
> field for acpi_device_id - maybe someone could suggest a smarter way to
> fix those.
> 
> Applies after https://lore.kernel.org/linux-iio/20220630230107.13438-1-nm@ti.com/
> 
>  drivers/iio/adc/ti-adc128s052.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 21a7764cbb93..0a3aab4df60e 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -7,6 +7,20 @@
>   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> + *
> + * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> + * interface. This driver supports the whole family of devices with name
> + * ADC<bb><c>S<sss>, where
> + * bb is the resolution in number of bits (8, 10, 12)
> + * c is the number of channels (1, 2, 4, 8)
> + * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> + * and 101 for 1 MSPS)
> + *
> + * Complete datasheets are available at TI's website here:
> + *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> + *
> + * Handling of 8, 10 and 12 bits converters are the same, the
> + * unavailable bits are 0 in LSB :)
>   */
>  
>  #include <linux/acpi.h>
> @@ -185,6 +199,12 @@ static const struct of_device_id adc128_of_match[] = {
>  	{ .compatible = "ti,adc122s021", .data = 1},
>  	{ .compatible = "ti,adc122s051", .data = 1},
>  	{ .compatible = "ti,adc122s101", .data = 1},
> +	{ .compatible = "ti,adc102s021", .data = 1},
> +	{ .compatible = "ti,adc102s051", .data = 1},
> +	{ .compatible = "ti,adc102s101", .data = 1},

Numeric order preferred. Not sure why these are in the middle.

> +	{ .compatible = "ti,adc082s021", .data = 1},
> +	{ .compatible = "ti,adc082s051", .data = 1},
> +	{ .compatible = "ti,adc082s101", .data = 1},

Andy's comment on using pointers instead follows through to here.
To describe the channels more fully you'll need additional
_config[] structures.


>  	{ .compatible = "ti,adc124s021", .data = 2},
>  	{ .compatible = "ti,adc124s051", .data = 2},
>  	{ .compatible = "ti,adc124s101", .data = 2},
> @@ -197,6 +217,12 @@ static const struct spi_device_id adc128_id[] = {
>  	{ "adc122s021",	1 },
>  	{ "adc122s051",	1 },
>  	{ "adc122s101",	1 },
> +	{ "adc102s021",	1 },
> +	{ "adc102s051",	1 },
> +	{ "adc102s101",	1 },
> +	{ "adc082s021",	1 },
> +	{ "adc082s051",	1 },
> +	{ "adc082s101",	1 },
>  	{ "adc124s021", 2 },
>  	{ "adc124s051", 2 },
>  	{ "adc124s101", 2 },

