Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3334A7E26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbiBCDAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:00:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46005 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349113AbiBCDAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:00:14 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220203030013epoutp0290ef292bf864beda687d7b83634e21eb~QJ20GoQ2P1856918569epoutp02k
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:00:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220203030013epoutp0290ef292bf864beda687d7b83634e21eb~QJ20GoQ2P1856918569epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643857213;
        bh=FtgxtF2Pn7rjuUdAv8gKYI+l31wN+W4WxwzY4sxV+Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AE/L1EGBONq2OqERJLuwCbbzy1tdwn594MfR77qpYm+GdT6WzDrBzTRUk8bIkg29m
         Jm6DplTSjbWd9lBMXI70Rzn+obmlEOVt4Cp2b8KVgWl4efQ481pYGOMwt3x6DAreGp
         07r3FLSLsh5SenvRMWMVN+Mwmt/gnEJdSJVbcQRA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220203030012epcas2p23aa3378279a469e379e85baf3640dd7a~QJ2zlgFla2459424594epcas2p2t;
        Thu,  3 Feb 2022 03:00:12 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jq3Lc1WCPz4x9Py; Thu,  3 Feb
        2022 03:00:08 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.BA.10018.8B44BF16; Thu,  3 Feb 2022 11:58:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220203030007epcas2p2e0e778e5763124be3cd66591e89c9668~QJ2vEeGSI2200622006epcas2p2u;
        Thu,  3 Feb 2022 03:00:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220203030007epsmtrp196c459806ac51bcf0d480ca7b3d0786f~QJ2u_2RFW2974329743epsmtrp10;
        Thu,  3 Feb 2022 03:00:07 +0000 (GMT)
X-AuditID: b6c32a46-a25ff70000002722-5b-61fb44b8f603
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.59.08738.7354BF16; Thu,  3 Feb 2022 12:00:07 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220203030007epsmtip28162a84c8ea69627ab7cf7a33a7f4890~QJ2uxDtkw0211302113epsmtip2U;
        Thu,  3 Feb 2022 03:00:07 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: [PATCH 2/3] usb: host: add xhci hooks for USB offload
Date:   Thu,  3 Feb 2022 11:57:33 +0900
Message-Id: <1643857054-112415-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmqe4Ol9+JBm0vrSzuLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XlXXPYLBYta2W2aN40hdVi5lplB06Py329TB4LNpV6LN7zkslj
        /9w17B59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeY
        m2qr5OIToOuWmQN0k5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0
        L10vL7XEytDAwMgUqDAhO6N95ia2gpPrGSsevFzA1MD4fSJjFyMnh4SAicSJKauYuxi5OIQE
        djBKbPw/lQ3C+cQoMeHUOxYI5zOjxIwVG+Ba9sy6A9Wyi1FiZ1sfI4Tzg1HixIQzTF2MHBxs
        AloS3xeCNYgIxEks7bzEBFLDLDCVSaJj1j0WkBphATuJ1eclQWpYBFQlLjz5ww5i8wq4SRw4
        c5oJYpmcxM1zncwgNqeAu8SRKTfAdkkIPGKXWHn1DCPIHAkBF4lz58sg6oUlXh3fwg5hS0m8
        7G+Dsosldn1qZYLobWCUaHxwghkiYSwx61k72BxmAU2J9bv0IUYqSxy5xQJSwSzAJ9Fx+C87
        RJhXoqNNCKJRWWL65QmsELakxMHX55ghSjwkPnfoQgJkFqPEn7f/mCYwys1CmL+AkXEVo1hq
        QXFuemqxUYERPMaS83M3MYLTnJbbDsYpbz/oHWJk4mA8xCjBwawkwrt34fdEId6UxMqq1KL8
        +KLSnNTiQ4ymwKCbyCwlmpwPTLR5JfGGJpYGJmZmhuZGpgbmSuK8XikbEoUE0hNLUrNTUwtS
        i2D6mDg4pRqYRJss1iTM82I7Xyi9sMV6QmPklQeFU47s2P32qZ2F12LptivrWF1ez1UpdCqa
        0/xze3GE48nX9s/6u+4+POepfufmeo38uvN2N4/riDH3XHm4955D/BO3c8mcayonJVXvWCB7
        7+/kwPyHiY+/zs+LOrcvXPX7NqfixU8jBL5d2q/iXniOyc/ZMeDYzd07XqhdvCyyPmjnpYYJ
        p2rcq+1m3We7wKr2oj/gA0fkzogNm6ac4RaTNZS+4X6y5br63js31lS6KmpX/3t66XJalNa0
        rYycwixSvalZ1x4kS2gwXfyzWNzxgoHvj7hkkbOVh0w6omY3OwtPO6I6q8lYNc9b/tHkFcae
        9yf6WC3fcK/7rxJLcUaioRZzUXEiABtYpZX8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSvK656+9Eg67n6hZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yA6fH5b5eJo8Fm0o9Fu95yeSx
        f+4ado++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKaJ+5ia3g5HrGigcvFzA1MH6fyNjFyMkh
        IWAisWfWHeYuRi4OIYEdjBJNHy8yQSQkJZbOvcEOYQtL3G85wgpR9I1R4viZd2xdjBwcbAJa
        Et8Xgg0SEYiTWHF5DwtIDbPAbCaJzcevM4LUCAvYSaw+LwlSwyKgKnHhyR+wmbwCbhIHzpyG
        2iUncfNcJzOIzSngLnFkyg2wmUJANauv9jFOYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOCS1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHevQu/JwrxpiRWVqUW5ccXleakFh9i
        lOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXApHeiuJRDPZj/1P0M6Q2PLy7/Y/A5P+3J
        6+unbxxdOj+eIfrwcYm31U4rlh8++lWU4Va4t/E6p+NVtYrfbJZ9sA/zP9djKDmBLS5fbW9T
        Cu/2ZHaVhbnrfy0WE2X2Snwee+v+2scfDMTiBQRdLB57//oueOJN+PITMp+bTeTzb3R16Zkc
        druZ1zKJ70X1loVOD+SbNY9fvy50smKx6MTIz6cLUtPc+rpuWkdtl9dfrK6yu880W4vPL9FX
        +4zk3cIlF1YUmpveNwt+7/dng/6Ki15zP2y6d0xl9g2WiXdP8f+YoVilIWzcarpobdGzbdfu
        FglmaF97fYQjpeNQ0sSi55duXkxaO3Gjer37pLW/ZyixFGckGmoxFxUnAgBJhRFeuAIAAA==
