Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308FE586013
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiGaRL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaRLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:11:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D410B7EC;
        Sun, 31 Jul 2022 10:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4840B80DA7;
        Sun, 31 Jul 2022 17:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B07C433D6;
        Sun, 31 Jul 2022 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659287511;
        bh=Eyb54P98ZxBTTy/p/CQm64vp3ep0RfhtJzwLsSC1dvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cj6BhG9AGIK886Adot7aslKv2OU9iqtb2a0aWALjbpyyZAbXq7z7fTgH8vp0rwb1/
         zzD88suADqbU9L8WsZOWBZrKEbzRSE3uzpVm1aW5LOmQqpsuSQP9P3e99oa9KjyY8W
         CqWZrPswAd0fXiozh06PAN8lbOla8Gc8HYHe2rXvX/G72/8iHkDzlLNeuzM20QvDJ4
         mllGvQjs9tHfYtzGsqDhjzJrU4z/az0bxfiI7Mhe5BDWK1Xp1oR1G7YK3PqFJc99uW
         A1IN24YEUcmUPszxKe2bjuAAlPI2KWN+O5fXrfnFRDrf2I/ftkmmRHCV2zCnEW6oes
         4xQiQM1kfaLLw==
Date:   Sun, 31 Jul 2022 18:22:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: core: Add support for IIO_AVAIL_LIST_WITH_TYPE
Message-ID: <20220731182204.02459834@jic23-huawei>
In-Reply-To: <20220721191526.374152-3-paul@crapouillou.net>
References: <20220721191526.374152-1-paul@crapouillou.net>
        <20220721191526.374152-3-paul@crapouillou.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 20:15:24 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> The IIO_AVAIL_LIST_WITH_TYPE specifies that the array that corresponds
> to the available values is composed by cells of 3 integers, the first
> two representing the value itself (similar to what you would have with
> IIO_AVAIL_LIST), and the third integer representing the encoding type of
> the value.
> 
> This can be used for instance when a driver's .read_avail() callback
> returns values which cannot be represented with an unique encoding type.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Hi Paul,

Generally looks good to me, but I'm not sure the overflow checks will work
as expected.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 25 +++++++++++++++++++++++++
>  drivers/iio/inkern.c            | 23 +++++++++++++++++++++++
>  include/linux/iio/consumer.h    |  6 ++++--
>  include/linux/iio/types.h       |  1 +
>  4 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index adf054c7a75e..99ced9eab069 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -838,6 +838,29 @@ static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
>  	return iio_format_list(buf, vals, type, 3, "[", "]");
>  }
>  
> +static ssize_t iio_format_avail_list_with_type(char *buf, const int *vals,
> +					       int length)
> +{
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < length; i += 3) {
> +		if (i != 0) {
> +			len += sysfs_emit_at(buf, len, " ");
> +			if (len >= PAGE_SIZE)
I don't think this check will trigger if I read the sysfs_emit_at() docs right.

> +				return -EFBIG;
> +		}
> +
> +		len += __iio_format_value(buf, len, vals[i + 2], 2, &vals[i]);
> +		if (len >= PAGE_SIZE)

Can this trigger?  sysfs_emit_at() inside __iio_format_value() will only return
characters written which I think is none if there isn't space left in the page...

I think the normal thing to do is to just not handle the overflow if it occurs...



> +			return -EFBIG;
> +	}
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
>  static ssize_t iio_read_channel_info_avail(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
> @@ -860,6 +883,8 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
>  		return iio_format_avail_list(buf, vals, type, length);
>  	case IIO_AVAIL_RANGE:
>  		return iio_format_avail_range(buf, vals, type);
> +	case IIO_AVAIL_LIST_WITH_TYPE:
> +		return iio_format_avail_list_with_type(buf, vals, length);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index e8a25852f0df..92d225f1ddd5 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -855,6 +855,29 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  		}
>  		return 0;
>  
> +	case IIO_AVAIL_LIST_WITH_TYPE:
> +		if (length <= 0 || length % 3 != 0)
> +			return -EINVAL;
> +
> +		if (vals[length - 1] != IIO_VAL_INT) {
> +			/* FIXME: learn about max for other iio values */
> +			return -EINVAL;
> +		}
> +
> +		*val = vals[length - 3];
> +		length -= 3;
> +
> +		for (; length; length -= 3) {
> +			if (vals[length - 1] != IIO_VAL_INT) {
> +				/* FIXME: learn about max for other iio values */
> +				return -EINVAL;
> +			}
> +
> +			if (vals[length - 3] > *val)
> +				*val = vals[length - 3];
> +		}
> +		return 0;
> +
>  	default:
>  		return ret;
>  	}
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 5fa5957586cf..99dd12e10fb6 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -309,7 +309,8 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
>   * @vals:		Available values read back.
>   * @length:		Number of entries in vals.
>   *
> - * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
> + * Returns an error code, IIO_AVAIL_RANGE, IIO_AVAIL_LIST or
> + * IIO_AVAIL_LIST_WITH_TYPE.
>   *
>   * For ranges, three vals are always returned; min, step and max.
>   * For lists, all the possible values are enumerated.
> @@ -328,7 +329,8 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
>   * @length:		Number of entries in vals.
>   * @attribute:		info attribute to be read back.
>   *
> - * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
> + * Returns an error code, IIO_AVAIL_RANGE, IIO_AVAIL_LIST or
> + * IIO_AVAIL_LIST_WITH_TYPE.
>   */
>  int iio_read_avail_channel_attribute(struct iio_channel *chan,
>  				     const int **vals, int *type, int *length,
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index a7aa91f3a8dc..9777d1357080 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -32,6 +32,7 @@ enum iio_event_info {
>  enum iio_available_type {
>  	IIO_AVAIL_LIST,
>  	IIO_AVAIL_RANGE,
> +	IIO_AVAIL_LIST_WITH_TYPE,
>  };
>  
>  enum iio_chan_info_enum {

