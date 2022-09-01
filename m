Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D95A96BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiIAM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiIAM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA481299D9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662035215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+R3oRbS1dr4Hw0Byg+WK1FYsd3bdoErBD0TzikrgHgY=;
        b=LpRiXdaVChkAtxT4midhEuq4IqotecQwKjkz2nr0yfuyTvXFTZEhjzx0OCAaVxH8nOJgFL
        kXp7iT5SxQK4n1eBxWcn+1ctpsEtjFW/BtqNnAAHuZpv9ePH952fVK+/e4zx03zW57BRFd
        PZa3q+X6cgjdIdh0UzJA6TTGBYWDnt4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-b6rC4-MjNEySXfcZzQbYOw-1; Thu, 01 Sep 2022 08:26:53 -0400
X-MC-Unique: b6rC4-MjNEySXfcZzQbYOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 714A31C0896E;
        Thu,  1 Sep 2022 12:26:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5E7D18ECC;
        Thu,  1 Sep 2022 12:26:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net v3 4/6] rxrpc: Fix calc of resend age
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Sep 2022 13:26:52 +0100
Message-ID: <166203521230.271364.2759659441831825820.stgit@warthog.procyon.org.uk>
In-Reply-To: <166203518656.271364.567426359603115318.stgit@warthog.procyon.org.uk>
References: <166203518656.271364.567426359603115318.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the calculation of the resend age to add a microsecond value as
microseconds, not nanoseconds.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/call_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index f8ecad2b730e..2a93e7b5fbd0 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -166,7 +166,7 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 	_enter("{%d,%d}", call->tx_hard_ack, call->tx_top);
 
 	now = ktime_get_real();
-	max_age = ktime_sub(now, jiffies_to_usecs(call->peer->rto_j));
+	max_age = ktime_sub_us(now, jiffies_to_usecs(call->peer->rto_j));
 
 	spin_lock_bh(&call->lock);
 