X-CMS-MailID: 20220203030007epcas2p2e0e778e5763124be3cd66591e89c9668
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220203030007epcas2p2e0e778e5763124be3cd66591e89c9668
References: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220203030007epcas2p2e0e778e5763124be3cd66591e89c9668@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable supporting for USB offload, define "offload" in usb controller
node of device tree. "offload" value can be used to determine which type
of offload was been enabled in the SoC.

For example:

&usbdrd_dwc3 {
	...
	/* support usb offloading, 0: disabled, 1: audio */
	offload = <1>;
	...
};

There are several vendor_ops introduced by this patch:

struct xhci_vendor_ops - function callbacks for vendor specific operations
{
	@vendor_init:
		- called for vendor init process during xhci-plat-hcd
		  probe.
	@vendor_cleanup:
		- called for vendor cleanup process during xhci-plat-hcd
		  remove.
	@is_usb_offload_enabled:
		- called to check if usb offload enabled.
	@queue_irq_work:
		- called to queue vendor specific irq work.
	@alloc_dcbaa:
		- called when allocating vendor specific dcbaa during
		  memory initializtion.
	@free_dcbaa:
		- called to free vendor specific dcbaa when cleanup the
		  memory.
	@alloc_transfer_ring:
		- called when vendor specific transfer ring allocation is required
	@free_transfer_ring:
		- called to free vendor specific transfer ring
	@sync_dev_ctx:
		- called when synchronization for device context is required
}

The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_vendor_ops.
For example, vendor_init ops will be invoked by xhci_vendor_init() hook,
is_usb_offload_enabled ops will be invoked by
xhci_vendor_is_usb_offload_enabled(), and so on.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/xhci-hub.c  |   5 ++
 drivers/usb/host/xhci-mem.c  | 131 +++++++++++++++++++++++++++++++----
 drivers/usb/host/xhci-plat.c |  43 +++++++++++-
 drivers/usb/host/xhci-plat.h |   8 +++
 drivers/usb/host/xhci-ring.c |  13 ++++
 drivers/usb/host/xhci.c      |  94 ++++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  48 +++++++++++++
 7 files changed, 325 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 6c1b8d748d0f..f7ed19cba8ad 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -535,8 +535,13 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 	    cmd->status == COMP_COMMAND_RING_STOPPED) {
 		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
 		ret = -ETIME;
+		goto cmd_cleanup;
 	}
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
+	if (ret)
+		xhci_warn(xhci, "Sync device context failed, ret=%d\n", ret);
+
 cmd_cleanup:
 	xhci_free_command(xhci, cmd);
 	return ret;
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index e6d56ef91ddb..5defbaf427ed 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -367,6 +367,54 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	return 0;
 }
 
