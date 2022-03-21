Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC24E22DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbiCUJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345598AbiCUJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:03:41 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821291574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:02:13 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220321090211epoutp02fb5cbf94141bd690a312112ea8bb19ac~eWd-cQPvY1331713317epoutp02X
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:02:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220321090211epoutp02fb5cbf94141bd690a312112ea8bb19ac~eWd-cQPvY1331713317epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647853331;
        bh=0ZBKOal9o0RAwuPgYl39qViuPY1EiXnhyFe1NQOXlrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9xgPm4haxpIr9G3S3mWcvLBthYFnFwk/1wiKQwPw7k8ic1CdS3pcYpd0ki4/k136
         gvTozL+DhxQJ3DudHJMFNRWMNFSg3Nn5uz6+uS6iIftS+U94Cncvz7z6CrfrGsMmSO
         giT2tAuM+j68Y6HzabLjTPcx8CEI7PzSrK2YMiMM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220321090211epcas2p4237f28cb622e695e90f57ea0db78a089~eWd_6hJZW0252402524epcas2p4v;
        Mon, 21 Mar 2022 09:02:11 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KMTC31YDTz4x9QH; Mon, 21 Mar
        2022 09:02:07 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.16.25540.C0F38326; Mon, 21 Mar 2022 18:02:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220321090204epcas2p31e39a4b8b6fc803ceecac5d19e6e39e9~eWd4hNu8u1861518615epcas2p3I;
        Mon, 21 Mar 2022 09:02:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321090204epsmtrp1577d4b73b077bdb91a42d68d917e800e~eWd4fpugv2591125911epsmtrp1a;
        Mon, 21 Mar 2022 09:02:04 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-70-62383f0cb425
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.F7.03370.C0F38326; Mon, 21 Mar 2022 18:02:04 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220321090203epsmtip264c16ceaf60044cce02b0cdada3b8f9c~eWd4PxAtW1528315283epsmtip26;
        Mon, 21 Mar 2022 09:02:03 +0000 (GMT)
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
Subject: [PATCH v3 1/4] usb: host: export symbols for xhci hooks usage
Date:   Mon, 21 Mar 2022 17:59:51 +0900
Message-Id: <1647853194-62147-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmuS6PvUWSwfI9JhZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLC
        XEkhLzE31VbJxSdA1y0zB+gwJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFe
        cWJucWleul5eaomVoYGBkSlQYUJ2xo7nE9kKfphX7Pz+hb2BcYpeFyMnh4SAiUTX+ScsXYxc
        HEICOxglfh16yQ7hfGKUONjTB5X5zCgx9d98oAwHWMvzByUQ8V2MEoe+n2eCcH4wSlza+Z4V
        pIhNQEvi+0JGkBUiAnESSzsvgdUwC6xmknj/8SIbSEJYwE2if+dbZhCbRUBVon3/BbAGXgFX
        iYYFvxkh7pOTuHmuE6yGE6h+7c1GsIskBF6ySyw5/Q3qIheJb9vTIOqFJV4d38IOYUtJvOxv
        g7KLJXZ9amWC6G1glGh8cIIZImEsMetZOyPIHGYBTYn1u/QhRipLHLnFAlLBLMAn0XH4L9Qm
        XomONiGIRmWJ6ZcnsELYkhIHX5+DGughseRuBzRIZjJK7Ju1lXUCo9wshAULGBlXMYqlFhTn
        pqcWGxUYwyMsOT93EyM43Wm572Cc8faD3iFGJg7GQ4wSHMxKIryLP5gnCfGmJFZWpRblxxeV
        5qQWH2I0BYbdRGYp0eR8YMLNK4k3NLE0MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTT
        x8TBKdXAxPH8QvMdo33cGk/aHkbMkXSc8Sd8N+/dl9zpUas7l+tU7FjBuGol99Pp3MtM+Fyn
        2uy9urR42ylR30tqd45tEVjJOpHP/sKdjUff+KqWCi96azZFvrh+0Yn0AyylOve5gx15xRhC
        e81C9y27dvbRX9H/bCZv1OayBT2e8PJf5JW6Q1u47m7jebtWepfCNOHOBwWx9zMOPTvT4Vgb
        oKdq8ykz1dLX9cjBc8ulD9+eZmmgpxsnoZ3f5vu87fuDaUo+L+7uZ9vpJdad1c3l0nvQeEld
        60eH9nUfdzq9PSKjc33HpKQuiatBPiXTrt3+FZPJyWQa2bfH7Ib+ubkLT7d9W/BqQlFA7dno
        3qp9H3V9/iuxFGckGmoxFxUnAgDnotB2AAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvC6PvUWSwZI7zBZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8f+uWvYPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjx/OJbAU/zCt2fv/C3sA4Ra+L
        kYNDQsBE4vmDki5GLg4hgR2MEtv/P2TpYuQEiktKLJ17gx3CFpa433KEFaLoG6PEnnsXWEGa
        2QS0JL4vZASpERGIk1hxeQ8LSA2zwEYmiUkPLoENEhZwk+jf+ZYZxGYRUJVo338BrIFXwFWi
        YcFvRogFchI3z3WC1XAC1a+92QjWKwRUs3XSDNYJjHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn
        5haX5qXrJefnbmIEB6aW1g7GPas+6B1iZOJgPMQowcGsJMK7+IN5khBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MKQ7XVh5PfaS+6E//8Y8ysyfNsrgs
        Vy5zc0tV3oeU+ZtnWteeNzuyv77oCL/po+0CxyW5Tk/LnzFx9+GF/Q9XbXltdVbiK8fk088W
        c3R7S3Jx3Woo/rS3/aBa/JfwkP95l21rfv5auOPuSsEHLrUcan+EEvjsPr2Oz/SeuH8Pa2tu
        ww5Bv2lW6dNvHy7bYR5W2fpVfQFDaMw9QZ4TAXJza1aXfU30iCmRvXC/LeyXPNvGF4ubJWff
        fL5qx+ePq3Qu7axbsHf7GdfHmV/bGW7cc9Oad/fH9L1/3z72ee99eMskvsexl42nBUzf/ulb
        7+opez+tb3Rw7hXanP2N3T3keW307UUGvZLeU2w3mquGNTsosRRnJBpqMRcVJwIAJzsT2LsC
        AAA=
