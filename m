Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E6E4DD875
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiCRKvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiCRKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB5B26C2E1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64459B81F7C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E74EC340F0;
        Fri, 18 Mar 2022 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647600592;
        bh=1pzfZml0Q8sVwbCaBTnrUqVKnz0JRxDGgLD3gFXNCM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=i76iyzoCYoGQEJ1n15PMzE5+UrbSvRDfuGBeJQk7KLJvK+HxowNqX0wbeLcUDXwkB
         IZ9GlDZgNwgBy2v1spJUXsXZxd8Jggdis9ZA1VrMuTBKk+N1jD6H8fpCEZbWN86ICp
         PsluMlfr7+k9jFMGF5Bx+Csf8ceKLBe9EqRDGJEG8nN4PjKrtCCF/QKlZr60NuXnBG
         +nogFcS2s2SlLJrf3WxZEnJE5q2lrShbpnmXjPpDB+49iwh5sXnA2e9ypDUcwAoRXA
         9hHH3evjrpcsb0/yO6GH2U9EbeZHfafCcLGmOWN1y16/pHMUTD1STKNyUdVytY/42E
         2j/e0Db4WUOug==
From:   sj@kernel.org
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Make the sampling more accurate
Date:   Fri, 18 Mar 2022 10:49:48 +0000
Message-Id: <20220318104948.26387-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5cb98e07-1e51-e376-8e67-dffc92f24941@linux.alibaba.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:01:19 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> On 3/18/2022 5:40 PM, sj@kernel.org wrote:
> > Hi Baolin,
> > 
> > On Fri, 18 Mar 2022 17:23:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> When I try to sample the physical address with DAMON to migrate pages
> >> on tiered memory system, I found it will demote some cold regions mistakenly.
> >> Now we will choose an physical address in the region randomly, but if
> >> its corresponding page is not an online LRU page, we will ignore the
> >> accessing status in this cycle of sampling, and actually will be treated
> >> as a non-accessed region. Suppose a region including some non-LRU pages,
> >> it will be treated as a cold region with a high probability, and may be
> >> merged with adjacent cold regions, but there are some pages may be
> >> accessed we missed.
> >>
> >> So instead of ignoring the access status of this region if we did not find
> >> a valid page according to current sampling address, we can use last valid
> >> sampling address to help to make the sampling more accurate, then we can do
> >> a better decision.
> > 
> > Well...  Offlined pages are also a valid part of the memory region, so treating
> > those as not accessed and making the memory region containing the offlined
> > pages looks colder seems legal to me.  IOW, this approach could make memory
> > regions containing many non-online-LRU pages as hot.
> 
> IMO I don't think this is a problem, since if this region containing 
> many non-online-LRU pages is treated as hot, which means threre are aome 
> pages are hot, right? We can find them and promote them to fast memory 
> (or do other schemes). Meanwhile, for non-online-LRU pages, we can 
> filter them and do nothing for them, since we can not get a valid page 
> struct for them.

For some of DAMOS actions that you mentioned, that could make sense.  However,
that wouldn't make much sense for some other cases, especially for manual
DAMON-based access pattern profiling.

After all, we already have a mechanism for this case: adaptive regions
adjustment (or, regions split/merge).  That mechanism will eventually separate
out hot oneline-LRU pages in the memory regions.  Before the region is
adjusted, reporting the whole region as hot looks like a right result to me.
Of course, I admit that it could take too much time to converge to the optimal
regions, and there are many rooms for improvement of the regions adjustment
mechanism.  I think we should pursue the direction (improving the regions
adjustment mechanism).


FYI, I have some rough ideas for improving the mechanism including partitioning
regions into more than 2 sub-regions if we belive it is not making a good
progress.  Nevertheless, I'd like to first make a methodology for evaluating
current accuracy.  For that, I am planning to implement a page-granularity
access monitoring.


Thanks,
SJ

[...]
