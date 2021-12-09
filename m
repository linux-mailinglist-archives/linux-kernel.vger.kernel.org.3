Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C45246F69F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhLIWTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhLIWTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A7C061353
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:16:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so12966153ybd.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lvYZWOMBGv2NvliGw5NO73inoVaqmyrZ+UqoCCa0Q2o=;
        b=RBkhEsB+TbqqkjEQx0sTwY/WeLY8qK5nIYs2MlLm587GOQtU6tH2jLBjfNSfmQygGx
         zlM08TUHCXig93/AlPkh86J8IU121WX91ikxAxAifMyCadcKe0qGkYAbMIraB7cMQJBl
         D73vY9NfXIJtTiBSDX918WyqpNAoRMfYSdcgsLrU0RBCeAsVlYe+UswtS0v7Qi3WCRuW
         LbeH1movF+a4mvzT00Q5OX7RQj9p0XtpeqTSrezLTlmbwdIbIbH5P4pfB13mZyu/ndoB
         oSm6FL54nBMhmxUN5vKhXoBExhbQQL7Tg7G358TrSDJnLZVC4KKeI3rqw4rnp9W+oqKD
         H0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lvYZWOMBGv2NvliGw5NO73inoVaqmyrZ+UqoCCa0Q2o=;
        b=D+2iKA48kQB7+MHxEgBBYnyI0JJaW/tX/tOswsH3AA5E+8RwomtjMchNITOckumF+0
         ll/newHRsZNhnGkcjJcV5PbynDYW15Hd0qDiQNpp1Y8VFX50t81Us1ofHi171QUB5L/z
         TAQYkBktLr6tN5KFMNKHbVdiVm5ewHGPLI374nll3TUGzeIN3gv1m1IkBuNYr+xRC+Mt
         P8wGLqAfKgbbKqDZexBpahH0BL20Hj3KdwB38eFfeXfeA4heEOYY2itFlAGZ/upAgtUm
         PBpFFHd0JEOIOu19FgJ2binWa429JlrmFvtnjE5KFO9c/V56n1c5URtj7vtYJUZgtCNo
         3D1Q==
X-Gm-Message-State: AOAM530PizoOvM4qsFt6mWrAJwH7BvF6rxNpYB8NPkG5U44vcg2mfzcr
        RtBC4wFzq9CZO5g2r5ReWR4zQp4=
X-Google-Smtp-Source: ABdhPJx7kPyMgfW98vbLG5bioLn4OfDFvxhzabv0RoREjBxyeXyYuIbfyTNmHSJpFQm+bDPS9Vkfirk=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f233:e324:8aa0:f65c])
 (user=pcc job=sendgmr) by 2002:a25:b2a6:: with SMTP id k38mr10316854ybj.122.1639088159255;
 Thu, 09 Dec 2021 14:15:59 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:15:40 -0800
In-Reply-To: <20211209221545.2333249-1-pcc@google.com>
Message-Id: <20211209221545.2333249-4-pcc@google.com>
Mime-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 3/7] fs: use copy_from_user_nolog() to copy mount() data
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

