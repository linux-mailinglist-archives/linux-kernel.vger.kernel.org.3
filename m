Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA755290C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiFUBf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFUBfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:35:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324591C134
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655775355; x=1687311355;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=1sAEize2JPA180/ucIEiMx0IRlM6GKGbk0JEfZIi4tM=;
  b=XAzDm7ASzWaBK6XY+86PJamrmnm7QpiFLkwrxqUAwXd5RIv1uGX4wlzJ
   Zje3hugZBn++S+3etcjjj37yd5HjNr2fPrjF6BTr463oUwaA9gEF/L+ZK
   Qbcy98rb33Yp8I72gYsC6THfr1ZKCvTZwSVO2TbwxQv1R/eMddjxF+FZx
   m8sFeXl4dIEuOSJsXJf4z6Wf059c+YOLat54INmaBv+EJgKQvb0KXroB9
   XwXGltExpOKGL0fSx58Zxcaw4Hkxi6IHJMwco5puRZDPb2y2bYyVLicWz
   kozn/8mmYHYWScdm8lJMpmCqOZeGtqpiSP0u36VfufEAvK5wNr2iQJ1jn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="259822437"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="259822437"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:35:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="654918761"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:35:53 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
References: <20220608144031.829-1-linmiaohe@huawei.com>
        <20220608144031.829-2-linmiaohe@huawei.com>
        <87r13jrdst.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <a384f290-dff3-6dad-f1d3-8ec245b9bebd@huawei.com>
Date:   Tue, 21 Jun 2022 09:35:50 +0800
In-Reply-To: <a384f290-dff3-6dad-f1d3-8ec245b9bebd@huawei.com> (Miaohe Lin's
        message of "Mon, 20 Jun 2022 20:12:27 +0800")
Message-ID: <87letqpzm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/6/20 15:31, Huang, Ying wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> security_vm_enough_memory_mm() checks whether a process has enough memory
>>> to allocate a new virtual mapping. And total_swap_pages is considered as
>>> available memory while swapoff tries to make sure there's enough memory
>>> that can hold the swapped out memory. But total_swap_pages contains the
>>> swap space that is being swapoff. So security_vm_enough_memory_mm() will
>>> success even if there's no memory to hold the swapped out memory because
>>> total_swap_pages always greater than or equal to p->pages.
>> 
>> Per my understanding, swapoff will not allocate virtual mapping by
>> itself.  But after swapoff, the overcommit limit could be exceeded.
>> security_vm_enough_memory_mm() is used to check that.  For example, in a
>> system with 4GB memory and 8GB swap, and 10GB is in use,
>> 
>> CommitLimit:    4+8 = 12GB
>> Committed_AS:   10GB
>> 
>> security_vm_enough_memory_mm() in swapoff() will fail because
>> 10+8 = 18 > 12.  This is expected because after swapoff, the overcommit
>> limit will be exceeded.
>> 
>> If 3GB is in use,
>> 
>> CommitLimit:    4+8 = 12GB
>> Committed_AS:   3GB
>> 
>> security_vm_enough_memory_mm() in swapoff() will succeed because
>> 3+8 = 11 < 12.  This is expected because after swapoff, the overcommit
>> limit will not be exceeded.
>
> In OVERCOMMIT_NEVER scene, I think you're right.
>
>> 
>> So, what's the real problem of the original implementation?  Can you
>> show it with an example as above?
>
> In OVERCOMMIT_GUESS scene, in a system with 4GB memory and 8GB swap, and 10GB is in use,
> pages below is 8GB, totalram_pages() + total_swap_pages is 12GB, so swapoff() will succeed
> instead of expected failure because 8 < 12. The overcommit limit is always *ignored* in the
> below case.
>
> 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
> 		if (pages > totalram_pages() + total_swap_pages)
> 			goto error;
> 		return 0;
> 	}
>
> Or am I miss something?

Per my understanding, with OVERCOMMIT_GUESS, the number of in-use pages
isn't checked at all.  The only restriction is that the size of the
virtual mapping created should be less than total RAM + total swap
pages.  Because swapoff() will not create virtual mapping, so it's
expected that security_vm_enough_memory_mm() in swapoff() always
succeeds.

Best Regards,
Huang, Ying

>
> Thanks!
>
>> 
>>> In order to fix it, p->pages should be retracted from total_swap_pages
>>> first and then check whether there's enough memory for inuse swap pages.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> 
>> [snip]
>> 
>> .
>> 
