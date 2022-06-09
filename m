Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3C5450D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbiFIP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiFIP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:29:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DD31237;
        Thu,  9 Jun 2022 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654788549; x=1686324549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LcYJN4aKPVwSNGUQj9U9ZpXLKWEeaZUocvmuITdYYBk=;
  b=hQNfSYECiFAL/nvqfP54VjGLwlXB3EsglTrF1hEr1O3fsG4/+S2p3ch3
   NUAsGErjapr/MNbM46MVo9Loh1RCGNpbktX4L7J6Uf5EmPLwJT5QAtDeK
   F2V8aqBj2+NfuQ5NvVeUNqoIBMB5EW0cCpkZwimtluoUrFSMNqiE+pFRR
   X8doNpyLZxQ0y0k9mmRwhcxZNWW3kof1HScYJ7wMouTkWK/pEJBg9MHvj
   afUl260RaC3Ib0TchgrfUvJUVYJ7H+pfT+hTsaBR/ttMjBPjyQrF5/C3q
   lkHgALg4ytZi6DH9lO7FwRnPTi0pQZDApvflHLbJ0G//+OOhwHGSZ+VBD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266096004"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="266096004"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:29:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="649317532"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:29:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzK5n-000XyN-Rz;
        Thu, 09 Jun 2022 18:29:03 +0300
Date:   Thu, 9 Jun 2022 18:29:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 06/16] ACPI: container: Use acpi_dev_for_each_child()
Message-ID: <YqIRv8xnGciF2wBd@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <3131424.5fSG56mABF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3131424.5fSG56mABF@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:58:24PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.

...

> +	return acpi_dev_for_each_child(ACPI_COMPANION(&cdev->dev),
> +				       check_offline, NULL);

I would find this on one line better and not missing important details after
80th character.

-- 
With Best Regards,
Andy Shevchenko


