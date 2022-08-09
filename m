Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED4758D848
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbiHILhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242370AbiHILhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:37:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB01224958
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660045021; x=1691581021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X/dHIiLosgMB7zWLY1AkVGmw+kNUfgf9G3XdNu373VA=;
  b=GxvSs66eRYT/PsORsxo+9KFeJykHTTsy7gdfRn6CebpeZ5Uzy4UOvujY
   uvy2+2cQJymrPa1zitLPS48lOSE3W9FLIqTeaN0G/RJ9jHrajRdqUxh+l
   2chGSqQnkW1XpCthinYlW8Kw60Rc1uyFraFpfBI93GtmdLPh5kUU7wNVp
   gmAZMRNT0KnOrA70woMZmWO55Xcx9TPL4RZgfrDEi9JAiXUhF/dUa3foP
   lcyFmGnRUOSq+6+oeJiDbucUqmOTQVVmE3l3Tt1KZWgj1kOPVp8tm0ix1
   j4x+OEb8yXxVQflEulaGLMsiIbdoMuYMqm9hqVUu37JeOLPRXtrlcxU01
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352543447"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="352543447"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:37:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="747008545"
Received: from mram-mobl1.amr.corp.intel.com (HELO [10.213.184.71]) ([10.213.184.71])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:36:59 -0700
Message-ID: <db9f787e-c3e4-d353-da57-80cb7a135d86@linux.intel.com>
Date:   Tue, 9 Aug 2022 12:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] drm/i915: stop using swiotlb
Content-Language: en-US
To:     "Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "bob.beckett@collabora.com" <bob.beckett@collabora.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>
Cc:     "hch@lst.de" <hch@lst.de>,
        "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Auld, Matthew" <matthew.auld@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
References: <20220726153935.2272777-1-bob.beckett@collabora.com>
 <1160a7c31084ab2259088e4bfe88b41ad61c2bcc.camel@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <1160a7c31084ab2259088e4bfe88b41ad61c2bcc.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/08/2022 16:48, Hellstrom, Thomas wrote:
> Hi, [back from vacation]
> 
> On Tue, 2022-07-26 at 16:39 +0100, Robert Beckett wrote:
>> Calling swiotlb functions directly is nowadays considered harmful.
>> See
>> https://lore.kernel.org/intel-gfx/20220711082614.GA29487@lst.de/
>>
>> Replace swiotlb_max_segment() calls with dma_max_mapping_size().
>> In i915_gem_object_get_pages_internal() no longer consider
>> max_segment
>> only if CONFIG_SWIOTLB is enabled. There can be other (iommu related)
>> causes of specific max segment sizes.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>>
>> v2: - restore UINT_MAX clamp in i915_sg_segment_size()
>>      - drop PAGE_SIZE check as it will always be >= PAGE_SIZE
>> v3: - actually clamp to UINT_MAX in i915_sg_segment_size()
>> v4: - round down max segment size to PAGE_SIZE
>> v5: - fix checkpatch whitespace issue
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> 
> Hmm,
> 
> This whole thing looks a bit strange to me since with SWIOTLB actually
> used for i915, the driver should malfunction anyway as it doesn't do
> any dma_sync_sg_for_cpu() or dma_sync_sg_for_device(), and the driver
> assumes all coherent dma. Is that SWIOTLB=force kernel option still
> available?

Don't know about these - but pretty sure in the past we had i915 break 
if we did not respect swiotlb_max_segment.

Digging through git history at least running as Xen dom0 looks to have 
been impacted, but commits such as abb0deacb5a6 ("drm/i915: Fallback to 
single PAGE_SIZE segments for DMA remapping") are older and suggest 
problem was generic. 1625e7e549c5 ("drm/i915: make compact dma scatter 
lists creation work with SWIOTLB backend.") as well. So it looks it did 
work behind swiotlb despite those missing calls you highlighted.

> Also, correct me if I'm wrong, but the original driver segment size
> appears to mean "the largest contiguous area that can be handled either
> by the device or the dma mapping layer" rather than the total space
> available for dma mappings? Not completely sure what
> dma_max_mapping_size() is returning, though?

AFAIU looks to be compatible on paper at least.:

dma_max_mapping_size -> "Returns the maximum size of a mapping for the 
device."

So an individual mapping.

But then in case of swiotlb is implemented in swiotlb_max_mapping_size, 
and not the same code as swiotlb_max_segment. I agree, ideally if 
someone could clarify they are returning the same thing or there is a 
miss somewhere.

Regards,

Tvrtko
