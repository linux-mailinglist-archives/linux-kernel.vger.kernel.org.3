Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5185C551644
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiFTKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiFTKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:53:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EDF657E;
        Mon, 20 Jun 2022 03:53:12 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRRK20yrFz689SS;
        Mon, 20 Jun 2022 18:51:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 20 Jun 2022 12:53:09 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 11:53:08 +0100
Date:   Mon, 20 Jun 2022 11:53:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command
 support
Message-ID: <20220620115307.000037a2@Huawei.com>
In-Reply-To: <62accfc892f74_81c5e29456@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
        <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
        <20220616194334.pvorvoozt4rrzr66@offworld>
        <20220616203400.GA1529208@alison-desk>
        <62accfc892f74_81c5e29456@dwillia2-xfh.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
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

On Fri, 17 Jun 2022 12:02:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Alison Schofield wrote:
> > On Thu, Jun 16, 2022 at 12:43:34PM -0700, Davidlohr Bueso wrote:  
> > > On Tue, 14 Jun 2022, alison.schofield@intel.com wrote:
> > >   
> > > >From: Alison Schofield <alison.schofield@intel.com>
> > > >
> > > >CXL devices that support persistent memory maintain a list of locations
> > > >that are poisoned or result in poison if the addresses are accessed by
> > > >the host.
> > > >
> > > >Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> > > >list as a set of  Media Error Records that include the source of the
> > > >error, the starting device physical address and length. The length is
> > > >the number of adjacent DPAs in the record and is in units of 64 bytes.
> > > >
> > > >Retrieve the list and log each Media Error Record as a trace event of
> > > >type cxl_poison_list.
> > > >
> > > >Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > >---
> > > > drivers/cxl/cxlmem.h    | 43 +++++++++++++++++++++++
> > > > drivers/cxl/core/mbox.c | 75 +++++++++++++++++++++++++++++++++++++++++
> > > > 2 files changed, 118 insertions(+)
> > > >  
> > snip
> >   
> > > >+int cxl_mem_get_poison_list(struct device *dev)
> > > >+{
> > > >+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > > >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > >+	struct cxl_mbox_poison_payload_out *po;
> > > >+	struct cxl_mbox_poison_payload_in pi;
> > > >+	int nr_records = 0;
> > > >+	int rc, i;
> > > >+
> > > >+	if (range_len(&cxlds->pmem_range)) {
> > > >+		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
> > > >+		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));  
> > 
> > First off - you stopped at a bug here - that pi.length needs to be
> > in units of 64 bytes.  
> > > 
> > > Do you ever see this changing to not always use the full pmem DPA range
> > > but allow arbitrary ones? I also assume this is the reason why you don't
> > > check the range vs cxlds->ram_range to prevent any overlaps, no?
> > > 
> > > Thanks,
> > > Davidlohr  
> > 
> > David - Great question!
> > 
> > I'm headed in this direction -
> > 
> > cxl list --media-errors -m mem1
> > 	lists media errors for requested memdev
> > 
> > cxl list --media-errors -r region#
> > 	lists region errors with HPA addresses
> > 	(So here cxl tool will collect the poison for all the regions
> > 	 memdevs and do the DPA to HPA translation)
> > 
> > To answer your question, I wasn't thinking of limiting
> > the range within the memdev, but certainly could. And if we were
> > taking in ranges, those ranges would need to be checked.
> > 
> > $cxl list --media-errors -m mem1 --range-start=  --range-end|len=
> > 
> > Now, if I left the sysfs inteface as is, the driver will read the 
> > entire poison list for the memdev and then cxl tool will filter it
> > for the range requested. 
> > 
> > Or, maybe we should implement in libcxl (not sysfs), with memdev and
> > range options and only collect from the device the range requested.
> > 
> > Either one looks the same to the cxl tool user, but limiting the
> > range we send to the device would certainly cut down on unwanted
> > records being logged, retrieved, and examined.
> > 
> > I'd like to hear more from you and other community members.  
> 
> There is some history here that is relevant to this design. CXL Get
> Poison List builds on lessons learned from the ACPI "Address Range
> Scrub" mechanism that was deployed for ACPI described persistent memory
> platform (See ACPI 6.4 9.20.7.2 "Address Range Scrubbing (ARS)
> Overview"). In that case there was no expectation that the device
> maintained a cached and coherent (with incoming poison writes) copy of
> the media error list. CXL Get Poison List in comparison is meant to
> obviate the need to perform Scan Media in most scenarios, and it is
> lightweight enough that userspace need not have a mechanism to request
> errors by range, in my opinion.
> 
> One of the design warts of drivers/acpi/nfit/ that I want to get away
> from in the case of drivers/cxl/ is snooping the equivalent of ARS
> command results to populate a kernel list of poison addresses and
> instead put the onus on userspace to collect DPA events and optionally
> inform the kernel of the HPA impacts.

Can you give more info on why such an in kernel flow doesn't work
well for this usecase (particularly for volatile memory)? I don't
much like the flow differing from how we do DRAM patrol scrub based
handling today. I'm not sure I like the requirement for userspace
to be in the loop if we are dealing with volatile failures even if
the detection is async.

> For example, DAX filesystems will
> soon have the ability to do something useful with poison notifications
> [1], but that support is limited to synchronously consumed poison
> flagged by memory_failure(). When the cxl tool translates the poison
> list to HPA it needs an ABI to turn around and notify the filesystem
> about which blocks got clobbered.

I'm not clear why it makes sense to do the DPA to HPA conversion in
userspace. It should be a fairly trivial bit of code to do the reverse look
up in kernel and then we just bolt into existing infrastructure.

Jonathan

> 
> [1]: https://lore.kernel.org/all/20220616193157.2c2e963f3e7e38dfac554a28@linux-foundation.org/



