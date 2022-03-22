Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951A4E463A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbiCVSqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiCVSqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:46:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027353B3C6;
        Tue, 22 Mar 2022 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647974689; x=1679510689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z9ISvqYW+aTilxDXA9Qpu3ET59simZEgcBrqEX9APhA=;
  b=WEqkixNrv8Yg6RumBPTxNK9NpMxqtqjq7waUgbBYUvBUP2kxVpv1m0yv
   GY8EJn3a/FWMvjdMPhD/XeRuYhN1ltnSriIrH/NzPjD7mEYGmV7bJzPOI
   +Xna8XHFADHkNmY6xgOswe5npn8o6Y4bv5wOaKcCDL8h7OfFrgc17h8Ma
   6nspBNMdfFVrOMK+0lZN+ZWhfT6a8w1YwRb0za5/+ldqWOD06v0E03HQE
   o5cl26cT4jCQ3Jmz3bLyikLjQBkEemJ/iHLJeRY3iG8OcGBdjjP8jAo1w
   0POH1HS1UEFK7aihwI85Vj1eBlmV7ufWwreM9FOSEX56xnr57haAH3gLC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="344347989"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="344347989"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 11:44:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="649120085"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 11:44:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nWjUH-004jQF-U9;
        Tue, 22 Mar 2022 20:44:09 +0200
Date:   Tue, 22 Mar 2022 20:44:09 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "david-b@pacbell.net" <david-b@pacbell.net>
Subject: Re: [PATCH] mmc: block: Check for errors after write on SPI
Message-ID: <YjoY+Z/iuIoNDhch@smile.fi.intel.com>
References: <9d1ea819e4bb4222a227a02d5f6ad97c@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d1ea819e4bb4222a227a02d5f6ad97c@hyperstone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:21:34PM +0000, Christian Löhle wrote:
> Introduce a SEND_STATUS check for writes through SPI to not mark
> an unsuccessful write as successful.
> 
> Since SPI SD/MMC does not have states, after a write, the card will
> just hold the line LOW until it is ready again. The driver marks the
> write therefore as completed as soon as it reads something other than
> all zeroes.
> The driver does not distinguish from a card no longer signalling busy
> and it being disconnected (and the line being pulled-up by the host).
> This lead to writes being marked as successful when disconnecting
> a busy card.
> Now the card is ensured to be still connected by an additional CMD13,
> just like non-SPI is ensured to go back to TRAN state.
> 
> While at it and since we already poll for the post-write status anyway,
> we might as well check for SPIs error bits (any of them).
> 
> The disconnecting card problem is reproducable for me after continuous
> write activity and randomly disconnecting, around every 20-50 tries
> on SPI DS for some card.

...

> +	if (mmc_host_is_spi(card->host)) {
> +		u32 status = 0;

> +		err = __mmc_send_status(card, &status, 0);

> +		/* All R1 and R2 bits of SPI are errors in our case */
> +		if (status)
> +			err = err ? err : -EIO;

I would use either this:

		if (err || status) {
			mqrq->brq.data.bytes_xfered = 0;

			if (err)
				return err;
			return -EIO;
		}

		return 0;

or at least this:

			err = err ?: -EIO;

or even this:

		if (!err && status)
			err = -EIO;

(Personally I would choose the first option)


> +		if (err)
> +			mqrq->brq.data.bytes_xfered = 0;
> +		return err;
> +	}

-- 
With Best Regards,
Andy Shevchenko


