Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A75471BD8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhLLRRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 12:17:39 -0500
Received: from out203-205-221-235.mail.qq.com ([203.205.221.235]:53715 "EHLO
        out203-205-221-235.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhLLRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 12:17:38 -0500
X-Greylist: delayed 19883 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 12:17:37 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639329456;
        bh=CKNZc3rNmxigNQnuhNRz5WMSmKELZ28GqKpX6RgOe78=;
        h=From:To:Cc:Subject:Date;
        b=XGkGtyD6oduY1fdCGP4xkS1qGsxEPdqDnBo5Tzl0o9FQt93z4fzMLP/Y66AjY7mq5
         QtpyTF7TdUMML1wmVr08P1MzmMUBFWmcf9FXJMUoGSUtHtK1peWbsKe6YASgRMBpe5
         Mb8zMHsd0yHcr4I1hwbK99GoqtoLSg3gLtkKZvuc=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 46115C1E; Mon, 13 Dec 2021 01:17:33 +0800
X-QQ-mid: xmsmtpt1639329453t6c9zofbi
Message-ID: <tencent_92C2059570FFBB4196983373B1387228D209@qq.com>
X-QQ-XMAILINFO: OBvbJS/7aDyUVPBqS0qKbaOpx82zf6igtFY8MVJOc+htCwbeGDqWjTtkNi2zI7
         r9B/eLPEjzPcsPSXW67BtVqFQcG9USzfYegBTA7/eLZpCilPEpHLwFaYPY5LEiGqEuRkL5E5gDxk
         KXV00VqLLiftooSCMSqrcRI5E6QhY2++HZb1BOyNoKkqnIqXNu0M7oQPTI1VWn6Ggm0YTeQvYv7B
         VQBotxaNwZ57g9iK3xFWnal2uW2vsQbCuUWUDTexhhS7HRyjETfEyySoUSXGXVNiRAb9m8y6oVYs
         caCHbCC+0tqvg/BZopQLav9kscVmPm7ho2qOkVlc4/VANzUy0iUriNVCQo9e+CRLir1gOZ0EX27g
         Oo+oNjBGZevMlD/RYIGCV+8i09PpNY+xfV9sptBPUTIH9qQCBUK2oNqVNQkQp3qEoQIkuRBTNfgL
         VmtPSKN6dyIK97iCk7+wH3Pafx1cLwPzwq1rhnwvjWHJpWo+zTmMsx9+nB5K+KlshgIUURNsA3QY
         1J1RgbPnE9T2OBdsT/tPD7q67mkdAyeScy8xGosURrNlNjxs8oy8huWwPD7cpo68SXzsvL2Vnt+w
         POCKK1CMuYi6C4BicWYQt/dQAUe8D5+0vM0frEMqhQl55eFmvTOvjqhwVWAmdB3bWAZqs09dG2Tx
         /F85pl26np/fXAZuwrk/R/AswCRh5FLdBHcWTY/4+fQpwwX+P8vmfgQmPCkzxNCuhD5+cqj0CIet
         VIZCYKWhmY8DnpwXICfHnZM6Wu0O4FKD65IKvtToJ/014BkprF03GhihjIhWHyNPJRIaSqIV+h/5
         tC+FJPi1+EJaNp+pwH7Q5sPZlwaDcSC1AxvgUSy4sDns+jlbf0nZ/I+H7ga8guZ/4yrvfPtOz8r1
         oIwZDOnmVO
From:   xkernel <xkernel.wang@foxmail.com>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, xkernel <xkernel.wang@foxmail.com>
Subject: [PATCH] pstore/platform: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 01:16:24 +0800
X-OQ-MSGID: <20211212171624.3067-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL when some internal memory errors happen, it is
better to check the return value of it. Otherwise, some memory errors
will not be catched in time and may also further result in wrong memory
access.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 fs/pstore/platform.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b9614db..f7c8732 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -620,6 +620,11 @@ int pstore_register(struct pstore_info *psi)
 	 * through /sys/module/pstore/parameters/backend
 	 */
 	backend = kstrdup(psi->name, GFP_KERNEL);
+	if (!backend) {
+		pr_err("out of memory duplicating '%s'\n", psi->name);
+		mutex_unlock(&psinfo_lock);
+		return -ENOMEM;
+	}
 
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
-- 
