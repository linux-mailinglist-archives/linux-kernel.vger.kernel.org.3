Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9B5A0F15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiHYLb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbiHYLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:31:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76F760F8;
        Thu, 25 Aug 2022 04:31:22 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MD10n3TZLz67yhs;
        Thu, 25 Aug 2022 19:27:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 13:31:20 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 12:31:20 +0100
Date:   Thu, 25 Aug 2022 12:31:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 7/9] cxl/test: Add generic mock events
Message-ID: <20220825123119.00000705@huawei.com>
In-Reply-To: <20220813053243.757363-8-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-8-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 12 Aug 2022 22:32:41 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Facilitate testing basic Get/Clear Event functionality by creating
> multiple logs and generic events with made up UUID's.
> 
> Data is completely made up with data patterns which should be easy to
> spot in trace output.
Hi Ira,

I'm tempted to hack the QEMU emulation for this in with appropriately
complex interface to inject all the record types...
Lots to do there though, so not sure where this fits in my priority list!

> 
> Test traces are easy to obtain with a small script such as this:
> 
> 	#!/bin/bash -x
> 
> 	devices=`find /sys/devices/platform -name cxl_mem*`
> 
> 	# Generate fake events if reset is passed in

reset is rather unintuitive naming.

fill_event_queue maybe or something more in that direction?

> 	if [ "$1" == "reset" ]; then
> 	        for device in $devices; do
> 	                echo 1 > $device/mem*/event_reset
> 	        done
> 	fi
> 
> 	# Turn on tracing
> 	echo "" > /sys/kernel/tracing/trace
> 	echo 1 > /sys/kernel/tracing/events/cxl_events/enable
> 	echo 1 > /sys/kernel/tracing/tracing_on
> 
> 	# Generate fake interrupt
> 	for device in $devices; do
> 	        echo 1 > $device/mem*/event_trigger
> 	        # just trigger 1
> 	        break;
> 	done
> 
> 	# Turn off tracing and report events
> 	echo 0 > /sys/kernel/tracing/tracing_on
> 	cat /sys/kernel/tracing/trace
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 291 +++++++++++++++++++++++++++++++++++
>  1 file changed, 291 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index e2f5445d24ff..87196d62acf5 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -9,6 +9,8 @@
>  #include <linux/bits.h>
>  #include <cxlmem.h>
>  
> +#include <trace/events/cxl-events.h>
> +
>  #define LSA_SIZE SZ_128K
>  #define DEV_SIZE SZ_2G
>  #define EFFECT(x) (1U << x)
> @@ -137,6 +139,287 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> +/*
> + * Mock Events
> + */
> +struct mock_event_log {
> +	int cur_event;
> +	int nr_events;
> +	struct xarray events;

I'm not convinced an xarray is appropriate here (I'd have used
a fixed size array) but meh, I don't care that much and mocking
code doesn't have to be quick or elegant :)

