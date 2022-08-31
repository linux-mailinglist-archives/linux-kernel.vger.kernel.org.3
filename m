Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCF5A7BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiHaKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiHaKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:52:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CBE9E2C7;
        Wed, 31 Aug 2022 03:52:28 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHgwM3trrz67ZXD;
        Wed, 31 Aug 2022 18:51:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 12:52:25 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 11:52:25 +0100
Date:   Wed, 31 Aug 2022 11:52:24 +0100
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
Subject: Re: [PATCH 08/15] cxl/acpi: Check RCH's CXL DVSEC capabilities
Message-ID: <20220831115224.00003afd@huawei.com>
In-Reply-To: <20220831081603.3415-9-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-9-rrichter@amd.com>
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

On Wed, 31 Aug 2022 10:15:56 +0200
Robert Richter <rrichter@amd.com> wrote:

> An RCH has an RCiEP connected to it with CXL DVSEC capabilities
> present and the CXL PCIe DVSEC included. Check this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
One comment inline. This looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index ffdf439adb87..f9cdf23a91a8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -322,6 +322,8 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  {
>  	struct pci_bus *bus = host ? host->bus : NULL;
>  	struct acpi_device *adev;
> +	struct pci_dev *pdev;
> +	bool is_restricted_host;
>  
>  	while ((bus = pci_find_next_bus(bus)) != NULL) {
>  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> @@ -343,6 +345,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
>  			acpi_dev_name(adev));
>  
> +		/* Check CXL DVSEC of dev 0 func 0 */

So assumption here is that the hostbridge has a one or more RCiEPs.
The spec (r3.0 9.11.4) allows for the EP to appear behind a root port
- that case always felt odd to me, so I'm fine with not supporting it until
we see a user.

> +		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> +		is_restricted_host = pdev
> +			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> +			&& pci_find_dvsec_capability(pdev,
> +						PCI_DVSEC_VENDOR_ID_CXL,
> +						CXL_DVSEC_PCIE_DEVICE);
> +		pci_dev_put(pdev);
> +
> +		if (!is_restricted_host)
> +			continue;
> +
> +		dev_dbg(&host->dev, "CXL restricted host found\n");
> +
>  		return host;
>  	}
>  
> @@ -354,6 +370,7 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  	struct pci_host_bridge *host = NULL;
>  
>  	while ((host = cxl_find_next_rch(host)) != NULL) {
> +		dev_info(&host->dev, "host supports CXL\n");
>  	}
>  
>  	return 0;

