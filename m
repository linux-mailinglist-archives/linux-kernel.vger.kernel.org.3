Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6602052D106
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiESLA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiESLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45CCAFB05
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652958005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mrr7J61xbEAJ+CxIh1AQCZK8gXG+6GrJt8OUNarfLlA=;
        b=Xr1ROzzD4W7+JeGwBhxMttXS07jI/mrhyMoJVkQNXXa3+iNyr0LMo0IlePNyZQih2yeutm
        QP4KQrqNArWnNLfALog6pzSfy/lL9BJ//YlbVQs0KIIMu2pVo1Q490FyylfRyyI0Z+znRn
        dxGBFQa0/TUuzkg2NhzcNhgR5sptQgs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-Ugc9FXFLN5SOQTeENS5yhQ-1; Thu, 19 May 2022 07:00:01 -0400
X-MC-Unique: Ugc9FXFLN5SOQTeENS5yhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C94F294EDDC;
        Thu, 19 May 2022 11:00:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7387E7B64;
        Thu, 19 May 2022 11:00:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/7] rxrpc: Fix overlapping ACK accounting
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 11:59:59 +0100
Message-ID: <165295799975.3423686.4097692238126197685.stgit@warthog.procyon.org.uk>
In-Reply-To: <165295798034.3423686.10148594094912570224.stgit@warthog.procyon.org.uk>
References: <165295798034.3423686.10148594094912570224.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix accidental overlapping of Rx-phase ACK accounting with Tx-phase ACK
accounting through variables shared between the two.  call->acks_* members
refer to ACKs received in the Tx phase and call->ackr_* members to ACKs
sent/to be sent during the Rx phase.

Fixes: 1a2391c30c0b ("rxrpc: Fix detection of out of order acks")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/ar-internal.h |    7 ++++---
 net/rxrpc/input.c       |   16 ++++++++--------
 net/rxrpc/output.c      |    2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 969e532f77a9..9a9688c41d4d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -676,10 +676,9 @@ struct rxrpc_call {
 
 	spinlock_t		input_lock;	/* Lock for packet input to this call */
 
-	/* receive-phase ACK management */
+	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
 	rxrpc_serial_t		ackr_serial;	/* serial of packet being ACK'd */
-	rxrpc_serial_t		ackr_first_seq;	/* first sequence number received */
 	rxrpc_seq_t		ackr_prev_seq;	/* previous sequence number received */
 	rxrpc_seq_t		ackr_consumed;	/* Highest packet shown consumed */
 	rxrpc_seq_t		ackr_seen;	/* Highest packet shown seen */
@@ -692,8 +691,10 @@ struct rxrpc_call {
 #define RXRPC_CALL_RTT_AVAIL_MASK	0xf
 #define RXRPC_CALL_RTT_PEND_SHIFT	8
 
-	/* transmission-phase ACK management */
+	/* Transmission-phase ACK management (ACKs we've received). */
 	ktime_t			acks_latest_ts;	/* Timestamp of latest ACK received */
+	rxrpc_seq_t		acks_first_seq;	/* first sequence number received */
+	rxrpc_seq_t		acks_prev_seq;	/* previous sequence number received */
 	rxrpc_seq_t		acks_lowest_nak; /* Lowest NACK in the buffer (or ==tx_hard_ack) */
 	rxrpc_seq_t		acks_lost_top;	/* tx_top at the time lost-ack ping sent */
 	rxrpc_serial_t		acks_lost_ping;	/* Serial number of probe ACK */
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index dc201363f2c4..f11673cda217 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -812,7 +812,7 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call, u8 *acks,
 static bool rxrpc_is_ack_valid(struct rxrpc_call *call,
 			       rxrpc_seq_t first_pkt, rxrpc_seq_t prev_pkt)
 {
-	rxrpc_seq_t base = READ_ONCE(call->ackr_first_seq);
+	rxrpc_seq_t base = READ_ONCE(call->acks_first_seq);
 
 	if (after(first_pkt, base))
 		return true; /* The window advanced */
@@ -820,7 +820,7 @@ static bool rxrpc_is_ack_valid(struct rxrpc_call *call,
 	if (before(first_pkt, base))
 		return false; /* firstPacket regressed */
 
-	if (after_eq(prev_pkt, call->ackr_prev_seq))
+	if (after_eq(prev_pkt, call->acks_prev_seq))
 		return true; /* previousPacket hasn't regressed. */
 
 	/* Some rx implementations put a serial number in previousPacket. */
@@ -906,8 +906,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
 	if (!rxrpc_is_ack_valid(call, first_soft_ack, prev_pkt)) {
 		trace_rxrpc_rx_discard_ack(call->debug_id, ack_serial,
-					   first_soft_ack, call->ackr_first_seq,
-					   prev_pkt, call->ackr_prev_seq);
+					   first_soft_ack, call->acks_first_seq,
+					   prev_pkt, call->acks_prev_seq);
 		return;
 	}
 
@@ -922,14 +922,14 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	/* Discard any out-of-order or duplicate ACKs (inside lock). */
 	if (!rxrpc_is_ack_valid(call, first_soft_ack, prev_pkt)) {
 		trace_rxrpc_rx_discard_ack(call->debug_id, ack_serial,
-					   first_soft_ack, call->ackr_first_seq,
-					   prev_pkt, call->ackr_prev_seq);
+					   first_soft_ack, call->acks_first_seq,
+					   prev_pkt, call->acks_prev_seq);
 		goto out;
 	}
 	call->acks_latest_ts = skb->tstamp;
 
-	call->ackr_first_seq = first_soft_ack;
-	call->ackr_prev_seq = prev_pkt;
+	call->acks_first_seq = first_soft_ack;
+	call->acks_prev_seq = prev_pkt;
 
 	/* Parse rwind and mtu sizes if provided. */
 	if (buf.info.rxMTU)
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index a45c83f22236..46aae9b7006f 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -89,7 +89,7 @@ static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 	pkt->ack.bufferSpace	= htons(8);
 	pkt->ack.maxSkew	= htons(0);
 	pkt->ack.firstPacket	= htonl(hard_ack + 1);
-	pkt->ack.previousPacket	= htonl(call->ackr_prev_seq);
+	pkt->ack.previousPacket	= htonl(call->ackr_highest_seq);
 	pkt->ack.serial		= htonl(serial);
 	pkt->ack.reason		= reason;
 	pkt->ack.nAcks		= top - hard_ack;


