Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659274AB02A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbiBFPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:19:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A54C06173B;
        Sun,  6 Feb 2022 07:19:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EE06112C;
        Sun,  6 Feb 2022 15:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CEDC340E9;
        Sun,  6 Feb 2022 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644160752;
        bh=CrKWLnFtz+agz6KlLPQCTPkXtniFpFUkLyFU3p2QN2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkMZcgd4DLbNyFC45jXwa0k2rrwmW8vx5JMDaDfboNTUqCtBPzs2oLD/FjI2SDpPD
         RbZWQz1DVpWptqK3auRL1iWQ2yzp+roJ3n8gjhp4QDggj2lpD4cCX4pHaFJw1Vpsne
         JVzdRBndQfugEeA2DGJZKcO5Ab45UH/fEQLK54vOLoFAohM8fycYZ3ezQhwM9pn8PO
         Z2NXRyflG8LFdPEwwnUyJPDBvodANOD6p/nwNPZ6keovmd7jpCB3Tkm+qTtUOjYU0L
         qZQWns22LlCuQYGCSkc9UpBvBzfU6TMqg5K0GeUX2WdJp01rN4lIy8IFr/iNy+cytS
         7jz6ggsm2vmIg==
Date:   Sun, 6 Feb 2022 15:25:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of device
 properties
Message-ID: <20220206152544.613c828e@jic23-huawei>
In-Reply-To: <Yf7ArwPrN34drkcv@smile.fi.intel.com>
References: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
        <20220203114506.53904-2-andriy.shevchenko@linux.intel.com>
        <20220205171454.49a7225c@jic23-huawei>
        <Yf7ArwPrN34drkcv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2022 20:23:43 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Feb 05, 2022 at 05:14:54PM +0000, Jonathan Cameron wrote:
> > On Thu,  3 Feb 2022 13:45:06 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.  
> > 
> > This description needs expansion as it's not a straight forward
> > conversion.
> > 
> > Also, complex enough that I definitely want more eyes and preferably
> > some testing.  
> 
> That's fair. I also spent most of the time on this change in comparison to the
> whole bundle.
> 
> ...
> 
> > > +#include <asm/byteorder.h>
> > > +#include <asm/unaligned.h>  
> 
> > This may well be a valid addition but it's not called out in the patch
> > description.  
> 
> This is a side effect of the change. Below I will try to explain, tell me if
> that is what you want to be added to the commit message (feel free to correct
> my English).

I figured that out whilst it was sending but didn't hit cancel fast enough! :)

> 
> The conversion slightly changes the logic behind property reading for the
> configuration values. Original code allocates just as much memory as needed.
> Then for each separate 32- or 64-bit value it reads it from the property
> and converts to a raw one which will be fed to the sensor. In the new code
> we allocated the amount of memory needed to retrieve all values at once from
> the property and then convert them as required.

Good description to put in the patch description.

> 
> ...
> 
> > >  	if (st->custom_table_size + new_custom->size >
> > > -	    (LTC2983_CUST_SENS_TBL_END_REG -
> > > -	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> > > +	    (LTC2983_CUST_SENS_TBL_END_REG - LTC2983_CUST_SENS_TBL_START_REG) + 1) {  
> > 
> > Shouldn't really be in this patch. Or at very least call out that there is
> > whitespace cleanup in the patch description.  
> 
> Good catch! It's a leftover, one case became a patch 1 in this series.
> 
> ...
> 
> > > +	if (is_steinhart)
> > > +		ret = fwnode_property_read_u32_array(fn, propname, new_custom->table, n_entries);
> > > +	else
> > > +		ret = fwnode_property_read_u64_array(fn, propname, new_custom->table, n_entries);
> > > +	if (ret < 0)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	/*
> > > +	 * Steinhart sensors are configured with raw values in the device tree.
> > > +	 * For the other sensors we must convert the value to raw. The odd
> > > +	 * index's correspond to temperatures and always have 1/1024 of
> > > +	 * resolution. Temperatures also come in Kelvin, so signed values is
> > > +	 * not possible.
> > > +	 */
> > > +	if (is_steinhart) {  
> > 
> > Perhaps would be cleaner to combine this if else with the one above at the cost
> > of duplicating the if (ret < 0) check.  
> 
> OK, I'm fine with either approach.
> 
> > > +		cpu_to_be32_array(new_custom->table, new_custom->table, n_entries);  
> > 
> > I completely failed to register the hand coded big endian conversion.  Nice
> > tidy up.  However, definitely something to call out in the patch description.  
> 
> See above.
> 
> > > +	} else {
> > > +		for (index = 0; index < n_entries; index++) {
> > > +			u64 temp = ((u64 *)new_custom->table)[index];
> > >  
> > >  			if ((index % 2) != 0)
> > >  				temp = __convert_to_raw(temp, 1024);
> > > @@ -445,16 +459,9 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
> > >  				temp = __convert_to_raw_sign(temp, resolution);
> > >  			else
> > >  				temp = __convert_to_raw(temp, resolution);
> > > -		} else {
> > > -			u32 t32;
> > >  
> > > -			of_property_read_u32_index(np, propname, index, &t32);
> > > -			temp = t32;
> > > +			put_unaligned_be24(temp, new_custom->table + index * 3);
> > >  		}
> > > -
> > > -		for (j = 0; j < n_size; j++)
> > > -			new_custom->table[tbl++] =
> > > -				temp >> (8 * (n_size - j - 1));
> > >  	}  
> 
> ...
> 
> > >  		if (IS_ERR(rtd->custom)) {
> > > -			of_node_put(phandle);
> > > +			fwnode_handle_put(ref);  
> > 
> > I guess there was a bunch of cut and paste in this driver ;) Same question as below
> > on whether we can just use a goto here to share the put in the fail path.  
> 
> Probably as separate (preparatory) patch?

Perfect

> 
> > >  			return ERR_CAST(rtd->custom);
> > >  		}  
> 
> ...
> 
> > >  		if (IS_ERR(thermistor->custom)) {
> > > -			of_node_put(phandle);
> > > +			fwnode_handle_put(ref);
> > >  			return ERR_CAST(thermistor->custom);  
> > 
> > Obviously not due to this patch, but this is odd.  Why have one error path
> > that doesn't use the goto faill;?
> > If you could tidy that up and add a note on it to the patch description
> > that would be great.  
> 
> Same answer as above.
> 
> > >  		}  
> 

