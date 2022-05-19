Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2608B52D103
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiESLAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiESLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61C33AFADA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652958012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsLby3WBRV2ksXngXcgjE65ylKzw8ZXqHaZSmqZRUG0=;
        b=FV/+8d1ox/wiORc3DRH0qiXMSivcqWpB609/56PeilMGLXc2bApN/CWW2sJn0IMWPmX+Ay
        X+WzKJfELHl6JlLizRqDJdvfSNCPdTwsxPJ9L4LOMWyUQcBh/2MKSKFIbpNfQ0jYIfiLZy
        ocoXKD1+gGje812cfpo1DOBevFUWmVc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-7lGJGNUFMJCvNsPkUvNNmA-1; Thu, 19 May 2022 07:00:08 -0400
X-MC-Unique: 7lGJGNUFMJCvNsPkUvNNmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A40AB185A794;
        Thu, 19 May 2022 11:00:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1373840CF8F5;
        Thu, 19 May 2022 11:00:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/7] rxrpc: Don't let ack.previousPacket regress
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 12:00:06 +0100
Message-ID: <165295800634.3423686.6147984492300725678.stgit@warthog.procyon.org.uk>
In-Reply-To: <165295798034.3423686.10148594094912570224.stgit@warthog.procyon.org.uk>
References: <165295798034.3423686.10148594094912570224.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previousPacket field in the rx ACK packet should never go backwards -
it's now the highest DATA sequence number received, not the last on
received (it used to be used for out of sequence detection).

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/ar-internal.h |    4 ++--
 net/rxrpc/input.c       |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9a9688c41d4d..8465985a4cb6 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -679,7 +679,7 @@ struct rxrpc_call {
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
 	rxrpc_serial_t		ackr_serial;	/* serial of packet being ACK'd */
-	rxrpc_seq_t		ackr_prev_seq;	/* previous sequence number received */
+	rxrpc_seq_t		ackr_highest_seq; /* Higest sequence number received */
 	rxrpc_seq_t		ackr_consumed;	/* Highest packet shown consumed */
 	rxrpc_seq_t		ackr_seen;	/* Highest packet shown seen */
 
@@ -694,7 +694,7 @@ struct rxrpc_call {
 	/* Transmission-phase ACK management (ACKs we've received). */
 	ktime_t			acks_latest_ts;	/* Timestamp of latest ACK received */
 	rxrpc_seq_t		acks_first_seq;	/* first sequence number received */
-	rxrpc_seq_t		acks_prev_seq;	/* previous sequence number received */
+	rxrpc_seq_t		acks_prev_seq;	/* Highest previousPacket received */
 	rxrpc_seq_t		acks_lowest_nak; /* Lowest NACK in the buffer (or ==tx_hard_ack) */
 	rxrpc_seq_t		acks_lost_top;	/* tx_top at the time lost-ack ping sent */
 	rxrpc_serial_t		acks_lost_ping;	/* Serial number of probe ACK */
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index f11673cda217..2e61545ad8ca 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -453,7 +453,6 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb)
 	    !rxrpc_receiving_reply(call))
 		goto unlock;
 
-	call->ackr_prev_seq = seq0;
 	hard_ack = READ_ONCE(call->rx_hard_ack);
 
 	nr_subpackets = sp->nr_subpackets;
@@ -534,6 +533,9 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb)
 			ack_serial = serial;
 		}
 
+		if (after(seq0, call->ackr_highest_seq))
+			call->ackr_highest_seq = seq0;
+
 		/* Queue the packet.  We use a couple of memory barriers here as need
 		 * to make sure that rx_top is perceived to be set after the buffer
 		 * pointer and that the buffer pointer is set after the annotation and


