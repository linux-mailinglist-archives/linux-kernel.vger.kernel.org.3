Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10767469859
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbhLFOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:17:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:63767 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245673AbhLFOR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:17:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237260920"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="237260920"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:06:46 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="579381160"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:06:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muEch-002nkt-6l;
        Mon, 06 Dec 2021 16:05:43 +0200
Date:   Mon, 6 Dec 2021 16:05:42 +0200
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
Message-ID: <Ya4Ytr9re/a8oP/6@smile.fi.intel.com>
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

Okay, this driver is two in one, i.e. library for PMC access and some other
stuff. When you do iounmap() you ruin library routines with that.

So, my other comments are fine in general, but not applicable here.

NAK.

-- 
With Best Regards,
Andy Shevchenko