+static void xhci_vendor_free_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->free_container_ctx)
+		ops->free_container_ctx(xhci, ctx);
+}
+
+static void xhci_vendor_alloc_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
+					    int type, gfp_t flags)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->alloc_container_ctx)
+		ops->alloc_container_ctx(xhci, ctx, type, flags);
+}
+
+static struct xhci_ring *xhci_vendor_alloc_transfer_ring(struct xhci_hcd *xhci,
+		u32 endpoint_type, enum xhci_ring_type ring_type,
+		unsigned int max_packet, gfp_t mem_flags)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->alloc_transfer_ring)
+		return ops->alloc_transfer_ring(xhci, endpoint_type, ring_type,
+				max_packet, mem_flags);
+	return 0;
+}
+
+void xhci_vendor_free_transfer_ring(struct xhci_hcd *xhci,
+		struct xhci_ring *ring, unsigned int ep_index)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->free_transfer_ring)
+		ops->free_transfer_ring(xhci, ring, ep_index);
+}
+
+bool xhci_vendor_is_usb_offload_enabled(struct xhci_hcd *xhci,
+		struct xhci_virt_device *virt_dev, unsigned int ep_index)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->is_usb_offload_enabled)
+		return ops->is_usb_offload_enabled(xhci, virt_dev, ep_index);
+	return false;
+}
+
 /*
  * Create a new ring with zero or more segments.
  *
@@ -419,7 +467,11 @@ void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index)
 {
-	xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, ep_index))
+		xhci_vendor_free_transfer_ring(xhci, virt_dev->eps[ep_index].ring, ep_index);
+	else
+		xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
+
 	virt_dev->eps[ep_index].ring = NULL;
 }
 
@@ -478,6 +530,7 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
 {
 	struct xhci_container_ctx *ctx;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
 
 	if ((type != XHCI_CTX_TYPE_DEVICE) && (type != XHCI_CTX_TYPE_INPUT))
 		return NULL;
@@ -491,7 +544,12 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
 	if (type == XHCI_CTX_TYPE_INPUT)
 		ctx->size += CTX_SIZE(xhci->hcc_params);
 
-	ctx->bytes = dma_pool_zalloc(xhci->device_pool, flags, &ctx->dma);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0) &&
+	    (ops && ops->alloc_container_ctx))
+		xhci_vendor_alloc_container_ctx(xhci, ctx, type, flags);
+	else
+		ctx->bytes = dma_pool_zalloc(xhci->device_pool, flags, &ctx->dma);
+
 	if (!ctx->bytes) {
 		kfree(ctx);
 		return NULL;
@@ -502,9 +560,16 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
 void xhci_free_container_ctx(struct xhci_hcd *xhci,
 			     struct xhci_container_ctx *ctx)
 {
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
 	if (!ctx)
 		return;
-	dma_pool_free(xhci->device_pool, ctx->bytes, ctx->dma);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0) &&
+	    (ops && ops->free_container_ctx))
+		xhci_vendor_free_container_ctx(xhci, ctx);
+	else
+		dma_pool_free(xhci->device_pool, ctx->bytes, ctx->dma);
+
 	kfree(ctx);
 }
 
@@ -897,7 +962,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	for (i = 0; i < 31; i++) {
 		if (dev->eps[i].ring)
-			xhci_ring_free(xhci, dev->eps[i].ring);
+			xhci_free_endpoint_ring(xhci, dev, i);
 		if (dev->eps[i].stream_info)
 			xhci_free_stream_info(xhci,
 					dev->eps[i].stream_info);
@@ -1495,8 +1560,16 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 		mult = 0;
 
 	/* Set up the endpoint ring */
-	virt_dev->eps[ep_index].new_ring =
-		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, ep_index) &&
+	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		virt_dev->eps[ep_index].new_ring =
+			xhci_vendor_alloc_transfer_ring(xhci, endpoint_type, ring_type,
+							max_packet, mem_flags);
+	} else {
+		virt_dev->eps[ep_index].new_ring =
+			xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
+	}
+
 	if (!virt_dev->eps[ep_index].new_ring)
 		return -ENOMEM;
 
