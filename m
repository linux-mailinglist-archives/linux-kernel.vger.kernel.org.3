Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56D52D109
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiESLBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiESLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59423AFB18
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652958024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZAE0tHWnpJkr45vCJeJX11jwL2RN6kA2lgbolTk1SI=;
        b=L/0fFHV9eA8tAb5ShdLmDU2R2niqgPSIKZEyZY6aRhpSo/6H6jmYaxZXQcDcKkWxyRLFLM
        nh/O0STYzGOMsWQ+RGJtqI8VeCakJW4JOX+fEnuLjiJBuzNJVbKXWb964CBo2XAo8Zdiue
        6lQSzLUqNtLhV21GePbN/wjp2iz1wFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-wpw-UkB_Pv6qx6RJV7O1Tg-1; Thu, 19 May 2022 07:00:21 -0400
X-MC-Unique: wpw-UkB_Pv6qx6RJV7O1Tg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDA6B101A52C;
        Thu, 19 May 2022 11:00:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20F26492C3B;
        Thu, 19 May 2022 11:00:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/7] rxrpc: Limit retransmission by acked serial
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 12:00:19 +0100
Message-ID: <165295801939.3423686.15170060927390373804.stgit@warthog.procyon.org.uk>
In-Reply-To: <165295798034.3423686.10148594094912570224.stgit@warthog.procyon.org.uk>
References: <165295798034.3423686.10148594094912570224.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rx protocol marks each packet on a connection with a monotonically
increasing serial number.  This serial number is referenced in ACK packets
to indicate the packet that caused it for the purpose of RTT determination.

When a DATA packet is lost, we get an out-of-sequence ACK in response to
the next ACK received and we can use this to determine what packets we need
to retransmit.  However, the OOS ACK might not mention DATA packets later
than the triggering DATA packet because at the time it generated the ACK,
it hadn't received them yet.

This causes a problem in the retransmission algorithm as it has to try and
determine which packets to retransmit.  It sees a bunch of un-ACK'd
packets, both the explicitly NACK'd ones and the ones that the OOS ACK
didn't mention - and, currently, it will try to retransmit all of them.

A further problem can also be seen in which a stream of OOS ACKs (because
several DATA packets arrive after the missing one) causes a bunch of
retransmissions of the same DATA packet.

Fix this by tracking the highest serial number referenced in an ACK packet
on each call, and don't retransmit any DATA packet whose last transmission
serial number exceeded that.  A retransmitted packet will have its
REQUEST_ACK flag set and this will elicit another ACK that should advance
the serial number when we receive it, allowing further retransmission.

There are two gotchas with this, though: PING ACKs don't have the serial
number set, and DELAY ACKs may not have it set (it'll be 0 in both cases).

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/call_event.c  |    5 +++++
 net/rxrpc/input.c       |    4 ++++
 3 files changed, 10 insertions(+)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index dce056adb78c..3b08075c71fd 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -698,6 +698,7 @@ struct rxrpc_call {
 	rxrpc_seq_t		acks_lowest_nak; /* Lowest NACK in the buffer (or ==tx_hard_ack) */
 	rxrpc_seq_t		acks_lost_top;	/* tx_top at the time lost-ack ping sent */
 	rxrpc_serial_t		acks_lost_ping;	/* Serial number of probe ACK */
+	rxrpc_serial_t		acks_highest_serial; /* Highest serial number ACK'd */
 };
 
 /*
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 31761084a76f..4a381de0b4dd 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -156,6 +156,7 @@ static void rxrpc_congestion_timeout(struct rxrpc_call *call)
  */
 static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 {
+	struct rxrpc_skb_priv *sp;
 	struct sk_buff *skb;
 	unsigned long resend_at;
 	rxrpc_seq_t cursor, seq, top;
@@ -191,6 +192,10 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 			continue;
 
 		skb = call->rxtx_buffer[ix];
+		sp = rxrpc_skb(skb);
+
+		if (after(sp->hdr.serial, call->acks_highest_serial))
+			continue;
 		rxrpc_see_skb(skb, rxrpc_skb_seen);
 
 		if (anno_type == RXRPC_TX_ANNO_UNACK) {
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 1145cb14d86f..6c2db1d58aa8 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -940,6 +940,10 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	call->acks_first_seq = first_soft_ack;
 	call->acks_prev_seq = prev_pkt;
 
+	if (buf.ack.reason != RXRPC_ACK_PING &&
+	    after(acked_serial, call->acks_highest_serial))
+		call->acks_highest_serial = acked_serial;
+
 	/* Parse rwind and mtu sizes if provided. */
 	if (buf.info.rxMTU)
 		rxrpc_input_ackinfo(call, skb, &buf.info);


