Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EDA4A9A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358909AbiBDNkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:40:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4675 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiBDNkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:40:19 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JqxV458l2z67LtG;
        Fri,  4 Feb 2022 21:39:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 14:40:17 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 13:40:16 +0000
Date:   Fri, 4 Feb 2022 13:40:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 10/10] cxl/cdat: Parse out DSMAS data from CDAT table
Message-ID: <20220204134013.000076fc@Huawei.com>
In-Reply-To: <20220201071952.900068-11-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-11-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.86]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 23:19:52 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL memory devices need the information in the Device Scoped Memory
> Affinity Structure (DSMAS).  This information is contained within the
> CDAT table buffer which is already read and cached.
> 
> Parse and cache DSMAS data from the CDAT table.  Store this data in
> unmarshaled struct dsmas data structures for ease of use.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

A few suggests inline but this basically looks good to me.
I'll hold off on tags until we resolve the warn or not question
Ben raised.

> 
> ---
> Changes from V5
> 	Fix up sparse warnings
> 	Split out cdat_hdr_valid()
> 	Update cdat_hdr_valid()
> 		Remove revision and cs field parsing
> 			There is no point in these
> 		Add seq check and debug print.
> 	From Jonathan
> 		Add spaces around '+' and '/'
> 		use devm_krealloc() for dmas_ary
> 
> Changes from V4
> 	New patch
> ---
>  drivers/cxl/cdat.h        | 21 ++++++++++++
>  drivers/cxl/core/memdev.c | 70 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> index a7725d26f2d2..f8c126190d18 100644
> --- a/drivers/cxl/cdat.h
> +++ b/drivers/cxl/cdat.h
> @@ -83,17 +83,38 @@
>  #define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
>  #define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
>  
> +/**
> + * struct cxl_dsmas - host unmarshaled version of DSMAS data
> + *
> + * As defined in the Coherent Device Attribute Table (CDAT) specification this
> + * represents a single DSMAS entry in that table.
> + *
> + * @dpa_base: The lowest DPA address associated with this DSMAD
> + * @dpa_length: Length in bytes of this DSMAD
> + * @non_volatile: If set, the memory region represents Non-Volatile memory
> + */
> +struct cxl_dsmas {
> +	u64 dpa_base;
> +	u64 dpa_length;
> +	/* Flags */
> +	u8 non_volatile:1;
> +};
> +
>  /**
>   * struct cxl_cdat - CXL CDAT data
>   *
>   * @table: cache of CDAT table
>   * @length: length of cached CDAT table
>   * @seq: Last read Sequence number of the CDAT table
> + * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
> + * @nr_dsmas: Number of entries in dsmas_ary
>   */
>  struct cxl_cdat {
>  	void *table;
>  	size_t length;
>  	u32 seq;
> +	struct cxl_dsmas *dsmas_ary;
> +	int nr_dsmas;
>  };
>  
>  #endif /* !__CXL_CDAT_H__ */
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 11d721c56f08..32342a15e991 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -6,6 +6,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include "cdat.h"
>  #include "core.h"
>  
>  static DECLARE_RWSEM(cxl_memdev_rwsem);
> @@ -386,6 +387,71 @@ static int read_cdat_data(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +static int parse_dsmas(struct cxl_memdev *cxlmd)

Looking forwards, it's more than possible this code might be of
use for type2 devices.  As such, maybe it should avoid
taking the cxlmd as a parameter?  Really need a dev for the
allocations, and the cdat structure.

Could fix that up once someone else wants it of course.

> +{
> +	struct cxl_dsmas *dsmas_ary = NULL;
> +	u32 *data = cxlmd->cdat.table;
> +	int bytes_left = cxlmd->cdat.length;
> +	int nr_dsmas = 0;
> +
> +	if (!data)
> +		return -ENXIO;
> +
> +	/* Skip header */
> +	data += CDAT_HEADER_LENGTH_DW;
> +	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
> +
> +	while (bytes_left > 0) {
> +		u32 *cur_rec = data;
> +		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
> +		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
> +
> +		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {

Again, maybe something to do later, but a
for_each_cdat_struct() loop (possibly with a type specified) would
give us something we are sure to want later when doing switches etc.

> +			struct cxl_dsmas *new_ary;
> +			u8 flags;
> +
> +			new_ary = devm_krealloc(&cxlmd->dev, dsmas_ary,
> +					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
> +					   GFP_KERNEL);
> +			if (!new_ary) {
> +				dev_err(&cxlmd->dev,
> +					"Failed to allocate memory for DSMAS data\n");
> +				return -ENOMEM;
> +			}
> +			dsmas_ary = new_ary;
> +
> +			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
> +
> +			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
> +			dsmas_ary[nr_dsmas].dpa_length = CDAT_DSMAS_DPA_LEN(cur_rec);
> +			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
> +
> +			dev_dbg(&cxlmd->dev, "DSMAS %d: %llx:%llx %s\n",
> +				nr_dsmas,
> +				dsmas_ary[nr_dsmas].dpa_base,
> +				dsmas_ary[nr_dsmas].dpa_base +
> +					dsmas_ary[nr_dsmas].dpa_length,
> +				(dsmas_ary[nr_dsmas].non_volatile ?
> +					"Persistent" : "Volatile")
> +				);
> +
> +			nr_dsmas++;
> +		}
> +
> +		data += (length / sizeof(u32));
> +		bytes_left -= length;
> +	}
> +
> +	if (nr_dsmas == 0)
> +		return -ENXIO;
> +
> +	dev_dbg(&cxlmd->dev, "Found %d DSMAS entries\n", nr_dsmas);
> +	cxlmd->cdat.dsmas_ary = dsmas_ary;
> +	cxlmd->cdat.nr_dsmas = nr_dsmas;
> +
> +	return 0;
> +}
> +
