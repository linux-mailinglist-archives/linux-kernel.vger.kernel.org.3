Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91C4743A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhLNNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:38:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:47058 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhLNNh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:37:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218993114"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="218993114"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:37:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="604284845"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:37:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mx7z9-0068is-01;
        Tue, 14 Dec 2021 15:36:51 +0200
Date:   Tue, 14 Dec 2021 15:36:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sean Wang <sean.wang@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Subject: Re: [PATCH v2 2/2] pinctrl: Propagate firmware node from a parent
 device
Message-ID: <Ybid8lFy8aS1cTVI@smile.fi.intel.com>
References: <20211214125855.33207-1-andriy.shevchenko@linux.intel.com>
 <20211214125855.33207-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214125855.33207-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 02:58:55PM +0200, Andy Shevchenko wrote:
> When creating MFD platform devices the firmware node is left unset.
> This, in particular, prevents GPIO library to use it for different
> purposes. Propagate firmware node from the parent device and let
> GPIO library do the right thing.
> 
> While at it, slightly modify the headers to reflect the usage of APIs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed compilation bug (LKP), due to above reshuffle headers in the rest

...

> +#include <linux/mod_device_table.h>

He-h, updated code, updated bugs...

Linus, can you, please, apply the first patch if you have no objections, so I
won't spam a lot of people again with no changes beneath?

-- 
With Best Regards,
Andy Shevchenko


