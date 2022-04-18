Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD4505CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbiDRQx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346447AbiDRQxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3CD32EFF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650300637; x=1681836637;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=T9DgsGykPJu/61nxfr6AZYfMrvU5yqC0wpyU4UQckBs=;
  b=kbLypj4vUoXGNLt9eyOuZxrdqeuIKOvPfDhlIPpvgdMuY2aV8mBViOL/
   CrS863w/iBoECNIYkT+Rib5LHihcT9Z805geve4zYt4sD2KzwbSmPh4pM
   ydtukVBjM1rvDI3al2Q66ZzrGKlR+4u1+qT6gXmx3nd/ZGq4XVHv1b1mN
   /UNdrODQEdkrjVrM7psEHpynhwxFho6+6bi0+L4yxw6XSbBxZo7C3DTuG
   +xrvwRHoQPlxye5UHiMMWtwcH0fOTAv8UX3RLVH6QtZa0fm0zoJ+lMHa+
   uBcW5hFQ6NZRN87X2MAdTe9TesE+OpPZvfrJCjpJF0bqchE1D1QI3UuGs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="245453342"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="245453342"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 09:50:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="554310652"
Received: from cebrown-mobl.amr.corp.intel.com (HELO [10.212.18.136]) ([10.212.18.136])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 09:50:34 -0700
Message-ID: <9961bda1-687a-a681-743e-7eb7b9f6f751@intel.com>
Date:   Mon, 18 Apr 2022 09:50:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220417034932.jborenmvfbqrfhlj@offworld>
 <c1475d8e-3ad6-cdab-5cc9-b44fef998636@intel.com>
 <20220418164503.jfips3aiwhnlfjrq@offworld>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 6/6] mm/migrate: export whether or not node is toptier in
 sysf
In-Reply-To: <20220418164503.jfips3aiwhnlfjrq@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 09:45, Davidlohr Bueso wrote:
> On Mon, 18 Apr 2022, Dave Hansen wrote:
>> On 4/16/22 20:49, Davidlohr Bueso wrote:
>>> This allows userspace to know if the node is considered fast
>>> memory (with CPUs attached to it). While this can be already
>>> derived without a new file, this helps further encapsulate the
>>> concept.
>>
>> What is userspace supposed to *do* with this, though?
> 
> This came as a scratch to my own itch. I wanted to start testing
> more tiering patches overall that I see pop up, and wanted a way
> to differentiate the slow vs the fast memories in order to better
> configure workload(s) working set sizes beyond what is your typical
> grep MemTotal /proc/meminfo. If there is a better way I'm all
> for it.

But how does this help you?  Does it save you a few lines in a shell
script to find the nodes that have memory and CPUs?

>> Isn't it just asking for trouble to add (known) redundancy to the ABI?
>> It seems like a recipe for future inconsistency.
> 
> Perhaps. It was mostly about the fact that the notion of top tier
> could also change as technology evolves.

It seems like something arbitrary that everyone will just disagree on.
I think we should try to stick to cold, hard facts as must as possible
rather than trying to have the *kernel* dictate as a policy what is fast
versus slow.
