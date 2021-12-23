Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15E347DE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 04:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346047AbhLWDWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 22:22:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:15721 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhLWDWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 22:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640229760; x=1671765760;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=nVLDDg8On+ICFAWhrHSjhLFb+A4To9duy6snog5e8I4=;
  b=SRAJ+Ic5HduwoLdkiAMKvlCKAlha7FQcE/jR8ap2rmwOjwpGl9WnMSL4
   I5HHUSI57KW2LS7P20tFU1fQH7/jKyA9YWW+36xI/J9E+53KB/aSPke+s
   FcSXY1//7mRw7pIrKOq6QxkivV4VG+rtnSpIZ1O8tTi4+vOF7BbBYAbOK
   BU1CPl90eNazTI4O9dzFDX9HCX7Hdw1HgPM2VByXcJ0ceZLSI40zedB7x
   8V+dCRheogS5HxiTjEmsaB0Suvv873bV2CTxGFyhI2dpdGDfMkfmnpLB8
   p66PkI6z59AIRPx5k7dEz22ePXeQpsymrYq/Aq/y6S/Tb9LF8KHFETfkw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="221422511"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="221422511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 19:22:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="521926203"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 19:22:37 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, <sj@kernel.org>
Cc:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <shy828301@gmail.com>,
        <zhongjiang-ali@linux.alibaba.com>, <xlpang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
        <87a6gsceo6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <90c5f31f-9e0a-df6d-8639-8a46ee02f9fa@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 11:22:35 +0800
In-Reply-To: <90c5f31f-9e0a-df6d-8639-8a46ee02f9fa@linux.alibaba.com> (Baolin
        Wang's message of "Thu, 23 Dec 2021 09:21:45 +0800")
Message-ID: <875yrgc8ec.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 12/23/2021 9:07 AM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> Hi,
>>>
>>> Now on tiered memory system with different memory types, the reclaim path in
>>> shrink_page_list() already support demoting pages to slow memory node instead
>>> of discarding the pages. However, at that time the fast memory node memory
>>> wartermark is already tense, which will increase the memory allocation latency
>>> during page demotion. So a new method from user space demoting cold pages
>>> proactively will be more helpful.
>>>
>>> We can rely on the DAMON in user space to help to monitor the cold memory on
>>> fast memory node, and demote the cold pages to slow memory node proactively to
>>> keep the fast memory node in a healthy state.
>>>
>>> This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
>>> and works well from my testing. Any comments are welcome. Thanks.
>> As a performance optimization patch, it's better to provide some
>> test
>> results.
>
> Actually this is a functional patch, which adds a new scheme for
> DAMON. And I think it is too early to measure the performance for the
> real workload, and more work need to do for DAMON used on tiered
> memory system (like supporting promotion scheme later).

I don't think you provide any new functionality except the performance
influence.

And I think proactive demotion itself can show some performance benefit
already.  Just like we can find the performance benefit in the proactive
reclaim patchset as below.

https://lore.kernel.org/lkml/20211019150731.16699-1-sj@kernel.org/

>> Another question is why we shouldn't do this in user space?  With DAMON,
>> it's possible to export cold memory regions information to the user
>> space, then we can use move_pages() to migrate them from DRAM to PMEM.
>> What's the problem of that?
>
> IMO this is the purpose of introducing scheme for DAMON, and you can
> check more in the Documentation/admin-guide/mm/damon/usage.rst.
>
> "
> Schemes
> -------
>
> For usual DAMON-based data access aware memory management
> optimizations, users
> would simply want the system to apply a memory management action to a memory
> region of a specific access pattern.  DAMON receives such formalized
> operation
> schemes from the user and applies those to the target processes.
> "

For proactive reclaim, we haven't a user space ABI to reclaim a page of
a process from memory to disk.  So it appears necessary to add a kernel
module to do that.

But for proactive demotion, we already have a user space ABI
(move_pages()) to demote a page of a process from DRAM to PMEM.  What
prevents you to do all these in the user space?

And, I found there are MADV_XXX schemes too.  Where the user space ABIs
are available already.  TBH, I don't know why we need these given there
are already user space ABIs.  Maybe this is a question for SeongJae too.

Best Regards,
Huang, Ying
