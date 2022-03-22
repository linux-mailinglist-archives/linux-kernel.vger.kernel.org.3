Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2084E4789
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCVUbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCVUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:31:23 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB3CC2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:29:55 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Wl8anBpiiIQAdWl8an8q7V; Tue, 22 Mar 2022 21:29:53 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 22 Mar 2022 21:29:53 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-cifs@vger.kernel.org
Subject: [PATCH] ksmbd: Remove a redundant zeroing of memory
Date:   Tue, 22 Mar 2022 21:29:51 +0100
Message-Id: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fill_transform_hdr() already call memset(0) on its 1st argument, so there
is no need to clear it explicitly before calling this function.

Use kmalloc() instead of kzalloc() to save a few cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Alternatively, fill_transform_hdr() has only one caller. So its memset()
could be removed instead and this kzalloc() left as is.
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bcb98109bac9..0e4f819e5859 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8434,7 +8434,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 	if (ARRAY_SIZE(iov) < rq_nvec)
 		return -ENOMEM;
 
-	work->tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
+	work->tr_buf = kmalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
 	if (!work->tr_buf)
 		return rc;
 
-- 
2.32.0

