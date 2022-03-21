Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669DC4E22DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbiCUJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbiCUJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:03:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8A9155C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:02:12 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220321090209epoutp042464c380aac563b83db967656bac324f~eWd9FEw_U2386023860epoutp04Q
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:02:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220321090209epoutp042464c380aac563b83db967656bac324f~eWd9FEw_U2386023860epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647853329;
        bh=uRnFLQg5/8hmbZcP6DXKCztRA1dIuNN9qRZ4XIDEJrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTasvr8Uxhl0rf0lCVEJbIsvtKROzTaaaGJ+7CgBcvIcTheOqSqsRzfum0S3LSB0o
         q6ba7qlFa+GliVHIOZdOg4iSOMpfUhGlFRF5X6JjiWAecyVfCwYx0q9OHxgPuqMSQu
         ePfjBHisqkHL+F/lNrEFrssqBHytowpbN8qeeOM8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220321090208epcas2p157de555b8e5edb0e35ce053593f8eefc~eWd8ns66I1490814908epcas2p1I;
        Mon, 21 Mar 2022 09:02:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KMTC16f3dz4x9Q8; Mon, 21 Mar
        2022 09:02:05 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.5A.10444.D0F38326; Mon, 21 Mar 2022 18:02:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220321090204epcas2p3b2be5c6b131240e408d12d40c517395c~eWd5EuZGk3112631126epcas2p3E;
        Mon, 21 Mar 2022 09:02:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321090204epsmtrp1ab7b85b35f5cb943a66db8ca2b1e0b45~eWd5D8nux2589125891epsmtrp1k;
        Mon, 21 Mar 2022 09:02:04 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-55-62383f0d2bab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.3E.29871.C0F38326; Mon, 21 Mar 2022 18:02:04 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220321090204epsmtip209d2f68655623b26b74d774866d6ae53~eWd4xv5TX1773717737epsmtip2D;
        Mon, 21 Mar 2022 09:02:04 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com
Subject: [PATCH v3 2/4] usb: host: add xhci hooks for USB offload
Date:   Mon, 21 Mar 2022 17:59:52 +0900
Message-Id: <1647853194-62147-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmmS6vvUWSwam93BZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLC
        XEkhLzE31VbJxSdA1y0zB+gwJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFe
        cWJucWleul5eaomVoYGBkSlQYUJ2xuy17gVN8xkr1jX1MTUwzmth7GLk5JAQMJHY0bmNqYuR
        i0NIYAejRP/HQ8wQzidGids7bjNCON8YJd48nsMK07J6ZisbRGIvo8TMdY9ZIZwfjBIfp7wB
        auHgYBPQkvi+EGyHiECcxNLOS2A7mAVWM0m8/3iRDSQhLOAosWT/A3YQm0VAVeLnsq9gcV4B
        V4nNN9cxQ2yTk7h5rhPM5hRwk1h7s5EFZJCEwCN2iT2TvrFBFLlInJ24HcoWlnh1fAs7hC0l
        8bK/Dcoultj1qZUJormBUaLxwQmoDcYSs561g13NLKApsX6XPogpIaAsceQWC0gFswCfRMfh
        v+wQYV6JjjYhiEZliemXJ0ADRVLi4OtzUAM9JFqv7oUG0ExGickbpzNOYJSbhbBgASPjKkax
        1ILi3PTUYqMCQ3icJefnbmIEJz0t1x2Mk99+0DvEyMTBeIhRgoNZSYR38QfzJCHelMTKqtSi
        /Pii0pzU4kOMpsDAm8gsJZqcD0y7eSXxhiaWBiZmZobmRqYG5krivF4pGxKFBNITS1KzU1ML
        Uotg+pg4OKUamJSOBXYGTX9q4dv3gf+Ox886aeeP8Q1LBJanO1+8e3O91Pvt0yPM+gS7wz2v
        2qxJW+fotKNZP27K1Z7jCW1h9XvYH8/1OPMtQkzyhccd+73RYpfyb11bJRZ4uzor6M9ctz/z
        840+l9Ro79l74YmBJzN35FX9d3eOzvbSvXuEz/GgyKuX6gIblvad/fz1/yx5d5OUB3mLwzcv
        3NTd+Gx39lbTf9l1xnd9/iX0rrJeudDld6Fy5PtlDZcK+l6dXP2/Z9Zn0Ws23Ee/8S/VmR68
        a0nB3i1ujP0b127lrqxZUjDder+12BP21H2ruOZVO8zgSGzJvZ8zcd9NUXuWn3OLndz+b3gw
        8bLzv8htKo8eXtRXYinOSDTUYi4qTgQA/NmKUQMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvC6PvUWSwbmDmhZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8f+uWvYPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj9lr3gqb5jBXrmvqYGhjntTB2
        MXJySAiYSKye2crWxcjFISSwm1Hi/O0uqISkxNK5N9ghbGGJ+y1HWCGKvjFKvDi8G6iDg4NN
        QEvi+0KwehGBOIkVl/ewgNQwC2xkkpj04BILSEJYwFFiyf4HYINYBFQlfi77ygZi8wq4Smy+
        uY4ZYoGcxM1znWA2p4CbxNqbjWC9QkA1WyfNYJ3AyLeAkWEVo2RqQXFuem6xYYFhXmq5XnFi
        bnFpXrpecn7uJkZwcGpp7mDcvuqD3iFGJg7GQ4wSHMxKIryLP5gnCfGmJFZWpRblxxeV5qQW
        H2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cAU31FeM0Vjq9mromsrvLz+aC5qK5uf
        +2cHV+SizLz5GhvWuHQt4/v2Nm7Cw2+TIwXWhok4z7q+4BA3q3Qem0udwLYAxy9Oajvs7ESe
        7XJb5zZVxdLhx5Xc6wEB35hS89kn911i6pgz++hhIW7Rq2/Xxf8vTHlwt6GOPd095cxj1rKo
        zFSvcK0nir8OzPl97+ATieNODxf9E1v5L2T2ceaAqxzOny6f8lgrf/T7zwvejL0pBpvvmhd9
        OjCzcw9/BedX/tJdhbGWpsv3rKibfkTc7bKXfIzc1+j4Xb/X8Nc05V+PW794zbwP81eHdWka
        iZ20ldVecmLbGo+sNFejpYffWOd82iPLnfXaQHeFd7qiEktxRqKhFnNRcSIAv3serb0CAAA=
