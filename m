Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C374B1FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347963AbiBKIOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:14:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBKIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:14:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23BB8B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:14:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63E42B82886
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA54C340E9;
        Fri, 11 Feb 2022 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644567283;
        bh=WZCYqEtEdQI2nL3L1MblRCngBlk4UIBepJRNH61waVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmkL+HA4bOvs1dUxX3sg5pYeYehURdGNnx0nEiE/T3gnfonblMdhStg7GeCc6vtBU
         6Gv0rzP87mXkF5KqYPmo4SYXlP7QvnVZnKoI7UgxDTddAHEDe4F0r6E1NUQOFJ0iUW
         iYt5fd15CuLhHkdy5GFUyIqzroguaxSFIb4M/Xr4=
Date:   Fri, 11 Feb 2022 09:14:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add rf69_dbg_hex function
Message-ID: <YgYa8Pt77v6AAyjb@kroah.com>
References: <YgYZRArwwF7Z1B4f@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgYZRArwwF7Z1B4f@mail.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 09:07:32PM +1300, Paulo Miguel Almeida wrote:
> dev_<level> functions don't support printing hex dumps and the
> alternative available (print_hex_dump_debug) doesn't print the device
> information such as device's driver name and device name. That type of
> information which comes in handy for situations in which you can more
> than 1 device attached at the same type.
> 
> this patch adds a utility function that can obtain the same result as
> print_hex_dump_debug while being able to honour all possible flags that
> one may be interested in when dynamic debug is used.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Meta-comments:
> 
> the initial discussion to use print_hex_dump_debug started in this patch
> but the original idea got merged into the brach.
> 
> https://lore.kernel.org/lkml/a630d8381cee0f543e0d77614052e1d04ab162a5.camel@perches.com/#t
> 
> ---
>  drivers/staging/pi433/rf69.c | 39 ++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index 901f8db3e3ce..82d4ba24c35f 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -822,9 +822,37 @@ int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
>  
>  /*-------------------------------------------------------------------------*/
>  
> +static void rf69_dbg_hex(struct spi_device *spi, u8 *buf, unsigned int size,
> +			 const char *fmt, ...)
> +{
> +	va_list args;
> +	char textbuf[512] = {};
> +	char *text = textbuf;
> +	int text_pos;
> +
> +	int rowsize = 16;
> +	int i, linelen, remaining = size;
> +
> +	va_start(args, fmt);
> +	text_pos = vscnprintf(text, sizeof(textbuf), fmt, args);
> +	text += text_pos;
> +	va_end(args);
> +
> +	for (i = 0; i < size; i += rowsize) {
> +		linelen = min(remaining, rowsize);
> +		remaining -= rowsize;
> +
> +		hex_dump_to_buffer(buf + i, linelen, rowsize, 1,
> +				   text, sizeof(textbuf) - text_pos, false);
> +
> +		dev_dbg(&spi->dev, "%s\n", textbuf);
> +
> +		memset(text, 0, sizeof(textbuf) - text_pos);
> +	}
> +}

This is a lot of additional complexity for almost no real benefit.


> +
>  int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  {
> -	int i;
>  	struct spi_transfer transfer;
>  	u8 local_buffer[FIFO_SIZE + 1];
>  	int retval;
> @@ -844,9 +872,7 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  
>  	retval = spi_sync_transfer(spi, &transfer, 1);
>  
> -	/* print content read from fifo for debugging purposes */
> -	for (i = 0; i < size; i++)
> -		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);

What is wrong with this simple line?

> +	rf69_dbg_hex(spi, local_buffer + 1, size, "%s - ", __func__);
>  
>  	memcpy(buffer, &local_buffer[1], size);
>  
> @@ -855,7 +881,6 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  
>  int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  {
> -	int i;
>  	u8 local_buffer[FIFO_SIZE + 1];
>  
>  	if (size > FIFO_SIZE) {
> @@ -867,9 +892,7 @@ int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  	local_buffer[0] = REG_FIFO | WRITE_BIT;
>  	memcpy(&local_buffer[1], buffer, size);
>  
> -	/* print content written from fifo for debugging purposes */
> -	for (i = 0; i < size; i++)
> -		dev_dbg(&spi->dev, "0x%x\n", buffer[i]);
> +	rf69_dbg_hex(spi, local_buffer + 1, size, "%s - ", __func__);

Again, the original is fine here, why make this so complex?

Also, you are using local_buffer here, not buffer, why?

I think the original is just fine, no need to polish something as tiny
as a hex dump for debugging only.

thanks,

greg k-h
