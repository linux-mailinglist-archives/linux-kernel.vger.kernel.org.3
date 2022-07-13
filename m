Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0632573BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiGMRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGMRLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:11:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614C2CE02;
        Wed, 13 Jul 2022 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657732283; x=1689268283;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7okOHRohkmqY1odlj6bLAXPI/CRp5yIJ+HMblNpFZsw=;
  b=nmBCq803A32+ZNpzoqz8DLNRR++Y2G+LNLehVY/9xTHVNVOTYi3CX96q
   bkwXDfPXOQmixTxEiDXZdDBKhdmJXXo7Dnyt9QbRNJWCGj2XtHSJTZgNy
   rXT6xB4n3JOWlu1JurdeRg6VvYaATEd+r33+HJK0kl35KB2cQaTqIVy05
   kA1OUToRESJlvyyiLdlRIdmCyi8ojlxppLy3DeFmxXdVoycWi8u2c2TQZ
   H6M0HowVwBUeo1PKdG1EI0taeJjL1nZhqKHLvDkTswcqbyo7KovoZ6xF6
   RCEEnUJbONuKkjmIwawRXtjW+cri0tLvcqH8JAhl/xVF1Tolh5oxXa22F
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="346969871"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="346969871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="628391499"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2022 10:11:22 -0700
Message-ID: <c60f5634e8605cb4c2ef4646b6e511e6135bea48.camel@linux.intel.com>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, rafael.j.wysocki@intel.com,
        len.brown@intel.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 13 Jul 2022 10:11:22 -0700
In-Reply-To: <87ilo1wdac.fsf@jogness.linutronix.de>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
         <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
         <87czegxccb.fsf@jogness.linutronix.de>
         <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
         <87tu7qvx1q.fsf@jogness.linutronix.de>
         <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
         <87o7xwbuoy.fsf@jogness.linutronix.de> <Ysvbp8vz7R9hDNqx@alley>
         <Ysv3JNs4RwE7kAou@google.com> <87ilo1wdac.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the bugzilla entry with new data:
https://bugzilla.kernel.org/show_bug.cgi?id=216216

I just added 3 new tests for 5.19.0-rc6 on 3 machines that see this
issue: otcpl-asus-e200-cht (cherry trail), otcpl-aml-y (amber lake),
and otcpl-whl-u (whiskey lake). The kernel has the CONFIG_PRINTK_CALLER
option enabled.

The test is a S2idle and is run thusly:
%> sleepgraph -dev -m freeze -rtcwake 15

I've included the dmesg boot logs for all three. The dmesg
suspend/resume logs are included in the html timelines by clicking the
"dmesg" button in the upper right hand corner of the timeline. There's
a "log" button as well that shows other system into.

These files are attached to the bugzilla entry.
otcpl-aml-y-5.19.0-rc6-boot-dmesg.txt
otcpl-aml-y-5.19.0-rc6-freeze.html
otcpl-asus-e200-cht-5.19.0-rc6-boot-dmesg.txt
otcpl-asus-e200-cht-5.19.0-rc6-freeze.html
otcpl-whl-u-5.19.0-rc6-boot-dmesg.txt
otcpl-whl-u-5.19.0-rc6-freeze.html

If possible can we move this thread to the bugzilla comment section?


On Wed, 2022-07-13 at 11:57 +0206, John Ogness wrote:
> On 2022-07-11, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > > It seems that __pr_flush() does not check whether all consoles
> > > are
> > > suspended. In this case the progress is not possible and it has
> > > to
> > > wait the entire timeout.
> > 
> > But isn't console_suspended set after pr_flush() call?
> 
> There should not be any printing after the suspend_console() message.
> If
> Todd's report is coming from 5.19-rc1, then it is likely a kthread
> issue, where the kthread is not respecting @console_suspended. (This
> would still need to be fixed for the kthreads, but would not be
> relevant
> for 5.19.)
> 
> John

