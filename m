Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C15A7AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiHaKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHaKIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:08:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55494CCD7E;
        Wed, 31 Aug 2022 03:08:08 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHfsd6qZTz682Y2;
        Wed, 31 Aug 2022 18:04:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 12:08:06 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 11:08:05 +0100
Date:   Wed, 31 Aug 2022 11:08:04 +0100
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
Message-ID: <20220831110804.00003812@huawei.com>
In-Reply-To: <20220831081603.3415-6-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-6-rrichter@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Wed, 31 Aug 2022 10:15:53 +0200
Robert Richter <rrichter@amd.com> wrote:

> Restricted CXL device (RCD) mode (formerly CXL 1.1) uses a different
> enumeration scheme other than CXL VH (formerly CXL 2.0). In RCD mode a
> host/device (RCH-RCD) pair shows up as a legal PCIe hierarchy with an
> ACPI host bridge ("PNP0A08" or "ACPI0016" HID) and RCiEP connected to
> it with a description of the CXL device.
> 
> Add function cxl_restricted_host_probe() to probe RCD enumerated
> devices. The function implements a loop that detects all CXL capable
> ACPI PCI root bridges in the system (RCD mode only). The iterator
> function cxl_find_next_rch() is introduced to walk through all of the
> CXL hosts. The loop will then enable all CXL devices connected to the
> host. For now, only implement an empty loop with an iterator that
> returns all pci host bridges in the system.
> 
> The probe function is triggered by adding an own root device for RCHs.
> This is different to CXL VH where an ACPI "ACPI0017" root device
> exists. Its detection starts the CXL host detection. In RCD mode such
> a device does not necessarily exists, so solve this by creating a
> plain platform device that is not an ACPI device and is root only for
> RCHs.

If I read this correctly that platform device is created whether or not
there are any cxl devices in the system?

Can we create it only if we find some devices that will be placed
under it later?

Jonathan

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 31e104f0210f..a19e3154dd44 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -312,6 +312,33 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  	return 1;
>  }
>  
> +struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host ? host->bus : NULL;
> +
> +	while ((bus = pci_find_next_bus(bus)) != NULL) {
> +		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> +		if (!host)
> +			continue;
> +
> +		dev_dbg(&host->dev, "PCI bridge found\n");
> +
> +		return host;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> +{
> +	struct pci_host_bridge *host = NULL;
> +
> +	while ((host = cxl_find_next_rch(host)) != NULL) {
> +	}
> +
> +	return 0;
> +}
> +
>  static struct lock_class_key cxl_root_key;
>  
>  static void cxl_acpi_lock_reset_class(void *dev)
> @@ -445,6 +472,13 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *adev = ACPI_COMPANION(host);
>  	struct cxl_cfmws_context ctx;
>  
> +	/*
> +	 * For RCH (CXL 1.1 hosts) the probe is triggered by a plain
> +	 * platform dev which does not have an acpi companion.
> +	 */
> +	if (!adev)
> +		return cxl_restricted_host_probe(pdev);
> +
>  	device_lock_set_class(&pdev->dev, &cxl_root_key);
>  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
>  				      &pdev->dev);
> @@ -518,6 +552,7 @@ MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
>  
>  static const struct platform_device_id cxl_test_ids[] = {
>  	{ "cxl_acpi" },
> +	{ "cxl_root" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, cxl_test_ids);
> @@ -531,7 +566,41 @@ static struct platform_driver cxl_acpi_driver = {
>  	.id_table = cxl_test_ids,
>  };
>  
> -module_platform_driver(cxl_acpi_driver);
> +static void cxl_acpi_device_release(struct device *dev) { }

Why the empty release?  Perhaps introduce this only when it
does something.

> +
> +static struct platform_device cxl_acpi_device = {
> +	.name = "cxl_root",
> +	.id = PLATFORM_DEVID_NONE,
> +	.dev = {
> +		.release = cxl_acpi_device_release,
> +	}
> +};
> +
> +static int __init cxl_host_init(void)
> +{
> +	int rc;
> +
> +	/* Kick off restricted host (CXL 1.1) detection */
> +	rc = platform_device_register(&cxl_acpi_device);
> +	if (rc) {
> +		platform_device_put(&cxl_acpi_device);
> +		return rc;
> +	}
> +	rc = platform_driver_register(&cxl_acpi_driver);
> +	if (rc)
> +		platform_device_unregister(&cxl_acpi_device);
> +	return rc;
> +}
> +
> +static void __exit cxl_host_exit(void)
> +{
> +	platform_driver_unregister(&cxl_acpi_driver);
> +	platform_device_unregister(&cxl_acpi_device);
> +}
> +
> +module_init(cxl_host_init);
> +module_exit(cxl_host_exit);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_IMPORT_NS(ACPI);

