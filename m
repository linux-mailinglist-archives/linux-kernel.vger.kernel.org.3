Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF053C907
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiFCLET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiFCLEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:04:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374C3BFAC;
        Fri,  3 Jun 2022 04:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654254252; x=1685790252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W/HKIRPNvX152Z7BaxTdygVLuFAkWmCdbyYuVpi8UJg=;
  b=aaALueKCYAelRvh3ATmM8b2MGMPKbf9ccvLQXzwpXJtPu437lmnKsSeN
   Z7QQQpIG0E5yMX+D6Z5x9oNGeLtSZ+o6qIVUojQvMBgbA90525ORZNr3r
   IlgsAmFVpCxwyXPRCBiRi7xKN4YsYHwIUw1VE4lVISk9XSwNM8Oq0/IE4
   lLOOq1KY+OGFwsfKHgS2Lnf3udejdyqledqxtufCaUfKtNobDu4ovZ6WA
   pN6m7FNkO3GJ4oDhU7I7fy73D+bxwtOBNshtjfBa2M1Q2RinxzADj1N0p
   y0y4mbn1lRMoReaF32SHlsGjsbQa260Jr7Tn//nZCkO393BSAUvfGqY/x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="276297015"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="276297015"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 04:04:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="530969122"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 04:04:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nx565-000SQf-2B;
        Fri, 03 Jun 2022 14:04:05 +0300
Date:   Fri, 3 Jun 2022 14:04:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, hdanton@sina.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [syzbot] general protection fault in __device_attach
Message-ID: <YpnqpMYcokTwCB6u@smile.fi.intel.com>
References: <000000000000bb7f1c05da29b601@google.com>
 <00000000000010b7d305e08837c8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000010b7d305e08837c8@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 03:02:07AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a9c4cf299f5f79d5016c8a9646fa1fc49381a8c1
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Fri Jun 18 13:41:27 2021 +0000
> 
>     ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros

Hmm... It's not obvious at all how this change can alter the behaviour so
drastically. device_add() is called from USB core with intf->dev.name == NULL
by some reason. A-ha, seems like fault injector, which looks like

	dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
		     dev->devpath, configuration, ifnum);

missed the return code check.

But I'm not familiar with that code at all, adding Linux USB ML and Alan.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1040b80df00000
> start commit:   d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1240b80df00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1440b80df00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
> dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15613e2bf00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c90adbf00000
> 
> Reported-by: syzbot+dd3c97de244683533381@syzkaller.appspotmail.com
> Fixes: a9c4cf299f5f ("ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
With Best Regards,
Andy Shevchenko


