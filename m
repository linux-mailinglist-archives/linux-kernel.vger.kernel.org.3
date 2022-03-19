Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A354DE933
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiCSQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiCSQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:05:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43731D2532;
        Sat, 19 Mar 2022 09:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7307FB80D77;
        Sat, 19 Mar 2022 16:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45679C340EC;
        Sat, 19 Mar 2022 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647705851;
        bh=aBAvLOR8rDN70mh20uxHrqjsroR6gpSJwnuy4ZCVi0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ArMOBI7g2kqxYWB68e590jwwf5oXoYoYNe3T/u7qXxHoLaBFIXUxF4soI3rkjQFTY
         xj9YKzXE6ellrF7kcfdNE7UTRe2Da+9lHyRKwFUG6DKwSz+E8q4fnZODUTYGU2R7jA
         c+s+6EP6xJvVoHjmKzzne7M9ei7zZ4DZyxizZHzuTMdZjHC9KTpQ6BIhDPtwi9W9fn
         mdoSoB3vzmg2ZPgjXwB6x2Aw5Gqs/cOmA8o6OTUiDIFyjxv1NJmd59B65nFjIEuWIK
         iLRJ4LW7xoCqMNBBdQA6da1prK3O0xdD6VqR1rX9q0KZfuOjWY8PRT6/4TtudAgvsg
         3iNVaKOE8Og8w==
Date:   Sat, 19 Mar 2022 16:11:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] iio: adc: ad7192: add sequencer support
Message-ID: <20220319161135.5c7153e7@jic23-huawei>
In-Reply-To: <20220318162722.51215-7-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
        <20220318162722.51215-7-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:27:20 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add sequencer support for AD7192.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index adff6472e075..e59753c61274 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -58,7 +58,8 @@
>  /* Mode Register Bit Designations (AD7192_REG_MODE) */
>  #define AD7192_MODE_SEL(x)	(((x) & 0x7) << 21) /* Operation Mode Select */
>  #define AD7192_MODE_SEL_MASK	(0x7 << 21) /* Operation Mode Select Mask */
> -#define AD7192_MODE_DAT_STA	BIT(20) /* Status Register transmission */
> +#define AD7192_MODE_STA(x)	(((x) & 0x1) << 20) /* Status Register transmission */
> +#define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
>  #define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
>  #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
>  #define AD7192_MODE_ACX		BIT(14) /* AC excitation enable(AD7195 only)*/
> @@ -288,12 +289,25 @@ static int ad7192_set_mode(struct ad_sigma_delta *sd,
>  	return ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
>  }
>  
> +static int ad7192_append_status(struct ad_sigma_delta *sd, bool append)
> +{
> +	struct ad7192_state *st = ad_sigma_delta_to_ad7192(sd);
> +
> +	st->mode &= ~AD7192_MODE_STA_MASK;
> +	st->mode |= AD7192_MODE_STA(append);
> +
Another case where I would prefer the state cache be updated after the write
succeeds unless there is some reason that doesn't make sense.

+ Swash patch 8 into this one so we don't leave a broken driver inbetween.

Thanks,

Jonathan

> +	return ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +}
> +
>  static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
>  	.set_channel = ad7192_set_channel,
> +	.append_status = ad7192_append_status,
>  	.set_mode = ad7192_set_mode,
>  	.has_registers = true,
>  	.addr_shift = 3,
>  	.read_mask = BIT(6),
> +	.status_ch_mask = GENMASK(3, 0),
> +	.num_slots = 4,
>  	.irq_flags = IRQF_TRIGGER_FALLING,
>  };
>  