X-CMS-MailID: 20220321090204epcas2p31e39a4b8b6fc803ceecac5d19e6e39e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090204epcas2p31e39a4b8b6fc803ceecac5d19e6e39e9
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090204epcas2p31e39a4b8b6fc803ceecac5d19e6e39e9@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
    - Allow xhci hook to allocate vendor specific ring.

    xhci_trb_virt_to_dma
    - Used to retrieve the DMA address of vendor specific ring.

    xhci_segment_free
    xhci_link_segments
    - Allow xhci hook to handle vendor specific segment.

    xhci_initialize_ring_info
    - Allow xhci hook to initialize vendor specific ring.

    xhci_check_trb_in_td_math
    - Allow xhci hook to Check TRB math for validation.

    xhci_address_device
    - Allow override to give configuration info to Co-processor.

    xhci_bus_suspend
    xhci_bus_resume
    - Allow override of suspend and resume for power scenario.

    xhci_remove_stream_mapping
    - Allow xhci hook to remove stream mapping.

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
index 1e7dc130c39a..56546aaa93c7 100644
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
index d0b6806275e0..c6896bdab763 100644
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
index 642610c78f58..8f53672dcd97 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1457,6 +1457,7 @@ unsigned int xhci_get_endpoint_address(unsigned int ep_index)
 	unsigned int direction = ep_index % 2 ? USB_DIR_OUT : USB_DIR_IN;
 	return direction | number;
 }
+EXPORT_SYMBOL_GPL(xhci_get_endpoint_address);
 
 /* Find the flag for this endpoint (for use in the control context).  Use the
  * endpoint index to create a bitmask.  The slot context is bit 0, endpoint 0 is
@@ -4313,10 +4314,11 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
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

