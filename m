Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24F35738BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiGMOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiGMOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:24:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ADB3342F;
        Wed, 13 Jul 2022 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657722284; x=1689258284;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qcu2fDzbjH+8Pob7GAhka1a5X+B4rezoCFYuJ3gdx9w=;
  b=SZaS28hDr+JcVFtTVgjatL0muvDmpIc9VgNTKk/H+vko53aQQ3DFQSyK
   U3ruq7WJnzO3guHJ4yKX/i76/OQwOGtymeq0ybHwVhHCXmq391bPJMRBt
   ESm4yiq2uBY/e0awxlUp77pI90U3qclYdji+RxgvdEaeBHzu8h6hjSeA2
   6QPlvv5G16SMmPSxYbkrd94BkpMoeDFu5lXg6s1JfyPF1jhLnwtuSe2pK
   q0z8bX9UoV9M+ZYFaIZHIYR4p2NpV1kv/IpxVRXCh5lMyuGhdsTPIgTeV
   M5jka+I+bNK3Xh9zqwByyAgYQvtTj/uiPL74DvTrIOGF4fq/x2D78qNqK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371537551"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="371537551"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="663375775"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2022 07:24:43 -0700
Message-ID: <838bd68dbdc14e556d0b69d910b9fd6dd5898f29.camel@linux.intel.com>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 13 Jul 2022 07:24:43 -0700
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

It appears to still be there in rc5 (our lab system is usually 6 days
behind, so rc6 hasn't been run yet). I'm building a new rc6 kernel with
CONFIG_PRINTK_CALLER today and will run it on all affected machines,
I'll send out the data this afternoon Oregon Time. I'll include
timelines for all affected machines to give you a better sampling.

