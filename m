Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5253B51B5CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiEECZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiEECZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:25:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86564B1EE;
        Wed,  4 May 2022 19:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6F20B82A9E;
        Thu,  5 May 2022 02:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BBBC385A4;
        Thu,  5 May 2022 02:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651717284;
        bh=Jc/hE57il7GJCRFa3rMEElYHvssdWJFgqG+ZQENpwao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ld3ce0ofq08Ma0sWuCjJTlsEQQx293G4F2Tk5xA/o4TZJkAaa99zAv/KAcSct0nfD
         KZjW0J6SW4w2JW1elBQ3Sc9htsx4axQPEKmPGODRn/H6dp+LldkF8AslgirTnso74h
         16Y+hduFHx+FgX/1dDaxfKlkXishxDxNptt4tW4cAuP84t/xDlF2Aj2zAM4n5PvRCg
         msIpOZJ+Rc4xLxiDvVatfPTzuoANH/J409UHae4LBqtAQQT6VKEgt90oFlwx1NtaNA
         8iOnO0P9dS6ozwa0sXYIskQrVv/wse+Gv6uhNWElyicpTEZcVoJcdTWST9fT6B0+re
         OejQRInMo/w3A==
Date:   Thu, 5 May 2022 10:21:11 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        linux-usb@vger.kernel.org, jun.li@nxp.com, lznuaa@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/1] usb: cdns3: allocate TX FIFO size according to
 composite EP number
Message-ID: <20220505022111.GA433739@Peter>
References: <20220427163525.1129887-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427163525.1129887-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-27 11:35:25, Frank Li wrote:
> Some devices have USB compositions which may require multiple endpoints.
> To get better performance, need bigger CDNS3_EP_BUF_SIZE.
> 
> But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
> multiple endpoints.
> 
> By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.
> 
> Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
> Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
> ecnds3_device:ep_iso_burst

typo, and would you please explain usage for ep_iso_burst in your patch?

> 
> Using a simple algorithm to calculate ep_buf_size.
> ep_buf_size = ep_iso_burst = (onchip_buffers - 2k) / (number of IN EP +
> 1).
> 
> Test at 8qxp:
> 
> 	Gadget			ep_buf_size
> 
> 	RNDIS:				5
> 	RNDIS+ACM:			3
> 	Mass Storage + NCM + ACM	2
> 
> Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
> exceed FIFO memory.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2:
>  Add safe check for mult, buffering and maxburst
> 
>  drivers/usb/cdns3/cdns3-gadget.c | 50 +++++++++++++++++++++++++++++---
>  drivers/usb/cdns3/cdns3-gadget.h |  9 ++++--
>  2 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 1f3b4a1422126..e25e7a2b55862 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2050,7 +2050,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  	u8 mult = 0;
>  	int ret;
>  
> -	buffering = CDNS3_EP_BUF_SIZE - 1;
> +	buffering = priv_dev->ep_buf_size - 1;
>  
>  	cdns3_configure_dmult(priv_dev, priv_ep);
>  
> @@ -2069,7 +2069,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  		break;
>  	default:
>  		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
> -		mult = CDNS3_EP_ISO_HS_MULT - 1;
> +		mult = priv_dev->ep_iso_burst - 1;
>  		buffering = mult + 1;
>  	}
>  
> @@ -2085,14 +2085,14 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  		mult = 0;
>  		max_packet_size = 1024;
>  		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
> -			maxburst = CDNS3_EP_ISO_SS_BURST - 1;
> +			maxburst = priv_dev->ep_iso_burst - 1;
>  			buffering = (mult + 1) *
>  				    (maxburst + 1);
>  
>  			if (priv_ep->interval > 1)
>  				buffering++;
>  		} else {
> -			maxburst = CDNS3_EP_BUF_SIZE - 1;
> +			maxburst = priv_dev->ep_buf_size - 1;
>  		}
>  		break;
>  	default:
> @@ -2136,6 +2136,10 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  		ep_cfg |=  EP_CFG_STREAM_EN | EP_CFG_TDL_CHK | EP_CFG_SID_CHK;
>  	}
>  
> +	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
> +	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
> +	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
> +
>  	ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
>  		  EP_CFG_MULT(mult) |
>  		  EP_CFG_BUFFERING(buffering) |
> @@ -2970,6 +2974,43 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>  	return 0;
>  }
>  
> +/**
> + * cdns3_gadget_check_config - ensure cdns3 can support the USB configuration
> + * @gadget: pointer to the USB gadget
> + *
> + * Used to record the maximum number of endpoints being used in a USB composite
> + * device. (across all configurations)  This is to be used in the calculation
> + * of the TXFIFO sizes when resizing internal memory for individual endpoints.
> + * It will help ensured that the resizing logic reserves enough space for at
> + * least one max packet.
> + */
> +static int cdns3_gadget_check_config(struct usb_gadget *gadget)
> +{
> +	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +	struct usb_ep *ep;
> +	int n_in = 0;
> +	int total;
> +
> +	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
> +		if (ep->claimed && (ep->address & USB_DIR_IN))
> +			n_in++;
> +	}
> +
> +	priv_dev->ep_buf_size = 1;
> +	priv_dev->ep_iso_burst = 1;

