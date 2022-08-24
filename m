Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A659FF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiHXQLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiHXQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:11:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCD17D793;
        Wed, 24 Aug 2022 09:11:17 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCWKl1YHyz67xWY;
        Thu, 25 Aug 2022 00:10:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 18:11:15 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 17:11:14 +0100
Date:   Wed, 24 Aug 2022 17:11:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Trace General Media Event Record
Message-ID: <20220824171113.00006f80@huawei.com>
In-Reply-To: <20220813053243.757363-5-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-5-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Fri, 12 Aug 2022 22:32:38 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL v3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> 
> Determine if the event read is a general media record and if so trace
> the record.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
A few trivial things inline...

> 
> ---
> A couple of specification questions I've had.
> 
> 1) The component id is not specified as a UUID or any particular
> format.  It is therefore reported as a byte array.  Is this intentional?
Given spec gives "device specific" I'm guessing it's intentional.

> 
> 2) This record has a very odd byte layout with a 16 bit field
>    (validity_flags) landing on a 3 byte boundary and a 3 byte bit field
>    (device) landing on a 7 byte boundary.

oops. Guess 'we' weren't paying attention.  Stuck with it now.

> 
> I've made my best guess as to how the endianess of these fields should
> be resolved.  But I'm happy to hear from other folks if what I have done
> is wrong.

Mailing list probably isn't the place to look for clarification on this.

> 
> struct cxl_evt_gen_media {
> 	struct cxl_event_record_hdr hdr;
> 	__le64 phys_addr;
> 	u8 descriptor;
> 	u8 type;
> 	u8 transaction_type;
> 	u16 validity_flags;			/* ??? */
> 	u8 channel;
> 	u8 rank;
> 	u8 device[CXL_EVT_GEN_MED_DEV_SIZE];	/* ??? */
> 	u8 component_id[CXL_EVT_GEN_MED_COMP_ID_SIZE];
> } __packed;
> ---
>  drivers/cxl/core/mbox.c           |  30 ++++++-
>  drivers/cxl/cxlmem.h              |  19 +++++
>  include/trace/events/cxl-events.h | 125 ++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 493f5ceb5d1c..0e433f072163 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -709,6 +709,32 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +/*
> + * General Media Event Record
> + * CXL v3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +static const uuid_t gen_media_event_uuid =
> +	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> +
> +static void cxl_trace_event_record(const char *dev_name,
> +				   enum cxl_event_log_type type,
> +				   struct cxl_get_event_payload *payload)
> +{
> +	uuid_t *id = &payload->record.hdr.id;
> +
> +	if (uuid_equal(id, &gen_media_event_uuid)) {
> +		struct cxl_evt_gen_media *rec =
> +				(struct cxl_evt_gen_media *)&payload->record;
> +
> +		trace_cxl_gen_media_event(dev_name, type, rec);
> +		return;
> +	}
> +
> +	/* For unknown record types print just the header */
> +	trace_cxl_event(dev_name, type, &payload->record);
> +}
> +
>  static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>  				  enum cxl_event_log_type log,
>  				  __le16 handle)
> @@ -747,8 +773,8 @@ static int cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  
>  		record_count = le16_to_cpu(payload.record_count);
>  		if (record_count > 0) {
> -			trace_cxl_event(dev_name(cxlds->dev), type,
> -					&payload.record);
> +			cxl_trace_event_record(dev_name(cxlds->dev), type,
> +					       &payload);
>  			cxl_clear_event_record(cxlds, type,
>  					       payload.record.hdr.handle);
>  		}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5506e7210cf6..33669459ae4b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -402,6 +402,25 @@ struct cxl_mbox_clear_event_payload {
>  	__le16 handle;
>  };
>  
> +/*
> + * General Media Event Record
> + * CXL v3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_EVT_GEN_MED_DEV_SIZE	3
> +#define CXL_EVT_GEN_MED_COMP_ID_SIZE	0x10
> +struct cxl_evt_gen_media {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u16 validity_flags;
> +	u8 channel;
> +	u8 rank;
> +	u8 device[CXL_EVT_GEN_MED_DEV_SIZE];
> +	u8 component_id[CXL_EVT_GEN_MED_COMP_ID_SIZE];
> +} __packed;
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> index f4baeae66cf3..b51c51fd4e62 100644
> --- a/include/trace/events/cxl-events.h
> +++ b/include/trace/events/cxl-events.h
> @@ -119,6 +119,131 @@ TRACE_EVENT(cxl_event,
>  		)
>  );
>  
> +/*
> + * General Media Event Record - GMER
> + * CXL v2.0 Section 8.2.9.1.1.1; Table 154
> + */
> +#define CXL_GMER_PHYS_ADDR_VOLATILE			BIT(0)
> +#define CXL_GMER_PHYS_ADDR_MASK				0x3f

