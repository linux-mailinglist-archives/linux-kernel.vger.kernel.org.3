Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7E4D1704
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346740AbiCHMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346732AbiCHMPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:15:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76143ED3;
        Tue,  8 Mar 2022 04:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646741681; x=1678277681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pj07O+oiBpvt9RG+DMy/vaA6wCldd0Kb1X9+1g+qKKk=;
  b=nk46dBewC7OoH88g5BrYrpB7wkmfnWgJkccsipXV1jMZtgMjwt7dlscd
   94FfGr8xOIDI1dC0HhAWg39V9w+G0k9e7caeeA3lBsezmdOSp/I/FfsCU
   Alz0mC+Rda8l0KMlfEhzLsjp/yy67zB2M0E1h+DHDvNbswFKYak1bsz0f
   NqJoNy/bRM//+pdiuHOVuxc+n5XXC9W4XTK2qUUl/Qe6sLzNwge/rqxeB
   ORD8FbiQcQkoRxzTWB00oHTv6L3NExkZvHk9BAlSRPC/9sM+ahTF9GQ8q
   A0i8uq7ZXfU1gow2lcFpL5Xa5HpS88f++9GMdGKPEs2Oonbyi99eyrKpK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317898528"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="317898528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:14:41 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="537546642"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:14:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRYiw-00DLej-Di;
        Tue, 08 Mar 2022 14:13:54 +0200
Date:   Tue, 8 Mar 2022 14:13:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/1] staging: fbtft: Consider type of init sequence
 values in fbtft_init_display()
Message-ID: <YidIgkiv7B8g14RD@smile.fi.intel.com>
References: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
 <Yictcf0BCvveVT+V@smile.fi.intel.com>
 <Yic0CN+qSvDtSiEz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yic0CN+qSvDtSiEz@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:46:32AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 08, 2022 at 12:18:25PM +0200, Andy Shevchenko wrote:
> > +Cc: Helge
> > 
> > Maybe you can pick this up?
> > 
> > On Fri, Mar 04, 2022 at 09:34:14PM +0200, Andy Shevchenko wrote:
> 
> You sent this less than a week ago!  Please relax, staging driver
> patches are way down my list of priorities at the moment.  Wait at least
> 2 weeks before trying to get someone else to take patches for this
> subsystem.
> 
> relax...

Ah, okay. Sorry, I was browsing my long mailbox and haven't paid attention on
the date I had sent this one on.

-- 
With Best Regards,
Andy Shevchenko


