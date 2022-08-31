Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868225A7AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHaKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHaKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:00:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36751DEC4;
        Wed, 31 Aug 2022 02:59:49 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHflj3mCTz687Gp;
        Wed, 31 Aug 2022 17:59:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:59:46 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 10:59:46 +0100
Date:   Wed, 31 Aug 2022 10:59:45 +0100
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
Subject: Re: [PATCH 03/15] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <20220831105945.00004668@huawei.com>
In-Reply-To: <20220831081603.3415-4-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-4-rrichter@amd.com>
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

On Wed, 31 Aug 2022 10:15:51 +0200
Robert Richter <rrichter@amd.com> wrote:

> CXL ports are added in a couple of code paths using
> devm_cxl_add_port(). Debug messages are individually generated, but
> are incomplete and inconsistent. Change this by moving its generation
> to devm_cxl_add_port(). This unifies the messages and reduces code
> duplication. Also, generate messages on failure.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

This is one for Dan etc as it is mostly a question of how verbose we want
the debug prints to be plus preference for caller or callee being
responsible for outputting this sort of message.

Patch looks good to me if we want to make this sort of change.

> ---
>  drivers/cxl/acpi.c      |  2 --
>  drivers/cxl/core/port.c | 39 ++++++++++++++++++++++++++++-----------
>  2 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..767a91f44221 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -220,7 +220,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	port = devm_cxl_add_port(host, match, dport->component_reg_phys, dport);
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
> -	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
>  
>  	return 0;
>  }
> @@ -466,7 +465,6 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>  	if (IS_ERR(root_port))
>  		return PTR_ERR(root_port);
> -	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
>  
>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_dport);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bffde862de0b..8604cda88787 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -666,13 +666,17 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_dport *parent_dport)
>  {
> -	struct cxl_port *port;
> +	struct cxl_port *port, *parent_port;
>  	struct device *dev;
>  	int rc;
>  
> +	parent_port = parent_dport ? parent_dport->port : NULL;
> +
>  	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
> -	if (IS_ERR(port))
> -		return port;
> +	if (IS_ERR(port)) {
> +		rc = PTR_ERR(port);
> +		goto err_out;
> +	}
>  
>  	dev = &port->dev;
>  	if (is_cxl_memdev(uport))
> @@ -682,24 +686,39 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  	else
>  		rc = dev_set_name(dev, "root%d", port->id);
>  	if (rc)
> -		goto err;
> +		goto err_put;
>  
>  	rc = device_add(dev);
>  	if (rc)
> -		goto err;
> +		goto err_put;
>  
>  	rc = devm_add_action_or_reset(host, unregister_port, port);
>  	if (rc)
> -		return ERR_PTR(rc);
> +		goto err_out;
>  
>  	rc = devm_cxl_link_uport(host, port);
>  	if (rc)
> -		return ERR_PTR(rc);
> +		goto err_out;
>  
> -	return port;
> +	dev_dbg(host, "added %s as%s port of device %s%s%s\n",
> +		dev_name(&port->dev),
> +		parent_port ? "" : " root",
> +		dev_name(uport),
> +		parent_port ? " to parent port " : "",
> +		parent_port ? dev_name(&parent_port->dev) : "");
>  
> -err:
> +	return port;
> +err_put:
>  	put_device(dev);
> +err_out:
> +	dev_dbg(host, "failed to add %s as%s port of device %s%s%s: %d\n",
> +		dev_name(&port->dev),
> +		parent_port ? "" : " root",
> +		dev_name(uport),
> +		parent_port ? " to parent port " : "",
> +		parent_port ? dev_name(&parent_port->dev) : "",
> +		rc);
> +
>  	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
> @@ -1140,8 +1159,6 @@ int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
>  	if (IS_ERR(endpoint))
>  		return PTR_ERR(endpoint);
>  
> -	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
> -
>  	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
>  	if (rc)
>  		return rc;

