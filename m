Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6FF52F634
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354116AbiETXcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348253AbiETXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:32:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873A019FF7E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653089553; x=1684625553;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nlqrTymAHeI9jw2VarrArEVOw1HPczPiwh10VKEkDxg=;
  b=DswjfxU5Vee2rYIDpWs495JPT61JwL/MGesl5FUYI13637eenaKO9xK8
   IQb75Xj7KD8+caKRqiIEAKTsFDnrOwmmbhOpdPr1L5w29yd5dznsGvlKu
   1o/Nw+PEXAatJNpeNRBu2UzR7QdPT/vNqxeA3R0ycB1wuY/PJkeyPoYVi
   uXPvzMv28xp/nDtNTRVMxyVDFnUrEwOLq06XZMCz0bc8i+H6sJg1NzTkn
   rpEu3D5F5SnY801SZoTV9763BbDu8EyXkTnPIREdpYjU6rViAuXxDu4+Y
   bDAZVJbEvicaCyX8Xdc8uRptlj/vCnA9iJ6+gEl8ZGAxYTDuLTLhvqK77
   A==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; 
   d="scan'208";a="200966285"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:32:31 +0800
IronPort-SDR: FYPT8ZK3enhsBUZSijkauDKIlyPGYwGNI+sRpxf89vv0G73aQ1zPMS4H1078oBeXq1TS8HnxjC
 iPhRNS87ly3M/Y5pdLHM6NQ2pMfjj5aTZk/b9XAmCqfRb2ujVOFFHqT4z5vZObMMXmaawh8nGb
 NYLkemylFAeVW3lCQ8B8E0o2xLvclTTF9my2qdACxSygsOmoVCzkfxK2qv11CRZX94ROGQ3w+s
 lRp9u1VErmQpmwzIQYAUqIg7CN//DVfvm9K5OXskZ6PX8tshSSuMi3PXyssGoP7dOMO27CLDl0
 fdZzH0wZv6YCmOvfprmWfPIj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 15:57:54 -0700
IronPort-SDR: SC3YldUTiTNboEz9x+yQ9YJaS7h9Nb7UUV4toEdKX4PSoWssUxUwKfulYMm9fLVqoBikKQpU2s
 ScJ7Ns6SaVNCxXAaEpKKfW1aS5y9sOKQGtVYpFRXwAwDLcLy0wzfkkn523h7W5MW4hxPO8Zlua
 hyANIOh2L1jwxybZotU4BtSMTKHlPcWXKTVtuqfDWdPCUjtYpor4ndvLFdW2HIFYwJa09PSBIe
 Sc911WRgw96vSc0KHOUgdj5nlGTqtj77hdPx24UjYZbwzYyDTsi9BvQK7bWNCMr2kUpNSLHv04
 cmM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 16:32:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jgh1qXLz1SVp2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:32:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653089551; x=1655681552; bh=nlqrTymAHeI9jw2VarrArEVOw1HPczPiwh1
        0VKEkDxg=; b=EdV2FxZidnZiv8fZT8Mv8bveSXH46h+c2KjLhAttf5g2dKfMwQl
        cJja6NwxT66QwCkiZXS+GST0N1x8SUxakoOOENSOVBCMD0yvfXUjjSG4qWuvJD9M
        KW+zbDNZSJRsBqIOJEMlBAJ9cMijNxN0nq+JsdT1h/Lvvnes8wHFtiP1+L9lTtgY
        PCMkxSADkwb5YB1kVC8Lx0OUrfZiyxf3ovjjat6j5ooV2PlW2oFulowqBVxfptQF
        wCKFqAcJgWv7UkbOOA3+jf2AWosW7eNuSPR4k6ZG+5ljypSWHG2emM4ZPIu9REUC
        PtE9ztTvY5KCFWCZByOd/rGIswaqiKRCJNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZKuX0mw-G9ih for <linux-kernel@vger.kernel.org>;
        Fri, 20 May 2022 16:32:31 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jgc191Pz1Rvlc;
        Fri, 20 May 2022 16:32:27 -0700 (PDT)
Message-ID: <8f46233b-9905-c35b-0d27-00c9af729195@opensource.wdc.com>
Date:   Sat, 21 May 2022 08:32:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] dma-mapping: Add dma_opt_mapping_size()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 17:23, John Garry wrote:
> Streaming DMA mapping involving an IOMMU may be much slower for larger
> total mapping size. This is because every IOMMU DMA mapping requires an
> IOVA to be allocated and freed. IOVA sizes above a certain limit are not
> cached, which can have a big impact on DMA mapping performance.
> 
> Provide an API for device drivers to know this "optimal" limit, such that
> they may try to produce mapping which don't exceed it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  Documentation/core-api/dma-api.rst |  9 +++++++++
>  include/linux/dma-map-ops.h        |  1 +
>  include/linux/dma-mapping.h        |  5 +++++
>  kernel/dma/mapping.c               | 12 ++++++++++++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 6d6d0edd2d27..b3cd9763d28b 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -204,6 +204,15 @@ Returns the maximum size of a mapping for the device. The size parameter
>  of the mapping functions like dma_map_single(), dma_map_page() and
>  others should not be larger than the returned value.
>  
> +::
> +
> +	size_t
> +	dma_opt_mapping_size(struct device *dev);
> +
> +Returns the maximum optimal size of a mapping for the device. Mapping large
> +buffers may take longer so device drivers are advised to limit total DMA
> +streaming mappings length to the returned value.
> +
>  ::
>  
>  	bool
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d5b06b3a4a6..98ceba6fa848 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -69,6 +69,7 @@ struct dma_map_ops {
>  	int (*dma_supported)(struct device *dev, u64 mask);
>  	u64 (*get_required_mask)(struct device *dev);
>  	size_t (*max_mapping_size)(struct device *dev);
> +	size_t (*opt_mapping_size)(void);
>  	unsigned long (*get_merge_boundary)(struct device *dev);
>  };
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index dca2b1355bb1..fe3849434b2a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -144,6 +144,7 @@ int dma_set_mask(struct device *dev, u64 mask);
>  int dma_set_coherent_mask(struct device *dev, u64 mask);
>  u64 dma_get_required_mask(struct device *dev);
>  size_t dma_max_mapping_size(struct device *dev);
> +size_t dma_opt_mapping_size(struct device *dev);
>  bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
>  unsigned long dma_get_merge_boundary(struct device *dev);
>  struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
> @@ -266,6 +267,10 @@ static inline size_t dma_max_mapping_size(struct device *dev)
>  {
>  	return 0;
>  }
> +static inline size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	return 0;
> +}
>  static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>  {
>  	return false;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index db7244291b74..1bfe11b1edb6 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -773,6 +773,18 @@ size_t dma_max_mapping_size(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>  
> +size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	size_t size = SIZE_MAX;
> +
> +	if (ops && ops->opt_mapping_size)
> +		size = ops->opt_mapping_size();
> +
> +	return min(dma_max_mapping_size(dev), size);
> +}
> +EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> +
>  bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
