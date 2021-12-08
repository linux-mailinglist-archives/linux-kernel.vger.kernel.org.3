Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B046CCB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbhLHEwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244300AbhLHEv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:51:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBCEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 20:48:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so2489326ybj.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 20:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lvYZWOMBGv2NvliGw5NO73inoVaqmyrZ+UqoCCa0Q2o=;
        b=LcAaZtOXvzkNd9sVH2yLm+/LCfc50ZjsZQfoXUZn7U+OT7GnL1XVyB0o+cD51g1mak
         Atu4LFmhQbZyDYeWpivY/cKuxNwGA8Jh/O7LpaMl/n1cfe2dZkr+atqOCbOeszYfTebI
         GC+jxXlemcn9ha4kKrirxAiOx89J4pv6tgTH17jY1GS/bmFafsxIDdDGbhzbX+ARJjCL
         G1Vq1kN0jk63LtGyolqjlQ/LUi0i9ZuCv6Qa8sNIMOPIlPGzgln1AjOoe2RdvLL8u+Ld
         pnAKV5yKSrxy6nzTPsR77c04HAKapfoXuyNLG7p2cKRJLtjzi8rUA0NXs5ToyAv17gH+
         MfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lvYZWOMBGv2NvliGw5NO73inoVaqmyrZ+UqoCCa0Q2o=;
        b=F4nxh1N4I14InRDqNKIl7x3/TAZIM7eDKwO1ggs/VRd/lneXomC9d0pGcUsYy5echK
         BHuwcvghG9TTYBil2wFk5AeGRrpMRamZp4O4bG1gF5FvMxo6JGinTPkKsXXTjAdb0oyy
         Szv3INhJVgXrH7pxU04nt0zi/B4ZGAMl9hqqshd1aL6H4oJYzM2zqdGO9NYmQYk5ErPd
         9UUCiSk9CSdz19oNHkClmZvtqfoWRaq2DSdImc3+ijdBZjfX3Sd+Uvpe4qch7RNRye8z
         DxbG8+6J4Tm/BLefLQcboM7ziCbAiGcNi/L3aepWSyoUFSwmmoU2I4AvMxan0lbL0eZU
         TbwA==
X-Gm-Message-State: AOAM531VMKA/Irl/b3Dx9lrXBmGDAhWzDg3ZiG+Q/13kz6pOUIT4sdhy
        3L7jxX83I9sAY7IubT2pG72DCc0=
X-Google-Smtp-Source: ABdhPJwdKv4aEZBt18+APFTl37LHZZmJKCQ2bWdhzhqziL4e4O+qlZtepaGeVotGWLHKGp3ZB5en6oU=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:be2d:924d:844b:d2fa])
 (user=pcc job=sendgmr) by 2002:a25:5cf:: with SMTP id 198mr52498659ybf.742.1638938904301;
 Tue, 07 Dec 2021 20:48:24 -0800 (PST)
Date:   Tue,  7 Dec 2021 20:48:05 -0800
In-Reply-To: <20211208044808.872554-1-pcc@google.com>
Message-Id: <20211208044808.872554-4-pcc@google.com>
Mime-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 3/6] fs: use copy_from_user_nolog() to copy mount() data
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With uaccess logging the contract is that the kernel must not report
accessing more data than necessary, as this can lead to false positive
reports in downstream consumers. This generally works out of the box
when instrumenting copy_{from,to}_user(), but with the data argument
to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
much as we can, if the PAGE_SIZE sized access failed) and figure out
later how much we actually need.

To prevent this from leading to a false positive report, use
copy_from_user_nolog(), which will prevent the access from being logged.
Recall that it is valid for the kernel to report accessing less
data than it actually accessed, as uaccess logging is a best-effort
mechanism for reporting uaccesses.

Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861288338dd605cafee6
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 fs/namespace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 659a8f39c61a..8f5f2aaca64e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -31,6 +31,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
+#include <linux/uaccess-buffer.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -3197,7 +3198,12 @@ static void *copy_mount_options(const void __user * data)
 	if (!copy)
 		return ERR_PTR(-ENOMEM);
 
-	left = copy_from_user(copy, data, PAGE_SIZE);
+	/*
+	 * Use copy_from_user_nolog to avoid reporting overly large accesses in
+	 * the uaccess buffer, as this can lead to false positive reports in
+	 * downstream consumers.
+	 */
+	left = copy_from_user_nolog(copy, data, PAGE_SIZE);
 
 	/*
 	 * Not all architectures have an exact copy_from_user(). Resort to
-- 
2.34.1.173.g76aa8bc2d0-goog

