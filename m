Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33F52AFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiERBSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiERBSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:18:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796FB443EC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:18:08 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m1so467221qkn.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXB3stC8a3X2zk+f7WkrlT4Wp9/qyMy9VfllxGNmaGo=;
        b=nKKrO3FFEhdIwa4SqWQwSokkUlU4h2iIH+Vn0LAiheZdjIEh3ZEoi2aSgnxFsyQqd8
         opjb5W3cbSQIPijzdJ8IwgAvBpnFrxyYKWYTlBLmox7fAL/qnSTv8wKIIdV4rw3NeFfQ
         IT1+i7DEaPZiZhp+zNiUn413+nWKu3oxIuGIlELhm4U7f9LjKbc31mSjDx0XDR0m1jFN
         xOpEBW0t/sqlIbKIeRGzMGRSokYDxVKhT0cUFcp8A2gq11cpjSqWISiQIAMEPyEYhNoJ
         Xaoupunz4nXE/6g1olTlKfyBNlHrvKLjcozO7JSeXpuSP2uXnjrPAqr9VD8DEu1wS07v
         8zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXB3stC8a3X2zk+f7WkrlT4Wp9/qyMy9VfllxGNmaGo=;
        b=4ub10ajBPxPtg/wCLUwQ71h2cXbn1ogl4XBcfF/Ng+5E8fD+vlAAR2ZVLx0ml07gS6
         HcjDaI5Cz1bO84fFC83MW2PyJO0prcoCjU5Ydy7jjGQgYClHKeONvAEMJcEp3zIvOQl/
         Dq/jKkrNl/MrQIdJSGpPLXZkiQKyiO/WSKe7MH35VSQ6UHiHAIAZP/NCbpoTMfsr3lii
         gJURt7nVwt2H84xLW9mjfX9wQGqbmghPiWQ6uXqvz6gv15I1sWPu7VfTiV4sKfpRfvGl
         K1h0RmHe8+xkDgew/l2ZJ3+46oRhzhaELseOFxHwC9/6xShxJR8On582l/9VRrjiN3gJ
         sFLg==
X-Gm-Message-State: AOAM533h2eS9UXDD4Vu+H3q7aeL3o9jTdcSVgPcc2DE9kbfeccdpYHTr
        woQ3m+zy16QcAv8wf9dyQ3Y=
X-Google-Smtp-Source: ABdhPJy8S1N3yTy7GgsNcharYnQM9ywR6OfvQVmmTEv8rVuRgiyFpCyOGF5+zKnqBfWOTBcveXIJqA==
X-Received: by 2002:a05:620a:440e:b0:6a0:6353:f440 with SMTP id v14-20020a05620a440e00b006a06353f440mr18232849qkp.79.1652836687594;
        Tue, 17 May 2022 18:18:07 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id j3-20020ac84c83000000b002f39b99f69dsm364267qtv.55.2022.05.17.18.18.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2022 18:18:07 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        hridya@google.com, surenb@google.com, cmllamas@google.com
Cc:     linux-kernel@vger.kernel.org, schspa@gmail.com,
        syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Subject: [PATCH v2] binder: fix atomic sleep when get extended error
Date:   Wed, 18 May 2022 09:17:54 +0800
Message-Id: <20220518011754.49348-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
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

binder_inner_proc_lock(thread->proc) is a spin lock, copy_to_user can't
be called with in this lock.

Copy it as a local variable to fix it.

Reported-by: syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Fixes: bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")
Signed-off-by: Schspa Shi <schspa@gmail.com>

---

Changelog:
v1 -> v2:
        - Remove the retry as Carlos Llamas adviced.
        - Use binder_set_extended_error to reset the error info.
---
 drivers/android/binder.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d9253b2a7bd9..1a6b7a8c8346 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5162,19 +5162,16 @@ static int binder_ioctl_get_freezer_info(
 static int binder_ioctl_get_extended_error(struct binder_thread *thread,
 					   void __user *ubuf)
 {
-	struct binder_extended_error *ee = &thread->ee;
+	struct binder_extended_error ee;
 
 	binder_inner_proc_lock(thread->proc);
-	if (copy_to_user(ubuf, ee, sizeof(*ee))) {
-		binder_inner_proc_unlock(thread->proc);
-		return -EFAULT;
-	}
-
-	ee->id = 0;
-	ee->command = BR_OK;
-	ee->param = 0;
+	ee = thread->ee;
+	binder_set_extended_error(&thread->ee, 0, BR_OK, 0);
 	binder_inner_proc_unlock(thread->proc);
 
+	if (copy_to_user(ubuf, &ee, sizeof(ee)))
+		return -EFAULT;
+
 	return 0;
 }
 
-- 
2.24.3 (Apple Git-128)

