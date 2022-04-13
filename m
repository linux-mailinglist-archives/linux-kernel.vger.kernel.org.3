Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC944FF3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiDMJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiDMJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:42:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D642E0AE;
        Wed, 13 Apr 2022 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UFEvVEPP/ZgNd4BfkJxogNQd+MVlwANmMEZKhdkYdAw=; b=uRWQyn6ZrANh0GbXqBPc3vJndI
        MDx5h6Y4vOyeMHmw4BrbX62Wiblzdx/oXv/3ky6MKKEoctY81wYvZz3iHphkemCEhjWBaVLePbprk
        91VPMjVG03f1fiiFdH1zoMgLuBeB62CXFuRmo0Bi0/kRyHibu6Re5yVpUXVxCkQv776SD6q/aMLY3
        /ibyP/gQ3ZhRqnxWEGlOE/P/DqrUzRfkCYUKMPeqMgmbr6nNmRkBwkD051xXbDuYDR3qS6hbyUpsC
        KXRVRNQCr9uGWwY3IhbomCTEVipSfwYBqL8jyRMnBNsETn0vH+iX/rldhfBOq6Q/WWgzO61x64X1g
        KpGalxXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neZTa-00E9IH-Rk; Wed, 13 Apr 2022 09:39:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 306AE9861CB; Wed, 13 Apr 2022 11:39:49 +0200 (CEST)
Date:   Wed, 13 Apr 2022 11:39:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v2 03/12] cxl/core: Refactor a cxl_lock_class() out of
 cxl_nested_lock()
Message-ID: <20220413093949.GW2731@worktop.programming.kicks-ass.net>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164982970436.684294.12004091884213856239.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164982970436.684294.12004091884213856239.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


*Completely* untested (I wouldn't know where to begin and probably odn't
have the hardware anyway), and known incomplete.

What's wrong with something like this then?

---
 drivers/cxl/core/pmem.c |  8 +++++
 drivers/cxl/core/port.c | 58 +++++++++++++++++++++---------------
 drivers/cxl/cxl.h       | 78 -------------------------------------------------
 3 files changed, 42 insertions(+), 102 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 8de240c4d96b..aca0dd5eefeb 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -80,6 +80,8 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_nvdimm_bridge, CXL);
 
+static lock_class_key cxl_nvdimm_bridge_key;
+
 static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb;
@@ -104,6 +106,8 @@ static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_nvdimm_bridge_type;
 
+	lockdep_set_class(&dev->mutex, &cxl_nvdimm_bridge_key);
+
 	return cxl_nvb;
 
 err:
@@ -214,6 +218,8 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_nvdimm, CXL);
 
+static struct lock_class_key cxl_nvdimm_key;
+
 static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
 {
 	struct cxl_nvdimm *cxl_nvd;
@@ -231,6 +237,8 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_nvdimm_type;
 
+	lockdep_set_class(&dev->mutex, &cxl_nvdimm_key);
+
 	return cxl_nvd;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2ab1ba4499b3..cae88404612f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -312,10 +312,10 @@ static void cxl_port_release(struct device *dev)
 	struct cxl_port *port = to_cxl_port(dev);
 	struct cxl_ep *ep, *_e;
 
-	cxl_device_lock(dev);
+	device_lock(dev);
 	list_for_each_entry_safe(ep, _e, &port->endpoints, list)
 		cxl_ep_release(ep);
-	cxl_device_unlock(dev);
+	device_unlock(dev);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -391,6 +391,8 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
 	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
 }
 
+static struct lock_class_key cxl_port_key;
+
 static struct cxl_port *cxl_port_alloc(struct device *uport,
 				       resource_size_t component_reg_phys,
 				       struct cxl_port *parent_port)
@@ -431,6 +433,8 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_port_type;
 
+	lockdep_set_class(&dev->mutex, &cxl_port_key);
+
 	return port;
 
 err:
@@ -457,8 +461,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	if (IS_ERR(port))
 		return port;
 
-	if (parent_port)
+	if (parent_port) {
 		port->depth = parent_port->depth + 1;
+		lockdep_set_class_and_subclass(&port->dev->mutex, &cxl_port, port->depth);
+	}
 	dev = &port->dev;
 	if (is_cxl_memdev(uport))
 		rc = dev_set_name(dev, "endpoint%d", port->id);
