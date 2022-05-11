Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F787522AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbiEKDz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbiEKDzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:55:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CD4CD55
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:55:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q4so653297plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Oj5fYgOyP9r6j4Oo2YFgfJ89J2j62xWeof0Jo9AY3w=;
        b=v9w+8OSo8NSVmDmBQbc8obXr4Wi1nhD7MIDl5mmowMNt72/kNMxqluqzW8jS3Kp7UB
         /7VISt6MIJKtVD9o0A7m6LzNO5Lqp9ow+x5B9kBGB7t7PtEZGsvXfcXksfmbNr4z51g2
         LTzKHBx8TvH8VwSw5qQxFSvqLW2aYGDGcyTCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Oj5fYgOyP9r6j4Oo2YFgfJ89J2j62xWeof0Jo9AY3w=;
        b=gKBNlz3W4ErVwNaV1LBEXKfjk7dCw+kncT24w8YgNAZMfksrnNqLEjZ6DORKeShwBx
         igHWdzB+GyTeyq3If4B9nthhjFGz8ia39GQvuynsCyFmOB9gp3L+uiMaSzYYUSlW8oNe
         H1Rqca0uRaQ2eWCKttcrrSujNy+gCXXgCUGHNDbTJLWfZAU5v82Y62LRfoDRJqhd4nFo
         3vDgYJDJzsdOpgMYNeYUIMsu0MHBFmFAFhZViA+r7rxNqjYZnIvVCg532GpOiVWa2DxX
         nU5IgyQI5uhCqMmqqLNTJ/BP2zVE4v1ft5xeW4ZFm4wyw5SiwP8MbrrJNbakXW81IorF
         1rSA==
X-Gm-Message-State: AOAM531dBxzYBmWuyzNcoVP/2nYXsVki2W4LEXf29DifWLr2XuKxWIpJ
        VCYA9InzH8te8LaODbwvlJAJLA==
X-Google-Smtp-Source: ABdhPJzDBQpUZk7W8Mq0NWHrteV9nx9UH/BVPj5fyK4gC7QCMNmi9ReuRK03KcV0ElJJJiZ8qW3FTA==
X-Received: by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id y4-20020a170902864400b001539f012090mr22917397plt.101.1652241338601;
        Tue, 10 May 2022 20:55:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0015e8d4eb1f7sm442789plh.65.2022.05.10.20.55.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 20:55:38 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,net-next 6/6] net: unix: Add MSG_NTCOPY
Date:   Tue, 10 May 2022 20:54:27 -0700
Message-Id: <1652241268-46732-7-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652241268-46732-1-git-send-email-jdamato@fastly.com>
References: <1652241268-46732-1-git-send-email-jdamato@fastly.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sendmsg flag, MSG_NTCOPY, which user programs can use to signal
to the kernel that data copied into the kernel during sendmsg should be
done so using nontemporal copies, if it is supported by the architecture.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/socket.h |  1 +
 net/unix/af_unix.c     | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 12085c9..c9b10aa 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -318,6 +318,7 @@ struct ucred {
 					  * plain text and require encryption
 					  */
 
+#define MSG_NTCOPY	0x2000000	/* Use a non-temporal copy */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e1dd9e9..ccbd643 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1907,7 +1907,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	skb_put(skb, len - data_len);
 	skb->data_len = data_len;
 	skb->len = len;
-	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, len);
+	if (msg->msg_flags & MSG_NTCOPY)
+		err = skb_copy_datagram_from_iter_nocache(skb, 0, &msg->msg_iter, len);
+	else
+		err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, len);
+
 	if (err)
 		goto out_free;
 
@@ -2167,7 +2171,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		skb_put(skb, size - data_len);
 		skb->data_len = data_len;
 		skb->len = size;
-		err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
+
+		if (msg->msg_flags & MSG_NTCOPY)
+			err = skb_copy_datagram_from_iter_nocache(skb, 0, &msg->msg_iter, size);
+		else
+			err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
+
 		if (err) {
 			kfree_skb(skb);
 			goto out_err;
-- 
2.7.4

