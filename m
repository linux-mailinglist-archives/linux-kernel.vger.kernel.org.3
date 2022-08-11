Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0B59087B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiHKWBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiHKWBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:01:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A0923C5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29EE3B822C3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B01C43141;
        Thu, 11 Aug 2022 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660255266;
        bh=0jzWSKGIa0lja44Of6Wk9nanVIqaf3tH8/GBEI38e+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ae+7QQXtxh/ub4KqOuWm93rAtjNxAU7txOnERHKUdtNsiPUmUOYjW4p+zdfB0ApNx
         KGay20cgP4rJrCnX6sTZ8s7H2acq5F6DRyXp3ObFLa1Jt6aSVvkD7vCCeLMMCOfWOH
         53xMFxXF6guXABfBz45LXMlvHiBXEoTbpHXu5ZJE=
Date:   Thu, 11 Aug 2022 15:01:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] mm/uffd: Reset write protection when unregister with
 wp-mode
Message-Id: <20220811150105.ce8636e7f101545d12d6cfac@linux-foundation.org>
In-Reply-To: <YvVzQqXp81zgA/DP@xz-m1.local>
References: <20220811201340.39342-1-peterx@redhat.com>
        <20220811141144.6aa509e68c5c7cd8b6c131b6@linux-foundation.org>
        <YvVzQqXp81zgA/DP@xz-m1.local>
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

On Thu, 11 Aug 2022 17:23:14 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Thu, Aug 11, 2022 at 02:11:44PM -0700, Andrew Morton wrote:
> > On Thu, 11 Aug 2022 16:13:40 -0400 Peter Xu <peterx@redhat.com> wrote:
> > 
> > > I added a Fixes upon introducing of uffd-wp shmem+hugetlbfs because that's
> > > the only issue reported so far and that's the commit David's reproducer
> > > will start working (v5.19+).  But the whole idea actually applies to not
> > > only file memories but also anonymous.  It's just that we don't need to fix
> > > anonymous prior to v5.19- because there's no known way to exploit.
> > 
> > I added a cc:stable to this.
> 
> Thanks, Andrew.  I'll remember to do so in future patches when Fixes apply.
> 

Only if we want the fix to be backported!

I mean, it's legitimate and sensible to add a Fixes: to a patch which
fixes a comment typo, but we don't want that backported.

And sometimes a fix is too complex and the problem too small to warrant
a backport, but we still want that Fixes: tag.
