Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874050C5A4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiDWAKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDWAKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:10:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3318B2E;
        Fri, 22 Apr 2022 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650672472; x=1682208472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IArjNjJZz4Vc7BVwLKn3GsXeS47qYp1VbwvEuzMXHZA=;
  b=WUWSe0sh49fRrYPq0bc8+TRMYQch0xk7j5L8m1f2LYTtfZRv5EYYzjKK
   rskHQaw5Bl4ZMnnGf2S6WbcL56UxOfkB8dbtS0+JJU76WTJ2dJFBJEfel
   ohC6VTuMD+7+rIOB0bD96OFcZapAs3BbI1kW4JKJIydN7gTMXHqcWqjAa
   b76AktnSceE2naeAj/3FlaeW2Eyk16W5UkGYv0fMpeDCMuug1qpdmWHyd
   S48Z4jUngVX3uYjmFATGObEznLywl7M+dzS6SPLUPIySUUi66yUIQMPeD
   wCbgknQJtK+jEbmYDM6db/rQ9fBlIzVk4R7EheloEjV15FBlMUN3OEizw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325269478"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="325269478"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 17:07:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="531090618"
Received: from hltravis-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.166.215])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 17:07:51 -0700
Date:   Fri, 22 Apr 2022 17:07:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        peterz@infradead.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] cxl: Drop cxl_device_lock()
Message-ID: <YmNDVxnaWK8pBuN0@iweiny-desk3>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055520383.3745911.53447786039115271.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165055520383.3745911.53447786039115271.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:33:23AM -0700, Dan Williams wrote:
> Now that all CXL subsystem locking is validated with custom lock
> classes, there is no need for the custom usage of the lockdep_mutex.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/pmem.c |    4 +-
>  drivers/cxl/core/port.c |   55 ++++++++++++++-------------------
>  drivers/cxl/cxl.h       |   78 -----------------------------------------------
>  drivers/cxl/mem.c       |    4 +-
>  drivers/cxl/pmem.c      |   12 ++++---
>  lib/Kconfig.debug       |    6 ----
>  6 files changed, 33 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index e825e261278d..bec7cfb54ebf 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -124,10 +124,10 @@ static void unregister_nvb(void *_cxl_nvb)
>  	 * work to flush. Once the state has been changed to 'dead' then no new
>  	 * work can be queued by user-triggered bind.
>  	 */
> -	cxl_device_lock(&cxl_nvb->dev);
> +	device_lock(&cxl_nvb->dev);
>  	flush = cxl_nvb->state != CXL_NVB_NEW;
>  	cxl_nvb->state = CXL_NVB_DEAD;
> -	cxl_device_unlock(&cxl_nvb->dev);
> +	device_unlock(&cxl_nvb->dev);
>  
>  	/*
>  	 * Even though the device core will trigger device_release_driver()
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 750aac95ed5f..ea60abda6500 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -312,10 +312,10 @@ static void cxl_port_release(struct device *dev)
>  	struct cxl_port *port = to_cxl_port(dev);
>  	struct cxl_ep *ep, *_e;
>  
> -	cxl_device_lock(dev);
> +	device_lock(dev);
>  	list_for_each_entry_safe(ep, _e, &port->endpoints, list)
>  		cxl_ep_release(ep);
> -	cxl_device_unlock(dev);
> +	device_unlock(dev);
>  	ida_free(&cxl_port_ida, port->id);
>  	kfree(port);
>  }
> @@ -556,7 +556,7 @@ static int match_root_child(struct device *dev, const void *match)
>  		return 0;
>  
>  	port = to_cxl_port(dev);
> -	cxl_device_lock(dev);
> +	device_lock(dev);
>  	list_for_each_entry(dport, &port->dports, list) {
>  		iter = match;
>  		while (iter) {
> @@ -566,7 +566,7 @@ static int match_root_child(struct device *dev, const void *match)
>  		}
>  	}
>  out:
> -	cxl_device_unlock(dev);
> +	device_unlock(dev);
>  
>  	return !!iter;
>  }
> @@ -625,13 +625,13 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
>  static void cond_cxl_root_lock(struct cxl_port *port)
>  {
>  	if (is_cxl_root(port))
> -		cxl_device_lock(&port->dev);
> +		device_lock(&port->dev);
>  }
>  
>  static void cond_cxl_root_unlock(struct cxl_port *port)
>  {
>  	if (is_cxl_root(port))
> -		cxl_device_unlock(&port->dev);
> +		device_unlock(&port->dev);
>  }
>  
>  static void cxl_dport_remove(void *data)
> @@ -738,15 +738,15 @@ static int add_ep(struct cxl_port *port, struct cxl_ep *new)
>  {
>  	struct cxl_ep *dup;
>  
> -	cxl_device_lock(&port->dev);
> +	device_lock(&port->dev);
>  	if (port->dead) {
> -		cxl_device_unlock(&port->dev);
> +		device_unlock(&port->dev);
>  		return -ENXIO;
>  	}
>  	dup = find_ep(port, new->ep);
>  	if (!dup)
>  		list_add_tail(&new->list, &port->endpoints);
> -	cxl_device_unlock(&port->dev);
> +	device_unlock(&port->dev);
>  
>  	return dup ? -EEXIST : 0;
>  }
> @@ -856,12 +856,12 @@ static void delete_endpoint(void *data)
>  		goto out;
>  	parent = &parent_port->dev;
>  
> -	cxl_device_lock(parent);
> +	device_lock(parent);
>  	if (parent->driver && endpoint->uport) {
>  		devm_release_action(parent, cxl_unlink_uport, endpoint);
>  		devm_release_action(parent, unregister_port, endpoint);
>  	}
> -	cxl_device_unlock(parent);
> +	device_unlock(parent);
>  	put_device(parent);
>  out:
>  	put_device(&endpoint->dev);
> @@ -922,7 +922,7 @@ static void cxl_detach_ep(void *data)
>  		}
>  
>  		parent_port = to_cxl_port(port->dev.parent);
> -		cxl_device_lock(&parent_port->dev);
> +		device_lock(&parent_port->dev);
>  		if (!parent_port->dev.driver) {
>  			/*
>  			 * The bottom-up race to delete the port lost to a
> @@ -930,12 +930,12 @@ static void cxl_detach_ep(void *data)
>  			 * parent_port ->remove() will have cleaned up all
>  			 * descendants.
>  			 */
> -			cxl_device_unlock(&parent_port->dev);
> +			device_unlock(&parent_port->dev);
>  			put_device(&port->dev);
>  			continue;
>  		}
>  
> -		cxl_device_lock(&port->dev);
> +		device_lock(&port->dev);
>  		ep = find_ep(port, &cxlmd->dev);
>  		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
>  			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
> @@ -950,7 +950,7 @@ static void cxl_detach_ep(void *data)
>  			port->dead = true;
>  			list_splice_init(&port->dports, &reap_dports);
>  		}
> -		cxl_device_unlock(&port->dev);
> +		device_unlock(&port->dev);
>  
>  		if (!list_empty(&reap_dports)) {
>  			dev_dbg(&cxlmd->dev, "delete %s\n",
> @@ -958,7 +958,7 @@ static void cxl_detach_ep(void *data)
>  			delete_switch_port(port, &reap_dports);
>  		}
>  		put_device(&port->dev);
> -		cxl_device_unlock(&parent_port->dev);
> +		device_unlock(&parent_port->dev);
>  	}
>  }
>  
> @@ -1006,7 +1006,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -EAGAIN;
>  	}
>  
> -	cxl_device_lock(&parent_port->dev);
> +	device_lock(&parent_port->dev);
>  	if (!parent_port->dev.driver) {
>  		dev_warn(&cxlmd->dev,
>  			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> @@ -1024,7 +1024,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			get_device(&port->dev);
>  	}
>  out:
> -	cxl_device_unlock(&parent_port->dev);
> +	device_unlock(&parent_port->dev);
>  
>  	if (IS_ERR(port))
>  		rc = PTR_ERR(port);
> @@ -1135,14 +1135,14 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
>  {
>  	struct cxl_dport *dport;
>  
> -	cxl_device_lock(&port->dev);
> +	device_lock(&port->dev);
>  	list_for_each_entry(dport, &port->dports, list)
>  		if (dport->dport == dev) {
> -			cxl_device_unlock(&port->dev);
> +			device_unlock(&port->dev);
>  			return dport;
>  		}
>  
> -	cxl_device_unlock(&port->dev);
> +	device_unlock(&port->dev);
>  	return NULL;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
> @@ -1384,9 +1384,9 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  
>  	port = to_cxl_port(cxld->dev.parent);
>  
> -	cxl_device_lock(&port->dev);
> +	device_lock(&port->dev);
>  	rc = cxl_decoder_add_locked(cxld, target_map);
> -	cxl_device_unlock(&port->dev);
> +	device_unlock(&port->dev);
>  
>  	return rc;
>  }
> @@ -1457,14 +1457,7 @@ static int cxl_bus_probe(struct device *dev)
>  {
>  	int rc;
>  
> -	/*
> -	 * Take the CXL nested lock since the driver core only holds
> -	 * @dev->mutex and not @dev->lockdep_mutex.
> -	 */
> -	cxl_nested_lock(dev);
>  	rc = to_cxl_drv(dev->driver)->probe(dev);
> -	cxl_nested_unlock(dev);
> -
>  	dev_dbg(dev, "probe: %d\n", rc);
>  	return rc;
>  }
> @@ -1473,10 +1466,8 @@ static void cxl_bus_remove(struct device *dev)
>  {
>  	struct cxl_driver *cxl_drv = to_cxl_drv(dev->driver);
>  
> -	cxl_nested_lock(dev);
>  	if (cxl_drv->remove)
>  		cxl_drv->remove(dev);
> -	cxl_nested_unlock(dev);
>  }
>  
>  static struct workqueue_struct *cxl_bus_wq;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 990b6670222e..140dc3278cde 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -405,82 +405,4 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
>  #define __mock static
>  #endif
>  
> -#ifdef CONFIG_PROVE_CXL_LOCKING
> -enum cxl_lock_class {
> -	CXL_ANON_LOCK,
> -	CXL_NVDIMM_LOCK,
> -	CXL_NVDIMM_BRIDGE_LOCK,
> -	CXL_PORT_LOCK,
> -	/*
> -	 * Be careful to add new lock classes here, CXL_PORT_LOCK is
> -	 * extended by the port depth, so a maximum CXL port topology
> -	 * depth would need to be defined first.
> -	 */
> -};
> -
> -static inline void cxl_nested_lock(struct device *dev)
> -{
> -	if (is_cxl_port(dev)) {
> -		struct cxl_port *port = to_cxl_port(dev);
> -
> -		mutex_lock_nested(&dev->lockdep_mutex,
> -				  CXL_PORT_LOCK + port->depth);
> -	} else if (is_cxl_decoder(dev)) {
> -		struct cxl_port *port = to_cxl_port(dev->parent);
> -
> -		/*
> -		 * A decoder is the immediate child of a port, so set
> -		 * its lock class equal to other child device siblings.
> -		 */
> -		mutex_lock_nested(&dev->lockdep_mutex,
> -				  CXL_PORT_LOCK + port->depth + 1);
> -	} else if (is_cxl_nvdimm_bridge(dev))
> -		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_BRIDGE_LOCK);
> -	else if (is_cxl_nvdimm(dev))
> -		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_LOCK);
> -	else
> -		mutex_lock_nested(&dev->lockdep_mutex, CXL_ANON_LOCK);
> -}
> -
> -static inline void cxl_nested_unlock(struct device *dev)
> -{
> -	mutex_unlock(&dev->lockdep_mutex);
> -}
> -
> -static inline void cxl_device_lock(struct device *dev)
> -{
> -	/*
> -	 * For double lock errors the lockup will happen before lockdep
> -	 * warns at cxl_nested_lock(), so assert explicitly.
> -	 */
> -	lockdep_assert_not_held(&dev->lockdep_mutex);
> -
> -	device_lock(dev);
> -	cxl_nested_lock(dev);
> -}
> -
> -static inline void cxl_device_unlock(struct device *dev)
> -{
> -	cxl_nested_unlock(dev);
> -	device_unlock(dev);
> -}
> -#else
> -static inline void cxl_nested_lock(struct device *dev)
> -{
> -}
> -
> -static inline void cxl_nested_unlock(struct device *dev)
> -{
> -}
> -
> -static inline void cxl_device_lock(struct device *dev)
> -{
> -	device_lock(dev);
> -}
> -
> -static inline void cxl_device_unlock(struct device *dev)
> -{
> -	device_unlock(dev);
> -}
> -#endif
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 49a4b1c47299..91fb8d5b21a7 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -195,7 +195,7 @@ static int cxl_mem_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> -	cxl_device_lock(&parent_port->dev);
> +	device_lock(&parent_port->dev);
>  	if (!parent_port->dev.driver) {
>  		dev_err(dev, "CXL port topology %s not enabled\n",
>  			dev_name(&parent_port->dev));
> @@ -205,7 +205,7 @@ static int cxl_mem_probe(struct device *dev)
>  
>  	rc = create_endpoint(cxlmd, parent_port);
>  out:
> -	cxl_device_unlock(&parent_port->dev);
> +	device_unlock(&parent_port->dev);
>  	put_device(&parent_port->dev);
>  	return rc;
>  }
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 15ad666ab03e..b65a272a2d6d 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -43,7 +43,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	if (!cxl_nvb)
>  		return -ENXIO;
>  
> -	cxl_device_lock(&cxl_nvb->dev);
> +	device_lock(&cxl_nvb->dev);
>  	if (!cxl_nvb->nvdimm_bus) {
>  		rc = -ENXIO;
>  		goto out;
> @@ -68,7 +68,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	dev_set_drvdata(dev, nvdimm);
>  	rc = devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);
>  out:
> -	cxl_device_unlock(&cxl_nvb->dev);
> +	device_unlock(&cxl_nvb->dev);
>  	put_device(&cxl_nvb->dev);
>  
>  	return rc;
> @@ -233,7 +233,7 @@ static void cxl_nvb_update_state(struct work_struct *work)
>  	struct nvdimm_bus *victim_bus = NULL;
>  	bool release = false, rescan = false;
>  
> -	cxl_device_lock(&cxl_nvb->dev);
> +	device_lock(&cxl_nvb->dev);
>  	switch (cxl_nvb->state) {
>  	case CXL_NVB_ONLINE:
>  		if (!online_nvdimm_bus(cxl_nvb)) {
> @@ -251,7 +251,7 @@ static void cxl_nvb_update_state(struct work_struct *work)
>  	default:
>  		break;
>  	}
> -	cxl_device_unlock(&cxl_nvb->dev);
> +	device_unlock(&cxl_nvb->dev);
>  
>  	if (release)
>  		device_release_driver(&cxl_nvb->dev);
> @@ -327,9 +327,9 @@ static int cxl_nvdimm_bridge_reset(struct device *dev, void *data)
>  		return 0;
>  
>  	cxl_nvb = to_cxl_nvdimm_bridge(dev);
> -	cxl_device_lock(dev);
> +	device_lock(dev);
>  	cxl_nvb->state = CXL_NVB_NEW;
> -	cxl_device_unlock(dev);
> +	device_unlock(dev);
>  
>  	return 0;
>  }
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 075cd25363ac..4a2c853c948b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1559,12 +1559,6 @@ config PROVE_NVDIMM_LOCKING
>  	help
>  	  Enable lockdep to validate nd_device_lock() usage.
>  
> -config PROVE_CXL_LOCKING
> -	bool "CXL"
> -	depends on CXL_BUS
> -	help
> -	  Enable lockdep to validate cxl_device_lock() usage.
> -
>  endchoice
>  
>  endmenu # lock debugging
> 
