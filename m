Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86884CFC18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbiCGK7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiCGK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:43 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CC51EAE3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:18:56 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220307101854epoutp045f9fad4664987408761e31f13b7f9f68~aEe_qExQc0483004830epoutp04a
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220307101854epoutp045f9fad4664987408761e31f13b7f9f68~aEe_qExQc0483004830epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646648334;
        bh=RF4TiedEEbBa0PmOpJq3jeBUFdTOgIuaimKCB38qlmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fcz2/CKOOAx/7cvK/Mrjq0OZuH5xmPdGIbD0F739znsDP4fCTfWD4uDT2OUNJyVxB
         6rZQze4b/QJf7KXb7RlXndMmxXHetzuFceoFrWczV12uL2hZ7MeieMO6FNVcLRwJZ/
         FvPmB/jTTqYXPS1BT3KbYVFjD9tAbgRhDXR6MVn4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220307101853epcas2p195ab187554dd8a37f1615eba3e3f46f4~aEe9wG3Fs3042230422epcas2p1R;
        Mon,  7 Mar 2022 10:18:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KBvZ33vJcz4x9Q9; Mon,  7 Mar
        2022 10:18:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.AC.51767.B0CD5226; Mon,  7 Mar 2022 19:18:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220307101850epcas2p3e944ac6a7d1ef0b96c3777b87731d02f~aEe7ALH7K2526025260epcas2p3K;
        Mon,  7 Mar 2022 10:18:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220307101850epsmtrp1beec8b9de78cbb7c0bc27b22079b4079~aEe6-E8LV3119831198epsmtrp1-;
        Mon,  7 Mar 2022 10:18:50 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-12-6225dc0b0a5e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.81.29871.A0CD5226; Mon,  7 Mar 2022 19:18:50 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220307101850epsmtip236f022471bc8cb95235cc92bf25507c8~aEe6wOMiS0102401024epsmtip26;
        Mon,  7 Mar 2022 10:18:50 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: [PATCH v2 2/4] usb: host: add xhci hooks for USB offload
Date:   Mon,  7 Mar 2022 19:17:34 +0900
Message-Id: <1646648256-105214-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQpf7jmqSwa55EhYvD2labH54hc3i
        zoJpTBZPjixit2hevJ7N4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgcfj
        cl8vk8eCTaUei/e8ZPLYP3cNu0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpj9Zy9bwd1NjBWHl91ibmC8NIWxi5GT
        Q0LAROLm+1YWEFtIYAejRP8T4S5GLiD7E6PEhG2PWSCcb4wSr3e8BergAOs4Nt0MIr6XUeLD
        xP2sEM4PRolNPy8ygxSxCWhJfF8ItkFEIE5iaeclJpAaZoGrTBJLNhxjB0kICzhKNO06ALaa
        RUBV4t/joywgvbwCbhKdM/MgrpOTuHmukxnE5hRwl/g2pZcJIv6XXeLWLDMI20Xi6K67bBC2
        sMSr41vYIWwpiZf9bVB2scSuT61gN0gINDBKND44wQyRMJaY9awd7DFmAU2J9bv0IX5Uljhy
        iwWigleiYeNvsDHMAnwSHYf/skOU8Ep0tAlBlChLTL88gRXClpQ4+Poc1HAPiaYNN6BBOItR
        om/HLuYJjPKzEJYtYGRcxSiWWlCcm55abFRgCI+85PzcTYzgxKjluoNx8tsPeocYmTgYDzFK
        cDArifDeP6+SJMSbklhZlVqUH19UmpNafIjRFBiME5mlRJPzgak5ryTe0MTSwMTMzNDcyNTA
        XEmc1ytlQ6KQQHpiSWp2ampBahFMHxMHp1QDU/bjoycObBNVyKtuNYn9srxVN/hXRdnOZfUP
        tk0+vaWZN0NyCnOGyo9D3Hlif9iVm8PjXq9TjtSMOeu2PHHTmXSOLZtTX/WmXf8vr9psUvji
        5MVGh00171+dYzvPyMpv9Ykvyrb68uzAsJilYp9Dz01Q+nQ8r/bKVUats32LpW+Hu5323LP/
        2PTb18Pvbn9yQm3Oy92aRjx60iYhysdWGKds+6tS8Ppi3xF1pmNW9wqsN/+qFpsgxHPArG3D
        OzlRpr+7i/IVn3ilFG1bv/Wo6ewmKaFQ43fcOyN3nHH5arW7+sFC4a87mE9qaK9iyiop/Hbo
        wNUkheszXsyI9Dr3de3qdNd070ajf+v39zml7VViKc5INNRiLipOBABd2krFFQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvC7XHdUkg/+/dSxeHtK02PzwCpvF
        nQXTmCyeHFnEbtG8eD2bxfU/7xkt2p9fYLO4vGsOm8WiZa3MFs2bprBazFyrbNF19wajA4/H
        5b5eJo8Fm0o9Fu95yeSxf+4ado++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKmP1nL1vB3U2M
        FYeX3WJuYLw0hbGLkYNDQsBE4th0sy5GLg4hgd2MEktmHWfuYuQEiktKLJ17gx3CFpa433KE
        FaLoG6PE+Wu32UGa2QS0JL4vZASpERGIk1hxeQ8LSA2zwH0mifPvvrOCJIQFHCWadh1gAbFZ
        BFQl/j0+ygLSyyvgJtE5Mw9ivpzEzXOdYHs5Bdwlvk3pZQKxhYBKLp64yjSBkW8BI8MqRsnU
        guLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgYNXS3MG4fdUHvUOMTByMhxglOJiVRHjvn1dJ
        EuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFJeeneVLVv
        +1aKx22X5mtRy328c6W3RJD6zuvr5v+tebGeTeNvwbG4nxNCJSZPnJe0aIJtxJLjE/tW7Qhb
        mH2pctHSqyf+Hb60TVmKddkRgzKHl1a7lDuq99hZa2h/lVF+6ld4VmYWU9n+RlftLYtObqtZ
        uGf5y+071OT+P3WscGJh/P7/2HzH4uW8CY8Lmp9cYZim+2j+om1HV2gplHqr6jkbaqwpvDp9
        q9uDpWrb1U+/cmD+HNvsufpZvcP1/zNuL9/46+8F0/2vLrk1Nby+sm6m9dv+IqPGvWUrVt/k
        MbrAESZYn/Q/ta1H6m2krKKK0OrrLtNz3+p+D1tcZNfGeJxx79zJOd/Oxz+RCltwYroSS3FG
        oqEWc1FxIgDUIK6QxQIAAA==
