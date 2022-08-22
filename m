Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E259C2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiHVP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiHVP32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:29:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B0E02B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L0RSP2WRBejZlqTDBjBr4XbEOe0Tr9fW4Xf6+0aI1cQ=; b=aN0y209Hwl1TQUGfVba0RdJXKB
        RTqPxpt23L+vrIHkuGXeSNTDPoBxHS0oLwBQBax5cU/XhCMMVoeZG52QgXwEg9uVvrOw6t3ERDdlP
        Dy2vEmbBl1lJn04wnHhK56uyngRMmN+k3gqhx28BjDZi4NV7yGCNWMYq/Iw8Y8Sa5yfxmlxNe2Uw7
        B7bW8QNK1xPYxavsBp3YGxeAhhbzUCILN64wNnvzkSLr+oItcyRdAwtcQX9pXn/jk713Z2hQONrDk
        iYZgmYoY2gK3WPfKY/Td6uJ2MRDW6gUuZYDrB93vQxjveOdAXpcaa+kbbxozAEDlC6Kkb4D/8fjOq
        N6otzbjQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ9MW-00EP51-5B; Mon, 22 Aug 2022 15:29:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 073419804A3; Mon, 22 Aug 2022 17:29:11 +0200 (CEST)
Date:   Mon, 22 Aug 2022 17:29:10 +0200
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
Message-ID: <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:41:42AM +0530, Ravi Bangoria wrote:
> 
> > pulling up the ctx->mutex makes things simpler, but also violates the
> > locking order vs exec_update_lock.
> > 
> > Pull that lock up as well...
> 
> I'm not able to apply this patch as is but I get the idea. Few
> questions below...

I was just about to rebase the 'series' to current, let me do that and
get back to you on the specifics.