> +};
> +
> +struct mock_event_store {
> +	struct cxl_dev_state *cxlds;
> +	struct mock_event_log *mock_logs[CXL_EVENT_TYPE_MAX];

Each entry isn't terribly big and there aren't that many of them.
Make the code simpler by just embedding the instances here?

> +};
> +
> +DEFINE_XARRAY(mock_cxlds_event_store);
> +
> +void delete_event_store(void *ds)
> +{
> +	xa_store(&mock_cxlds_event_store, (unsigned long)ds, NULL, GFP_KERNEL);
> +}
> +
> +void store_event_store(struct mock_event_store *es)
> +{
> +	struct cxl_dev_state *cxlds = es->cxlds;
> +
> +	if (xa_insert(&mock_cxlds_event_store, (unsigned long)cxlds, es,
> +		      GFP_KERNEL)) {
> +		dev_err(cxlds->dev, "Event store not available for %s\n",
> +			dev_name(cxlds->dev));
> +		return;
> +	}
> +
> +	devm_add_action_or_reset(cxlds->dev, delete_event_store, cxlds);
> +}
> +
> +struct mock_event_log *find_event_log(struct cxl_dev_state *cxlds, int log_type)
> +{
> +	struct mock_event_store *es = xa_load(&mock_cxlds_event_store,
> +					      (unsigned long)cxlds);
> +
> +	if (!es || log_type >= CXL_EVENT_TYPE_MAX)
> +		return NULL;
> +	return es->mock_logs[log_type];
> +}
> +
> +struct cxl_event_record_raw *get_cur_event(struct mock_event_log *log)
> +{
> +	return xa_load(&log->events, log->cur_event);
> +}
> +
> +__le16 get_cur_event_handle(struct mock_event_log *log)
> +{
> +	return cpu_to_le16(log->cur_event);
> +}
> +
> +static bool log_empty(struct mock_event_log *log)
> +{
> +	return log->cur_event == log->nr_events;
> +}
> +
> +static int log_rec_left(struct mock_event_log *log)
> +{
> +	return log->nr_events - log->cur_event;
> +}
> +
> +static void xa_events_destroy(void *l)
> +{
> +	struct mock_event_log *log = l;
> +
> +	xa_destroy(&log->events);
> +}
> +
> +static void event_store_add_event(struct mock_event_store *es,
> +				  enum cxl_event_log_type log_type,
> +				  struct cxl_event_record_raw *event)
> +{
> +	struct mock_event_log *log;
> +	struct device *dev = es->cxlds->dev;
> +	int rc;
> +
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return;
> +
> +	log = es->mock_logs[log_type];
> +	if (!log) {
> +		log = devm_kzalloc(dev, sizeof(*log), GFP_KERNEL);

As above, I'd just embed the logs directly in the containing structure
rather than allocating on demand. init them all up front.

> +		if (!log) {
> +			dev_err(dev, "Failed to create %s log\n",
> +				cxl_event_log_type_str(log_type));
> +			return;
> +		}
> +		xa_init(&log->events);
> +		devm_add_action(dev, xa_events_destroy, log);
> +		es->mock_logs[log_type] = log;
> +	}
> +
> +	rc = xa_insert(&log->events, log->nr_events, event, GFP_KERNEL);
Not sure using an xa for a list really makes that much sense, but
doesn't matter hugely. 
> +	if (rc) {
> +		dev_err(dev, "Failed to store event %s log\n",
> +			cxl_event_log_type_str(log_type));
> +		return;
> +	}
> +	log->nr_events++;

Having an index into a static set of events is more complex.
I'd either switch to a simple array of pointers, or actually add and
remove events (or pointers to them anyway).

> +}
> +
> +/*
> + * Get and clear event only handle 1 record at a time as this is what is
> + * currently implemented in the main code.
> + */
> +static int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_get_event_payload *pl;
> +	struct mock_event_log *log;
> +	u8 log_type;
> +
> +	/* Valid request? */
> +	if (cmd->size_in != 1)
> +		return -EINVAL;
> +
> +	log_type = *((u8 *)cmd->payload_in);
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	log = find_event_log(cxlds, log_type);
> +	if (!log || log_empty(log))
> +		goto no_data;
> +
> +	/* Don't handle more than 1 record at a time */
> +	if (cmd->size_out < sizeof(*pl))
> +		return -EINVAL;
> +
> +	pl = cmd->payload_out;
> +	memset(pl, 0, sizeof(*pl));
> +
> +	pl->record_count = cpu_to_le16(1);
> +
> +	if (log_rec_left(log) > 1)
> +		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> +
> +	memcpy(&pl->record, get_cur_event(log), sizeof(pl->record));
> +	pl->record.hdr.handle = get_cur_event_handle(log);
> +	return 0;
> +
> +no_data:
> +	/* Room for header? */
> +	if (cmd->size_out < (sizeof(*pl) - sizeof(pl->record)))
> +		return -EINVAL;
> +
> +	memset(cmd->payload_out, 0, cmd->size_out);
> +	return 0;
> +}
> +
> +/*
> + * Get and clear event only handle 1 record at a time as this is what is
> + * currently implemented in the main code.

Duplicating this comment seems unnecessary.
 
> + */
> +static int mock_clear_event(struct cxl_dev_state *cxlds,
> +			    struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> +	struct mock_event_log *log;
> +	u8 log_type = pl->event_log;
> +
> +	/* Don't handle more than 1 record at a time */
> +	if (pl->nr_recs != 1)
> +		return -EINVAL;
> +
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	log = find_event_log(cxlds, log_type);
> +	if (!log)
> +		return 0; /* No mock data in this log */
> +
> +	/*
> +	 * The current code clears events as they are read
> +	 * Test that behavior; not clearning from the middle of the log
> +	 */
> +	if (log->cur_event != le16_to_cpu(pl->handle)) {
> +		dev_err(cxlds->dev, "Clearing events out of order\n");
> +		return -EINVAL;
> +	}
> +
> +	log->cur_event++;
> +	return 0;
> +}
> +
> +static ssize_t event_reset_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct cxl_memdev *cxlmd = container_of(dev, struct cxl_memdev, dev);
> +	int i;
> +
> +	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
> +		struct mock_event_log *log;
> +
> +		log = find_event_log(cxlmd->cxlds, i);
> +		if (log)
> +			log->cur_event = 0;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(event_reset);
> +
> +static ssize_t event_trigger_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct cxl_memdev *cxlmd = container_of(dev, struct cxl_memdev, dev);
> +
> +	cxl_mem_get_event_records(cxlmd->cxlds);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(event_trigger);
> +
> +static struct attribute *cxl_mock_event_attrs[] = {
> +	&dev_attr_event_reset.attr,
> +	&dev_attr_event_trigger.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(cxl_mock_event);
> +
> +void remove_mock_event_groups(void *dev)
static 
> +{
> +	device_remove_groups(dev, cxl_mock_event_groups);
> +}
> +
> +struct cxl_event_record_raw maint_needed = {
> +	.hdr = {
> +		.id = UUID_INIT(0xDEADBEEF, 0xCAFE, 0xBABE, 0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_MAINT_NEEDED << 8) |
> +					      sizeof(struct cxl_event_record_raw)),
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0xa5b6),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +struct cxl_event_record_raw hardware_replace = {
static const?
> +	.hdr = {
> +		.id = UUID_INIT(0xBABECAFE, 0xBEEF, 0xDEAD, 0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_HW_REPLACE << 8) |
> +					     sizeof(struct cxl_event_record_raw)),
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0xb6a5),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct mock_event_store *es;
> +
> +	/*
> +	 * The memory device gets the sysfs attributes such that the cxlmd
> +	 * pointer can be used to get to a cxlds pointer.
> +	 */
> +	if (device_add_groups(dev, cxl_mock_event_groups))

Whilst it might not matter in a mocking driver, it's normal to jump through
hoops to avoid doing this because it races with userspace notifications in
all sorts of hideous ways.  It makes the sysfs maintainers very grumpy ;)
To do it here, you would need to pass the group to devm_cxl_add_memdev()
and have that slip it in before the cdev_device_add() call I think.
That wouldn't be particular invasive though. 