@@ -554,7 +560,7 @@ static int match_root_child(struct device *dev, const void *match)
 		return 0;
 
 	port = to_cxl_port(dev);
-	cxl_device_lock(dev);
+	device_lock(dev);
 	list_for_each_entry(dport, &port->dports, list) {
 		iter = match;
 		while (iter) {
@@ -564,7 +570,7 @@ static int match_root_child(struct device *dev, const void *match)
 		}
 	}
 out:
-	cxl_device_unlock(dev);
+	device_unlock(dev);
 
 	return !!iter;
 }
@@ -623,13 +629,13 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 static void cond_cxl_root_lock(struct cxl_port *port)
 {
 	if (is_cxl_root(port))
-		cxl_device_lock(&port->dev);
+		device_lock(&port->dev);
 }
 
 static void cond_cxl_root_unlock(struct cxl_port *port)
 {
 	if (is_cxl_root(port))
-		cxl_device_unlock(&port->dev);
+		device_unlock(&port->dev);
 }
 
 static void cxl_dport_remove(void *data)
@@ -736,15 +742,15 @@ static int add_ep(struct cxl_port *port, struct cxl_ep *new)
 {
 	struct cxl_ep *dup;
 
-	cxl_device_lock(&port->dev);
+	device_lock(&port->dev);
 	if (port->dead) {
-		cxl_device_unlock(&port->dev);
+		device_unlock(&port->dev);
 		return -ENXIO;
 	}
 	dup = find_ep(port, new->ep);
 	if (!dup)
 		list_add_tail(&new->list, &port->endpoints);
-	cxl_device_unlock(&port->dev);
+	device_unlock(&port->dev);
 
 	return dup ? -EEXIST : 0;
 }
@@ -854,12 +860,12 @@ static void delete_endpoint(void *data)
 		goto out;
 	parent = &parent_port->dev;
 
-	cxl_device_lock(parent);
+	device_lock(parent);
 	if (parent->driver && endpoint->uport) {
 		devm_release_action(parent, cxl_unlink_uport, endpoint);
 		devm_release_action(parent, unregister_port, endpoint);
 	}
-	cxl_device_unlock(parent);
+	device_unlock(parent);
 	put_device(parent);
 out:
 	put_device(&endpoint->dev);
@@ -920,7 +926,7 @@ static void cxl_detach_ep(void *data)
 		}
 
 		parent_port = to_cxl_port(port->dev.parent);
-		cxl_device_lock(&parent_port->dev);
+		device_lock(&parent_port->dev);
 		if (!parent_port->dev.driver) {
 			/*
 			 * The bottom-up race to delete the port lost to a
@@ -928,12 +934,12 @@ static void cxl_detach_ep(void *data)
 			 * parent_port ->remove() will have cleaned up all
 			 * descendants.
 			 */
-			cxl_device_unlock(&parent_port->dev);
+			device_unlock(&parent_port->dev);
 			put_device(&port->dev);
 			continue;
 		}
 
-		cxl_device_lock(&port->dev);
+		device_lock(&port->dev);
 		ep = find_ep(port, &cxlmd->dev);
 		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
@@ -948,7 +954,7 @@ static void cxl_detach_ep(void *data)
 			port->dead = true;
 			list_splice_init(&port->dports, &reap_dports);
 		}
-		cxl_device_unlock(&port->dev);
+		device_unlock(&port->dev);
 
 		if (!list_empty(&reap_dports)) {
 			dev_dbg(&cxlmd->dev, "delete %s\n",
@@ -956,7 +962,7 @@ static void cxl_detach_ep(void *data)
 			delete_switch_port(port, &reap_dports);
 		}
 		put_device(&port->dev);
-		cxl_device_unlock(&parent_port->dev);
+		device_unlock(&parent_port->dev);
 	}
 }
 
@@ -1004,7 +1010,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -EAGAIN;
 	}
 
