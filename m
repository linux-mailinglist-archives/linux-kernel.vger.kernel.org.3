Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7386A5598C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiFXLpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiFXLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:45:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6487C867;
        Fri, 24 Jun 2022 04:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41EACB82843;
        Fri, 24 Jun 2022 11:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D09C34114;
        Fri, 24 Jun 2022 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071102;
        bh=2OdxBW7zOQDflGPS+i+6wvl/FUJ2680bq4VvcnCLOvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=10zZhcC3sv1Ebk8gLwIOBVQc0ANNaJGC6wMd597qmtQ6C/Xhugkc+N1cb41qIx2Ba
         D0GrQEy3DUWE5l1fz1kzeJvyhSfFMiPZR/0O2TlffcnCby6+fFQF5lzaDk46iwj2uV
         F/THNDBAfuArcsXYouK85ba37aTQXvjrlvCN1NyM=
Date:   Fri, 24 Jun 2022 13:39:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Julian Scheel <julian@jusst.de>,
        xin lin <xin.lin@mediatek.com>,
        Yunhao Tian <t123yh.xyz@gmail.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH] usb: gadget: f_uac1: add IAD descriptor
Message-ID: <YrWif4oeelZrctmr@kroah.com>
References: <20220622085757.23437-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622085757.23437-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:57:57PM +0800, Chunfeng Yun wrote:
> From: xin lin <xin.lin@mediatek.com>
> 
> Win10 can not enumerate composite device of UVC+UAC1+ADB without IAD descriptor
> in uac1.0, so add it.

I do not know what this means at all, sorry.  Can you please provide a
better changelog text that describes what all of this is in more detail?



> 
> Signed-off-by: xin lin <xin.lin@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/gadget/function/f_uac1.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
> index 6f0e1d803dc2..8390207bc513 100644
> --- a/drivers/usb/gadget/function/f_uac1.c
> +++ b/drivers/usb/gadget/function/f_uac1.c
> @@ -71,6 +71,17 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
>   * ALSA_Playback -> IT_3 -> OT_4 -> USB-IN
>   */
>  
> +static struct usb_interface_assoc_descriptor iad_desc = {
> +	.bLength = sizeof(iad_desc),
> +	.bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
> +
> +	.bFirstInterface = 0,
> +	.bInterfaceCount = 3,
> +	.bFunctionClass = USB_CLASS_AUDIO,
> +	.bFunctionSubClass = 0,
> +	.bFunctionProtocol = UAC_VERSION_1,
> +};
> +
>  /* B.3.1  Standard AC Interface Descriptor */
>  static struct usb_interface_descriptor ac_interface_desc = {
>  	.bLength =		USB_DT_INTERFACE_SIZE,
> @@ -259,6 +270,7 @@ static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
>  };
>  
>  static struct usb_descriptor_header *f_audio_desc[] = {
> +	(struct usb_descriptor_header *)&iad_desc,

Why put this first?  Is that a requirement?

>  	(struct usb_descriptor_header *)&ac_interface_desc,
>  	(struct usb_descriptor_header *)&ac_header_desc,
>  
> @@ -293,6 +305,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
>  };
>  
>  enum {
> +	STR_ASSOC,

Again, why first?

>  	STR_AC_IF,
>  	STR_USB_OUT_IT,
>  	STR_USB_OUT_IT_CH_NAMES,
> @@ -310,6 +323,7 @@ enum {
>  
>  static struct usb_string strings_uac1[] = {
>  	/* [STR_AC_IF].s = DYNAMIC, */
> +	[STR_ASSOC].s = "Source/Sink",
>  	[STR_USB_OUT_IT].s = "Playback Input terminal",
>  	[STR_USB_OUT_IT_CH_NAMES].s = "Playback Channels",
>  	[STR_IO_OUT_OT].s = "Playback Output terminal",
> @@ -1058,6 +1072,7 @@ static void setup_descriptor(struct f_uac1_opts *opts)
>  	as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
>  	as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
>  
> +	iad_desc.bInterfaceCount = 1;

Why this change?


>  	ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc->bLength);
>  
>  	if (EPIN_EN(opts)) {
> @@ -1068,6 +1083,7 @@ static void setup_descriptor(struct f_uac1_opts *opts)
>  		if (FUIN_EN(opts))
>  			len += in_feature_unit_desc->bLength;
>  		ac_header_desc->wTotalLength = cpu_to_le16(len);
> +		iad_desc.bInterfaceCount++;
>  	}
>  	if (EPOUT_EN(opts)) {
>  		u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
> @@ -1077,9 +1093,11 @@ static void setup_descriptor(struct f_uac1_opts *opts)
>  		if (FUOUT_EN(opts))
>  			len += out_feature_unit_desc->bLength;
>  		ac_header_desc->wTotalLength = cpu_to_le16(len);
> +		iad_desc.bInterfaceCount++;
>  	}
>  
>  	i = 0;
> +	f_audio_desc[i++] = USBDHDR(&iad_desc);

Again, why first?

>  	f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
>  	f_audio_desc[i++] = USBDHDR(ac_header_desc);
>  
> @@ -1217,6 +1235,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
>  		}
>  	}
>  
> +	iad_desc.iFunction = us[STR_ASSOC].id;
>  	ac_interface_desc.iInterface = us[STR_AC_IF].id;
>  	usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
>  	usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id;
> @@ -1302,6 +1321,8 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
>  	status = usb_interface_id(c, f);
>  	if (status < 0)
>  		goto err_free_fu;
> +
> +	iad_desc.bFirstInterface = status;

Shouldn't this be needed without your change?

thanks,

greg k-h
