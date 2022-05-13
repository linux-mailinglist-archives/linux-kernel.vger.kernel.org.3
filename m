Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D4526C03
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384603AbiEMVBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384601AbiEMVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:01:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68254993A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62A77B831DC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 21:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D309BC34113;
        Fri, 13 May 2022 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652475702;
        bh=K30XMESHglCJLbQuyFBmL05TFQc8cKlakkW76H42nlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Il8ZJG9tgo+mG6W51u/73e0HJDadPxdS1p8DITFOz144F+OCYHqklMgcUw2adM+Zy
         BLGfrMgtrDmLLE7GNtTq9f3uwGH2tV4+mcKus8lOKgLCVo05V1UIhgeZ/BuJah8Msb
         7+I0nMgMMs8m2K00P/7JlVqCUuj/qRTnkOjwjmSM=
Date:   Fri, 13 May 2022 14:01:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     aquini@redhat.com, ddutile@redhat.com, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, vvghjk1234@gmail.com
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return
 pfn in the target zone
Message-Id: <20220513140141.3b2accfc8fbae08ec4177781@linux-foundation.org>
In-Reply-To: <20220513041112.31609-1-yamamoto.rei@jp.fujitsu.com>
References: <20220512134945.fe74df5e322b98ae4046ce15@linux-foundation.org>
        <20220513041112.31609-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 13:11:12 +0900 Rei Yamamoto <yamamoto.rei@jp.fujitsu.com> wrote:

> On Thu, 12 May 2022 13:49:45 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 12 May 2022 13:27:33 +0900 Rei Yamamoto <yamamoto.rei@jp.fujitsu.com> wrote:
> >
> >> >> Thank you for your review.
> >> >> The runtime effect is that compaction become unintended behavior.
> >> >> For example, pages not in the target zone are added to cc->migratepages list in isolate_migratepages_block().
> >> >> As a result, pages migrate between nodes unintentionally.
> >> >
> >> > Many thanks for clarifying. :) Is this worth a Fixes tag or even CC stable?
> >> >
> >> > Thanks!
> >> 
> >> Thank you for your reply.
> >> 
> >> If add a Fixes tag, I think the following commit:
> >>   Fixes: 70b4459 ("mm, compaction: use free lists to quickly locate a migration source")
> >> 
> >> Andrew, how do you think about this? 
> >
> > Thanks, I added that and also a paragraph describing the effect of the bug:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-compaction-fast_find_migrateblock-should-return-pfn-in-the-target-zone.patch
> >
> > I assume this problem isn't sufficiently serious to require a -stable
> > backport of the fix?
> 
> This would be a serious problem for older kernels without commit a984226, 
> because it can corrupt the lru list by handling pages in list without holding proper lru_lock.

Thanks, I added the above to the changelog.

The patch applies OK to older kernels (I tried v5.10).  So I guess we
put a cc:stable in this, so it gets backported?

