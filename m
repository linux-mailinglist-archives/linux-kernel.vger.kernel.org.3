Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483FD55165E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbiFTK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbiFTK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:56:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E8140FA;
        Mon, 20 Jun 2022 03:56:10 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRRNS35Rzz684kT;
        Mon, 20 Jun 2022 18:54:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 12:56:08 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 11:56:07 +0100
Date:   Mon, 20 Jun 2022 11:56:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command
 support
Message-ID: <20220620115605.00004440@Huawei.com>
In-Reply-To: <20220617162935.GA1532720@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
        <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
        <20220617150508.0000266a@Huawei.com>
        <20220617162935.GA1532720@alison-desk>
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

On Fri, 17 Jun 2022 09:29:35 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Jun 17, 2022 at 07:05:08AM -0700, Jonathan Cameron wrote:
> > On Tue, 14 Jun 2022 17:10:27 -0700
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > CXL devices that support persistent memory maintain a list of locations
> > > that are poisoned or result in poison if the addresses are accessed by
> > > the host.
> > > 
> > > Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> > > list as a set of  Media Error Records that include the source of the
> > > error, the starting device physical address and length. The length is
> > > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > > 
> > > Retrieve the list and log each Media Error Record as a trace event of
> > > type cxl_poison_list.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > 
> > A few more things inline.
> > 
> > Otherwise, can confirm it works with some hack QEMU code.
> > I'll tidy that up and post soon.
> >   
> > > +int cxl_mem_get_poison_list(struct device *dev)
> > > +{  
> snip
> > > +
> > > +			trace_cxl_poison_list(dev, source, addr, len);  
> > 
> > Need to mask off the lower 6 bits of addr as they contain the source
> > + a few reserved bits.
> > 
> > I was confused how you were geting better than 64 byte precision in your
> > example.
> >  
> Ah...got it. Thanks!
> 
> > > +		}
> > > +
> > > +		/* Protect against an uncleared _FLAG_MORE */
> > > +		nr_records = nr_records + le16_to_cpu(po->count);
> > > +		if (nr_records >= cxlds->poison_max)
> > > +			goto out;
> > > +
> > > +	} while (po->flags & CXL_POISON_FLAG_MORE);  
> > So.. A conundrum here.  What happens if:
> > 
> > 1. We get an error mid way through a set of multiple reads
> >    (something intermittent - maybe a software issue)
> > 2. We will drop out of here fine and report the error.
> > 3. We run this function again.
> > 
> > It will (I think) currently pick up where we left off, but we have
> > no way of knowing that as there isn't a 'total records' count or
> > any other form of index in the output payload.  
> 
> Yes. That is sad. I'm assume it's by design and CXL devices never
> intended to keep any totals.
> 
> > 
> > So, software solutions I think should work (though may warrant a note
> > to be added to the spec).
> > 
> > 1. Read whole thing twice. First time is just to ensure we get
> >    to the end and flush out any prior half done reads.
> > 2. Issue a read for a different region (perhaps length 0) first
> >    and assume everything starts from scratch when we go back to
> >    this region.  
> 
> Can you tell me more about 2 ?

2 relies on interpreting what the spec says for an unusual corner case.
The concept of 'more available' is something I would assume you'd only
get if you issued a repeat of the same request.  I don't think the
spec actually covers this case - perhaps that's something we need to
raise via the appropriate channels.

Jonathan



> 
> Also, Since posting this I have added protection to this path to ensure
> only one reader of the poison list for this device. Like this:
> 
> if (!completion_done(&cxlds->read_poison_complete);
>               return -EBUSY;
> wait_for_completion_interruptible(&cxlds->read_poison_complete);
> 	...GET ALL THE POISON...
> complete(&cxlds->read_poison_complete);
> 
> And will add the error message on that unexpected _FLAG_MORE too.
> 
> Alison
> > 
> > Jonathan
> >   
> 
> 
> 
> > > +
> > > +out:
> > > +	kvfree(po);
> > > +	return rc;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
> > > +
> > >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> > >  {
> > >  	struct cxl_dev_state *cxlds;  
> >   

