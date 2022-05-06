Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91DA51D17E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380952AbiEFGht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354174AbiEFGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:28 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7A65D37
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:45 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220506063343epoutp021a46ac23e62dba4d7bc331d03ca35fff~scHfvDFwT1005110051epoutp02j
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220506063343epoutp021a46ac23e62dba4d7bc331d03ca35fff~scHfvDFwT1005110051epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651818823;
        bh=sic1v50tzKGx31K+Pke1xBGhbvgq+xivzhBOFgYgK00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPWSo77btFrui3ui4vfbThXYBXY/r4iUh3MUFjsS5+Bsusxi87St17qS0Z9eWWDbC
         N9PAthA+oc8x+OriSGtyq7BiHfsvKHG0aXJa3CgU/pvPFCg2urlYSoqzaBzeRVHsHC
         qXZ1gjxSrbUIgO6PeIomu10iH36nc1USd0BpA09Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220506063342epcas2p11f50d917aa4825b1b7a7ed49891d79bb~scHe7Chj62814128141epcas2p1W;
        Fri,  6 May 2022 06:33:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KvgkV6GsJz4x9Q1; Fri,  6 May
        2022 06:33:38 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.EC.09764.241C4726; Fri,  6 May 2022 15:33:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220506063338epcas2p3749d0e1a3fffde81a758f708861b62ec~scHanJ7fj0340303403epcas2p3v;
        Fri,  6 May 2022 06:33:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506063338epsmtrp2d9ed052002dcbadeac560d60c66e9622~scHamBFGX0438604386epsmtrp2X;
        Fri,  6 May 2022 06:33:38 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-81-6274c14276de
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.55.11276.241C4726; Fri,  6 May 2022 15:33:38 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506063337epsmtip2c93408e2f79a62c19174717f510f9b05~scHaVyXQx0767807678epsmtip2J;
        Fri,  6 May 2022 06:33:37 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
        EXYNOS ARM ARCHITECTURES), sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com, Daehwan Jung <dh10.jung@samsung.com>,
        "J . Avila" <elavila@google.com>, Puma Hsu <pumahsu@google.com>,
        Howard Yen <howardyen@google.com>
Subject: [PATCH v5 2/6] usb: host: add xhci hooks for xhci-exynos
Date:   Fri,  6 May 2022 15:31:15 +0900
Message-Id: <1651818679-10594-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTZxTP13t7W1i6XIt1n8wRdglbeLcI9GMBxAnkxm0J2RLdXJZ6hTtA
        +qK3sM0srg6Vx7INmI6H4ioPIY2Ia6EqoSjIRBniEAFhoCiM8JDpeAmC21pat/9+5+T8fud3
        zvk+ISbuIjyFaWo9q1MzSopwx61X/cKD3m7V75NOTgSh0VNWAj0vuiZA146OC9Cw8UceGm+v
        EKDOmtM8lF1ZT6CBtccAnRwMRSMPlnFkm2kUIPNYPx/1Np0kUMmtFh6qOHMEQ4d/ycFRtvkY
        H82fHwOotM4H5Y/cBaioVYIu39kZu4lefVYE6KXFIpw+YejB6UtlIwLaaM6kK5uneLTZlEfQ
        w/3NBH25/KyAtlR9RX/XYAJ0fUMfTs+bvRJFe9KjUlkmmdV5s+okTXKaOiWaeucDxQ5FeIRU
        FiSLRHLKW82o2Ggq7t3EoIQ0pX1myjuLUWbaU4kMx1EhMVE6Taae9U7VcPpoitUmK7VybTDH
        qLhMdUqwmtW/JZNKQ8PthXvTUxeefS/QLlaDzyu6p3kGUJoL8oGbEJJhMGepkJ8P3IVi8iKA
        uaeuYM5gDsDargbcUSUmlwCcrRG8YDy6O+EqsgFobBzCncEygLf7H9q1hEKC9IdPTwNHfiNZ
        jMEbZ78lHAFG1uNwJW9uXcqD3A5r/xlcN4KTvnCgKY9wYBEZD+vKCwhnOy842J2HObAbmQBv
        H29YV4XkpBAu3HjomiIOVq8WYk7sAac7GlxePeH8nzaXEAeb5o7wnGQDgIdGr7sIW2HZRA5w
        2MZIP1jfFOKAkPSB7UPr42PkyzD36nOBMy2CuUfFTqIPLO4t4DvxZtg60+0SpGHZgonnXEqp
        fSm1c3gB8Cr7v4ERABPYxGo5VQrLhWpD/ztakkZlBuvP2j/hIjg2+yS4DfCEoA1AIUZtFHmU
        6feJRcnMFwdYnUahy1SyXBsIty+vEPOUJGns/0KtV8jCIqVhEREyeWi4VE69ItqZfJ4RkymM
        nk1nWS2re8HjCd08DTyYFfMR+rs89iXbT2+uPRj1rfm0U/Nk/67OQwu9tg1dOy6k8+8tPm1Z
        liuiBrI6K3cFrA6tqc596dvj1Xdwi5bJGPPd/h6833hnZbLaav7Bp8fgt7dv+NWpkemb1pLB
        xF9TVXC/obbd9OEbq7stgb9Z/Q5uMAl6z42AgOsXkuC9HMvP8QeOK2ljZPdN/mHbTMzj6df3
        bDNGVoxlwSk5TeUbAtuqLIGD8b3B2177K8D9symPkOaOvE/OWJZbi29plFGSb7qJJt3KH6Nb
        NX1XOmL4FFjMgF8/isv1nv09635Jy6U6t4jp+d1bPrYExr4vmU0xuG/OqEowlSrGpdktJ+TB
        sRIK51IZmT+m45h/AYM9V9hfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXtfpYEmSwe89bBYP5m1js/g76Ri7
        xbG2J+wWdxZMY7J4cmQRu8Wp5QuZLJoXr2ezuP7nPaPFnJtGFncf/mCx2Pt6K7vFpsfXWC0u
        75rDZjHj/D4mi0XLWpktWo62s1g0b5rCavF5w2NGi5lrlS267t5gtJh0UNRi/xUvBzGP378m
        MXp8+zqJxWN2w0UWj52z7rJ7LNhU6rF4z0smj02rOtk87lzbw+axf+4ado/NS+o9+rasYvRY
        v+Uqi8fnTXIBvFFcNimpOZllqUX6dglcGV9+9bMXfF3KWLHo3CumBsaZHYxdjJwcEgImEm9u
        PGPuYuTiEBLYzShx7topdoiEpMTSuTegbGGJ+y1HWCGKvjFKNG9ZAuRwcLAJaEl8Xwg2SERg
        LrPE1q1FIDXMAttZJA5cP8kGkhAWcJRY8f8mWBGLgKrE9V2dYHFeAVeJtXMnsEEskJO4ea6T
        GcTmFHCTuDR1C1i9EFDNwj/fmScw8i1gZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7
        iREcVVqaOxi3r/qgd4iRiYPxEKMEB7OSCK/wrJIkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwX
        uk7GCwmkJ5akZqemFqQWwWSZODilGpg4GyPEDLyff2/QzWJ8cOAy61lT5mM1C88VyjHFmZ1x
        dUsO8s89LeWSbzqx0OdtW4PymSfeh/ee7ah47JJeweokN+/F9i2fWc26n3TfztcVW/Mrfnf9
        Al55pYiWKbU5Rg5NH7cLvt6fxNhUG515UNtizvs5h+U5tRfEXWaVW6jK+PezlMlj0/1XVeyr
        rJtFelb5zZt2alnqeoFL6S+fS6/4L5G3sGpGYdmOyjijfsVSq7Jnq7cz5Rd1Nl/8rF8VUNoX
        nXrxr5Px/MPFj87//lPdJ/Uh4qnal7VJeuvu/1NSefaXt/QeyxPXSTfScpwUp3y2SfHlnTFr
        fcAGgZuH4o/5M97SkZcrqmvgOBhXpsRSnJFoqMVcVJwIALdR8GYZAwAA
