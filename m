Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684B759A48C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbiHSRzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349956AbiHSRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:54:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D75B07B;
        Fri, 19 Aug 2022 10:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 578AFCE2638;
        Fri, 19 Aug 2022 17:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B621CC433C1;
        Fri, 19 Aug 2022 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660930463;
        bh=iN73GdUjnPeKZ1+z54YawEVKxrH8HjG373BwJUVD51Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SsSKP1QgP1Ld2LHGqOgoXwYXYs2eY7ro0MlNnbugBueQiM8wDEVUZtxpym5wyDIHA
         /LsBDL96a2Dlh1RmI3kNlJR5m6n16/rrD0OOKAQ32icSqdepa7AM/Dj+qgr0sXmwqh
         psNkzYybSEHiTSwWOLrwF9k5nXrAK2OxchbIC7/6U46PMQynXPLRz70SXHu5scQdfi
         iHr3BqkaDAzDb1AZyNfw9RNQ+fzoNsKg1VIRMXcHy/GF6HL9n3rYvvaCD6cS3XCZ5t
         qvLskNFO2tXY5VKYzzc++FlmPzfyfyMMh5egPTqCyqBszfi1XmaaWXhbHK2Zj9biYb
         SnTeXRISaOpaQ==
Date:   Fri, 19 Aug 2022 18:44:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: add iio_channel_cb_get_iio_buffer helper
Message-ID: <20220819184459.34a12f3f@jic23-huawei>
In-Reply-To: <20220817105643.95710-3-contact@artur-rojek.eu>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
        <20220817105643.95710-3-contact@artur-rojek.eu>
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

On Wed, 17 Aug 2022 12:56:41 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Introduce a helper function to retrieve an iio_buffer from
> iio_cb_buffer.
> 
> This is useful for consumers that need to extract metadata about
> the buffer, e.g. get the channel offsets.
> 
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Hmm. I'm not keen on breaking this boundary between
exposed interface and implementation like this.

The intent was always that the consumer knew what it was
requesting and had access to all the channel information
so should know what the buffer alignment is.

In this driver there is a call to devm_iio_channel_get_all()
which returns the channels.

The buffer offsets can be calculated from that information
as the alignement in a buffer a consumer sees is entirely
controlled by that information.

It might be helpful to provide some helper functions to allow
the consumer to establish where particular channels are though.
(which will look very like what userspace code has to do as the
information available is much the same).

Perhaps I'm missing some information that is missing from what
is exposed to consumers?

Jonathan




> ---
>  drivers/iio/buffer/industrialio-buffer-cb.c |  7 +++++++
>  include/linux/iio/consumer.h                | 12 ++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
> index 4c12b7a94af5..47d6e28b4d36 100644
> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> @@ -151,6 +151,13 @@ struct iio_dev
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
>  
> +struct iio_buffer
> +*iio_channel_cb_get_iio_buffer(struct iio_cb_buffer *cb_buffer)
> +{
> +	return &cb_buffer->buffer;
> +}
> +EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_buffer);
> +
>  MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
>  MODULE_DESCRIPTION("Industrial I/O callback buffer");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 6802596b017c..c28925d5b69c 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -196,6 +196,18 @@ struct iio_channel
>  struct iio_dev
>  *iio_channel_cb_get_iio_dev(const struct iio_cb_buffer *cb_buffer);
>  
> +/**
> + * iio_channel_cb_get_iio_buffer() - get access to the underlying buffer.
> + * @cb_buffer:		The callback buffer from whom we want the buffer
> + *			information.
> + *
> + * This function allows one to obtain information about the buffer.
> + * The primary aim is to allow drivers that are consuming a buffer to query
> + * things like channel offsets in the buffer.
> + */
> +struct iio_buffer
> +*iio_channel_cb_get_iio_buffer(struct iio_cb_buffer *cb_buffer);
> +
>  /**
>   * iio_read_channel_raw() - read from a given channel
>   * @chan:		The channel being queried.

