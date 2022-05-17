Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9452AB57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352424AbiEQS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiEQS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:58:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5050053
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:58:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h10-20020a170902748a00b00161b9277a4aso481904pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yU9tmGFK0DAjJ+sFRZSLbkdZAIbxizXFIoBzmHvbAd8=;
        b=ro9kOBJBoB0wOHV7iVL+OeWwjl7dZn6RzjvKM/v3a4JL6QmD004h1XzuJR21n0BoTo
         jdGpzzY6i+xxNx6iVKUG6kHDLOgURgspNkZrsT1qHvYjPUyrhfaA4bIzhRkFPf3hKSwv
         By5EyXkLr+UZ6w6x0MbB6cD9nHdyJn5zhyqbVLMj6nFFNMqzxVefbTvoxGECgGeEp5X2
         EazjYSahFUnuPzHMi9Lp8VZzn2G3td6uuV+AQVCsJ5Cluj5Frxb+hmFB2c+LHFUENfiW
         e/qr5dBVY37IVxy7g4LKVdPJAUYfkv7kS0BQOuQC13xnN8++KZ/l+a3m78k4bN2iSyF2
         lBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yU9tmGFK0DAjJ+sFRZSLbkdZAIbxizXFIoBzmHvbAd8=;
        b=gqK4wRj/sa6Ia+DQusBPYa5HTiphVGXaeaBmnK7C3UmA/eULAmHHKwScGZmIDOV6bc
         /KcEyLI/vB/cMF0j7ZuFuR7tKoA1Y9z8KaOChzXY4XxOJYyz4yPFtx49Oz+trwvGZ8mC
         IcGYYgDnSkkzDKxCzqkju9+2xSME84J629aG6fLdfJEvK2amCzc9zPF48StFz+z12phI
         YwLlVwtxoRWKdfFQbWRJi+nXip3mv9o6BNsgQliHOR7ycaYzBBzcy+hFBl3xYorCqSv8
         mYte+yzpM4Yh2btj4aPihV76k54JWmbr0/sheTC/ht9Un33Jvr7VH9bIh32dm9MpVDpE
         6AMg==
X-Gm-Message-State: AOAM533340fbVnLXdS+h+HJkzYy8mSq2YW4hklmQ6IN7nLo8X/2ql+Gx
        xo6Su6A1zJ98Cv2LQmdqlnWLUIpBGrf40g==
X-Google-Smtp-Source: ABdhPJwVjldvpNzPt9HLGmwMb9OsWzFJWExSDo1NDV6t8UreN/x63xiKdGbjm+hTDHft4ac0gSQ4gEBBDSPYtA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:bd9:b0:50e:dad:b285 with SMTP id
 x25-20020a056a000bd900b0050e0dadb285mr23893799pfu.40.1652813903039; Tue, 17
 May 2022 11:58:23 -0700 (PDT)
Date:   Tue, 17 May 2022 18:58:17 +0000
Message-Id: <20220517185817.598872-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] binder: fix potential UAF of target_{proc,thread}
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9474be34a727 ("binder: add failed transaction logging info")
dereferences target_{proc,thread} after they have been potentially
freed by binder_proc_dec_tmpref() and binder_thread_dec_tmpref().

This patch delays the release of the two references after their last
usage. Fixes the following two errors reported by smatch:

  drivers/android/binder.c:3562 binder_transaction() error: dereferencing freed memory 'target_proc'
  drivers/android/binder.c:3563 binder_transaction() error: dereferencing freed memory 'target_thread'

Fixes: 9474be34a727 ("binder: add failed transaction logging info")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d9253b2a7bd9..83facfa1a5c3 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3546,10 +3546,6 @@ static void binder_transaction(struct binder_proc *proc,
 err_empty_call_stack:
 err_dead_binder:
 err_invalid_target_handle:
-	if (target_thread)
-		binder_thread_dec_tmpref(target_thread);
-	if (target_proc)
-		binder_proc_dec_tmpref(target_proc);
 	if (target_node) {
 		binder_dec_node(target_node, 1, 0);
 		binder_dec_node_tmpref(target_node);
@@ -3565,6 +3561,11 @@ static void binder_transaction(struct binder_proc *proc,
 		     (u64)tr->data_size, (u64)tr->offsets_size,
 		     return_error_line);
 
+	if (target_thread)
+		binder_thread_dec_tmpref(target_thread);
+	if (target_proc)
+		binder_proc_dec_tmpref(target_proc);
+
 	{
 		struct binder_transaction_log_entry *fe;
 
-- 
2.36.0.550.gb090851708-goog

