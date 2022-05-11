Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C1523E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347568AbiEKUHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbiEKUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:07:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BB50461
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5MYsnYRSKK7Ebe+ni7U3mTFvHRE4ANXZttj+MDUakS4=; b=M+jtpgiGBiLZ9Re3/fTGn+jI0s
        GOsXZG7vzknZbCGBsUerzHMyQiq0Tmqx8y6iFrrSMEUnb/6TjpV2vgn09iVwQB9No5CNGDDAlu+t3
        CnEOdIxLE3k2tlfEnJlML97wt2PswUc936w0aPeTRNDEFH9RKii+EyNpqlrUoaeiR+PmA1ZVsqgnl
        xCj654dlb6OGEAQw+7wVcx+8w8Klyso7fEQ+nn2/ThIcop4muzLFLnoEaHSm0B1Nz3kCmX+jTzWyb
        +kvQjNHd+nDnDrLMq6fKOP1JUeJDd1JDY3iZIszNXPDBarJHsTTbRZoQqF5pwwpLWr8coKJCaRs3t
        smZVFjIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nosbr-00DGOs-FG; Wed, 11 May 2022 20:06:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44BF0980EBE; Wed, 11 May 2022 22:06:57 +0200 (CEST)
Date:   Wed, 11 May 2022 22:06:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     x86@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH 4/5] perf/x86: Change x86_pmu::limit_period signature
Message-ID: <20220511200657.GB76023@worktop.programming.kicks-ass.net>
References: <20220511142037.353492804@infradead.org>
 <20220511142345.289907761@infradead.org>
 <208c46f9-ca5e-5825-3b4f-a805054315f4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208c46f9-ca5e-5825-3b4f-a805054315f4@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:47:06PM -0400, Liang, Kan wrote:
> > @@ -1386,19 +1387,14 @@ int x86_perf_event_set_period(struct per
> >   		hwc->last_period = period;
> >   		ret = 1;
> >   	}
> > -	/*
> > -	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> > -	 */
> > -	if (unlikely(left < 2))
> > -		left = 2;
> > 
> 
> Is the quirk accidentally deleted?
> We should still need the quirk for certain CPUs.

No, but I did forget to write about it in the Changelog :/

IIRC it was Nehalem that triggered that and that should now be covered
by nhm_limit_period().

Or are you aware of more machines that need this?

Anyway, perhaps this should be its own separate commit.


