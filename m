Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD549527F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377085AbiATQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:38:34 -0500
Received: from foss.arm.com ([217.140.110.172]:44576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376980AbiATQi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:38:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A7FDED1;
        Thu, 20 Jan 2022 08:38:28 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39FC53F73D;
        Thu, 20 Jan 2022 08:38:26 -0800 (PST)
Date:   Thu, 20 Jan 2022 16:38:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
Message-ID: <20220120163819.GA8187@lpieralisi>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
 <20211231033725.21109-3-ilkka@os.amperecomputing.com>
 <20220105104602.GA4752@lpieralisi>
 <alpine.DEB.2.22.394.2201051530290.2489@ubuntu200401>
 <alpine.DEB.2.22.394.2201131801380.3166@ubuntu200401>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2201131801380.3166@ubuntu200401>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 06:17:13PM -0800, Ilkka Koskinen wrote:
> 
> Hi Lorenzo,
> 
> On Wed, 5 Jan 2022, Ilkka Koskinen wrote:
> > 
> > Hi Lorenzo,
> > 
> > On Wed, 5 Jan 2022, Lorenzo Pieralisi wrote:
> > > [+James, for SDEI bits]
> > > 
> > > On Thu, Dec 30, 2021 at 07:37:25PM -0800, Ilkka Koskinen wrote:
> > > > ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
> > > > Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
> > > > issue diagnostic dump and reset via an SDEI event or an interrupt.
> > > > This patch implements SDEI path.
> > > > 
> > > > [0] https://developer.arm.com/documentation/den0093/latest/
> > > > 
> > > > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > ---
> > > >  drivers/acpi/arm64/Kconfig  |   8 +++
> > > >  drivers/acpi/arm64/Makefile |   1 +
> > > >  drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 134 insertions(+)
> > > >  create mode 100644 drivers/acpi/arm64/agdi.c
> 
> <snip>
> 
> > > > diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> > > > new file mode 100644
> > > > index 000000000000..6525ccbae5c1
> > > > --- /dev/null
> > > > +++ b/drivers/acpi/arm64/agdi.c
> 
> <snip>
> 
> > > > 
> > > > +static int __init agdi_init(void)
> > > > +{
> > > > +	int ret;
> > > > +	acpi_status status;
> > > > +	struct acpi_table_agdi *agdi_table;
> > > > +	struct agdi_data pdata;
> > > > +	struct platform_device *pdev;
> > > > +
> > > > +	if (acpi_disabled)
> > > > +		return 0;
> > > 
> > > Why don't we call agdi_init() from acpi_init() as we do for IORT/VIOT ?
> > > 
> > > I don't think it is necessary to add a device_initcall(), with related
> > > ordering dependencies.
> > 
> > That's a good point. I change it.
> 
> Actually, I looked at this more carefully. acpi_init() is called in
> subsys_initcall() while sdei_init() is called in subsys_initcall_sync().
> That is, if I call this function in acpi_init(), SDEI driver won't be ready
> and this driver fails to register the event.

Maybe this will help:

https://lore.kernel.org/linux-arm-kernel/20220120050522.23689-1-xueshuai@linux.alibaba.com/
