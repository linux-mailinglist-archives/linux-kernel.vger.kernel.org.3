Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778D5A55F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiH2VMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2VMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:12:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D2832FD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uj6vZ5sg2VZR0D0tH224APsM+dtjkauYrq1ummlOcSg=; b=byg9fjZnuQuNkMDzuqBZdY/Fsa
        42FNbZM5hWZyLKEhkFR6AYZaT+e6/UkM73Rj72tBT+8YkAhd+HZQboqMwgi0pM7zcqn9VwaIwAYSs
        QgJFnfpgc7np7QkF1ssBBtHRgFyv2XC86zQQtA5KWBgFQy2v8ArpFX8Fo+kLkYzmy14fqAix4R0g0
        c5UXYAvRlqhm3/Wu+a0k5MvjC+5nA2a6cr59yV0ruIomA6747zN/TFyt3UnaDuAqr6Sr5Juq1VLuK
        FLeBexleLk2DDopZL16EsZforssXMo5WTWZw7q4xQR5aABfwmnxulsB3QA0L9KVBlOxSSRdDKHzMw
        iSekJGFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSm3X-003POS-Ap; Mon, 29 Aug 2022 21:12:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAB27980055; Mon, 29 Aug 2022 23:12:22 +0200 (CEST)
Date:   Mon, 29 Aug 2022 23:12:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     x86@kernel.org, eranian@google.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 9/9] perf/x86/intel: Optimize short PEBS counters
Message-ID: <Yw0rtp4cjPj4+HFR@worktop.programming.kicks-ass.net>
References: <20220829100959.917169441@infradead.org>
 <20220829101321.971473694@infradead.org>
 <e8b5086e-735f-51ea-f413-3b2d456c0e32@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b5086e-735f-51ea-f413-3b2d456c0e32@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:55:12AM -0400, Liang, Kan wrote:
> 
> 
> On 2022-08-29 6:10 a.m., Peter Zijlstra wrote:
> > XXX: crazy idea; really not sure this is worth the extra complexity
> > 
> > It is possible to have the counter programmed to a value smaller than
> > the sampling period.
> 
> I'm not quite sure how the above case can be triggered.
> 
> For the most of the cases, the pmc_prev_left[idx] should be the same as
> the hwc->period_left.
> 
> For the left < 2 or the limit_period case, I think perf usually program
> a larger value, so the pmc_prev_left[idx] > hwc->period_left.
> 
> It looks like the only case, which triggers the pmc_prev_left[idx] <
> hwc->period_left, is the left > max_period. I don't think it's common
> for a user to set a period which is larger than the HW counter limit.
> Even if they set a huge period, the PEBS overhead should not be an
> issue, since it may causes days to trigger a sample.
> 
> If so, it may not be a good idea to introduce such complexity to only
> handle such rare cases.

Yeah, happy to forget this patch exists.. I wrote this things months ago
and I'm not entirely sure why :-)
