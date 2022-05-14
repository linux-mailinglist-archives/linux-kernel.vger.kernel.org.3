Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A8526F96
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiENHSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 03:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiENHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 03:18:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70198CCC
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15B64B82CD9
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 07:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D8BC340EE;
        Sat, 14 May 2022 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652512707;
        bh=h/WVTZYcRvheFzmWypCAOaDVrx4HZe4HVRhe4SlC1XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mysqPVmQ5JY5H0x3iIpKNP4fGl37eimBAoxQUJpMjz4KKaXs5VbNEBruqTDaUdGy
         ju8EzTnFcaaVBLAQEIoiTxZPnUFts8RI+ZhMBnOaGCCCLNh+TpHmmzfTg0R6nV4j3C
         ax+QDZckn1ac6a47ffTKNRZNAovafjQEh3jFY3LA=
Date:   Sat, 14 May 2022 09:18:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     eli.billauer@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Check endpoint type properly
Message-ID: <Yn9XwHxWsLIJXlHu@kroah.com>
References: <20220514071436.2517776-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514071436.2517776-1-zheyuma97@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 03:14:35PM +0800, Zheyu Ma wrote:
> The driver submits bulk urb without checking the endpoint type is
> actually bulk.
> 
> [    3.108411] ------------[ cut here ]------------
> [    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> [    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> [    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> [    3.115318] Call Trace:
> [    3.115452]  <TASK>
> [    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
> [    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]
> 
> Add a check to fix it.
> 
> Fixes: a53d1202aef1 ("char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/char/xillybus/xillyusb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> index 39bcbfd908b4..2ec2e087b2e7 100644
> --- a/drivers/char/xillybus/xillyusb.c
> +++ b/drivers/char/xillybus/xillyusb.c
> @@ -730,6 +730,11 @@ static void try_queue_bulk_in(struct xillyusb_endpoint *ep)
>  
>  		usb_anchor_urb(urb, &ep->anchor);
>  
> +		if (usb_urb_ep_type_check(urb)) {
> +			report_io_error(xdev, -EINVAL);
> +			goto unanchor;
> +		}
> +
>  		rc = usb_submit_urb(urb, GFP_KERNEL);
>  
>  		if (rc) {
> @@ -834,6 +839,11 @@ static void try_queue_bulk_out(struct xillyusb_endpoint *ep)
>  
>  		usb_anchor_urb(urb, &ep->anchor);
>  
> +		if (usb_urb_ep_type_check(urb)) {
> +			report_io_error(xdev, -EINVAL);
> +			goto unanchor;
> +		}
> +
>  		rc = usb_submit_urb(urb, GFP_KERNEL);
>  
>  		if (rc) {
> -- 
> 2.25.1
> 

This should all be checked much earlier, in your probe function, to make
sure you have the endpoints correct.  Just refuse to bind to a device
that is not correct.  Don't check late here when you are submitting the
urb.

thanks,

greg k-h