Inverse of mask is confusing. Just specify the full mask.

> +
> +#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
> +#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
> +#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
> +#define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"Uncorrectable Event"	}, \
> +	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"Threshold event"	}, \
> +	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"Poison List Overflow"	}  \
> +)
> +
> +#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
> +#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
> +#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
> +#define show_mem_event_type(type)	__print_symbolic(type,			\
> +	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
> +	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
> +	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
> +)
> +
> +#define CXL_GMER_TRANS_UNKNOWN				0x00
> +#define CXL_GMER_TRANS_HOST_READ			0x01
> +#define CXL_GMER_TRANS_HOST_WRITE			0x02
> +#define CXL_GMER_TRANS_HOST_SCAN_MEDIA			0x03
> +#define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
> +#define show_trans_type(type)	__print_symbolic(type,					\
> +	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
> +	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
> +	{ CXL_GMER_TRANS_HOST_WRITE,			"Host Write" },			\
> +	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
> +	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
> +)
> +
> +#define CXL_GMER_VALID_CHANNEL				BIT(0)
> +#define CXL_GMER_VALID_RANK				BIT(1)
> +#define CXL_GMER_VALID_DEVICE				BIT(2)
> +#define CXL_GMER_VALID_COMPONENT			BIT(3)
> +#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
> +	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
> +	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
> +	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
> +)
> +
> +TRACE_EVENT(cxl_gen_media_event,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_evt_gen_media *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		/* Common */
> +		__string(dev_name, dev_name)
> +		__field(int, log)
> +		__array(u8, id, UUID_SIZE)
> +		__field(u32, flags)
> +		__field(u16, handle)
> +		__field(u16, related_handle)
> +		__field(u64, timestamp)
> +
> +		/* General Media */
> +		__field(u64, phys_addr)
> +		__field(u8, descriptor)
> +		__field(u8, type)
> +		__field(u8, transaction_type)
> +		__field(u8, channel)
> +		__field(u32, device)
> +		__array(u8, comp_id, CXL_EVT_GEN_MED_COMP_ID_SIZE)
> +		__field(u16, validity_flags)
> +		__field(u8, rank) /* Out of order to pack trace record */
> +	),
> +
> +	TP_fast_assign(
> +		/* Common */
> +		__assign_str(dev_name, dev_name);
> +		memcpy(__entry->id, &rec->hdr.id, UUID_SIZE);
> +		__entry->log = log;
> +		__entry->flags = le32_to_cpu(rec->hdr.flags_length) >> 8;
> +		__entry->handle = le16_to_cpu(rec->hdr.handle);
> +		__entry->related_handle = le16_to_cpu(rec->hdr.related_handle);
> +		__entry->timestamp = le64_to_cpu(rec->hdr.timestamp);
> +
> +		/* General Media */
> +		__entry->phys_addr = le64_to_cpu(rec->phys_addr);
> +		__entry->descriptor = rec->descriptor;
> +		__entry->type = rec->type;
> +		__entry->transaction_type = rec->transaction_type;
> +		__entry->channel = rec->channel;
> +		__entry->rank = rec->rank;
> +		__entry->device = rec->device[0] << 24 |
> +				  rec->device[1] << 16 |
> +				  rec->device[2] << 8; /* 3 byte LE ? */
> +		__entry->device = le32_to_cpu(__entry->device);
> +		memcpy(__entry->comp_id, &rec->component_id,
> +			CXL_EVT_GEN_MED_COMP_ID_SIZE);
> +		__entry->validity_flags = le16_to_cpu(rec->validity_flags);
> +	),
> +
> +	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s': " \
> +		  "phys_addr=%llx volatile=%s desc='%s' type='%s' trans_type='%s' channel=%u " \
> +		  "rank=%u device=%x comp_id=%s valid_flags='%s'",
> +		__get_str(dev_name), show_log_type(__entry->log),
> +		__entry->timestamp, __entry->id, __entry->handle,
> +		__entry->related_handle, show_hdr_flags(__entry->flags),
> +		__entry->phys_addr & ~CXL_GMER_PHYS_ADDR_MASK,
> +		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
> +		show_event_desc_flags(__entry->descriptor),
> +		show_mem_event_type(__entry->type),
> +		show_trans_type(__entry->transaction_type),
> +		__entry->channel, __entry->rank, __entry->device,
> +		__print_hex(__entry->comp_id, CXL_EVT_GEN_MED_COMP_ID_SIZE),
> +		show_valid_flags(__entry->validity_flags)

Can we make the printing of fields with valid flags conditional?
Been a while since I wrote a Trace point, but I think I recall doing that..

> +		)
> +);
> +
>  #endif /* _CXL_TRACE_EVENTS_H */
>  
>  /* This part must be outside protection */

