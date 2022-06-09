Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7002A54505D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbiFIPOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiFIPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:14:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284A46150;
        Thu,  9 Jun 2022 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654787666; x=1686323666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wr33ML0e4lODezvF0rSXZW2gyNc2rLAlNWAvEtgI1TQ=;
  b=b2ls8HuuIxikpqK190ySTuiJx0LidsWad4miA2YaT/RD0WTlUxjMjhtc
   0aMcoY0pVMYkkwM/t9YIdgix8wZ3yRBm0oS7wwUXnqf7kD1OaI7nGoqsM
   77ePbIPoPBbYsTuc/Bauup64Ipd3Hi8JFPMLqzqzJKKYq4SWxRlQZ9a03
   KanP9teVV95x6r56zbZE56rPubkx9XfmlSUZNi72PKi9HbOfYIEcSJZ24
   dOFQH7Ew+HqEtsFkG2/YYl+qS7e8Tbm8UNdQHb3tHGZeifamZoRhDKRyK
   S5I1JskXsRTFi34k0PzKRSYXnR9WmXPGYCcqSjnrn4N/O1ArIkLTkp7dX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="274837351"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="274837351"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:14:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="649312322"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:14:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzJpR-000XxY-4u;
        Thu, 09 Jun 2022 18:12:09 +0300
Date:   Thu, 9 Jun 2022 18:12:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 00/16] ACPI: Get rid of the list of children in struct
 acpi_device
Message-ID: <YqINyDTfpNBGDYlb@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:44:27PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> Confusingly enough, the ACPI subsystem stores the information on the given ACPI
> device's children in two places: as the list of children in struct acpi_device
> and (as a result of device registration) in the list of children in the embedded
> struct device.
> 
> These two lists agree with each other most of the time, but not always (like in
> error paths in some cases), and the list of children in struct acpi_device is
> not generally safe to use without locking.  In principle, it should always be
> walked under acpi_device_lock, but in practice holding acpi_scan_lock is
> sufficient for that too.  However, its users may not know whether or not
> they operate under acpi_scan_lock and at least in some cases it is not accessed
> in a safe way (note that ACPI devices may go away as a result of hot-remove,

> unlike OF nodes).

Hmm... Does it true for DT overlays? Not an expert in DT overlays, though,
adding Rob and Frank.

> For this reason, it is better to consolidate the code that needs to walk the
> children of an ACPI device which is the purpose of this patch series.
> 
> Overall, it switches over all of the users of the list of children in struct
> acpi_device to using helpers based on the driver core's mechanics and finally
> drops that list, but some extra cleanups are done on the way.
> 
> Please refer to the patch changelogs for details.

I'm going to look the individual patches.

-- 
With Best Regards,
Andy Shevchenko


