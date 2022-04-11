Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636D94FBDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbiDKN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiDKN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:56:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4624F2C;
        Mon, 11 Apr 2022 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649685235; x=1681221235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ietpjAH2T/bkGKzP1TWlkHX10R1PiEwOjSTCOSWzC/E=;
  b=dAwO6bDG/YC9ESQmMFpbbD2uW3ozKtW/UAk9hNSrEh6oULLuFVY/b7gp
   upLGbcLRNqZVtbqPfnbLi+0uwhoaLDd7DGTMxNl7Cf6urzEOEgIYEkn5S
   ecIhMWQbVqITvMd09HFmWZLSOfj7NwRjcrlw6tc+ICML7XSb7CFQzyasH
   6xptn2gJUfdBN+bPWimaffjXBFO1W38G2qexqN/QmS0fVusLqgNY4gsSj
   vO8MB+xP58VBHN6UGy2jdH7NA/L4rZqZWT96HRh1CRKw8ykm4AGOuB9BL
   PvgPymyAKxotzAeKIsYcAKxAF4wb1vi8q4Eh13bRcI9YN4s3y5cjoxigW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242057827"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="242057827"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:53:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="654627742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:53:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nduQl-001Dys-JD;
        Mon, 11 Apr 2022 16:50:11 +0300
Date:   Mon, 11 Apr 2022 16:50:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v6 1/5] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YlQyEz3/J0rb2Hew@smile.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 09:48:40PM +0300, Andy Shevchenko wrote:
> Some of the fwnode APIs might return an error pointer instead of NULL
> or valid fwnode handle. The result of such API call may be considered
> optional and hence the test for it is usually done in a form of
> 
> 	fwnode = fwnode_find_reference(...);
> 	if (IS_ERR(fwnode))
> 		...error handling...
> 
> Nevertheless the resulting fwnode may have bumped the reference count
> and hence caller of the above API is obliged to call fwnode_handle_put().
> Since fwnode may be not valid either as NULL or error pointer the check
> has to be performed there. This approach uglifies the code and adds
> a point of making a mistake, i.e. forgetting about error point case.
> 
> To prevent this, allow an error pointer to be passed to the fwnode APIs.

Rafael and Greg, if this okay for you, can the first three patches be
applied, so we will have at least the fix in and consider constification
a further work?

-- 
With Best Regards,
Andy Shevchenko


