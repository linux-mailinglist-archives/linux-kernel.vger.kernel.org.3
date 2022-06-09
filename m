Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1833545113
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbiFIPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiFIPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:41:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF91C5915;
        Thu,  9 Jun 2022 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654789263; x=1686325263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2HFR+cNA9oe1wo8qYpDqHV/TYkzOI48bE6rdd6UD88=;
  b=dXJ6baYpGCZZKcTj3SttjzGyGkaxcJ+mB9qaSSbT84di0KrAsD/oNzpl
   v7ABzkgYHQKdDWdMMgFmATT68QfhrgAePxS552zpIM35cMVIRdlQ4z+iR
   wuDhzz1HvsHrZAoN/4Oy8H45B+d2/wxpSAbmU7zIi5rpiF6I0rcC80SBA
   fXkAa7lIyLsKkyeSY2zj76+ZqpBaF5RkcsiI6nnfR9hN9QHH+85fqKq6p
   CPAhoB9+xMxRabKo6qdPogaInJVzNWV7HyfoNkklwPdgnfKOMeel9erVy
   8B1DhwSdOijPyKUAsgUUMzN5MM0FZVN7el5XWbnqaMGM5Od5gALbI5d4T
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278469195"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="278469195"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:41:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="760110181"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:41:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzKHK-000XzE-3M;
        Thu, 09 Jun 2022 18:40:58 +0300
Date:   Thu, 9 Jun 2022 18:40:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 10/16] ACPI: bus: Introduce
 acpi_dev_for_each_child_reverse()
Message-ID: <YqIUiQEOJVFSvATD@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <2137459.Mh6RI2rZIc@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2137459.Mh6RI2rZIc@kreacher>
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

On Thu, Jun 09, 2022 at 04:06:21PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make it possible to walk the children of an ACPI device in the revese
> order by defining acpi_dev_for_each_child_reverse() in analogy with
> acpi_dev_for_each_child().

...

> +	return device_for_each_child_reverse(&adev->dev, &adwc,
> +					     acpi_dev_for_one_check);

Perhaps one line?

-- 
With Best Regards,
Andy Shevchenko