@@ -1844,6 +1917,24 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 }
 EXPORT_SYMBOL_GPL(xhci_free_erst);
 
+static struct xhci_device_context_array *xhci_vendor_alloc_dcbaa(
+		struct xhci_hcd *xhci, gfp_t flags)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->alloc_dcbaa)
+		return ops->alloc_dcbaa(xhci, flags);
+	return 0;
+}
+
+static void xhci_vendor_free_dcbaa(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->free_dcbaa)
+		ops->free_dcbaa(xhci);
+}
+
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
 	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
@@ -1898,9 +1989,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Freed medium stream array pool");
 
-	if (xhci->dcbaa)
-		dma_free_coherent(dev, sizeof(*xhci->dcbaa),
-				xhci->dcbaa, xhci->dcbaa->dma);
+	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0)) {
+		xhci_vendor_free_dcbaa(xhci);
+	} else {
+		if (xhci->dcbaa)
+			dma_free_coherent(dev, sizeof(*xhci->dcbaa),
+					xhci->dcbaa, xhci->dcbaa->dma);
+	}
 	xhci->dcbaa = NULL;
 
 	scratchpad_free(xhci);
@@ -2441,15 +2536,21 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * xHCI section 5.4.6 - doorbell array must be
 	 * "physically contiguous and 64-byte (cache line) aligned".
 	 */
-	xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
-			flags);
-	if (!xhci->dcbaa)
-		goto fail;
-	xhci->dcbaa->dma = dma;
+	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0)) {
+		xhci->dcbaa = xhci_vendor_alloc_dcbaa(xhci, flags);
+		if (!xhci->dcbaa)
+			goto fail;
+	} else {
+		xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
+				flags);
+		if (!xhci->dcbaa)
+			goto fail;
+		xhci->dcbaa->dma = dma;
+	}
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"// Device context base array address = 0x%llx (DMA), %p (virt)",
 			(unsigned long long)xhci->dcbaa->dma, xhci->dcbaa);
-	xhci_write_64(xhci, dma, &xhci->op_regs->dcbaa_ptr);
+	xhci_write_64(xhci, xhci->dcbaa->dma, &xhci->op_regs->dcbaa_ptr);
 
 	/*
 	 * Initialize the ring segment pool.  The ring must be a contiguous
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9b13ce..21280a6d589e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -184,6 +184,41 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+static struct xhci_plat_priv_overwrite xhci_plat_vendor_overwrite;
+
+int xhci_plat_register_vendor_ops(struct xhci_vendor_ops *vendor_ops)
+{
+	if (vendor_ops == NULL)
+		return -EINVAL;
+
+	xhci_plat_vendor_overwrite.vendor_ops = vendor_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_plat_register_vendor_ops);
+
+static int xhci_vendor_init(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = NULL;
+
+	if (xhci_plat_vendor_overwrite.vendor_ops)
+		ops = xhci->vendor_ops = xhci_plat_vendor_overwrite.vendor_ops;
+
+	if (ops && ops->vendor_init)
+		return ops->vendor_init(xhci);
+	return 0;
+}
+
+static void xhci_vendor_cleanup(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->vendor_cleanup)
+		ops->vendor_cleanup(xhci);
+
+	xhci->vendor_ops = NULL;
+}
+
 static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct xhci_plat_priv *priv_match;
@@ -339,6 +374,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto put_usb3_hcd;
 	}
 
+	ret = xhci_vendor_init(xhci);
+	if (ret)
+		goto disable_usb_phy;
+
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 	xhci->shared_hcd->tpl_support = hcd->tpl_support;
 
@@ -418,8 +457,10 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_phy_shutdown(hcd->usb_phy);
 
 	usb_remove_hcd(hcd);
-	usb_put_hcd(shared_hcd);
 
+	xhci_vendor_cleanup(xhci);
+
+	usb_put_hcd(shared_hcd);
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 561d0b7bce09..e726a572321d 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -13,6 +13,7 @@
 struct xhci_plat_priv {
 	const char *firmware_name;
 	unsigned long long quirks;
+	struct xhci_vendor_data *vendor_data;
 	int (*plat_setup)(struct usb_hcd *);
 	void (*plat_start)(struct usb_hcd *);
 	int (*init_quirk)(struct usb_hcd *);
@@ -22,4 +23,11 @@ struct xhci_plat_priv {
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
 #define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
+
+struct xhci_plat_priv_overwrite {
+	struct xhci_vendor_ops *vendor_ops;
+};
+
+int xhci_plat_register_vendor_ops(struct xhci_vendor_ops *vendor_ops);
+
 #endif	/* _XHCI_PLAT_H */
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 2e99393560e5..e611f8d7d587 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3075,6 +3075,15 @@ void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 }
 EXPORT_SYMBOL_GPL(xhci_update_erst_dequeue);
 
