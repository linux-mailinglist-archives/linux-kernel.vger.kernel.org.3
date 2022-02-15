Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8264B6C02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiBOM2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:28:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBOM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:28:00 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE6107AAB;
        Tue, 15 Feb 2022 04:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644928071; x=1676464071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RhsArYRmWUjv92mfHTpn/hhqqJT+C/mxoD6qW8AsTjY=;
  b=NnmExAp85fcoz3nWkxxrax8gTGyeKjkWu44qgPliw9Jz7xiNDLT6te9o
   TV4JdQeu98M7vgP8HhyZxuWSph2CmeZdUnSs4RrS560XWKdeEw2yvZveo
   9mG94Byzlp5zlxyOa6NOhFcj8z3OxU9IhlI8OSYF5rgCjubsVBRHM2sIE
   nZrGH/MRJMBshqrzBVrUb0r7NPI+wtVQUKfx/q6UaRpeY22J1km6Ol2v4
   T1yP15S3r+ks63LynMp1RVXXlFbhSQ+Zuy3vARLDOtcWZuAyyuut6Jt5q
   4z5RfK87ylxpkcmebE6IaJdEcr+JzGjkW3sw5PzYKXLL8sVzCHtrAoVes
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="311077686"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="311077686"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:27:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="773496380"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:27:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJwv0-004ur5-K3;
        Tue, 15 Feb 2022 14:26:54 +0200
Date:   Tue, 15 Feb 2022 14:26:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qing Wang <wangqing@vivo.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_mid: Balance reference count for PCI
 DMA device
Message-ID: <YgucDuOsCbogHRV9@smile.fi.intel.com>
References: <20220215100920.41984-1-andriy.shevchenko@linux.intel.com>
 <db576c63-73e2-b5f8-bc8b-057bdab2264d@kernel.org>
 <YguAncl92hV2vUkm@smile.fi.intel.com>
 <YguBEJ1cc0TMQLuE@smile.fi.intel.com>
 <f8ffca37-6029-6103-e3cf-0c2c62d04485@kernel.org>
 <YgubxsqouAl1zXFK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgubxsqouAl1zXFK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:25:42PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 15, 2022 at 12:08:26PM +0100, Jiri Slaby wrote:
> > On 15. 02. 22, 11:31, Andy Shevchenko wrote:

...

> > No, I mixed up patches :P. This was meant as a comment to
> > "serial: 8250_lpss: Balance reference count for PCI DMA device"
> > 
> > byt_serial_exit() isn't called when byt_serial_setup() fails with EINVAL if
> > I'm looking correctly.
> 
> I see now, thanks for catching this!
> I will send a v2 soon.

What do you think about this patch? Can you give your tag if the code is
looking good?

-- 
With Best Regards,
Andy Shevchenko


