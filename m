Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7482147B358
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhLTTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhLTTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:02:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01718C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:02:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso21185092yba.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Tap7nBAM0h0L8VrB9lLDO+R7RMvpcS4S2PLyP50CL8w=;
        b=UcUzIg+ZujUKm8Nx/UydFFi+uMvumbtNCxprjcJkB01d9AJrO6NJPDVVzuERlTxtoo
         O0qsQou5K98cO5aXEfF7StBWN2OD2N2Ruy5v+ZsYRMvEagNADmvgQdir0ZW1D13+mle1
         jrS33OHIGUH/+y3ah7lppcTv6FOZjU4gieOL9hEPdxCjiZKdeHaQBpua6b2XJCshuWD/
         0TrRAV/tx7tDmDUo+GXyiZFehOJMqe7FwPbaRBkPAuG+AktfcTU+Z+zDOpvaUUK0aW3M
         R8FJyCnv6fEkO+fiqyV0n8mBlyH9hM9PjUUscNVeD7G5HBY5M8QUDPt2NsTBRIk+zIsb
         z9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Tap7nBAM0h0L8VrB9lLDO+R7RMvpcS4S2PLyP50CL8w=;
        b=tW8j8nRWNDPEZzeCFhUsrWNa4t9MhvytKJJz43XD5Y71v/FQ/+YACVNjfJHK9VJfJC
         YbY9DLdAqClNlcO6JUZqxePvSgFII9Md7UhqsaeogLjFb2Gz9L+TZz7lf2t5V0+lYa/o
         Zj4MmYx4/GGNyNpc1I49sCjRi1iRmA2/Oa3qadp1evoxwnpDbmQxtMeAElmQwj8jSllA
         A8i1Et+4PyRR/RfJAkhPJKNdIZU3VTwwilc1qvQk+CSft/LYN+X0FChA1CS0ASmvvVqs
         BZHVflj5Kge5xhGUWFB6jSfa8dOvfM5h7oxvYdoxRlSBoiqts2pkeLdPeA+BHiSHuciu
         Yi6A==
X-Gm-Message-State: AOAM532poeFmNv6ZKYqitcoi35yJZrdUjYKafxA7Db2xKi2Tz3kX4joX
        3zoI/mQWLxn7c8t5HBYzk85yuRDRSA==
X-Google-Smtp-Source: ABdhPJxZdayCcLgGEvMgK9ZDeJlqsTgjaZ1M/Le/NEE1z5TpUoR902tFNIT9OoDe4Yfw9al4vallvqy71g==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:1cee:d72d:c926:e290])
 (user=tkjos job=sendgmr) by 2002:a25:850f:: with SMTP id w15mr26872987ybk.373.1640026923099;
 Mon, 20 Dec 2021 11:02:03 -0800 (PST)
Date:   Mon, 20 Dec 2021 11:01:50 -0800
Message-Id: <20211220190150.2107077-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH] binder: fix async_free_space accounting for empty parcels
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 4.13, commit 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
fixed a kernel structure visibility issue. As part of that patch,
sizeof(void *) was used as the buffer size for 0-length data payloads so
the driver could detect abusive clients sending 0-length asynchronous
transactions to a server by enforcing limits on async_free_size.

Unfortunately, on the "free" side, the accounting of async_free_space
did not add the sizeof(void *) back. The result was that up to 8-bytes of
async_free_space were leaked on every async transaction of 8-bytes or
less.  These small transactions are uncommon, so this accounting issue
has gone undetected for several years.

The fix is to use "buffer_size" (the allocated buffer size) instead of
"size" (the logical buffer size) when updating the async_free_space
during the free operation. These are the same except for this
corner case of asynchronous transactions with payloads < 8 bytes.

Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 340515f54498..47bc74a8c7b6 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -671,7 +671,7 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
-		alloc->free_async_space += size + sizeof(struct binder_buffer);
+		alloc->free_async_space += buffer_size + sizeof(struct binder_buffer);
 
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_free_buf size %zd async free %zd\n",
-- 
2.34.1.307.g9b7440fafd-goog

