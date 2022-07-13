Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2715E573C77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiGMSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiGMSYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:24:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E3183A9;
        Wed, 13 Jul 2022 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657736639; x=1689272639;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GFwjk0WDlWHLT5scE0PrSHapMgZnVgphn1v3cLSw9A=;
  b=cI/2c4443pjmTyyFEGXDlkXtjTN4oJI/qkUqbOFgvjJzMlX4kL4De6t5
   kGNhZD+mnTeXs+hTWFU4mkHOmI0hNG4tVe+51ChrRGaFZZMks7NSuNfMI
   BMFrZvzZxqCyUNIfFkSlbbT4JhlezgUpDxvAvfPbn66Z1ciyl9TABTCez
   E/PTYIaz6yuJ2TcjzUUEt5WdhY+U/LiOMdWK0yGm8oDnSSqUmoVExvXeR
   lcd7/YEG1I3r/NhLbIvak9K8Vyu1jZ5V6+Vrj1CvX6Zn6e/W7Lpnz/RI5
   +woQVMAhRGSlwm5NH3sq/tb70R7IMJtjTyiiX0H4cha7JhP2VGZ7rMUU/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="310955144"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="310955144"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 11:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="623074034"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2022 11:23:58 -0700
Message-ID: <7d79e9877d63cdb74144f38d8736959281b562cc.camel@linux.intel.com>
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
Date:   Wed, 13 Jul 2022 11:23:58 -0700
In-Reply-To: <c60f5634e8605cb4c2ef4646b6e511e6135bea48.camel@linux.intel.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
         <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
         <87czegxccb.fsf@jogness.linutronix.de>
         <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
         <87tu7qvx1q.fsf@jogness.linutronix.de>
         <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
         <87o7xwbuoy.fsf@jogness.linutronix.de> <Ysvbp8vz7R9hDNqx@alley>
         <Ysv3JNs4RwE7kAou@google.com> <87ilo1wdac.fsf@jogness.linutronix.de>
         <c60f5634e8605cb4c2ef4646b6e511e6135bea48.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

URGENT: Removing the commit FIXES the issue.

I just ran a 5.19.0-rc6 kernel with the offending commit removed and it
fixed the problem completely on all 3 machines. To be clear the
offending commit is:

commit 3b604ca81202eea2a917eb6491e90f610fba0ec7

I strongly recommend that this commit be pulled (or fixed very quickly)
before the 5.19 release or 1 in 10 linux machines running 5.19 will
take up to 2 seconds longer in suspend/resume.

commit 3b604ca81202eea2a917eb6491e90f610fba0ec7
Author: John Ogness <john.ogness@linutronix.de>
Date:   Thu Apr 21 23:28:46 2022 +0206

    printk: add pr_flush()

    Provide a might-sleep function to allow waiting for console
printers
    to catch up to the latest logged message.

    Use pr_flush() whenever it is desirable to get buffered messages
    printed before continuing: suspend_console(), resume_console(),
    console_stop(), console_start(), console_unblank().

    Signed-off-by: John Ogness <john.ogness@linutronix.de>
    Reviewed-by: Petr Mladek <pmladek@suse.com>
    Signed-off-by: Petr Mladek <pmladek@suse.com>
    Link: 
https://lore.kernel.org/r/20220421212250.565456-12-john.ogness@linutronix.de

 include/linux/printk.h |  7 +++++
 kernel/printk/printk.c | 83
++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)



On Wed, 2022-07-13 at 10:11 -0700, Todd Brandt wrote:
> I've updated the bugzilla entry with new data:
> https://bugzilla.kernel.org/show_bug.cgi?id=216216
> 
> I just added 3 new tests for 5.19.0-rc6 on 3 machines that see this
> issue: otcpl-asus-e200-cht (cherry trail), otcpl-aml-y (amber lake),
> and otcpl-whl-u (whiskey lake). The kernel has the
> CONFIG_PRINTK_CALLER
> option enabled.
> 
> The test is a S2idle and is run thusly:
> %> sleepgraph -dev -m freeze -rtcwake 15
> 
> I've included the dmesg boot logs for all three. The dmesg
> suspend/resume logs are included in the html timelines by clicking
> the
> "dmesg" button in the upper right hand corner of the timeline.
> There's
> a "log" button as well that shows other system into.
> 
> These files are attached to the bugzilla entry.
> otcpl-aml-y-5.19.0-rc6-boot-dmesg.txt
> otcpl-aml-y-5.19.0-rc6-freeze.html
> otcpl-asus-e200-cht-5.19.0-rc6-boot-dmesg.txt
> otcpl-asus-e200-cht-5.19.0-rc6-freeze.html
> otcpl-whl-u-5.19.0-rc6-boot-dmesg.txt
> otcpl-whl-u-5.19.0-rc6-freeze.html
> 
> If possible can we move this thread to the bugzilla comment section?
> 
> 
> On Wed, 2022-07-13 at 11:57 +0206, John Ogness wrote:
> > On 2022-07-11, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > > > It seems that __pr_flush() does not check whether all consoles
> > > > are
> > > > suspended. In this case the progress is not possible and it has
> > > > to
> > > > wait the entire timeout.
> > > 
> > > But isn't console_suspended set after pr_flush() call?
> > 
> > There should not be any printing after the suspend_console()
> > message.
> > If
> > Todd's report is coming from 5.19-rc1, then it is likely a kthread
> > issue, where the kthread is not respecting @console_suspended.
> > (This
> > would still need to be fixed for the kthreads, but would not be
> > relevant
> > for 5.19.)
> > 
> > John

