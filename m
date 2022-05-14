Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A525272B8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiENPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiENPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72BFC5;
        Sat, 14 May 2022 08:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E3960FDF;
        Sat, 14 May 2022 15:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF1C340EE;
        Sat, 14 May 2022 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652543076;
        bh=mv7fBW28LBGQjB6TNE8qE4Q+PHMJWnlAXHOAlsOBxTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eXDIqw7HUdccXhBDLlUkU/FepEM2ogrz6qKGSgzjLWwIVZJohm5OmR8eo46hvCrK+
         PDEf0q1Q8/0dqExDB7LZk0eCrHu2vEDUDVGE0uhGtgCGqs6AYj5wiSjDTd4/kEOJ30
         uP8Tzqy7n4+5p2nBkpOIWP08Ml8g6OCEQI0dHcx148Ea21NGm1zlwRIN0uFg6R/Pao
         k5PZ1Ai4oMTv2TlsIdmgGUy0z3OteoqDV+aS+lXrExXuIs51q8S/SsOXn287J+1brE
         xxMkqI9XRqyAnh+JfuiapPrEd2NkbQ/5Tk+BufxeDnRF6ejvxczZdzH+x53wPbvYcZ
         JYxLfNVsUfTqA==
Date:   Sat, 14 May 2022 16:53:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 05/22] iio: replace bitmap_weight with
 bitmap_weitght_{eq,le} where appropriate
Message-ID: <20220514165309.7445c767@jic23-huawei>
In-Reply-To: <20220510154750.212913-6-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
        <20220510154750.212913-6-yury.norov@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 08:47:33 -0700
Yury Norov <yury.norov@gmail.com> wrote:

> bitmap_weight_{eq,le} is better than bitmap_weight because it
> may return earlier.
> 
> CC: Jonathan Cameron <jic23@kernel.org>
> CC: Lars-Peter Clausen <lars@metafoo.de>
> CC: Michael Hennerich <Michael.Hennerich@analog.com>
> CC: linux-iio@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
without being cc'd on the cover letter, there is no obvious way for
me to know this is reliant in some series to be found in next.

Please call out the exact dependency and whilst it's a long list,
it is good to cc all people cc'd on individual patches also
on the cover letter so they have that background information.

Change seems fine, but I've no idea when/if to pick it up because of
that lack of information.

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c  | 2 +-
>  drivers/iio/industrialio-buffer.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 261a9a6b45e1..6445b591f071 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -525,7 +525,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned l
>  {
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  
> -	return bitmap_weight(mask, indio_dev->masklength) <= sigma_delta->num_slots;
> +	return bitmap_weight_le(mask, indio_dev->masklength, sigma_delta->num_slots);
>  }
>  
>  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 06141ca27e1f..18d3d756aee1 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1824,7 +1824,7 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>  	const unsigned long *mask)
>  {
> -	return bitmap_weight(mask, indio_dev->masklength) == 1;
> +	return bitmap_weight_eq(mask, indio_dev->masklength, 1);
>  }
>  EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
>  

