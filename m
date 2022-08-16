Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F229595F11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiHPPb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHPPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:31:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E23DE5;
        Tue, 16 Aug 2022 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=piB87MH4BnL8/sCpyrwH73dQ4LrdevKm9iNdDHRtn8Y=; b=bw0i6sQhn+gqtiCOs5StixYStC
        CpXdFygGFVg81kotcMz0zpZfp1orva5SUyaaSpE/9SgPn/iMiE2RIqQDnb3218YiID1zFa1Asbcjd
        N99U2xyH3JkgeGDKK3jndKfTxtqQt6NFQcfZZldLdXYxSMTPp+6MdVLXi85kXUxV1xIQCAlIHPoa9
        Uf8XGn8ayjr3g7bE9+tMRVvRzbmJ0/NygNTGj6DPo+SodWqXVALg5vct8el1pMe345NMCBYcogyFA
        gYS2f0mH/lsidFU/IlkEwqi0o8JBiv0PaC/dBipLFFM/NZLTveRIySXHqPQewh0ruP3OYm8/mXH3j
        KyqlAjnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNyXR-00756X-AE; Tue, 16 Aug 2022 15:31:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E882980120; Tue, 16 Aug 2022 17:31:27 +0200 (CEST)
Date:   Tue, 16 Aug 2022 17:31:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix reentry problem in
 perf_output_read_group
Message-ID: <Yvu4TyFmeOd/rJ8t@worktop.programming.kicks-ass.net>
References: <20220816091103.257702-1-yangjihong1@huawei.com>
 <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
 <Yvuvm7Onw3pmB9Z6@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvuvm7Onw3pmB9Z6@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:54:19PM +0100, Mark Rutland wrote:
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index ee8b9ecdc03b..d4d53b9ba71e 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -631,7 +631,12 @@ struct pmu_event_list {
> >  	struct list_head	list;
> >  };
> >  
> > +/*
> > + * Iterating the sibling list requires this list to be stable; by ensuring IRQs
> > + * are disabled IPIs from perf_{install_in,remove_from}_context() are held off.
> > + */
> >  #define for_each_sibling_event(sibling, event)			\
> > +	lockdep_assert_irqs_disabled();				\
> >  	if ((event)->group_leader == (event))			\
> >  		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
> >  
> 
> I had a go with v6.0-rc1 and Vince's perf fuzzer immediately triggered a bunch
> of cases (dump below).
> 
> I had thought holding the context mutex protected some of these cases, even
> with IRQs unmasked?

Ah yes.. duh. How's this then?


diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..4d9cf508c510 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -631,7 +631,21 @@ struct pmu_event_list {
 	struct list_head	list;
 };
 
+#ifdef CONFIG_LOCKDEP
+#define LOCKDEP_ASSERT_EVENT_CTX(event)				\
+	WARN_ON_ONCE(__lockdep_enabled &&			\
+		     (this_cpu_read(hardirqs_enabled) ||	\
+		      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))
+#else
+#define LOCKDEP_ASSERT_EVENT_CTX(event)
+#endif
+
+/*
+ * Iterating the sibling list requires this list to be stable; by ensuring IRQs
+ * are disabled IPIs from perf_{install_in,remove_from}_context() are held off.
+ */
 #define for_each_sibling_event(sibling, event)			\
+	LOCKDEP_ASSERT_EVENT_CTX(event);			\
 	if ((event)->group_leader == (event))			\
 		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
 
