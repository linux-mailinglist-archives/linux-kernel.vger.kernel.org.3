Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EA49E63F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiA0Pio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:38:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:51298 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237732AbiA0Pik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643297920; x=1674833920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m6hvK8EvrQklv7boMPwOjx9XYUIbfEG+A3JROTW3WAY=;
  b=Et3yLFUsDxh1zEgBrQCoCE2/mrc+x4rSvpAFefm3cDopXVzxDQKzg4dX
   tzr5SDO88H9jfwnJTpRnztvUeuQxucyk6DlY2wqPNHXM2qoTtnc72OHE0
   C+Z2mBV2uSDGXVGyq5J2APf/+V9Qk89ere1y/pO0uGCMupTmyaH338Ijz
   SLtHT/5ZefPOMdQri3LxsyGQM8oE15wVGgWKK9Dfod2Gc2iSBODxR1QxO
   kC7ix0Yys/KLm3CMK90TVAweDAHfq7VXeVozn0oyhR4AH0Qygq9ztgD+r
   ucVoI4bNUXvbl/s7yRj0v1za1nKVNc8Ag/aUj3gUkDJknonv6YFCQwquk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226862372"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226862372"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:38:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="767547488"
Received: from anithaha-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.224.126])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:38:39 -0800
Date:   Thu, 27 Jan 2022 07:38:38 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     intel-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 09/19] dma-buf-map: Add wrapper over memset
Message-ID: <20220127153838.eefwiqkljdplyfd4@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
 <20220126203702.1784589-10-lucas.demarchi@intel.com>
 <7cb8a8a2-718d-6d5c-5de6-05bf990dd479@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cb8a8a2-718d-6d5c-5de6-05bf990dd479@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 03:54:21PM +0100, Thomas Zimmermann wrote:
>Hi
>
>Am 26.01.22 um 21:36 schrieb Lucas De Marchi:
>>Just like memcpy_toio(), there is also need to write a direct value to a
>>memory block. Add dma_buf_map_memset() to abstract memset() vs memset_io()
>>
>>Cc: Matt Roper <matthew.d.roper@intel.com>
>>Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>Cc: Christian König <christian.koenig@amd.com>
>>Cc: linux-media@vger.kernel.org
>>Cc: dri-devel@lists.freedesktop.org
>>Cc: linaro-mm-sig@lists.linaro.org
>>Cc: linux-kernel@vger.kernel.org
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>  include/linux/dma-buf-map.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>>diff --git a/include/linux/dma-buf-map.h b/include/linux/dma-buf-map.h
>>index 3514a859f628..c9fb04264cd0 100644
>>--- a/include/linux/dma-buf-map.h
>>+++ b/include/linux/dma-buf-map.h
>>@@ -317,6 +317,23 @@ static inline void dma_buf_map_memcpy_to(struct dma_buf_map *dst, const void *sr
>>  		memcpy(dst->vaddr, src, len);
>>  }
>>+/**
>>+ * dma_buf_map_memset - Memset into dma-buf mapping
>>+ * @dst:	The dma-buf mapping structure
>>+ * @value:	The value to set
>>+ * @len:	The number of bytes to set in dst
>>+ *
>>+ * Set value in dma-buf mapping. Depending on the buffer's location, the helper
>>+ * picks the correct method of accessing the memory.
>>+ */
>>+static inline void dma_buf_map_memset(struct dma_buf_map *dst, int value, size_t len)
>>+{
>>+	if (dst->is_iomem)
>>+		memset_io(dst->vaddr_iomem, value, len);
>>+	else
>>+		memset(dst->vaddr, value, len);
>>+}
>
>Maybe add an offset parameter here.

yep, on v2 I will have 2 APIs, one with and one without offset.

thanks
Lucas De Marchi

>
>Best regards
>Thomas
>
>>+
>>  /**
>>   * dma_buf_map_incr - Increments the address stored in a dma-buf mapping
>>   * @map:	The dma-buf mapping structure
>
>-- 
>Thomas Zimmermann
>Graphics Driver Developer
>SUSE Software Solutions Germany GmbH
>Maxfeldstr. 5, 90409 Nürnberg, Germany
>(HRB 36809, AG Nürnberg)
>Geschäftsführer: Ivo Totev



