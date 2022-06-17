Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B206B54FDE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbiFQTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFQTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:47:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CCB64F2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655495260; x=1687031260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UArsJI0e93/zPeU0GTpsxAfxvbVJorGPGyLoU1Vq9ig=;
  b=c8qjOmPndDbIRr1L1dWL+6OJp83oJTrUAjSysGucTcjT/gEm7nnBadny
   vAF18F/UCam8I7zAIa4AaP2m2qr0Qzh6LRZdWRSDCbSF2xu2GVo1vUkut
   tnJUGp1zn44dNhzFe7mDkR7l3CxGNZyL8uf7gyIYfx6+9ZisXl8VuiGFW
   Snl6N3o9X5lbi5tN12RBNvJO9zQHtEBSvEYlMBwgRI14bc3c6UvyMEtZk
   +bsUAiF3H4tk2njas6oZ/NWQWX1hQ7OOfjwkJQdYYCD1CLo02p86NiQnS
   fu9xhNnl50LhStsOm4g2gIfYBQs2+G+UyBHeJocWqgt944ILC7igxeY7i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279607011"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279607011"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 12:47:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642163174"
Received: from patelman-mobl1.amr.corp.intel.com (HELO [10.212.115.29]) ([10.212.115.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 12:47:39 -0700
Message-ID: <e993c4c7-a956-b669-f5b5-5d42c8b35f1e@linux.intel.com>
Date:   Fri, 17 Jun 2022 14:47:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 03/11] ASoC: soc-component: use
 pm_runtime_resume_and_get()
Content-Language: en-US
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
 <20220616220427.136036-4-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220616220427.136036-4-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 17:04, Pierre-Louis Bossart wrote:
> simplify the flow. No functionality change, except that on -EACCESS
> the reference count will be decreased.

This patch turns out to be incorrect and should not be merged.

I missed the fact that the component pm_runtime_put() will decrease the
reference count that is already decreased with
pm_runtime_resume_and_get() when pm_runtime is not enabled. This leads
to warnings:

snd-soc-dummy snd-soc-dummy: Runtime PM usage count underflow!

Unfortunately we missed those warnings during validation, that's not so
good.

pm_runtime_resume_and_get() really needs to be used ONLY when the
get/put are part of the same function and the reference count can be
checked. When the get/put are in different functions, it's asking for
trouble.

Also the check on -EACCES is problematic when the component is handled
by a framework, it's not clear if that can happen or not.

The rest of the patches follow the pattern get_sync/put and don't have a
problem.

Sorry for the noise.

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  sound/soc/soc-component.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
> index e12f8244242b9..cb92e002c38bc 100644
> --- a/sound/soc/soc-component.c
> +++ b/sound/soc/soc-component.c
> @@ -1213,11 +1213,11 @@ int snd_soc_pcm_component_pm_runtime_get(struct snd_soc_pcm_runtime *rtd,
>  	int i;
>  
>  	for_each_rtd_components(rtd, i, component) {
> -		int ret = pm_runtime_get_sync(component->dev);
> -		if (ret < 0 && ret != -EACCES) {
> -			pm_runtime_put_noidle(component->dev);
> +		int ret = pm_runtime_resume_and_get(component->dev);
> +
> +		if (ret < 0 && ret != -EACCES)
>  			return soc_component_ret(component, ret);
> -		}
> +
>  		/* mark stream if succeeded */
>  		soc_component_mark_push(component, stream, pm);
>  	}
