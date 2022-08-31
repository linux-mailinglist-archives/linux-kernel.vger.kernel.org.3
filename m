Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F215A7D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHaMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiHaMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:23:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6CCEB13;
        Wed, 31 Aug 2022 05:23:32 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHjst0WWpz684wN;
        Wed, 31 Aug 2022 20:19:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 14:23:30 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 13:23:30 +0100
Date:   Wed, 31 Aug 2022 13:23:29 +0100
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
Subject: Re: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Message-ID: <20220831132329.00007c46@huawei.com>
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Wed, 31 Aug 2022 10:15:48 +0200
Robert Richter <rrichter@amd.com> wrote:

> In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
> the PCIe enumeration hierarchy is different from CXL VH Enumeration
> (formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
> and 9.12, [1]). This series adds support for RCD mode. It implements
> the detection of Restricted CXL Hosts (RCHs) and its corresponding
> Restricted CXL Devices (RCDs). It does the necessary enumeration of
> ports and connects the endpoints. With all the plumbing an RCH/RCD
> pair is registered at the Linux CXL bus and becomes visible in sysfs
> in the same way as CXL VH hosts and devices do already. RCDs are
> brought up as CXL endpoints and bound to subsequent drivers such as
> cxl_mem.
> 
> For CXL VH the host driver (cxl_acpi) starts host bridge discovery
> once the ACPI0017 CXL root device is detected and then searches for
> ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
> might not necessarily exist and the host bridge can have a standard
> PCIe host bridge PNP0A08 ID, there aren't any CXL port or switches in
> the PCIe hierarchy visible. As such the RCD mode enumeration and host
> discovery is very different from CXL VH. See patch #5 for
> implementation details.
> 
> This implementation expects the host's downstream and upstream port
> RCRBs base address being reported by firmware using the optional CEDT
> CHBS entry of the host bridge (see CXL spec 3.0, 9.17.1.2).
> 
> RCD mode does not support hot-plug, so host discovery is at boot time
> only.
> 
> Patches #1 to #4 are prerequisites of the series with fixes needed and
> a rework of debug messages for port enumeration. Those are general
> patches and could be applied earlier and independently from the rest
> assuming there are no objections with them. Patches #5 to #15 contain
> the actual implementation of RCD mode support.
> 
> [1] https://www.computeexpresslink.org/spec-landing

Hi Robert,

I'm curious on the aims of this work.  Given expectation for RCDs is often
that the host firmware has set them up before the OS loads, what functionality
do you want to gain by mapping these into the CXL 2.0+ focused infrastructure?

When I did some analysis a while back on CXL 1.1 I was pretty much assuming
that there was no real reason to let the OS know about it because it
couldn't do much of any use with the information.  There are some corners
like RAS where it might be useful or perhaps to enable some of the CXL 3.0
features that are allowed to be EP only and so could be relevant for
an older host (e.g. CPMUs).

With my QEMU hat on I wasn't planning to bother with anything pre 2.0
but it might be worth considering to let us exercise this code...

Jonathan


> 
> Robert Richter (15):
>   cxl/core: Remove duplicate declaration of devm_cxl_iomap_block()
>   cxl/core: Check physical address before mapping it in
>     devm_cxl_iomap_block()
>   cxl: Unify debug messages when calling devm_cxl_add_port()
>   cxl: Unify debug messages when calling devm_cxl_add_dport()
>   cxl/acpi: Add probe function to detect restricted CXL hosts in RCD
>     mode
>   PCI/ACPI: Link host bridge to its ACPI fw node
>   cxl/acpi: Check RCH's PCIe Host Bridge ACPI ID
>   cxl/acpi: Check RCH's CXL DVSEC capabilities
>   cxl/acpi: Determine PCI host bridge's ACPI UID
>   cxl/acpi: Extract the RCH's RCRB base address from CEDT
>   cxl/acpi: Extract the host's component register base address from RCRB
>   cxl/acpi: Skip devm_cxl_port_enumerate_dports() when in RCD mode
>   cxl/acpi: Rework devm_cxl_enumerate_ports() to support RCD mode
>   cxl/acpi: Enumerate ports in RCD mode to enable RCHs and RCDs
>   cxl/acpi: Specify module load order dependency for the cxl_acpi module
> 
>  drivers/acpi/pci_root.c      |   1 +
>  drivers/cxl/acpi.c           | 311 ++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/pci.c       |  22 ++-
>  drivers/cxl/core/port.c      | 103 ++++++++----
>  drivers/cxl/core/regs.c      |   3 +
>  drivers/cxl/cxl.h            |   2 -
>  drivers/cxl/mem.c            |   1 +
>  tools/testing/cxl/test/cxl.c |   8 +-
>  8 files changed, 400 insertions(+), 51 deletions(-)
> 

