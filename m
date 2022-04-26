Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FF50F97B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbiDZKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbiDZKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:01:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ECE35DCA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:20:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220426092027epoutp01d8a86dece9df79e7aaf89429994dd3b3~pZ8Nr8qd20834308343epoutp01I
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220426092027epoutp01d8a86dece9df79e7aaf89429994dd3b3~pZ8Nr8qd20834308343epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650964827;
        bh=DI2N6MsptAZ4w52slbF9YkZmkY2W7qAobVVKObxqoNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5k6WjDWjVhDIRnM2LlkJXPXimFlOh1AtkORteZEI6Vhd5tWsiE0fd+Fu1984vHZB
         ZDhXOrdUUVBgOwOAQTiSl8k/s9lIbz0ZXyVd1ccAKziYvvvbkv+xCq9CNqq3lluOmp
         oEr6UExexJuCwWbM7obis7OgGtfDxdVAHuV3+Z80=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220426092026epcas2p1aeb4085e7e2547ea348e2d48c2ba60cd~pZ8NKHSbA0597205972epcas2p1a;
        Tue, 26 Apr 2022 09:20:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KnbvX39q9z4x9Pw; Tue, 26 Apr
        2022 09:20:24 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.66.10069.559B7626; Tue, 26 Apr 2022 18:20:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220426092021epcas2p4071f2b7621558a015579131990486a3c~pZ8H-nEOp2651026510epcas2p4J;
        Tue, 26 Apr 2022 09:20:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220426092021epsmtrp2ac3c98bf2d962a417468d62c9eb4898a~pZ8H9lh2G1198711987epsmtrp24;
        Tue, 26 Apr 2022 09:20:21 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-04-6267b9555afb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.63.08853.559B7626; Tue, 26 Apr 2022 18:20:21 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092021epsmtip2086b1f93ba272f8f41a97a90f2952f97~pZ8HxTjEy2691826918epsmtip2a;
        Tue, 26 Apr 2022 09:20:21 +0000 (GMT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 1/5] usb: host: export symbols for xhci-exynos to use
 xhci hooks
Date:   Tue, 26 Apr 2022 18:18:44 +0900
Message-Id: <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmhW7ozvQkgxeT9S3uLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54eOkZW8EZq4qtndsZGxinGHQxcnJI
        CJhIPNy0gr2LkYtDSGAHo8T1mX9ZQRJCAp8YJe5clINIfGOU2HDwJxtMx76v/SwQib2MEuc7
        upghOn4wSvyaXNfFyMHBJqAl8X0hI0hYRCBOYmnnJSaQemaBJ0wSO97dYgJJCAuEShz41g3W
        yyKgKnHy5hVGkF5eATeJQ/ezIXbJSdw81wlWwingLvGiZxHYpRICH9kllu/dwg5R5CKxofMp
        1HHCEq+Ow8SlJD6/2wsVL5bY9amVCaK5gVGi8cEJZoiEscSsZ+1gi5kFNCXW79IHMSUElCWO
        3GIBqWAW4JPoOPyXHSLMK9HRJgTRqCwx/fIEVghbUuLg63PMECUeEttmCEICZBajRO+GogmM
        crMQxi9gZFzFKJZaUJybnlpsVGAIj63k/NxNjODkp+W6g3Hy2w96hxiZOBgPMUpwMCuJ8E5V
        TUsS4k1JrKxKLcqPLyrNSS0+xGgKDLmJzFKiyfnA9JtXEm9oYmlgYmZmaG5kamCuJM7rlbIh
        UUggPbEkNTs1tSC1CKaPiYNTqoHJ3mLV3JBDjMEFn9RKznEsfV0V0Hvv30PmDoUcZdZbx64s
        lU+9VGFfaVs4qcqmc9WtZyvvGXRM+bjT771/gOqpB65X4/cZVB/R3RLzy3A9t6WCu26exxfJ
        v363Vi681x5tqFsidK9/Hf8kk1KvE4vSTt/yM5RvOe91zmX55jUcnxZWFN2c80cp5aNJ0M9f
        /JJOQRJNXaf//BaquRl4mm/q1oUX2qVZT4q0WuzdzrHpd+nLJcZHCgpebwvUtkz+FJdWpXb3
        82Zr09L/7EJt6pf9JxycsLxGWLqnMlogYkvYziuTY65n6jstPxa3jPmQkXtR8Wb2thNLVp+b
        Vy0j93jRFscHXx/eTlcJv2x3pPm0EktxRqKhFnNRcSIA2IBxAgcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvG7ozvQkgwdPeCzuLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZTy89Iyt4IxV
        xdbO7YwNjFMMuhg5OSQETCT2fe1n6WLk4hAS2M0ose/gRRaIhKTE0rk32CFsYYn7LUdYIYq+
        MUq86f3G1sXIwcEmoCXxfSEjSI2IQJzEist7wHqZBd4wSVzdnQRiCwsES+zffggsziKgKnHy
        5hVGkFZeATeJQ/ezIcbLSdw818kMYnMKuEu86FkEtlYIqGTyiutMExj5FjAyrGKUTC0ozk3P
        LTYsMMxLLdcrTswtLs1L10vOz93ECA5VLc0djNtXfdA7xMjEwXiIUYKDWUmEd6pqWpIQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTPObvqX6rHwXH7ap
        eH5DY/CTpREfXS7psMzwzJFY/Vp9rvOpvyxhi7PafVZ4HDij9u2nwgrppRNmiSe+OyqaFHni
        5tTMCFUR8+mlU4I3ak6SrOdZq3Fr1+V+Lb/gny9+XxQ90mwc8jRa77WnRf42vke7bqbFysh4
        BYZpW0f72F/KcfPf/ff3eq87XlwVd/uy5atv/36/1i3sgej8VS/d797V5j3PnmA6ucB+5QOF
        1MhbDIdjS1eultCvPcxta7q2iWMmt+zzy9M9pzE66yu6edxrLp8fIqPJyRsgKbNfeqPqSuW8
        ialRTzc4ztYwvVYYsHxT7uoPW3gr1ASaF8Rzf7JZmTHj2rG9ejc1PodMVmIpzkg01GIuKk4E
        AOfpD8zEAgAA
