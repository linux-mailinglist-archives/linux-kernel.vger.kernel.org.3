Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF84CCDD0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiCDGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiCDGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:33:55 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D95018620B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:33:05 -0800 (PST)
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220304063303epoutp04e067460d323b2ad39dfffc0f45fe2a86~ZGd7SIcak2812728127epoutp04T
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:33:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220304063303epoutp04e067460d323b2ad39dfffc0f45fe2a86~ZGd7SIcak2812728127epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646375583;
        bh=LGKG8Os53akFidJ0Qm+uFmsP9e/aXiWkXpoX/j2bbmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkQJwXo4LoBwmkxWaMGwWaLZvddUbq143x02dndOn3zEzgv+psJ4AsnWaeHEdUxId
         TVRQ9Gvx90BMooF+q+7fsV4qKh5xmzErtbaw6X3H3ToAszHugs2NDndy7CyUYklVPF
         ofz6lD3Mj3eunCxd5COWp9vQfX33Y1NYl1gDNinE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas3p4.samsung.com (KnoxPortal) with ESMTP id
        20220304063303epcas3p4385c61726bd4a7b9a6358312aa0a104b~ZGd6zL7Tz3190631906epcas3p4H;
        Fri,  4 Mar 2022 06:33:03 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4K8yhv08Bxz4x9Pv; Fri,  4 Mar 2022 06:33:03 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220304062617epcas2p2084161966aaa66d07f4c25720ec18088~ZGYAsvwuM0423504235epcas2p2R;
        Fri,  4 Mar 2022 06:26:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220304062617epsmtrp27ab0a9a39a7a0952f9065849d7fc7003~ZGYAr9Ldj1333913339epsmtrp24;
        Fri,  4 Mar 2022 06:26:17 +0000 (GMT)
X-AuditID: b6c32a29-41fff700000074af-3d-6221b108d0e8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.B3.29871.801B1226; Fri,  4 Mar 2022 15:26:16 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220304062616epsmtip263bd17f1bcfb61d4f3d2dea4ce036a9e~ZGYAe_yM_1782617826epsmtip2P;
        Fri,  4 Mar 2022 06:26:16 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: [PATCH v1 1/4] usb: host: export symbols for xhci hooks usage
Date:   Fri,  4 Mar 2022 15:23:55 +0900
Message-Id: <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvC7HRsUkg+0brS1WHJ7HaPHykKbF
        5odX2CzuLJjGZPHkyCJ2i+bF69ksrv95z2jR/vwCm8XlXXPYLBYta2W2aN40hdVi5lpli667
        NxgdeD0u9/UyeSzYVOqxeM9LJo/9c9ewe7Sc3M/i0bdlFaPH501yAexRXDYpqTmZZalF+nYJ
        XBk3zvoWnI2uaG3rYG5gfOndxcjBISFgIjHzXGEXIxeHkMBuRomH354ydjFyAsUlJZbOvcEO
        YQtL3G85wgpiCwl8Y5RY/1kApJdNQEvi+0KwchGBOIkVl/ewgMxhFuhnltjQfAusXljATWLn
        ygNgc1gEVCU2r/kBZvMKuEq03r3BBjFfTuLmuU5mEJsTqH7L/SNsELtcJR60PmKcwMi3gJFh
        FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcOhqae5g3L7qg94hRiYOxkOMEhzMSiK8
        lpoKSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw7U5f
        vs+wY5mZ0Rnv/RNZL6w5kvNsDe/slV/nfgq53WfQfVpA54VQyEe3M8K3/eNzfipFnp921c6V
        5zGjauzB3v0xFw11D5r0S+XynTKXWdqUKfrtr7RJA5+UcNjjKSqydtcmF+hn7Ewq8DawNDzy
        tkD0R9E1T4l4350/ZHPPnC0vFWNQeLQwwF1/up7L6SuTDlXOUeg15PyuIjy3uETZZOF1ibMa
        btlG4ufuK7AZb+AQsfn4iW/irU3nHJcHfalc0+s2NavJfKNJMqO7wt+G+E+V0xjYq/NX2N/U
        Fmw/syY5b4tuTsHsmuw5SwKOvP+z76VpUfXE76t1bDrWbI7My0pwWaJ4ruVVpJ4gj5USS3FG
        oqEWc1FxIgBc7/yMzAIAAA==
