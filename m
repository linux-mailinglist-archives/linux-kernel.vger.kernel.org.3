Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2751A399
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbiEDPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiEDPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:21:31 -0400
X-Greylist: delayed 1467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 08:17:50 PDT
Received: from vps19.webwerkers.nl (vps19.webwerkers.nl [136.144.231.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0AC36E26
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:17:50 -0700 (PDT)
Received: from [89.255.59.226] (helo=server.mep)
        by vps19.webwerkers.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <indan.zupancic@mep-info.com>)
        id 1nmGNV-000625-O2; Wed, 04 May 2022 16:53:21 +0200
Received: from _ (localhost [127.0.0.1])
        by server.mep (Postfix) with ESMTPA id EC363D0FEBA;
        Wed,  4 May 2022 16:52:53 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 04 May 2022 16:52:53 +0200
From:   Indan Zupancic <indan.zupancic@mep-info.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] UIO: Let uio_pdrv_genirq support cached memory
Message-ID: <436ea1f019d26d28ab4fce4ee28f609b@mep-info.com>
X-Sender: indan.zupancic@mep-info.com
User-Agent: Roundcube Webmail/1.3.16
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: meptelco
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'cacheable' DT property exists, the memory mapping will be
done with UIO_MEM_IOVA instead of the default UIO_MEM_PHYS.
---
  Documentation/driver-api/uio-howto.rst | 3 ++-
  drivers/uio/uio_pdrv_genirq.c          | 8 ++++++--
  2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/uio-howto.rst 
b/Documentation/driver-api/uio-howto.rst
index 907ffa3b38f5..3cb48fc757d9 100644
--- a/Documentation/driver-api/uio-howto.rst
+++ b/Documentation/driver-api/uio-howto.rst
@@ -413,7 +413,8 @@ probed with the ``"of_id"`` module parameter set to 
the ``"compatible"``
  string of the node the driver is supposed to handle. By default, the
  node's name (without the unit address) is exposed as name for the
  UIO device in userspace. To set a custom name, a property named
-``"linux,uio-name"`` may be specified in the DT node.
+``"linux,uio-name"`` may be specified in the DT node. If a property
+named ``cacheable`` exists, the memory will be mapped cacheable.

  Using uio_dmem_genirq for platform devices
  ------------------------------------------
diff --git a/drivers/uio/uio_pdrv_genirq.c 
b/drivers/uio/uio_pdrv_genirq.c
index 63258b6accc4..269784ce0ba3 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -115,6 +115,7 @@ static int uio_pdrv_genirq_probe(struct 
platform_device *pdev)
  	struct uio_mem *uiomem;
  	int ret = -EINVAL;
  	int i;
+	int memtype = UIO_MEM_PHYS;

  	if (node) {
  		const char *name;
@@ -132,7 +133,10 @@ static int uio_pdrv_genirq_probe(struct 
platform_device *pdev)
  		else
  			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
  						       "%pOFn", node);
-
+		if (of_get_property(node, "cacheable", NULL)) {
+			dev_info(&pdev->dev, "%s cacheable\n", uioinfo->name);
+			memtype = UIO_MEM_IOVA;
+		}
  		uioinfo->version = "devicetree";
  		/* Multiple IRQs are not supported */
  	}
@@ -204,7 +208,7 @@ static int uio_pdrv_genirq_probe(struct 
platform_device *pdev)
  			break;
  		}

-		uiomem->memtype = UIO_MEM_PHYS;
+		uiomem->memtype = memtype;
  		uiomem->addr = r->start & PAGE_MASK;
  		uiomem->offs = r->start & ~PAGE_MASK;
  		uiomem->size = (uiomem->offs + resource_size(r)
-- 
