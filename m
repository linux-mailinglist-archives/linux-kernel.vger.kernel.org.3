Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3754513A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiFIPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiFIPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:49:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C486FA1A;
        Thu,  9 Jun 2022 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654789784; x=1686325784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVJ9nUrab+QmY+GSG1HNCt4wr+crK76F+ZOhFnD2E0w=;
  b=JAZZ2keXx9EXVhm/xq9bfTMk21fwcVbo+56gcXyxng7u+0n2sWdwm3y9
   LNzEv/r/5KtYy1D7Vd1rKc9xLFoqJvT7r4/4GZe8QxoNQrT0mo0cWBZ0z
   DY3xDROgytjr9NEpeYA94OBMLi6I6v9JT9aeFR+iBA8nd3DSYi1gqsULP
   zZywsTNu97NXEI/1bcznOStDmQfCSWA1alyXigTHuxLuEsUzyaPNjzhft
   FL78kMUZmCL/CcZnfeiodiAJ0Eah9HsP5UH0hqBU1IIXtFGFs4U3Fg3uy
   EZzil9iKkVovASTUnn5t6tXBzr5sWPQAji+zIQ84FOKWq2LeyRf7IKcUg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341399797"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341399797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:48:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="724492128"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:48:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzKOU-000Y0J-OW;
        Thu, 09 Jun 2022 18:48:22 +0300
Date:   Thu, 9 Jun 2022 18:48:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 12/16] platform/x86/thinkpad_acpi: Use
 acpi_dev_for_each_child()
Message-ID: <YqIWRnwyqXZppuxN@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <44750652.fMDQidcC6G@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44750652.fMDQidcC6G@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 04:09:45PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.

...

> +	rc = acpi_dev_for_each_child(device, tpacpi_evaluate_bcl, NULL);
> +	if (rc > 0)
> +		return rc;
>  
> +	return 0;

It can be simply 'return acpi_dev_for_each_child();', no?

AFAICS the caller is prepared for negative returns.

-- 
With Best Regards,
Andy Shevchenko


