Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA55AEF5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiIFPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiIFPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:49:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD486C35
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662476476; x=1694012476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YpQEq6W0lBkBTsd3nLUmbMaxmwO7fK2kpzAtWEr5KxE=;
  b=kmG5d8QG0a06DSdTiEkIRVb3+ApOLRn7j63mE9DNNXSQnB8G+46N3rAj
   /Uk9cin0V0DlrZ48lEZlzS7thtLS/dTfYTXWWP+yf8IpcDO29piBtt3S+
   Ae4Z/1QVer1+09QOnUlah9fy7HJ7E1kYIAY3oEH/pPYc70NzzscW5wfk7
   auyh2vPQKv5pfTQsJF8Gm4FWd0sswevTFsgRed5F76QyKtfTz7ef9KkXF
   qYl3pLKWaiUx3iWe+BBjZcMbUdOHLYJW3S51tl1aXNeAqET8cx5p3/u8M
   Ga452Jh6myoVpCnX/jRzPMIUx8Y+vREUD785yyh7dX6kqsHp+Zfd3Zwwv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="382910609"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="382910609"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:01:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="703238455"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:01:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVa4T-009AOF-2a;
        Tue, 06 Sep 2022 18:01:01 +0300
Date:   Tue, 6 Sep 2022 18:01:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 1/5] smp: don't declare nr_cpu_ids if NR_CPUS == 1
Message-ID: <Yxdgrbvtv36C4zcJ@smile.fi.intel.com>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-2-yury.norov@gmail.com>
 <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
 <YxdT5w9Qd5SxK1wl@yury-laptop>
 <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:36:39PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 07:06:31AM -0700, Yury Norov wrote:
> > On Tue, Sep 06, 2022 at 10:53:53AM +0200, Peter Zijlstra wrote:
> > > On Mon, Sep 05, 2022 at 04:08:16PM -0700, Yury Norov wrote:

...

> > > Why do we need extra source complexity for this?
> > 
> > To have effective code generation for UP builds.
> 
> Again, who cares... isn't it hard to find actual UP chips these days?

For the record, Intel produced somewhat a volume of Intel Quark chips [1],
that are UP (in 2013-2019).

[1]: https://en.wikipedia.org/wiki/Intel_Quark

-- 
With Best Regards,
Andy Shevchenko


