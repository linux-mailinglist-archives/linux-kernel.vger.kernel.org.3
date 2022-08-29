Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E335A5269
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiH2Q7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiH2Q7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:59:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D269C210;
        Mon, 29 Aug 2022 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661792343; x=1693328343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYz8gmC188I7X0Y1EWCMJGKwgvo0NnQBvcuTDxv+92E=;
  b=ObswXpX5teA5cHkCctMsXc3m9L2H5nk85ewFMWfqiVq04Xl0NS1QZxEP
   R6nDa1uP+tb66FAr39xYZ4bEGNok9Bx6E8ThFgFXdAC2iJfjQMESVyU3f
   7yeGvoOlhen88XAz7rXkBKbvgIQAQ9Wq8ZM7uYjRSdB0tWVy8sWFtkMRH
   KLp24DtC3ITpv8/g4uz+s9AYaNGAbW1Sk5vbPzAXGvvklpY/uZ1f3YNJA
   CYs3NnNo58F+o8o+Rp2gPOM/2stlqIxkesEmeaUbosQzCbrm/kaJcfMK0
   mhbqjVDsCNXTO73jvowNiALIzI71SUT36oBffR9LlJGcmDvQPIfq3s07s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293682382"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="293682382"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 09:39:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="714935922"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.3.205])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 09:39:10 -0700
Date:   Mon, 29 Aug 2022 09:39:08 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tracepoint: Allow trace events in modules with TAINT_TEST
Message-ID: <YwzrrMqUbCu+ZBkr@aschofie-mobl2>
References: <20220826223511.170256-1-alison.schofield@intel.com>
 <Ywle+96kZr5Y6Kn/@aschofie-mobl2>
 <CABVgOSkdXPw3yx=J+=YLxgu=0kpBGD5MvPJr0=_VO4jgrSBpPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkdXPw3yx=J+=YLxgu=0kpBGD5MvPJr0=_VO4jgrSBpPw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 09:09:54AM +0800, David Gow wrote:
> On Sat, Aug 27, 2022 at 8:02 AM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >
> > + David Gow - Submitter of the new taint type
> >
> > On Fri, Aug 26, 2022 at 03:35:11PM -0700, alison.schofield@intel.com wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> > > introduced a new taint type, TAINT_TEST, to signal that an
> > > in-kernel test has been run.
> > >
> > > TAINT_TEST taint type defaults into a 'bad_taint' list for
> > > kernel tracing and blocks the creation of trace events. This
> > > causes a problem for CXL testing where loading the cxl_test
> > > module makes all CXL modules out-of-tree, blocking any trace
> > > events.
> > >
> > > Trace events are in development for CXL at the moment and this
> > > issue was found in test with v6.0-rc1.
> > >
> > > Reported-by: Ira Weiny <ira.weiny@intel.com>
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> 
> This seems fine to me: thanks for catching it. Test modules should be
> safe enough to load for this.
> 
> Does the comment in tracepoint_module_coming() need updating as well?
> https://elixir.bootlin.com/linux/v6.0-rc2/source/kernel/tracepoint.c#L650

Yes, ready in a v2:
-	 * Staging, out-of-tree, and unsigned GPL modules are fine.
+	 * Staging, out-of-tree, unsigned GPL, and test modules are fine.

Thanks!
Alison

> 
> Regardless, this is
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> > >  kernel/tracepoint.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > > index 64ea283f2f86..5f17378c9dc2 100644
> > > --- a/kernel/tracepoint.c
> > > +++ b/kernel/tracepoint.c
> > > @@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
> > >  bool trace_module_has_bad_taint(struct module *mod)
> > >  {
> > >       return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
> > > -                            (1 << TAINT_UNSIGNED_MODULE));
> > > +                            (1 << TAINT_UNSIGNED_MODULE) |
> > > +                            (1 << TAINT_TEST));
> > >  }
> > >
> > >  static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
> > >
> > > base-commit: 4c612826bec1441214816827979b62f84a097e91
> > > --
> > > 2.31.1
> > >
