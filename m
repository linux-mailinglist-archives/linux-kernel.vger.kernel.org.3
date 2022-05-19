Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0652D104
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiESK75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiESK7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AE9FAFADF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652957983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xh8dSPuYVd16pGU1eOSrw4RK/14MRTLIpBGTzg2s4yA=;
        b=gbvyYHREC2sH35zLHDZ6W6oOFFVtEIIfrVtiT2JwXocs1iQl1p4NLM0nvbY1oO1AcDf7ps
        D7a9dPAW47dheth9tTwU1iYSZQZV3mL+WUu1ki3lhAnUYkjWmgyIB/GIo4ep6hs4g8J+D/
        p3b4N0XJ8Xxu9r3tw+tJboIuXzq58q8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-RBFi4NKJO_i_znEMxsae0w-1; Thu, 19 May 2022 06:59:42 -0400
X-MC-Unique: RBFi4NKJO_i_znEMxsae0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB8881C05AEC;
        Thu, 19 May 2022 10:59:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B052492C14;
        Thu, 19 May 2022 10:59:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/7] rxrpc: Enable IPv6 checksums on transport socket
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 11:59:40 +0100
Message-ID: <165295798034.3423686.10148594094912570224.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AF_RXRPC doesn't currently enable IPv6 UDP Tx checksums on the transport
socket it opens and the checksums in the packets it generates end up 0.

It probably should also enable IPv6 UDP Rx checksums and IPv4 UDP
checksums.  The latter only seem to be applied if the socket family is
AF_INET and don't seem to apply if it's AF_INET6.  IPv4 packets from an
IPv6 socket seem to have checksums anyway.

What seems to have happened is that the inet_inv_convert_csum() call didn't
get converted to the appropriate udp_port_cfg parameters - and
udp_sock_create() disables checksums unless explicitly told not too.

Fix this by enabling the three udp_port_cfg checksum options.

Fixes: 1a9b86c9fd95 ("rxrpc: use udp tunnel APIs instead of open code in rxrpc_open_socket")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: Vadim Fedorenko <vfedorenko@novek.ru>
cc: David S. Miller <davem@davemloft.net>
cc: linux-afs@lists.infradead.org
---

 net/rxrpc/local_object.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index a4111408ffd0..6a1611b0e303 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -117,6 +117,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	       local, srx->transport_type, srx->transport.family);
 
 	udp_conf.family = srx->transport.family;
+	udp_conf.use_udp_checksums = true;
 	if (udp_conf.family == AF_INET) {
 		udp_conf.local_ip = srx->transport.sin.sin_addr;
 		udp_conf.local_udp_port = srx->transport.sin.sin_port;
@@ -124,6 +125,8 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	} else {
 		udp_conf.local_ip6 = srx->transport.sin6.sin6_addr;
 		udp_conf.local_udp_port = srx->transport.sin6.sin6_port;
+		udp_conf.use_udp6_tx_checksums = true;
+		udp_conf.use_udp6_rx_checksums = true;
 #endif
 	}
 	ret = udp_sock_create(net, &udp_conf, &local->socket);


