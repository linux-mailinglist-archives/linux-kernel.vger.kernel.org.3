Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B455B1DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiIHMwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIHMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:52:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F10D51FA;
        Thu,  8 Sep 2022 05:52:45 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MNf7R3Nt2z67n8d;
        Thu,  8 Sep 2022 20:48:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:52:42 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Sep
 2022 13:52:42 +0100
Date:   Thu, 8 Sep 2022 13:52:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <20220908135240.00001217@huawei.com>
In-Reply-To: <Yxgd51zdrk9pEXE6@iweiny-mobl>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-2-ira.weiny@intel.com>
        <20220824165058.00007d4f@huawei.com>
        <Yxgd51zdrk9pEXE6@iweiny-mobl>
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


> > > +static int cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > > +				   enum cxl_event_log_type type)
> > > +{
> > > +	struct cxl_get_event_payload payload;
> > > +
> > > +	do {
> > > +		u8 log_type = type;
> > > +		u16 record_count;
> > > +		int rc;
> > > +
> > > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> > > +				       &log_type, sizeof(log_type),
> > > +				       &payload, sizeof(payload));
> > > +		if (rc)
> > > +			return rc;
> > > +
> > > +		record_count = le16_to_cpu(payload.record_count);
> > > +		if (record_count > 0)  
> > 
> > If it is anything other than 1 you have a problem..  So fornow
> > I would check for that.  
> 
> I assume you mean if there are any records at all?  For the next version I've
> checked for 1 here but 0 is also valid if there are no records to return.  So
> != 1 is not an error.

Yes, I must meant if (record_count == 1)
for this case..

> 
> (Currently all logs are checked when the event records are queried and some may
> be empty.  I don't plan on trying to distinguish the various interrupts.)
> 
> >   
> > > +			trace_cxl_event(dev_name(cxlds->dev), type,
> > > +					&payload.record);
> > > +
> > > +		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > > +			trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> > > +						 &payload);
> > > +
> > > +	} while (payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> > > +
> > > +	return 0;
> > > +}
> > > +

