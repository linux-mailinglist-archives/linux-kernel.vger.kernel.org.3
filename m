Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23EC4CFC13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbiCGK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiCGK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:43 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB81B78B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:18:55 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220307101854epoutp02217d124597cfe02ee8a5ef5d17a1d045~aEe_MbQuy2659526595epoutp02S
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220307101854epoutp02217d124597cfe02ee8a5ef5d17a1d045~aEe_MbQuy2659526595epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646648334;
        bh=gBkRa9oyvlGi4TXhpuLV+ga0eBimnmJJi9TO6A9hnjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYhRBp8B0oDtB4y840YxhdEU3aeEkXJL8j960dZPEJYD1AIs6H9394s8Fyvyp76cB
         nAhrvG3YYUIGfoXXfgnVY+8672TYJygbWyol1ZOHKQsBZWvJYYBYNcDdE5s+yXXI9X
         VscNloP2JXhUWZCe59KwIPO0IcJnfWMiFqQPZCJk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220307101853epcas2p10f2e5a89f5d549ceafb7c45db88017d7~aEe9bWTGl2100421004epcas2p1B;
        Mon,  7 Mar 2022 10:18:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KBvZ24ZWGz4x9Q2; Mon,  7 Mar
        2022 10:18:50 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.AC.51767.A0CD5226; Mon,  7 Mar 2022 19:18:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220307101850epcas2p4ac4158cd821031464cd3aa6eb4e5d2a7~aEe6WTaLm2631426314epcas2p4P;
        Mon,  7 Mar 2022 10:18:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220307101850epsmtrp13eb08abc38b2094bb1922873416214b4~aEe6VKy753178231782epsmtrp1S;
        Mon,  7 Mar 2022 10:18:50 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-10-6225dc0a047d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.81.29871.90CD5226; Mon,  7 Mar 2022 19:18:50 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220307101849epsmtip25765e3a1d1d8baef7d07e61ae83b1939~aEe6HLGD-0474804748epsmtip2Z;
        Mon,  7 Mar 2022 10:18:49 +0000 (GMT)
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
Subject: [PATCH v2 1/4] usb: host: export symbols for xhci hooks usage
Date:   Mon,  7 Mar 2022 19:17:33 +0900
Message-Id: <1646648256-105214-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTTJfrjmqSwcouBYuXhzQtNj+8wmZx
        Z8E0JosnRxaxWzQvXs9mcf3Pe0aL9ucX2Cwu75rDZrFoWSuzRfOmKawWM9cqW3TdvcHowONx
        ua+XyWPBplKPxXteMnnsn7uG3aNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od
        403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fY
        KqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ8y6cpO9YENMxZyGlcwNjId8uhg5OSQE
        TCR+bO1lArGFBHYwSvz5n9fFyAVkf2KUuPNgMQuE841R4uStu2wwHX+Xbofq2Mso8euKC0TR
        D0aJrRd2M3YxcnCwCWhJfF/ICFIjIhAnsbTzEhNIDbPAVSaJJRuOsYMkhAXcJGY9ncsMYrMI
        qEo0nr7GCmLzAsVfT53JDLFMTuLmuU4wm1PAXeLblF6wQRICH9kl/u88xgJR5CJx9MQedghb
        WOLV8S1QtpTEy/42KLtYYtenVqjmBkaJxgcnoDYYS8x61g52NbOApsT6XfogpoSAssSRW1Dj
        eSUaNv4GG8MswCfRcfgvO0QJr0RHmxBEibLE9MsTWCFsSYmDr89BDfeQ2PtwLyskrGYxSqx9
        FzWBUX4Wwq4FjIyrGMVSC4pz01OLjQoM4XGXnJ+7iRGcFrVcdzBOfvtB7xAjEwfjIUYJDmYl
        Ed7751WShHhTEiurUovy44tKc1KLDzGaAsNxIrOUaHI+MDHnlcQbmlgamJiZGZobmRqYK4nz
        eqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgUol9/WGyR63v0ehqpYhLoYZ7PSoMr7Le071huGeV
        cmaO2HSxdxvezt4gfnZuXOf9e2/M88Tm3GeWir5WxDjFhCP36f3v9bt2HF5heEma2+f+/8MJ
        F10K1t92upX3evadz453s/WnLmwyZl32rP/pbpZ3vBs6mrzrF+9SnXik2JpRsO5D+7ekiY3Z
        Lz11Lu1WYtsmpnJo3ZwncYryP5i9GycJP024zNZRI6d2m3vH/0fzZ4tv0Vi1n+uRyJd52kp3
        wkUO14pfklrGeyh85dm52/8bLPdbkBRzWkyx/iDbn2ta4Wb3hef8lKqvPbPoNLumqsJljgn/
        oy88C3qwK+RWfltU5sfMHVu9V2202esQIqvEUpyRaKjFXFScCACYHo6EFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvC7XHdUkg/P3mCxeHtK02PzwCpvF
        nQXTmCyeHFnEbtG8eD2bxfU/7xkt2p9fYLO4vGsOm8WiZa3MFs2bprBazFyrbNF19wajA4/H
        5b5eJo8Fm0o9Fu95yeSxf+4ado++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKmHXlJnvBhpiK
        OQ0rmRsYD/l0MXJySAiYSPxdup2pi5GLQ0hgN6NE477zbBAJSYmlc2+wQ9jCEvdbjrBCFH1j
        lGg+1QhUxMHBJqAl8X0hI0iNiECcxIrLe1hAapgF7jNJnH/3nRUkISzgJjHr6VxmEJtFQFWi
        8fQ1sDgvUPz11JnMEAvkJG6e6wSzOQXcJb5N6WUCsYWAai6euMo0gZFvASPDKkbJ1ILi3PTc
        YsMCw7zUcr3ixNzi0rx0veT83E2M4GDV0tzBuH3VB71DjEwcjIcYJTiYlUR4759XSRLiTUms
        rEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBKfr0v2+b7PW9yxTP
        tFemrNkrwH+0UiFS++n04Lg6GfGnm72kVtZanzY5pq/+oOKYwJGSGp32dBV3k5n8SlvCZ7+3
        lNBUeGh4d+6dw267nskEW9xuOGm6b9Gl/UZBwrurNkmUn5F917jf+2rh103mj0Mn2Nls3vn2
        9def7dcD7mbZT5jD2rxSf2nN7YcvsoTjN78//GJzo8Xp9e7pk65+dVodEs7gxl3xq+XzMpYp
        wo+Ofy7QX2h2NZqVeV3TUs7FeY/T3V1vycw7wJP0pVdQM1X1ljX76aMCL2pmLS7+usiLd63W
        F8Vr7Q5TuXh/ponNCXaQvrvp4sEMo/3itZJGqh6LzM2/urkGzZDR6bklo8RSnJFoqMVcVJwI
        ALgtBmnFAgAA
