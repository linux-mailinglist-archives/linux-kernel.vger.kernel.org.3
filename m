Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCDC59FECC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiHXPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiHXPvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:51:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060EB51A2D;
        Wed, 24 Aug 2022 08:51:01 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCVtV46DLz67Q7R;
        Wed, 24 Aug 2022 23:50:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:50:59 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 16:50:59 +0100
Date:   Wed, 24 Aug 2022 16:50:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <20220824165058.00007d4f@huawei.com>
In-Reply-To: <20220813053243.757363-2-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-2-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Fri, 12 Aug 2022 22:32:35 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Event records are defined for CXL devices.  Each record is reported in
> one event log.  Devices are required to support the storage of at least
> one event record in each event log type.
Hi Ira,

Someone went and slipped in a new field in CXL r3.0.  Might be easier
just to add it now?

A few other comments inline.

> 
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
> 
> Software queries events via the Get Event Record mailbox command; CXL
> v3.0 section 8.2.9.2.2.
rev3.0

You reference 3.0 but use 2.0 definitions below (I'm guessing this crossed
with spec release).

> 
> Issue the Get Event Record mailbox command on driver load.  Trace each
> record found, as well as any overflow conditions.  Only 1 event is
> requested for each query.  Optimization of multiple record queries is
> deferred.
I'd be tempted to make it easier by using a variable sized fail element and
an allocation, but fair enough that can come later.

> 
> This patch traces a raw event record only and leaves the specific event
> record types to subsequent patches.
> 
> NOTE: checkpatch is not completely happy with the tracing part of this
> patch but AFAICT it is correct.  I'm open to suggestions if I've done
> something wrong.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>


> ---
>  MAINTAINERS                       |   1 +
>  drivers/cxl/core/mbox.c           |  60 ++++++++++++++
>  drivers/cxl/cxlmem.h              |  66 ++++++++++++++++
>  include/trace/events/cxl-events.h | 127 ++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h      |   1 +
>  5 files changed, 255 insertions(+)
>  create mode 100644 include/trace/events/cxl-events.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 54fa6e2059de..1cb9cec31009 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5014,6 +5014,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
> +F:	include/trace/events/cxl*.h
>  F:	include/uapi/linux/cxl_mem.h
>  
>  CONEXANT ACCESSRUNNER USB DRIVER
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 16176b9278b4..2cceed8608dc 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -7,6 +7,9 @@
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/cxl-events.h>
> +
>  #include "core.h"
>  
>  static bool cxl_raw_allow_all;
> @@ -48,6 +51,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> +	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> @@ -704,6 +708,62 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				   enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload payload;
> +
> +	do {
> +		u8 log_type = type;
> +		u16 record_count;
> +		int rc;
> +
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> +				       &log_type, sizeof(log_type),
> +				       &payload, sizeof(payload));
> +		if (rc)
> +			return rc;
> +
> +		record_count = le16_to_cpu(payload.record_count);
> +		if (record_count > 0)

If it is anything other than 1 you have a problem..  So fornow
I would check for that.

