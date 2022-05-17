Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC16D52A99B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351614AbiEQRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiEQRwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:52:38 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB253F88A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:52:37 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id eq14so14916948qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ye8rlTwVaBXLKIDRNeS/uc0ek5+GCSAg8ykTDxHypoU=;
        b=eARHZjkj5aIArTz7nwjRvYji169HwtXCybpLydSBxEFCQTzOMt/ALaL+u47k31acS/
         QRmkPo6TIIrFK0lM3G0tt0Yw+bxQckGpRyhhnFB94AgGQRvi1DkwXDowzYBPPnnLF9Kc
         j8LGMFJIYKWafTJClThq4Roqnptyq4fCeHxKUfHtwQTOT+kR1OocdByC8Hh5UUf276fx
         IE0zF86JtddpnHFExUGuY3ftsbfLja5hdgIQNMfkRNWGAD+OoZrew5M0kjV20xCzVANM
         WoXrwMVaPdjrSLPPqWjktXqa1oqKGLzPYXhZ4/+xK7VMIyTl5t1dgB2qZ9FNxGzuduaw
         SQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ye8rlTwVaBXLKIDRNeS/uc0ek5+GCSAg8ykTDxHypoU=;
        b=mze9KJ4tN9FnGbRLW18rpthhfkkJ6sQKjy0CsqEsaVyZXmBVDe+16QyYy0V4i0l0ge
         EFZLyU7jQ09zJlPlQ/nXSLt0e2FTG5/UbagCxgpmS00O+6fY9XAvc3p7arSQuSZ5eA+u
         HX4dCCzWmJi5B/MUs/yCncY9jm+NTOWC/RoM4Xg4wiat9ZdIrN/dkM0Q5Xth60KfTKFI
         ko+zdqSOf5r8yvNK3gze32e4Ou1gBvGADpvo2O0U/3yB2jVauRJOwq9wG+vrMJxe1hsK
         3xAD+kxEFyM0/Evyw+Vc/qei+fXdTQ5ObnJzGBtcXOK1AydDIHhgpRb7l3PBwO5VZQjT
         WAfQ==
X-Gm-Message-State: AOAM530fhOtYjqvT0dyibKtXedQ7bHDvkf1PN72FfRfWq9Q2WVLjWmC9
        TIni0/FNnmGDiJW5zwsggFI=
X-Google-Smtp-Source: ABdhPJyMC6yHJabmJdIJBSgOrn/2/mtdru85oCpv8UTTuT6CSstIdLEI5FwQ8NkrIJxEETGOv14ixQ==
X-Received: by 2002:a05:6214:c2e:b0:461:ce7d:6bcc with SMTP id a14-20020a0562140c2e00b00461ce7d6bccmr10092719qvd.32.1652809956856;
        Tue, 17 May 2022 10:52:36 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id h3-20020a375303000000b0069fc13ce1f9sm8236768qkb.42.2022.05.17.10.52.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2022 10:52:36 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        hridya@google.com, surenb@google.com, cmllamas@google.com
Cc:     linux-kernel@vger.kernel.org, schspa@gmail.com,
        syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Subject: [PATCH] binder: fix atomic sleep when get extended error
Date:   Wed, 18 May 2022 01:52:25 +0800
Message-Id: <20220517175225.65283-1-schspa@gmail.com>
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

Copy it as a local variable, and check the id to make sure the user space
gets the latest error message

Reported-by: syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Fixes: bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")
Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/android/binder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d9253b2a7bd9..5f2e1fa3da74 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5163,13 +5163,20 @@ static int binder_ioctl_get_extended_error(struct binder_thread *thread,
 					   void __user *ubuf)
 {
 	struct binder_extended_error *ee = &thread->ee;
+	struct binder_extended_error eeb;
 
 	binder_inner_proc_lock(thread->proc);
-	if (copy_to_user(ubuf, ee, sizeof(*ee))) {
-		binder_inner_proc_unlock(thread->proc);
+retry:
+	eeb = *ee;
+	binder_inner_proc_unlock(thread->proc);
+	if (copy_to_user(ubuf, &eeb, sizeof(eeb)))
 		return -EFAULT;
-	}
 
+	binder_inner_proc_lock(thread->proc);
+	if (eeb.id != ee->id) {
+		/* retry to get newest error info */
+		goto retry;
+	}
 	ee->id = 0;
 	ee->command = BR_OK;
 	ee->param = 0;
-- 
2.24.3 (Apple Git-128)

