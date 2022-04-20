Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15203508EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381114AbiDTRoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359710AbiDTRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:44:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1BA47049;
        Wed, 20 Apr 2022 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650476481; x=1682012481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbZu7eWEid6dNs7PEy4WsbHQMUyRtvOvvbZT7aD6MhU=;
  b=bNa3FBoF5FnRcQc6cTFnI73IfR4KQQwyTelGlKyq4ycO56Z1ZSPKOET9
   R9IOoAQYLnB8b18rPkmWxEqrbgCOuHbGpZ5tSLoO1MDMQ8REOdPuo5/EB
   Z9DZD0MYRb07eEcTPsHzYzJn6luCgvMQimtO75drFJ5qvb6G1MprLivTU
   9ltlH6pNa8zpdtpM0JGm9fOosxi3/hHAjICGTvMcOY+tdQLo7h2G5OdJX
   MZ+kt8AP2yBnHL49JXSo5I0W7ZvW6OM8Z05Z/aTVg5VIOOoA3jxR59EGv
   fk4RF8GzzDXSaJ5IAWuO9VKP8+ilZmYXtD7q9phyHZqawXs+E9FREZcky
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251416868"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="251416868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:40:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576712395"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO [10.209.100.171]) ([10.209.100.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:40:56 -0700
Message-ID: <10eb3973-03c4-74cd-d28a-014fc280cdf8@linux.intel.com>
Date:   Wed, 20 Apr 2022 12:39:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] soundwire: qcom: add runtime pm support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220228172528.3489-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> @@ -1017,6 +1032,15 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *codec_dai;
>  	int ret, i;
>  
> +	ret = pm_runtime_get_sync(ctrl->dev);
> +	if (ret < 0 && ret != -EACCES) {
> +		dev_err_ratelimited(ctrl->dev,
> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    __func__, ret);
> +		pm_runtime_put_noidle(ctrl->dev);
> +		return ret;

here there's an error handling, but ...

> +	}
> +
>  	sruntime = sdw_alloc_stream(dai->name);
>  	if (!sruntime)
>  		return -ENOMEM;
> @@ -1044,6 +1068,9 @@ static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
>  
>  	sdw_release_stream(ctrl->sruntime[dai->id]);
>  	ctrl->sruntime[dai->id] = NULL;
> +	pm_runtime_mark_last_busy(ctrl->dev);
> +	pm_runtime_put_autosuspend(ctrl->dev);
> +
>  }
>  
>  static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
> @@ -1197,12 +1224,23 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  static int swrm_reg_show(struct seq_file *s_file, void *data)
>  {
>  	struct qcom_swrm_ctrl *swrm = s_file->private;
> -	int reg, reg_val;
> +	int reg, reg_val, ret;
> +
> +	ret = pm_runtime_get_sync(swrm->dev);
> +	if (ret < 0 && ret != -EACCES) {
> +		dev_err_ratelimited(swrm->dev,
> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    __func__, ret);
> +		pm_runtime_put_noidle(swrm->dev);

... here it's missing?

I have a fix ready but thought I would check first if this was intentional

https://github.com/thesofproject/linux/pull/3602/commits/6353eec8dc971c5f0fda0166ae1777f71784ea32

> +	}
>  
>  	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
>  		swrm->reg_read(swrm, reg, &reg_val);
>  		seq_printf(s_file, "0x%.3x: 0x%.2x\n", reg, reg_val);
>  	}
> +	pm_runtime_mark_last_busy(swrm->dev);
> +	pm_runtime_put_autosuspend(swrm->dev);
> +
>  
>  	return 0;
