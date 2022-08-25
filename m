Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2075A0DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiHYKYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbiHYKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:24:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578F067477;
        Thu, 25 Aug 2022 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Th1nwdy3i9u0OHY/OZcQUzbFY7IMsHdi41zIVBzQJNU=; b=NB+WSeTrtb0f2RxsXPn1w5DDca
        CJ1uwHC1R7u1flKyB0xMg8jNHBvgC7tuobUFSaI1fLQ3Z+H4t6RdbekstP6fVIg/ylfwvZ9xnZgfG
        cqMfOugmD1W/UD9OVVeFYKL6lXGVZyxrqqtaicj0eay15QF2dqZHz1gyNG+sjTg1WhTP7aSjkyByq
        JdJRBUsdEOXyqR4akA72lc+IXZROFVrK3B9/XHyhakQB4sl29GsWZKfI7KPuWWF3CgSzd9xGDQ2Oy
        W+yNLCmNqr7svb2+PBvKVkDA8fZZzSUuUq1Vc7QtqUE+PSFD+D6IdtLxzpT27opg+kUzLNl+LmFvf
        JxjzVshQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRA1o-005yt2-Pp; Thu, 25 Aug 2022 10:24:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B68698014D; Thu, 25 Aug 2022 12:24:00 +0200 (CEST)
Date:   Thu, 25 Aug 2022 12:24:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, acme@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, like.xu.linux@gmail.com,
        Stephane Eranian <eranian@google.com>, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
Message-ID: <YwdNwBeHI3pBQ5F6@worktop.programming.kicks-ass.net>
References: <cover.1660211399.git.sandipan.das@amd.com>
 <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
 <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
 <YwNG1XzcyR5ys+rA@worktop.programming.kicks-ass.net>
 <06e9a357-422d-1870-ae72-18e74964caf3@amd.com>
 <YwOEIESeDSuekmf8@worktop.programming.kicks-ass.net>
 <91cc5c2b-75d9-1b2a-9ad0-a94a60ee72c2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cc5c2b-75d9-1b2a-9ad0-a94a60ee72c2@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 02:21:06PM +0530, Sandipan Das wrote:
> I can rename this feature to AMD_LBR_V2.

I've done that and stuck them in queue/perf/core. If the robots don't
hate on it I'll push them into tip.
