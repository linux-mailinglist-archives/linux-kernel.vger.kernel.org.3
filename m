Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F01485143
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiAEKmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:42:21 -0500
Received: from cable.insite.cz ([84.242.75.189]:49421 "EHLO cable.insite.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239468AbiAEKmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:42:19 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 05:42:19 EST
Received: from localhost (localhost [127.0.0.1])
        by cable.insite.cz (Postfix) with ESMTP id 8CCB8A1A3D405;
        Wed,  5 Jan 2022 11:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1641379022; bh=OrLuKcXAlnnN4decGJViJL+g4ZzqJD2LAN/oShAGcXs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mkFVChcOMouuWBUsenhrNpM6mbfqkblC5QALs3iodI+hGJCn+qPHCCqNnsoswbSmX
         pNaPjf6Z4nK8SFYeJ68Jl3y/JFsWjuyFuCUWFmbNZXbOWsi6etZXFvhBLCKgGEh7Jr
         XnCIkc3MG2jRkTQUdu6lyEhiiXxnHBk1obMe+jh0=
Received: from cable.insite.cz ([84.242.75.189])
        by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C7yyzBA8U1Ng; Wed,  5 Jan 2022 11:36:57 +0100 (CET)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
        (Authenticated sender: pavel)
        by cable.insite.cz (Postfix) with ESMTPSA id E02A1A1A3D404;
        Wed,  5 Jan 2022 11:36:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1641379017; bh=OrLuKcXAlnnN4decGJViJL+g4ZzqJD2LAN/oShAGcXs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bFqy0CqIkRqBTIijV6KB/CtSlMhp6tZ34UKUIHpUs/Mi/nNoi21MFJVlXoHsdi8Gv
         cPvONIDAFlB8go6hbBBj0OYfMNfjn3i7KJElPUcdRq/sVCCr7vSBhXSythaQtO4Jv6
         XkN2gGYiZTo4z72/uLZRCZQRE/sauvocvL9azuzY=
Subject: Re: [PATCH] usb: gadget: u_audio: fix calculations for small
 bInterval
To:     John Keeping <john@metanate.com>, linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220104183243.718258-1-john@metanate.com>
From:   Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <e3cae3a2-ef5c-2188-7fcf-b5b7dd9e4ba8@ivitera.com>
Date:   Wed, 5 Jan 2022 11:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104183243.718258-1-john@metanate.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dne 04. 01. 22 v 19:32 John Keeping napsal(a):
> If bInterval is 1, then p_interval is 8000 and p_interval_mil is 8E9,
> which is too big for a 32-bit value.  While the storage is indeed
> 64-bit, this value is used as the divisor in do_div() which will
> truncate it into a uint32_t leading to incorrect calculated values.
> 
> Switch back to keeping the base value in struct snd_uac_chip which fits
> easily into an int, meaning that the division can be done in two steps
> with the divisor fitting safely into a uint32_t on both steps.
> 
> Fixes: 6fec018a7e70 ("usb: gadget: u_audio.c: Adding Playback Pitch ctl for sync playback")
> Signed-off-by: John Keeping <john@metanate.com>


Tested-by: Pavel Hofman <pavel.hofman@ivitera.com>

> ---
>   drivers/usb/gadget/function/u_audio.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
> index c46400be5464..4fb05f9576a6 100644
> --- a/drivers/usb/gadget/function/u_audio.c
> +++ b/drivers/usb/gadget/function/u_audio.c
> @@ -76,8 +76,8 @@ struct snd_uac_chip {
>   	struct snd_pcm *pcm;
>   
>   	/* pre-calculated values for playback iso completion */
> -	unsigned long long p_interval_mil;
>   	unsigned long long p_residue_mil;
> +	unsigned int p_interval;
>   	unsigned int p_framesize;
>   };
>   
> @@ -194,21 +194,24 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
>   		 * If there is a residue from this division, add it to the
>   		 * residue accumulator.
>   		 */
> +		unsigned long long p_interval_mil = uac->p_interval * 1000000ULL;
> +
>   		pitched_rate_mil = (unsigned long long)
>   				params->p_srate * prm->pitch;
>   		div_result = pitched_rate_mil;
> -		do_div(div_result, uac->p_interval_mil);
> +		do_div(div_result, uac->p_interval);
> +		do_div(div_result, 1000000);
>   		frames = (unsigned int) div_result;
>   
>   		pr_debug("p_srate %d, pitch %d, interval_mil %llu, frames %d\n",
> -				params->p_srate, prm->pitch, uac->p_interval_mil, frames);
> +				params->p_srate, prm->pitch, p_interval_mil, frames);
>   
>   		p_pktsize = min_t(unsigned int,
>   					uac->p_framesize * frames,
>   					ep->maxpacket);
>   
>   		if (p_pktsize < ep->maxpacket) {
> -			residue_frames_mil = pitched_rate_mil - frames * uac->p_interval_mil;
> +			residue_frames_mil = pitched_rate_mil - frames * p_interval_mil;
>   			p_pktsize_residue_mil = uac->p_framesize * residue_frames_mil;
>   		} else
>   			p_pktsize_residue_mil = 0;
> @@ -222,11 +225,11 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
>   		 * size and decrease the accumulator.
>   		 */
>   		div_result = uac->p_residue_mil;
> -		do_div(div_result, uac->p_interval_mil);
> +		do_div(div_result, uac->p_interval);
> +		do_div(div_result, 1000000);
>   		if ((unsigned int) div_result >= uac->p_framesize) {
>   			req->length += uac->p_framesize;
> -			uac->p_residue_mil -= uac->p_framesize *
> -					   uac->p_interval_mil;
> +			uac->p_residue_mil -= uac->p_framesize * p_interval_mil;
>   			pr_debug("increased req length to %d\n", req->length);
>   		}
>   		pr_debug("remains uac->p_residue_mil %llu\n", uac->p_residue_mil);
> @@ -591,7 +594,7 @@ int u_audio_start_playback(struct g_audio *audio_dev)
>   	unsigned int factor;
>   	const struct usb_endpoint_descriptor *ep_desc;
>   	int req_len, i;
> -	unsigned int p_interval, p_pktsize;
> +	unsigned int p_pktsize;
>   
>   	ep = audio_dev->in_ep;
>   	prm = &uac->p_prm;
> @@ -612,11 +615,10 @@ int u_audio_start_playback(struct g_audio *audio_dev)
>   	/* pre-compute some values for iso_complete() */
>   	uac->p_framesize = params->p_ssize *
>   			    num_channels(params->p_chmask);
> -	p_interval = factor / (1 << (ep_desc->bInterval - 1));
> -	uac->p_interval_mil = (unsigned long long) p_interval * 1000000;
> +	uac->p_interval = factor / (1 << (ep_desc->bInterval - 1));
>   	p_pktsize = min_t(unsigned int,
>   				uac->p_framesize *
> -					(params->p_srate / p_interval),
> +					(params->p_srate / uac->p_interval),
>   				ep->maxpacket);
>   
>   	req_len = p_pktsize;
> 

