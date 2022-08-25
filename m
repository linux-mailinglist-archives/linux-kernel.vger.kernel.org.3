Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334E5A0F68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiHYLiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:37:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023032B9B;
        Thu, 25 Aug 2022 04:37:46 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MD1Ch0kQQz67KVh;
        Thu, 25 Aug 2022 19:37:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 13:37:45 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 12:37:44 +0100
Date:   Thu, 25 Aug 2022 12:37:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 8/9] cxl/test: Add specific events
Message-ID: <20220825123743.00004295@huawei.com>
In-Reply-To: <20220813053243.757363-9-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-9-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 22:32:42 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Each type of event has different trace point outputs.
> 
> Add mock General Media Event, DRAM event, and Memory Module Event
> records to the mock list of events returned.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 70 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 87196d62acf5..c5d7857ae2e5 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -391,6 +391,70 @@ struct cxl_event_record_raw hardware_replace = {
>  	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
>  };
>  
> +struct cxl_evt_gen_media gen_media = {
> +	.hdr = {
> +		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> +				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> +		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_PERMANENT << 8) |
> +					     sizeof(struct cxl_evt_gen_media)),
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.phys_addr = cpu_to_le64(0x2000),
> +	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> +	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
> +	.validity_flags = cpu_to_le16(CXL_GMER_VALID_CHANNEL |
> +				      CXL_GMER_VALID_RANK),

No actual affect (I think: __put_unaligned_t is basically
forcing a packed structure element) , but put_unaligned_le16() would
make it clear this is unaligned?


> +	.channel = 1,
> +	.rank = 30
> +};
> +
> +struct cxl_evt_dram_rec dram_rec = {
> +	.hdr = {
> +		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
> +				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> +		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_PERF_DEGRADED << 8) |
> +					     sizeof(struct cxl_evt_dram_rec)),
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.phys_addr = cpu_to_le64(0x8000),
> +	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
> +	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
> +	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
> +	.validity_flags = cpu_to_le16(CXL_DER_VALID_CHANNEL |
> +				      CXL_DER_VALID_BANK_GROUP |
> +				      CXL_DER_VALID_BANK |
> +				      CXL_DER_VALID_COLUMN),
> +	.channel = 1,
> +	.bank_group = 5,
> +	.bank = 2,
> +	.column = cpu_to_le16(1024)
> +};
> +
> +struct cxl_evt_mem_mod_rec mem_mod_rec = {
> +	.hdr = {
> +		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> +				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
> +		.flags_length = cpu_to_le32(sizeof(struct cxl_evt_mem_mod_rec)),
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.event_type = CXL_MMER_TEMP_CHANGE,
> +	.info = {
> +		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
> +		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
> +		.add_status = (CXL_DHI_AS_CRITICAL << 2) |

Can we use masks + FIELD_PREP() for these rather than
magic shifts here?

> +			      (CXL_DHI_AS_WARNING << 4) |
> +			      (CXL_DHI_AS_WARNING << 5),
> +		.device_temp = cpu_to_le16(1000),
> +		.dirty_shutdown_cnt = cpu_to_le32(30000),
> +		.cor_vol_err_cnt = cpu_to_le32(30100),
> +		.cor_per_err_cnt = cpu_to_le32(40100),
> +	}
> +};
> +
>  static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
> @@ -414,8 +478,14 @@ static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
>  	es->cxlds = cxlmd->cxlds;
>  
>  	event_store_add_event(es, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	event_store_add_event(es, CXL_EVENT_TYPE_INFO,
> +			      (struct cxl_event_record_raw *)&gen_media);
> +	event_store_add_event(es, CXL_EVENT_TYPE_INFO,
> +			      (struct cxl_event_record_raw *)&mem_mod_rec);
>  
>  	event_store_add_event(es, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	event_store_add_event(es, CXL_EVENT_TYPE_FATAL,
> +			      (struct cxl_event_record_raw *)&dram_rec);
>  
>  	store_event_store(es);
>  }