X-CMS-MailID: 20220426092021epcas2p4071f2b7621558a015579131990486a3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092021epcas2p4071f2b7621558a015579131990486a3c
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092021epcas2p4071f2b7621558a015579131990486a3c@epcas2p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export symbols for xhci hooks usage:
    xhci_get_slot_ctx
    xhci_get_endpoint_address
    - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
      getting the ep_ctx information to know which ep is offloading and
      comparing the context in remote subsystem memory if needed.

    xhci_ring_alloc
    - Allow xhci hook to allocate vendor specific ring. Vendors could
      alloc additional event ring.

    xhci_trb_virt_to_dma
    - Used to retrieve the DMA address of vendor specific ring. Vendors
      could get dequeue address of event ring.

    xhci_segment_free
    xhci_link_segments
    - Allow xhci hook to handle vendor specific segment. Vendors could
      directly free or link segments of vendor specific ring.

    xhci_initialize_ring_info
    - Allow xhci hook to initialize vendor specific ring.

    xhci_check_trb_in_td_math
    - Allow xhci hook to Check TRB math for validation. Vendors could
      check trb when allocating vendor specific ring.

    xhci_address_device
    - Allow override to give configuration info to Co-processor.

    xhci_bus_suspend
    xhci_bus_resume
    - Allow override of suspend and resume for power scenario.

    xhci_remove_stream_mapping
    - Allow to xhci hook to remove stream mapping. Vendors need to do it
      when free-ing vendor specific ring if it's stream type.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-hub.c  |  2 ++
 drivers/usb/host/xhci-mem.c  | 19 +++++++++++++------
 drivers/usb/host/xhci-ring.c |  1 +
 drivers/usb/host/xhci.c      |  4 +++-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index f65f1ba2b592..841617952ac7 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1812,6 +1812,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_bus_suspend);
 
 /*
  * Workaround for missing Cold Attach Status (CAS) if device re-plugged in S3.
@@ -1956,6 +1957,7 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_bus_resume);
 
 unsigned long xhci_get_resuming_ports(struct usb_hcd *hcd)
 {
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index bbb27ee2c6a3..82b9f90c0f27 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -65,7 +65,7 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
 	return seg;
 }
 
-static void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
+void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
 {
 	if (seg->trbs) {
 		dma_pool_free(xhci->segment_pool, seg->trbs, seg->dma);
@@ -74,6 +74,7 @@ static void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
 	kfree(seg->bounce_buf);
 	kfree(seg);
 }
+EXPORT_SYMBOL_GPL(xhci_segment_free);
 
 static void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
 				struct xhci_segment *first)
@@ -96,9 +97,9 @@ static void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
  * DMA address of the next segment.  The caller needs to set any Link TRB
  * related flags, such as End TRB, Toggle Cycle, and no snoop.
  */
