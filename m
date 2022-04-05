Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED64F4C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575871AbiDEXJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454522AbiDEP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:58:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E638D8B;
        Tue,  5 Apr 2022 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649171072; x=1680707072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuJEj7FBhgDkCn5WeO0N79dzrUVDGVen+PgutrVZgfs=;
  b=T61m0Sc35fW/mdLnUJsw5clVpEA1Cq7PtwqvxU5b3fy/SU7zp7eV2Hw2
   VXcrnxtq8N3vefpnLOJTT5KhMjbo19qik5MmQV+vkEKCuj9bZ2H7g2gPJ
   EB+3yh8CJ3Md4QDj1q8CblmquNEWy7GT4FG6Xf+yYZAxGT07W0up/AuYs
   ZKdb1B+hAl/f5fccFSKH+Ua3qr55TwuRfCkqnuusBSyiXzxefo9fT9Hpq
   JrhxusgEAohGJRJ6LNJ/nCtY+4lzXbnVvT7hFfYRb/h16jGECtMe5bi4T
   8ikQQBfJboZ+lgEcI2Mzh9k7qaLwZA44idbi5QjEcVwxEkjMhaBzQvsAS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="242912032"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="242912032"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:04:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="620387693"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:04:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbkid-00DQTI-OJ;
        Tue, 05 Apr 2022 18:03:43 +0300
Date:   Tue, 5 Apr 2022 18:03:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Helge Deller <deller@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v2 00/12] implement threaded console printing
Message-ID: <YkxaTy08ClcNj0P3@smile.fi.intel.com>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-1-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 03:31:23PM +0206, John Ogness wrote:
> This is v2 of a series to implement a kthread for each registered
> console. v1 is here [0]. The kthreads locklessly retrieve the
> records from the printk ringbuffer and also do not cause any lock
> contention between each other. This allows consoles to run at full
> speed. For example, a netconsole is able to dump records much
> faster than a serial or vt console. Also, during normal operation,
> it completely decouples printk() callers from console printing.
> 
> There are situations where kthread printing is not sufficient. For
> example, during panic situations, where the kthreads may not get a
> chance to schedule. In such cases, the current method of attempting
> to print directly within the printk() caller context is used. New
> functions printk_prefer_direct_enter() and
> printk_prefer_direct_exit() are made available to mark areas of the
> kernel where direct printing is preferred. (These should only be
> areas that do not occur during normal operation.)
> 
> This series also introduces pr_flush(): a might_sleep() function
> that will block until all active printing threads have caught up
> to the latest record at the time of the pr_flush() call. This
> function is useful, for example, to wait until pending records
> are flushed to consoles before suspending.
> 
> Note that this series does *not* increase the reliability of console
> printing. Rather it focuses on the non-interference aspect of
> printk() by decoupling printk() callers from printing (during normal
> operation). Nonetheless, the reliability aspect should not worsen
> due to this series.

From the list of patches and the only one I am Cc'ed to I can't find the
answer to my question, i.e. does it take care about console_unregister()
cases at run time? (We have some drivers to call ->exit() for console in
that case, perhaps it should do something before calling it.)

Would be nice to see some pointers where I can find the answer and
maybe even describing in the cover-letter/commit message/documentation.

-- 
With Best Regards,
Andy Shevchenko


