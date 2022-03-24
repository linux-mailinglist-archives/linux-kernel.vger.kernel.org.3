Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8F44E6062
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348931AbiCXIfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiCXIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:35:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B09BB89
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B0A6CE235C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D8CC340EC;
        Thu, 24 Mar 2022 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648110823;
        bh=l7p+lzVuxSNaywoNSXcl3ZMeNQOe1Z3EcdoxDxqSA5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u65XJ496YyPFCe0kGzD3+E80pvKbjzpOl2ZkXKk1lGHOZnw6J2MXaEIbBd692wc6n
         Qk5dFHTWg6U2NHJdaws0VjXp/ZYgvOZW0Mc0QxmJdDjIN7nnxxll3XzcLkdbPpvLQV
         Oaf9O7fqP0e9SBygVx7gFJp1aIBSCNK72NvjHfbk=
Date:   Thu, 24 Mar 2022 09:33:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: Re: [PATCH v1 1/3] sound: usb: Add vendor's hooking interface
Message-ID: <Yjws5IhAqos5LDM+@kroah.com>
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
 <CGME20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b@epcas2p4.samsung.com>
 <1648109444-196321-2-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648109444-196321-2-git-send-email-eomji.oh@samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 05:10:42PM +0900, Oh Eomji wrote:
> In mobile, a co-processor can be used with USB audio to improve power
> consumption.  To support this type of hardware, hooks need to be added
> to the USB audio subsystem to be able to call into the hardware when
> needed.
> 
> The main operation of the call-backs are:
>   - Initialize the co-processor by transmitting data when initializing.
>   - Change the co-processor setting value through the interface
>     function.
>   - Configure sampling rate
>   - pcm open/close
>   - other housekeeping
> 
> Known issues:
>   - This only supports one set of callback hooks, meaning that this only
>     works if there is one type of USB controller in the system.  This
>     should be changed to be a per-host-controller interface instead of
>     one global set of callbacks.
> 
> Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
> Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
> ---
>  sound/usb/card.c     | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  sound/usb/card.h     |  20 +++++++++
>  sound/usb/usbaudio.h |  45 +++++++++++++++++++
>  3 files changed, 184 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 3769622..bd59311 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -117,6 +117,117 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>  static DEFINE_MUTEX(register_mutex);
>  static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>  static struct usb_driver usb_audio_driver;
> +static struct snd_usb_audio_vendor_ops *usb_vendor_ops;
> +
> +int snd_vendor_set_ops(struct snd_usb_audio_vendor_ops *ops)
> +{
> +	if ((!ops->connect) ||
> +	    (!ops->disconnect) ||
> +	    (!ops->set_interface) ||
> +	    (!ops->set_rate) ||
> +	    (!ops->set_pcm_buf) ||
> +	    (!ops->set_pcm_intf) ||
> +	    (!ops->set_pcm_connection) ||
> +	    (!ops->set_pcm_binterval) ||
> +	    (!ops->usb_add_ctls))
> +		return -EINVAL;
> +
> +	usb_vendor_ops = ops;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_vendor_set_ops);
> +
> +struct snd_usb_audio_vendor_ops *snd_vendor_get_ops(void)
> +{
> +	return usb_vendor_ops;
> +}

This is the function you need to fix up, and add proper reference
counting to, in order to solve your "this breaks with multiple USB
controllers" problem.  So this really should not be all that difficult
of a task.  Why has it taken years to do so?

thanks,

greg k-h
