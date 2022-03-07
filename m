Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBFF4CF120
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiCGF1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiCGF1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:27:10 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0620197
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:26:16 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220307052610epoutp0232c1a0d6818c3ad441ccd853290bd052~aAfYK92Cd2991929919epoutp02i
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:26:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220307052610epoutp0232c1a0d6818c3ad441ccd853290bd052~aAfYK92Cd2991929919epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646630770;
        bh=9tjq2zNlTSzLqr3qckKG9tmOLZlxb8W7Esn7UKQRyV0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lWlax/Hau5sbfWnYBPT1sgA9Hu/pcFW47J5vmrN7hoJPuGR4Phwk2GYNGztu5E2zB
         TGGj9ShVnOD6kXdWuA9jkibZwuSBCDM+B0YuH9yJbl1ndCb7eznb3INl5Ku499Gjv0
         c9BpuldZY+lZdQakrso7a7/58x31ThpcFINfAYxk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220307052609epcas2p25bc106c55f44992c76ba6489993e4e2e~aAfXiihYj1775517755epcas2p2R;
        Mon,  7 Mar 2022 05:26:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KBn4H2vwrz4x9QP; Mon,  7 Mar
        2022 05:26:07 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.4C.51767.D6795226; Mon,  7 Mar 2022 14:26:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220307052605epcas2p2b84f6db2642863ed61373070f508e200~aAfTw8EZd2036320363epcas2p2K;
        Mon,  7 Mar 2022 05:26:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220307052605epsmtrp175691b06cd1275ed69afb439f3a7f8c2~aAfTwJ1Ui1024710247epsmtrp1d;
        Mon,  7 Mar 2022 05:26:05 +0000 (GMT)
X-AuditID: b6c32a45-447ff7000000ca37-d5-6225976d1f84
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.5C.29871.D6795226; Mon,  7 Mar 2022 14:26:05 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220307052605epsmtip11291b6c3684732bf2275c54f6d7f48e0~aAfTlCOcX0030500305epsmtip1_;
        Mon,  7 Mar 2022 05:26:05 +0000 (GMT)
