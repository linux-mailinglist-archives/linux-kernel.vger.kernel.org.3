Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8034D705C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiCLSPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCLSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:15:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDF1E523B;
        Sat, 12 Mar 2022 10:14:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E532FB80A0A;
        Sat, 12 Mar 2022 18:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944C1C340EB;
        Sat, 12 Mar 2022 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647108881;
        bh=BqMtPa51aGGOEPpH/4cwY/nCgf9FyuXsCpcvHJIaJW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPcORDKiHDl6f09SEkVUQVuIISCM6c7tQFfHEz/VJ+I2QGsiL58WxgdddHj/4hsmh
         /BOH2DildkY/JCxCCT6By4jsEtCXWA6CsfSzmTr1w21sCofK0+1g5+IUZ0+SSxH3EF
         cZJaPdKyqkOrg3NkInm31o/I8CUZ19xIMWoK2d8X/E7zzuqiN+2mwVD0WkbfZ7KZos
         ZWkezUz3mRbfLnpgSuAL73wUHJQpt8Jxmdrg8sGAuEbus61Sf05+b5O39DHeDA/WeN
         c9nqP5SIXSoCENvqgjm/6mZwcjss5Rwpth/GOrv6kzuorik7oyR4xYDizYMT2tZpzV
         2JZUxD4Flmd3A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nT6GD-0002sy-8D; Sat, 12 Mar 2022 19:14:37 +0100
Date:   Sat, 12 Mar 2022 19:14:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Michael Estner <michaelestner@web.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitor-commits@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: usbtouchscreen: use kzalloc
Message-ID: <YizjDULjVcDQb6iR@hovoldconsulting.com>
References: <michaelestner@web.de>
 <20220312172232.13146-1-michaelestner@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312172232.13146-1-michaelestner@web.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 06:22:30PM +0100, Michael Estner wrote:
> Use kzalloc instead of kmalloc + memset.
> 
> The semantic patch that makes this change is:
> (https://coccinelle.gitlabpages.inria.fr/website/)
> 
> Signed-off-by: Michael Estner <michaelestner@web.de>
> ---
>  drivers/input/touchscreen/usbtouchscreen.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index 43c521f50c85..159e1ac6198a 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -975,7 +975,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
>  	if (!input_ep || !output_ep)
>  		return -ENXIO;
> 
> -	buf = kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
> +	buf = kzalloc(NEXIO_BUFSIZE, GFP_NOIO);
>  	if (!buf)
>  		goto out_buf;
> 
> @@ -998,7 +998,6 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
> 
>  	/* read replies */
>  	for (i = 0; i < 3; i++) {
> -		memset(buf, 0, NEXIO_BUFSIZE);
>  		ret = usb_bulk_msg(dev, usb_rcvbulkpipe(dev, input_ep),
>  				   buf, NEXIO_BUFSIZE, &actual_len,
>  				   NEXIO_TIMEOUT);

NAK

The new code is not equivalent to the old so that semantic patch must be
broken.

The current code is clearing the buffer before each read, after this
patch it would only be cleared once.

Johan
