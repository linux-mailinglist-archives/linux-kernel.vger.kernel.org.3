Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892754697A7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245026AbhLFOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:04:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:54034 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231828AbhLFOEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:04:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="218002531"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="218002531"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:01:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="460835880"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:01:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muEXN-002ng4-Pb;
        Mon, 06 Dec 2021 16:00:13 +0200
Date:   Mon, 6 Dec 2021 16:00:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver: pmc_atom: free pmc->regmap when
 pmc_setup_clks fails
Message-ID: <Ya4XbbVnK/0Getmt@smile.fi.intel.com>
References: <20211205084419.2382395-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205084419.2382395-1-mudongliangabcd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 04:44:19PM +0800, Dongliang Mu wrote:
> Smatch reports:
> 
> drivers/platform/x86/pmc_atom.c:496
> pmc_setup_dev() warn: 'pmc->regmap' not released on lines: 496.
> 
> Fix this by deallocating pm->regmap when pmc_setup_clks fails.
> 
> Fixes: 282a4e4ce5f9("platform/x86: Enable Atom PMC platform clocks")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---

It says v2 in the subject, what is in v2 exactly in comparison to v1?

...

>  	ret = pmc_setup_clks(pdev, pmc->regmap, data);
> -	if (ret)
> +	if (ret) {
> +		iounmap(pmc->regmap);
>  		dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
>  			 ret);

In this case it makes sense to move to

		dev_err(&pdev->dev, "platform clocks register failed: %d\n", ret);

> +	}

-- 
With Best Regards,
Andy Shevchenko


