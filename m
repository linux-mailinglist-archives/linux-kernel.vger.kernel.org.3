Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DAF534A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbiEZGzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346314AbiEZGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:55:00 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E54924C;
        Wed, 25 May 2022 23:54:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 313DE16C0268;
        Thu, 26 May 2022 09:54:56 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ViELkY5qTegR; Thu, 26 May 2022 09:54:55 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1653548095; bh=5Ouxq8SyXbf5NqqTqb9cLhuUiQ5WZxGNrJ5nYwDNAVs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iEF+Eh4PY3o639B92mFGAVPUKvvyryD1A+VIodK5I2ESuE3Nxbc3yhhv03tKQxVRV
         6V/dllXCRrSpvDCVv11YLdQCAVefV4W3uzI/kO3cXfWssFl01tvGUqTuF/RgK9P/RY
         z7cz0vUMokiiAK8rmmXXKbmqV74wbOOgLfvNd1ow=
To:     Maximilian Senftleben <kernel@mail.msdigital.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: No static MAC address for usb gadget ethernet via
 kernel parameter any more.
In-Reply-To: <5ad210a8-a834-607e-351c-83ff23e23f5a@mail.msdigital.de>
References: <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
 <6c0eb462-3fab-473d-8989-b56e5748e5f7@mutex.one>
 <83b013eb-b320-f397-0ecc-f4824f3f45b9@msdigital.de>
 <874k1htj8b.fsf@mutex.one>
 <5ad210a8-a834-607e-351c-83ff23e23f5a@mail.msdigital.de>
Date:   Thu, 26 May 2022 09:54:53 +0300
Message-ID: <87tu9cpyv6.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maximilian Senftleben <kernel@mail.msdigital.de> writes:

Could you test if this patch fixes the issue for you?
Should apply without problems on kernel 5.17.
---
 drivers/usb/gadget/function/u_ether.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 6f5d45ef2e39a..b5bf51cdc3c8f 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -775,9 +775,14 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
 	dev->qmult = qmult;
 	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
 
-	if (get_ether_addr(dev_addr, addr))
+	if (get_ether_addr(dev_addr, addr)) {
+		net->addr_assign_type = NET_ADDR_RANDOM;
 		dev_warn(&g->dev,
 			"using random %s ethernet address\n", "self");
+	}
+	else {
+		net->addr_assign_type = NET_ADDR_SET;
+	}
 	eth_hw_addr_set(net, addr);
 	if (get_ether_addr(host_addr, dev->host_mac))
 		dev_warn(&g->dev,
@@ -835,6 +840,9 @@ struct net_device *gether_setup_name_default(const char *netname)
 	INIT_LIST_HEAD(&dev->tx_reqs);
 	INIT_LIST_HEAD(&dev->rx_reqs);
 
+	/* by default we always have a random MAC address */
+	net->addr_assign_type = NET_ADDR_RANDOM;
+
 	skb_queue_head_init(&dev->rx_frames);
 
 	/* network device setup */
@@ -871,7 +879,6 @@ int gether_register_netdev(struct net_device *net)
 	dev = netdev_priv(net);
 	g = dev->gadget;
 
-	net->addr_assign_type = NET_ADDR_RANDOM;
 	eth_hw_addr_set(net, dev->dev_mac);
 
 	status = register_netdev(net);
@@ -912,6 +919,7 @@ int gether_set_dev_addr(struct net_device *net, const char *dev_addr)
 	if (get_ether_addr(dev_addr, new_addr))
 		return -EINVAL;
 	memcpy(dev->dev_mac, new_addr, ETH_ALEN);
+	net->addr_assign_type = NET_ADDR_SET;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gether_set_dev_addr);
-- 
2.35.1

