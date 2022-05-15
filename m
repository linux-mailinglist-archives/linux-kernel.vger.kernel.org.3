Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81AD527723
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiEOKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiEOKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:54:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2D6DF8D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9B60B80B42
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F2BC385B8;
        Sun, 15 May 2022 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652612078;
        bh=UccLv4RhQ0bQJ0lHh69V+IGbIndO8BVCVFJ42fJnLi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2kE10ySCX6GBhG8MnOwDJz76No/2U2GyA3sqATKqIEQg5nrcjpzgK5m46HIFUUMTK
         aNOfI+qFpW/Cjb5c+aKrPrM6zP2t7hZ4PLdkdYpRp8mOUWUyu8EaWpaxbkyJEB9W1j
         NlmEF6uSVc5kUxUN2MU2FWNugX2GAj9ZJcUfUw6c=
Date:   Sun, 15 May 2022 12:54:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?WWHFn2FyIEFyYWJhY8Sx?= <yasar11732@gmail.com>
Cc:     paulo.miguel.almeida.rodenas@gmail.com, dan.carpenter@oracle.com,
        alexandre.belloni@bootlin.com, realwakka@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: Don't use ioctl for per-client
 configuration
Message-ID: <YoDb6wwRmn0I496H@kroah.com>
References: <20220515104711.94567-1-yasar11732@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220515104711.94567-1-yasar11732@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 01:47:11PM +0300, Yaşar Arabacı wrote:
> Currently this driver uses ioctl for reading/writing per-device and
> per-client configuration. Per-client configuration can be handled by
> usespace and sent to driver with each write() call. Doing so does not
> introduce extra overhead because we copy tx config to fifo for each
> transmit anyway. This way, we don't have to introduce new ioctl's.
> 
> This has not been tested as I don't have access to hardware.
> 
> Signed-off-by: Yaşar Arabacı <yasar11732@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 63 ++++++--------------------------
>  drivers/staging/pi433/pi433_if.h |  7 +---
>  2 files changed, 13 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 941aaa7eab2e..07cd9054560a 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -109,10 +109,6 @@ struct pi433_device {
>  
>  struct pi433_instance {
>  	struct pi433_device	*device;
> -	struct pi433_tx_cfg	tx_cfg;
> -
> -	/* control flags */
> -	bool			tx_cfg_initialized;
>  };
>  
>  /*-------------------------------------------------------------------------*/
> @@ -574,12 +570,6 @@ static int pi433_tx_thread(void *data)
>  		if (kthread_should_stop())
>  			return 0;
>  
> -		/*
> -		 * get data from fifo in the following order:
> -		 * - tx_cfg
> -		 * - size of message
> -		 * - message
> -		 */
>  		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
>  		if (retval != sizeof(tx_cfg)) {
>  			dev_dbg(device->dev,
> @@ -588,13 +578,7 @@ static int pi433_tx_thread(void *data)
>  			continue;
>  		}
>  
> -		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
> -		if (retval != sizeof(size_t)) {
> -			dev_dbg(device->dev,
> -				"reading msg size from fifo failed: got %d, expected %d\n",
> -				retval, (unsigned int)sizeof(size_t));
> -			continue;
> -		}
> +		size = tx_cfg.payload_size;
>  
>  		/* use fixed message length, if requested */
>  		if (tx_cfg.fixed_message_length != 0)
> @@ -811,6 +795,7 @@ pi433_write(struct file *filp, const char __user *buf,
>  	    size_t count, loff_t *f_pos)
>  {
>  	struct pi433_instance	*instance;
> +	struct pi433_tx_cfg *tx_cfg;
>  	struct pi433_device	*device;
>  	int                     retval;
>  	unsigned int		required, available, copied;
> @@ -822,18 +807,16 @@ pi433_write(struct file *filp, const char __user *buf,
>  	 * check, whether internal buffer (tx thread) is big enough
>  	 * for requested size
>  	 */
> -	if (count > MAX_MSG_SIZE)
> +	if (unlikely(count > MAX_MSG_SIZE))
>  		return -EMSGSIZE;

Unless you can benchmark the difference, NEVER use likely/unlikely as
the compiler and CPU almost always do a better job than humans in
figuring this stuff out.

Also it's an unrelated change to what you said this commit was going to
do, please don't do that.

thanks,

greg k-h
