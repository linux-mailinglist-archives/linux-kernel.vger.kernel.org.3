Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C736B51315D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243545AbiD1KjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiD1KjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:39:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D706A02A;
        Thu, 28 Apr 2022 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651142158; x=1682678158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNerj3kD6Y8mhAk9ompGhzAXz6vRVhoVMUf84Vky2Bs=;
  b=AxB1IynCFV/sawUjAe7ALmfcYROgwH6GcBZGsVj4cvVOSqEo5m16svKP
   ppaQb9feuMnoFNUM8dUl6wYU/98C7thSE4BjGt0R9MA4Q2pEfJEgvXXas
   CvU/lAlL1BIMrNWk1ykOgslvjXO2KYwiNV027mDee9zFH2RwUCxDOw/Xh
   LPixaeEJlfx+Z/CuYcsY6jA176ndSNYSatuF9N0Hj67Yd1HapjYw/67CD
   MK2uzQHDkeR/kUKSRsIxuEl4Z/Q+GkqBXjJLm0TeTBhKxrVUqwLNqaZpH
   WrcWrS1Mg1ZG2GI18FIaVWvoaYE0LA7LCanjJmKErUroOSlU/NNjylDIT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="253624161"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="253624161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:35:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="581267741"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:35:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nk1V2-009FkD-EH;
        Thu, 28 Apr 2022 13:35:52 +0300
Date:   Thu, 28 Apr 2022 13:35:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] ACPI: LPSS: make the Kconfig dependency on PMC_ATOM
 explicit
Message-ID: <YmpuCG76aJ+d5lGH@smile.fi.intel.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <20220428062430.31010-3-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428062430.31010-3-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:24:28AM -0400, Paul Gortmaker wrote:
> The code in acpi_lpss.c has been unconditionally using pmc_atom_read()
> for about the past six years.  This hasn't been a problem since you
> currently can't disable PMC_ATOM short of disabling PCI entirely.
> 
> But it doesn't need to be that way, and so that we can change Kconfigs
> in a subsequent commit, we make sure LPSS selects PMC_ATOM in advance,
> so that existing .config files can live on with "make oldconfig".
> 
> In theory, one could make LPSS build w/o PMC_ATOM, similar to what it
> did six years ago, but I doubt there is any demand for that now.

I'm wondering if without LPSS we may use those devices to some extend.
If it's the case, this patch is half-baked since it's missed the network
and audio drivers to also enable it (see PMC clock driver registration
and usage).

That said, I'm not sure it's beneficial to spread this selection over
the drivers that may be used widely on non-Intel-Atom platforms.

-- 
With Best Regards,
Andy Shevchenko


