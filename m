Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352748F3FD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiAOBNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:13:50 -0500
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210]:58139 "EHLO
        out162-62-57-210.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbiAOBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642209226;
        bh=KtC2JAo9Zv4oft7XPe6btVLuXHfV817m3kIZSg+ZITY=;
        h=From:To:Cc:Subject:Date;
        b=Oh7AsDnPr5IvUZGlxd+4VZ/tiMiGw2ffhQAgpDmUnnD3s8VUbFFs8S8exdRchof59
         q2v22sEUkV0cDlfVUaQcCwxuFwUUpRolR6gDhhDM+Qd3FKs2Sx0ZUt7+33PzBWHgFE
         ltc96/3y0fb55JX8aI0LhFtfUuX2cvu4GfCP1mw0=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 2A006C80; Sat, 15 Jan 2022 09:10:32 +0800
X-QQ-mid: xmsmtpt1642209032t17m0k78d
Message-ID: <tencent_D67F131001E6EB5C358E0E0AB7F03725A907@qq.com>
X-QQ-XMAILINFO: M7r/zttrUmlksvo2G1dU0x+495CKZ8lA2TaVTDWSgFeh18HvqEBmuBZFhXZFRt
         p6UboqGlj17odmJTwuN21U3hqVvkbgrsHmLeCTdzUOLJU5nJHOaVPojHZbQ2GHvXDE073hniUIdr
         amAX6Wmc1M6WKwnM4zeBYvizY+2ZGDxquComGTkU3PJp+xhIAEI43L1/SLKgsg2WUfJi0BpWSBeC
         B87XSERumlTLYgXg5gqyak9Q6ZlMQPL+P+ZnGBqj37vMlzAh139zrv4C5Mr3DodkHyFqh5SBgJqG
         PKKwH5/gae/j5n6EXCCjTpaXuk3tITYa4/I/r7gj1to2L1nZ7So1tcviQka9E8nkysMBEUlPDyb0
         8gpYq/bSqYkBJfd9+ehg7yMltrve/ymP27jjTewlFkY3PSPYspcJSM1bS4STi+iZOltO2t5Ag631
         ApfcAU2eJAP6PxbFuE9XWpd5rDfoC58xHY8wIczRgtsba6FNo8rFZYdTVuAexLQc8ruSsJiX8GtK
         tbsgByYjIeBJ0ubM1ZVkJ6CUfc4SSMTHWxXHr274r9uP9dPKzaLu+E4b7mBts8atf25T3ksIs2q1
         lY7ze3P52yXLwiveaIPhOQGYK32uxDWnPmGdLgHHuJRtqkKteezNkDZqgM4vZuc39oaVVeZ/ODmK
         qz5b86eK8vHyQDdu7pLxJlJfbtvI0nstsfKgFtRE6PmphUyI0OBXTG5yFWp7bE8Z55U++Sib+0U8
         Wtv2dTtp4F/gYpwl1Y4O1dtmXK+1ngBPqlBuerNLmHeChU5Da2PhcP798jeLeuvA7pAg77+1Bt6B
         CNe+uT3A1Dswy+pPojJSf/hOR0oWHEXT7nRepulZoDSl21NV8XnNtyHZrTsssq5QchzLDdfl/1ms
         sv5wzyp3hQ
From:   xkernel.wang@foxmail.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] selinux: check the return value of audit_log_start()
Date:   Sat, 15 Jan 2022 09:10:06 +0800
X-OQ-MSGID: <20220115011006.1881-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

audit_log_start() returns audit_buffer pointer on success or NULL on
error. It is better to check the return value of it so to prevent
potential memory access error.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 security/selinux/ss/services.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e5f1b27..759d878 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3277,11 +3277,13 @@ int security_sid_mls_copy(struct selinux_state *state,
 				ab = audit_log_start(audit_context(),
 						     GFP_ATOMIC,
 						     AUDIT_SELINUX_ERR);
-				audit_log_format(ab,
-						 "op=security_sid_mls_copy invalid_context=");
-				/* don't record NUL with untrusted strings */
-				audit_log_n_untrustedstring(ab, s, len - 1);
-				audit_log_end(ab);
+				if (ab) {
+					audit_log_format(ab,
+							"op=security_sid_mls_copy invalid_context=");
+					/* don't record NUL with untrusted strings */
+					audit_log_n_untrustedstring(ab, s, len - 1);
+					audit_log_end(ab);
+				}
 				kfree(s);
 			}
 			goto out_unlock;
-- 
