Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C424E5F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbiCXHPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiCXHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:15:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4931646D;
        Thu, 24 Mar 2022 00:13:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r22so7243763ejs.11;
        Thu, 24 Mar 2022 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnICOnb+N94MLHVGeJL/0evUi/Ke2rE32iWEgW1NDL8=;
        b=HhzDNpJlYUaU1nPBhae6cs/YytVeWU2K/2buXFuv92vvielTDsPOH68ua+tLUNqsXo
         2UrTo/7MZ0e46JIZ130/2NPe82JPsiaKN3VKnXNHbQ9JfiZCKEtJxJrBtjFBai6I0S+Q
         e4jBoV+44Ta4axWSgegjQMAZBTFfjQ4q5yr0YUrlwwqc+NXb55SdDi+Kh3j8PuGiWD2W
         OanRASwzqr4LCYnULmkpk89MH5HQhOwmvgUJGoklYX69Fx16BvAg9tk74cOFalCV5jtN
         +0/YiL+Tr/hty3r+6yaH90D7H401N0vIo5f3nDlvkdSRvqFPvbKqzy7Tp+QeeHgAGGB1
         PnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnICOnb+N94MLHVGeJL/0evUi/Ke2rE32iWEgW1NDL8=;
        b=lY0SIUiUJeWOb1dwrWxQv4dajGM19E1qJbnSHQt6+UAhIy85HkgKFVTYN6EX7Xh7Ek
         vYVNsm6UUFXVbTa7Kyk2mXCGHa+rzCoRqpRv2uItLk3h7tKeNwolf6zT2IKvuHES+TOu
         Cx3RSuuHHZiI4gPBFY8ntVlFSL5stJQ2h1jHwxt+lsMpN2isrj91env9r6n64EEYv3NB
         OD51vHurZsvBEyc6yyxs0PnjQSxBL6KYaT/Q4AZNiDaoiYLDvufxdvTwEBob6o+5FP/v
         QErKSltPye6iUXNfNf9iiAO20UJKcc0p14j6nLkbb4lYeumbcd+co59bbTwRP3tdzRe2
         cPKg==
X-Gm-Message-State: AOAM532Dy1SJxaV2GKK9YqpGDinN1Hmb1CUX7aWUMzDe0u1OFr9jUord
        ESOwOC+CnN1mADq0+SOx4qI=
X-Google-Smtp-Source: ABdhPJwUzwCyipHVNtLt8vkkWb1HU8Sb1JipKhb9oCKWOvzU6+6OYbBGGU/WB+U+avthgw4gCCYPnw==
X-Received: by 2002:a17:906:f85:b0:6d6:e97b:d276 with SMTP id q5-20020a1709060f8500b006d6e97bd276mr4115107ejj.431.1648106011268;
        Thu, 24 Mar 2022 00:13:31 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id qk30-20020a1709077f9e00b006dfae33d969sm767826ejc.216.2022.03.24.00.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:13:30 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] ksmbd: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:13:01 +0100
Message-Id: <20220324071301.60228-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/ksmbd/smb2pdu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 67e8e28e3fc3..be9606b9a944 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6618,8 +6618,7 @@ int smb2_cancel(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
-	struct ksmbd_work *cancel_work = NULL;
-	int canceled = 0;
+	struct ksmbd_work *cancel_work = NULL, *iter;
 	struct list_head *command_list;
 
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
@@ -6629,11 +6628,11 @@ int smb2_cancel(struct ksmbd_work *work)
 		command_list = &conn->async_requests;
 
 		spin_lock(&conn->request_lock);
-		list_for_each_entry(cancel_work, command_list,
+		list_for_each_entry(iter, command_list,
 				    async_request_entry) {
-			chdr = smb2_get_msg(cancel_work->request_buf);
+			chdr = smb2_get_msg(iter->request_buf);
 
-			if (cancel_work->async_id !=
+			if (iter->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
 				continue;
 
@@ -6641,7 +6640,7 @@ int smb2_cancel(struct ksmbd_work *work)
 				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->Id.AsyncId),
 				    le16_to_cpu(chdr->Command));
-			canceled = 1;
+			cancel_work = iter;
 			break;
 		}
 		spin_unlock(&conn->request_lock);
@@ -6649,24 +6648,24 @@ int smb2_cancel(struct ksmbd_work *work)
 		command_list = &conn->requests;
 
 		spin_lock(&conn->request_lock);
-		list_for_each_entry(cancel_work, command_list, request_entry) {
-			chdr = smb2_get_msg(cancel_work->request_buf);
+		list_for_each_entry(iter, command_list, request_entry) {
+			chdr = smb2_get_msg(iter->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
-			    cancel_work == work)
+			    iter == work)
 				continue;
 
 			ksmbd_debug(SMB,
 				    "smb2 with mid %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->MessageId),
 				    le16_to_cpu(chdr->Command));
-			canceled = 1;
+			cancel_work = iter;
 			break;
 		}
 		spin_unlock(&conn->request_lock);
 	}
 
-	if (canceled) {
+	if (cancel_work) {
 		cancel_work->state = KSMBD_WORK_CANCELLED;
 		if (cancel_work->cancel_fn)
 			cancel_work->cancel_fn(cancel_work->cancel_argv);

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

