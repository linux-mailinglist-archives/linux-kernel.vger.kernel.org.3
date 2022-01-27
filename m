Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4854149DD74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiA0JMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:12:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:53346 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238308AbiA0JMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643274769; x=1674810769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ypHEOArCLQ9Lqljw8MluEpZa7igABREh5sdnYemF0aQ=;
  b=YFBANs9xzBKoi2uaV2Nhe7Fbof2YyB39rAHVsFjOYsH2eiIqVP3vkBE7
   MS73Jnomn01Q/rkp9d6C6MqpDXM5SEwe+IQ0vfGWqKJWs5G9iQ61M7z+c
   2HgC5EjCWF0zr+LqO1vaa/ueTM/B38JVL+6U6L/8KjEbPkpq96tMywv8L
   r999i791uCvC0TmIXmILi4OKVXdbf6PkGHx/nGa/Kf/gntP4W+urhJrUp
   ermsfo0+HiBS0hql4I9tPtHvtr8c4AxCg1F9WvKhOnQecj0SjRuuqTyuS
   toMYavYleFQBR2XcX+BmJgWIyozWRF3Z5Az2mM5A0y07xPcg9te7V8KgI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310109592"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="310109592"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:12:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="581408612"
Received: from anithaha-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.224.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:12:48 -0800
Date:   Thu, 27 Jan 2022 01:12:47 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [Intel-gfx] [PATCH 02/19] dma-buf-map: Add helper to initialize
 second map
Message-ID: <20220127091247.3uqi5zhesqtecbsw@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
 <20220126203702.1784589-3-lucas.demarchi@intel.com>
 <f0dbdcc0-13b5-c484-0bf3-a1f8c3e48954@amd.com>
 <20220127075728.ygwgorhnrwaocdqv@ldmartin-desk2>
 <3066c6a7-fc73-d34d-d209-a3ff6818dfb6@amd.com>
 <20220127081810.6zt6cyib4s7kpa6f@ldmartin-desk2>
 <3c6a9126-bf88-0f29-425f-36748271c179@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c6a9126-bf88-0f29-425f-36748271c179@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:55:05AM +0100, Christian König wrote:
>Am 27.01.22 um 09:18 schrieb Lucas De Marchi:
>>On Thu, Jan 27, 2022 at 09:02:54AM +0100, Christian König wrote:
>>>Am 27.01.22 um 08:57 schrieb Lucas De Marchi:
>>>>On Thu, Jan 27, 2022 at 08:27:11AM +0100, Christian König wrote:
>>>>>Am 26.01.22 um 21:36 schrieb Lucas De Marchi:
>>>>>>[SNIP]
>>>>humn... not sure if I was  clear. There is no importer and 
>>>>exporter here.
>>>
>>>Yeah, and exactly that's what I'm pointing out as problem here.
>>>
>>>You are using the inter driver framework for something internal to 
>>>the driver. That is an absolutely clear NAK!
>>>
>>>We could discuss that, but you guys are just sending around 
>>>patches to do this without any consensus that this is a good idea.
>>
>>s/you guys/you/ if you have to blame anyone - I'm the only s-o-b in
>>these patches. I'm sending these to _build consensus_ on what may be 
>>a good
>>use for it showing a real problem it's helping to fix.
>
>Well a cover letter would have been helpful, my impression was that 
>you have a larger set and just want to upstream some minor DMA-buf 
>changes necessary for it.

I missed adding this sentence to the cover letter, as my impression was that
dma-buf-map was already used outside inter-driver framework. But there
is actually a cover letter:

https://lore.kernel.org/all/20220126203702.1784589-1-lucas.demarchi@intel.com/

And looking at it now, it seems I missed adding Thomas Zimmermann to Cc.

>
>Now I know why people are bugging me all the time to add cover letters 
>to add more context to my sets.
>
>>
>>From its documentation:
>>
>> * The type :c:type:`struct dma_buf_map <dma_buf_map>` and its 
>>helpers are
>> * actually independent from the dma-buf infrastructure. When 
>>sharing buffers
>> * among devices, drivers have to know the location of the memory to 
>>access
>> * the buffers in a safe way. :c:type:`struct dma_buf_map <dma_buf_map>`
>> * solves this problem for dma-buf and its users. If other drivers or
>> * sub-systems require similar functionality, the type could be 
>>generalized
>> * and moved to a more prominent header file.
>>
>>if there is no consensus and a better alternative, I'm perfectly fine in
>>throwing it out and using the better approach.
>
>When Thomas Zimmermann upstreamed the dma_buf_map work we had a 
>discussion if that shouldn't be independent of the DMA-buf framework.
>
>The consensus was that as soon as we have more widely use for it this 
>should be made independent. So basically that is what's happening now.
>
>I suggest the following approach:
>1. Find a funky name for this, something like iomem_, kiomap_ or similar.

iosys_map?

>2. Separate this from all you driver dependent work and move the 
>dma_buf_map structure out of DMA-buf into this new whatever_ prefix.

should this be a follow up to the driver work or a prerequisite?

thanks
Lucas De Marchi

>3. Ping Thomas, LKML, me and probably a couple of other core people if 
>this is the right idea or not.
>4. Work on dropping the map parameter from dma_buf_vunmap(). This is 
>basically why we can't modify the pointers returned from 
>dma_buf_vmap() and has already cause a few problems with 
>dma_buf_map_incr().
>
>Regards,
>Christian.
>
>>
>>Lucas De Marchi
>
