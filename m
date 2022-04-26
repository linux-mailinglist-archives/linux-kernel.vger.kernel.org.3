Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8850F386
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbiDZIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbiDZIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:20:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6A34D9DC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:17:14 -0700 (PDT)
X-UUID: ea449387750345078522c858417b48e9-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:40a5b8ef-fb72-49dc-a62d-9043f4f2051c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:50,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.4,REQID:40a5b8ef-fb72-49dc-a62d-9043f4f2051c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:50,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:faefae9,CLOUDID:9a6483c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:-5,EDM:-3,File:n
        il,QS:0,BEC:nil
X-UUID: ea449387750345078522c858417b48e9-20220426
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 810141183; Tue, 26 Apr 2022 16:17:09 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Apr 2022 16:17:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Apr
 2022 16:17:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 16:17:06 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 1/2] tracing: Avoid adding tracer option before update_tracer_options
Date:   Tue, 26 Apr 2022 16:17:06 +0800
Message-ID: <20220426081706.13274-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422174258.1f41777a@gandalf.local.home>
References: <20220422174258.1f41777a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > To prepare for support asynchronous tracer_init_tracefs initcall,
> > avoid calling create_trace_option_files before __update_tracer_options.
> > Otherwise, create_trace_option_files will show warning because
> > some tracers in trace_types list are already in tr->topts.
> > 
> > For example, hwlat_tracer call register_tracer in late_initcall,
> > and global_trace.dir is already created in tracing_init_dentry,
> > hwlat_tracer will be put into tr->topts.
> > Then if the __update_tracer_options is executed after hwlat_tracer
> > registered, create_trace_option_files find that hwlat_tracer is
> > already in tr->topts.
> > 
> > Link: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> 
> Before this patch:
> 
>  # ls /sys/kernel/tracing/options
> annotate	   funcgraph-duration  hex		stacktrace
> bin		   funcgraph-irqs      irq-info		sym-addr
> blk_cgname	   funcgraph-overhead  latency-format	sym-offset
> blk_cgroup	   funcgraph-overrun   markers		sym-userobj
> blk_classic	   funcgraph-proc      overwrite	test_nop_accept
> block		   funcgraph-tail      pause-on-trace	test_nop_refuse
> context-info	   func-no-repeats     printk-msg-only	trace_printk
> disable_on_free    func_stack_trace    print-parent	userstacktrace
> display-graph	   function-fork       raw		verbose
> event-fork	   function-trace      record-cmd
> funcgraph-abstime  graph-time	       record-tgid
> funcgraph-cpu	   hash-ptr	       sleep-time
> 
> 
> After this patch:
> 
>  # ls /sys/kernel/tracing/options
> annotate      disable_on_free  irq-info         raw          trace_printk
> bin           display-graph    latency-format   record-cmd   userstacktrace
> blk_cgname    event-fork       markers          record-tgid  verbose
> blk_cgroup    function-fork    overwrite        stacktrace
> blk_classic   function-trace   pause-on-trace   sym-addr
> block         hash-ptr         printk-msg-only  sym-offset
> context-info  hex              print-parent     sym-userobj
> 
> Not good.

Calling __update_tracer_options() when tracer_options_updated=false have no
effect because it return directly in add_tracer_options().
I will fix it in v4 as you suggest in the below comment.

> 
> > ---
> >  kernel/trace/trace.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index eb44418574f9..85ec758c4455 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6317,12 +6317,18 @@ static void tracing_set_nop(struct trace_array *tr)
> >  	tr->current_trace = &nop_trace;
> >  }
> >  
> > +static bool tracer_options_updated;
> > +
> >  static void add_tracer_options(struct trace_array *tr, struct tracer *t)
> >  {
> >  	/* Only enable if the directory has been created already. */
> >  	if (!tr->dir)
> >  		return;
> >  
> > +	/* Only create trace option files after update_tracer_options finish */
> > +	if (!tracer_options_updated)
> > +		return;
> > +
> >  	create_trace_option_files(tr, t);
> >  }
> >  
> > @@ -9133,6 +9139,7 @@ static void update_tracer_options(struct trace_array *tr)
> >  {
> >  	mutex_lock(&trace_types_lock);
> >  	__update_tracer_options(tr);
> > +	tracer_options_updated = true;
> 
> I think you want to set this before the __update, as doing it after just
> makes the update a nop.

You are right.
I will update in v4, thanks!

> 
> -- Steve
> 
> 
> >  	mutex_unlock(&trace_types_lock);
> >  }
> >  

