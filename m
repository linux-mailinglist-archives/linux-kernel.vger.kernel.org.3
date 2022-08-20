Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9F59B0AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 00:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiHTWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHTWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 18:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A802B268
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 15:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716F660C28
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A6DC433C1;
        Sat, 20 Aug 2022 22:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661033233;
        bh=OMjSKoN1CgLtZDBS1iDToK7phTnQHbLYbNnSr9H4cOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SST4XN0HIP94HTmFajkz8ZT0FtzmNfPwNmCIamX1rrN1Q3BSh2pw1B8pLTSZs/E1U
         96qlzs7VEWwlTPlxQScCv5g2GCPhBGyg+4pdbRPd9G+/PyC3/AKBJuN3RbPmMfywxW
         YG/Z7Qz+KVE1vLZD3ZGgAtoAJeMlCw+oXB0w9NCs=
Date:   Sat, 20 Aug 2022 15:07:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <alexlzhu@fb.com>
Cc:     <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to debugfs
Message-Id: <20220820150712.53ec2dd281dfe894ad3fe2df@linux-foundation.org>
In-Reply-To: <20220818000112.2722201-1-alexlzhu@fb.com>
References: <20220818000112.2722201-1-alexlzhu@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 17:01:12 -0700 <alexlzhu@fb.com> wrote:

> THPs have historically been enabled on a per application basis due to
> performance increase or decrease depending on how the particular
> application uses physical memory. When THPs are heavily utilized,
> application performance improves due to fewer TLB cache misses.
> It has long been suspected that performance regressions when THP
> is enabled happens due to heavily underutilized anonymous THPs.
> 
> Previously there was no way to track how much of a THP is
> actually being used. With this change, we seek to gain visibility
> into the utilization of THPs in order to make more intelligent
> decisions regarding paging.
> 
> This change introduces a tool that scans through all of physical
> memory for anonymous THPs and groups them into buckets based
> on utilization. It also includes an interface under
> /sys/kernel/debug/thp_utilization.
> 
> Utilization of a THP is defined as the percentage of nonzero
> pages in the THP. The worker thread will scan through all
> of physical memory and obtain utilization of all anonymous
> THPs. It will gather this information by periodically scanning
> through all of physical memory for anonymous THPs, group them
> into buckets based on utilization, and report utilization

I'd like to see sample debugfs output right here in the changelog, for
reviewers to review.  In some detail.

And I'd like to see the code commented!  Especially
thp_utilization_workfn(), thp_util_scan() and thp_scan_next_zone(). 
What are their roles and responsibilities?  How long do they take, by
what means do they scan?

I mean, scanning all of physical memory is a huge task.  How do we
avoid chewing vast amounts of CPU?  What is the chosen approach and
what are the tradeoffs?  Why is is done within a kernel thread at all,
rather than putting the load into the context of the reader of the
stats (which is more appropriate).  etcetera.  There are many traps,
tradeoffs and hidden design decisions here.  Please unhide them.

This comment, which is rather a core part of these tradeoffs:

+/*
+ * The number of addresses to scan through on each periodic
+ * run of the scanner that generates /sys/kernel/debug/thp_utilization.
+ */
+#define THP_UTIL_SCAN_SIZE 256

isn't very helpful.  "number of addresses"?  Does it mean we scan 256
bytes at a time?  256 pages?  256 hugepages?  Something else?

How can any constant make sense when different architectures have
different [huge]page sizes?  Should it be scaled by pagesize?  And if
we're going to do that, we should scale it by CPU speed at the same time.

Or bypass all of that and simply scan for a certain amount of *time*,
rather than scan a certain amount of memory.  After all, chunking up
the scan time is what we're trying to achieve by chunking up the scan
amount.  Why not chunk up the scan time directly?

See where I'm going?  I see many hidden assumptions, design decisions
and tradeoffs here.  Can we please attempt to spell them out and review
them.

Anyway.  There were many review comments on previous versions.  It
would have been better had those reviewers been cc'ed on this version. 
I'll go into hiding and see what people think.
