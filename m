Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9221473B91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhLNDff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:35:35 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:39179 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbhLNDfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639452929;
        bh=Sa2iqEOLVku/y36eaFX4M1VKLqfo4RVssY1JQQe1YQc=;
        h=From:To:Cc:Subject:Date;
        b=C3szi05D12hVXiWpQKVzBAvNy8Q2D7Fi0ofNC/OpkCC5Bym1fdcKH+SDf96m2cNCR
         CrUconkQcS6FmLvk1/vf1zWF+VMjMsU1ocz6oP+pFtwObPS2lsQJ/h2nwKcZL7PXxL
         Sq3VjoYTExKHX82cT9WD8e+mn8RbcpotUl/51DvI=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza28.qq.com (NewEsmtp) with SMTP
        id 8DA2B8F7; Tue, 14 Dec 2021 11:35:26 +0800
X-QQ-mid: xmsmtpt1639452926t1x4d61w0
Message-ID: <tencent_425C87AB28D1FF53823C3047E48A71FC520A@qq.com>
X-QQ-XMAILINFO: OWP2IlFwb745ZxdgO7UJM0sto4kd0qqTYK5AJYBI3kv6KRtQdTU+Ll8Xv2L5ql
         HzHGJ3QD6XTUpvOvGTd47cR6OWjzt1UnU8THM+xt/fEXcALK1qF1xjOhoauhV8KH64pbNXTZDN+b
         wZRe6aSBMJM+J5d9SgjwDeE2K7/awsWtaEAR7sWQl3KEXBgiRlhBf3aQCztTqO2/CUxhSHpvmLaq
         v692xKJy4ws2lyCCi8OPbhznK9yZaBBZDBAS1kdRPp/jqx40diQo3/ogdQmH8q97NVqKC8rGbr3d
         6djoa8c7AQ0Zk6B4vGTBeIQKj8QimJlikLKz1WHYkisqDgjGf66ES/CikMXI3miV/OCYFlDZF6Q4
         gZxfHJMM7rH4W0WZfP6ZfMkZSUQkZgkE+8KegqSacM5jBm9rnSLWeIff97BUEgAPNYMm4lYAwbPF
         T+JtY3RwpG/0NwbWYyx95qtyT6B4yMR6KdRKQ+0X9OtYEZ8vKlTPEzuCWsHztFSIv8yjVY2Jj30+
         2K6qaVMSwHJ5ItA0LWFeaVaG4h9MkPS380ClpRY4Vd7sQoVoAANcjgPuKdTLj9O+tUdpirtl/cSI
         KbKmLsLzc2Toyj4eRfy4Km4sXtbyKYrZFTIDI9RQhDEymgSv3OaKwAY7z5Cs+Roh5Y84vrFC/Tse
         XD+a/x+Noc9km4jBYG4jGoaDMOS3is/A0pKXb6ZtXk3BBMYxJJuXsftMFK1dud9Upt+4rQZWZsRh
         QTA/aHkH2t+ZkMcPDEc4+O66/0jwAnVtZjSoUhOUd/ZTeHwYDSqOaLywaN3t8nDNYIhhKqU6FzDB
         xT+92JMdbgY5aqA93OjqowMzZBfZQhSKRqm1Lf+IH32swBpZ+ZdwUPsQSpjLRytvVCt2MAY2OlST
         bRUpWLNujmwDysxSM57tePXVopWZByIQ==
From:   xkernel.wang@foxmail.com
To:     jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] integrity: check the return value of audit_log_start()
Date:   Tue, 14 Dec 2021 11:34:59 +0800
X-OQ-MSGID: <20211214033459.1983-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

audit_log_start() returns audit_buffer pointer on success or NULL on
error, so it is better to check the return value of it to prevent
potential memory access error.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 security/integrity/integrity_audit.c | 38 +++++++++++++++-------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 2922005..62785d5 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -45,23 +45,25 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 		return;
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
-	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
-			 task_pid_nr(current),
-			 from_kuid(&init_user_ns, current_uid()),
-			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			 audit_get_sessionid(current));
-	audit_log_task_context(ab);
-	audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
-	audit_log_untrustedstring(ab, get_task_comm(name, current));
-	if (fname) {
-		audit_log_format(ab, " name=");
-		audit_log_untrustedstring(ab, fname);
+	if (ab) {
+		audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
+				task_pid_nr(current),
+				from_kuid(&init_user_ns, current_uid()),
+				from_kuid(&init_user_ns, audit_get_loginuid(current)),
+				audit_get_sessionid(current));
+		audit_log_task_context(ab);
+		audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
+		audit_log_untrustedstring(ab, get_task_comm(name, current));
+		if (fname) {
+			audit_log_format(ab, " name=");
+			audit_log_untrustedstring(ab, fname);
+		}
+		if (inode) {
+			audit_log_format(ab, " dev=");
+			audit_log_untrustedstring(ab, inode->i_sb->s_id);
+			audit_log_format(ab, " ino=%lu", inode->i_ino);
+		}
+		audit_log_format(ab, " res=%d errno=%d", !result, errno);
+		audit_log_end(ab);
 	}
-	if (inode) {
-		audit_log_format(ab, " dev=");
-		audit_log_untrustedstring(ab, inode->i_sb->s_id);
-		audit_log_format(ab, " ino=%lu", inode->i_ino);
-	}
-	audit_log_format(ab, " res=%d errno=%d", !result, errno);
-	audit_log_end(ab);
 }
-- 
