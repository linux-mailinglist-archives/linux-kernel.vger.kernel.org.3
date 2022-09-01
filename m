Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AEE5A92C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiIAJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiIAJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:07:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921EB1360BB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=75M0gaIwvPRkBp8eX8QIzAR0L6EGBa4m0/QqT3gBJ90=; b=KbuClTk87EAyo3Z96pVpWuzjY6
        9gaUFL5ApEiafPpXUCTWp3c5q3XQ3pFaaefyHlaboxejUpCmG33dtUW3lBxpRX8+G4uQHXdtxXg+m
        luUl9w3SwUlxUfWTNpuk//7kX9418mnqFgT8/KlBlyq0j+5NQn+z1AIOMbXJGVwmaS3gujOUSt2UB
        bMSawZK9gq6VAIs7xBDb/fNpPYvv2atD2nuv+r7exE+tR1VHv0PFuYp66VH0qTDZchGtR8fD3xbAJ
        ldFVWRAfFEKdVpQs121MCutodHkvgaOOPt0x1ZRRgGSjEisu7xtkyMCVl9T32VTTtk67MRxd66fTy
        N6wudSPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTg9e-008Mnq-7b; Thu, 01 Sep 2022 09:06:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6429300244;
        Thu,  1 Sep 2022 11:06:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACB4F2B1A6BC3; Thu,  1 Sep 2022 11:06:29 +0200 (CEST)
Date:   Thu, 1 Sep 2022 11:06:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     x86@kernel.org, eranian@google.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 2/9] perf/x86/intel: Move the topdown stuff into the
 intel driver
Message-ID: <YxB2Ff9f+pM9W9Zf@hirez.programming.kicks-ass.net>
References: <20220829100959.917169441@infradead.org>
 <20220829101321.505933457@infradead.org>
 <30dfae24-887d-128f-3172-d52c90c95f86@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30dfae24-887d-128f-3172-d52c90c95f86@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 09:41:06AM -0400, Liang, Kan wrote:
> >  static void intel_pmu_reset(void)
> >  {
> >  	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
> > @@ -4635,6 +4653,10 @@ static __initconst const struct x86_pmu
> >  	.enable_all		= core_pmu_enable_all,
> >  	.enable			= core_pmu_enable_event,
> >  	.disable		= x86_pmu_disable_event,
> > +
> > +	.set_period		= intel_pmu_set_period,
> > +	.update			= intel_pmu_update,
> 
> I tried the patch, but it impacts the topdown.
> The root cause is that these should be added for intel_pmu rather than
> core_pmu.
> 

Dang; must be a rebase fail on my end, sorry about that. Let me go fix
that.
