Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39F4E4CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiCWGdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiCWGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:33:40 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C9F716ED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:32:10 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id WuXPnSkMs9VRxWuXPnBGAk; Wed, 23 Mar 2022 07:32:08 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 23 Mar 2022 07:32:08 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-cifs@vger.kernel.org
Subject: [PATCH v2] ksmbd: Remove a redundant zeroing of memory
Date:   Wed, 23 Mar 2022 07:32:05 +0100
Message-Id: <577b4601aa5d62d222fa9387c5036f2504f40318.1648017112.git.christophe.jaillet@wanadoo.fr>
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

fill_transform_hdr() has only one caller that already clears tr_buf (it is
kzalloc'ed).

So there is no need to clear it another time here.

Remove the superfluous memset() and add a comment to remind that the caller
must clear the buffer.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: keep kzalloc in the caller and remove the memset here
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bcb98109bac9..bcd1bb7e2856 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8410,7 +8410,7 @@ static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
-	memset(tr_buf, 0, sizeof(struct smb2_transform_hdr) + 4);
+	/* tr_buf must be cleared by the caller */
 	tr_hdr->ProtocolId = SMB2_TRANSFORM_PROTO_NUM;
 	tr_hdr->OriginalMessageSize = cpu_to_le32(orig_len);
 	tr_hdr->Flags = cpu_to_le16(TRANSFORM_FLAG_ENCRYPTED);
-- 
2.32.0

