Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F65A7CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiHaMDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiHaMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:02:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F3D2905;
        Wed, 31 Aug 2022 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661947378; x=1693483378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HW2JFCNdRJHhOepmkl12B9zePyb16TeBouVweEP1hbE=;
  b=c4YTCrW70UqfTkyxo5dSoXL21Wp8SXcgRh1i6VqYeWS3VvnZLIfcU0Y1
   bn0u4LEwU8jS1HZEBnzyP+aUbbY4heS+pSS/FkCBmlpuAxGOOfS/DLQ1V
   +PzMm/qE7xUAtUoMGwHTJEqDKB0fLyiBCwMW2kZjRqZeyna1vQVHlSgWW
   GkRthx1/uP3wfQkwes07jRsQOto8/nj7As8PIQ783OjdIj/LZhPUlMPGm
   WuwaZyJmUx9W2W5L67oNJcMRJBGNjWRty3g564mqgrYm0aZnfdcUnEsVU
   5U9CQW3sRBzwPE4G/vTkOk3Kh7uFXrQdo0b41otdakwuzSPIRS6Ik/ufV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296710701"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="296710701"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:02:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="701341488"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:02:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTMQk-006MXt-0s;
        Wed, 31 Aug 2022 15:02:50 +0300
Date:   Wed, 31 Aug 2022 15:02:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com,
        rahul.tanwar@linux.intel.com
Subject: Re: [PATCH v3 11/19] hwmon: (mr75203) add VM pre-scaler support
Message-ID: <Yw9N6sr+k/4lcmT7@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-12-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-12-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:04PM +0000, Eliav Farber wrote:
> Add mr76006 pre-scaler support to normalize the voltage output result for
> channels that use pre-scaler units to get the measurement to be within
> the range that the sensor supports.
> 
> For channels that are listed in the device-tree to have a pre-scaler, the
> voltage result is multiplied by a factor of 2, to represent to the user
> the actual voltage source which is measured.

...

> +static int pvt_get_pre_scaler(struct device *dev, struct pvt_device *pvt)
> +{
> +	const struct device_node *np = dev->of_node;
> +	u32 total_channels = pvt->vm_channels.total;
> +	u32 channel;
> +	u8 *pre_scaler_ch_list;
> +	int i, ret, num_ch;
> +
> +	/* Set default pre-scaler value to be 1. */
> +	for (i = 0; i < total_channels; i++)
> +		pvt->vd[i].pre_scaler = PRE_SCALER_X1;
> +
> +	/* Get number of channels configured in "moortec,vm-pre-scaler". */
> +	num_ch = of_property_count_u8_elems(np, "moortec,vm-pre-scaler");

of_ ?!

> +	if (num_ch <= 0)
> +		return 0;
> +
> +	pre_scaler_ch_list = kcalloc(total_channels,
> +				     sizeof(*pre_scaler_ch_list), GFP_KERNEL);
> +	if (!pre_scaler_ch_list)
> +		return -ENOMEM;
> +
> +	/* Get list of all channels that have pre-scaler of 2. */
> +	ret = device_property_read_u8_array(dev, "moortec,vm-pre-scaler",
> +					    pre_scaler_ch_list, num_ch);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < num_ch; i++) {
> +		channel = pre_scaler_ch_list[i];

> +

Unnecessary blank line.

> +		if (channel >= total_channels) {
> +			dev_err(dev,
> +				"invalid channel (%u) in pre-scaler list\n",
> +				channel);
> +			ret = -EINVAL;

> +			goto out;

Wouldn't

			break;

suffice? (I understand the point, up to you)

> +		}
> +
> +		pvt->vd[channel].pre_scaler = PRE_SCALER_X2;
> +	}
> +
> +out:

out_free:

> +	kfree(pre_scaler_ch_list);
> +
> +	return ret;
> +}


-- 
With Best Regards,
Andy Shevchenko


