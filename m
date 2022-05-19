Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4652E095
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiESXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbiESXbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:31:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E481BC5C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:31:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c22so6344165pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDZJpQEck2IEnCwvWe0nT2u43d++wRfT3gBaO1c2DlI=;
        b=e/rCiNwyO+tDaNdaLHEHZ4+HbKYmU0DRLFcvh2OI8F0y49U9SXKLToWn4BllXgf5wS
         qPKqOHf5PUXNB5NVozFPy/LqFRJCGkhUHRosKk+LerGluLPqxTRxhkZ2DOUbSjs85e3j
         uIdyyN+3AiSKI/xjzAbn16IbVmqZe5ZDuynY3uyspICNXceH8xH5IdxaTc4RIoOzgUt9
         +gy+F2W+dT4nhjLbg9FBEe08aLRb5rgAP7dxfNm1cUWBysIHGbW1XlOv41M3QFd9GxD/
         JtcB8lzj3RxldCHXhXIKBtLxtilpKdbyvcX3rljFuMh7Ea4vth/wQ4L9U7tYkOzcYWq7
         ll7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDZJpQEck2IEnCwvWe0nT2u43d++wRfT3gBaO1c2DlI=;
        b=OerGltAaeNeEQ7W4BM0R8tE48ab5cs084zORYh6+ve8AnjD6nttcB1k5tX0FmdvHBC
         4EyFYOeuhRpOYsizNyHMYWq/WPCE0u10dzWuIHvnplsfpHh+LD9+t6EuywjufYyCTT32
         iqfTi8O+gVkomJq8C73eg1TQ5xlGm80Kj53zqKNeMH54PE8a3Qw12kfafUoFFgn9uKke
         ElVHemUZe0r+mb5YUjBZDooJztWg1n9Jq7A6sFiP4tEGLvfjDitMAEI3IRMdyWdLMKMh
         Kq71YWmIiE5jIINoIzX5b/OsJilspqd1l/n6o59Rtvzr9P8Tfa7uI+44sLvVxJOt58AP
         m2Iw==
X-Gm-Message-State: AOAM530pGF0O9YoT9qenhiBIaJ0jYfi6mfLBsBn+bBJm41bK0Iz8lxYj
        KCbIZsX1qCZz2ZwDfxh1dDIOGA==
X-Google-Smtp-Source: ABdhPJyfwFJjO+PKaBVKYIj6Mk7nJVzmva2Bi1w3gN26hsXBgXQSTe+RbM7aeW4f1dPobqHbuHzuLw==
X-Received: by 2002:a65:4d48:0:b0:3f3:936a:7c33 with SMTP id j8-20020a654d48000000b003f3936a7c33mr6025235pgt.217.1653003103377;
        Thu, 19 May 2022 16:31:43 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ab9000b0016191b843e2sm4331249plr.235.2022.05.19.16.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 16:31:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] random: wire up fops->splice_read_iter()
Date:   Thu, 19 May 2022 17:31:37 -0600
Message-Id: <20220519233137.20415-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220519233137.20415-1-axboe@kernel.dk>
References: <20220519233137.20415-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that random/urandom is using read_iter, we can wire it up to using
the generic splice read handler.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/char/random.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d000fe6fbb5a..41ca5966aa4f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1418,6 +1418,7 @@ const struct file_operations random_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
 };
 
 const struct file_operations urandom_fops = {
@@ -1427,6 +1428,7 @@ const struct file_operations urandom_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
 };
 
 
-- 
2.35.1

