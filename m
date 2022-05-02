Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254425173B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386090AbiEBQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiEBQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:08:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA7EBC3D;
        Mon,  2 May 2022 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651507508; x=1683043508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mTN/sFuEKOvHaXrCmuIKcyX8bTKXzMSHR2ip8sSamBk=;
  b=NlQQgGyv35yNl4gAZEIF4PGmPBhe89/v588AeYSSXWjID/0ubTdgwxrl
   djuVRjvV56tyZCuTBxptbj6WPBKbSCsE3Mjtt76CtbCcLyjWM13ZbposO
   K11rOIafOmFJhrlF7ptXCp+rMU4H20FfpyvwGm0RmRICx7B1AlTAgUk9n
   UKHwdlQZqVQZKe1SGm1uN/JjvzInufpMSxX+wFyz2wIck2I46gT2csjyI
   0KF6FkQBMVVpOFUTZK9lL/+mUQ8CnrYl7PmpsWjmgifPQFJUKb+0OGB+a
   7fktiCcuylRcic1X2aQBacwqOHQ3rtO44ix9/6xZguZtERGoxwpbnA/SR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330239489"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="330239489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:05:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="516162976"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:05:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nlYXm-00B6Tb-Tt;
        Mon, 02 May 2022 19:05:02 +0300
Date:   Mon, 2 May 2022 19:05:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional
Message-ID: <YnABLhyUGR+ZRQ+u@smile.fi.intel.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <YmpoeJtFNSyCq1QL@smile.fi.intel.com>
 <20220428181131.GG12977@windriver.com>
 <827dc313-33ff-1c91-afaf-7645b655a1be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827dc313-33ff-1c91-afaf-7645b655a1be@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 04:30:57PM +0200, Hans de Goede wrote:
> On 4/28/22 20:11, Paul Gortmaker wrote:

...

> As for users breaking support for BYT/CHT setups because they forget
> to enable this, without X86_INTEL_LPSS being enabled BYT/CHT are pretty
> much broken anyways and since patch 2/4 adds a "select PMC_ATOM" to the
> X86_INTEL_LPSS Kconfig option I'm not really worried about that.
> 
> I'm afraid this patch-set might break some randomconfig builds though,
> but I cannot see anything obviously causing such breakage here, so
> I think it would be fine to just merge this series as is and then
> see if we get any breakage reports.
> 
> Andy, are you ok with me moving ahead and merging this series as is?

It seems as is can't be fulfilled due to your own comment, but in general I'm
not objecting the idea. So, go ahead if you feel it's ready.

-- 
With Best Regards,
Andy Shevchenko


