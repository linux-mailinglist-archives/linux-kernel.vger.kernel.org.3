Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE10547976
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiFLJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiFLJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:00:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A50149F3E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z17so1482730wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ea5VDYyACTdLFfDR1OzYQ+USVPk0XrM3SL5Uf8rgmF0=;
        b=KR0M7uzWU0BPwWn1Brdk2z+8Fi7ZcEFz/0BqFDgszVZgE8lwHoAW6oSObc3l1b6vr4
         BoC6dWRtE6EBumonrLPkkC91REo5S9yRXWhNwSvD4HcKvP5LKq/IS1A2cXQD+219YWhl
         ZvQrPdoNkDwgS4izTjiqJ0S57mfhBZYKU3hDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ea5VDYyACTdLFfDR1OzYQ+USVPk0XrM3SL5Uf8rgmF0=;
        b=CJKgXrYYQr6dv1Cq8WdnH7JPtdTQGRDgb/Yi4kus/KBoXDV3Sj/dslOYZoUomImbdL
         yLKqwh8gb001mMay0kaupKuF0IHhOOnkoQ7XyXXdvlK0l5CSwSHIj4DC4RQK1MZ+9kBf
         mJJs2LyszgzBESIe+ttckeh6gBLR9Zf+YTDdX2WQ37IR+rNhIgd6bAUtKt9jpX/rOfhB
         T/erDs8QbJhXmwvtTUl5SUur0LLtUoCFYXZmoLJIpjBi4JFus71bKnrces6YpbYd1GGW
         lEYlHYYsA62OUl7d/5pd4sp8YY6JSXfOlkLFtW8t1H+oEh9ormpBKalGfzhQMVIFb72k
         XaOQ==
X-Gm-Message-State: AOAM532qaJ39R5R6+82VHeibxXzv1ut40kTw2r6zXV7jpeg5iTVSBAw/
        tXtU7wDtLe1LJS6umT1weM25Cg==
X-Google-Smtp-Source: ABdhPJyNlQK22KcaUyTUuErIsRmeLRfYWG48oRcA2vWnHqeaWVoWe/3tpFsgtVdSSbyWZCmkaqjVDg==
X-Received: by 2002:a7b:c346:0:b0:397:626d:d2c4 with SMTP id l6-20020a7bc346000000b00397626dd2c4mr8629025wmj.172.1655024444792;
        Sun, 12 Jun 2022 02:00:44 -0700 (PDT)
Received: from localhost.localdomain ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id d34-20020a05600c4c2200b0039c5b4ab1b0sm4798603wmp.48.2022.06.12.02.00.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 02:00:43 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,net-next v2 5/8] net: unix: Support MSG_NTCOPY
Date:   Sun, 12 Jun 2022 01:57:54 -0700
Message-Id: <1655024280-23827-6-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MSG_NTCOPY to unix sockets. The helper function
msg_set_iter_copy_type is used to set the copy flag on the iovec iterator
correctly.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/unix/af_unix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3453e00..b8f522d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1905,6 +1905,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	skb_put(skb, len - data_len);
 	skb->data_len = data_len;
 	skb->len = len;
+
+	msg_set_iter_copy_type(msg);
 	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, len);
 	if (err)
 		goto out_free;
@@ -2165,6 +2167,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		skb_put(skb, size - data_len);
 		skb->data_len = data_len;
 		skb->len = size;
+
+		msg_set_iter_copy_type(msg);
 		err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
 		if (err) {
 			kfree_skb(skb);
-- 
2.7.4

