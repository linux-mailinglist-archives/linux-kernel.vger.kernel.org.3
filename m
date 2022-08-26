Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD425A32B2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbiHZXgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZXgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:36:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4839568E;
        Fri, 26 Aug 2022 16:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661557005; x=1693093005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u20zxDzkp31lrS39BKPMIAjH1TtKgLIefJ0jzT7lrls=;
  b=Ct8fBxjQEQxfCYbeyWnIyv5GHNUqYWHvG2/7roPFiGK2Og3qBCS1FnRo
   WYwPFVzIYRVWfzIoeKusbUaiEFukVyEyoFwcug3gd6JO3EdRFy7nT8S3V
   J4ZWOu2KjIc0ZY0+eYUYFuh4eHC/P+ZDG3n3BOSzDRcT94L8jMFo4NuGV
   fx+hlQEc6trNEXqU+UIaJQy4ambG09vG8ixA7GC/DzJMJxxqUWtpSK474
   XkUqvn+ogCSJPwLb/6cYO61ZdVaGCIZ+1Mdbl6biHspkvt9TkGbWUyFz6
   TD+AvS0k7zs84NNKhKvbI2zeByKey0062j6TBaGUyZKBaHoqjEJl0ccDg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="356330045"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="356330045"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 16:36:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="640243606"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.82.226])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 16:36:44 -0700
Date:   Fri, 26 Aug 2022 16:36:42 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tracepoint: Allow trace events in modules with TAINT_TEST
Message-ID: <YwlZCrhbrSUbbvMQ@aschofie-mobl2>
References: <20220826223511.170256-1-alison.schofield@intel.com>
 <f543e2a4-1994-bd53-b60d-206c1e3c0726@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f543e2a4-1994-bd53-b60d-206c1e3c0726@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 03:48:42PM -0700, Dave Jiang wrote:
> 
> On 8/26/2022 3:35 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> > introduced a new taint type, TAINT_TEST, to signal that an
> > in-kernel test has been run.
> 
> has been loaded?
> 

I took that explanation directly from the mentioned commit, where
it seems that 'run' was the intended word when referring to KUnit 
tests. Reviewer feedback led the submitter to make the taint per
module to handle 'longer lasting' modules.

> > 
> > TAINT_TEST taint type defaults into a 'bad_taint' list for
> > kernel tracing and blocks the creation of trace events. This
> > causes a problem for CXL testing where loading the cxl_test
> > module makes all CXL modules out-of-tree, blocking any trace
> > events.
> > 
> > Trace events are in development for CXL at the moment and this
> > issue was found in test with v6.0-rc1.
> > 
> > Reported-by: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   kernel/tracepoint.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 64ea283f2f86..5f17378c9dc2 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
> >   bool trace_module_has_bad_taint(struct module *mod)
> >   {
> >   	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
> > -			       (1 << TAINT_UNSIGNED_MODULE));
> > +			       (1 << TAINT_UNSIGNED_MODULE) |
> > +			       (1 << TAINT_TEST));
> >   }
> >   static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
> > 
> > base-commit: 4c612826bec1441214816827979b62f84a097e91
