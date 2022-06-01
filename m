Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA02253A081
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347227AbiFAJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351127AbiFAJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:33:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786258B09E;
        Wed,  1 Jun 2022 02:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E3FBB8185E;
        Wed,  1 Jun 2022 09:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7B4C385A5;
        Wed,  1 Jun 2022 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654076029;
        bh=5T6DOvFw902lROs1sSAyrJ/DZ8vBhIwjqturHxstVd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGGzdgsl0yWRtC4tWhYShHmsSXAkbeeoS1eRaWgAuHlUB8ydG6LiQgI9ENIJpxdvi
         lI2Zh0dsTLjglJKNtjG3AJsMHdauUUCWmZMnJDlDaUW6FNuR9a/bnbZ2OsY9rYdlzs
         1s/mzxOUsVKKevlFm5kdHfOHd2SOWfgorHG4Rtuw=
Date:   Wed, 1 Jun 2022 11:33:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v8 3/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
Message-ID: <YpcyaTqqsfDJx7HG@kroah.com>
References: <20220422024653.2199489-1-quan@os.amperecomputing.com>
 <20220422024653.2199489-4-quan@os.amperecomputing.com>
 <YmJJIb1DAIq5arCw@kroah.com>
 <4f5d7746-3747-4a4d-525a-4fb69e706cd0@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5d7746-3747-4a4d-525a-4fb69e706cd0@os.amperecomputing.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 03:21:47PM +0700, Quan Nguyen wrote:
> > > +	if (err_type & BIT(2)) {
> > > +		/* Error with data type */
> > > +		ret = regmap_read(errmon->regmap, err_info->err_data_low, &data_lo);
> > > +		if (ret)
> > > +			goto done;
> > > +
> > > +		ret = regmap_read(errmon->regmap, err_info->err_data_high, &data_hi);
> > > +		if (ret)
> > > +			goto done;
> > > +
> > > +		count = sysfs_emit(buf, "%01x%02x%01x%02x%04x%04x%04x\n",
> > > +				   4, (ret_hi & 0xf000) >> 12, (ret_hi & 0x0800) >> 11,
> > > +				   ret_hi & 0xff, ret_lo, data_hi, data_lo);
> > > +		/* clear the read errors */
> > > +		ret = regmap_write(errmon->regmap, err_info->err_type, BIT(2));
> > > +
> > > +	} else if (err_type & BIT(1)) {
> > > +		/* Error type */
> > > +		count = sysfs_emit(buf, "%01x%02x%01x%02x%04x%04x%04x\n",
> > > +				   2, (ret_hi & 0xf000) >> 12, (ret_hi & 0x0800) >> 11,
> > > +				   ret_hi & 0xff, ret_lo, data_hi, data_lo);
> > > +		/* clear the read errors */
> > > +		ret = regmap_write(errmon->regmap, err_info->err_type, BIT(1));
> > > +
> > > +	} else if (err_type & BIT(0)) {
> > > +		/* Warning type */
> > > +		count = sysfs_emit(buf, "%01x%02x%01x%02x%04x%04x%04x\n",
> > > +				   1, (ret_hi & 0xf000) >> 12, (ret_hi & 0x0800) >> 11,
> > > +				   ret_hi & 0xff, ret_lo, data_hi, data_lo);
> 
> Hi Greg,
> 
> Since the internal representation of the internal error is split into high
> low chunks of the info and data values which need to be communicated
> atomicly, I'm treating them as "one value" here.

That is a huge "one value", that's not what this really is, it needs to
be parsed by userspace, right?

And why does this have to be atomic?  What happens if the values change
right after you read them?  What is userspace going to do with them?

> I could dump them in a
> temporary array and print that, but it seems like additional complexity for
> the same result. Can we consider this concatenated encoding as "an array of
> the same type" for the purposes of this driver?"

That's really not a good idea as sysfs files should never need to be
"parsed" like this.

Again, what are you trying to do here, and why does it have to be
atomic?

thanks,

greg k-h
