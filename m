Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29947DB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbhLWABK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhLWABJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:01:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 16:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CA9CB81EDC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 00:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89703C36AE8;
        Thu, 23 Dec 2021 00:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640217667;
        bh=8mKy0ejJYhDe1sSwxvENGA/O6BaHbuKqNIN2Oui80fE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cQdliyZv6Mk+2L3Ne6sSwjPko/FERnScWunZ6aNdaJB0i7wiTJoaBfMk38GNz/pa4
         bRUpCkO2AWJiQnvTBRgl9CBPThsz6nwVZPEZgEnqC0uqOOdKiHnnogSw4eeHBudI0e
         PKMxMvLgpMblseMfvQrbjOUelBckULyINBTLHDXo=
Date:   Wed, 22 Dec 2021 16:01:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, ying.huang@intel.com, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
Message-Id: <20211222160105.a267eaacefae77ae094c050e@linux-foundation.org>
In-Reply-To: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 19:14:39 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

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

This is interesting.

I think it would be helpful if we could have some example scenarios in
this changelog, help people understand how to use DAMOS_DEMOTE and what
effects it has.

Documentation/admin-guide/mm/damon/usage.rst would like an update?

And the DAMON user space tool?
