Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB749D271
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbiAZTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:22:04 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:60028 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231542AbiAZTWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:22:03 -0500
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 14:22:02 EST
Received: from sas1-299d7dae1406.qloud-c.yandex.net (sas1-299d7dae1406.qloud-c.yandex.net [IPv6:2a02:6b8:c14:399e:0:640:299d:7dae])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id E2E394BE5E1D;
        Wed, 26 Jan 2022 22:15:06 +0300 (MSK)
Received: from sas1-1f4a002bb12a.qloud-c.yandex.net (sas1-1f4a002bb12a.qloud-c.yandex.net [2a02:6b8:c14:3908:0:640:1f4a:2b])
        by sas1-299d7dae1406.qloud-c.yandex.net (mxback/Yandex) with ESMTP id MRAHHasq3z-F6cmkliU;
        Wed, 26 Jan 2022 22:15:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1643224506;
        bh=p3KfHCrgw2V7xw85Rkmv7kxdQ1h3+1sdFv87o/9OxoY=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=r27455zd7Uwjz5OYX65kwCLGugwbRzux9uNOj7E1EWM8eS4djUwvsuZoEUYZBr4sF
         4Y6as9FbiZxl5X6QNgnqXFYwLz0VXA9CCoFwK7lE80I3suIfms8e+eFy/Mi5BjjKHa
         jcFEnEHPQ+dJpZ4HtsWkW8TaCoBZLWbTuhYCZIIE=
Authentication-Results: sas1-299d7dae1406.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-1f4a002bb12a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id vdrU00sr04-F5IGfXk7;
        Wed, 26 Jan 2022 22:15:05 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Stas Sergeev <stsp2@yandex.ru>
Cc:     Stas Sergeev <stsp2@yandex.ru>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Lutomirski <luto@mit.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sigaltstack: ignore flags if SS_DISABLE is set
Date:   Wed, 26 Jan 2022 22:14:40 +0300
Message-Id: <20220126191441.3380389-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126191441.3380389-1-stsp2@yandex.ru>
References: <20220126191441.3380389-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ss_flags combo of SS_AUTODISARM|SS_DISABLE can be used to check
the support of SS_AUTODISARM. We need to remove the like flags and
only keep SS_DISABLE because many libraries (eg asan runtime)
check if SAS is disabled by just checking "ss_flags == SS_DISABLE".

Also man page mandates that only 1 flag can be returned, so
returning SS_AUTODISARM|SS_DISABLE should be disallowed.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kees Cook <keescook@chromium.org>
CC: Jens Axboe <axboe@kernel.dk>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Marco Elver <elver@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Alexey Gladkov <legion@kernel.org>
CC: Andrew Lutomirski <luto@mit.edu>
CC: linux-kernel@vger.kernel.org
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 38602738866e..40634a500317 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4209,6 +4209,7 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 		if (ss_mode == SS_DISABLE) {
 			ss_size = 0;
 			ss_sp = NULL;
+			ss_flags = SS_DISABLE;
 		} else {
 			if (unlikely(ss_size < min_ss_size))
 				ret = -ENOMEM;
-- 
2.34.1

