Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8151347DC87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 02:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhLWBHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 20:07:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:28929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239969AbhLWBHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640221631; x=1671757631;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=G18tnnL+Hp4+XPM1Yabt858Hl7hd2hnrvqUnfFExzfo=;
  b=gI7R8nko3R5Ox3MHjENJRYlHYAse/qErLXneT0hMUqPA3AXW10zm1/du
   do0CO5nAKAzgcKHcEDt55SHBmnYmHAeMMchOTa3MGoflDbNllJnuavrPu
   2xuFfO0jNHxzlMB7LIfc/L25rYwuzr+d/RdGlzDrCbt2odAVcIJQd5euL
   Lroh4fHn2FwcDk8jadEVWkIyOxQLEjqr472CdkixbjSlWhqQfBh7hpb/J
   DWB8exHZzvMMy+rrNkEAZ1JRK7dnnG1ZZPDb8OCqLGrnPXQ67LdQC9xZI
   ChY+QS8rCkkhhLZFQZQIo+aBX3JYON7486ri3jeTJkPQTdPdP3BZoLM2J
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="221408979"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="221408979"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 17:07:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="521891684"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 17:07:07 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <sj@kernel.org>, <akpm@linux-foundation.org>,
        <dave.hansen@linux.intel.com>, <ziy@nvidia.com>,
        <shy828301@gmail.com>, <zhongjiang-ali@linux.alibaba.com>,
        <xlpang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 09:07:05 +0800
In-Reply-To: <cover.1640171137.git.baolin.wang@linux.alibaba.com> (Baolin
        Wang's message of "Wed, 22 Dec 2021 19:14:39 +0800")
Message-ID: <87a6gsceo6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

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

As a performance optimization patch, it's better to provide some test
results.

Another question is why we shouldn't do this in user space?  With DAMON,
it's possible to export cold memory regions information to the user
space, then we can use move_pages() to migrate them from DRAM to PMEM.
What's the problem of that?

Best Regards,
Huang, Ying

> Changes from v1:
>  - Reuse the demote_page_list().
>  - Fix some comments style issues.
>  - Move the DAMOS_DEMOTE definition to the correct place.
>  - Rename some function name.
>  - Change to return void type for damos_isolate_page().
>  - Remove unnecessary PAGE_ALIGN() in damos_demote().
>  - Fix the return value for damos_demote().
>
> Baolin Wang (2):
>   mm: Export the demote_page_list() function
>   mm/damon: Add a new scheme to support demotion on tiered memory system
>
>  include/linux/damon.h |   3 ++
>  mm/damon/dbgfs.c      |   1 +
>  mm/damon/vaddr.c      | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/internal.h         |   2 +
>  mm/vmscan.c           |   4 +-
>  5 files changed, 155 insertions(+), 2 deletions(-)