+static irqreturn_t xhci_vendor_queue_irq_work(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->queue_irq_work)
+		return ops->queue_irq_work(xhci);
+	return IRQ_NONE;
+}
+
 /*
  * xHCI spec says we can get an interrupt, and if the HC has an error condition,
  * we might get bad data out of the event ring.  Section 4.10.2.7 has a list of
@@ -3108,6 +3117,10 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		goto out;
 	}
 
+	ret = xhci_vendor_queue_irq_work(xhci);
+	if (ret == IRQ_HANDLED)
+		goto out;
+
 	/*
 	 * Clear the op reg interrupt status first,
 	 * so we can receive interrupts from other MSI-X interrupters.
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 041a65a6f175..10d5e20b710d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1621,6 +1621,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		return -ENODEV;
 	}
 
+	if (xhci_vendor_usb_offload_skip_urb(xhci, urb)) {
+		xhci_dbg(xhci, "skip urb for usb offload\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
 		num_tds = urb->number_of_packets;
 	else if (usb_endpoint_is_bulk_out(&urb->ep->desc) &&
@@ -2964,6 +2969,14 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 			xhci_finish_resource_reservation(xhci, ctrl_ctx);
 		spin_unlock_irqrestore(&xhci->lock, flags);
 	}
+	if (ret)
+		goto failed;
+
+	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (ret)
+		xhci_warn(xhci, "sync device context failed, ret=%d", ret);
+
+failed:
 	return ret;
 }
 
@@ -3107,7 +3120,11 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	for (i = 0; i < 31; i++) {
 		if (virt_dev->eps[i].new_ring) {
 			xhci_debugfs_remove_endpoint(xhci, virt_dev, i);
-			xhci_ring_free(xhci, virt_dev->eps[i].new_ring);
+			if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, i))
+				xhci_vendor_free_transfer_ring(xhci, virt_dev->eps[i].new_ring, i);
+			else
+				xhci_ring_free(xhci, virt_dev->eps[i].new_ring);
+
 			virt_dev->eps[i].new_ring = NULL;
 		}
 	}
@@ -3272,6 +3289,13 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(stop_cmd->completion);
 
+	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (err) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, err);
+		goto cleanup;
+	}
+
 	spin_lock_irqsave(&xhci->lock, flags);
 
 	/* config ep command clears toggle if add and drop ep flags are set */
@@ -3303,6 +3327,11 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(cfg_cmd->completion);
 
+	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (err)
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, err);
+
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
 	xhci_free_command(xhci, stop_cmd);
@@ -3848,6 +3877,13 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 	/* Wait for the Reset Device command to finish */
 	wait_for_completion(reset_device_cmd->completion);
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		goto command_cleanup;
+	}
+
 	/* The Reset Device command can't fail, according to the 0.95/0.96 spec,
 	 * unless we tried to reset a slot ID that wasn't enabled,
 	 * or the device wasn't in the addressed or configured state.
@@ -4093,6 +4129,14 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 		xhci_warn(xhci, "Could not allocate xHCI USB device data structures\n");
 		goto disable_slot;
 	}
+
+	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		goto disable_slot;
+	}
+
 	vdev = xhci->devs[slot_id];
 	slot_ctx = xhci_get_slot_ctx(xhci, vdev->out_ctx);
 	trace_xhci_alloc_dev(slot_ctx);
@@ -4223,6 +4267,13 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	/* ctrl tx can take up to 5 sec; XXX: need more time for xHC? */
 	wait_for_completion(command->completion);
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		goto out;
+	}
+
 	/* FIXME: From section 4.3.4: "Software shall be responsible for timing
 	 * the SetAddress() "recovery interval" required by USB and aborting the
 	 * command on a timeout.
@@ -4371,6 +4422,14 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
 		return -ENOMEM;
 	}
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (ret) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		return ret;
+	}
+
 	xhci_slot_copy(xhci, command->in_ctx, virt_dev->out_ctx);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
@@ -4395,6 +4454,30 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
 	return ret;
 }
 
+struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci)
+{
+	return xhci->vendor_ops;
+}
+EXPORT_SYMBOL_GPL(xhci_vendor_get_ops);
+
+int xhci_vendor_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->sync_dev_ctx)
+		return ops->sync_dev_ctx(xhci, slot_id);
+	return 0;
+}
+
+bool xhci_vendor_usb_offload_skip_urb(struct xhci_hcd *xhci, struct urb *urb)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->usb_offload_skip_urb)
+		return ops->usb_offload_skip_urb(xhci, urb);
+	return false;
+}
+
 #ifdef CONFIG_PM
 
 /* BESL to HIRD Encoding array for USB2 LPM */
