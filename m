Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE15A93EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiIAKKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiIAKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:10:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBAAAA3FF;
        Thu,  1 Sep 2022 03:10:42 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJGxg5Qz1z67xt4;
        Thu,  1 Sep 2022 18:09:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:10:40 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 11:10:40 +0100
Date:   Thu, 1 Sep 2022 11:10:38 +0100
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
Subject: Re: [PATCH 05/15] cxl/acpi: Add probe function to detect restricted
 CXL hosts in RCD mode
Message-ID: <20220901111038.00002e00@huawei.com>
In-Reply-To: <YxBKoT2zlUVgXIry@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-6-rrichter@amd.com>
        <20220831110804.00003812@huawei.com>
        <YxBKoT2zlUVgXIry@rric.localdomain>
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

On Thu, 1 Sep 2022 08:01:05 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 31.08.22 11:08:04, Jonathan Cameron wrote:
> > On Wed, 31 Aug 2022 10:15:53 +0200  
> 
> > Robert Richter <rrichter@amd.com> wrote:
> >   
> > > Restricted CXL device (RCD) mode (formerly CXL 1.1) uses a different
> > > enumeration scheme other than CXL VH (formerly CXL 2.0). In RCD mode a
> > > host/device (RCH-RCD) pair shows up as a legal PCIe hierarchy with an
> > > ACPI host bridge ("PNP0A08" or "ACPI0016" HID) and RCiEP connected to
> > > it with a description of the CXL device.
> > > 
> > > Add function cxl_restricted_host_probe() to probe RCD enumerated
> > > devices. The function implements a loop that detects all CXL capable
> > > ACPI PCI root bridges in the system (RCD mode only). The iterator
> > > function cxl_find_next_rch() is introduced to walk through all of the
> > > CXL hosts. The loop will then enable all CXL devices connected to the
> > > host. For now, only implement an empty loop with an iterator that
> > > returns all pci host bridges in the system.
> > > 
> > > The probe function is triggered by adding an own root device for RCHs.
> > > This is different to CXL VH where an ACPI "ACPI0017" root device
> > > exists. Its detection starts the CXL host detection. In RCD mode such
> > > a device does not necessarily exists, so solve this by creating a
> > > plain platform device that is not an ACPI device and is root only for
> > > RCHs.  
> > 
> > If I read this correctly that platform device is created whether or not
> > there are any cxl devices in the system?
> > 
> > Can we create it only if we find some devices that will be placed
> > under it later?  
> 
> This would move the host detection from probe to init which I wanted
> to avoid to better control driver init order dependencies.

It's a bit nasty either way.  I can see your reasoning, but
definitely not keen on it if there is a plausible way to avoid.
> 
> I could add a put_device() at the end of a probe so that it will be
> released in case no other references use it. This implies the refcount
> is maintained for parent devices. Or this needs to be added to. So if
> there are no children (hosts) attached to the root device after probe,
> it will disappear.

Unless there is precedence for that, it'll be weird enough to be
hard to maintain.  I guess I can live with the ugliness if we can't
add something new to ACPI to base this off.

> 
> > > @@ -531,7 +566,41 @@ static struct platform_driver cxl_acpi_driver = {
> > >  	.id_table = cxl_test_ids,
> > >  };
> > >  
> > > -module_platform_driver(cxl_acpi_driver);
> > > +static void cxl_acpi_device_release(struct device *dev) { }  
> > 
> > Why the empty release?  Perhaps introduce this only when it
> > does something.  
> 
> The core device driver requires this in device_release() to be setup.
> 
> There is nothing to do as the device is kept in a static struct.
> That's why it's empty.
Ah got it. I'd failed to register the static structure.

> 
> -Robert

