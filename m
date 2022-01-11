Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4950F48AEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbiAKNmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:45185 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240649AbiAKNmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641908537; x=1673444537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yDCHUQBUGZPvgMw0jxUpeD6RdPHQaA2QSgQjo47V2vU=;
  b=c04L5DBQduF31Glpg4m3kwHaDh8CLc7zpNr/O+UVnV/itHGPNN2Dm3Uf
   2XVTFKhaMtTRRBmCjfMutS5EbV3iXkxYPCaHsDqmhoQaI0oRHu9qNTYuX
   jszndxanQ0uHa4De1EpAlR5R337OduqPtvA9dGpTfDsbemL4cEnlmSvPi
   aFwgE32TkJ+eptY3aeVFfuInyVVCvF1rWDxBBZBphn4GepErlx7WPPfT+
   bN8NKMroGl8LM6O/PVkLhx8ej5ztjGoFUa9oupodPBMGXCG9nhX/cW3qd
   T5dFMVaM3E6e72HNLScwsWJomQlGx0f4Da9szl2M53wYsgzEJ579NiOE0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242296416"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="242296416"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 05:42:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="619828353"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 05:41:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1n7HOF-009FDJ-Fw;
        Tue, 11 Jan 2022 15:40:43 +0200
Date:   Tue, 11 Jan 2022 15:40:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Add new pr_*_deferred_once() variants
Message-ID: <Yd2I28a+BuuIdBcv@smile.fi.intel.com>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <20210123233741.3614408-2-qais.yousef@arm.com>
 <YA6fTuFEaCjFQB3h@hirez.programming.kicks-ass.net>
 <87y2gh2shy.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2gh2shy.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:04:01PM +0106, John Ogness wrote:
> On 2021-01-25, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sat, Jan 23, 2021 at 11:37:40PM +0000, Qais Yousef wrote:

...

> > We should be very close to printk not needing this anymore, printk
> > people?
> 
> It will disappear once console printing threads are introduced. We
> probably still have a few kernel releases until we see that. First we
> need to finish merging full lockless access, remove the safe buffers,
> and merge the atomic consoles.

Where are we now at this?

I almost easily can reproduce the below at boot time for last several releases

 cblist_init_generic: Setting adjustable number of callback queues.

 =============================
 [ BUG: Invalid wait context ]
 5.16.0-next-20220111-00101-gb3e9f395c6f1 #28 Not tainted
 -----------------------------
 swapper/0/1 is trying to lock:
 ffffffffb3dce758 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x3a8/0x480
 other info that might help us debug this:
 context-{5:5}
 3 locks held by swapper/0/1:
  #0: ffffffffb2955e08 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic.constprop.0+0x14/0x1e0
  #1: ffffffffb2953ec0 (console_lock){+.+.}-{0:0}, at: _printk+0x53/0x6a
  #2: ffffffffb2873ca0 (console_owner){....}-{0:0}, at: console_unlock+0x157/0x580
 stack backtrace:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-next-20220111-00101-gb3e9f395c6f1 #28
 Hardware name: Intel Corporation CHERRYVIEW D0 PLATFORM/Braswell CRB, BIOS BRAS.X64.B082.R00.1507270557 07/27/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x7d
  __lock_acquire.cold+0xca/0x2e8
  ? stack_trace_save+0x46/0x70
  lock_acquire+0xd2/0x300
  ? serial8250_console_write+0x3a8/0x480
  _raw_spin_lock_irqsave+0x39/0x50
  ? serial8250_console_write+0x3a8/0x480
  serial8250_console_write+0x3a8/0x480
  console_unlock+0x397/0x580
  vprintk_emit+0x99/0x2e0
  _printk+0x53/0x6a
  cblist_init_generic.constprop.0.cold+0x24/0x31
  rcu_init_tasks_generic+0x5/0xd9
  kernel_init_freeable+0x14d/0x294
  ? rest_init+0x250/0x250
  kernel_init+0x11/0x110
  ret_from_fork+0x22/0x30
  </TASK>
 cblist_init_generic: Setting shift to 2 and lim to 1.

-- 
With Best Regards,
Andy Shevchenko


