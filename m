Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF89D54C103
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbiFOFIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiFOFIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:08:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495719F89;
        Tue, 14 Jun 2022 22:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655269689; x=1686805689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8W6+BS5zW2ikAODP0FdofqAW5wGMZqw2O6tgAoEQX+k=;
  b=OyeIfBy9vzTOnbt1scKaqBNaEvgz60bNL1AVqJgbMCI7UatRz3/CH47J
   D+D6kTcud6v16UqVLOKfMDgxchwlqlMz7gLzAEjVBR/k0LOOX5KxZNk0G
   WnpEm/4nRCTv/mV683P9/aYehtaG3cfVIGkQfmwHsEzWdhKxipuDIJIhy
   8BgfTkh+AG/82ohd1s6Fi3dVwlNrxqHqS3jb6cc3gdzTLMioqp5p5MACi
   lCSPPHrBb8wDzEK8WoRePFhx/JlBwnQ5N+AkdQ+vdgsx0bunZMZqGePy1
   3j2f5X1URWZ03CH+v80iKh03K0GTM+vH/h8YEuVVXJ4p1xxfjdiIBqZu9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="259296007"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="259296007"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 22:08:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588897117"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 22:08:09 -0700
Date:   Tue, 14 Jun 2022 22:07:52 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220615050752.GA1521419@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <YqlQgbDUTJ6k9UBY@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqlQgbDUTJ6k9UBY@iweiny-desk3>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:22:41PM -0700, Ira Weiny wrote:

Thanks for the review Ira...

> On Tue, Jun 14, 2022 at 05:10:27PM -0700, Alison Schofield wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 

snip

> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 60d10ee1e7fc..29cf0459b44a 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -174,6 +174,7 @@ struct cxl_endpoint_dvsec_info {
> >   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> >   * @lsa_size: Size of Label Storage Area
> >   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> > + * @poison_max_mer: maximum Media Error Records tracked in Poison List
> 
> Does not match the member name below.
Got it! I intended to drop the _mer.

> 
> Ira
> 
> >   * @mbox_mutex: Mutex to synchronize mailbox access.
> >   * @firmware_version: Firmware version for the memory device.
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> > @@ -204,6 +205,7 @@ struct cxl_dev_state {
> >  
> >  	size_t payload_size;
> >  	size_t lsa_size;
> > +	u32 poison_max;
> >  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> >  	char firmware_version[0x10];
> >  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);

snip

> > +int cxl_mem_get_poison_list(struct device *dev)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_mbox_poison_payload_out *po;
> > +	struct cxl_mbox_poison_payload_in pi;
> > +	int nr_records = 0;
> > +	int rc, i;
> > +
> > +	if (range_len(&cxlds->pmem_range)) {
> > +		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
> > +		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));
> > +	} else {
> > +		return -ENXIO;
> > +	}
> > +
> > +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > +	if (!po)
> > +		return -ENOMEM;
> > +
> > +	do {
> > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> > +				       sizeof(pi), po, cxlds->payload_size);
> > +		if (rc)
> > +			goto out;
> > +
> > +		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
> > +			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
> > +
> > +			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
> > +				&o_time);
> > +			rc = -ENXIO;
> > +			goto out;
> 
> I guess the idea is that this return will trigger something else will clear the list,
> rebuild the list, and perform a scan media request?
> 
Per CXL Spec 8.2.9.5.4.1: The poison list may be incomplete when the list
has overflowed. User can perform a Scan Media to try to clear and rebuild
the list, with no guarantee that the overflow will not recur.

So yes to what you are saying. This return value should indicate to
user space that a Scan Media should be issued. Issuing the Scan Media
to the device does lead the device to rebuild it's list, as you say.
Also, when we get the Scan Media results, the device is able to report
partial results and tell the host to collect the error records, and
then restart the scan, get results again, and on and on until the scan
is complete.

Perhaps a clarification - there is not a logical pairing of Scan Media
followed by Get Poison List.  Scan Media followed by Get Scan Media
Results is the logical pairing. Get Poison List is getting a snapshot
of the poison list at a point in time. The device adds DPAs to the list
when the device detects poison, some devices run their own backround
scans and add to the poison list, and then there are the user initiated
actions (Scan Media and Poison Inject) that can affect the list.

> I'm just wondering if this loop should continue to clear the list and then let
> something else do the scan media request?

It's not like the _MORE status where the device is telling the host to
come back and gather more. I think the action of failing, and letting
user initiated a Scan Media is correct course here.

So, this response got kind of long winded. As you can see, especially
if one looks in the spec as I know you are, there are additional
commands that need to be implemented to complete the ARS feature set.
And, of course, we'll offer user space tooling (NDCTL and libcxl).

> 
> Other than that question and the above typo.  Looks good!
> 
> Ira
> 
> > +		}
> > +
> > +		if (po->flags & CXL_POISON_FLAG_SCANNING) {
> > +			dev_err(dev, "Scan Media in Progress\n");
> > +			rc = -EBUSY;
> > +			goto out;
> > +		}
> > +
> > +		for (i = 0; i < le16_to_cpu(po->count); i++) {
> > +			u64 addr = le64_to_cpu(po->record[i].address);
> > +			u32 len = le32_to_cpu(po->record[i].length);
> > +			int source = FIELD_GET(CXL_POISON_SOURCE_MASK, addr);
> > +
> > +			if (!CXL_POISON_SOURCE_VALID(source)) {
> > +				dev_dbg(dev, "Invalid poison source %d",
> > +					source);
> > +				source = CXL_POISON_SOURCE_INVALID;
> > +			}
> > +
> > +			trace_cxl_poison_list(dev, source, addr, len);
> > +		}
> > +
> > +		/* Protect against an uncleared _FLAG_MORE */
> > +		nr_records = nr_records + le16_to_cpu(po->count);
> > +		if (nr_records >= cxlds->poison_max)
> > +			goto out;
> > +
> > +	} while (po->flags & CXL_POISON_FLAG_MORE);
> > +
> > +out:
> > +	kvfree(po);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
> > +
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> >  {
> >  	struct cxl_dev_state *cxlds;
> > -- 
> > 2.31.1
> > 
