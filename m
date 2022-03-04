Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885824CD837
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbiCDPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbiCDPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:46:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A148A1C60C1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IZnP7MtHXyvumKF4Vst75s+zUdBfvr5Nb+RSDn2GK+s=; b=kQ9PmszfnioO+zM1EUiYvStZ+8
        boaetq544DMH6Qm0XkoioZZzng2BtzzA1dWIPTPnUThjYmGt1yMOOW1kNMSdHbV8ma4YiWPiSynEF
        kAzCgfF6RFKLYCSs2z7wmL+MkJ3c3sGE9EnBxdOx8f+WImkTcV58vMxFFETLKIXbgjbNSH+lVE+V6
        kvZMsul2eBmHBqVM9hhpIc5VE87kgBvpq1yQCJKp/cD4Uzfwad3t6MgHcbD0RJAay73aLqZ8RBCBS
        ytF9RKrOIr5SAucMIbbf+1c2i5B000mm7w2C/LgIHitXA3QXRZLNPNCOzgGN6DfsusbcoMGXTOrqj
        X1vL050Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQA7K-00CkoQ-2y; Fri, 04 Mar 2022 15:45:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A502300230;
        Fri,  4 Mar 2022 16:45:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9A7F2C55A101; Fri,  4 Mar 2022 16:45:16 +0100 (CET)
Date:   Fri, 4 Mar 2022 16:45:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Subject: Re: [PATCH v6 06/12] perf/x86/amd: add AMD branch sampling period
 adjustment
Message-ID: <YiI0DKEzc41bF15C@hirez.programming.kicks-ass.net>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-7-eranian@google.com>
 <YgPedIWUiPIzF8OW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPedIWUiPIzF8OW@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:32:04PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 08, 2022 at 01:16:31PM -0800, Stephane Eranian wrote:
> > Add code to adjust the sampling event period when used with the Branch
> > Sampling feature (BRS). Given the depth of the BRS (16), the period is
> > reduced by that depth such that in the best case scenario, BRS saturates at
> > the desired sampling period. In practice, though, the processor may execute
> > more branches. Given a desired period P and a depth D, the kernel programs
> > the actual period at P - D. After P occurrences of the sampling event, the
> > counter overflows. It then may take X branches (skid) before the NMI is
> > caught and held by the hardware and BRS activates. Then, after D branches,
> > BRS saturates and the NMI is delivered.  With no skid, the effective period
> > would be (P - D) + D = P. In practice, however, it will likely be (P - D) +
> > X + D. There is no way to eliminate X or predict X.
> > 
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/x86/events/core.c       |  7 +++++++
> >  arch/x86/events/perf_event.h | 12 ++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index c2a890caeb0a..ed285f640efe 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1374,6 +1374,13 @@ int x86_perf_event_set_period(struct perf_event *event)
> >  	    x86_pmu.set_topdown_event_period)
> >  		return x86_pmu.set_topdown_event_period(event);
> >  
> > +	/*
> > +	 * decrease period by the depth of the BRS feature to get
> > +	 * the last N taken branches and approximate the desired period
> > +	 */
> > +	if (has_branch_stack(event))
> > +		period = amd_brs_adjust_period(period);
> > +
> >  	/*
> >  	 * If we are way outside a reasonable range then just skip forward:
> >  	 */
> > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> > index 3485a4cf0241..25b037b571e4 100644
> > --- a/arch/x86/events/perf_event.h
> > +++ b/arch/x86/events/perf_event.h
> > @@ -1263,6 +1263,14 @@ static inline bool amd_brs_active(void)
> >  	return cpuc->brs_active;
> >  }
> >  
> > +static inline s64 amd_brs_adjust_period(s64 period)
> > +{
> > +	if (period > x86_pmu.lbr_nr)
> > +		return period - x86_pmu.lbr_nr;
> > +
> > +	return period;
> > +}
> 
> This makes no sense to me without also enforcing that the event is in
> fact that branch retired thing.

So what are we going to do with all these patches? Note that I did pick
them up for testing and I've fixed at least 2 build problems with them.

But I still don't think they're actually completely sane. So there's the
above issue, subtracting lbr_nr from a random event just makes no sense.
But there's also the whole exclusion thing, IIRC you're making it
exclusive against other LBR users, but AFAICT having one LBR user active
will completely screw over any other sampling event due to introducing
these massive skids.
