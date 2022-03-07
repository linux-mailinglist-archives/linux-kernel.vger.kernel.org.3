Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C07D4D03E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbiCGQUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiCGQUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:20:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E24D9C4;
        Mon,  7 Mar 2022 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646669995; x=1678205995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nCdJ9kv9kF9+cM2VoJw0GpTu/gzqvrLvVOduS7j3Scc=;
  b=CQnyZ6uKeXx+2VdZoFPbzHVP6x4A19dlH6gtmodZooPLgDtxfy9Ef6tQ
   RrnG9bSiU4XxO88sHs1im9ZaciIN+bebuCbb0M7bOtq0++KfIZaOyDWJB
   ZIUIE+nmZeWtsjTPX6aRnP4LtBhI1zXMkLrK5OmZdmwL1NMSm7Xmulsz3
   PYteMph+DQILcVMwmC7I4hz+aJvhQJC8FrUteYZAz0xOGkBbj+hav0P33
   L+DPlCpQ7bWHy1gXcEUA9ufvBMZeVDRsRraZQzsOZCEoUZTB3l13Ag1TJ
   JivhwQBiVT5fjjweMIbIXfRKwPT11BiZnDYDcEOsxSlycGfEIC5fyr2h0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="241865103"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="241865103"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:18:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="711162057"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:18:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRG3T-00CrIo-NM;
        Mon, 07 Mar 2022 18:17:51 +0200
Date:   Mon, 7 Mar 2022 18:17:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YiYwL7gCprl69A2c@smile.fi.intel.com>
References: <20220304173256.39059-1-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB67863963179FBA901E649C7599089@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB67863963179FBA901E649C7599089@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 04:15:23PM +0000, Sa, Nuno wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, March 4, 2022 6:33 PM

...

> > Some of the fwnode APIs might return an error pointer instead of
> > NULL
> > or valid fwnode handle. The result of such API call may be considered
> > optional and hence the test for it is usually done in a form of
> > 
> > 	fwnode = fwnode_find_reference(...);
> > 	if (IS_ERR_OR_NULL(fwnode))
> > 		...error handling...
> > 
> > Nevertheless the resulting fwnode may have bumped reference count
> > and
> > hence caller of the above API is obliged to call fwnode_handle_put().
> > Since fwnode may be not valid either as NULL or error pointer the
> > check
> > has to be performed there. This approach uglifies the code and adds
> > a point of making a mistake, i.e. forgetting about error point case.
> > 
> > To prevent this allow error pointer to be passed to the fwnode APIs.

...

> > v2: adjusted the entire fwnode API (Sakari)
> > 
> > Nuno, can you test this with the ltc2983 series, including the
> > IS_ERR_OR_NULL()
> > fix to it?
> 
> Hi Andy,
> 
> Just tested this patch with the ltc2983 series and now 
> fwnode_handle_put() does not crash when fwnode is an
> error pointer. I think this usecase does not cover all
> of the patch so I'm not sure if a tested by tag here is
> meaningful...

I believe it still makes sense because we understand what you have tested.
And at least it has some kind of BAT:
- compile testing
- testing (some of the) branches

> If it is, go ahead:
> 
> Tested-by: Nuno Sá <nuno.sa@analog.com>

Thank you!

I'll send v3 because I want to amend the commit message.

-- 
With Best Regards,
Andy Shevchenko


