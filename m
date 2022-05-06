Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E551D171
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353313AbiEFGh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351663AbiEFGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:26 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5465D1C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:43 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220506063341epoutp0172209a364d4be4e70fcf279dd34e449b~scHdmFlWv1941519415epoutp01V
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220506063341epoutp0172209a364d4be4e70fcf279dd34e449b~scHdmFlWv1941519415epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651818821;
        bh=CDSe4hMSW9iyh5nlVlFrqmdmtEl+nqw4l8+FBs360vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJhhuvDUkIUnj451zGOMwge052Pkvvflprtsue+9FRfuKCw11uWlT6VWe8ciDQCV3
         /33jFYWh0hiMNFmpNN9aU6o+7KvEtwslZ1ppg7q3dxAydHzzewprcl0J/onwRHf8gW
         61GaJlaNhOnhLu6iWCprwlMoO96Gt2UZFs1L0E7g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220506063340epcas2p3eb4d903c3fad698d2c06c7a372758834~scHc9tbwI0340303403epcas2p39;
        Fri,  6 May 2022 06:33:40 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KvgkV0m2bz4x9QP; Fri,  6 May
        2022 06:33:38 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.DF.10028.041C4726; Fri,  6 May 2022 15:33:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220506063336epcas2p3da4c57aaa5a74460a742985f8a9d4ce1~scHY-hBdu3067030670epcas2p3F;
        Fri,  6 May 2022 06:33:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506063336epsmtrp25c16d25f83ef329a3e2fdd5e60142f31~scHY9jqhU0488004880epsmtrp2M;
        Fri,  6 May 2022 06:33:36 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-fc-6274c140362a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.DD.08924.041C4726; Fri,  6 May 2022 15:33:36 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506063336epsmtip2ffe229746b87d0601961c24c87b954ed~scHYrEJjQ0642706427epsmtip20;
        Fri,  6 May 2022 06:33:36 +0000 (GMT)
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
        Jack Pham <jackp@codeaurora.org>,
        Howard Yen <howardyen@google.com>
Subject: [PATCH v5 1/6] usb: host: export symbols for xhci-exynos to use
 xhci hooks
