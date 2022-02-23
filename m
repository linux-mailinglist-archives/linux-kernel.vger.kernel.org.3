Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C94C1858
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiBWQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiBWQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:18:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D13B2A7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645633056; x=1677169056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kdFETTBddN7EdBnhGYgG52WV2uKpzlnZnEFWwu9QLo0=;
  b=iavcHd4mHZoGZtmtN4DJ+o7MlpDrFBt0nVZdHriz3o2EgO/vNxnyZl+l
   n/moscgjFpLMdph9dlD7k7hb5aGvImNxNXOQsp9BuMj/DBKmlxd37zOoc
   XbywTZmseH5+85anjnmw4u/vGBXdnotgJCbr88YgdRTAIOkRmRiq2lunQ
   p+5DRSXP9LnVSjFOlC2YH5xWHhoaDXasdpig8DPp9YpX4+4ZGRxTeo8M0
   361Jb+3tsZkBfGjJA6P+DOdBPvMYG2PtJeF1Pwp/b47BFX3SPcoTW4rYl
   EC396yi3oCU841W37UboGA3qcJwT+yf1lmams9x1GEXzeFT21HejRHgVF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251740390"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="251740390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 08:10:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="548312807"
Received: from vermaama-mobl.ger.corp.intel.com (HELO [10.252.44.244]) ([10.252.44.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 08:09:57 -0800
Message-ID: <16567e15-2ea5-60cc-74bd-97475b793a57@linux.intel.com>
Date:   Wed, 23 Feb 2022 18:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] ASoC: SOF: pcm: Add compress_ops for SOF platform
 component driver
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
References: <20220223153849.84471-1-daniel.baluta@oss.nxp.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220223153849.84471-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2022 17:38, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Now that sof_compressed_ops initial implementation was merged
> we can enable it in SOF platform component driver.

and fixes the following sparse error:
sound/soc/sof/compress.c:310:25: error: symbol 'sof_compressed_ops' was
not declared. Should it be static?

> This partially reverts commit
> 8a720724589e ("ASoC: SOF: pcm: Remove non existent CONFIG_SND_SOC_SOF_COMPRESS reference")

Back at that time there were _no_ sof_compressed_ops in the tree...

> Reported-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/sof/pcm.c      | 4 ++++
>  sound/soc/sof/sof-priv.h | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
> index 137f8ed71677..a312ed855f1a 100644
> --- a/sound/soc/sof/pcm.c
> +++ b/sound/soc/sof/pcm.c
> @@ -922,6 +922,10 @@ void snd_sof_new_platform_drv(struct snd_sof_dev *sdev)
>  	pd->pointer = sof_pcm_pointer;
>  	pd->ack = sof_pcm_ack;
>  
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMPRESS)
> +	pd->compress_ops = &sof_compressed_ops;
> +#endif
> +
>  	pd->pcm_construct = sof_pcm_new;
>  	pd->ignore_machine = drv_name;
>  	pd->be_hw_params_fixup = sof_pcm_dai_link_fixup;
> diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
> index 2c8e556cd5cc..886787a9997f 100644
> --- a/sound/soc/sof/sof-priv.h
> +++ b/sound/soc/sof/sof-priv.h
> @@ -556,6 +556,11 @@ int snd_sof_debugfs_add_region_item_iomem(struct snd_sof_dev *sdev,
>  		enum snd_sof_fw_blk_type blk_type, u32 offset, size_t size,
>  		const char *name, enum sof_debugfs_access_type access_type);
>  
> +/*
> + * Platform specific ops.
> + */
> +extern struct snd_compress_ops sof_compressed_ops;

This is not really platform ops?

> +
>  /*
>   * DSP Architectures.
>   */

-- 
Péter
