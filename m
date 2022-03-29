Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F61F4EA707
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiC2FTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiC2FT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BF8198963
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E47E61475
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D5CC2BBE4;
        Tue, 29 Mar 2022 05:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648531064;
        bh=X8Qn7F6rC63/GnRr6CPPqirj9apFFFA15tfuNaZx/dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odRgAPa6JVZhXGW6VKWu6cRxX3IGgrtVRxbl8TfWkRw9Ue1iJvw9N5NIcEZX49De7
         f0w+h8UCK2oogrgLKdA+AnrFdsXLcohCoQ5+knCQDU9h8EjMEbCqPBirDs2arYz3vv
         9wPB/JJ5Xu2eEIcbfClUWyBfA107yJDfZr1HLkck=
Date:   Tue, 29 Mar 2022 07:17:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     vaibhav.sr@gmail.com, dan.carpenter@oracle.com,
        mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: audio_codec: initialize data to silence static
 checker warnings
Message-ID: <YkKWdcI2AdidmqOv@kroah.com>
References: <20220329015913.10420-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329015913.10420-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:59:13AM +0800, Xiaomeng Tong wrote:
> These three declares are here:
> 	struct gbaudio_data_connection *data;
> 
> Since all three of these functions check for if the codec->module_list is
> empty at the start of the function so these are not real bugs to bypass
> 'if (!data) {'. To avoid static checker warnings like Smatch, initialize
> the data with NULL.
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index b589cf6b1d03..939e05af4dcf 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -397,7 +397,7 @@ static int gbcodec_hw_params(struct snd_pcm_substream *substream,
>  	u8 sig_bits, channels;
>  	u32 format, rate;
>  	struct gbaudio_module_info *module;
> -	struct gbaudio_data_connection *data;
> +	struct gbaudio_data_connection *data = NULL;
>  	struct gb_bundle *bundle;
>  	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
>  	struct gbaudio_stream_params *params;
> @@ -498,7 +498,7 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
>  {
>  	int ret;
>  	struct gbaudio_module_info *module;
> -	struct gbaudio_data_connection *data;
> +	struct gbaudio_data_connection *data = NULL;
>  	struct gb_bundle *bundle;
>  	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
>  	struct gbaudio_stream_params *params;
> @@ -562,7 +562,7 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
>  static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
>  {
>  	int ret;
> -	struct gbaudio_data_connection *data;
> +	struct gbaudio_data_connection *data = NULL;
>  	struct gbaudio_module_info *module;
>  	struct gb_bundle *bundle;
>  	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
> -- 
> 2.17.1
> 
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
