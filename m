Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EAD5A7D15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiHaMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHaMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:16:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB19CD520;
        Wed, 31 Aug 2022 05:16:38 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHjnV288Lz67tfn;
        Wed, 31 Aug 2022 20:15:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 14:16:36 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 13:16:35 +0100
Date:   Wed, 31 Aug 2022 13:16:34 +0100
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
Subject: Re: [PATCH 14/15] cxl/acpi: Enumerate ports in RCD mode to enable
 RCHs and RCDs
Message-ID: <20220831131634.00007870@huawei.com>
In-Reply-To: <20220831081603.3415-15-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-15-rrichter@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Wed, 31 Aug 2022 10:16:02 +0200
Robert Richter <rrichter@amd.com> wrote:

> Do the plumbing of ports to enable RCD/RCH pairs.
> 
> Do this by enumerating all necessary ports an endpoint needs to
> connect to. This includes:
> 
>  1) A CXL root port with dport links to the RCHs. The port links to
>     the CXL root platform device for RCH mode.
> 
>  2) RCH ports with dport links to its endpoints. Port connects to the
>     pci host bridge device.
> 
>  3) CXL device endpoint connected to the RCH.
> 
> The port creation for the endpoint (3) is already implemented and
> works in RCD mode too. Thus, it is not scope of this patch. Only the
> endpoints must be registered at the host bridge port.
> 
> Implement this by introducing the function cxl_enumerate_rch_ports().
> It registers a CXL host at the CXL root device, creates the host's
> port and registers the existing CXL memory device endpoint at it. The
> port of the CXL root device is created with the first CXL host being
> registered.
> 
> Once enumerated, CXL restricted hosts show up in sysfs with CXL
> devices connected as endpoints to it.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Hi Robert,

A few things inline.

Jonathan

> ---
>  drivers/cxl/acpi.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 88bbd2bb61fc..56b2d222afcc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -471,13 +471,52 @@ static int cxl_setup_component_reg(struct device *parent,
>  	return 0;
>  }
>  
> +static int cxl_enumerate_rch_ports(struct device *root_dev,
> +				   struct cxl_port *cxl_root,
> +				   struct pci_host_bridge *host,
> +				   resource_size_t component_reg_phys,
> +				   int port_id)
> +{
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	struct pci_dev *pdev;
> +
> +	dport = devm_cxl_add_dport(cxl_root, &host->dev, port_id,
> +				   component_reg_phys);
> +	if (IS_ERR(dport))
> +		return PTR_ERR(dport);
> +
> +	port = devm_cxl_add_port(root_dev, &host->dev,
> +				 component_reg_phys, dport);
> +	if (IS_ERR(port))
> +		return PTR_ERR(port);
> +
> +	pdev = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
> +	if (!pdev)
> +		return -ENXIO;
> +
> +	/* Note: The endpoint provides the component reg base. */

I'm not sure what this comment means.  Which component reg base?

> +	dport = devm_cxl_add_dport(port, &pdev->dev, 0,
> +				   CXL_RESOURCE_NONE);

Trivial: No need to wrap the above.

> +
> +	pci_dev_put(pdev);
> +
> +	if (IS_ERR(dport))
> +		return PTR_ERR(dport);
> +
> +	return 0;
> +}
> +
>  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  {
> +	struct device *root_dev = &pdev->dev;
>  	struct pci_host_bridge *host = NULL;
>  	struct acpi_device *adev;
> +	struct cxl_port *cxl_root = NULL;
>  	unsigned long long uid = ~0;
>  	resource_size_t rcrb;
>  	resource_size_t component_reg_phys;
> +	int port_id = 0;
>  	int rc;
>  
>  	while ((host = cxl_find_next_rch(host)) != NULL) {
> @@ -497,11 +536,30 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  
>  		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
>  
> +		/*
> +		 * For CXL 1.1 hosts we create a root device other
> +		 * than the ACPI0017 device to hold the devm data and
> +		 * the uport ref.
> +		 */
> +		if (!cxl_root) {
> +			cxl_root = devm_cxl_add_port(root_dev, root_dev,
> +						     CXL_RESOURCE_NONE, NULL);
> +			if (IS_ERR(cxl_root)) {
> +				rc = PTR_ERR(cxl_root);
> +				goto fail;
> +			}
> +		}
> +
>  		component_reg_phys = cxl_get_component_reg_phys(rcrb);
>  		rc = cxl_setup_component_reg(&host->dev, component_reg_phys);
>  		if (rc)
>  			goto fail;
>  
> +		rc = cxl_enumerate_rch_ports(root_dev, cxl_root, host,
> +					     component_reg_phys, port_id++);
> +		if (rc)
> +			goto fail;
> +
>  		dev_info(&host->dev, "host supports CXL\n");
>  	}
>  

