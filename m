Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6B54F80F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382425AbiFQNBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382224AbiFQNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:01:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5A56B00;
        Fri, 17 Jun 2022 06:01:32 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPfLQ5030z6GDCt;
        Fri, 17 Jun 2022 21:01:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 15:01:30 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 14:01:29 +0100
Date:   Fri, 17 Jun 2022 14:01:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command
 support
Message-ID: <20220617140125.0000081e@Huawei.com>
In-Reply-To: <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
        <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.131]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 17:10:27 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices that support persistent memory maintain a list of locations
> that are poisoned or result in poison if the addresses are accessed by
> the host.
> 
> Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> list as a set of  Media Error Records that include the source of the
> error, the starting device physical address and length. The length is
> the number of adjacent DPAs in the record and is in units of 64 bytes.
> 
> Retrieve the list and log each Media Error Record as a trace event of
> type cxl_poison_list.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
 
> +int cxl_mem_get_poison_list(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_poison_payload_out *po;
> +	struct cxl_mbox_poison_payload_in pi;
> +	int nr_records = 0;
> +	int rc, i;
> +
> +	if (range_len(&cxlds->pmem_range)) {
> +		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
> +		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));
> +	} else {
> +		return -ENXIO;
> +	}
> +
> +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (!po)
> +		return -ENOMEM;
> +
> +	do {
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> +				       sizeof(pi), po, cxlds->payload_size);
> +		if (rc)
> +			goto out;
> +
> +		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
> +			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
> +
> +			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
> +				&o_time);
> +			rc = -ENXIO;
> +			goto out;
> +		}
> +
> +		if (po->flags & CXL_POISON_FLAG_SCANNING) {
> +			dev_err(dev, "Scan Media in Progress\n");
> +			rc = -EBUSY;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < le16_to_cpu(po->count); i++) {
> +			u64 addr = le64_to_cpu(po->record[i].address);
> +			u32 len = le32_to_cpu(po->record[i].length);
> +			int source = FIELD_GET(CXL_POISON_SOURCE_MASK, addr);
> +
> +			if (!CXL_POISON_SOURCE_VALID(source)) {
> +				dev_dbg(dev, "Invalid poison source %d",
> +					source);
> +				source = CXL_POISON_SOURCE_INVALID;
> +			}
> +
> +			trace_cxl_poison_list(dev, source, addr, len);
> +		}
> +
> +		/* Protect against an uncleared _FLAG_MORE */
> +		nr_records = nr_records + le16_to_cpu(po->count);
> +		if (nr_records >= cxlds->poison_max)

If this happens and _FLAG_MORE is set (it will occur anyway currently
if we happen to have poison_max records - I hit this in QEMU because
until now default of poison_max == 0)
then we should spit out an error message as I think that means the
hardware is broken.


> +			goto out;
> +
> +	} while (po->flags & CXL_POISON_FLAG_MORE);
> +
> +out:
> +	kvfree(po);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;

