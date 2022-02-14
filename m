Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD64B53B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355366AbiBNOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:48:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355345AbiBNOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:48:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60324BFDF;
        Mon, 14 Feb 2022 06:48:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2611ACE136D;
        Mon, 14 Feb 2022 14:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE2AC340E9;
        Mon, 14 Feb 2022 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644850110;
        bh=BORgLaUPxCTDX5yxIj1jsaKLkKZy0KysODNRJJND/io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbKmmm8V4BdGISEsG1YfrnHrJZim2ToZCizAAEZIXOUCjrpYGmK/39MK2Cfi05qFJ
         TqTLoo733ANy3k4NdqFXPkViU/1c6mo6L25JfuYvIDpMY1Q5hZ99Usf8sC4tOTT/L9
         rURCdvb6I/fPKKDiFwemGHhB/+7OQnLK1DpEpTdg=
Date:   Mon, 14 Feb 2022 15:48:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     balbi@kernel.org, ruslan.bilovol@gmail.com,
        pavel.hofman@ivitera.com, jbrunet@baylibre.com,
        jackp@codeaurora.org, colin.king@intel.com, pawell@cadence.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH v2] usb: gadget: f_uac2: fix superspeed transfer
Message-ID: <YgpruynyO1AJr7bn@kroah.com>
References: <20220214032606.17227-1-3090101217@zju.edu.cn>
 <20220214143223.5658-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214143223.5658-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:32:23PM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> On page 362 of the USB3.2 specification (
> https://usb.org/sites/default/files/usb_32_20210125.zip),
> The 'SuperSpeed Endpoint Companion Descriptor' shall only be returned
> by Enhanced SuperSpeed devices that are operating at Gen X speed.
> Each endpoint described in an interface is followed by a 'SuperSpeed
> Endpoint Companion Descriptor'.
> 
> If we use SuperSpeed UDC, host can't recognize the device if endpoint
> doesn't have 'SuperSpeed Endpoint Companion Descriptor' followed.
> 
> Currently in the uac2 driver code:
> 1. ss_epout_desc_comp follows ss_epout_desc;
> 2. ss_epin_fback_desc_comp follows ss_epin_fback_desc;
> 3. ss_epin_desc_comp follows ss_epin_desc;
> 4. Only ss_ep_int_desc endpoint doesn't have 'SuperSpeed Endpoint
> Companion Descriptor' followed, so we should add it.
> 
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
>  drivers/usb/gadget/function/f_uac2.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index 097a709549d6..a6fc492f9148 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -282,6 +282,14 @@ static struct usb_endpoint_descriptor ss_ep_int_desc = {
>  	.bInterval = 4,
>  };
>  
> +static struct usb_ss_ep_comp_descriptor ss_ep_int_desc_comp = {
> +	.bLength = sizeof(ss_ep_int_desc_comp),
> +	.bDescriptorType = USB_DT_SS_ENDPOINT_COMP,
> +	.bMaxBurst = 0,
> +	.bmAttributes = 0,
> +	.wBytesPerInterval = cpu_to_le16(6),
> +};
> +
>  /* Audio Streaming OUT Interface - Alt0 */
>  static struct usb_interface_descriptor std_as_out_if0_desc = {
>  	.bLength = sizeof std_as_out_if0_desc,
> @@ -595,7 +603,8 @@ static struct usb_descriptor_header *ss_audio_desc[] = {
>  	(struct usb_descriptor_header *)&in_feature_unit_desc,
>  	(struct usb_descriptor_header *)&io_out_ot_desc,
>  
> -  (struct usb_descriptor_header *)&ss_ep_int_desc,
> +	(struct usb_descriptor_header *)&ss_ep_int_desc,
> +	(struct usb_descriptor_header *)&ss_ep_int_desc_comp,
>  
>  	(struct usb_descriptor_header *)&std_as_out_if0_desc,
>  	(struct usb_descriptor_header *)&std_as_out_if1_desc,
> @@ -657,6 +666,7 @@ static int set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
>  
>  	case USB_SPEED_HIGH:
>  	case USB_SPEED_SUPER:
> +	case USB_SPEED_SUPER_PLUS:
>  		max_size_ep = 1024;
>  		factor = 8000;
>  		break;
> @@ -723,6 +733,7 @@ static void setup_headers(struct f_uac2_opts *opts,
>  	struct usb_ss_ep_comp_descriptor *epout_desc_comp = NULL;
>  	struct usb_ss_ep_comp_descriptor *epin_desc_comp = NULL;
>  	struct usb_ss_ep_comp_descriptor *epin_fback_desc_comp = NULL;
> +	struct usb_ss_ep_comp_descriptor *ep_int_desc_comp = NULL;
>  	struct usb_endpoint_descriptor *epout_desc;
>  	struct usb_endpoint_descriptor *epin_desc;
>  	struct usb_endpoint_descriptor *epin_fback_desc;
> @@ -750,6 +761,7 @@ static void setup_headers(struct f_uac2_opts *opts,
>  		epin_fback_desc = &ss_epin_fback_desc;
>  		epin_fback_desc_comp = &ss_epin_fback_desc_comp;
>  		ep_int_desc = &ss_ep_int_desc;
> +		ep_int_desc_comp = &ss_ep_int_desc_comp;
>  	}
>  
>  	i = 0;
> @@ -778,8 +790,11 @@ static void setup_headers(struct f_uac2_opts *opts,
>  	if (EPOUT_EN(opts))
>  		headers[i++] = USBDHDR(&io_out_ot_desc);
>  
> -	if (FUOUT_EN(opts) || FUIN_EN(opts))
> +	if (FUOUT_EN(opts) || FUIN_EN(opts)) {
>  		headers[i++] = USBDHDR(ep_int_desc);
> +		if (ep_int_desc_comp)
> +			headers[i++] = USBDHDR(ep_int_desc_comp);
> +	}
>  
>  	if (EPOUT_EN(opts)) {
>  		headers[i++] = USBDHDR(&std_as_out_if0_desc);
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
