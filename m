Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF94E543F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiCWOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiCWOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:30:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F865B6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE829B81E7C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87324C340E8;
        Wed, 23 Mar 2022 14:28:32 +0000 (UTC)
Date:   Wed, 23 Mar 2022 10:28:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lkp@intel.com>,
        <lkp@lists.01.org>, <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <oliver.sang@intel.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] tracing: Avoid adding duplicated tracer options when
 update_tracer_options is running in parallel
Message-ID: <20220323102831.1cf884d6@gandalf.local.home>
In-Reply-To: <20220323142129.4175-1-mark-pk.tsai@mediatek.com>
References: <20220323093021.4f541b40@gandalf.local.home>
        <20220323142129.4175-1-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 22:21:29 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> > On Wed, 23 Mar 2022 11:24:42 +0800
> > Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> >   
> > > When update_tracer_options is running in parallel,
> > > tr->tops might be updated before the trace_types list traversal.
> > > Let update_tracer_options traverse the trace_types list safely in
> > > kernel init time and avoid the tr->tops update before it finish.  
> > 
> > ??? Have you seen a bug here? I'm totally confused by this.  
> 
> Sorry to make you confused.
> 
> After the below patch, update_tracer_options might be executed later than registering
> hwlat_tracer, which is in late_initcall.
> 
> https://lore.kernel.org/lkml/20220316151639.9216-1-mark-pk.tsai@mediatek.com/

If you send patches that depend on patches that are not in the tree, you
need to explicitly state that.


> 
> The init_hwlat_tracer initcall will put hwlat_tracer to tr->tops.
> Then when the later arrived __update_tracer_options is trying to
> update all the tracer options, create_trace_option_files show the
> below warning because hwlat_tracer is already in the list.
> 
> [ 6.680068 ][ T7 ] WARNING: CPU: 0 PID: 7 at kernel/trace/trace.c:8899 create_trace_option_files (kernel/trace/trace.c:8899 (discriminator 1))
> 
> full log: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/

So this is all dependent on patches not in the tree?

> 
> 
> >   
> > > 
> > > Link: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > ---
> > >  kernel/trace/trace.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index adb37e437a05..2974ae056068 100644
> > > --- a/kernel/trace/trace.c
> > > +++ b/kernel/trace/trace.c
> > > @@ -6317,12 +6317,18 @@ static void tracing_set_nop(struct trace_array *tr)
> > >  	tr->current_trace = &nop_trace;
> > >  }
> > >  
> > > +static bool tracer_options_updated;
> > > +
> > >  static void add_tracer_options(struct trace_array *tr, struct tracer *t)
> > >  {
> > >  	/* Only enable if the directory has been created already. */
> > >  	if (!tr->dir)
> > >  		return;
> > >  
> > > +	/* Only create trace option files after update_tracer_options finish */
> > > +	if (!tracer_options_updated)
> > > +		return;
> > > +
> > >  	create_trace_option_files(tr, t);
> > >  }
> > >  
> > > @@ -9133,6 +9139,7 @@ static void update_tracer_options(struct trace_array *tr)
> > >  {
> > >  	mutex_lock(&trace_types_lock);  
> > 
> > How is update_trace_options run in parallel?
> > 
> > There's a mutex that protects it. 
> >   
> 
> Oh sorry.
> What I trying to tell is that update_trace_options is run in parallel with
> the initcall thread after:
> 
> https://lore.kernel.org/lkml/20220316151639.9216-1-mark-pk.tsai@mediatek.com/
> 

Again, this is not in the tree, so it should be part of that patch series,
which I haven't yet been able to fully review.

-- Steve
