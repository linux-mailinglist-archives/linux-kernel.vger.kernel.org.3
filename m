Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB549E6D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbiA0P7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:59:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:17584 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbiA0P7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643299153; x=1674835153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H+/eoThfG+75X7A+Op4iugtDZzzkJmdbY8DLaA/CLPA=;
  b=fcF9PTA2Lb7QYAluYFRd2sPZArZvZb4tzXK6viPcEFoOFNg4EhlvUWfC
   Kelk4zmQ8Cg+wV21giYtCtsY97obXpEFj3Vpn2nloHgn4QZGheW74CR0g
   SKQBuJ0iOM/0OU4pb6RJ9JEf3K+/kIY90ZQV9uYjfPThSlUngHqn2Pp6J
   phYsI2LqU77iT2Awi5xVWuP/2z76NH+pvAh2oQtFwtNfR2VVddaWgFaPo
   Bv/lMxQ/Ynnz9gwBPcxq2UJtGJqrWDCAD0KDhOWSbfTzzFy3Os4WFqUYO
   zxyS6QAWr7d8ANoAdocP1mjCDW2u/IjqbPiE4OHIdrcqHcMcaf4bkdbhs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246670595"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246670595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:59:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="480345386"
Received: from anithaha-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.224.126])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:59:13 -0800
Date:   Thu, 27 Jan 2022 07:59:13 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     intel-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 02/19] dma-buf-map: Add helper to initialize
 second map
Message-ID: <20220127155913.vt7a74zmsglghzom@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
 <20220126203702.1784589-3-lucas.demarchi@intel.com>
 <b7a3fe1d-3b85-cb7e-19cf-1611ff4f3c9e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7a3fe1d-3b85-cb7e-19cf-1611ff4f3c9e@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 03:33:12PM +0100, Thomas Zimmermann wrote:
>
>
>Am 26.01.22 um 21:36 schrieb Lucas De Marchi:
>>When dma_buf_map struct is passed around, it's useful to be able to
>>initialize a second map that takes care of reading/writing to an offset
>>of the original map.
>>
>>Add a helper that copies the struct and add the offset to the proper
>>address.
>>
>>Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>Cc: Christian König <christian.koenig@amd.com>
>>Cc: linux-media@vger.kernel.org
>>Cc: dri-devel@lists.freedesktop.org
>>Cc: linaro-mm-sig@lists.linaro.org
>>Cc: linux-kernel@vger.kernel.org
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>  include/linux/dma-buf-map.h | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>>diff --git a/include/linux/dma-buf-map.h b/include/linux/dma-buf-map.h
>>index 65e927d9ce33..3514a859f628 100644
>>--- a/include/linux/dma-buf-map.h
>>+++ b/include/linux/dma-buf-map.h
>>@@ -131,6 +131,35 @@ struct dma_buf_map {
>>  		.is_iomem = false, \
>>  	}
>>+/**
>>+ * DMA_BUF_MAP_INIT_OFFSET - Initializes struct dma_buf_map from another dma_buf_map
>>+ * @map_:	The dma-buf mapping structure to copy from
>>+ * @offset:	Offset to add to the other mapping
>>+ *
>>+ * Initializes a new dma_buf_struct based on another. This is the equivalent of doing:
>>+ *
>>+ * .. code-block: c
>>+ *
>>+ *	dma_buf_map map = other_map;
>>+ *	dma_buf_map_incr(&map, &offset);
>>+ *
>>+ * Example usage:
>>+ *
>>+ * .. code-block: c
>>+ *
>>+ *	void foo(struct device *dev, struct dma_buf_map *base_map)
>>+ *	{
>>+ *		...
>>+ *		struct dma_buf_map = DMA_BUF_MAP_INIT_OFFSET(base_map, FIELD_OFFSET);
>>+ *		...
>>+ *	}
>>+ */
>>+#define DMA_BUF_MAP_INIT_OFFSET(map_, offset_)	(struct dma_buf_map)	\
>>+	{								\
>>+		.vaddr = (map_)->vaddr + (offset_),			\
>>+		.is_iomem = (map_)->is_iomem,				\
>>+	}
>>+
>
>It's illegal to access .vaddr  with raw pointer. Always use a 
>dma_buf_memcpy_() interface. So why would you need this macro when you 
>have dma_buf_memcpy_*() with an offset parameter?

I did a better job with an example in 20220127093332.wnkd2qy4tvwg5i5l@ldmartin-desk2

While doing this series I had code like this when using the API in a function to
parse/update part of the struct mapped:

	int bla_parse_foo(struct dma_buf_map *bla_map)
	{
		struct dma_buf_map foo_map = *bla_map;
		...

		dma_buf_map_incr(&foo_map, offsetof(struct bla, foo));

		...
	}

Pasting the rest of the reply here:

I had exactly this code above, but after writting quite a few patches
using it, particularly with functions that have to write to 2 maps (see
patch 6 for example), it felt much better to have something to
initialize correctly from the start

         struct dma_buf_map other_map = *bla_map;
         /* poor Lucas forgetting dma_buf_map_incr(map, offsetof(...)); */

is error prone and hard to debug since you will be reading/writting
from/to another location rather than exploding

While with the construct below

         other_map;
         ...
         other_map = INITIALIZER()

I can rely on the compiler complaining about uninitialized var. And
in most of the cases I can just have this single line in the beggining of the
function when the offset is constant:

         struct dma_buf_map other_map = INITIALIZER(bla_map, offsetof(..));


This is useful when you have several small functions in charge of
updating/reading inner struct members.

>
>I've also been very careful to distinguish between .vaddr and 
>.vaddr_iomem, even in places where I wouldn't have to. This macro 
>breaks the assumption.

That's one reason I think if we have this macro, it should be in the
dma_buf_map.h header (or whatever we rename these APIs to). It's the
only place where we can safely add code that relies on the implementation
of the "private" fields in struct dma_buf_map.

Lucas De Marchi

>
>Best regards
>Thomas
>
>>  /**
>>   * dma_buf_map_set_vaddr - Sets a dma-buf mapping structure to an address in system memory
>>   * @map:	The dma-buf mapping structure
>
>-- 
>Thomas Zimmermann
>Graphics Driver Developer
>SUSE Software Solutions Germany GmbH
>Maxfeldstr. 5, 90409 Nürnberg, Germany
>(HRB 36809, AG Nürnberg)
>Geschäftsführer: Ivo Totev



