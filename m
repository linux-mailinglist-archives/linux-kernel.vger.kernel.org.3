Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0EE47C0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbhLUN0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:26:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38912 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhLUN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:26:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2544F61595
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD39FC36AE8;
        Tue, 21 Dec 2021 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640093180;
        bh=bwhIc2CW6eSSB5kjPKSc77aefUPIhzP9eVdEkv24dl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=MEw4nOQk+pvLr2E3a/HfO+Iu+ulX18D2aPRa8pLRQUt7ZTwpv69ae0AV4d5NjDfAc
         BkHCKQnNEb2dZTOk4UzUVaZZutSq1Cid6hbiq97H6bXTxj4VenbiEWCAS13wtmoOml
         2eYLvOjYOS5xhXxGXYq7GiSnQ4wG7hXuL8/2b7Pl3XvvB5WekIcGvOv2Le9WNr1rcp
         iqeK42QsW+O8qaqQaOTLGWj/De7Lg82MiMUuhESNoHjoxhKAvD7F0ZqkFirtOs3PIE
         V6Nl0zaauXHqVHsjx/Cdyo/l7ML4OA8NMwOlpmwkwEqyh3NJMJObQoWMJBI6Dcg0bJ
         eWFTNPwqveNuQ==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com, ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add a new scheme to support demotion on tiered memory system
Date:   Tue, 21 Dec 2021 13:26:17 +0000
Message-Id: <20211221132617.15064-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1640077468.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Tue, 21 Dec 2021 17:18:02 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Hi,
> 
> Now on tiered memory system with different memory types, the reclaim path in
> shrink_page_list() already support demoting pages to slow memory node instead
> of discarding the pages. However, at that time the fast memory node memory
> wartermark is already tense, which will increase the memory allocation latency
> during page demotion. So a new method from user space demoting cold pages
> proactively will be more helpful.
> 
> We can rely on the DAMON in user space to help to monitor the cold memory on
> fast memory node, and demote the cold pages to slow memory node proactively to
> keep the fast memory node in a healthy state.
> 
> This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
> and works well from my testing. Any comments are welcome. Thanks.

I like the idea, thank you for these patches!  If possible, could you share
some details about your tests?


Thanks,
SJ

> 
> 
> Baolin Wang (2):
>   mm: Export the alloc_demote_page() function
>   mm/damon: Add a new scheme to support demotion on tiered memory system
> 
>  include/linux/damon.h |   3 +
>  mm/damon/dbgfs.c      |   1 +
>  mm/damon/vaddr.c      | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/internal.h         |   1 +
>  mm/vmscan.c           |   2 +-
>  5 files changed, 162 insertions(+), 1 deletion(-)
> 
> -- 
> 1.8.3.1
