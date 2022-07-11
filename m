Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30A5705A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiGKOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGKOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6463911;
        Mon, 11 Jul 2022 07:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23BCD6150E;
        Mon, 11 Jul 2022 14:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F3BC34115;
        Mon, 11 Jul 2022 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657550002;
        bh=MSEj7+VO4mdQqRSJbsD57UztsJqhRFCYrTs18jUyAeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZknyyheT/aYeZF2cu3sch5puRITMNBuJ896WE6Oql+0nM/7K2k4Tor6HMzDvfzyd0
         r1vkBf1aPSUJyGRSTumjI0/ZG5b2JJiILikdNR42rbY4Eqrcgs1RLTyVjIurhYCj67
         eMT6UPjqUoNntD71ZFYJhi7lcDS/XqaoNNw+Rgvo=
Date:   Mon, 11 Jul 2022 16:33:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: 8250: Add support for Brainboxes PX cards.
Message-ID: <Ysw0r9xSrbx188xe@kroah.com>
References: <AM5PR0202MB2564E7101DA29351041CB4C9C4879@AM5PR0202MB2564.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0202MB2564E7101DA29351041CB4C9C4879@AM5PR0202MB2564.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 02:50:35PM +0100, Cameron Williams wrote:
> Add support for some of the Brainboxes PCIe (PX) range of
> serial cards, including the PX-101, PX-235/PX-246,
> PX-203/PX-257, PX-260/PX-701, PX-310, PX-313,
> PX-320/PX-324/PX-376/PX-387, PX-335/PX-346, PX-368, PX-420,
> PX-803 and PX-846.
> 
> Signed-off-by: Cameron Williams <cang1@live.co.uk>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 116 ++++++++++++++++++++++++++++-
>  1 file changed, 113 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index a17619db7939..4a0ea79ca9d6 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -4973,7 +4973,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
>  	/*
>  	* Brainboxes UC-101
>  	*/
> -	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA1,
> +	{	PCI_VENDOR_ID_INTASHIELD, 0x0BA1,

You seem to have included a bunch of no-needed whitespace changes.  Can
you redo this to only make the additional device id support instead?

thanks,

greg k-h