-	cxl_device_lock(&parent_port->dev);
+	device_lock(&parent_port->dev);
 	if (!parent_port->dev.driver) {
 		dev_warn(&cxlmd->dev,
 			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
@@ -1022,7 +1028,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			get_device(&port->dev);
 	}
 out:
-	cxl_device_unlock(&parent_port->dev);
+	device_unlock(&parent_port->dev);
 
 	if (IS_ERR(port))
 		rc = PTR_ERR(port);
@@ -1133,14 +1139,14 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 {
 	struct cxl_dport *dport;
 
-	cxl_device_lock(&port->dev);
+	device_lock(&port->dev);
 	list_for_each_entry(dport, &port->dports, list)
 		if (dport->dport == dev) {
-			cxl_device_unlock(&port->dev);
+			device_unlock(&port->dev);
 			return dport;
 		}
 
-	cxl_device_unlock(&port->dev);
+	device_unlock(&port->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
@@ -1173,6 +1179,8 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	return rc;
 }
 
+static struct lock_class_key cxl_decoder_key;
+
 /**
  * cxl_decoder_alloc - Allocate a new CXL decoder
  * @port: owning port of this decoder
@@ -1224,6 +1232,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	else
 		cxld->dev.type = &cxl_decoder_switch_type;
 
+	lockdep_set_class(&dev->mutex, cxl_decoder_key);
+
 	/* Pre initialize an "empty" decoder */
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
@@ -1379,9 +1389,9 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
 	port = to_cxl_port(cxld->dev.parent);
 
-	cxl_device_lock(&port->dev);
+	device_lock(&port->dev);
 	rc = cxl_decoder_add_locked(cxld, target_map);
-	cxl_device_unlock(&port->dev);
+	device_unlock(&port->dev);
 
 	return rc;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 990b6670222e..140dc3278cde 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -405,82 +405,4 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
 #define __mock static
 #endif
 
-#ifdef CONFIG_PROVE_CXL_LOCKING
-enum cxl_lock_class {
-	CXL_ANON_LOCK,
-	CXL_NVDIMM_LOCK,
-	CXL_NVDIMM_BRIDGE_LOCK,
-	CXL_PORT_LOCK,
-	/*
-	 * Be careful to add new lock classes here, CXL_PORT_LOCK is
-	 * extended by the port depth, so a maximum CXL port topology
-	 * depth would need to be defined first.
-	 */
-};
-
-static inline void cxl_nested_lock(struct device *dev)
-{
-	if (is_cxl_port(dev)) {
-		struct cxl_port *port = to_cxl_port(dev);
-
-		mutex_lock_nested(&dev->lockdep_mutex,
-				  CXL_PORT_LOCK + port->depth);
-	} else if (is_cxl_decoder(dev)) {
-		struct cxl_port *port = to_cxl_port(dev->parent);
-
-		/*
-		 * A decoder is the immediate child of a port, so set
-		 * its lock class equal to other child device siblings.
-		 */
-		mutex_lock_nested(&dev->lockdep_mutex,
-				  CXL_PORT_LOCK + port->depth + 1);
-	} else if (is_cxl_nvdimm_bridge(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_BRIDGE_LOCK);
-	else if (is_cxl_nvdimm(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_LOCK);
-	else
-		mutex_lock_nested(&dev->lockdep_mutex, CXL_ANON_LOCK);
-}
-
-static inline void cxl_nested_unlock(struct device *dev)
-{
-	mutex_unlock(&dev->lockdep_mutex);
-}
-
-static inline void cxl_device_lock(struct device *dev)
-{
-	/*
-	 * For double lock errors the lockup will happen before lockdep
-	 * warns at cxl_nested_lock(), so assert explicitly.
-	 */
-	lockdep_assert_not_held(&dev->lockdep_mutex);
-
-	device_lock(dev);
-	cxl_nested_lock(dev);
-}
-
-static inline void cxl_device_unlock(struct device *dev)
-{
-	cxl_nested_unlock(dev);
-	device_unlock(dev);
-}
-#else
-static inline void cxl_nested_lock(struct device *dev)
-{
-}
-
-static inline void cxl_nested_unlock(struct device *dev)
-{
-}
-
-static inline void cxl_device_lock(struct device *dev)
-{
-	device_lock(dev);
-}
-
-static inline void cxl_device_unlock(struct device *dev)
-{
-	device_unlock(dev);
-}
-#endif
 #endif /* __CXL_H__ */