Date:   Fri,  6 May 2022 15:31:14 +0900
Message-Id: <1651818679-10594-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTf0xTVxTe7Xt9fTSWvRXZLmwjTQUTUaCFAheRBaeyFybYuHQby7Q+6AsQ
        oC19ZdFlcyyOnwmKDBABCSgqEhTSIWqD8ktU2MZwbArMbjBwBBhIaBzEgq704fbfd875vu+c
        e+69JCb9nvAmU/Vm1qRn0uWEGG/r2RIeEN1lTlQU5kegsZo2Aq2W3BGhO7mTIvSotlyA+i/W
        CdCxc80EerjyBKC8qUECVY8EI9v4Mo5uzl4VIcvEAyEaslYTqOKnWwJ09kIOhr7pzcPRMUup
        ENlbJgAqtA0DVNLliTp+iY32pB3PSgD9z9MSnK7Kvo/TQ8eLBPSNSpuIrrVk0efapwW0pbGA
        oB89aCfojjNNIvq7+q/o462NgG5u/RWn7RYftfsnaTtSWEbHmmSsPsmgS9UnR8nf/0C7Sxsa
        plAGKCNQuFymZzLYKPnuveqAmNR056Hlss+Y9CxnSs1wnDzonR0mQ5aZlaUYOHOUnDXq0o3h
        xkCOyeCy9MmBeta8XalQBIc6iYfSUroG24Gxij584Y9VUTaYjSwEbiSkVHCh9m+iEIhJKXUd
        wGb73fVgEcB86zMBH9idlRf9+EvJiannOF+wAlhe/lDIB8sATg10iwoBSRKUP1yqA2v5jdQp
        DPY1Fbl8MaoYhyvWHpeVB6WBHR2PXRin/ODZS/ewNSyh9sCKxtME384HjgwUuPJuVAz8uazV
        5QqpBRKOls2vk3ZDy9IQ4LEHnLnbKuKxN7TP31zncNC6mCPgxdkAfj3Gd4NUCKz8Kw+sjY1R
        W2CzNWgNQmoTvD3qmg2j3GF+z6qIT0tgfq6UF26Cp4aKhTz2gl2zAxhPoWHL82h+J6cBrB/r
        xYqBT+X//rUANILXWSOXkcxywcaQ/64syZBhAa5X7f/edVAxtxDYDQQk6AaQxOQbJR6V5kSp
        RMcc+Zw1GbSmrHSW6wahzt2dxLw9kwzOb6E3a5WqCIUqLEwZHhyqCJe/IYnVtTBSKpkxs2ks
        a2RNL3UC0s07W/BF6aG6fVTjlcmPlz6qdzTde+WJyaQu0GXPzP/JjoxpNvgOT9hCFnMntdEB
        s9orQq9e/7Zdl/3u92ZWTcWLW3pG3tbnxMWpHOZO3/raab9tiWduHLkVebBI51edkF8lVeP9
        t6XbOmvIyaO2d9/a7rbcIJ5ZyK3UDRJJcXYgc6hqlj0O/6hi616zfXow80AU1qcRu++P3XnC
        evlD8OLkqwmcZOv4TMlv32qEwZeYhr4oXXNT/NEcz5ED6qdd9GpC/M7pxWud134f1wzJV0q3
        9m6A7pbNbudJgy7U12vO5sjUSL+cS2YHHv8QdDFyVJznKHtzc0yRbLChb2a/bO9w5tUOOc6l
        MEp/zMQx/wK3TRxdXgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXtfhYEmSwdbzwhYP5m1js/g76Ri7
        xbG2J+wWdxZMY7I4tXwhk0Xz4vVsFtf/vGe0aH9+gc1izk0ji7sPf7BY7H29ld1i0+NrrBaX
        d81hs5hxfh+TxaJlrcwWLUfbWSyaN01htfi84TGjRdfdG4wWkw6KWuy/4uUg6vH71yRGj29f
        J7F4zG64yOJxua+XyWPnrLvsHgs2lXos3vOSyWPTqk42jzvX9rB57J+7ht1j85J6j74tqxg9
        1m+5yuLxeZNcAF8Ul01Kak5mWWqRvl0CV8bBC3sYC2Z7VCy7/5e9gfG1dRcjJ4eEgIlE//N/
        LF2MXBxCAjsYJa613maGSEhKLJ17gx3CFpa433KEFaLoG6PE2ccnmLoYOTjYBLQkvi9kBKkR
        EZjLLLF1axFIDbPANBaJjXemgCWEBYIl9t38ywZiswioSixaeQJsAa+Aq8SMVTPZIBbISdw8
        1wkW5xRwk7g0dQtYrxBQzcI/35knMPItYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yf
        u4kRHFNaWjsY96z6oHeIkYmD8RCjBAezkgiv8KySJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        F7pOxgsJpCeWpGanphakFsFkmTg4pRqYzD1SRHXmb3V+t0n5+97D1dMjf7JObdN6+Hc5t7xx
        +PP73jXHv50V89mVbxOiMMF5/W5u4TWqz77YL/pzJ/DZ/b49XGLJ/7bvOP7tp2XcjQmR32SW
        /bUMOPdb2P597Po67cL/DybMf6ez+ZKNesqbCc+NBbgK5/NN8tTfN3H7EpGVOS8ZDyV2W9Rd
        MA75JWE0U8Bp2SGRSUtVzy9PSc+U/3l5Yq933bbHGzJdzxcwLvlVMMdP7Yvdawbh5JLYP6Ha
        EWUBEhmmC+53f7K45ay1LFuY8d62Arm7f0/IbtlllHq4bIWHjoOjSvuuWVqtLA/Sg93Pea7Y
        lH8ofMeu22uWbn58lmHegW6p39yfT0tH31ZiKc5INNRiLipOBADI4NK5GAMAAA==
X-CMS-MailID: 20220506063336epcas2p3da4c57aaa5a74460a742985f8a9d4ce1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220506063336epcas2p3da4c57aaa5a74460a742985f8a9d4ce1
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220506063336epcas2p3da4c57aaa5a74460a742985f8a9d4ce1@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
 drivers/usb/host/xhci.h      |  7 +++++++
 5 files changed, 26 insertions(+), 7 deletions(-)

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
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 473a33ce299e..5316841e9b26 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2054,6 +2054,11 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst);
 void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index);
+void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg);
+void xhci_link_segments(struct xhci_segment *prev,
+			struct xhci_segment *next,
+			enum xhci_ring_type type, bool chain_links);
+void xhci_remove_stream_mapping(struct xhci_ring *ring);
 struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 		unsigned int num_stream_ctxs,
 		unsigned int num_streams,
@@ -2100,6 +2105,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 		       struct usb_host_endpoint *ep);
 int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
+int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
@@ -2116,6 +2122,7 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 
 /* xHCI ring, segment, TRB, and TD functions */
 dma_addr_t xhci_trb_virt_to_dma(struct xhci_segment *seg, union xhci_trb *trb);
+int xhci_check_trb_in_td_math(struct xhci_hcd *xhci);
 struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
 		struct xhci_segment *start_seg, union xhci_trb *start_trb,
 		union xhci_trb *end_trb, dma_addr_t suspect_dma, bool debug);
-- 
2.31.1

