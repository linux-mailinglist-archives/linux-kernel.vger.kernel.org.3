Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4414586009
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiGaQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGaQ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:57:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD765AB;
        Sun, 31 Jul 2022 09:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F421B80DB2;
        Sun, 31 Jul 2022 16:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B5EC433C1;
        Sun, 31 Jul 2022 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286620;
        bh=C2gjWpdRXKf8H74OuiqBmJfM3oAyddv3Qxyb+Pg+zEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aAd7Z4WkMcGJ0IgdUSaCVJZtQ2fq0bh1txcOGKRFpNj7Irte0y+Z6oF9HfeD/vJSk
         QN7eLhjzDm27y1OKx0PqAV0Aww/tyxbQt2RB84iyRCdrHRJDKdoQstj0LKuPV4I/c1
         SvuDLDGdvxBJ7oWSr8OEFJ8ytDPKiskjURPzOy+w1ZYSWiCJctV45CKgC5Fu30uOAF
         M0qV29DCJJLcJFEuYRvjsJ5Skxb36ZB5pq34vkwK7H7q5bO/gdA9IUVfzoG3JN645a
         jtSggRsOMuYgx6Inr6WHTTwkD8xT6ID0qUUIIhuwez8f2jfcJnt18iMoEVjPXON1Lq
         q6ESDOWXVkRsQ==
Date:   Sun, 31 Jul 2022 18:07:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: inkern: Remove useless argument to
 iio_channel_read_max()
Message-ID: <20220731180713.48349570@jic23-huawei>
In-Reply-To: <20220721191526.374152-2-paul@crapouillou.net>
References: <20220721191526.374152-1-paul@crapouillou.net>
        <20220721191526.374152-2-paul@crapouillou.net>
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

On Thu, 21 Jul 2022 20:15:23 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> The 'type' argument was passed by the only caller of the
> iio_channel_read_max() function as a pointer to return an extra value,
> but the value of the variable passed by the caller was never read
> afterwards.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Curious. I'm playing guess the intent here and I suspect that what
we should really be doing is checking type in 
iio_read_max_channel_raw() and returning an error if it is not IIO_VAL_INT
(can only get there for IIO_AVAIL_RANGE currently as there is a FIXME for
 IIO_AVAIL_LIST for non IIO_VAL_INT types)

I'm not sure we've ever documented that _RAW can't be non integer even if
that makes relatively little sense most of the time..

Jonathan

> ---
>  drivers/iio/inkern.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index df74765d33dc..e8a25852f0df 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -813,21 +813,22 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
>  EXPORT_SYMBOL_GPL(iio_read_avail_channel_raw);
>  
>  static int iio_channel_read_max(struct iio_channel *chan,
> -				int *val, int *val2, int *type,
> +				int *val, int *val2,
>  				enum iio_chan_info_enum info)
>  {
>  	int unused;
>  	const int *vals;
>  	int length;
>  	int ret;
> +	int type;
>  
>  	if (!val2)
>  		val2 = &unused;
>  
> -	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
> +	ret = iio_channel_read_avail(chan, &vals, &type, &length, info);
>  	switch (ret) {
>  	case IIO_AVAIL_RANGE:
> -		switch (*type) {
> +		switch (type) {
>  		case IIO_VAL_INT:
>  			*val = vals[2];
>  			break;
> @@ -840,7 +841,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  	case IIO_AVAIL_LIST:
>  		if (length <= 0)
>  			return -EINVAL;
> -		switch (*type) {
> +		switch (type) {
>  		case IIO_VAL_INT:
>  			*val = vals[--length];
>  			while (length) {
> @@ -863,7 +864,6 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>  	int ret;
> -	int type;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
>  	if (!chan->indio_dev->info) {
> @@ -871,7 +871,7 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
>  		goto err_unlock;
>  	}
>  
> -	ret = iio_channel_read_max(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
> +	ret = iio_channel_read_max(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  err_unlock:
>  	mutex_unlock(&iio_dev_opaque->info_exist_lock);
>  

