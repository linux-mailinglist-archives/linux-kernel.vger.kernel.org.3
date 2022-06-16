Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D754EA48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378347AbiFPTn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiFPTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:43:55 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C28580C2;
        Thu, 16 Jun 2022 12:43:51 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AD1986A137F;
        Thu, 16 Jun 2022 19:43:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 19BA56A1081;
        Thu, 16 Jun 2022 19:43:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655408627; a=rsa-sha256;
        cv=none;
        b=ZbOmTxb9kizxwZGOJqxuEvi/CzJiuyatvvpfSG050xGeikLDKJvU9kpBdH2Lkl375INDFU
        IWILJnot3A3m0dukQ+v9omifK28xrgqpZCR2RIgZMj4/9ryHziFcoX1gUzsAwJgEHe/0nH
        OU4ecUIhwLjrJKIKSPsCJLRUJ3S461FeBsIuf3Bi2sQwurv/0CXS1eikVFnSbYuoAxGegO
        9fPzByYtcJZcp+D/hSM2p6+vWQx+RnowdS/6hhQgzz2EW0WIRMdUtWglkHwoL2DC0sd0ck
        Qi7WAZNMPlTlvWAxZHM980HEUTYfDe96G9lE3F/fjcJiwjVL2Hs2blAorypRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655408627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=APowBpXKlvkZTYp8d00UGVeluyopSqpyy/WS7dXz7QE=;
        b=co1A+6+5JfACtmYqN+w6xJNeEFy0lomu0EHDxqevMXV97u6nMTU6TjQKgzG9t7jQNaWr+M
        EAqD0CAaeIsyu59xKJEpDQ6+lt3z+8Ak7b1utrLf9EIhDgWNQMBxRXy5x+Y30immuubsH8
        2pAqDzEBvuqrQyTjDh+pjbBajTkBaIio2dkO7hG/K9aDXLJvQFDMdLJ3QmiUF6waVO/7Xx
        PtqTONRvSxZTerhSXSofBIEkwR3/Fafvyl8y/ZzwNO2yX/n7Fm4UC8IbjaXC78d4nSqzzG
        dpT8gRK0il6/1ud2e1BccE3EMBq+VKcfKAX3f43ATTP9EB1ZBILODNqey0mIxQ==
ARC-Authentication-Results: i=1;
        rspamd-848669fb87-x5wm2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Abortive: 41da3f886441c637_1655408627505_2417365882
X-MC-Loop-Signature: 1655408627505:3811859437
X-MC-Ingress-Time: 1655408627505
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.1 (trex/6.7.1);
        Thu, 16 Jun 2022 19:43:47 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPCK51KcczCY;
        Thu, 16 Jun 2022 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655408617;
        bh=APowBpXKlvkZTYp8d00UGVeluyopSqpyy/WS7dXz7QE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bWnZP6fl+abY+VfCEhbJQEYKEpHuaS4vNwKdL9AO2ZiLI3vgOscBCfNuIO17+cyUx
         tXvQqBoLqB9pbwQZgx/dlC4m3TqSCVq3L4nMYiRtnpRhSM6jwlIyHAWuTeRiX3sSOf
         +F0KfcIsyGEuAwVHwyC8zF1ERSJolFHwxqDhB/xiMYAaEy1PJNeQBEptLtfz8HadGK
         vtM5RQxGOXvDminsHZ8NojlqoQvFRa/6slhK8pfK2PjLKwrszDJrQa/H3uVyrU1zDm
         xZu6dKZDbXY6318qqjHAMh+9Wm+1fB3po/SzXx26wh5KNWQODsmBkgjGXODLDMMaUO
         Gul83z1rIBzTA==
