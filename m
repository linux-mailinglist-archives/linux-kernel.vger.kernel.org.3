Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE95A94E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiIAKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiIAKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:41:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CC12C3FA;
        Thu,  1 Sep 2022 03:41:37 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJHYm0cVWz67yhg;
        Thu,  1 Sep 2022 18:37:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:41:35 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 11:41:34 +0100
Date:   Thu, 1 Sep 2022 11:41:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Message-ID: <20220901114133.0000540c@huawei.com>
In-Reply-To: <YxBW8Kz/bgoMsAee@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-10-rrichter@amd.com>
        <20220831120027.000017b3@huawei.com>
        <YxBW8Kz/bgoMsAee@rric.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Thu, 1 Sep 2022 08:53:36 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 31.08.22 12:00:27, Jonathan Cameron wrote:
> > On Wed, 31 Aug 2022 10:15:57 +0200
> > Robert Richter <rrichter@amd.com> wrote:
> >   
> > > The UID is needed to read the RCH's CEDT entry with the RCRB base
> > > address. Determine the host's UID from its ACPI fw node.
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/acpi.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index f9cdf23a91a8..b3146b7ae922 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -368,8 +368,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > >  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> > >  {
> > >  	struct pci_host_bridge *host = NULL;
> > > +	struct acpi_device *adev;
> > > +	unsigned long long uid = ~0;
> > >  
> > >  	while ((host = cxl_find_next_rch(host)) != NULL) {
> > > +		adev = ACPI_COMPANION(&host->dev);
> > > +		if (!adev || !adev->pnp.unique_id ||
> > > +			(kstrtoull(adev->pnp.unique_id, 10, &uid) < 0))  
> > 
> > There is an acpi_device_uid() accessor function that should probably be
> > used here.  
> 
> That accessor actually does not help really, there is no null pointer
> check for adev. Using it actually adds more complexity since another
> variable is introduced plus you need to look at the function's
> implementation anyway.
> 
> The adev->pnp.unique_id access pattern is widely used in the kernel, I
> don't expect changes in the data struct here.

Ok.

> 
> > Also, should a fialure to convert to an integer (or one within
> > limits) be something we paper over?  Feels like we should fail
> > hard if that happens.  
> 
> This is a real corner case and close to a broken firmware
> implementation. I think current dbg messages are good to find where
> the detection stops.

Hmm. I don't like papering over such bugs as it leads to people not
fixing their bios as early as they otherwise would,
	but fair enough I guess.

> 
> > Admittedly I can't immediately find any spec that states that
> > the _UID should be either integer or under 32 bits...
> > ACPI allows a string and CXL just says it's 4 bytes long.  
> 
> IIRC the UID can be implemented as string or 8 bytes, there is no
> limitation then. That's why the range check below.
Ok.

All queries answered so

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> -Robert
> 
> >   
> > > +			continue;
> > > +
> > > +		dev_dbg(&adev->dev, "host uid: %llu\n", uid);
> > > +
> > > +		if (uid > U32_MAX)
> > > +			continue;
> > > +
> > >  		dev_info(&host->dev, "host supports CXL\n");
> > >  	}
> > >    
> >   

