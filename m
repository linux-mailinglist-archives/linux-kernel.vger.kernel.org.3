Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9298E59FEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiHXPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiHXPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:55:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697861B1C;
        Wed, 24 Aug 2022 08:55:16 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCVzH0F3Mz67NYQ;
        Wed, 24 Aug 2022 23:54:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:55:14 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 16:55:14 +0100
Date:   Wed, 24 Aug 2022 16:55:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] cxl/mem: Implement Clear Event Records command
Message-ID: <20220824165513.00000987@huawei.com>
In-Reply-To: <20220813053243.757363-3-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-3-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Fri, 12 Aug 2022 22:32:36 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL v3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> command.  After an event record is read it needs to be cleared from the
> event log.
> 
> Implement cxl_clear_event_record() and call it for each record retrieved
> from the device.
> 
> Each record is cleared individually.  A clear all bit is specified but
> events could arrive between a get and the final clear all operation.
> Therefore each event is cleared specifically.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Trivial suggestions inline, but other than that LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c      | 31 ++++++++++++++++++++++++++++---
>  drivers/cxl/cxlmem.h         | 15 +++++++++++++++
>  include/uapi/linux/cxl_mem.h |  1 +
>  3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2cceed8608dc..493f5ceb5d1c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -52,6 +52,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
>  	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
>  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> @@ -708,6 +709,26 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> +				  enum cxl_event_log_type log,
> +				  __le16 handle)
> +{
> +	struct cxl_mbox_clear_event_payload payload;
> +	int rc;
> +
> +	memset(&payload, 0, sizeof(payload));

Could just do payload = {};

Thouch as you are setting stuff, why not just do

payload = {
	.event_log = log,
	.nr_recs = 1,
	.handle = handle,
};
and let the compiler zero anything else (I think there are no holes to complicate
things).

> +	payload.event_log = log;
> +	payload.nr_recs = 1;
> +	payload.handle = handle;
> +
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> +			       &payload, sizeof(payload), NULL, 0);

return cxl_mbox_send_cmd() and drop rc definition.


> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
>  static int cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  				   enum cxl_event_log_type type)
>  {
> @@ -725,9 +746,12 @@ static int cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  			return rc;
>  
>  		record_count = le16_to_cpu(payload.record_count);
> -		if (record_count > 0)
> +		if (record_count > 0) {
>  			trace_cxl_event(dev_name(cxlds->dev), type,
>  					&payload.record);
> +			cxl_clear_event_record(cxlds, type,
> +					       payload.record.hdr.handle);
> +		}
>  
>  		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> @@ -742,10 +766,11 @@ static int cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>   * cxl_mem_get_event_records - Get Event Records from the device
>   * @cxlds: The device data for the operation
>   *
> - * Retrieve all event records available on the device and report them as trace
> - * events.
> + * Retrieve all event records available on the device, report them as trace
> + * events, and clear them.
>   *
>   * See CXL v3.0 @8.2.9.2.2 Get Event Records
> + * See CXL v3.0 @8.2.9.2.3 Clear Event Records
>   */
>  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f83634f3bc8d..5506e7210cf6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -255,6 +255,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> +	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -387,6 +388,20 @@ static inline char *cxl_event_log_type_str(enum cxl_event_log_type type)
>  	return "<unknown>";
>  }
>  
> +/*
> + * Clear Event Records input payload
> + * CXL v3.0 section 8.2.9.2.3; Table 8-51
> + *
> + * Space given for 1 record
> + */
> +struct cxl_mbox_clear_event_payload {
> +	u8 event_log;		/* enum cxl_event_log_type */
> +	u8 clear_flags;
> +	u8 nr_recs;		/* 1 for this struct */
> +	u8 reserved[3];
> +	__le16 handle;
> +};
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 70459be5bdd4..7c1ad8062792 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -25,6 +25,7 @@
>  	___C(RAW, "Raw device command"),                                  \
>  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
>  	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
> +	___C(CLEAR_EVENT_RECORD, "Clear Event Record"),                   \
>  	___C(GET_FW_INFO, "Get FW Info"),                                 \
>  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
>  	___C(GET_LSA, "Get Label Storage Area"),                          \