X-CMS-MailID: 20220307101850epcas2p4ac4158cd821031464cd3aa6eb4e5d2a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307101850epcas2p4ac4158cd821031464cd3aa6eb4e5d2a7
References: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220307101850epcas2p4ac4158cd821031464cd3aa6eb4e5d2a7@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export symbols for xhci hooks usage:
	xhci_ring_free
	- Allow xhci hook to free xhci_ring.

	xhci_get_slot_ctx
	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
	  for getting the slot_ctx information to know which slot is
	  offloading and compare the context in remote subsystem memory
	  if needed.

	xhci_get_ep_ctx
	- Allow xhci hook to get ep_ctx from the xhci_container_ctx for
	  getting the ep_ctx information to know which ep is offloading and
	  comparing the context in remote subsystem memory if needed.

	xhci_handle_event
	- Allow xhci hook to handle the xhci events from the USB
	  controller.

	xhci_update_erst_dequeue
	- If xhci events was handle by xhci hook, it needs to update
	  the erst dequeue pointer to let the USB controller know the
	  events was handled.

	xhci_ring_alloc
	- Allocate a struct xhci_ring.

	xhci_alloc_erst
	xhci_free_erst
	- Allocate and free event ring segment tables.

	xhci_trb_virt_to_dma
	- Used to retrieve the DMA address of a TRB

	xhci_ring_cmd_db
	- Notify the controller when a new command is issued

	xhci_alloc_command
	xhci_free_command
	- Allocate and free a struct xhci_command

	xhci_queue_stop_endpoint
	- Issue a stop endpoint command to the controller

	xhci_segment_free
	- Free a segment struct.

	xhci_link_segments
	- Make the prev segment point to the next segment.

	xhci_initialize_ring_info
	- Initialize a ring struct.

	xhci_check_trb_in_td_math
	- Check TRB math for validation.

	xhci_get_endpoint_address
	- Get endpoint address from endpoint index.

	xhci_address_device
	- Issue an address device command

	xhci_bus_suspend
	xhci_bus_resume
	- Suspend and resume for power scenario

	xhci_remove_stream_mapping
	- Remove stream mapping in stream endpoint

	xhci_remove_segment_mapping
	- Remove segment mapping

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-hub.c  |  2 ++
 drivers/usb/host/xhci-mem.c  | 29 +++++++++++++++++++++--------
 drivers/usb/host/xhci-ring.c |  9 +++++++--
 drivers/usb/host/xhci.c      |  4 +++-
 4 files changed, 33 insertions(+), 11 deletions(-)

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
index bbb27ee2c6a3..45be6732eb89 100644
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
@@ -74,8 +74,9 @@ static void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
 	kfree(seg->bounce_buf);
 	kfree(seg);
 }
