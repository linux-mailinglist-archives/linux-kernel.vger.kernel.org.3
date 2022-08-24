Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5259F435
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiHXH1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiHXH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:27:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF4669F4D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dLscxFkI37Iy2zsCWkiigExtiRT/8vYmPbsCuER+yws=; b=lWJi5kISStz8pom5XpN7Y99kQf
        xjZ3BIuJNHYDwQhNzT7Nzg5/J9ee1QK6lvhOurYFr0AY2HErOL/4ZfFint4K2zxGhWpw8SttXbzN3
        G3Rr9a1hwkk7yzEzheuczdn4vtdlfvXGkLzFk4ftrPqSF0Uhk3R8qn/oXoTFCVwmHztOHLJsVxOh7
        iDQb0dORUKJ4orGHAatefZRrP6TSh7wUNZDZrYol1lERAZnMmAMHbq1j76NYQOAC+vViNiI8kYieg
        Wna7g1YDY6VA3w/tTbUodJwF6iPzfBwtvdcc+mW50GTawuAd2XysdcbR1cs3yVYQPmHOpFb5VSSJM
        pcmq8GIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQkn4-00G6xD-KH; Wed, 24 Aug 2022 07:27:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F822980403; Wed, 24 Aug 2022 09:27:05 +0200 (CEST)
Date:   Wed, 24 Aug 2022 09:27:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YwXSyWE9BqTwi5aL@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdNKJllCVMci3ov@hirez.programming.kicks-ass.net>
 <aab04cfb-2dd5-89dc-213d-7fa253615864@amd.com>
 <YwSWhXW+BUA3WkIE@worktop.programming.kicks-ass.net>
 <cf2cdf28-8678-8e61-9992-a460e61d3ce2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf2cdf28-8678-8e61-9992-a460e61d3ce2@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:37:36AM +0530, Ravi Bangoria wrote:

> > Now, I suppose making that:
> > 
> >   {-1, NULL, NULL}, {cpu, NULL, NULL}
> > 
> > could work, but wouldn't iterating the the tree be more expensive than
> > just finding the sub-trees as we do now?
> 
> pmu=NULL can be used while scheduling entire context. We can just traverse
> through all pmu events of both cpu subtrees.

But imagine the case where we have 50 event for a PMU that can only
schedule 8. Then we have to iterate 42 events for naught instead of
directly jumping to the next PMU.


