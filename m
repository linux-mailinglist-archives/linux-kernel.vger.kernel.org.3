Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D15A7CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiHaML1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaMLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:11:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E412BCC34;
        Wed, 31 Aug 2022 05:11:23 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHjgW01Khz67xv7;
        Wed, 31 Aug 2022 20:10:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 14:11:20 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 13:11:20 +0100
Date:   Wed, 31 Aug 2022 13:11:19 +0100
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
Subject: Re: [PATCH 13/15] cxl/acpi: Rework devm_cxl_enumerate_ports() to
 support RCD mode
Message-ID: <20220831131119.00002c7f@huawei.com>
In-Reply-To: <20220831081603.3415-14-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-14-rrichter@amd.com>
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

On Wed, 31 Aug 2022 10:16:01 +0200
Robert Richter <rrichter@amd.com> wrote:

> RCD mode has a different enumeration scheme other than in CXL VH mode.
> An RCD is directly connected to an RCH without downstream and upstream
> ports showing up in between in the PCI hierarchy. Due to the direct
> connection of RCD and RCH, the host bridge is always the RCD's parent
> instead of the grandparent. 
Mentioned earlier, but that's not quite true.  There is a reference in
the spec to allowing it to be under a root port (some sort of virtual structure
- I'm not sure of 'why' you would that though.)(

> Modify devm_cxl_enumerate_ports()
> respectively.

Don't line wrap above.

> 
> Implement this by introducing a function to determine the device's
> downstream port. The 'for' loop is adjusted for RCD mode and in this
> case find_cxl_port() will always find the host's associated port and
> the loop iteration stops.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/port.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 61e9915162d5..08b99423dbf8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1084,6 +1084,22 @@ static struct device *grandparent(struct device *dev)
>  	return NULL;
>  }
>  
> +static struct device *cxl_mem_dport_dev(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = cxlmd->dev.parent;
> +	struct pci_dev *pdev = to_pci_dev(cxlmd->dev.parent);

to_pci_dev(dev);

> +
> +	/*
> +	 * An RCiEP is directly connected to the root bridge without
> +	 * any PCI bridges/ports in between. Reduce the parent level
> +	 * for those.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> +		return dev;
> +
> +	return dev->parent;
Switching from grandparent to this is a little confusing because it's
done in two steps.  Perhaps use
	return grandparent(cmlmd->dev);
here to keep that connection and rename dev in this function to parent.

Far too many devices in here with similar names for it to be easy
to read.


> +}
> +
>  static void delete_endpoint(void *data)
>  {
>  	struct cxl_memdev *cxlmd = data;
> @@ -1339,7 +1355,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
> -	struct device *iter;
> +	struct device *dport_dev;
>  	int rc;
>  
>  	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
> @@ -1352,25 +1368,21 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	 * attempt fails.
>  	 */
>  retry:
> -	for (iter = dev; iter; iter = grandparent(iter)) {
> -		struct device *dport_dev = grandparent(iter);
> +	for (dport_dev = cxl_mem_dport_dev(cxlmd); dport_dev;
> +	     dport_dev = grandparent(dport_dev)) {

I don't like looping for the RCD case as it relies a bit too
much on subtle relationships between devices and parent.

Perhaps better to factor out the contents of the loop, then handle
the RCD case separately from the main loop.
I haven't tried it, so perhaps that looks even less readable.


>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
>  		struct cxl_port *port;
>  
> -		if (!dport_dev)
> -			return 0;
> -
>  		uport_dev = dport_dev->parent;
>  		if (!uport_dev) {
> -			dev_warn(dev, "at %s no parent for dport: %s\n",
> -				 dev_name(iter), dev_name(dport_dev));
> +			dev_warn(dev, "no parent for dport: %s\n",
> +				 dev_name(dport_dev));
>  			return -ENXIO;
>  		}
>  
> -		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
> -			dev_name(iter), dev_name(dport_dev),
> -			dev_name(uport_dev));
> +		dev_dbg(dev, "scan: dport_dev: %s parent: %s\n",
> +			dev_name(dport_dev), dev_name(uport_dev));
>  		port = find_cxl_port(dport_dev, &dport);
>  		if (port) {
>  			dev_dbg(&cxlmd->dev,
> @@ -1418,7 +1430,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> +	return find_cxl_port(cxl_mem_dport_dev(cxlmd), dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
>  

