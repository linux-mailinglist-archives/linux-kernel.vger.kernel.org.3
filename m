Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DD4B6BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiBOM0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:26:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiBOM0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:26:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916C6D4EA;
        Tue, 15 Feb 2022 04:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644927999; x=1676463999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mAOEDZwZltc79R8ljIE8KX8QQVn+66VpKFi11FYX9sU=;
  b=EIRnqus/hw2MB3+g30fZIVTkAA6ie9U1gepphGQMgCYF7bcFVdxdDTtg
   Jw4Rspe+xJvqyIffeEDop8Tg63yWWPERS1LJmpduO+Lgf4VsgK9KPUbix
   N7S4GNlcJEl3HyGDag0JG541eXnE3huoLcj0aFQUpZF+GA0Bf5BOT5wDc
   AMdm62Z1GMvuKUdypqTTe+hZFDnQK+loJuk/jbe1gDhJbJ46TN2cQ3D31
   QTrExDQW4Bz0y8CcDgSpOKiQM9mtgEV1xVENcGQikC/5MPUDWAkEgJfIS
   uxhE3Sze9hDRH7xlQYMI/V2sk501L54NIYP6GKgzMO4gC1OM6STU9yZWS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230303529"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="230303529"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:26:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="624765025"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:26:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJwtq-004upb-TR;
        Tue, 15 Feb 2022 14:25:42 +0200
Date:   Tue, 15 Feb 2022 14:25:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qing Wang <wangqing@vivo.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_mid: Balance reference count for PCI
 DMA device
Message-ID: <YgubxsqouAl1zXFK@smile.fi.intel.com>
References: <20220215100920.41984-1-andriy.shevchenko@linux.intel.com>
 <db576c63-73e2-b5f8-bc8b-057bdab2264d@kernel.org>
 <YguAncl92hV2vUkm@smile.fi.intel.com>
 <YguBEJ1cc0TMQLuE@smile.fi.intel.com>
 <f8ffca37-6029-6103-e3cf-0c2c62d04485@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ffca37-6029-6103-e3cf-0c2c62d04485@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:08:26PM +0100, Jiri Slaby wrote:
> On 15. 02. 22, 11:31, Andy Shevchenko wrote:
> > On Tue, Feb 15, 2022 at 12:29:49PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 15, 2022 at 11:11:41AM +0100, Jiri Slaby wrote:
> > > > On 15. 02. 22, 11:09, Andy Shevchenko wrote:
> > > > > The pci_get_slot() increases its reference count, the caller
> > > > > must decrement the reference count by calling pci_dev_put().
> > > 
> > > > And what about the -EINVAL case?
> > > 
> > > What about it? The ->probe() calls ->exit() in its error path.
> > > Or did I miss something?
> > 
> > Or you mean that we call pci_dev_put() on NULL pointer?
> > This is completely valid case and handled in the callee.
> 
> No, I mixed up patches :P. This was meant as a comment to
> "serial: 8250_lpss: Balance reference count for PCI DMA device"
> 
> byt_serial_exit() isn't called when byt_serial_setup() fails with EINVAL if
> I'm looking correctly.

I see now, thanks for catching this!
I will send a v2 soon.

-- 
With Best Regards,
Andy Shevchenko


