Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26A259D14D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiHWGbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiHWGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:31:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A907606A9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=juVaszzeJMqMuBefR+gyU1mZqLKM7XtSJtv1abvtWWg=; b=uHPqi60KT7Kpa+y+BpA4pDBcZH
        WD37BIxxH23YOHhe175qFXpmLGDIMKDnzkcOB8HHyyaimswR2eN/RXl1bf+4s+6gp763aQ/5WQbxQ
        R+u1RB+vN50soeKs2euBCkV8E8P54oeWaHkanid4POokRLiMXqOo8BMFZP1u1e5ZSoBXf+5fzS9aE
        hPO8onIE7Srpyw3/hErv6ZMNnfaYPIGPTJV8CXrZLZQtQSW/9QPfdulVatvuvJUIA21VWhU84Z/jj
        ww46XsXm7FC2Il2p8vfLj8xUZ/PJKWxd/Egc3h5bE7b6s5iDaavHmM0xWGn34YfcO/lfJniOUiADF
        ZpyYfMnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQNQs-00F1cs-Jx; Tue, 23 Aug 2022 06:30:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1084C980403; Tue, 23 Aug 2022 08:30:37 +0200 (CEST)
Date:   Tue, 23 Aug 2022 08:30:36 +0200
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
Message-ID: <YwR0DL319gD/ebha@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
 <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
 <YwOkFqqxONtoGImZ@worktop.programming.kicks-ass.net>
 <fb28c31f-c531-4be3-e9c9-d324451d79d5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb28c31f-c531-4be3-e9c9-d324451d79d5@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:07:45PM +0530, Ravi Bangoria wrote:
> On 22-Aug-22 9:13 PM, Peter Zijlstra wrote:
> > On Mon, Aug 22, 2022 at 05:29:11PM +0200, Peter Zijlstra wrote:
> >> On Tue, Aug 02, 2022 at 11:41:42AM +0530, Ravi Bangoria wrote:
> >>>
> >>>> pulling up the ctx->mutex makes things simpler, but also violates the
> >>>> locking order vs exec_update_lock.
> >>>>
> >>>> Pull that lock up as well...
> >>>
> >>> I'm not able to apply this patch as is but I get the idea. Few
> >>> questions below...
> >>
> >> I was just about to rebase the 'series' to current, let me do that and
> >> get back to you on the specifics.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/wip.rewrite
> 
> Additional set of changes on top of this tree is required to build and boot,
> atleast on my AMD machine:

Right; clearly I didn't even test build that thing... your changes look
fine and added then on top, above tree should be updated.
