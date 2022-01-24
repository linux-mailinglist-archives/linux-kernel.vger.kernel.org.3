Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A482B498212
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiAXO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:26:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:60714 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbiAXO03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643034389; x=1674570389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RtwAD8uQ/Ug7Sb0YvKHFVuZ2wiMpSRuHA87kqhLRezE=;
  b=WSgb9GwRBISHDaKNke6QpPxIl+ZvyOODcr6jNXhqhxMnmHHsst7irORr
   20r/h5VuVhNgO6uaOsfv8yugqSXlAaUdetcGnfSqCG5Hvh5mtkEJ5khS0
   zHVcH91YKDilemb38+K7YomSPJ15wD7m3K55JVGokB5v53zZG5tn7hO5+
   Nijge5hZPVKiphFxbht1B0q/4w17YPlj/8dTYLZh5wLorg11cFgE6hQCr
   vHBQO7gYF2mWLVIke9oc0Q7O/2M0/m8J+fCqC9lQXxVoHpq/XsRIdh8M6
   EhNz5LVwI1wOmwS61DdYGMOp2ODzv7u+nMJe1g8c8gkSM3zm/kYLxSBJL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226727633"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226727633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:26:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476733497"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:26:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nC0HY-00DvEo-2C;
        Mon, 24 Jan 2022 16:25:20 +0200
Date:   Mon, 24 Jan 2022 16:25:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     xkernel.wang@foxmail.com
Cc:     andy@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: merrifield: check the return value of
 devm_kstrdup()
Message-ID: <Ye62z5jB+25ocAeT@smile.fi.intel.com>
References: <tencent_A3850F2901FD5B80E831ABE7C27144509C0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A3850F2901FD5B80E831ABE7C27144509C0A@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 03:06:06PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> devm_kstrdup() returns pointer to allocated string on success, NULL on
> failure. So it is better to check the return value of it.
> 
> Before, if devm_kstrdup() fails, pinctrl_dev_name will be NULL, then the
> retval below will be a negative error-code(inside gpiochip_add_pin_range(),
> pinctrl_find_and_add_gpio_range()->get_pinctrl_dev_from_devname() will
> finally check pinctrl_dev_name and return error), so the failure of
> devm_kstrdup() can be only implicitly caught after a long call chain.
> While this patch is to explicitly catch the failure in time.
> > retval = gpiochip_add_pin_range(&priv->chip, pinctrl_dev_name,
> >				  range->gpio_base,
> >				  range->pin_base,
> >				  range->npins);
> > if (retval) {
> > 	dev_err(priv->dev, "failed to add GPIO pin range\n");
> > 	return retval;
> > }

Pushed to my review and testing queue, thanks!

> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> Changelogs:
> v1 -> v2: update the commit message.
>  drivers/gpio/gpio-merrifield.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 42c4d9d..f3d1bae 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -409,6 +409,9 @@ static int mrfld_gpio_add_pin_ranges(struct gpio_chip *chip)
>  	int retval;
>  
>  	pinctrl_dev_name = mrfld_gpio_get_pinctrl_dev_name(priv);
> +	if (!pinctrl_dev_name)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < ARRAY_SIZE(mrfld_gpio_ranges); i++) {
>  		range = &mrfld_gpio_ranges[i];
>  		retval = gpiochip_add_pin_range(&priv->chip, pinctrl_dev_name,
> -- 

-- 
With Best Regards,
Andy Shevchenko


