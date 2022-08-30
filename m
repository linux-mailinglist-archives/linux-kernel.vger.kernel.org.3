Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC95A688C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiH3QkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3QkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:40:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4BB1BEA6;
        Tue, 30 Aug 2022 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661877611; x=1693413611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hMJfedZvdsmbwPRh9VykDs64eRMZZWjvzG9b69fVzo=;
  b=bJsI0gf+Z4U6NQsLRyqfiJQWcA6f4c9U9ziBZnHHBCttbGR8t0nDQFMu
   6guSWOhwpxKyJbwVLbpuFSQbQBAz6cs0TYpUvmzhgnZVs6h0V4n1XZZse
   HZg8alqwDCKt4FJKszbe4O1ZzrWCdbb5MFOsfcOAd79Pma8B2lA02X5PQ
   dnKhqVPP0CIDaAeH27vZEP2UERWlyEmaY1a6oIVWkj3wuNq8keXOvFuM7
   AQDDstsYTz6YNZlb/ZL17K1Z9y+BTqXZwJZ6RfiCKXasjfscVZXXXYeCH
   3xvPj3WRDTrXw8zbl8eWoBze9G/+Ua2ZcIOXEJkfTTwGetC9hDdiBpIUt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381533157"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="381533157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:35:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="701056242"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:35:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oT4Cu-00622y-0H;
        Tue, 30 Aug 2022 19:35:20 +0300
Date:   Tue, 30 Aug 2022 19:35:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2 v5] regmap: mmio: Support accelerared noinc operations
Message-ID: <Yw48R+EBmmZYl9x+@smile.fi.intel.com>
References: <20220816204832.265837-1-linus.walleij@linaro.org>
 <20220816204832.265837-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816204832.265837-2-linus.walleij@linaro.org>
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

On Tue, Aug 16, 2022 at 10:48:32PM +0200, Linus Walleij wrote:
> Use the newly added callback for accelerated noinc MMIO
> to provide writesb, writesw, writesl, writesq, readsb, readsw,
> readsl and readsq.
> 
> A special quirk is needed to deal with big endian regmaps: there
> are no accelerated operations defined for big endian, so fall
> back to calling the big endian operations itereatively for this
> case.
> 
> The Hexagon architecture turns out to have an incomplete
> <asm/io.h>: writesb() is not implemented. Fix this by doing
> what other architectures do: include <asm-generic/io.h> into
> the <asm/io.h> file.

Wonderful!

So, I have seen a recent blow up by kernel bot due to Alpha issues on these
accessors.

Also see below for the further followups.

...

> +	if (!IS_ERR(ctx->clk)) {
> +		ret = clk_enable(ctx->clk);
> +		if (ret < 0)
> +			return ret;
> +	}

It's a new place of the duplicating check, can we have a helper for that?

...

> +	/*
> +	 * There are no native, assembly-optimized write single register
> +	 * operations for big endian, so fall back to emulation if this
> +	 * is needed. (Single bytes are fine, they are not affected by
> +	 * endianness.)
> +	 */

Wouldn't be faster to memdup() / swap / use corresponding IO accessor?

...

> +	/*
> +	 * There are no native, assembly-optimized write single register
> +	 * operations for big endian, so fall back to emulation if this
> +	 * is needed. (Single bytes are fine, they are not affected by
> +	 * endianness.)
> +	 */
> +	if (ctx->big_endian && (ctx->val_bytes > 1)) {
> +		switch (ctx->val_bytes) {
> +		case 2:
> +		{
> +			u16 *valp = (u16 *)val;
> +			for (i = 0; i < val_count; i++)
> +				valp[i] = swab16(valp[i]);
> +			break;
> +		}
> +		case 4:
> +		{
> +			u32 *valp = (u32 *)val;
> +			for (i = 0; i < val_count; i++)
> +				valp[i] = swab32(valp[i]);
> +			break;
> +		}
> +#ifdef CONFIG_64BIT
> +		case 8:
> +		{
> +			u64 *valp = (u64 *)val;
> +			for (i = 0; i < val_count; i++)
> +				valp[i] = swab64(valp[i]);
> +			break;
> +		}
> +#endif
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}

So, two questions here:

1) can we use helpers from include/linux/byteorder/generic.h, such as
   cpu_to_be32_array()/be32_to_cpu_array()?

2) have you considered using memcpy_toio() / memcpy_fromio() and why
   it's not okay to use them?

...

> +
> +

Single blank line is enough.

> +out_clk:
> +	if (!IS_ERR(ctx->clk))
> +		clk_disable(ctx->clk);
> +
> +	return ret;
> +
> +	return 0;

Seems like misrebase? I believe this has to be fixed.

-- 
With Best Regards,
Andy Shevchenko


