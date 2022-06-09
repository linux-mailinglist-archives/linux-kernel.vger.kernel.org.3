Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15705450C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbiFIP0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbiFIP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:26:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4E4B407;
        Thu,  9 Jun 2022 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654788377; x=1686324377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LfRhNY4IeUXJ5GUS/DdcyZ4zd1tukJjcMtxj4uvvm2M=;
  b=RbdIl56mZRFQ++Vb6P+qQtWA/r2/QMNZdslywj73H5r4BRLUlHAvVlUM
   +OX11BiAAS49Jqv6FPvoBJAbRtEFzWW3uoRFf1lA9J7PwLWyFo5gUhAk7
   /CSwsgTI3dFUcVJQhT6FUxiZxpR2atAob/B/4WYiy8jAiIX+Y82oHbfpA
   cn3YlhAcEqe10DCaPOCPhoSG4rvSAlocIs83RK+Ad338n+gFU3IpJ8lu8
   jXlU31fPwZ9Chqz/+YCagEtwMhMP5UltZ9BNGIxkvKjH04XCwonAaZ3Fx
   2Y+V2jVST8xpUjP+lWPeZlrw0W05SVRWc8T9v8rxstsJ0S+4AivHKNC6f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339078181"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="339078181"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:26:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="684017304"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:26:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzK2e-000Xy5-Qg;
        Thu, 09 Jun 2022 18:25:48 +0300
Date:   Thu, 9 Jun 2022 18:25:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 04/16] thunderbolt: ACPI: Use acpi_find_child_by_adr()
Message-ID: <YqIQ/HbSS9/0Fe/A@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <7414189.EvYhyI6sBW@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7414189.EvYhyI6sBW@kreacher>
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

On Thu, Jun 09, 2022 at 03:54:40PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly
> in order to find the child matching a given bus address, use
> acpi_find_child_by_adr() for this purpose.

...

>  	if (!adev)
>  		return NULL;

Already checked in the below call, IIUC. Hence can be removed.

> +	return acpi_find_child_by_adr(adev, port->port);

-- 
With Best Regards,
Andy Shevchenko


