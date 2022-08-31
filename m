Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C524A5A7B41
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiHaKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiHaKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:20:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1C1D33C;
        Wed, 31 Aug 2022 03:20:31 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHg7x5JrLz68BVJ;
        Wed, 31 Aug 2022 18:16:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 12:20:29 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 11:20:29 +0100
Date:   Wed, 31 Aug 2022 11:20:28 +0100
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
Message-ID: <20220831112028.00002566@huawei.com>
In-Reply-To: <20220831081603.3415-8-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-8-rrichter@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Wed, 31 Aug 2022 10:15:55 +0200
Robert Richter <rrichter@amd.com> wrote:

> An RCH is a root bridge and has "PNP0A08" or "ACPI0016" ACPI ID set.
> Check this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Hi Robert,

I'm a little uncomfortable with repurposing acpi_device_id
as you have done here.  Might be better to do the same
as in pci_root.c where the matches are done more directly.

> ---
>  drivers/cxl/acpi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a19e3154dd44..ffdf439adb87 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -312,9 +312,16 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  	return 1;
>  }
>  
> +static const struct acpi_device_id cxl_host_ids[] = {
> +	{ "ACPI0016", 0 },
> +	{ "PNP0A08", 0 },
> +	{ },

Trivial but no comma after a null terminator.   Always good to make
it harder for people to add things where they really shouldn't!

pci_root.c avoids using an acpi_device_id table for similar matching.
I think the point being to separate probe type use of this table
from cases where we aren't using a normal device probe.
So to remain consistent with that, I would just grab the hid
and match it directly in this code.

I don't feel that strongly about this if the ACPI maintainers are
fine with reusing this infrastructure as you have it here.


> +};
> +
>  struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  {
>  	struct pci_bus *bus = host ? host->bus : NULL;
> +	struct acpi_device *adev;
>  
>  	while ((bus = pci_find_next_bus(bus)) != NULL) {
>  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> @@ -323,6 +330,19 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  
>  		dev_dbg(&host->dev, "PCI bridge found\n");
>  
> +		/* Must be a root bridge */
> +		if (host->bus->parent)
> +			continue;
> +
> +		dev_dbg(&host->dev, "PCI bridge is root bridge\n");
> +
> +		adev = ACPI_COMPANION(&host->dev);
> +		if (acpi_match_device_ids(adev, cxl_host_ids))
> +			continue;
> +
> +		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
> +			acpi_dev_name(adev));
> +
>  		return host;
>  	}
>  