> +			trace_cxl_event(dev_name(cxlds->dev), type,
> +					&payload.record);
> +
> +		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> +			trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> +						 &payload);
> +
> +	} while (payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device and report them as trace
> + * events.
> + *
> + * See CXL v3.0 @8.2.9.2.2 Get Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	enum cxl_event_log_type log_type;
> +
> +	for (log_type = CXL_EVENT_TYPE_INFO;
> +	     log_type < CXL_EVENT_TYPE_MAX; log_type++) {
> +		int rc;
> +
> +		rc = cxl_mem_get_records_log(cxlds, log_type);
> +		if (rc)
> +			dev_err(dev, "Failed to query %s Event Logs : %d",
> +				cxl_event_log_type_str(log_type), rc);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..f83634f3bc8d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -4,6 +4,7 @@
>  #define __CXL_MEM_H__
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
> +#include <linux/uuid.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -253,6 +254,7 @@ struct cxl_dev_state {
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -322,6 +324,69 @@ struct cxl_mbox_identify {
>  	u8 qos_telemetry_caps;
>  } __packed;
>  
> +/*
> + * Common Event Record Format
> + * CXL v3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct cxl_event_record_hdr {
> +	uuid_t id;
> +	__le32 flags_length;

Can you split this into a u8 and
u8[3] then use the get_unaligned_le24 accessor
where appropriate? Oh for 24bit types ;)

> +	__le16 handle;
> +	__le16 related_handle;
> +	__le64 timestamp;
> +	__le64 reserved1;

As below. Maintenance op from CXL 3.0?  Seems easy
to add now rather than needing a change later.

> +	__le64 reserved2;
> +} __packed;
> +
> +#define EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +	struct cxl_event_record_hdr hdr;
> +	u8 data[EVENT_RECORD_DATA_LENGTH];
> +} __packed;
> +
> +/*
> + * Get Event Records output payload
> + * CXL v3.0 section 8.2.9.2.2; Table 8-50

r3.0 :) (just drop the v and go with 3.0 would be my preference).

> + *
> + * Space given for 1 record
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS	BIT(1)
> +struct cxl_get_event_payload {
> +	u8 flags;
> +	u8 reserved1;
> +	__le16 overflow_err_count;
> +	__le64 first_overflow_timestamp;
> +	__le64 last_overflow_timestamp;
> +	__le16 record_count;
> +	u8 reserved2[0xa];
> +	struct cxl_event_record_raw record;
> +} __packed;
> +
> +enum cxl_event_log_type {
> +	CXL_EVENT_TYPE_INFO = 0x00,
> +	CXL_EVENT_TYPE_WARN,
> +	CXL_EVENT_TYPE_FAIL,
> +	CXL_EVENT_TYPE_FATAL,

Worth putting Dynamic capacity in now? Up to you.

> +	CXL_EVENT_TYPE_MAX
> +};

Blank line for readability.

> +static inline char *cxl_event_log_type_str(enum cxl_event_log_type type)
> +{
> +	switch (type) {
> +	case CXL_EVENT_TYPE_INFO:
> +		return "Informational";
> +	case CXL_EVENT_TYPE_WARN:
> +		return "Warning";
> +	case CXL_EVENT_TYPE_FAIL:
> +		return "Failure";
> +	case CXL_EVENT_TYPE_FATAL:
> +		return "Fatal";
> +	default:
> +		break;
> +	}
> +	return "<unknown>";
> +}
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> @@ -381,6 +446,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> new file mode 100644
> index 000000000000..f4baeae66cf3
> --- /dev/null
> +++ b/include/trace/events/cxl-events.h
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl_events
> +
> +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_EVENTS_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define EVENT_LOGS					\
> +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
> +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
> +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
> +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
> +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")

Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
dynamic capacity events so I guess it doesn't matter.

> +
> +/*
> + * First define the enums in the above macros to be exported to userspace via
> + * TRACE_DEFINE_ENUM().
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)	TRACE_DEFINE_ENUM(a);
> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
> +
> +EVENT_LOGS
> +#define show_log_type(type) __print_symbolic(type, EVENT_LOGS)
> +
> +/*
> + * Now redefine the EM and EMe macros to map the enums to the strings that will
> + * be printed in the output
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)        {a, b},
> +#define EMe(a, b)       {a, b}
> +
> +TRACE_EVENT(cxl_event_overflow,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_get_event_payload *payload),
> +
> +	TP_ARGS(dev_name, log, payload),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(int, log)
> +		__field(u16, count)
> +		__field(u64, first)
> +		__field(u64, last)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__entry->log = log;
> +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> +		__entry->first = le64_to_cpu(payload->first_overflow_timestamp);
> +		__entry->last = le64_to_cpu(payload->last_overflow_timestamp);
> +	),
> +
> +	TP_printk("%s: EVENT LOG %s OVERFLOW %u records from %llu to %llu",
> +		__get_str(dev_name), show_log_type(__entry->log),
> +		__entry->count, __entry->first, __entry->last)
> +
> +);
> +
> +/*
> + * Common Event Record Format
> + * CXL v2.0 section 8.2.9.1.1; Table 153
> + */
> +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"Permanent Condition"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"Maintanance Needed"		}, \

Maintenance

> +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> +)
> +
> +TRACE_EVENT(cxl_event,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_record_raw *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(int, log)
> +		__array(u8, id, UUID_SIZE)
> +		__field(u32, flags)
> +		__field(u16, handle)
> +		__field(u16, related_handle)
> +		__field(u64, timestamp)
> +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
> +		__field(u8, length)

Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
(only noticed because I happen to have that spec revision open rather than 2.0).

> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		memcpy(__entry->id, &rec->hdr.id, UUID_SIZE);
> +		__entry->log = log;
> +		__entry->flags = le32_to_cpu(rec->hdr.flags_length) >> 8;
> +		__entry->length = le32_to_cpu(rec->hdr.flags_length) & 0xFF;
> +		__entry->handle = le16_to_cpu(rec->hdr.handle);
> +		__entry->related_handle = le16_to_cpu(rec->hdr.related_handle);
> +		__entry->timestamp = le64_to_cpu(rec->hdr.timestamp);
> +		memcpy(__entry->data, &rec->data, EVENT_RECORD_DATA_LENGTH);
> +	),
> +
> +	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s' " \
> +		  ": %s",
> +		__get_str(dev_name), show_log_type(__entry->log),
> +		__entry->timestamp, __entry->id, __entry->handle,
> +		__entry->related_handle, show_hdr_flags(__entry->flags),
> +		__print_hex(__entry->data, EVENT_RECORD_DATA_LENGTH)
> +		)
> +);
> +
> +#endif /* _CXL_TRACE_EVENTS_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl-events
> +#include <trace/define_trace.h>
