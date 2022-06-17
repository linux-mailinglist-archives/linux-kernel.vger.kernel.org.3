Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410654FE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbiFQUCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiFQUCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:02:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C345AA42;
        Fri, 17 Jun 2022 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655496126; x=1687032126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIOPDztJcbgiHuxrPZa6CZEtsLYHu/u1qnz0FsmldL4=;
  b=BQbMY8V5mVe1yhlH1WZA/SUfn9R5ttiEiQvL2Bgau911PmsKiJP1aEIQ
   STWZHvNC5CFrwTtYkM6Hv2kKYzTihC92QFLQzZJoOr+GrRzDoPS8+0khW
   uhSf3ePVocAlZrIeBJyfSEan2CWTRoDuwKWZUF8zlq8HSpQUEs5Xs/JAn
   uWMGlCvF/QFQr8yh5EklFJWHaV/r0xPdaZWQvYVTC4xM4286KDEnMMTeC
   /z0kv84dPILMeT4BbY4+WxRzMC7BidMMiiFYisLUfMz5MwefWbtYTnX+a
   JOucasE0enowtZayEXuchZ/RBTek8ZJcHFEkfs9RmYHX96ZcWcnc2dBFd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365901199"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365901199"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 13:02:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642167729"
Received: from patelman-mobl1.amr.corp.intel.com (HELO [10.212.115.29]) ([10.212.115.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 13:02:05 -0700
Message-ID: <ad76d0d9-22f9-5e35-8575-bf7a78bd1568@linux.intel.com>
Date:   Fri, 17 Jun 2022 15:02:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: ops: Fix multiple value control type
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com
References: <1655492828-5471-1-git-send-email-spujar@nvidia.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1655492828-5471-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/22 14:07, Sameer Pujar wrote:
> The commit aa2a4b897132("ASoC: ops: Fix boolean/integer detection for
> simple controls") fixes false positives with controls not ending in
> " Volume" string. But it now forces boolean type for the multi value
> controls. Fix this by adding a max check before assigning types.
> 
> Fixes: aa2a4b897132("ASoC: ops: Fix boolean/integer detection for simple controls")
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This fixes the second regression we noticed today, with mixer values
such as:

numid=5,iface=MIXER,name='PGA4.0 4 Master Capture Volume'
  ; type=BOOLEAN,access=rw---R--,values=2
  : values=on,on
  | dBscale-min=-50.00dB,step=1.00dB,mute=1

This caused an across-the-board fail with alsa-bat tests

https://github.com/thesofproject/linux/pull/3702

Thanks Sameer!

> ---
>  sound/soc/soc-ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
> index 0267e39..21be8e8 100644
> --- a/sound/soc/soc-ops.c
> +++ b/sound/soc/soc-ops.c
> @@ -190,7 +190,7 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
>  			vol_string = NULL;
>  	}
>  
> -	if (!vol_string)
> +	if (!vol_string && max == 1)
>  		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
>  	else
>  		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
