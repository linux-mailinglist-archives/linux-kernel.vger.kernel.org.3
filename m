Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6B4AAADD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380887AbiBESYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:24:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:52614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbiBESYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644085485; x=1675621485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwdT3oPchGN+YP/B5MlgIYEIHZ80n73Pyrl4jYokB0U=;
  b=FHJt5M3jdVDNQX27zzu+2cNdi0GYxR/g3FB3z2PkORXMtJc3VFvmu8hE
   5UINF6lHU/sBV5mbgEG6UB/oeflMNC884X9jwTqsAEeW+Jd103jqYYC+x
   7hDRDq36nhsWze+blI6BNzOkKQi0/p/+LzcY7Tw5DL2U0Yd87IJzs4xn2
   7STCWsiyliF8HgbNtuTbv2vwdkdM4Ili+qrhIhoX0VUz+PvKwvRf4kHx0
   5XxzfWbRRtEZXVlRGMx+C8s4LwoxV5+vUwp7erLYHPnqSZmHAvpy6uZS8
   GTkOFRHmBZn//0AjBNUyF0QXgKIhtVDiWfhGekiIVKqsrbgNKZT2QOwpd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="228499102"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="228499102"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:24:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="524662254"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:24:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nGPip-001LL8-CX;
        Sat, 05 Feb 2022 20:23:43 +0200
Date:   Sat, 5 Feb 2022 20:23:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of device
 properties
Message-ID: <Yf7ArwPrN34drkcv@smile.fi.intel.com>
References: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
 <20220203114506.53904-2-andriy.shevchenko@linux.intel.com>
 <20220205171454.49a7225c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205171454.49a7225c@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 05:14:54PM +0000, Jonathan Cameron wrote:
> On Thu,  3 Feb 2022 13:45:06 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> 
> This description needs expansion as it's not a straight forward
> conversion.
> 
> Also, complex enough that I definitely want more eyes and preferably
> some testing.

That's fair. I also spent most of the time on this change in comparison to the
whole bundle.

...

> > +#include <asm/byteorder.h>
> > +#include <asm/unaligned.h>

> This may well be a valid addition but it's not called out in the patch
> description.

This is a side effect of the change. Below I will try to explain, tell me if
that is what you want to be added to the commit message (feel free to correct
my English).

The conversion slightly changes the logic behind property reading for the
configuration values. Original code allocates just as much memory as needed.
Then for each separate 32- or 64-bit value it reads it from the property
and converts to a raw one which will be fed to the sensor. In the new code
we allocated the amount of memory needed to retrieve all values at once from
the property and then convert them as required.

...

> >  	if (st->custom_table_size + new_custom->size >
> > -	    (LTC2983_CUST_SENS_TBL_END_REG -
> > -	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> > +	    (LTC2983_CUST_SENS_TBL_END_REG - LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> 
> Shouldn't really be in this patch. Or at very least call out that there is
> whitespace cleanup in the patch description.

Good catch! It's a leftover, one case became a patch 1 in this series.

...

> > +	if (is_steinhart)
> > +		ret = fwnode_property_read_u32_array(fn, propname, new_custom->table, n_entries);
> > +	else
> > +		ret = fwnode_property_read_u64_array(fn, propname, new_custom->table, n_entries);
> > +	if (ret < 0)
> > +		return ERR_PTR(ret);
> > +
> > +	/*
> > +	 * Steinhart sensors are configured with raw values in the device tree.
> > +	 * For the other sensors we must convert the value to raw. The odd
> > +	 * index's correspond to temperatures and always have 1/1024 of
> > +	 * resolution. Temperatures also come in Kelvin, so signed values is
> > +	 * not possible.
> > +	 */
> > +	if (is_steinhart) {
> 
> Perhaps would be cleaner to combine this if else with the one above at the cost
> of duplicating the if (ret < 0) check.

OK, I'm fine with either approach.

> > +		cpu_to_be32_array(new_custom->table, new_custom->table, n_entries);
> 
> I completely failed to register the hand coded big endian conversion.  Nice
> tidy up.  However, definitely something to call out in the patch description.

See above.

> > +	} else {
> > +		for (index = 0; index < n_entries; index++) {
> > +			u64 temp = ((u64 *)new_custom->table)[index];
> >  
> >  			if ((index % 2) != 0)
> >  				temp = __convert_to_raw(temp, 1024);
> > @@ -445,16 +459,9 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
> >  				temp = __convert_to_raw_sign(temp, resolution);
> >  			else
> >  				temp = __convert_to_raw(temp, resolution);
> > -		} else {
> > -			u32 t32;
> >  
> > -			of_property_read_u32_index(np, propname, index, &t32);
> > -			temp = t32;
> > +			put_unaligned_be24(temp, new_custom->table + index * 3);
> >  		}
> > -
> > -		for (j = 0; j < n_size; j++)
> > -			new_custom->table[tbl++] =
> > -				temp >> (8 * (n_size - j - 1));
> >  	}

...

> >  		if (IS_ERR(rtd->custom)) {
> > -			of_node_put(phandle);
> > +			fwnode_handle_put(ref);
> 
> I guess there was a bunch of cut and paste in this driver ;) Same question as below
> on whether we can just use a goto here to share the put in the fail path.

Probably as separate (preparatory) patch?

> >  			return ERR_CAST(rtd->custom);
> >  		}

...

> >  		if (IS_ERR(thermistor->custom)) {
> > -			of_node_put(phandle);
> > +			fwnode_handle_put(ref);
> >  			return ERR_CAST(thermistor->custom);
> 
> Obviously not due to this patch, but this is odd.  Why have one error path
> that doesn't use the goto faill;?
> If you could tidy that up and add a note on it to the patch description
> that would be great.

Same answer as above.

> >  		}

-- 
With Best Regards,
Andy Shevchenko


