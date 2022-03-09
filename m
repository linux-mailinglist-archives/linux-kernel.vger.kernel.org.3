Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8973C4D38C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiCIS2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiCIS2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:28:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976EF3B560;
        Wed,  9 Mar 2022 10:26:55 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KDLHj2D4wz67drY;
        Thu, 10 Mar 2022 02:26:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 19:26:53 +0100
Received: from localhost (10.47.72.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 18:26:52 +0000
Date:   Wed, 9 Mar 2022 18:26:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH 04/11] cxl/core: Clamp max lock_class
Message-ID: <20220309182650.00006b28@Huawei.com>
In-Reply-To: <164610295187.2682974.18123746840987009597.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164610295187.2682974.18123746840987009597.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.72.217]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 18:49:11 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> MAX_LOCKDEP_SUBCLASSES limits the depth of the CXL topology that can be
> validated by lockdep. Given that the cxl_test topology is already at
> this limit collapse some of the levels and clamp the max depth.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/cxl.h |   21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 97e6ca7e4940..1357a245037d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -501,20 +501,33 @@ enum cxl_lock_class {
>  	CXL_ANON_LOCK,
>  	CXL_NVDIMM_LOCK,
>  	CXL_NVDIMM_BRIDGE_LOCK,

I'd be tempted to give explicit value to the one above as well
so it's immediate clear there is deliberate duplication here.

> -	CXL_PORT_LOCK,
> +	CXL_PORT_LOCK = 2,
>  	/*
>  	 * Be careful to add new lock classes here, CXL_PORT_LOCK is
>  	 * extended by the port depth, so a maximum CXL port topology
> -	 * depth would need to be defined first.
> +	 * depth would need to be defined first. Also, the max
> +	 * validation depth is limited by MAX_LOCKDEP_SUBCLASSES.
>  	 */
>  };
>  
> +static inline int clamp_lock_class(struct device *dev, int lock_class)
> +{
> +	if (lock_class >= MAX_LOCKDEP_SUBCLASSES) {
> +		dev_warn_once(dev,
> +			      "depth: %d, disabling lockdep for this device\n",
> +			      lock_class);
> +		return 0;
> +	}
> +
> +	return lock_class;
> +}
> +
>  static inline int cxl_lock_class(struct device *dev)
>  {
>  	if (is_cxl_port(dev)) {
>  		struct cxl_port *port = to_cxl_port(dev);
>  
> -		return CXL_PORT_LOCK + port->depth;
> +		return clamp_lock_class(dev, CXL_PORT_LOCK + port->depth);
>  	} else if (is_cxl_decoder(dev)) {
>  		struct cxl_port *port = to_cxl_port(dev->parent);
>  
> @@ -522,7 +535,7 @@ static inline int cxl_lock_class(struct device *dev)
>  		 * A decoder is the immediate child of a port, so set
>  		 * its lock class equal to other child device siblings.
>  		 */
> -		return CXL_PORT_LOCK + port->depth + 1;
> +		return clamp_lock_class(dev, CXL_PORT_LOCK + port->depth + 1);
>  	} else if (is_cxl_nvdimm_bridge(dev))
>  		return CXL_NVDIMM_BRIDGE_LOCK;
>  	else if (is_cxl_nvdimm(dev))
> 

