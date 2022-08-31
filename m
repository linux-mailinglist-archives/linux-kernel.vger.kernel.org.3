Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1E5A7C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiHaLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaLsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:48:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CBCC12D4;
        Wed, 31 Aug 2022 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661946491; x=1693482491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dbY9Kt7YVbtqJr0JU9eSAN6j3JA7u7NZVv1zVrh2KbI=;
  b=M0AGaDRTkRO12d+/cyZzBWfxKfAPWeDB6Sr7qBnlVXpSB9uo/VDtiAAG
   mH/mL3WHXFQPg5twKKXlRnYWshkq9P4mJc9vddV9Zf9d8/ZCHGeLoOvRi
   oKjlMLTF2Ob0VBB98ZgJ2rXS2pXVz/sbHoOg1x5xe9fYzezRlWq5uw1nn
   VYprE4nnmJh09FZC0LXL4duCH0PX/dcHIdVlpCC+5RKdxJJAquW74yUPN
   QQ2mLs8Lbiv5B4gPvTIK3jtdr65TYHDFCWxuuP/20PYIDuY95/89XFaop
   RoDwsA55sv9SnG5YfCLVwR+LwNlVKwAHM3NpPs+/gQv5txInH7pPWwP7G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296213314"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="296213314"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 04:48:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="645205782"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 04:48:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTMCQ-006MI7-1z;
        Wed, 31 Aug 2022 14:48:02 +0300
Date:   Wed, 31 Aug 2022 14:48:02 +0300
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
Subject: Re: [PATCH v3 09/19] hwmon: (mr75203) add VM active channel support
Message-ID: <Yw9KcvaFzCcPw7qw@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-10-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-10-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:02PM +0000, Eliav Farber wrote:
> Add active channel support per voltage monitor.
> The number of active channels is read from the device-tree.
> When absent in device-tree, all channels are assumed to be used.
> 
> This shall be useful to expose sysfs only for inputs that are connected
> to a voltage source.
> 
> Setting number of active channels to 0, means that entire VM sensor is
> not used.

...

> +struct voltage_device {
> +	u32 vm_map;	/* Map channel number to VM index */
> +	u32 ch_map;	/* Map channel number to channel index */
> +};
> +
> +struct voltage_channels {
> +	u32 total;	/* Total number of channels in all VMs */
> +	u8 max;		/* Maximum number of channels among all VMs */
> +};

Why not convert them to kernel doc?

...

> +	ret = device_property_read_u8_array(dev, "moortec,vm-active-channels",
> +					    vm_active_ch, vm_num);
> +	if (ret) {
> +		/*
> +		 * Incase vm-active-channels property is not defined,
> +		 * we assume each VM sensor has all of its channels
> +		 * active.
> +		 */
> +		for (i = 0; i < vm_num; i++)
> +			vm_active_ch[i] = ch_num;

NIH memset().

> +		pvt->vm_channels.max = ch_num;
> +		pvt->vm_channels.total = ch_num * vm_num;
> +	} else {
> +		for (i = 0; i < vm_num; i++) {
> +			if (vm_active_ch[i] > ch_num) {
> +				dev_err(dev, "invalid active channels: %u\n",
> +					vm_active_ch[i]);
> +				return -EINVAL;
> +			}
> +
> +			pvt->vm_channels.total += vm_active_ch[i];
> +
> +			if (vm_active_ch[i] > pvt->vm_channels.max)
> +				pvt->vm_channels.max = vm_active_ch[i];
> +		}
> +	}

...

> +	k = 0;
> +	for (i = 0; i < vm_num; i++)
> +		for (j = 0; j < vm_active_ch[i]; j++) {
> +			pvt->vd[k].vm_map = vm_idx[i];
> +			pvt->vd[k].ch_map = j;

> +			k++;

How is it different from moving this outside the inner loop as

	k += vm_active_ch[i];

?

> +		}

Missed outer {}.


-- 
With Best Regards,
Andy Shevchenko


