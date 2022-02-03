Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EA4A7E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349115AbiBCDAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:00:13 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22487 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349102AbiBCDAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:00:11 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220203030009epoutp012c11723812b88bc61a32bf3b4029dad4~QJ2wflIUU0955109551epoutp01g
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:00:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220203030009epoutp012c11723812b88bc61a32bf3b4029dad4~QJ2wflIUU0955109551epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643857209;
        bh=LGKG8Os53akFidJ0Qm+uFmsP9e/aXiWkXpoX/j2bbmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSqXjeYdpsJDRDFcyeA4ESVzKrraCK3OV5kbF9ccBSPQvaWK69buf9XTVDY72U7Ah
         ny9tzj8e3ZbUziXgTwXK2ZnMnG6ySrtE8h7tsVETb66BquJtZidGSiX1Kvw1QZQIPK
         F1NqvUVrVGuxZJVnAHsH/DjksBtMevEs1p42Skm4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220203030008epcas2p1a64d103ae8f9c02a051cb0600d541d05~QJ2wCNC7h2624326243epcas2p1N;
        Thu,  3 Feb 2022 03:00:08 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jq3Lb1yXlz4x9QB; Thu,  3 Feb
        2022 03:00:07 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.8F.12141.6354BF16; Thu,  3 Feb 2022 12:00:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220203030006epcas2p176f1e35ad72df3ab6b2a64d66e95bf15~QJ2uDHGOj0771807718epcas2p1d;
        Thu,  3 Feb 2022 03:00:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220203030006epsmtrp1e1d907840bd173600a8b99ee6aef3354~QJ2uCSRRc2974329743epsmtrp1y;
        Thu,  3 Feb 2022 03:00:06 +0000 (GMT)
X-AuditID: b6c32a48-5886ca8000002f6d-c5-61fb45362f44
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.B7.29871.6354BF16; Thu,  3 Feb 2022 12:00:06 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220203030006epsmtip2f22a5f0b2cb46425f30031c844162ad7~QJ2t2tle40211302113epsmtip2S;
        Thu,  3 Feb 2022 03:00:06 +0000 (GMT)
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
Subject: [PATCH 1/3] usb: host: export symbols for xhci hooks usage
Date:   Thu,  3 Feb 2022 11:57:32 +0900
Message-Id: <1643857054-112415-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmma656+9Eg+38FncWTGOyeHJkEbtF
        8+L1bBbX/7xntGh/foHN4vKuOWwWi5a1Mls0b5rCajFzrbIDp8flvl4mjwWbSj0W73nJ5LF/
        7hp2j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
        tVVy8QnQdcvMATpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqX
        rpeXWmJlaGBgZApUmJCdceOsb8HZ6IrWtg7mBsaX3l2MnBwSAiYSb2deZ+9i5OIQEtjBKHH3
        zS1mCOcTo8S7b29ZIJxvjBJbFzexwbRM3/sJqmUvo8Sq62uhnB+MEtOm/AVyODjYBLQkvi9k
        BGkQEYiTWNp5iQmkhllgKpNEx6x7LCAJYQFniRsTF4PZLAKqEu9anrOD2LwCbhLvmz6xQmyT
        k7h5rpMZxOYUcJc4MuUGI8ggCYFb7BLvzu9jgihykfi06iQLhC0s8er4FnYIW0riZX8blF0s
        setTKxNEcwOjROODE8wQCWOJWc/aGUGuZhbQlFi/Sx/ElBBQljhyC2wkswCfRMdhiL8kBHgl
        OtqEIBqVJaZfngB1pqTEwdfnmCFKPCRuN5ZCgmQWo8TfqzeYJjDKzUKYv4CRcRWjWGpBcW56
        arFRgQk8wpLzczcxglOclscOxtlvP+gdYmTiYDzEKMHBrCTCu3fh90Qh3pTEyqrUovz4otKc
        1OJDjKbAsJvILCWanA9Msnkl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KLYPqY
        ODilGph0d7bycci0XEiL2XF003rln+yzb3c8uuAUFV8gxlh5bYuyWtMjzrOLwm6wVkkf1ecS
        fKT80Va6UTuop/z2or5iuSVSMfO2Znj5VyhaaEsx79f0nGb3cFHk5othRtduzPs3YcOlyjsa
        EWrL2Kad/9I2+9QqqapGwdszv9ste7rR2r4zuUTIdCdzfmdU0FMJ9tOO3ovWa71+yLBngsf8
        69bhK3+E9axZ87R3o6o/0xoOdWW2W9t4zzn/1rupETetUPedxM1bv5dsND42+Ujnwiy3rFma
        8+LXHHp96sibFYfdNtxjVo+ew/5XfOXylP4/5hET/gjOf5f89/e9KY+mcfJFxdiuu5ekIpsQ
        a79jxts4JZbijERDLeai4kQARwc3+/oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvK6Z6+9Eg3PPVCzuLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XlXXPYLBYta2W2aN40hdVi5lplB06Py329TB4LNpV6LN7zkslj
        /9w17B59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVceOsb8HZ6IrWtg7mBsaX3l2MnBwSAiYS
        0/d+YgexhQR2M0q8u2IDEZeUWDr3BjuELSxxv+UIaxcjF1DNN0aJq3ePAiU4ONgEtCS+L2QE
        qRERiJNYcXkPC0gNs8BsJonNx6+DJYQFnCVuTFzMAmKzCKhKvGt5DjaUV8BN4n3TJ1aIBXIS
        N891MoPYnALuEkem3GCEOMhNYvXVPsYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXr
        JefnbmIEB6OW5g7G7as+6B1iZOJgPMQowcGsJMK7d+H3RCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYtFZuYNh/8+O5bV+0FmzYV7hhCl90tcDdYqX7
        S7RnveL5ZdfV+Y+LQZDzmP5/d8MLN1efsFsRFCe72evxvf9vFnMrqipt3fYugf/wLLXIyfrZ
        N5tY/zfMeGupeqNq9lK21gfHAwNnbk9uzP0ZV2H1fN85EaMLX1+xfI0s4OF3jNi++LV9/Lrl
        Z83Eyi9XLhPZ53GJx1PvNvtSQ36LoqmCRTvXHNaPinTt0Jgz9dqziGPX90WcrJD17j35R+HU
        +cfr9FIl71zzvrdfNK+s5IPwmdpvJYpL77rx3vZu5hCU25dauTRCd+Y2dQWlJg+fOaYfLB/P
        eP9k8VGze2c/el3aVTKLvdBBlpX9s/rrgu+bw5VYijMSDbWYi4oTAVs99Ha1AgAA
X-CMS-MailID: 20220203030006epcas2p176f1e35ad72df3ab6b2a64d66e95bf15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220203030006epcas2p176f1e35ad72df3ab6b2a64d66e95bf15
References: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220203030006epcas2p176f1e35ad72df3ab6b2a64d66e95bf15@epcas2p1.samsung.com>
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

