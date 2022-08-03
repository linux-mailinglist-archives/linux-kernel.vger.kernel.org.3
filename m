Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BB158889A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiHCIQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiHCIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:16:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF3A65C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:16:21 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oJ9Xy-0000MF-BC; Wed, 03 Aug 2022 10:16:06 +0200
Message-ID: <d4838245-030c-39b4-df4b-17b3b4c73a5b@pengutronix.de>
Date:   Wed, 3 Aug 2022 10:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] tty: serial: imx: initialize
 peripheral_config/peripheral_size for sdma config
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-imx@nxp.com
References: <20220803065737.14752-1-sherry.sun@nxp.com>
Content-Language: en-US
In-Reply-To: <20220803065737.14752-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sherry,

On 03.08.22 08:57, Sherry Sun wrote:
> Since commit 824a0a02cd74 ("dmaengine: imx-sdma: Add multi fifo support")
> adds the use of dma_slave_config->peripheral_config/peripheral_size to
> sdma driver, the client drivers like uart need to initialize the
> peripheral_config/peripheral_size for sdma, otherwise, the random value
> of local variable slave_config may cause unexpected peripheral_config
> and make sdma mess up.
> 

If this a fix, please add a Fixes: tag. I am not sure it is though,
see below.

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 522445a8f666..bb8c2a712e94 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1320,6 +1320,8 @@ static int imx_uart_dma_init(struct imx_port *sport)

This function starts with 

struct dma_slave_config slave_config = {};

>  	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	/* one byte less than the watermark level to enable the aging timer */
>  	slave_config.src_maxburst = RXTL_DMA - 1;
> +	slave_config.peripheral_config = NULL;
> +	slave_config.peripheral_size = 0;

So these are already zero-initialized.

>  	ret = dmaengine_slave_config(sport->dma_chan_rx, &slave_config);
>  	if (ret) {
>  		dev_err(dev, "error in RX dma configuration.\n");
> @@ -1346,6 +1348,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
>  	slave_config.dst_addr = sport->port.mapbase + URTX0;
>  	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	slave_config.dst_maxburst = TXTL_DMA;
> +	slave_config.peripheral_config = NULL;
> +	slave_config.peripheral_size = 0;

Not sure if this is required. If preceding dmaengine_slave_config()
indeed makes clearing necessary, you should note that in the commit
message.

Cheers,
Ahmad

>  	ret = dmaengine_slave_config(sport->dma_chan_tx, &slave_config);
>  	if (ret) {
>  		dev_err(dev, "error in TX dma configuration.");


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