X-CMS-MailID: 20220307101850epcas2p3e944ac6a7d1ef0b96c3777b87731d02f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307101850epcas2p3e944ac6a7d1ef0b96c3777b87731d02f
References: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220307101850epcas2p3e944ac6a7d1ef0b96c3777b87731d02f@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
	@alloc_container_ctx
		- called when allocating vendor specific container context
	@free_container_ctx:
		- called to free vendor specific container context
}

The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_vendor_ops.
For example, vendor_init ops will be invoked by xhci_vendor_init() hook,
is_usb_offload_enabled ops will be invoked by
xhci_vendor_is_usb_offload_enabled(), and so on.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
Signed-off-by: J. Avila <elavila@google.com>
Signed-off-by: Puma Hsu <pumahsu@google.com>
Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-hub.c  |   5 ++
 drivers/usb/host/xhci-mem.c  | 131 +++++++++++++++++++++++++++++++----
 drivers/usb/host/xhci-plat.c |  43 +++++++++++-
 drivers/usb/host/xhci-plat.h |   8 +++
 drivers/usb/host/xhci-ring.c |  13 ++++
 drivers/usb/host/xhci.c      |  94 ++++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  50 +++++++++++++
 7 files changed, 327 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 56546aaa93c7..aea72ffce820 100644
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
index 45be6732eb89..ef531007fd50 100644
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
 
@@ -477,6 +529,7 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
 {
 	struct xhci_container_ctx *ctx;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
 
 	if ((type != XHCI_CTX_TYPE_DEVICE) && (type != XHCI_CTX_TYPE_INPUT))
 		return NULL;
@@ -490,7 +543,12 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
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
@@ -501,9 +559,16 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
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
 
@@ -896,7 +961,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	for (i = 0; i < 31; i++) {
 		if (dev->eps[i].ring)
-			xhci_ring_free(xhci, dev->eps[i].ring);
+			xhci_free_endpoint_ring(xhci, dev, i);
 		if (dev->eps[i].stream_info)
 			xhci_free_stream_info(xhci,
 					dev->eps[i].stream_info);
@@ -1494,8 +1559,16 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
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
 
@@ -1843,6 +1916,24 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
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
@@ -1894,9 +1985,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
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
@@ -2433,15 +2528,21 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * xHCI section 5.4.6 - Device Context array must be
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
index 649ffd861b44..3d2fe4d77f38 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -173,6 +173,41 @@ static const struct of_device_id usb_xhci_of_match[] = {
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
@@ -321,6 +356,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto put_usb3_hcd;
 	}
 
+	ret = xhci_vendor_init(xhci);
+	if (ret)
+		goto disable_usb_phy;
+
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 	xhci->shared_hcd->tpl_support = hcd->tpl_support;
 	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
@@ -393,8 +432,10 @@ static int xhci_plat_remove(struct platform_device *dev)
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
index 1fb149d1fbce..658589bbf2da 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -13,6 +13,7 @@
 struct xhci_plat_priv {
 	const char *firmware_name;
 	unsigned long long quirks;
+	struct xhci_vendor_data *vendor_data;
 	void (*plat_start)(struct usb_hcd *);
 	int (*init_quirk)(struct usb_hcd *);
 	int (*suspend_quirk)(struct usb_hcd *);
@@ -21,4 +22,11 @@ struct xhci_plat_priv {
 
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
index 8f53672dcd97..3f82df2c5be1 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1632,6 +1632,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
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
@@ -2975,6 +2980,14 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
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
 
@@ -3118,7 +3131,11 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
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
@@ -3279,6 +3296,13 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
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
@@ -3310,6 +3334,11 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(cfg_cmd->completion);
 
+	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (err)
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, err);
+
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
 	xhci_free_command(xhci, stop_cmd);
@@ -3855,6 +3884,13 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
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
@@ -4100,6 +4136,14 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
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
@@ -4230,6 +4274,13 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
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
@@ -4382,6 +4433,14 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
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
 
@@ -4409,6 +4468,30 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
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
@@ -5133,6 +5216,15 @@ static int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
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
index 473a33ce299e..e2ed4f88ae4b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1929,6 +1929,9 @@ struct xhci_hcd {
 	struct list_head	regset_list;
 
 	void			*dbc;
+
+	struct xhci_vendor_ops *vendor_ops;
+
 	/* platform-specific data -- must come last */
 	unsigned long		priv[] __aligned(sizeof(s64));
 };
@@ -2207,6 +2210,53 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
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

