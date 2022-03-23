Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00B34E5428
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbiCWOXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiCWOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:23:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1637520B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:21:34 -0700 (PDT)
X-UUID: 8b0a3f7a949c4fbb8b8c1b6fc03af3f7-20220323
X-UUID: 8b0a3f7a949c4fbb8b8c1b6fc03af3f7-20220323
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1529662981; Wed, 23 Mar 2022 22:21:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Mar 2022 22:21:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 22:21:29 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lkp@intel.com>,
        <lkp@lists.01.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <oliver.sang@intel.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] tracing: Avoid adding duplicated tracer options when update_tracer_options is running in parallel
Date:   Wed, 23 Mar 2022 22:21:29 +0800
Message-ID: <20220323142129.4175-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220323093021.4f541b40@gandalf.local.home>
References: <20220323093021.4f541b40@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 23 Mar 2022 11:24:42 +0800
> Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> 
> > When update_tracer_options is running in parallel,
> > tr->tops might be updated before the trace_types list traversal.
> > Let update_tracer_options traverse the trace_types list safely in
> > kernel init time and avoid the tr->tops update before it finish.
> 
> ??? Have you seen a bug here? I'm totally confused by this.

Sorry to make you confused.

After the below patch, update_tracer_options might be executed later than registering
hwlat_tracer, which is in late_initcall.

https://lore.kernel.org/lkml/20220316151639.9216-1-mark-pk.tsai@mediatek.com/

The init_hwlat_tracer initcall will put hwlat_tracer to tr->tops.
Then when the later arrived __update_tracer_options is trying to
update all the tracer options, create_trace_option_files show the
below warning because hwlat_tracer is already in the list.

[ 6.680068 ][ T7 ] WARNING: CPU: 0 PID: 7 at kernel/trace/trace.c:8899 create_trace_option_files (kernel/trace/trace.c:8899 (discriminator 1))

full log: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/


> 
> > 
> > Link: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  kernel/trace/trace.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index adb37e437a05..2974ae056068 100644
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
> 
> How is update_trace_options run in parallel?
> 
> There's a mutex that protects it. 
> 

Oh sorry.
What I trying to tell is that update_trace_options is run in parallel with
the initcall thread after:

https://lore.kernel.org/lkml/20220316151639.9216-1-mark-pk.tsai@mediatek.com/


> -- Steve
> 
> 
> >  	__update_tracer_options(tr);
> > +	tracer_options_updated = true;
> >  	mutex_unlock(&trace_types_lock);
> >  }
> >  