@@ -5131,6 +5214,15 @@ static int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 		return -ENOMEM;
 	}
 
+	ret = xhci_vendor_sync_dev_ctx(xhci, hdev->slot_id);
+	if (ret) {
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, ret);
+		xhci_free_command(xhci, config_cmd);
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		return ret;
+	}
+
 	xhci_slot_copy(xhci, config_cmd->in_ctx, vdev->out_ctx);
 	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
 	slot_ctx = xhci_get_slot_ctx(xhci, config_cmd->in_ctx);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 5a75fe563123..2efe8ddaab5f 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1928,6 +1928,7 @@ struct xhci_hcd {
 	struct list_head	regset_list;
 
 	void			*dbc;
+
 	/* platform-specific data -- must come last */
 	unsigned long		priv[] __aligned(sizeof(s64));
 };
@@ -2206,6 +2207,53 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
 					urb->stream_id);
 }
 
+/**
+ * struct xhci_vendor_ops - function callbacks for vendor specific operations
+ * @vendor_init: called for vendor init process
+ * @vendor_cleanup: called for vendor cleanup process
+ * @is_usb_offload_enabled: called to check if usb offload enabled
+ * @queue_irq_work: called to queue vendor specific irq work
+ * @alloc_dcbaa: called when allocating vendor specific dcbaa
+ * @free_dcbaa: called to free vendor specific dcbaa
+ * @alloc_transfer_ring: called when remote transfer ring allocation is required
+ * @free_transfer_ring: called to free vendor specific transfer ring
+ * @sync_dev_ctx: called when synchronization for device context is required
+ * @alloc_container_ctx: called when allocating vendor specific container context
+ * @free_container_ctx: called to free vendor specific container context
+ */
+struct xhci_vendor_ops {
+	int (*vendor_init)(struct xhci_hcd *xhci);
+	void (*vendor_cleanup)(struct xhci_hcd *xhci);
+	bool (*is_usb_offload_enabled)(struct xhci_hcd *xhci,
+				       struct xhci_virt_device *vdev,
+				       unsigned int ep_index);
+	irqreturn_t (*queue_irq_work)(struct xhci_hcd *xhci);
+
+	struct xhci_device_context_array *(*alloc_dcbaa)(struct xhci_hcd *xhci,
+							 gfp_t flags);
+	void (*free_dcbaa)(struct xhci_hcd *xhci);
+
+	struct xhci_ring *(*alloc_transfer_ring)(struct xhci_hcd *xhci,
+			u32 endpoint_type, enum xhci_ring_type ring_type,
+			unsigned int max_packet, gfp_t mem_flags);
+	void (*free_transfer_ring)(struct xhci_hcd *xhci,
+			struct xhci_ring *ring, unsigned int ep_index);
+	int (*sync_dev_ctx)(struct xhci_hcd *xhci, unsigned int slot_id);
+	bool (*usb_offload_skip_urb)(struct xhci_hcd *xhci, struct urb *urb);
+	void (*alloc_container_ctx)(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
+				    int type, gfp_t flags);
+	void (*free_container_ctx)(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx);
+};
+
+struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci);
+
+int xhci_vendor_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id);
+bool xhci_vendor_usb_offload_skip_urb(struct xhci_hcd *xhci, struct urb *urb);
+void xhci_vendor_free_transfer_ring(struct xhci_hcd *xhci,
+		struct xhci_ring *ring, unsigned int ep_index);
+bool xhci_vendor_is_usb_offload_enabled(struct xhci_hcd *xhci,
+		struct xhci_virt_device *virt_dev, unsigned int ep_index);
+
 /*
  * TODO: As per spec Isochronous IDT transmissions are supported. We bypass
  * them anyways as we where unable to find a device that matches the
-- 
2.31.1