Date:   Thu, 16 Jun 2022 12:43:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.manzanares@samsung.com
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220616194334.pvorvoozt4rrzr66@offworld>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>CXL devices that support persistent memory maintain a list of locations
>that are poisoned or result in poison if the addresses are accessed by
>the host.
>
>Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
>list as a set of  Media Error Records that include the source of the
>error, the starting device physical address and length. The length is
>the number of adjacent DPAs in the record and is in units of 64 bytes.
>
>Retrieve the list and log each Media Error Record as a trace event of
>type cxl_poison_list.
>
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>---
> drivers/cxl/cxlmem.h    | 43 +++++++++++++++++++++++
> drivers/cxl/core/mbox.c | 75 +++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 118 insertions(+)
>
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index 60d10ee1e7fc..29cf0459b44a 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -174,6 +174,7 @@ struct cxl_endpoint_dvsec_info {
>  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>  * @lsa_size: Size of Label Storage Area
>  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>+ * @poison_max_mer: maximum Media Error Records tracked in Poison List
>  * @mbox_mutex: Mutex to synchronize mailbox access.
>  * @firmware_version: Firmware version for the memory device.
>  * @enabled_cmds: Hardware commands found enabled in CEL.
>@@ -204,6 +205,7 @@ struct cxl_dev_state {
>
>	size_t payload_size;
>	size_t lsa_size;
>+	u32 poison_max;
>	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>	char firmware_version[0x10];
>	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>@@ -317,6 +319,46 @@ struct cxl_mbox_set_partition_info {
>
> #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>
>+struct cxl_mbox_poison_payload_in {
>+	__le64 offset;
>+	__le64 length;
>+} __packed;
>+
>+struct cxl_mbox_poison_payload_out {
>+	u8 flags;
>+	u8 rsvd1;
>+	__le64 overflow_timestamp;
>+	__le16 count;
>+	u8 rsvd2[0x14];
>+	struct cxl_poison_record {
>+		__le64 address;
>+		__le32 length;
>+		__le32 rsvd;
>+	} __packed record[];
>+} __packed;
>+
>+/* CXL 8.2.9.5.4.1 Get Poison List: payload out flags: */
>+#define CXL_POISON_FLAG_MORE            BIT(0)
>+#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
>+#define CXL_POISON_FLAG_SCANNING        BIT(2)
>+
>+/* CXL 8.2.9.5.4.1 Get Poison List: Error is encoded in record.address[2:0] */
>+#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
>+#define	CXL_POISON_SOURCE_UNKNOWN	0
>+#define	CXL_POISON_SOURCE_EXTERNAL	1
>+#define	CXL_POISON_SOURCE_INTERNAL	2
>+#define	CXL_POISON_SOURCE_INJECTED	3
>+#define	CXL_POISON_SOURCE_VENDOR	7
>+
>+/* Software define */
>+#define	CXL_POISON_SOURCE_INVALID	99
>+#define CXL_POISON_SOURCE_VALID(x)		\
>+	(((x) == CXL_POISON_SOURCE_UNKNOWN)  ||	\
>+	 ((x) == CXL_POISON_SOURCE_EXTERNAL) ||	\
>+	 ((x) == CXL_POISON_SOURCE_INTERNAL) ||	\
>+	 ((x) == CXL_POISON_SOURCE_INJECTED) ||	\
>+	 ((x) == CXL_POISON_SOURCE_VENDOR))
>+
> /**
>  * struct cxl_mem_command - Driver representation of a memory device command
>  * @info: Command information as it exists for the UAPI
>@@ -351,6 +393,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>+int cxl_mem_get_poison_list(struct device *dev);
> #ifdef CONFIG_CXL_SUSPEND
> void cxl_mem_active_inc(void);
> void cxl_mem_active_dec(void);
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index 54f434733b56..c10c7020ebc2 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -9,6 +9,9 @@
>
> #include "core.h"
>
>+#define CREATE_TRACE_POINTS
>+#include <trace/events/cxl.h>
>+
> static bool cxl_raw_allow_all;
>
> /**
>@@ -755,6 +758,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> {
>	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>	struct cxl_mbox_identify id;
>+	__le32 val = 0;
>	int rc;
>
>	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
>@@ -783,6 +787,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
>	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
>
>+	memcpy(&val, id.poison_list_max_mer, 3);
>+	cxlds->poison_max = le32_to_cpu(val);
>+
>	return 0;
> }
> EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>@@ -826,6 +833,74 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> }
> EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>
>+int cxl_mem_get_poison_list(struct device *dev)
>+{
>+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>+	struct cxl_mbox_poison_payload_out *po;
>+	struct cxl_mbox_poison_payload_in pi;
>+	int nr_records = 0;
>+	int rc, i;
>+
>+	if (range_len(&cxlds->pmem_range)) {
>+		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
>+		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));

Do you ever see this changing to not always use the full pmem DPA range
but allow arbitrary ones? I also assume this is the reason why you don't
check the range vs cxlds->ram_range to prevent any overlaps, no?

Thanks,
Davidlohr

>+	} else {
>+		return -ENXIO;
>+	}
>+
>+	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
>+	if (!po)
>+		return -ENOMEM;
>+
>+	do {
>+		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
>+				       sizeof(pi), po, cxlds->payload_size);
>+		if (rc)
>+			goto out;
>+
>+		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
>+			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
>+
>+			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
>+				&o_time);
>+			rc = -ENXIO;
>+			goto out;
>+		}
>+
>+		if (po->flags & CXL_POISON_FLAG_SCANNING) {
>+			dev_err(dev, "Scan Media in Progress\n");
>+			rc = -EBUSY;
>+			goto out;
>+		}
>+
>+		for (i = 0; i < le16_to_cpu(po->count); i++) {
>+			u64 addr = le64_to_cpu(po->record[i].address);
>+			u32 len = le32_to_cpu(po->record[i].length);
>+			int source = FIELD_GET(CXL_POISON_SOURCE_MASK, addr);
>+
>+			if (!CXL_POISON_SOURCE_VALID(source)) {
>+				dev_dbg(dev, "Invalid poison source %d",
>+					source);
>+				source = CXL_POISON_SOURCE_INVALID;
>+			}
>+
>+			trace_cxl_poison_list(dev, source, addr, len);
>+		}
>+
>+		/* Protect against an uncleared _FLAG_MORE */
>+		nr_records = nr_records + le16_to_cpu(po->count);
>+		if (nr_records >= cxlds->poison_max)
>+			goto out;
>+
>+	} while (po->flags & CXL_POISON_FLAG_MORE);
>+
>+out:
>+	kvfree(po);
>+	return rc;
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
>+
> struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> {
>	struct cxl_dev_state *cxlds;
>
>--
>2.31.1
>
