Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2825AC307
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 08:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIDGkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 02:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDGki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 02:40:38 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC221ADBD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 23:40:37 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 1CBCFC009; Sun,  4 Sep 2022 08:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1662273636; bh=XtdW/Qz1NptQheewRJMzIkzOqpOWHsLcyqkseqXpdnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Prt+eZFFrMsItLUhu/98SgpN+Lfs58DacEF3e2kf5w/0k26l71PVBDqNHn8chvraD
         sqpbncCpgkZGhvHU9aFHbVV26nNB/+3yc/zolVNiibdRuk28xUDQfblMhOv31NCt8l
         wAjV0irK5Q1pcefj2zXswlu6BkxWxdWIjeDXPU49lZMTCk8PWyQtGnAA+D89RevNEP
         HhWKsxo/7viUoDI4ajs7+CBv8qKc8qnvx0p/Evb6wSSeLtWlIxQVg3R58SZtXHGpMg
         fiYOv9pNSGIEUfm80cuoBHJGFl6O1DQrKg5sJhe9sO2k9plH1WuaVEY7N9tOIIr8RL
         C+v5uHgLVP8gA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 329A2C009;
        Sun,  4 Sep 2022 08:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1662273635; bh=XtdW/Qz1NptQheewRJMzIkzOqpOWHsLcyqkseqXpdnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4floERCrLWDbsWOLLfhtuztBVOTUYN+5eUeuQk/V2wpWbOyNIkvkDAYX/96ZtM4l
         sC+XEEhWolm7RqRDyf8KexFpBuWio23TgwBhscO6k9/zVlF2ulP8YiVH0pyVXaiiK9
         pJuuH2VRLTnLNDIwQCiHvL2OqByHoa4kVe7W6aeHgquAt5uobqBSiE4htvCg7RXR4E
         uYibFEHAgMM7ZEVnglR8XtkZqlKGMygE2mmsvXRWuher2+Y0ho3y1CAPm5gWxNFc6K
         jPj/ENHSjxnLRBmL45W36FAxwZATvbKQ700pDIrrBYQWmy/GGoBPKBTdVqWXNUXVYq
         iyWZCGObfe4vg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 23188c3b;
        Sun, 4 Sep 2022 06:40:31 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     syzkaller-bugs@googlegroups.com, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+50f7e8d06c3768dd97f3@syzkaller.appspotmail.com,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH 2/2] 9p: trans_fd/p9_conn_cancel: drop client lock earlier
Date:   Sun,  4 Sep 2022 15:40:28 +0900
Message-Id: <20220904064028.1305220-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <000000000000cad57405e5b5dbb7@google.com>
References: <000000000000cad57405e5b5dbb7@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a double-lock here and we no longer need this
lock after requests have been moved off to local list:
just drop the lock earlier.

Reported-by: syzbot+50f7e8d06c3768dd97f3@syzkaller.appspotmail.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Tested-by: Schspa Shi <schspa@gmail.com>
---
 net/9p/trans_fd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index e758978b44be..60fcc6b30b46 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -205,6 +205,8 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 		list_move(&req->req_list, &cancel_list);
 	}
 
+	spin_unlock(&m->client->lock);
+
 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
 		list_del(&req->req_list);
@@ -212,7 +214,6 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 			req->t_err = err;
 		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
 	}
-	spin_unlock(&m->client->lock);
 }
 
 static __poll_t
-- 
2.35.1

