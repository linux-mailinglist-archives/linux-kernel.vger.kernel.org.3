Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7207854F8E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382616AbiFQOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiFQOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:05:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7A413FAD;
        Fri, 17 Jun 2022 07:05:16 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPgly0bmjz67yhs;
        Fri, 17 Jun 2022 22:05:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 16:05:13 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 15:05:12 +0100
Date:   Fri, 17 Jun 2022 15:05:08 +0100
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
Message-ID: <20220617150508.0000266a@Huawei.com>
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

A few more things inline.

Otherwise, can confirm it works with some hack QEMU code.
I'll tidy that up and post soon.

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

Need to mask off the lower 6 bits of addr as they contain the source
+ a few reserved bits.

I was confused how you were geting better than 64 byte precision in your
example.

> +		}
> +
> +		/* Protect against an uncleared _FLAG_MORE */
> +		nr_records = nr_records + le16_to_cpu(po->count);
> +		if (nr_records >= cxlds->poison_max)
> +			goto out;
> +
> +	} while (po->flags & CXL_POISON_FLAG_MORE);
So.. A conundrum here.  What happens if:

1. We get an error mid way through a set of multiple reads
   (something intermittent - maybe a software issue)
2. We will drop out of here fine and report the error.
3. We run this function again.

It will (I think) currently pick up where we left off, but we have
no way of knowing that as there isn't a 'total records' count or
any other form of index in the output payload.

So, software solutions I think should work (though may warrant a note
to be added to the spec).

1. Read whole thing twice. First time is just to ensure we get
   to the end and flush out any prior half done reads.
2. Issue a read for a different region (perhaps length 0) first
   and assume everything starts from scratch when we go back to
   this region.

Jonathan



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

