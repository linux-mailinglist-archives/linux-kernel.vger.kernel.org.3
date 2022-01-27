Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBB49E5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiA0PWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:22:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:7771 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbiA0PWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643296931; x=1674832931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VuKbH3kWAdwpcevHZKsh6LuPUBEA54hne+chkbg+oBI=;
  b=gkRCQWDh6Q0hrbffuWKJFeKIzPay4oSddtFJzDjRjo4u5yFPjy/9dZh9
   BQOWEURpy72u0DLKkdKiIWRBy9R7R1Lx+j6dhMzVheqxiVJWDFPgLftEK
   Se6OHVw6Ns1OTcsAx6Icr/ukXC3yH00zxb7mALp1J3lpnWL0k0ILcxGwY
   CTvkyvxrzfMO6Aq8qE56dKPfBXmdxQNfD+sdhSIEX1RkSMet9Cwutqepz
   3A/C4cRdq/wE7XoHQIDF8rdLtnQ4jOQUd+sv1f1b+Q0TaLM1/0FOMqZrI
   FtvoFELD49zcWEHlkOqT2Xl8QtYS7WEUxJ8Nd0R2MbFO6cOkg49NTagQV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="247103157"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="247103157"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:22:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="696686312"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:21:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nD6Zt-00F1OR-Lf;
        Thu, 27 Jan 2022 17:20:49 +0200
Date:   Thu, 27 Jan 2022 17:20:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 2/3] Input: mt6779-keypad - Add MediaTek keypad driver
Message-ID: <YfK4UcuCfF7JfI7H@smile.fi.intel.com>
References: <20220127111526.3716689-1-mkorpershoek@baylibre.com>
 <20220127111526.3716689-3-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127111526.3716689-3-mkorpershoek@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:15:25PM +0100, Mattijs Korpershoek wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> This patch adds matrix keypad support for Mediatek SoCs.

Some comments which may be addressed now or in the follow-up patch(es).
Up to you.

...

> +static const struct regmap_config mt6779_keypad_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,

> +	.reg_stride = sizeof(u32),

I'm wondering if we need this when we have reg_bits = 32 already.

> +	.max_register = 36,
> +};

...

> +	regmap_write(keypad->regmap, MTK_KPD_DEBOUNCE,
> +		     (debounce * 32) & MTK_KPD_DEBOUNCE_MASK);

I'm wondering if << 5 is more specific to show that the value
is based on 2^5 units.

...

> +	error = devm_add_action_or_reset(&pdev->dev, mt6779_keypad_clk_disable, keypad->clk);

You have this long line...

> +	error = devm_request_threaded_irq(&pdev->dev, irq,
> +					  NULL, mt6779_keypad_irq_handler,
> +					  IRQF_ONESHOT,
> +					  MTK_KPD_NAME, keypad);

...at the same time you may reduce LOCs here...

> +	if (error) {
> +		dev_err(&pdev->dev, "Failed to request IRQ#%d:%d\n",
> +			irq, error);

...and here.

> +		return error;
> +	}

-- 
With Best Regards,
Andy Shevchenko


