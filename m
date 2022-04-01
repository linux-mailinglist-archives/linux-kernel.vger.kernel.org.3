Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39BC4EE89B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbiDAGpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344290AbiDAGnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:43:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE458E41
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648795252; x=1680331252;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=F2u5reVKngNG7rsHH+KeIseuLTsishF5Wx5rk2BYJhQ=;
  b=dTQ0XEX8EAfSqdpMV4dvHIR7aNwPfceMrbpQbBlozop1SIO8tXrjIEQK
   jhRsnPCu4OI+rIifV6rhlck6pzpeBKJ92KV/Gp/mfPhFUNvk1ABEK3dPX
   3S2uE/czc9IhXgMZfJ3WhJ7ysw+5xB0e02XpRw6i+2a7V4CEO7Cy8uIPE
   LhrYBMdO8sU/BBpZgige/8fcpXsua+Eo26hHFwxHeKIY6LTExRLz6fw3h
   bWSKnuOgw7el3oK3JhsdBmV41XIz6p5MR7ZLhAXS/e9WrSMwjvGAJANB0
   g7NtSPSYJp4nl3zLqWJDN6CJes+CXSqsLNjSaOSQkpWli7nXBY6j1tK7Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="258884663"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="258884663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 23:40:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="522659774"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 23:40:38 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 5/8] mm/vmscan: use helper folio_is_file_lru()
References: <20220329132619.18689-1-linmiaohe@huawei.com>
        <20220329132619.18689-6-linmiaohe@huawei.com>
        <87y20pa3r6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <191fa86c-2548-d136-19f5-3e0a744b6da9@huawei.com>
Date:   Fri, 01 Apr 2022 14:40:36 +0800
In-Reply-To: <191fa86c-2548-d136-19f5-3e0a744b6da9@huawei.com> (Miaohe Lin's
        message of "Fri, 1 Apr 2022 14:14:49 +0800")
Message-ID: <87tubd9uhn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/4/1 11:20, Huang, Ying wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> Use helper folio_is_file_lru() to check whether folio is file lru. Minor
>>> readability improvement.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/vmscan.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index ebd8ffb63673..31e95d627448 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1411,14 +1411,14 @@ static enum page_references folio_check_references(struct folio *folio,
>>>  		/*
>>>  		 * Activate file-backed executable folios after first usage.
>>>  		 */
>>> -		if ((vm_flags & VM_EXEC) && !folio_test_swapbacked(folio))
>>> +		if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio))
>> 
>> I think that this should be converted to
>> 
>> 		if ((vm_flags & VM_EXEC)))
>> 
>> We should activate swap-backed executable folios (e.g. tmpfs) after
>> first usage too.
>> 
>
> Dig into the git history, we can found that commit c909e99364c8 ("vmscan: activate executable pages after first usage")
> activate swap-backed executable folios after first usage too. But later swap-backed executable folios is not activated
> via commit b518154e59aa ("mm/vmscan: protect the workingset on anonymous LRU") to pretect the workingset from anonymous
> LRU. So above change might not be wanted. Or am I miss something?

I think we should restore the original behavior to protect swap backed
executable folios too.

Hi, Kim,

What do you think about this?

Best Regards,
Huang, Ying

> Many thanks.
>
>> Best Regards,
>> Huang, Ying
>> 
>>>  			return PAGEREF_ACTIVATE;
>>>  
>>>  		return PAGEREF_KEEP;
>>>  	}
>>>  
>>>  	/* Reclaim if clean, defer dirty folios to writeback */
>>> -	if (referenced_folio && !folio_test_swapbacked(folio))
>>> +	if (referenced_folio && folio_is_file_lru(folio))
>>>  		return PAGEREF_RECLAIM_CLEAN;
>>>  
>>>  	return PAGEREF_RECLAIM;
>> .
>> 