X-CMS-MailID: 20220506063338epcas2p3749d0e1a3fffde81a758f708861b62ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220506063338epcas2p3749d0e1a3fffde81a758f708861b62ec
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220506063338epcas2p3749d0e1a3fffde81a758f708861b62ec@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
	@alloc_container_ctx
		- called to alloc vendor specific container context
	@free_container_ctx
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
 drivers/usb/host/xhci-plat.c |  44 +++++++++++-
 drivers/usb/host/xhci-plat.h |   8 +++
 drivers/usb/host/xhci.c      |  80 ++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  47 +++++++++++++
 6 files changed, 297 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 841617952ac7..e07c9c132061 100644
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
index 649ffd861b44..a5881ff945a6 100644
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
+static int xhci_vendor_init(struct xhci_hcd *xhci, struct device *dev)
+{
+	struct xhci_vendor_ops *ops = NULL;
+
+	if (xhci_plat_vendor_overwrite.vendor_ops)
+		ops = xhci->vendor_ops = xhci_plat_vendor_overwrite.vendor_ops;
+
+	if (ops && ops->vendor_init)
+		return ops->vendor_init(xhci, dev);
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
@@ -185,7 +220,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
 
-
 	if (usb_disabled())
 		return -ENODEV;
 
@@ -321,6 +355,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto put_usb3_hcd;
 	}
 
+	ret = xhci_vendor_init(xhci, &pdev->dev);
+	if (ret)
+		goto disable_usb_phy;
+
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 	xhci->shared_hcd->tpl_support = hcd->tpl_support;
 	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
@@ -393,8 +431,10 @@ static int xhci_plat_remove(struct platform_device *dev)
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
index 1fb149d1fbce..8c204f3234d8 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -17,8 +17,16 @@ struct xhci_plat_priv {
 	int (*init_quirk)(struct usb_hcd *);
 	int (*suspend_quirk)(struct usb_hcd *);
 	int (*resume_quirk)(struct usb_hcd *);
+	void *vendor_priv;
 };
 
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
index c06e8b21b724..5ccf1bbe8732 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2986,6 +2986,14 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
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
 
@@ -3129,7 +3137,11 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
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
@@ -3290,6 +3302,13 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
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
@@ -3321,6 +3340,11 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(cfg_cmd->completion);
 
+	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
+	if (err)
+		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
+			  __func__, err);
+
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
 	xhci_free_command(xhci, stop_cmd);
@@ -3866,6 +3890,13 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
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
@@ -4111,6 +4142,14 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
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
@@ -4241,6 +4280,13 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
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
@@ -4393,6 +4439,14 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
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
 
@@ -4420,6 +4474,21 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
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
@@ -5144,6 +5213,15 @@ static int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
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
index 5316841e9b26..5d356f40c2b9 100644
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
@@ -2214,6 +2217,50 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
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
+	int (*vendor_init)(struct xhci_hcd *xhci, struct device *dev);
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
+/**
+ * Only Below vendor ops are non-static. That's why we add prototype here.
+ */
+struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci);
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

