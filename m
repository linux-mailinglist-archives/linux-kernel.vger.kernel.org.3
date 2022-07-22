Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B757DF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiGVKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiGVKOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:14:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4247694F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658484846; x=1690020846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SKPrtA2rILFUjYQxZJSiARCkKS6SUAGjnJyVAykGQWc=;
  b=ZRiHLLidczJPd5qhZH4OwhW/C5ED3xhr1iwB3odVXMNd9Tig6RCeQAPz
   TCmgOmv6hmCo+a9BxL+EMR8YQgnVKM5PnkP4orAcqXDRtQfn9XULrHz/+
   /ty7YgJu4hxhN0VJ1CaLGOAhKYLu6tqK7Nv8ll7wOBYC94iX72W9qwMNs
   UINVyEX2M2iy4mCHiMpXkZzZSFysq6/rbyxh8LAfV8AMmEgZhb7CBEvFU
   C9zjsUz8mMXlCbalsFkURCCT0LKZHseb8FxmnI581VMhO9+Nm8BxKIqDN
   UkdHT2Aa6003QGJRSK/un4jWH3EtRzmT7vUElhF5bCi8sonlCouCrXv2A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="313006451"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="313006451"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 03:14:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="574119258"
Received: from lflintof-mobl1.ger.corp.intel.com (HELO [10.213.217.10]) ([10.213.217.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 03:14:03 -0700
Message-ID: <a71371c5-8b56-a8a6-64eb-180180edfb89@linux.intel.com>
Date:   Fri, 22 Jul 2022 11:13:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/i915: stop using swiotlb
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220721174307.1085741-1-bob.beckett@collabora.com>
 <a0a7a734-d3dd-960e-f130-39f86b04b24d@linux.intel.com>
 <20220722095859.GB14113@lst.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220722095859.GB14113@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/2022 10:58, Christoph Hellwig wrote:
> On Fri, Jul 22, 2022 at 10:45:54AM +0100, Tvrtko Ursulin wrote:
>>> -	unsigned int size = swiotlb_max_segment();
>>> -
>>> -	if (size == 0)
>>> -		size = UINT_MAX;
>>
>> On a more detailed look, there was a CI failure which makes me think this
>> cap might need to stay. Because max sg segment is unsigned int. So I wonder
>> if sg contstruction overflows without it.
>>
>> If this quick analysis is right, you could leave i915_sg_segment_size
>> helper and cap the return from dma_max_mapping_size to UINT_MAX in it.
> 
> As dma_max_mapping_size retuns a size_t it would be good to make
> all variables using it a size_t as well.  In places where that gets
> lower to an unsigned int your probably want this cap.

Yep. Problem we have is struct scatterlist length field, which is 
unsigned int, since all our backing storage handling is built on top of 
it. Therefore I think capping in this helper should be good.

Regards,

Tvrtko