> > >   * cxl_mem_get_partition_info - Get partition info
> > >   * @cxlds: The device data for the operation
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 88e3a8e54b6a..f83634f3bc8d 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -4,6 +4,7 @@
> > >  #define __CXL_MEM_H__
> > >  #include <uapi/linux/cxl_mem.h>
> > >  #include <linux/cdev.h>
> > > +#include <linux/uuid.h>
> > >  #include "cxl.h"
> > >  
> > >  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> > > @@ -253,6 +254,7 @@ struct cxl_dev_state {
> > >  enum cxl_opcode {
> > >  	CXL_MBOX_OP_INVALID		= 0x0000,
> > >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > > +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> > >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> > >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> > >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > > @@ -322,6 +324,69 @@ struct cxl_mbox_identify {
> > >  	u8 qos_telemetry_caps;
> > >  } __packed;
> > >  
> > > +/*
> > > + * Common Event Record Format
> > > + * CXL v3.0 section 8.2.9.2.1; Table 8-42
> > > + */
> > > +struct cxl_event_record_hdr {
> > > +	uuid_t id;
> > > +	__le32 flags_length;  
> > 
> > Can you split this into a u8 and
> > u8[3] then use the get_unaligned_le24 accessor
> > where appropriate? Oh for 24bit types ;)  
> 
> Sure!  Another function I did not know about.
> 
> So the following should be correct ordering?
> 
> ...
> 	uuid_t id;
> 	u8 length;
> 	u8 flags[3];
> 	__le16 handle;
> ...
> 
Looks good.

> There are other records which may work better this way too.
> 
> >   
> > > +	__le16 handle;
> > > +	__le16 related_handle;
> > > +	__le64 timestamp;
> > > +	__le64 reserved1;  
> > 
> > As below. Maintenance op from CXL 3.0?  Seems easy
> > to add now rather than needing a change later.  
> 
> Yes I see it now.  Added.
> 
> >   
> > > +	__le64 reserved2;
> > > +} __packed;
> > > +
> > > +#define EVENT_RECORD_DATA_LENGTH 0x50
> > > +struct cxl_event_record_raw {
> > > +	struct cxl_event_record_hdr hdr;
> > > +	u8 data[EVENT_RECORD_DATA_LENGTH];
> > > +} __packed;
> > > +
> > > +/*
> > > + * Get Event Records output payload
> > > + * CXL v3.0 section 8.2.9.2.2; Table 8-50  
> > 
> > r3.0 :) (just drop the v and go with 3.0 would be my preference).  
> 
> Can do.
> 
> >   
> > > + *
> > > + * Space given for 1 record
> > > + */
> > > +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> > > +#define CXL_GET_EVENT_FLAG_MORE_RECORDS	BIT(1)
> > > +struct cxl_get_event_payload {
> > > +	u8 flags;
> > > +	u8 reserved1;
> > > +	__le16 overflow_err_count;
> > > +	__le64 first_overflow_timestamp;
> > > +	__le64 last_overflow_timestamp;
> > > +	__le16 record_count;
> > > +	u8 reserved2[0xa];
> > > +	struct cxl_event_record_raw record;
> > > +} __packed;
> > > +
> > > +enum cxl_event_log_type {
> > > +	CXL_EVENT_TYPE_INFO = 0x00,
> > > +	CXL_EVENT_TYPE_WARN,
> > > +	CXL_EVENT_TYPE_FAIL,
> > > +	CXL_EVENT_TYPE_FATAL,  
> > 
> > Worth putting Dynamic capacity in now? Up to you.  
> 
> Might as well.
> 
> >   
> > > +	CXL_EVENT_TYPE_MAX
> > > +};  
> > 
> > Blank line for readability.  
> 
> Done.
> 
> >   
> > > +static inline char *cxl_event_log_type_str(enum cxl_event_log_type type)
> > > +{
> > > +	switch (type) {
> > > +	case CXL_EVENT_TYPE_INFO:
> > > +		return "Informational";
> > > +	case CXL_EVENT_TYPE_WARN:
> > > +		return "Warning";
> > > +	case CXL_EVENT_TYPE_FAIL:
> > > +		return "Failure";
> > > +	case CXL_EVENT_TYPE_FATAL:
> > > +		return "Fatal";
> > > +	default:
> > > +		break;
> > > +	}
> > > +	return "<unknown>";
> > > +}
> > > +
> > >  struct cxl_mbox_get_partition_info {
> > >  	__le64 active_volatile_cap;
> > >  	__le64 active_persistent_cap;
> > > @@ -381,6 +446,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> > >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> > >  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> > >  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> > > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
> > >  #ifdef CONFIG_CXL_SUSPEND
> > >  void cxl_mem_active_inc(void);
> > >  void cxl_mem_active_dec(void);
> > > diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> > > new file mode 100644
> > > index 000000000000..f4baeae66cf3
> > > --- /dev/null
> > > +++ b/include/trace/events/cxl-events.h
> > > @@ -0,0 +1,127 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM cxl_events
> > > +
> > > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > > +#define _CXL_TRACE_EVENTS_H
> > > +
> > > +#include <linux/tracepoint.h>
> > > +
> > > +#define EVENT_LOGS					\
> > > +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
> > > +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
> > > +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
> > > +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
> > > +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")  
> > 
> > Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
> > dynamic capacity events so I guess it doesn't matter.  
> 
> I'm not sure why you would say that.  I anticipate some user space daemon
> requiring these events to set things up.

Certainly a possible solution. I'd kind of expect a more hand shake based approach
than a tracepoint.  Guess we'll see :)


> >   
> > > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> > > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> > > +)
> > > +
> > > +TRACE_EVENT(cxl_event,
> > > +
> > > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > > +		 struct cxl_event_record_raw *rec),
> > > +
> > > +	TP_ARGS(dev_name, log, rec),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__string(dev_name, dev_name)
> > > +		__field(int, log)
> > > +		__array(u8, id, UUID_SIZE)
> > > +		__field(u32, flags)
> > > +		__field(u16, handle)
> > > +		__field(u16, related_handle)
> > > +		__field(u64, timestamp)
> > > +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
> > > +		__field(u8, length)  
> > 
> > Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
> > (only noticed because I happen to have that spec revision open rather than 2.0).  
> 
> Yes done.
> 
> There is some discussion with Dan regarding not decoding anything and letting
> user space take care of it all.  I think this shows a valid reason Dan
> suggested this.

I like being able to print tracepoints with out userspace tools.
This also enforces structure and stability of interface which I like.

Maybe a raw tracepoint or variable length trailing buffer to pass
on what we don't understand?

Jonathan


