Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE65A93FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiIAKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiIAKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:14:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBF8130A29;
        Thu,  1 Sep 2022 03:14:07 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJH1c0PmLz67mqV;
        Thu,  1 Sep 2022 18:13:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:14:05 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 11:14:04 +0100
Date:   Thu, 1 Sep 2022 11:14:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 07/15] cxl/acpi: Check RCH's PCIe Host Bridge ACPI ID
Message-ID: <20220901111403.00003bff@huawei.com>
In-Reply-To: <YxBOVH+irgYSbEIz@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-8-rrichter@amd.com>
        <20220831112028.00002566@huawei.com>
        <YxBOVH+irgYSbEIz@rric.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Thu, 1 Sep 2022 08:16:52 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 31.08.22 11:20:28, Jonathan Cameron wrote:
> > Robert Richter <rrichter@amd.com> wrote:  
> 
> > > +static const struct acpi_device_id cxl_host_ids[] = {
> > > +	{ "ACPI0016", 0 },
> > > +	{ "PNP0A08", 0 },
> > > +	{ },  
> > 
> > Trivial but no comma after a null terminator.   Always good to make
> > it harder for people to add things where they really shouldn't!  
> 
> Can do this.
> 
> > pci_root.c avoids using an acpi_device_id table for similar matching.
> > I think the point being to separate probe type use of this table
> > from cases where we aren't using a normal device probe.
> > So to remain consistent with that, I would just grab the hid
> > and match it directly in this code.  
> 
> Grabbing the hid only is actually a violation of the acpi spec as a
> cid could be used interchangeable. It must also work then.
> 
> It is also not possible to use something like probe or a handler
> matching the ids because the hosts must be enabled with the already
> existing drivers and handlers. Suppose there are multiple handlers for
> the same ids, the first handler wins and all other never get called.
> 
> To me it looks sane and simple to use acpi_match_device_ids() here.

Ok. One for the ACPI maintainers to comment on if they wish - I'm fine with this

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> -Robert
> 
> > 
> > I don't feel that strongly about this if the ACPI maintainers are
> > fine with reusing this infrastructure as you have it here.  

