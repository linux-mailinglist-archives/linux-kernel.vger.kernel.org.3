Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044894D9C34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbiCON3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiCON3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:29:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AAA45AF7;
        Tue, 15 Mar 2022 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647350921; x=1678886921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=02kENQ6kKx62srv1XWDWw5brudPYvm0qNUEOOPz3Ok4=;
  b=gKO1GyOKRTI64lc+2urJhnVVppeG6JzFIS+2KmEOpC0frNn43ZJm1jY+
   8mKMbAwGWoF6wlka2KgyebiVCzBGRE8qR0cVxJgENAxn9xRxlf0KWsyfY
   WTgalrAVg6FCNUJNkIRgw0dglG+fkbeqDcY0qfzo83p78MotzFFxom9kr
   RYIUDreF568/0qSpikJD29XFkpOyQme8gp2UfMnRX7nQW5XY3mBHX6XeT
   fyPtFRRWE+93JfJPwEpSPS6r805W5QJM0pY4Bt/F2lD4yT3FiwHArFKkk
   3Tgg4VtmtnyFFDiX6IxDN4KNVuBxvgSDV3BtOdd+Np6OqIoi2L5mTZRGy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236244588"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="236244588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:28:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="646220776"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:28:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nU7DD-000HQ9-GW;
        Tue, 15 Mar 2022 15:27:43 +0200
Date:   Tue, 15 Mar 2022 15:27:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH v4 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YjCUT3WhNWfrE+VJ@smile.fi.intel.com>
References: <20220308123712.18613-1-andriy.shevchenko@linux.intel.com>
 <20220314195138.20036-1-michael@walle.cc>
 <CAJZ5v0hbY8XCC-DfkoPFe15awV_FOpq91pUZvmZ9JrYi1QBMEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hbY8XCC-DfkoPFe15awV_FOpq91pUZvmZ9JrYi1QBMEg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:16:01PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 14, 2022 at 8:51 PM Michael Walle <michael@walle.cc> wrote:

...

> > This breaks SFP/phylink (using the lan966x switch) on my board. See below
> > for more details.

Michael, thank you for the report, I'll investigate it further.

> I'm dropping this commit for the time being.

Thanks! Fine with me as I think it's not critical (the current or pending users
of the fwnode_find_reference() are / will be aware of the error pointer).

-- 
With Best Regards,
Andy Shevchenko


