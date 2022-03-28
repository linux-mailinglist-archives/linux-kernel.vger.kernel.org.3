Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F114E9D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiC1RWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiC1RWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CC35A59D;
        Mon, 28 Mar 2022 10:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 169DE60C7E;
        Mon, 28 Mar 2022 17:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8814FC340F0;
        Mon, 28 Mar 2022 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648488033;
        bh=A1cAETogMKE4ByDJveM04ydwDhQNcj7ZVpXQPOMQvQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xo72ByilWB92HDWNLTtqY4spp9AeXbHk/lIMpcKvTCxuvJxK1agcIrDcJBMcU6ONQ
         OrLQiIJfvQPszkZlORSVD3EBxVv/cFKt8DY6Ecuol75mzJVFKWimAm1a15lLoiZaGX
         +c9kaiRQumyv3W7d3B9qxnUKyUYK2Pq8MWmO7I7G+pizhBkaIuGU0zxdvKFUPRKwj6
         ENJmUDd4XO5Dt8OmtPJKEbWa+i5oe/81Ztqx4H2JJv9JcoHbyMpl4mBXkagDw2e+AM
         gYKHLx3m8AUjySN4AstB8l57w4Yw5yLC1QvgB4DBODe4Oe77EmR0B05aYzPT9v4MTN
         39NFS0/Be9MIQ==
Date:   Mon, 28 Mar 2022 18:28:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 04/12] iio: buffer-dmaengine: Enable write support
Message-ID: <20220328182808.48e51432@jic23-huawei>
In-Reply-To: <20220207125933.81634-5-paul@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
        <20220207125933.81634-5-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Mon,  7 Feb 2022 12:59:25 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Use the iio_dma_buffer_write() and iio_dma_buffer_space_available()
> functions provided by the buffer-dma core, to enable write support in
> the buffer-dmaengine code.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
This (and previous) look fine to me. Just that question of a user for
the new functionality...

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index ac26b04aa4a9..5cde8fd81c7f 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -123,12 +123,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
>  
>  static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
>  	.read = iio_dma_buffer_read,
> +	.write = iio_dma_buffer_write,
>  	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
>  	.set_length = iio_dma_buffer_set_length,
>  	.request_update = iio_dma_buffer_request_update,
>  	.enable = iio_dma_buffer_enable,
>  	.disable = iio_dma_buffer_disable,
>  	.data_available = iio_dma_buffer_data_available,
> +	.space_available = iio_dma_buffer_space_available,
>  	.release = iio_dmaengine_buffer_release,
>  
>  	.modes = INDIO_BUFFER_HARDWARE,

