Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79C7467EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383147AbhLCUyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbhLCUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:54:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BBC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:50:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so8194182wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOSjPGQ1kXbuiRCx0e8BVbhaDhMGDo7Gzfr415kJ7+4=;
        b=Ci65Su0CDpc4xoQmXxTan/Xs5wTt6gXS9TGLMDXimi5gzYKIQNdWKZ9rFgbm7bVGAU
         zyI9uIl7vvBG9r8vtBN4YQ3I4S7edjnCTyOX4x1RaS8jz0Y6JmM8ZTk3+9966ZfSxhSw
         BkaBcRjd5/FxZIICQEXJHHBocNmNtZXzwQCdv0TJcBjDKR3W0/sFkHkQBUFGAKOHFdRE
         npif+CHo6Akr+wIuBzwSeN8q/jn5SyUXz5VcQdP7sUm1ynv9cH/jO25gEpyXaxKTAGsQ
         Orv+AIR6AMdBoiU/90j/WwS4Wk7iMvxOGsBiCM2QSL3u+PHvJRmy6tE7kr5MaAMRmqQp
         Ye1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOSjPGQ1kXbuiRCx0e8BVbhaDhMGDo7Gzfr415kJ7+4=;
        b=Ju5oQPOKAQj1VH9uFFD1Oo7IbhOKda2Un6nmcLeE1c6dfUBPQwE2PrCzops2P+A7jm
         IAOGdvGt0/qFhuXEMeXUmyRO0vGDsg2KdxwHHoN4ZxuAih/5elcSPLuxyg+JUqIvOqfP
         5yrPS8UbsAebzYVCrNhEedGeEPnBex4YCLXaqbV5ASxEWyDVVVhECAEiISp4ki4AZWw2
         x4CfDJrLvkNrCyuFF+hGRzZV89eLEHsl5F7hLN5SCBTqASiwXhJYLK6K29Vth70b1MAH
         LHHBOSw2imn5cOhD+C+aEOhtedPWZTqRuBWr+yjELvDcgKhQTwGIKodDy355zKvWxIXE
         nykQ==
X-Gm-Message-State: AOAM530wHMm1mbSQo+8KPFBDa7wOdPRBH8ykJ47xQgGAONc1BcrKrfuv
        UVz/eTPoNoXiJgHmUPzag64=
X-Google-Smtp-Source: ABdhPJzgPmN9BqpsRZmJ3JbkyuiI8qdgPL9m/ymoK+3sbjhYuPKxW78qfuAHhqYlHLxO5Gm3UFPj2w==
X-Received: by 2002:a5d:64a2:: with SMTP id m2mr24877775wrp.248.1638564648306;
        Fri, 03 Dec 2021 12:50:48 -0800 (PST)
Received: from localhost.localdomain ([39.48.194.133])
        by smtp.gmail.com with ESMTPSA id h15sm6661592wmq.32.2021.12.03.12.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:50:47 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, amhamza.mgc@gmail.com
Subject: [PATCH] binder: fixed coverity warning by moving pr_warn outside lock
Date:   Sat,  4 Dec 2021 01:50:41 +0500
Message-Id: <20211203205041.115331-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity warns about using print operations within a lock due to
unlikely possible deadlock scenario, however, this warning can be
easily avoided here without having any effect on the program flow.

Addresses-Coverity: 1494148 ("Thread deadlock")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 drivers/android/binder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cffbe57a8e08..8ee942eef51d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1507,14 +1507,14 @@ static void binder_free_transaction(struct binder_transaction *t)
 	if (target_proc) {
 		binder_inner_proc_lock(target_proc);
 		target_proc->outstanding_txns--;
-		if (target_proc->outstanding_txns < 0)
-			pr_warn("%s: Unexpected outstanding_txns %d\n",
-				__func__, target_proc->outstanding_txns);
 		if (!target_proc->outstanding_txns && target_proc->is_frozen)
 			wake_up_interruptible_all(&target_proc->freeze_wait);
 		if (t->buffer)
 			t->buffer->transaction = NULL;
 		binder_inner_proc_unlock(target_proc);
+		if (target_proc->outstanding_txns < 0)
+			pr_warn("%s: Unexpected outstanding_txns %d\n",
+				__func__, target_proc->outstanding_txns);
 	}
 	if (trace_binder_txn_latency_free_enabled())
 		binder_txn_latency_free(t);
-- 
2.25.1

