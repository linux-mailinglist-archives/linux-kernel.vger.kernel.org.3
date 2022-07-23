Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5A57EEE1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiGWKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGWKt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:49:59 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637D13E0C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:49:58 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id FChnonNinxaQ2FChnov53j; Sat, 23 Jul 2022 12:49:57 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Jul 2022 12:49:57 +0200
X-ME-IP: 90.11.190.129
Message-ID: <53b307a3-67e0-2acd-5d4a-0970f717afa7@wanadoo.fr>
Date:   Sat, 23 Jul 2022 12:49:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/7] spi: a3700: support BE for AC5 SPI driver
Content-Language: en-US
To:     vadym.kochan@plvision.eu
Cc:     broonie@kernel.org, enachman@marvell.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        lnoam@marvell.com
References: <20220723102237.10281-1-vadym.kochan@plvision.eu>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220723102237.10281-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/07/2022 à 12:22, Vadym Kochan a écrit :
> From: Noam <lnoam-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> Tested-by: Raz Adashi <raza-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Raz Adashi <raza-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vadym Kochan <vadym.kochan-Nq3fbkz6jlnsq35pWSNszA@public.gmane.org>
> ---
>   drivers/spi/spi-armada-3700.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> index d8cc4b270644..386c7959ea93 100644
> --- a/drivers/spi/spi-armada-3700.c
> +++ b/drivers/spi/spi-armada-3700.c
> @@ -497,7 +497,7 @@ static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
>   
>   	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
>   		val = *(u32 *)a3700_spi->tx_buf;
> -		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
> +		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, cpu_to_le32(val));
>   		a3700_spi->buf_len -= 4;
>   		a3700_spi->tx_buf += 4;
>   	}
> @@ -519,7 +519,7 @@ static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
>   	while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
>   		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
>   		if (a3700_spi->buf_len >= 4) {
> -
> +			val = cpu_to_le32(val);

Hi,

even if both should generate the same code, should'nt this be le32_to_cpu()?

CJ

>   			memcpy(a3700_spi->rx_buf, &val, 4);
>   
>   			a3700_spi->buf_len -= 4;

