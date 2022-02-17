Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400F64BA61B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbiBQQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiBQQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:37:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9FE1DA0EE;
        Thu, 17 Feb 2022 08:37:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38AB06169D;
        Thu, 17 Feb 2022 16:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FAC340E8;
        Thu, 17 Feb 2022 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645115837;
        bh=Uh7SxgDiyle9Pt/1uKaz13Cdta+fG3LaUxSIrP3UDS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEfugztLGZ7KhKwtqEn9223T5MTF3xJxhO3dM2rtP9knaPDX97ekj22/Z1Ab70pBN
         4YNpm1mvWitXZ54ygxOgXm4QD0J1YXv3SX5zTMAws+LvFC99vaz3nRr3GjzFrsAqSZ
         /RpkNgGF8xxDs1g4J1ziT97ggzP23ySrpk5wwnGzl2eutVtCIZIDVyqvwyvfd6EuML
         TxPJ3n2XK3XEwexOe24bDRnFFV9jvNSNLPW8QiMAQiVG9KlwkTWiAsItK8E4chdWRH
         tzV+xyCwVuO1ULuUZkMv2495aU5ht22ip6UyTRrMOKgsp3VuD1nKzReRfrAqum4E9y
         pgosy2BeSWmeg==
Date:   Thu, 17 Feb 2022 10:44:58 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org,
        linux-hardening@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: Replace zero-length array with flexible-array
 member
Message-ID: <20220217164458.GA932472@embeddedor>
References: <20220217132755.1786130-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217132755.1786130-1-steve@sk2.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:27:55PM +0100, Stephen Kitt wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members"[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Link: https://github.com/KSPP/linux/issues/180
> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  include/sound/sof/topology.h | 2 +-
>  sound/soc/sof/topology.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
> index d12736e14b69..adee6afd1490 100644
> --- a/include/sound/sof/topology.h
> +++ b/include/sound/sof/topology.h
> @@ -237,7 +237,7 @@ struct sof_ipc_comp_process {
>  	/* reserved for future use */
>  	uint32_t reserved[7];
>  
> -	uint8_t data[0];
> +	uint8_t data[];
>  } __packed;
>  
>  /* frees components, buffers and pipelines
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index e72dcae5e7ee..1d119d1dd69d 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -2164,7 +2164,7 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
>  	 */
>  	if (ipc_data_size) {
>  		for (i = 0; i < widget->num_kcontrols; i++) {
> -			memcpy(&process->data + offset,
> +			memcpy(&process->data[offset],
>  			       wdata[i].pdata->data,
>  			       wdata[i].pdata->size);
>  			offset += wdata[i].pdata->size;
> 
> base-commit: f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
> -- 
> 2.27.0
> 