X-CMS-MailID: 20220321090204epcas2p3b2be5c6b131240e408d12d40c517395c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090204epcas2p3b2be5c6b131240e408d12d40c517395c
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090204epcas2p3b2be5c6b131240e408d12d40c517395c@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: J. Avila <elavila@google.com>
Signed-off-by: Puma Hsu <pumahsu@google.com>
Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-hub.c  |   5 ++
 drivers/usb/host/xhci-mem.c  | 131 +++++++++++++++++++++++++++++++----
 drivers/usb/host/xhci-plat.c |  43 +++++++++++-
 drivers/usb/host/xhci-plat.h |   7 ++
 drivers/usb/host/xhci.c      |  80 ++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  46 ++++++++++++
 6 files changed, 295 insertions(+), 17 deletions(-)

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
index 82b9f90c0f27..5ee0ffb676d3 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -365,6 +365,54 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
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
@@ -417,7 +465,11 @@ void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
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
 
@@ -475,6 +527,7 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
 {
 	struct xhci_container_ctx *ctx;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
 
 	if ((type != XHCI_CTX_TYPE_DEVICE) && (type != XHCI_CTX_TYPE_INPUT))
 		return NULL;
@@ -488,7 +541,12 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
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
@@ -499,9 +557,16 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
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
 
@@ -894,7 +959,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	for (i = 0; i < 31; i++) {
 		if (dev->eps[i].ring)
-			xhci_ring_free(xhci, dev->eps[i].ring);
+			xhci_free_endpoint_ring(xhci, dev, i);
 		if (dev->eps[i].stream_info)
 			xhci_free_stream_info(xhci,
 					dev->eps[i].stream_info);
@@ -1492,8 +1557,16 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
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
 
@@ -1837,6 +1910,24 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 	erst->entries = NULL;
 }
 
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
@@ -1888,9 +1979,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
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
@@ -2427,15 +2522,21 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
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
index 1fb149d1fbce..18b349883eea 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -21,4 +21,11 @@ struct xhci_plat_priv {
 
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
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 8f53672dcd97..4e4fcf97ba42 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2975,6 +2975,14 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
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
 
@@ -3118,7 +3126,11 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
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
@@ -3279,6 +3291,13 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
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
@@ -3310,6 +3329,11 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(cfg_cmd->completion);
 
+	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (err)
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, err);
+
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
 	xhci_free_command(xhci, stop_cmd);
@@ -3855,6 +3879,13 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
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
@@ -4100,6 +4131,14 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
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
@@ -4230,6 +4269,13 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
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
@@ -4382,6 +4428,14 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
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
 
@@ -4409,6 +4463,21 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
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
 #ifdef CONFIG_PM
 
 /* BESL to HIRD Encoding array for USB2 LPM */
@@ -5133,6 +5202,15 @@ static int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
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
index 473a33ce299e..f690a5dc9eb3 100644
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
@@ -2207,6 +2210,49 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
 					urb->stream_id);
 }
 
+/**
+ * struct xhci_vendor_ops - function callbacks for vendor specific operations
+ * @vendor_init: called for vendor init process
+ * @vendor_cleanup: called for vendor cleanup process
+ * @is_usb_offload_enabled: called to check if usb offload enabled
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
+	void (*alloc_container_ctx)(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
+				    int type, gfp_t flags);
+	void (*free_container_ctx)(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx);
+};
+
+struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci);
+
+int xhci_vendor_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id);
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

