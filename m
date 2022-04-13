Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2C4FFDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiDMSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiDMSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:25:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E86339B93;
        Wed, 13 Apr 2022 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649874191; x=1681410191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/+xMj+IKFmTxJpJGVNQWc4V5J5OA4f1IEmIa7d8H4Mk=;
  b=Qim5kBZ+UE2k4hXTa7QQQvpMULUMqdIYQS7JSDAtZILlJZXSPM+Rm0b4
   Wno8wbx7SgU/W+8ZDqbByzByZLWM0XhCsoq587dLXOaZrPpGEGQceyK8u
   zDrXHid8FbAde+yh05iIdQZzuMV4KuWhn8apSAzchTBn6c1LV34w/H5TH
   jQWpj5HPGWErzv7mPIkjv3Iat5RklaaqpBd/rEPiuYc9PVk6/6WPPc1gG
   AAcRr0E/H6Z0b20Z4xTdKp6dcrDybOYhMGLI3MOMYP3fJF1WFeiVfUxNt
   c1f5pj5Eg8ebStgl0cEFjfY8cPxefAKUKCSXScL3e6KYkGNU71I7t7smb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261588079"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="261588079"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:23:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="661034729"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:23:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nehaS-001xbd-Qr;
        Wed, 13 Apr 2022 21:19:28 +0300
Date:   Wed, 13 Apr 2022 21:19:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
Message-ID: <YlcUMNe5gDsEca4f@smile.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jnyg6n-1QRmVg1tjzu3szsG3DYqYTXAbobbKwkFhTreg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jnyg6n-1QRmVg1tjzu3szsG3DYqYTXAbobbKwkFhTreg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:10:22PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 8, 2022 at 8:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> > +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
> >  {

> >         if (!fwnode_has_op(fwnode, get))
> >                 return fwnode;

^^^^, so it needs a casting, but then we have to comment why is so.

> Why is 0-day complaining about this one?

-- 
With Best Regards,
Andy Shevchenko