You will re-calculate above variables below, why need to initialize them?

Peter
> +
> +	/* 2KB are reserved for EP0, 1KB for out*/
> +	total = 2 + n_in + 1;
> +
> +	if (total > priv_dev->onchip_buffers)
> +		return -ENOMEM;
> +
> +	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
> +			(priv_dev->onchip_buffers - 2) / (n_in + 1);
> +
> +	return 0;
> +}
> +
>  static const struct usb_gadget_ops cdns3_gadget_ops = {
>  	.get_frame = cdns3_gadget_get_frame,
>  	.wakeup = cdns3_gadget_wakeup,
> @@ -2978,6 +3019,7 @@ static const struct usb_gadget_ops cdns3_gadget_ops = {
>  	.udc_start = cdns3_gadget_udc_start,
>  	.udc_stop = cdns3_gadget_udc_stop,
>  	.match_ep = cdns3_gadget_match_ep,
> +	.check_config = cdns3_gadget_check_config,
>  };
>  
>  static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
> diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
> index c5660f2c4293f..fbe4a8e3aa897 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.h
> +++ b/drivers/usb/cdns3/cdns3-gadget.h
> @@ -562,15 +562,18 @@ struct cdns3_usb_regs {
>  /* Max burst size (used only in SS mode). */
>  #define EP_CFG_MAXBURST_MASK	GENMASK(11, 8)
>  #define EP_CFG_MAXBURST(p)	(((p) << 8) & EP_CFG_MAXBURST_MASK)
> +#define EP_CFG_MAXBURST_MAX	15
>  /* ISO max burst. */
>  #define EP_CFG_MULT_MASK	GENMASK(15, 14)
>  #define EP_CFG_MULT(p)		(((p) << 14) & EP_CFG_MULT_MASK)
> +#define EP_CFG_MULT_MAX		2
>  /* ISO max burst. */
>  #define EP_CFG_MAXPKTSIZE_MASK	GENMASK(26, 16)
>  #define EP_CFG_MAXPKTSIZE(p)	(((p) << 16) & EP_CFG_MAXPKTSIZE_MASK)
>  /* Max number of buffered packets. */
>  #define EP_CFG_BUFFERING_MASK	GENMASK(31, 27)
>  #define EP_CFG_BUFFERING(p)	(((p) << 27) & EP_CFG_BUFFERING_MASK)
> +#define EP_CFG_BUFFERING_MAX	15
>  
>  /* EP_CMD - bitmasks */
>  /* Endpoint reset. */
> @@ -1094,9 +1097,6 @@ struct cdns3_trb {
>  #define CDNS3_ENDPOINTS_MAX_COUNT	32
>  #define CDNS3_EP_ZLP_BUF_SIZE		1024
>  
> -#define CDNS3_EP_BUF_SIZE		4	/* KB */
> -#define CDNS3_EP_ISO_HS_MULT		3
> -#define CDNS3_EP_ISO_SS_BURST		3
>  #define CDNS3_MAX_NUM_DESCMISS_BUF	32
>  #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
>  #define CDNS3_WA2_NUM_BUFFERS		128
> @@ -1333,6 +1333,9 @@ struct cdns3_device {
>  	/*in KB */
>  	u16				onchip_buffers;
>  	u16				onchip_used_size;
> +
> +	u16				ep_buf_size;
> +	u16				ep_iso_burst;
>  };
>  
>  void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
> -- 
> 2.35.1
> 

-- 

Thanks,
Peter Chen

