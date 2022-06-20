Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B69755118A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiFTHc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiFTHcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:32:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA0DED6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655710338; x=1687246338;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=+G28GLDrdNJ98I4YnokMT1hGC4CArBlW7m+z/O+dMU4=;
  b=lEpT+8QwSnh7czWAb+Jmokubqa8CRDubtV6YdIzaPZKIlUmTQxr4BFS+
   /7wb+cwKWpNliTdRCELGXC0jdIP+2Q9sOY8542lPvEQMVsvgjTnEzsj70
   0NcPmvJgQZhtRpYSdL0Mr7LxlocFy7m00HaqaxJzkP1vl7Do0qv3ydDPa
   stfXE428Mv/Xd+sFfTfftR5W06EnFVDGCY7dMYc1bKVL5/aAM7GNppl1k
   czhmj9RIxtuAwDl8nRjvXyWvZPy915LLsM2ZSCrmeSQ41vCIosfNHCCon
   ENoHY9y4quZ+8SWVNQuwGO6qzUYSWAmpyCrHqsEzW6cTkAMJPJA2maV3G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278600784"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278600784"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:32:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832989989"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:32:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
References: <20220608144031.829-1-linmiaohe@huawei.com>
        <20220608144031.829-2-linmiaohe@huawei.com>
Date:   Mon, 20 Jun 2022 15:31:46 +0800
In-Reply-To: <20220608144031.829-2-linmiaohe@huawei.com> (Miaohe Lin's message
        of "Wed, 8 Jun 2022 22:40:29 +0800")
Message-ID: <87r13jrdst.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> security_vm_enough_memory_mm() checks whether a process has enough memory
> to allocate a new virtual mapping. And total_swap_pages is considered as
> available memory while swapoff tries to make sure there's enough memory
> that can hold the swapped out memory. But total_swap_pages contains the
> swap space that is being swapoff. So security_vm_enough_memory_mm() will
> success even if there's no memory to hold the swapped out memory because
> total_swap_pages always greater than or equal to p->pages.

Per my understanding, swapoff will not allocate virtual mapping by
itself.  But after swapoff, the overcommit limit could be exceeded.
security_vm_enough_memory_mm() is used to check that.  For example, in a
system with 4GB memory and 8GB swap, and 10GB is in use,

CommitLimit:    4+8 = 12GB
Committed_AS:   10GB

security_vm_enough_memory_mm() in swapoff() will fail because
10+8 = 18 > 12.  This is expected because after swapoff, the overcommit
limit will be exceeded.

If 3GB is in use,

CommitLimit:    4+8 = 12GB
Committed_AS:   3GB

security_vm_enough_memory_mm() in swapoff() will succeed because
3+8 = 11 < 12.  This is expected because after swapoff, the overcommit
limit will not be exceeded.

So, what's the real problem of the original implementation?  Can you
show it with an example as above?

Best Regards,
Huang, Ying

> In order to fix it, p->pages should be retracted from total_swap_pages
> first and then check whether there's enough memory for inuse swap pages.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

[snip]