+EXPORT_SYMBOL_GPL(xhci_segment_free);
 
-static void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
+void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
 				struct xhci_segment *first)
 {
 	struct xhci_segment *seg;
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
@@ -206,7 +208,7 @@ static int xhci_insert_segment_mapping(struct radix_tree_root *trb_address_map,
 	return ret;
 }
 
-static void xhci_remove_segment_mapping(struct radix_tree_root *trb_address_map,
+void xhci_remove_segment_mapping(struct radix_tree_root *trb_address_map,
 		struct xhci_segment *seg)
 {
 	unsigned long key;
@@ -215,6 +217,7 @@ static void xhci_remove_segment_mapping(struct radix_tree_root *trb_address_map,
 	if (radix_tree_lookup(trb_address_map, key))
 		radix_tree_delete(trb_address_map, key);
 }
+EXPORT_SYMBOL_GPL(xhci_remove_segment_mapping);
 
 static int xhci_update_stream_segment_mapping(
 		struct radix_tree_root *trb_address_map,
@@ -256,7 +259,7 @@ static int xhci_update_stream_segment_mapping(
 	return ret;
 }
 
-static void xhci_remove_stream_mapping(struct xhci_ring *ring)
+void xhci_remove_stream_mapping(struct xhci_ring *ring)
 {
 	struct xhci_segment *seg;
 
@@ -269,6 +272,7 @@ static void xhci_remove_stream_mapping(struct xhci_ring *ring)
 		seg = seg->next;
 	} while (seg != ring->first_seg);
 }
+EXPORT_SYMBOL_GPL(xhci_remove_stream_mapping);
 
 static int xhci_update_stream_mapping(struct xhci_ring *ring, gfp_t mem_flags)
 {
@@ -292,6 +296,7 @@ void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring)
 
 	kfree(ring);
 }
+EXPORT_SYMBOL_GPL(xhci_ring_free);
 
 void xhci_initialize_ring_info(struct xhci_ring *ring,
 			       unsigned int cycle_state)
@@ -316,6 +321,7 @@ void xhci_initialize_ring_info(struct xhci_ring *ring,
 	 */
 	ring->num_trbs_free = ring->num_segs * (TRBS_PER_SEGMENT - 1) - 1;
 }
+EXPORT_SYMBOL_GPL(xhci_initialize_ring_info);
 
 /* Allocate segments and link them for a ring */
 static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
@@ -407,6 +413,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
 	kfree(ring);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xhci_ring_alloc);
 
 void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
@@ -518,6 +525,7 @@ struct xhci_slot_ctx *xhci_get_slot_ctx(struct xhci_hcd *xhci,
 	return (struct xhci_slot_ctx *)
 		(ctx->bytes + CTX_SIZE(xhci->hcc_params));
 }
+EXPORT_SYMBOL_GPL(xhci_get_slot_ctx);
 
 struct xhci_ep_ctx *xhci_get_ep_ctx(struct xhci_hcd *xhci,
 				    struct xhci_container_ctx *ctx,
@@ -1754,6 +1762,7 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
 	INIT_LIST_HEAD(&command->cmd_list);
 	return command;
 }
+EXPORT_SYMBOL_GPL(xhci_alloc_command);
 
 struct xhci_command *xhci_alloc_command_with_ctx(struct xhci_hcd *xhci,
 		bool allocate_completion, gfp_t mem_flags)
@@ -1787,6 +1796,7 @@ void xhci_free_command(struct xhci_hcd *xhci,
 	kfree(command->completion);
 	kfree(command);
 }
+EXPORT_SYMBOL_GPL(xhci_free_command);
 
 int xhci_alloc_erst(struct xhci_hcd *xhci,
 		    struct xhci_ring *evt_ring,
@@ -1817,6 +1827,7 @@ int xhci_alloc_erst(struct xhci_hcd *xhci,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_alloc_erst);
 
 void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 {
@@ -1830,6 +1841,7 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 				erst->erst_dma_addr);
 	erst->entries = NULL;
 }
+EXPORT_SYMBOL_GPL(xhci_free_erst);
 
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
@@ -1965,7 +1977,7 @@ static int xhci_test_trb_in_td(struct xhci_hcd *xhci,
 }
 
 /* TRB math checks for xhci_trb_in_td(), using the command and event rings. */
-static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
+int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
 {
 	struct {
 		dma_addr_t		input_dma;
@@ -2085,6 +2097,7 @@ static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
 	xhci_dbg(xhci, "TRB math tests passed.\n");
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_check_trb_in_td_math);
 
 static void xhci_set_hc_event_deq(struct xhci_hcd *xhci)
 {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d0b6806275e0..2e99393560e5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -79,6 +79,7 @@ dma_addr_t xhci_trb_virt_to_dma(struct xhci_segment *seg,
 		return 0;
 	return seg->dma + (segment_offset * sizeof(*trb));
 }
+EXPORT_SYMBOL_GPL(xhci_trb_virt_to_dma);
 
 static bool trb_is_noop(union xhci_trb *trb)
 {
@@ -311,6 +312,7 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 	/* Flush PCI posted writes */
 	readl(&xhci->dba->doorbell[0]);
 }
+EXPORT_SYMBOL_GPL(xhci_ring_cmd_db);
 
 static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci, unsigned long delay)
 {
@@ -2965,7 +2967,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
  * Returns >0 for "possibly more events to process" (caller should call again),
  * otherwise 0 if done.  In future, <0 returns should indicate error code.
  */
-static int xhci_handle_event(struct xhci_hcd *xhci)
+int xhci_handle_event(struct xhci_hcd *xhci)
 {
 	union xhci_trb *event;
 	int update_ptrs = 1;
@@ -3034,13 +3036,14 @@ static int xhci_handle_event(struct xhci_hcd *xhci)
 	 */
 	return 1;
 }
+EXPORT_SYMBOL_GPL(xhci_handle_event);
 
 /*
  * Update Event Ring Dequeue Pointer:
  * - When all events have finished
  * - To avoid "Event Ring Full Error" condition
  */
-static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
+void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 		union xhci_trb *event_ring_deq)
 {
 	u64 temp_64;
@@ -3070,6 +3073,7 @@ static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 	temp_64 |= ERST_EHB;
 	xhci_write_64(xhci, temp_64, &xhci->ir_set->erst_dequeue);
 }
+EXPORT_SYMBOL_GPL(xhci_update_erst_dequeue);
 
 /*
  * xHCI spec says we can get an interrupt, and if the HC has an error condition,
@@ -4420,6 +4424,7 @@ int xhci_queue_stop_endpoint(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	return queue_command(xhci, cmd, 0, 0, 0,
 			trb_slot_id | trb_ep_index | type | trb_suspend, false);
 }
+EXPORT_SYMBOL_GPL(xhci_queue_stop_endpoint);
 
 int xhci_queue_reset_ep(struct xhci_hcd *xhci, struct xhci_command *cmd,
 			int slot_id, unsigned int ep_index,
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

