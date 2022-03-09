Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B64D38A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiCISTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiCISTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:19:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541E15A18;
        Wed,  9 Mar 2022 10:18:51 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KDL5K3dbKz67LM6;
        Thu, 10 Mar 2022 02:17:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 9 Mar 2022 19:18:48 +0100
Received: from localhost (10.47.72.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 18:18:47 +0000
Date:   Wed, 9 Mar 2022 18:18:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH 02/11] cxl/core: Refactor a cxl_lock_class() out of
 cxl_nested_lock()
Message-ID: <20220309181843.000003fe@Huawei.com>
In-Reply-To: <164610294030.2682974.642590821548098371.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164610294030.2682974.642590821548098371.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Mon, 28 Feb 2022 18:49:00 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for upleveling device_lock() lockdep annotation support into
> the core, provide a helper to retrieve the lock class. This lock_class
> will be used with device_set_lock_class() to idenify the CXL nested

idenify?

> locking rules.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Otherwise looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5486fb6aebd4..ca8a61a623b7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -509,13 +509,12 @@ enum cxl_lock_class {
>  	 */
>  };
>  
> -static inline void cxl_nested_lock(struct device *dev)
> +static inline int cxl_lock_class(struct device *dev)
>  {
>  	if (is_cxl_port(dev)) {
>  		struct cxl_port *port = to_cxl_port(dev);
>  
> -		mutex_lock_nested(&dev->lockdep_mutex,
> -				  CXL_PORT_LOCK + port->depth);
> +		return CXL_PORT_LOCK + port->depth;
>  	} else if (is_cxl_decoder(dev)) {
>  		struct cxl_port *port = to_cxl_port(dev->parent);
>  
> @@ -523,14 +522,18 @@ static inline void cxl_nested_lock(struct device *dev)
>  		 * A decoder is the immediate child of a port, so set
>  		 * its lock class equal to other child device siblings.
>  		 */
> -		mutex_lock_nested(&dev->lockdep_mutex,
> -				  CXL_PORT_LOCK + port->depth + 1);
> +		return CXL_PORT_LOCK + port->depth + 1;
>  	} else if (is_cxl_nvdimm_bridge(dev))
> -		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_BRIDGE_LOCK);
> +		return CXL_NVDIMM_BRIDGE_LOCK;
>  	else if (is_cxl_nvdimm(dev))
> -		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_LOCK);
> +		return CXL_NVDIMM_LOCK;
>  	else
> -		mutex_lock_nested(&dev->lockdep_mutex, CXL_ANON_LOCK);
> +		return CXL_ANON_LOCK;
> +}
> +
> +static inline void cxl_nested_lock(struct device *dev)
> +{
> +	mutex_lock_nested(&dev->lockdep_mutex, cxl_lock_class(dev));
>  }
>  
>  static inline void cxl_nested_unlock(struct device *dev)
> 

