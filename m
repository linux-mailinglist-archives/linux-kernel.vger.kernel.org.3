Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96D51312F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiD1KXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiD1KX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:23:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFB6408;
        Thu, 28 Apr 2022 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651141211; x=1682677211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geWC0vTfFeW70jzj+mxX3TbT5h1lFqMsvssH+3VsSkA=;
  b=FuMLTKVLL0sTWgkFO219V8larkQ9LHiJtZN4Llsd/8c31nOOIiNyjR2i
   KwkmaxYS/jeG6RZII+m9EPhEpPG4RV8JeKjyDpP6r1yQ6RDz6Jg9YO6dy
   5ciU7QQpu6bFrvVSrPcqkmHOPRCG1fjeuwdfnb60PBH5sQBVQbPw5bpwu
   /Zu3+7Dx0egUX4PvI6NYQpJKJZ6Z1q7QCNjp61dDohFgBJiGYeP5Ed5zS
   S6zqkvSB8przd8fH0yZW0pdtP9TX+wf/jmDUipgamrQbjbgNFHnCGtePm
   f+PPAuWn/+IDQXP33lLHHWenPRjJLiQlvWP98Cem6+Yofp/grgIGCYoxV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266049574"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="266049574"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:20:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="682425717"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:20:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nk1Fm-009FRL-1y;
        Thu, 28 Apr 2022 13:20:06 +0300
Date:   Thu, 28 Apr 2022 13:20:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] platform/x86: pmc_atom: make the PMC driver actually
 unselectable
Message-ID: <YmpqVUSva0HUNUXD@smile.fi.intel.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <20220428062430.31010-5-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428062430.31010-5-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:24:30AM -0400, Paul Gortmaker wrote:
> This caught my eye when I saw it was def_bool and hence largely
> pointless to have a Kconfig for it at all.
> 
> Yet there is no reason why you shouldn't be able to opt out of Atom
> platform support if you only care about desktop and server class CPUs.
> 
> It was introduced as def_bool, but there is no obvious reason as to why
> it was forcibly built-in for everyone, other than LPSS implicitly
> relying on it (which is now fixed).  So here we fix up the Kconfig and
> open the door for people to opt out.
> 
> Since putting "default y" on anything that isn't absolutely essential is
> generally frowned upon, I made the default be CONFIG_MATOM.  People who
> use "make oldconfig" or similar won't notice any difference.
> 
> The two "unchanged" lines for PCI and COMMON_CLK appear in the diff from
> fixing a whitespace issue that somehow managed to live on despite being
> moved between two different Kconfig files since its introduction.

>  config PMC_ATOM
> -       def_bool y
> -       depends on PCI
> -       select COMMON_CLK
> +	bool "Intel Atom SOC Power Management Controller driver"

s/SOC/SoC/ here and everywhere else in this patch.

> +	default MATOM
> +	depends on PCI
> +	select COMMON_CLK
> +	help
> +	  This enables support for the Atom SOC Power Management Controller
> +	  driver, and associated platform clocks.  If you intend to boot this

One space is enough.

> +	  kernel on platforms with an intel Atom CPU, say Y here.

Please, list the Atoms that really need this, for example, Broxton doesn't.

I believe the list should include (but not limited to):

	Intel Bay Trail
	Intel Braswell
	Intel Cherry Trail

-- 
With Best Regards,
Andy Shevchenko