> +		return;
> +	if (devm_add_action_or_reset(dev, remove_mock_event_groups, dev))
> +		return;
> +
> +	/*
> +	 * All the mock event data hangs off the device itself.

Nitpick of the day: Single line comment syntax ;)

> +	 */
> +	es = devm_kzalloc(cxlmd->cxlds->dev, sizeof(*es), GFP_KERNEL);
> +	if (!es)
> +		return;
> +	es->cxlds = cxlmd->cxlds;
> +
> +	event_store_add_event(es, CXL_EVENT_TYPE_INFO, &maint_needed);
> +
> +	event_store_add_event(es, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +
> +	store_event_store(es);
> +}
> +
>  static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
> @@ -224,6 +507,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_PARTITION_INFO:
>  		rc = mock_partition_info(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_GET_EVENT_RECORD:
> +		rc = mock_get_event(cxlds, cmd);
> +		break;
> +	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
> +		rc = mock_clear_event(cxlds, cmd);
> +		break;
>  	case CXL_MBOX_OP_SET_LSA:
>  		rc = mock_set_lsa(cxlds, cmd);
>  		break;
> @@ -285,6 +574,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	devm_cxl_mock_event_logs(cxlmd);
> +
>  	cxl_mem_get_event_records(cxlds);
>  
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))

