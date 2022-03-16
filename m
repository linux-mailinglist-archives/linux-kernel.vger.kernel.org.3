Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893C14DB57E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357352AbiCPP7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbiCPP7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:59:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFD1BE8E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:58:23 -0700 (PDT)
X-UUID: dc6c407514a841a982a93a5dd0c11e44-20220316
X-UUID: dc6c407514a841a982a93a5dd0c11e44-20220316
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 496109302; Wed, 16 Mar 2022 23:58:18 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Mar 2022 23:58:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Mar
 2022 23:58:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 23:58:16 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mark-pk.tsai@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mingo@redhat.com>, <rostedt@goodmis.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] tracing: make tracer_init_tracefs initcall asynchronous
Date:   Wed, 16 Mar 2022 23:58:16 +0800
Message-ID: <20220316155816.1094-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220314114749.28646-1-mark-pk.tsai@mediatek.com>
References: <20220314114749.28646-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Fri, 11 Mar 2022 19:26:56 +0800
> > Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> > 
> > > tracer_init_tracefs() is slow especially when there are
> > > lots of trace events.
> > > Create a kthread to do tracer_init_tracefs() asynchronously
> > 
> > When making comments like this, please provide the benchmarks you used,
> > with the numbers before and after.
> 
> I've retest it with kernel 5.17-rc7 on my arm64 board, and I found that
> the critical path is trace_eval_sync which spend about 430 ms.
> It's almost half of the time the do_initcalls spends.
> Below is the test result.
> 
> 			before		after
> tracer_init_tracefs	29872 us	66 us
> trace_eval_sync		429695 us	459370 us
> do_initcalls		797818 us	799890 us
> 
> I locally skip trace_eval_sync and got below result.
> 
> 			before		after		diff
> do_initcalls		359252 us	341725 us	-17527 us
> 
> So beside this patch, could we add a kernel parameter or a
> option to skip it when it doesn't used right after kernel boot?
> 

Please ignore this.
I do more tests and found that ftrace_eval_maps is in INIT_DATA.
So the eval_wq may crash if it doesn't finish before init mem
is freed.
And ftrace_eval_maps is big when there are lots of trace event
(About 6KB with arch/arm64/defconfig).
So it seems not a good idea to remove all the needed funcs from init.

So please review v2 [1] I've just push which queue the tracer_init_tracefs()
to eval_map_wq.

[1]: https://lore.kernel.org/lkml/20220316151639.9216-1-mark-pk.tsai@mediatek.com/

> > 
> > > to speed up the initialization of kernel and move the
> > > related functions and variables out of init section.
> > 
> > Thus we sacrifice memory for boot time. I'd like to also see how much
> > memory is freed from init before and after this patch.
> > 
> 
> Below is the INIT_TEXT and INIT_DATA diff:
> 
> 		before	after	diff
> INIT_TEXT	7F290	7EDAC	-0x4e4	bytes
> INIT_DATA	116FE8	116FE8	0	bytes
> 
> And the init section is 64K aligned on arm64 so that when I test
> on my platform, the actual memory freed by initmem_free() have no
> diffrence after apply this patch.
> 
> #define SEGMENT_ALIGN SZ_64K
> 
> > >  
> > >  static int trace_panic_handler(struct notifier_block *this,
> > > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > > index 3147614c1812..fe055bef1e8f 100644
> > > --- a/kernel/trace/trace_events.c
> > > +++ b/kernel/trace/trace_events.c
> > > @@ -3687,7 +3687,7 @@ static __init int event_trace_init_fields(void)
> > >  	return 0;
> > >  }
> > >  
> > > -__init int event_trace_init(void)
> > > +int event_trace_init(void)
> > >  {
> > >  	struct trace_array *tr;
> > >  	struct dentry *entry;
> > 
> > Hmm, this calls early_event_tracer() which is also in __init. Looks like
> > there's going to be a ripple effect due to this change.
> > 
> > If we want to go this route, then first a change must be made to remove the
> > needed functions from init, and then see if we can consolidate it. As there
> > are some init functions that are duplicated for init purposes.
> 
> Got it!
> 


