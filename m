Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E52508BED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378989AbiDTPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344823AbiDTPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:21:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B544A2A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650467945; x=1682003945;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+f8zw2+M+xo4E4iKHv4DnPjhY06IfOG5lA6m98XiFlk=;
  b=WO+3tYG/1leprZWcx98fKkWIPttOlp3yX5FD6Z7CHc/omwgvhfbG2Etx
   cFlQN/wNJO4oDAJQKhyu6kDol2TBIQjzKxLclIFzlPKZxFfxz2hX3iTbu
   zJfCuOzN+Bcrjy8CLohiYVmNpqZgBJ84hSzHH6RVobH+QrVNJJ3/A3igR
   QI+Mz1ZicHCCUazL7xJDmCkeduUV6Wu0iwEGHkh2H7W5aP9Vn8VfwRp1f
   B7recV/fElxD5c3SiBIfeiGDlaAHHiONDOi9VRX+E2n16UebITW00QU5b
   8GcSDyPO9j7zPZmikTHbY5GohNjuGiBwnLTktOe3zmwBr55zm6z6Oa4E9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="262908382"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="262908382"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:05:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576625740"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO [10.209.100.171]) ([10.209.100.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:05:36 -0700
Message-ID: <78c7edc3-f431-9735-238d-9aa2b45ec45e@linux.intel.com>
Date:   Wed, 20 Apr 2022 08:28:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: using pm_runtime_resume_and_get to simplify
 the code
To:     cgel.zte@gmail.com
Cc:     lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
Content-Language: en-US
In-Reply-To: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 22:03, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Well, maybe that's a simplification, but we've been using the same pattern for years now.

Is there really a clear direction to use this new function?

the overwhelming majority of drivers in sound/soc still rely on the pm_runtime_get_sync (111 v. 7).


> ---
>  sound/soc/sof/sof-client-probes.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
> index 797dedb26163..c4c6e03c8133 100644
> --- a/sound/soc/sof/sof-client-probes.c
> +++ b/sound/soc/sof/sof-client-probes.c
> @@ -503,10 +503,9 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0 && ret != -EACCES) {
>  		dev_err_ratelimited(dev, "debugfs read failed to resume %d\n", ret);
> -		pm_runtime_put_noidle(dev);
>  		goto exit;
>  	}
>  
> @@ -568,10 +567,9 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
>  
>  	desc = (struct sof_probe_point_desc *)tkns;
>  
> -	ret = pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0 && ret != -EACCES) {
>  		dev_err_ratelimited(dev, "debugfs write failed to resume %d\n", ret);
> -		pm_runtime_put_noidle(dev);
>  		goto exit;
>  	}
>  
> @@ -621,10 +619,9 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
>  		goto exit;
>  	}
>  
> -	ret = pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
>  		dev_err_ratelimited(dev, "debugfs write failed to resume %d\n", ret);
> -		pm_runtime_put_noidle(dev);
>  		goto exit;
>  	}
>  
