Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43B654510F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344560AbiFIPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiFIPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:40:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2128264D8;
        Thu,  9 Jun 2022 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654789221; x=1686325221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0meZMeXRVt+T0/yrWzbylwSvLRo1LFficXb2EiYhUQ=;
  b=I5VHb1xQ1RCqZkh1YF35pX8eOFpslT4EBgXLbX+Z0RQR+aEAz4I8l9Rj
   UD20W9wwossOOqgkYLWERVuF2ExDmlqevm5l4PN+oKQEg1L8lDvPW3zpo
   s88U6eSdT8I8wei4AzAvcZTTuRFmOJ7a3DVR7+b+Emc3G4QQnJbpKzW2x
   usSDy3gR20ckwestrfIafr354o69rR+NdGl628+t0E8maO+3wiQhSDunW
   eh+Gho9jrPfsXcFaS7y+7f0N+QciTjAkAfkhxdMzVWvs1y9FUv3mDoMdF
   qVzf/ne3RE+xuYTWCbdkYbtVioDeBDFjiHDkrJoCcQ6HweIDFsGUqj+P/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302692566"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="302692566"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:40:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="724490262"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:40:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzKGc-000Xz4-Dz;
        Thu, 09 Jun 2022 18:40:14 +0300
Date:   Thu, 9 Jun 2022 18:40:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 09/16] ACPI: video: Use acpi_dev_for_each_child()
Message-ID: <YqIUXtyvT1mQBLJ7@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <22695031.6Emhk5qWAg@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22695031.6Emhk5qWAg@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 04:03:37PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.

...

> +	return acpi_dev_for_each_child(device, acpi_video_bus_get_one_device,
> +				       video);

Perhaps one line?

-- 
With Best Regards,
Andy Shevchenko


