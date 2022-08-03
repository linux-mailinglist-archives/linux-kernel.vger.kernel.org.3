Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0370158894E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiHCJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiHCJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198919C09;
        Wed,  3 Aug 2022 02:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E824615F1;
        Wed,  3 Aug 2022 09:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F359C433C1;
        Wed,  3 Aug 2022 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659518558;
        bh=P4eKF7XDjuLzTy56svlSTm7yBbwooVXi0pHh6vFMI5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iN7MNUUYJn+0/ttPrYuVWcF6IcLCa+5VAp1BLLjr+8jEdYvW0BLWr0DBP47nREojd
         gcIn0lRPjRlkOiQ5RwnbBjue+TEjBduNAgRnBcG/bcs0kpzKiL/g3lU25EhucA0pjp
         UXL+OczMnko1RZcrmcfu8hcoZUqzCsi+ZArP/6eI=
Date:   Wed, 3 Aug 2022 11:22:35 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serial: imx: initialize
 peripheral_config/peripheral_size for sdma config
Message-ID: <Yuo+W2HhOLxnQpf+@kroah.com>
References: <20220803065737.14752-1-sherry.sun@nxp.com>
 <d4838245-030c-39b4-df4b-17b3b4c73a5b@pengutronix.de>
 <AS8PR04MB8404990740869737F326D302929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8404990740869737F326D302929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:15:58AM +0000, Sherry Sun wrote:
> > On 03.08.22 08:57, Sherry Sun wrote:
> > > Since commit 824a0a02cd74 ("dmaengine: imx-sdma: Add multi fifo
> > > support") adds the use of
> > > dma_slave_config->peripheral_config/peripheral_size to sdma driver,
> > > the client drivers like uart need to initialize the
> > > peripheral_config/peripheral_size for sdma, otherwise, the random
> > > value of local variable slave_config may cause unexpected
> > peripheral_config and make sdma mess up.
> > >
> > 
> > If this a fix, please add a Fixes: tag. I am not sure it is though, see below.
> 
> Hi Ahmad, thanks for the comments.
> I don't think this patch is a fix for a specific commit, so we don't need the Fixes tag.
> 
> > 
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/imx.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > > 522445a8f666..bb8c2a712e94 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -1320,6 +1320,8 @@ static int imx_uart_dma_init(struct imx_port
> > > *sport)
> > 
> > This function starts with
> > 
> > struct dma_slave_config slave_config = {};
> > 
> > >  	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> > >  	/* one byte less than the watermark level to enable the aging timer
> > */
> > >  	slave_config.src_maxburst = RXTL_DMA - 1;
> > > +	slave_config.peripheral_config = NULL;
> > > +	slave_config.peripheral_size = 0;
> > 
> > So these are already zero-initialized.
> 
> I am not sure actually, I think initialize a struct with {} cannot guarantee that all members are initialized to 0, it may depend on the compiler.

Not true, it's part of the C standard somewhere...

thanks,

greg k-h