X-CMS-MailID: 20220304062617epcas2p2084161966aaa66d07f4c25720ec18088
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CMS-RootMailID: 20220304062617epcas2p2084161966aaa66d07f4c25720ec18088
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220304062617epcas2p2084161966aaa66d07f4c25720ec18088@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
---
 drivers/usb/host/xhci-hub.c  |  2 ++
 drivers/usb/host/xhci-mem.c  | 29 +++++++++++++++++++++--------
 drivers/usb/host/xhci-ring.c |  9 +++++++--
 drivers/usb/host/xhci.c      |  4 +++-
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index df3522dab31b..6c1b8d748d0f 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1809,6 +1809,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_bus_suspend);
 
 /*
  * Workaround for missing Cold Attach Status (CAS) if device re-plugged in S3.
@@ -1953,6 +1954,7 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_bus_resume);
 
 unsigned long xhci_get_resuming_ports(struct usb_hcd *hcd)
 {
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 0e312066c5c6..e6d56ef91ddb 100644
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
@@ -519,6 +526,7 @@ struct xhci_slot_ctx *xhci_get_slot_ctx(struct xhci_hcd *xhci,
 	return (struct xhci_slot_ctx *)
 		(ctx->bytes + CTX_SIZE(xhci->hcc_params));
 }
+EXPORT_SYMBOL_GPL(xhci_get_slot_ctx);
 
 struct xhci_ep_ctx *xhci_get_ep_ctx(struct xhci_hcd *xhci,
 				    struct xhci_container_ctx *ctx,
@@ -1755,6 +1763,7 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
 	INIT_LIST_HEAD(&command->cmd_list);
 	return command;
 }
+EXPORT_SYMBOL_GPL(xhci_alloc_command);
 
 struct xhci_command *xhci_alloc_command_with_ctx(struct xhci_hcd *xhci,
 		bool allocate_completion, gfp_t mem_flags)
@@ -1788,6 +1797,7 @@ void xhci_free_command(struct xhci_hcd *xhci,
 	kfree(command->completion);
 	kfree(command);
 }
+EXPORT_SYMBOL_GPL(xhci_free_command);
 
 int xhci_alloc_erst(struct xhci_hcd *xhci,
 		    struct xhci_ring *evt_ring,
@@ -1818,6 +1828,7 @@ int xhci_alloc_erst(struct xhci_hcd *xhci,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_alloc_erst);
 
 void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 {
@@ -1831,6 +1842,7 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 				erst->erst_dma_addr);
 	erst->entries = NULL;
 }
+EXPORT_SYMBOL_GPL(xhci_free_erst);
 
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
@@ -1969,7 +1981,7 @@ static int xhci_test_trb_in_td(struct xhci_hcd *xhci,
 }
 
 /* TRB math checks for xhci_trb_in_td(), using the command and event rings. */
-static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
+int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
 {
 	struct {
 		dma_addr_t		input_dma;
@@ -2089,6 +2101,7 @@ static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
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
index dc357cabb265..041a65a6f175 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1449,6 +1449,7 @@ unsigned int xhci_get_endpoint_address(unsigned int ep_index)
 	unsigned int direction = ep_index % 2 ? USB_DIR_OUT : USB_DIR_IN;
 	return direction | number;
 }
+EXPORT_SYMBOL_GPL(xhci_get_endpoint_address);
 
 /* Find the flag for this endpoint (for use in the control context).  Use the
  * endpoint index to create a bitmask.  The slot context is bit 0, endpoint 0 is
@@ -4306,10 +4307,11 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
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