From:   JaeHun Jung <jh0801.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Date:   Mon,  7 Mar 2022 14:24:39 +0900
Message-Id: <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7bCmuW7udNUkg5m3dCyOtT1ht7izYBqT
        RfPi9WwWdx/+YLG4vGsOm8WiZa3MFl13bzA6sHtsWtXJ5rF/7hp2j74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsfXF
        W7aC78IV+7dPYG1gvCLQxcjBISFgIvH7LGsXIxeHkMAORom+r4/ZIZxPjBKrtt5hgXC+MUrc
        vNzM3MXICdbRvHYzE0RiL6PEw8WroKp+MEpsWHWPCaSKTUBbYt+cRewgtohAmMTEZfvAipgF
        bjNKrJh3gREkISzgKbG2YSoriM0ioCrx9tkksGZeAQ+JXwteskCsk5O4ea4TavUqdom3V5Ig
        bBeJV9/vsELYwhKvjm9hh7ClJF72t0HZxRKdmw4xgiyWEGhglPh2oIMJImEsMetZOyMoBJgF
        NCXW79KHBIayxJFbYGuZBfgkOg7/ZYcI80p0tAlBNKpKHGy8CXWZtMS33neMECUeEtuOcYOE
        hQRiJW5tbmOewCg7C2H8AkbGVYxiqQXFuempxUYFhvA4Ss7P3cQITlNarjsYJ7/9oHeIkYmD
        8RCjBAezkgjv/fMqSUK8KYmVValF+fFFpTmpxYcYTYGhNZFZSjQ5H5go80riDU0sDUzMzAzN
        jUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB9DFxcEo1MB23tRXefbSoQlol3H6qeAuTlHnJYst4
        RtXJi2sLlnh7ZpV5Bfz7JqpYP6X6hlDDEabWg1K86llCb+8fj7l3bpre88Mz5YRk5yq/ufBC
        W2dV0BufHw7P+Op1LpkKqWvvD5OYbVL30+DmdcudL3xnntHxWrwzc5XJWla3hTtid0i/VH+9
        yZMzZrt2eWL6vqCPTNnKIf8sQlU+ato0nvResVj0u+vPd+LmypssNprn6S492dJ++tna47ef
        69jMX72Gsaskz4D7ZmcMr9Dcpfu2+80M/tR1/fSxzPWPSjvfB/js823+LXA36+GquzMmr8zg
        jP//7MNSY3Fbqc6LYs+8Hb4Grf8h/LprzSJ+L8UTj5RYijMSDbWYi4oTAdTDuQbcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSnG7udNUkg9O/uCyOtT1ht7izYBqT
        RfPi9WwWdx/+YLG4vGsOm8WiZa3MFl13bzA6sHtsWtXJ5rF/7hp2j74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4MrY+uItW8F34Yr92yewNjBeEehi5OSQEDCRaF67mamLkYtDSGA3o8SKvlnM
        EAlpiZ2dU5kgbGGJ+y1HWCGKvjFK3H85nR0kwSagLbFvziIwW0QgTOLfo4ssIEXMAncZJZpO
        TGQDSQgLeEqsbZjKCmKzCKhKvH02CWwqr4CHxK8FL1kgNshJ3DzXyTyBkWcBI8MqRsnUguLc
        9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg8NHS3MG4fdUHvUOMTByMhxglOJiVRHjvn1dJEuJN
        SaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoEpVHNV1YZqX7bz
        Lk7Lru3Sd8us2Dil4Pk+rYmpzqIrD2Z4Ns3hO7howYTnlRNOOiRYKP4W13zFJ6JcKrQ2MUU9
        osHkfMz8Wws6r26QYn8j2Npy11+oVrlm3WWf3WVp6W7bDUyM9TZLNixfFLkiaNHa06o+B1Ry
        zvQJ1t17snXPu7m5qWEV99X1ZfNu2sv9PPIg65tBehiDJsOmiruXl2VnLTNa/Dw8eUG3wr3N
        t456zVHw3n9G931t8tFD+jGmBnfkOJSv1D/pSDjXFWV5hWPN9ZeN117NSFK5c3ySQrsFS9yp
        5L4zu9fypElkpn9RemEnIfTUVdBsrUnprs+GxdIX5e7Jziq99e7oUV6tbaVKLMUZiYZazEXF
        iQDjvkCnjgIAAA==
X-CMS-MailID: 20220307052605epcas2p2b84f6db2642863ed61373070f508e200
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307052605epcas2p2b84f6db2642863ed61373070f508e200
References: <CGME20220307052605epcas2p2b84f6db2642863ed61373070f508e200@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt Storming occurred with a very low probability of occurrence.
The occurrence of the problem is estimated to be caused by a race condition
between the top half and bottom half of the interrupt service routine.
It was confirmed that variables have values that cannot be held
when ISR occurs through normal H / W irq.
=====================================================================
(struct dwc3_event_buffer *) ev_buf = 0xFFFFFF88DE6A0380 (
	(void *) buf = 0xFFFFFFC01594E000,
	(void *) cache = 0xFFFFFF88DDC14080,
	(unsigned int) length = 4096,
	(unsigned int) lpos = 0,
	(unsigned int) count = 0, <<
	(unsigned int) flags = 1, <<
=====================================================================
"evt->count=0" and "evt->flags=DWC3_EVENT_PENDING" cannot be set
at the same time.

We estimate that a race condition occurred
between dwc3_interrupt() and dwc3_process_event_buf()
called by dwc3_gadget_process_pending_events().
So I try to block the race condition through spin_lock.

Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a0c883f19a41..88f9ecf8cbfe 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4172,6 +4172,7 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
 	struct dwc3 *dwc = evt->dwc;
+	unsigned long flags;
 	u32 amount;
 	u32 count;
 
@@ -4188,13 +4189,18 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	 * irq event handler completes before caching new event to prevent
 	 * losing events.
 	 */
-	if (evt->flags & DWC3_EVENT_PENDING)
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (evt->flags & DWC3_EVENT_PENDING) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
 		return IRQ_HANDLED;
+	}
 
 	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
-	if (!count)
+	if (!count) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
 		return IRQ_NONE;
+	}
 
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
@@ -4210,6 +4216,7 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 		memcpy(evt->cache, evt->buf, count - amount);
 
 	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return IRQ_WAKE_THREAD;
 }
-- 
2.31.1

