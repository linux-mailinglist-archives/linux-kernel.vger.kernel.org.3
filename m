Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82302507B88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357868AbiDSVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355486AbiDSVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:00:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949854132B;
        Tue, 19 Apr 2022 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K28ZszIq+QiHeei7bDvtjvKxO/gUup7E4EwBSEICmPI=; b=WUpYfAEK9Zn9MxE4if1EFyd1MJ
        2gGb89aNhOI17BdkguShlb1EWfF1maQm/qLJkrMzE59bxC/XFtah6Z0cCUmSfzLLghILF96mj4LER
        uHk7R4lHK+r7l0RQ10eSoiCUoX0eOlDDjSl5BLrt8PRanApn0dcsqUB602Bq4aO4sQQX44A/Etsx9
        u7mRJaGnb/frLOcFE+XcH+eRYX8pUKCeD72/3pq3KxdxYzFVzLRc48Rt+R1Naxt2H/3WQR9yUeKx0
        DLnSs8ucGSh7fR74oL1Ahp0PG9PD6dWgU/eI9Eq0OZLVgyHcypBARzETZVYR7yj0ElLwwYEqqFVUL
        xcnpNMXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nguuq-003Uu9-7B; Tue, 19 Apr 2022 20:57:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BB6E9861A4; Tue, 19 Apr 2022 22:57:38 +0200 (CEST)
Date:   Tue, 19 Apr 2022 22:57:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
Message-ID: <20220419205738.GZ2731@worktop.programming.kicks-ass.net>
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com>
 <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com>
 <YidREXNn2AtI3V1c@hirez.programming.kicks-ass.net>
 <271bc186-7ffb-33c8-4934-cda2beb94816@linux.alibaba.com>
 <Yi8fELo+k9gmkJIa@hirez.programming.kicks-ass.net>
 <05861b8c-2c7c-ae89-613a-41fcace6a174@linux.alibaba.com>
 <e50c5307-8b2d-9338-0acc-9375b76c211d@linux.alibaba.com>
 <c33fd91c-8f8f-c82f-4e03-8799f3b8cd28@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c33fd91c-8f8f-c82f-4e03-8799f3b8cd28@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:16:12PM +0800, Wen Yang wrote:
> We finally found that TFA (TSX Force Abort) may affect PMC3's behavior,
> refer to the following patch:
> 
> 400816f60c54 perf/x86/intel:  ("Implement support for TSX Force Abort")
> 
> When the MSR gets set; the microcode will no longer use PMC3 but will
> Force Abort every TSX transaction (upon executing COMMIT).
> 
> When TSX Force Abort (TFA) is allowed (default); the MSR gets set when
> PMC3 gets scheduled and cleared when, after scheduling, PMC3 is
> unused.
> 
> When TFA is not allowed; clear PMC3 from all constraints such that it
> will not get used.
> 
> 
> > 
> > However, this patch attempts to avoid the switching of the pmu counters
> > in various perf_events, so the special behavior of a single pmu counter
> > will not be propagated to other events.
> > 
> 
> Since PMC3 may have special behaviors, the continuous switching of PMU
> counters may not only affects the performance, but also may lead to abnormal
> data, please consider this patch again.

I'm not following. How do you get abnormal data?

Are you using RDPMC from userspace? If so, are you following the
prescribed logic using the self-monitoring interface?