-static void xhci_link_segments(struct xhci_segment *prev,
-			       struct xhci_segment *next,
-			       enum xhci_ring_type type, bool chain_links)
+void xhci_link_segments(struct xhci_segment *prev,
+			struct xhci_segment *next,
+			enum xhci_ring_type type, bool chain_links)
 {
 	u32 val;
 
@@ -118,6 +119,7 @@ static void xhci_link_segments(struct xhci_segment *prev,
 		prev->trbs[TRBS_PER_SEGMENT-1].link.control = cpu_to_le32(val);
 	}
 }
+EXPORT_SYMBOL_GPL(xhci_link_segments);
 
 /*
  * Link the ring to the new segments.
@@ -256,7 +258,7 @@ static int xhci_update_stream_segment_mapping(
 	return ret;
 }
 
-static void xhci_remove_stream_mapping(struct xhci_ring *ring)
+void xhci_remove_stream_mapping(struct xhci_ring *ring)
 {
 	struct xhci_segment *seg;
 
@@ -269,6 +271,7 @@ static void xhci_remove_stream_mapping(struct xhci_ring *ring)
 		seg = seg->next;
 	} while (seg != ring->first_seg);
 }
+EXPORT_SYMBOL_GPL(xhci_remove_stream_mapping);
 
 static int xhci_update_stream_mapping(struct xhci_ring *ring, gfp_t mem_flags)
 {
@@ -316,6 +319,7 @@ void xhci_initialize_ring_info(struct xhci_ring *ring,
 	 */
 	ring->num_trbs_free = ring->num_segs * (TRBS_PER_SEGMENT - 1) - 1;
 }
+EXPORT_SYMBOL_GPL(xhci_initialize_ring_info);
 
 /* Allocate segments and link them for a ring */
 static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
@@ -407,6 +411,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
 	kfree(ring);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xhci_ring_alloc);
 
 void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
@@ -518,6 +523,7 @@ struct xhci_slot_ctx *xhci_get_slot_ctx(struct xhci_hcd *xhci,
 	return (struct xhci_slot_ctx *)
 		(ctx->bytes + CTX_SIZE(xhci->hcc_params));
 }
+EXPORT_SYMBOL_GPL(xhci_get_slot_ctx);
 
 struct xhci_ep_ctx *xhci_get_ep_ctx(struct xhci_hcd *xhci,
 				    struct xhci_container_ctx *ctx,
@@ -1965,7 +1971,7 @@ static int xhci_test_trb_in_td(struct xhci_hcd *xhci,
 }
 
 /* TRB math checks for xhci_trb_in_td(), using the command and event rings. */
-static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
+int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
 {
 	struct {
 		dma_addr_t		input_dma;
@@ -2085,6 +2091,7 @@ static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
 	xhci_dbg(xhci, "TRB math tests passed.\n");
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_check_trb_in_td_math);
 
 static void xhci_set_hc_event_deq(struct xhci_hcd *xhci)
 {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f9707997969d..652b37cd9c5e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -79,6 +79,7 @@ dma_addr_t xhci_trb_virt_to_dma(struct xhci_segment *seg,
 		return 0;
 	return seg->dma + (segment_offset * sizeof(*trb));
 }
+EXPORT_SYMBOL_GPL(xhci_trb_virt_to_dma);
 
 static bool trb_is_noop(union xhci_trb *trb)
 {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 25b87e99b4dd..c06e8b21b724 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1468,6 +1468,7 @@ unsigned int xhci_get_endpoint_address(unsigned int ep_index)
 	unsigned int direction = ep_index % 2 ? USB_DIR_OUT : USB_DIR_IN;
 	return direction | number;
 }
+EXPORT_SYMBOL_GPL(xhci_get_endpoint_address);
 
 /* Find the flag for this endpoint (for use in the control context).  Use the
  * endpoint index to create a bitmask.  The slot context is bit 0, endpoint 0 is
@@ -4324,10 +4325,11 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	return ret;
 }
 
-static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
 	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
 }
+EXPORT_SYMBOL_GPL(xhci_address_device);
 
 static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
-- 
2.31.1

