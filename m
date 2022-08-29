Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795685A4F76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiH2Ol0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiH2OlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:41:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D858C475;
        Mon, 29 Aug 2022 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lJS+pLAi5sb8pBgmQuEnoBizzRdmvXfzdL3MQDy3a/M=; b=NM3GMWCME6KcxUES8h8nuw3Jtz
        yT8WFtLWcEFeiCptFrBzQYF9ZbcPj3SDgh98MFhThfzLX37DexiocmtuU+cxLlRsbdW8387JE0Agf
        HIlNlSSGWkMm/dINC2uaBkERa9wUQ8JKJrn0gyLkCvqClWMMKOFuJUa1Mptrpq80QfIz+aK6tM4QI
        eA326NpyLe5tsWtX+rGIsq1AznuDhNH2OD3I7GweQIRMWnkWWJyS+DiE3qcrYas70B6NTF83GL/0J
        zqfmKrkAN3qPClkCvr1Rg4TuSPP+RHm6+RILfx08k1isT9Nmcpp8B46YGomKVod6QKVLGSEdrf6Nk
        0fv3StdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSfwh-003ATB-Re; Mon, 29 Aug 2022 14:40:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFBE23002FE;
        Mon, 29 Aug 2022 16:40:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9992D2097DAD1; Mon, 29 Aug 2022 16:40:56 +0200 (CEST)
Date:   Mon, 29 Aug 2022 16:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH] perf: Rewrite core context handling
Message-ID: <YwzP+AFWCx4Ni/kx@hirez.programming.kicks-ass.net>
References: <20220829113347.295-1-ravi.bangoria@amd.com>
 <YwyrUYS30gVbxc2D@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwyrUYS30gVbxc2D@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:04:33PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 05:03:47PM +0530, Ravi Bangoria wrote:
> > @@ -12598,6 +12590,7 @@ EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
> >  
> >  void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
> >  {
> > +#if 0 // XXX buggered - cpu hotplug, who cares
> >  	struct perf_event_context *src_ctx;
> >  	struct perf_event_context *dst_ctx;
> >  	struct perf_event *event, *tmp;
> > @@ -12658,6 +12651,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
> >  	}
> >  	mutex_unlock(&dst_ctx->mutex);
> >  	mutex_unlock(&src_ctx->mutex);
> > +#endif
> >  }
> >  EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
> >  
> 
> Note to self; fix this :-) I'll see if I have time for that later today.

Urgh, while going through that it appears the whole refcounting thing
isn't fully done either.
