Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49F654EB47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378683AbiFPUeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378223AbiFPUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:34:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67185C758;
        Thu, 16 Jun 2022 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655411661; x=1686947661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6NPi5JN15DLj+hnNH4iONRsN3PsHwgvkpeMbdRdXc4Q=;
  b=boAc/izsFt1FGUR2jyltC0JtUdJcq9Q0ziVHxG7XEdoYhPYogI7WVVUu
   aq8MFdOWViQx8MRgKhTrSGj53Wx4mwzHNR67NAbU2WVMyWwJsQ9t5YVMn
   FoHbauwJpjPneqlFxp6VXtsjZGneTcke2GU9KcnfeJjxdAK1lQ9pXsG1h
   2msZrqR6g4Sa3l7dhU3erTCE3rxJ47GXY03aFV99DgTu4Ss0vuvpz+Vbu
   n2Sb6JJtg9MQec62Pm1Pacv9xSH2wiGVn6fv96LzDE2cTMzY59wV6rI2Y
   FDNBwQhh6pGzgcpa3nRLHBfiihiCnNK+Fl2/wi0VTsrn0atloAv426EHs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365698497"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365698497"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:34:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="589802054"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:34:20 -0700
Date:   Thu, 16 Jun 2022 13:34:00 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220616203400.GA1529208@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616194334.pvorvoozt4rrzr66@offworld>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:43:34PM -0700, Davidlohr Bueso wrote:
> On Tue, 14 Jun 2022, alison.schofield@intel.com wrote:
> 
> >From: Alison Schofield <alison.schofield@intel.com>
> >
> >CXL devices that support persistent memory maintain a list of locations
> >that are poisoned or result in poison if the addresses are accessed by
> >the host.
> >
> >Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> >list as a set of  Media Error Records that include the source of the
> >error, the starting device physical address and length. The length is
> >the number of adjacent DPAs in the record and is in units of 64 bytes.
> >
> >Retrieve the list and log each Media Error Record as a trace event of
> >type cxl_poison_list.
> >
> >Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> >---
> > drivers/cxl/cxlmem.h    | 43 +++++++++++++++++++++++
> > drivers/cxl/core/mbox.c | 75 +++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 118 insertions(+)
> >
snip

> >+int cxl_mem_get_poison_list(struct device *dev)
> >+{
> >+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >+	struct cxl_mbox_poison_payload_out *po;
> >+	struct cxl_mbox_poison_payload_in pi;
> >+	int nr_records = 0;
> >+	int rc, i;
> >+
> >+	if (range_len(&cxlds->pmem_range)) {
> >+		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
> >+		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));

First off - you stopped at a bug here - that pi.length needs to be
in units of 64 bytes.
> 
> Do you ever see this changing to not always use the full pmem DPA range
> but allow arbitrary ones? I also assume this is the reason why you don't
> check the range vs cxlds->ram_range to prevent any overlaps, no?
> 
> Thanks,
> Davidlohr

David - Great question!

I'm headed in this direction -

cxl list --media-errors -m mem1
	lists media errors for requested memdev

cxl list --media-errors -r region#
	lists region errors with HPA addresses
	(So here cxl tool will collect the poison for all the regions
	 memdevs and do the DPA to HPA translation)

To answer your question, I wasn't thinking of limiting
the range within the memdev, but certainly could. And if we were
taking in ranges, those ranges would need to be checked.

$cxl list --media-errors -m mem1 --range-start=  --range-end|len=

Now, if I left the sysfs inteface as is, the driver will read the 
entire poison list for the memdev and then cxl tool will filter it
for the range requested. 

Or, maybe we should implement in libcxl (not sysfs), with memdev and
range options and only collect from the device the range requested.

Either one looks the same to the cxl tool user, but limiting the
range we send to the device would certainly cut down on unwanted
records being logged, retrieved, and examined.

I'd like to hear more from you and other community members.

Alison

> > snip

