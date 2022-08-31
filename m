Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EED5A7BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiHaLJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiHaLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:09:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A386CE33C;
        Wed, 31 Aug 2022 04:09:13 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHhHh25zkz6896k;
        Wed, 31 Aug 2022 19:08:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:09:10 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 12:09:10 +0100
Date:   Wed, 31 Aug 2022 12:09:09 +0100
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
Subject: Re: [PATCH 10/15] cxl/acpi: Extract the RCH's RCRB base address
 from CEDT
Message-ID: <20220831120909.00004e49@huawei.com>
In-Reply-To: <20220831081603.3415-11-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-11-rrichter@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Wed, 31 Aug 2022 10:15:58 +0200
Robert Richter <rrichter@amd.com> wrote:

> The downstream and upstream port Root Complex Register Blocks (RCRBs)
> are needed to control the ports and CXL devices connected to it. It
> also includes the location of the RCH/RCD downstream and upstream port
> component registers in MEMBAR0. Extract the RCRB from the host's CEDT
> entry.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Hi Robert,

One trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index b3146b7ae922..439df9df2741 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -365,11 +365,48 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  	return NULL;
>  }
>  
> +static int __cxl_get_rcrb(union acpi_subtable_headers *header, void *arg,
> +			  const unsigned long end)
> +{
> +	struct cxl_chbs_context *ctx = arg;
> +	struct acpi_cedt_chbs *chbs;
> +
> +	if (ctx->chbcr)
> +		return 0;
> +
> +	chbs = (struct acpi_cedt_chbs *)header;
> +
> +	if (ctx->uid != chbs->uid)
> +		return 0;
> +
> +	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
> +		return 0;
> +
> +	if (chbs->length != SZ_8K)
> +		return 0;
> +
> +	ctx->chbcr = chbs->base;
> +
> +	return 0;
> +}
> +
> +static resource_size_t cxl_get_rcrb(u32 uid)
> +{
> +	struct cxl_chbs_context ctx = {
> +		.uid = uid,
> +	};
> +
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, __cxl_get_rcrb, &ctx);
> +
> +	return ctx.chbcr;
> +}
> +
>  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  {
>  	struct pci_host_bridge *host = NULL;
>  	struct acpi_device *adev;
>  	unsigned long long uid = ~0;
> +	resource_size_t rcrb;

Some of these could be made local to the while loop to reduce their scope.
>  
>  	while ((host = cxl_find_next_rch(host)) != NULL) {
>  		adev = ACPI_COMPANION(&host->dev);
> @@ -382,6 +419,12 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  		if (uid > U32_MAX)
>  			continue;
>  
> +		rcrb = cxl_get_rcrb(uid);
> +		if (!rcrb)
> +			continue;
> +
> +		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
> +
>  		dev_info(&host->dev, "host supports CXL\n");
>  	}
>  

