Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86859A455
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350863AbiHSR4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354002AbiHSR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC65E117C;
        Fri, 19 Aug 2022 10:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7639617D8;
        Fri, 19 Aug 2022 17:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE7C433C1;
        Fri, 19 Aug 2022 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660930724;
        bh=OKpgMPnKr9d9cTKpfOdmcjkXXNEfExuYIhIkIm7K3RQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uixDXXWkvtEq9Gd/b2RZf6otlbMU4JEP/iz6Ag940SJHlUdBVfDY0VH5ysVrdmg+L
         zx4mu+vd7OTagl1pX06kbIqOG6r94+Rep+EBnNNhUEaIq7YpP3kJPGNFCDv1B6qO6F
         zKu+LVkcpyxVXINVvt3c9M2c5hOIS/S+i2gqYefwgF+X1alSoQl16XqNGxrYZfYq18
         1zCf9Qdz5aCCOlrWUscIXFo7hIYXz4h+5YZDPRMuT1xg5yr41DTzb1ETVaoEhcZ0Lw
         cJ8qz3H20ycCUoL1odKIeaSC0e1MDB1c78CTX7JtGaIR0tBXtpDLi/nbD/U4KgVGgI
         R/SwKz7rl06Ng==
Date:   Fri, 19 Aug 2022 18:49:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: add helper function for reading channel offset
 in buffer
Message-ID: <20220819184919.6e08ae06@jic23-huawei>
In-Reply-To: <20220817105643.95710-4-contact@artur-rojek.eu>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
        <20220817105643.95710-4-contact@artur-rojek.eu>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 12:56:42 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> This is useful for consumers that wish to parse raw buffer data.
> 
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/iio/industrialio-buffer.c | 28 ++++++++++++++++++++++++++++
>  include/linux/iio/buffer.h        |  4 ++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 228598b82a2f..cf23736610d9 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -691,6 +691,34 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
>  	return bytes;
>  }
>  
> +int iio_find_channel_offset_in_buffer(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      struct iio_buffer *buffer)
> +{
> +	int length, offset = 0;
> +	unsigned int si;
> +
> +	if (chan->scan_index < 0 ||
> +	    !test_bit(chan->scan_index, buffer->scan_mask)) {
> +		return -EINVAL;
> +	}
> +
> +	for (si = 0; si < chan->scan_index; ++si) {
> +		if (!test_bit(si, buffer->scan_mask))

You are walking channels that the consumer should not even know about
here.

I think you can establish the same easily enough from the channels it
does know about.  It would be fiddly if you had lots of channels (as
you might be best off sorting them) but for small numbers of channels
loop over the array to find lowest scan_index - compute offset due
to that then move on to next one etc until you reach the scan index
of the channel you want.


> +			continue;
> +
> +		length = iio_storage_bytes_for_si(indio_dev, si);
> +
> +		/* Account for channel alignment. */
> +		if (offset % length)
> +			offset += length - (offset % length);
> +		offset += length;
> +	}
> +
> +	return offset;
> +}
> +EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);
> +
>  static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 418b1307d3f2..b1db74772e77 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -16,6 +16,10 @@ enum iio_buffer_direction {
>  	IIO_BUFFER_DIRECTION_OUT,
>  };
>  
> +int iio_find_channel_offset_in_buffer(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      struct iio_buffer *buffer);
> +
>  int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
>  
>  int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);

