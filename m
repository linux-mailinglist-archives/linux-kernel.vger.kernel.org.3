Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECA5AE818
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiIFM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbiIFM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:28:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E924951;
        Tue,  6 Sep 2022 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662467104; x=1694003104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLnflIlhNOSKlv+K+sGMeC6Yi4HRSkPtWSqjX4XDHWo=;
  b=U9N+FlkdS0sYsBDdatUc3mzlVKsE6YvuLzFvuz94vnUau0EGpqfl813Y
   UBYWIblQvchfLB0b8JYx2LEqMITfM3qdXCfrSBaGv7ImPOphFXEEsuS8Z
   TuXDbIYa5hrrjmtnKjR+0AIsowMyrIpVNz/UMzbraunUi6jk9dC0ZP0L9
   9Qzq3aMrQ7QpW6ijGSd1xeLdE7ltHrAmjA+1tIByZ05odJBRKypVCn6G0
   oPo2FoaWsoc79QDncKXpe0uXUFOs51YnWJU22GYfXxsgvrH0s9T0+0sUN
   WQmGQRgSVKJpoipIXTX5gZBKSHDnR8I1hhUhDFRv3YAmHmVSn1s30Uy27
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="279592183"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279592183"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:25:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565073686"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:25:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVXdS-00970o-2G;
        Tue, 06 Sep 2022 15:24:58 +0300
Date:   Tue, 6 Sep 2022 15:24:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] gpio: pca953x: Add support for PCAL6534
Message-ID: <Yxc8GgUnHOuMIn4p@smile.fi.intel.com>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-5-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906082820.4030401-5-martyn.welch@collabora.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 09:28:19AM +0100, Martyn Welch wrote:
> From: Martyn Welch <martyn.welch@collabora.com>
> 
> Add support for the NXP PCAL6534. This device is broadly a 34-bit version
> of the PCAL6524. However, whilst the registers are broadly what you'd
> expect for a 34-bit version of the PCAL6524, the spacing of the registers
> has been compacted. This has the unfortunate effect of breaking the bit
> shift based mechanism that is employed to work out register locations used
> by the other chips supported by this driver. To accommodate ths, callback
> functions have been added to allow alterate implementations of
> pca953x_recalc_addr() and pca953x_check_register() for the PCAL6534.


This looks much cleaner!

...

> @@ -107,6 +109,7 @@ static const struct i2c_device_id pca953x_id[] = {
>  	{ "tca9539", 16 | PCA953X_TYPE | PCA_INT, },
>  	{ "tca9554", 8  | PCA953X_TYPE | PCA_INT, },
>  	{ "xra1202", 8  | PCA953X_TYPE },
> +
>  	{ }

Missed Diodes?

>  };
>  MODULE_DEVICE_TABLE(i2c, pca953x_id);

...

> +	u8 (*recalc_addr)(struct pca953x_chip *chip, int reg , int off);
> +	bool (*check_reg)(struct pca953x_chip *chip, unsigned int reg,
> +		          u32 checkbank);

I would think of splitting this change. Like in a separate patch you simply
create this interface and only add what you need in the next one.

...

> +static bool pcal6534_check_register(struct pca953x_chip *chip, unsigned int reg,
> +				    u32 checkbank)
> +{
> +	int bank;
> +	int offset;
> +
> +	if (reg > 0x2f) {

I guess code read and generation wise the

	if (reg >= 0x30) {

is slightly better.

> +		/*
> +		 * Reserved block between 14h and 2Fh does not align on
> +		 * expected bank boundaries like other devices.
> +		 */
> +		int temp = reg - 0x30;
> +
> +		bank = temp / NBANK(chip);
> +		offset = temp - (bank * NBANK(chip));

Parentheses are not needed fur multiplication, but if you insist...

> +		bank += 8;

> +	} else if (reg > 0x53) {

In the similar way...

> +		/* Handle lack of reserved registers after output port
> +		 * configuration register to form a bank.
> +		 */

Comment style

/*
 * Handle...
 */

> +		int temp = reg - 0x54;
> +
> +		bank = temp / NBANK(chip);
> +		offset = temp - (bank * NBANK(chip));
> +		bank += 16;
> +	} else {
> +		bank = reg / NBANK(chip);
> +		offset = reg - (bank * NBANK(chip));
> +	}
> +
> +	/* Register is not in the matching bank. */
> +	if (!(BIT(bank) & checkbank))
> +		return false;
> +
> +	/* Register is not within allowed range of bank. */
> +	if (offset >= NBANK(chip))
> +		return false;
> +
> +	return true;
> +}

...

> -	u8 regaddr = pinctrl | addr | (off / BANK_SZ);
>  
> -	return regaddr;
> +	return pinctrl | addr | (off / BANK_SZ);

Stray change, or anything I have missed?

...

> +/* The PCAL6534 and compatible chips have altered bank alignment that doesn't
> + * fit within the bit shifting scheme used for other devices.
> + */

Comment style.

...

> @@ -1240,6 +1335,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
>  
>  	{ .compatible = "nxp,pcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
>  	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
> +	{ .compatible = "nxp,pcal6534", .data = OF_653X(34, PCA_LATCH_INT), },
>  	{ .compatible = "nxp,pcal9535", .data = OF_953X(16, PCA_LATCH_INT), },
>  	{ .compatible = "nxp,pcal9554b", .data = OF_953X( 8, PCA_LATCH_INT), },
>  	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_LATCH_INT), },

Do you decide to drop Diodes compatible from the code?

-- 
With Best Regards,
Andy Shevchenko


