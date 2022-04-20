Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4109508EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381395AbiDTSC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381459AbiDTSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:02:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B15BED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650477590; x=1682013590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZPYh6ii3d6sit1IsGVPNN+fvydkX/ToCt0Ocqq0aUxE=;
  b=Xv+wy1P94wmB670kpEO70Am6mGM5aUl/wiAhOr0O8trgMs5v7Yiora6D
   p+O0ESMHuL2r7eqSROoe4JG8goXqhy5NyK91oRYGgJh6jQ3WsH3UcQb/D
   3SMYRr0Ay0LyhHCWbRDQgtEqrDmF5z1/Cq7MbTZrquCFOhgRUnlPrPD4E
   4wvceK9e4p4UafhY4ourdUaiKNt2oltuRKAnDwbY5lGmJqtqe9cKFl6ZR
   plGqe8R/UCeUu3UwopqtfazFWf4A4PwFNVeOlmOtBG2dVsY94IbTADHKx
   s4rBOxIl698q2Bhdz3pcdOjdPKFnF9P/oX4PmrogOd1N4ZJg4ccHLlM02
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327013175"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="327013175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:59:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576721826"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO [10.209.100.171]) ([10.209.100.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:59:46 -0700
Message-ID: <b1b0a8b9-5fc2-bfe1-dfde-692a0a7ac34a@linux.intel.com>
Date:   Wed, 20 Apr 2022 12:59:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v4] ASoC: codecs: wsa881x: add runtime pm support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        quic_srivasam@quicinc.com
References: <20220228144235.24208-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220228144235.24208-1-srinivas.kandagatla@linaro.org>
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

Hi Srini,

> +static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct regmap *regmap = dev_get_regmap(dev, NULL);
> +	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
> +
> +	gpiod_direction_output(wsa881x->sd_n, 1);
> +
> +	wait_for_completion_timeout(&slave->initialization_complete,
> +				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));

while I was revisiting pm_runtime support, I also saw that this codec driver is the only one that doesn't check for errors

max98373-sdw.c: time = wait_for_completion_timeout(&slave->initialization_complete,

rt1308-sdw.c:   time = wait_for_completion_timeout(&slave->initialization_complete,

rt1316-sdw.c:   time = wait_for_completion_timeout(&slave->initialization_complete,

rt5682-sdw.c:   time = wait_for_completion_timeout(&slave->initialization_complete,

rt5682.c:                       &slave->initialization_complete,

rt700-sdw.c:    time = wait_for_completion_timeout(&slave->initialization_complete,

rt711-sdca-sdw.c:       time = wait_for_completion_timeout(&slave->initialization_complete,

rt711-sdw.c:    time = wait_for_completion_timeout(&slave->initialization_complete,

rt715-sdw.c:    time = wait_for_completion_timeout(&slave->initialization_complete,

wsa881x.c:      wait_for_completion_timeout(&slave->initialization_complete,


If the attachment fails for some reason, you probably want to avoid starting regmap syncs that will fail by construction, no?

> +
> +	regcache_cache_only(regmap, false);
> +	regcache_sync(regmap);
> +
> +	return 0;
> +}
