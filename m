Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386995603CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiF2PFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiF2PE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:04:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F59FE7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656515097; x=1688051097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7eAnJIHWyOFB5EOuayi5Sk5n3trLR8ejcLuLMPW2Au0=;
  b=MKxuzWhxczlzZhJoEQSylIhxiofo0UGOkd4szXMfElA2S0ohsZQISntG
   py2YJY8VZ56tvGLus2sbvH4OK2M0wKu6c5pknbccveSdjTDe3ssYaBdot
   3EarIHWYdZIwLCYuBEEk2Uut9KXjpDGwEedhtE7Tmkt5LmYlN6GhhoF+S
   xJzB/tBXIY9gquKsrWMNOIEfxKgj7tc1NgmjpgvzYfvO9A/94Q9rYtFKk
   krqsKTPvNUrpsf6YHcmvt3sRncBpnMaFnINpejgjWMMKvcaXDwJIX3vJN
   qfy8+SIfILcIcDoH4oSyrbVs7A80Ev8Amx6eh+MsLrk8QcDtXmwfQGfWa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282788409"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="282788409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:04:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="917633192"
Received: from jwacker-mobl.amr.corp.intel.com (HELO [10.213.178.109]) ([10.213.178.109])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:04:29 -0700
Message-ID: <352fac7e-597c-84af-d33b-bdff0e2acdb6@linux.intel.com>
Date:   Wed, 29 Jun 2022 10:03:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] ASoC: codecs: add wsa883x amplifier support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
 <20220629090644.67982-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220629090644.67982-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +/* 4 ports */
> +static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA883X_MAX_SWR_PORTS] = {
> +	{
> +		/* DAC */
> +		.num = 1,
> +		.type = SDW_DPN_SIMPLE,
> +		.min_ch = 1,
> +		.max_ch = 1,
> +		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
> +	}, {

nit-pick: it's unusual to see such opening brackets for structure
initialization, usually there are on a new line.

> +		/* COMP */
> +		.num = 2,
> +		.type = SDW_DPN_SIMPLE,
> +		.min_ch = 1,
> +		.max_ch = 1,
> +		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
> +	}, {
> +		/* BOOST */
> +		.num = 3,
> +		.type = SDW_DPN_SIMPLE,
> +		.min_ch = 1,
> +		.max_ch = 1,
> +		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
> +	}, {
> +		/* VISENSE */
> +		.num = 4,
> +		.type = SDW_DPN_SIMPLE,
> +		.min_ch = 1,
> +		.max_ch = 1,
> +		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
> +	}
> +};

> +static int wsa883x_update_status(struct sdw_slave *slave,
> +				 enum sdw_slave_status status)
> +{
> +	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
> +
> +	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)

do you actually need to test if slave->dev_num is > 0?

if I look at drivers/soundwire/bus.c, update_status cannot really be
invoked with dev_num == 0.

> +		wsa883x_init(wsa883x);
> +
> +	return 0;
> +}
> +

> +static int __maybe_unused wsa883x_runtime_resume(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct regmap *regmap = dev_get_regmap(dev, NULL);
> +	struct wsa883x_priv *wsa883x = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(wsa883x->vdd);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable vdd regulator (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	gpiod_direction_output(wsa883x->sd_n, 1);
> +
> +	wait_for_completion_timeout(&slave->initialization_complete,
> +				    msecs_to_jiffies(WSA883X_PROBE_TIMEOUT));

check for success? You don't want to enable regmap sync below if the
device never successfully attached and initialized.

> +
> +	usleep_range(20000, 20010);
> +	regcache_cache_only(regmap, false);
> +	regcache_sync(regmap);
> +
> +	return 0;
> +}

