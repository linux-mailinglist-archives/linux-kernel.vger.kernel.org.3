Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677094CD45C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiCDMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCDMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:39:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530F13FAD2;
        Fri,  4 Mar 2022 04:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646397545; x=1677933545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QJ5044QybdgyBcGGWpEQ66a2p8/cp1NF4P4f5axlo9k=;
  b=joUQmOxSdedcN1I9+GCIIO+RMAaKFRpjw5usPStdRAhlmxkAX38OjT2u
   M1y7wTiV45Y9l0bAM6CE89MQAxrXPLUwYCK6RpXS98UyzEVrS9Z63XJZV
   +nNNALn9Fg2JYZJ7SB/u7XV2EHtGj+tRmZz9BL5QaZ9gG8PD/iPvgU/1x
   Ox7zFg2ZOWBfRtL5DM9ejLI+FaQA7VYz4iShZ7+HX8SNKff0AIPHUNJBg
   51baMoOBS/U+cdEAeZr2qNVtj4I0fxKh/aV0dvTREkRHG5pCip/FBag1x
   rQpT9UoCBtMaQwvdqVXN3mlGD+aMkwFf9J03F0DiQgKNqbaUT0BAHLKdb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="252793831"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="252793831"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:39:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="576869293"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:39:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ7CI-00BDcA-IQ;
        Fri, 04 Mar 2022 14:38:14 +0200
Date:   Fri, 4 Mar 2022 14:38:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: Re: [PATCH v21 2/3] Input: mt6779-keypad - Add MediaTek keypad driver
Message-ID: <YiIINpi4zbJq/AZE@smile.fi.intel.com>
References: <20220303154302.252041-1-mkorpershoek@baylibre.com>
 <20220303154302.252041-3-mkorpershoek@baylibre.com>
 <300114e2-6794-db3c-a51c-3f900b6476f9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300114e2-6794-db3c-a51c-3f900b6476f9@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:31:38AM +0100, AngeloGioacchino Del Regno wrote:
> Il 03/03/22 16:43, Mattijs Korpershoek ha scritto:
> > From: "fengping.yu" <fengping.yu@mediatek.com>
> > 
> > This patch adds matrix keypad support for Mediatek SoCs.

> > +struct mt6779_keypad {
> > +	struct regmap *regmap;
> > +	struct input_dev *input_dev;
> > +	struct clk *clk;

> > +	void __iomem *base;

Not sure why you need this here.

> > +	u32 n_rows;
> > +	u32 n_cols;
> > +	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
> > +};
> > +
> > +static const struct regmap_config mt6779_keypad_regmap_cfg = {
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = sizeof(u32),
> > +	.max_register = 36,
> 
> Are you sure that you can't use .fast_io = true?
> 
> Another version for the same question:
> Are you sure that you need to lock with a mutex here, and not with a spinlock?
> 
> Since you're performing reads over a MMIO, I think that there's a very good
> chance that you can use fast_io.
> 
> > +};

...

> Please use dev_err_probe() to simplify error handling in probe functions: you've
> done a great job with adding a devm action for the error cases, avoiding gotos to
> get out cleanly.. it would be a pity to not finish this to perfection.
> 
> I'll give you two examples for this, so that you'll be all set.
> 
> 	if (IS_ERR(keypad->regmap))
> 		return dev_err_probe(&pdev->dev, PTR_ERR(keypad->regmap),
> 				     "regmap init failed\n");
> 
> P.S.: No need for %pe here, as dev_err_probe prints the error number for you!

Maintainer of the input subsystem is strongly against dev_err_probe() API. See
other files there. Ditto for other cases you mentioned below.

-- 
With Best Regards,
Andy Shevchenko


