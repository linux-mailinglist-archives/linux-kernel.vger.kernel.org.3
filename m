Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CEA561F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiF3PqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiF3PqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:46:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E0D41993;
        Thu, 30 Jun 2022 08:46:02 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYjHm0hZPz67nNr;
        Thu, 30 Jun 2022 23:41:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 17:46:00 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 16:45:59 +0100
Date:   Thu, 30 Jun 2022 16:45:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 6/9] cxl/port: Read CDAT table
Message-ID: <20220630164557.00005fdd@Huawei.com>
In-Reply-To: <Yr0aBnTJtFXrCUSM@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
        <20220628041527.742333-7-ira.weiny@intel.com>
        <20220628154727.0000021c@Huawei.com>
        <Yr0aBnTJtFXrCUSM@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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

On Wed, 29 Jun 2022 20:35:34 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Jun 28, 2022 at 03:47:27PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 Jun 2022 21:15:24 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The OS will need CDAT data from CXL devices to properly set up
> > > interleave sets.  Currently this is supported through a DOE mailbox
> > > which supports CDAT.
> > > 
> > > Search the DOE mailboxes available, query CDAT data, and cache the data
> > > for later parsing.
> > > 
> > > Provide a sysfs binary attribute to allow dumping of the CDAT.
> > > 
> > > Binary dumping is modeled on /sys/firmware/ACPI/tables/
> > > 
> > > The ability to dump this table will be very useful for emulation of real
> > > devices once they become available as QEMU CXL type 3 device emulation will
> > > be able to load this file in.
> > > 
> > > This does not support table updates at runtime. It will always provide
> > > whatever was there when first cached. Handling of table updates can be
> > > implemented later.
> > > 
> > > Finally create a complete list of CDAT defines within cdat.h for code
> > > wishing to decode the CDAT table.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > One query inline, though I'm fine with it either way, just want to
> > understand your logic in keeping completion when Dan suggested using
> > flush_work() to achieve the same thing.
> >   
> > > 
> > > ---
> > > Changes from V11:
> > > 	Adjust for the use of DOE mailbox xarray
> > > 	Dan Williams:
> > > 		Remove unnecessary get/put device
> > > 		Use new BIN_ATTR_ADMIN_RO macro
> > > 		Flag that CDAT was supported
> > > 			If there is a read error then the CDAT sysfs
> > > 			will return a 0 length entry
> > >   
> > ...  
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index c4c99ff7b55e..4bd479ec0253 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -4,10 +4,12 @@  
> >   
> > > +static int cxl_cdat_get_length(struct device *dev,
> > > +			       struct pci_doe_mb *cdat_mb,
> > > +			       size_t *length)
> > > +{
> > > +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> > > +	u32 cdat_response_pl[32];
> > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > +	struct pci_doe_task task = {
> > > +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > > +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > > +		.request_pl = &cdat_request_pl,
> > > +		.request_pl_sz = sizeof(cdat_request_pl),
> > > +		.response_pl = cdat_response_pl,
> > > +		.response_pl_sz = sizeof(cdat_response_pl),
> > > +		.complete = cxl_doe_task_complete,
> > > +		.private = &c,
> > > +	};
> > > +	int rc = 0;
> > > +
> > > +	rc = pci_doe_submit_task(cdat_mb, &task);
> > > +	if (rc < 0) {
> > > +		dev_err(dev, "DOE submit failed: %d", rc);
> > > +		return rc;
> > > +	}
> > > +	wait_for_completion(&c);  
> > 
> > Dan mentioned in his review that we could just use
> > flush_work() and drop the completion logic and callback.
> > Why didn't you go that way?  Would want to wrap it up
> > in pci_doe_wait_task() or something like that.  
> 
> In early reviews of the Aux Bus work Dan also specified the above design
> pattern.
> 
> 	"I would expect that the caller of this routine [pci_doe_exchange_sync]
> 	would want to specify the task and end_task() callback and use that as
> 	the completion signal.  It may also want "no wait" behavior where it is
> 	prepared for the DOE result to come back sometime later. With that
> 	change the exchange fields can move into the task directly."
> 
> 	-- https://lore.kernel.org/linux-cxl/CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com/
> 
> I've renamed pci_doe_exchange_sync() pci_doe_submit_task() because of other
> feedback.  Here the callback is set to cxl_doe_task_complete() and we have to
> wait because this particular query needs the length prior to the next task
> being issued.
> 
> I use flush_workqueue() within the shutdown handling (or if someone destroys
> the mailbox or abort fails) to first block new work from being submitted
> (PCI_DOE_FLAG_DEAD), cancel the running work if needed (PCI_DOE_FLAG_CANCEL
> [was ABORT]), and then flush the queue causing all the pending work to error
> when seeing PCI_DOE_FLAG_DEAD.

I'm lost, but I'm fine with completions anyway so no problem :)

I wasn't advocating not waiting, but potentially a different way of doing
the wait.  If Dan cares about what I think he was proposing with flush_work()
I'll leave it to him to explain why.

Jonathan



> 
> Ira
> 
> >   
> > > +
> > > +	if (task.rv < 1)
> > > +		return -EIO;
> > > +
> > > +	*length = cdat_response_pl[1];
> > > +	dev_dbg(dev, "CDAT length %zu\n", *length);
> > > +
> > > +	return rc;
> > > +}
> > > +  
> 

