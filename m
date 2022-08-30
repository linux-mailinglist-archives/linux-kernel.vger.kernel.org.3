Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418DD5A6882
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiH3Qgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH3Qgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:36:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC5B6D5C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661877392; x=1693413392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evuEwafeYuR5tiKtPLjXwPPmUAgK2MYWXlQ13DrPxvQ=;
  b=BlUYICb0mMbkWcHyFXUTan6T/iIgrS6Q/udpxiz/XBONvb4rSEuMa1Qf
   PofUk0DjS7y8J/xt5mDf7HAXamnUDWjG6/YGGtsumnFdRBNmuFXPmtSaj
   mi6CSKNN6qWgZyM4gKBPuDa5VQTYIYLmfo8DHeIT+uzdcbInDnH4G3Skr
   2V3L+5Sr23KnYsurpf3hOCICL4IPa+wE1YuEDXB7Fp8t11g8ZbitSC1dL
   JAdveE68RlrTZcnPg+qaLUUJJVrdaN/HP7fPO+VCDHsu8GIyVdO3LrLcn
   ykIRINvNLFdRKOzXnr/96nuUUAmrnXvQh98JprAkNCk3BY1Ep/W9nMti6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="292811009"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="292811009"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:28:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="680101151"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:28:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oT46R-0061u5-2a;
        Tue, 30 Aug 2022 19:28:39 +0300
Date:   Tue, 30 Aug 2022 19:28:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v5] regmap: Support accelerated noinc operations
Message-ID: <Yw46t9Y1PYoMLSKq@smile.fi.intel.com>
References: <20220816204832.265837-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816204832.265837-1-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:48:31PM +0200, Linus Walleij wrote:
> Several architectures have accelerated operations for MMIO
> operations writing to a single register, such as writesb, writesw,
> writesl, writesq, readsb, readsw, readsl and readsq but regmap
> currently cannot use them because we have no hooks for providing
> an accelerated noinc back-end for MMIO.
> 
> Solve this by providing reg_[read/write]_noinc callbacks for
> the bus abstraction, so that the regmap-mmio bus can use this.
> 
> Currently I do not see a need to support this for custom regmaps
> so it is only added to the bus.
> 
> Callbacks are passed a void * with the array of values and a
> count which is the number of items of the byte chunk size for
> the specific register width.

I see these applied, but consider below for the possible followups.

...

> +			ret = regcache_write(map, reg, lastval);
> +			if (ret != 0)

if (ret) ?

> +				return ret;

...

> +		dev_info(map->dev, "%x %s [", reg, write ? "<=" : "=>");
> +		for (i = 0; i < val_len; i++) {
> +			switch (val_bytes) {
> +			case 1:
> +				pr_cont("%x", u8p[i]);
> +				break;
> +			case 2:
> +				pr_cont("%x", u16p[i]);
> +				break;
> +			case 4:
> +				pr_cont("%x", u32p[i]);
> +				break;
> +#ifdef CONFIG_64BIT
> +			case 8:
> +				pr_cont("%llx", u64p[i]);
> +				break;
> +#endif
> +			default:
> +				break;
> +			}
> +			if (i == (val_len - 1))
> +				pr_cont("]\n");
> +			else
> +				pr_cont(",");
> +		}

I'm wondering why we can't use hex_dump_to_buffer() approach? Or even better,
introduce eventually dev_hex_dump() (as it's done for seq_file and printk)
and use it.

-- 
With Best Regards,
Andy Shevchenko


