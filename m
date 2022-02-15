Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CA34B6E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiBOOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:08:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiBOOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:08:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720E6C968;
        Tue, 15 Feb 2022 06:08:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E211B819E4;
        Tue, 15 Feb 2022 14:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E9DC340EB;
        Tue, 15 Feb 2022 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644934117;
        bh=2a2WgalEeiELEcZIgFaEbv0GOqcKw+xpRsYr5cJFSDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HztFqtJLPHvCezQO1GD5iRpPCr7Ta7PLfWgDt7fFYSlQVJm2xV+hZECStnXYjL8xN
         s91ZHZBMU07zNpIJo/kd3ArBWpd3SAxSV7/sPwKNfN4Cb5e+K3Qggn6fsEvSedXqw7
         VTg2EA2tExjDlNTci909HZyTiDhHpWffXBfBsZHM=
Date:   Tue, 15 Feb 2022 15:08:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        ruslan.bilovol@gmail.com, Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH v3] usb: gadget: f_uac1: add different speed transfers
 support
Message-ID: <Yguz4hOBYTXRL35t@kroah.com>
References: <YgprpGbtBpojsCmQ@kroah.com>
 <20220215030848.5709-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215030848.5709-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:08:48AM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> On page 61 of the UAC1 specification (
> https://www.usb.org/sites/default/files/audio10.pdf),
> bInterval is interval for polling endpoint for data transfers
> expressed in milliseconds, must be set to 1.
> 
> On page 47 of the USB2.0 specification (
> https://www.usb.org/sites/default/files/usb_20_20211008.zip),
> An isochronous endpoint must specify its required bus access period.
> Full-/high-speed endpoints must specify a desired period as
> (2^(bInterval-1)) x F, where bInterval is in the range one to
> (and including) 16 and F is 125 μs for high-speed and 1ms for full-speed.
> 
> On page 362 of the USB3.2 specification (
> https://usb.org/sites/default/files/usb_32_20210125.zip),
> The 'SuperSpeed Endpoint Companion Descriptor' shall only be
> returned by Enhanced SuperSpeed devices that are operating at Gen X speed.
> Each endpoint described in an interface is followed by a 'SuperSpeed
> Endpoint Companion Descriptor'.
> 
> Currently uac1 driver doesn't set bInterval to 1 in full speed transfer
> and doesn't have a 'SuperSpeed Endpoint Companion Descriptor' behind
> 'Standard Endpoint Descriptor'.
> 
> So we should set bInterval to 1 in full speed transfer and set it to 4
> in other speed transfers, and we should add 'SuperSpeed Endpoint Companion
> Descriptor' behind 'Standard Endpoint Descriptor' for superspeed transfer.
> 
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
>  drivers/usb/gadget/function/f_uac1.c | 276 ++++++++++++++++++++++-----
>  1 file changed, 225 insertions(+), 51 deletions(-)

Where is the patch version information?

> +static struct usb_ss_ep_comp_descriptor as_out_ep_desc_comp = {
> +	.bLength		= sizeof(as_out_ep_desc_comp),
> +	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
> +	.bMaxBurst		= 0,
> +	.bmAttributes		= 0,

Why are you setting values to 0 when you do not have to as that is the
default value?

> @@ -891,7 +1098,6 @@ static int f_audio_get_alt(struct usb_function *f, unsigned intf)
>  	return -EINVAL;
>  }
>  
> -
>  static void f_audio_disable(struct usb_function *f)
>  {
>  	struct f_uac1 *uac1 = func_to_uac1(f);

The above change is not needed here.

thanks,

greg k-h
