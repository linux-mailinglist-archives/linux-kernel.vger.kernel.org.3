Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E250E4C28AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiBXJzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiBXJzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:55:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D1F28571D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:55:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63AE260B4B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A4EC340E9;
        Thu, 24 Feb 2022 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645696513;
        bh=/n75j2+vxgqqryZGybH7IthNrDj1w6prdozxYse9SUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkaey1ITcpR7c7EjwedBuhUzAG0S/M7sD+ClXNymg+LsuPFABd3j70d3o8r7R4qEa
         cKZpCk1/pDoeLT0PW0y9PI5UpsPWKVFGhkCCN40t0JnA8NfxVZMS3Qiu3TsesTuCNP
         vBMPJQ7fJ2pycFiyeJP//s3/skccbBWIxmR+hMWihtkAkztXlE1zDM//yfDIqVXUcS
         11zU2+oy5Ls3yuPcvKBuY8II0ZH5kRoZyj/u2zarp81DhQuyn7bC4fVW7Ouy8/r3fI
         WdtGzbsD8cMGebTfrVNaEmPnIieDVviSu1a7EMPTVs2BiDiJAQC/KUrudUTLl+d0aC
         0vL01pqzSFqbg==
Date:   Thu, 24 Feb 2022 15:25:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V1 1/1] ASoC: compress: propagate the error code from the
 compress framework
Message-ID: <YhdV/ZsxJ3J+3JK5@matsya>
References: <cover.1645689841.git.quic_rbankapu@quicinc.com>
 <ec8263009612ead127398ba089f84dafb9fcfa88.1645689841.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec8263009612ead127398ba089f84dafb9fcfa88.1645689841.git.quic_rbankapu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 13:56, Raghu Bankapur wrote:
> Propagate the error code from the compress framework for the timestamp
> query. This error code will be used by the client to handle the
> error case scenarios gracefully.
> 
> Signed-off-by: Raghu Bankapur <quic_rbankapu@quicinc.com>
> ---
>  sound/core/compress_offload.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index de514ec8c83d..b89adbf666b1 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -166,9 +166,12 @@ static int snd_compr_free(struct inode *inode, struct file *f)
>  static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
>  		struct snd_compr_tstamp *tstamp)
>  {
> +	int ret = 0;

why initialize here, also pls leave an empty line here

>  	if (!stream->ops->pointer)
>  		return -ENOTSUPP;
> -	stream->ops->pointer(stream, tstamp);
> +	ret = stream->ops->pointer(stream, tstamp);
> +	if (ret)
> +		return ret;
>  	pr_debug("dsp consumed till %d total %d bytes\n",
>  		tstamp->byte_offset, tstamp->copied_total);
>  	if (stream->direction == SND_COMPRESS_PLAYBACK)
> -- 
> 2.17.1

-- 
~Vinod
