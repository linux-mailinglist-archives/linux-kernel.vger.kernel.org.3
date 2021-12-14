Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0002473D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhLNGUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:20:16 -0500
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87]:34721 "EHLO
        out162-62-57-87.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhLNGUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:20:15 -0500
X-Greylist: delayed 17511 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 01:20:14 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639462809;
        bh=KtC2JAo9Zv4oft7XPe6btVLuXHfV817m3kIZSg+ZITY=;
        h=From:To:Cc:Subject:Date;
        b=Xzz/8CAgbnjnG8LXbp/cTKw3zVQ8BvqT8VSJlOexbP0KBgB1nWBe0wPyDHC12/nBB
         zE19xInorzMd76fgkGKogGNk0VubjuGPM91lmACFVJw/mNWH3gJPjH933yQy4MZ/rI
         d2o1r3sQNwfX/xRChBh4ndBT2qFXUE31tlGaZJxk=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 505A2217; Tue, 14 Dec 2021 14:20:05 +0800
X-QQ-mid: xmsmtpt1639462805tkfq958wh
Message-ID: <tencent_D0F3F07E25927F681055E6A35C038E168A07@qq.com>
X-QQ-XMAILINFO: MntsAqBg2ZZ5Fu3j93YYKkZ8AivXMvtN+g4XHjdxcoSj6+/RxlR3irJDF7Nprs
         cT4v6fh8S8xID1f+R/x5prxnjXNbept0v7QjULzjwaSGFDJnhmdwLWfWEA2w4H7918Hh5XA9cypW
         XnmPusASVTG8AJKzweNLhSH1eqzjO5TP5JFBsaCoL/aHOi3m9vrklPc+2femM+lBztb4SDwuyiEO
         dn9OFjCoQFrA61i8DQAbavNYGS4MvyvriluwK/1pcvXgzKXBkFuSLwxpQruDSJdqS+gKj6krB9x7
         eD/dHpZxS9i9WYhqbXB7LUSP9Bv500q6tLYdLeQwmsNvG/zZin1GYFSfFGwsw/CsEq3hcekAB2sO
         6NAwVCMQIICpgIuxofEeoCSkYBvMADUkc4PJRwuKxMsI8/kDnUeEAoeLa3ERQg362f8kg7iCEs1s
         8RdSvxIAMnqckb8KNnOcN6eQvOjdlRQbVPGR+FgOrg4Uu0D1PW8PC6SsSs16bL3VKAZhWQ7dHBbN
         3ZmbINmXPjjnTUhYB6uzYbBQ/cZb+ybIXQv4A1VUKtDZNbf5dXh4PnMdqzSHUaG6XG51757b8UcX
         wMpZG7PUR+GUKuEpBa2Gkuq/5Dp3M55inVZaDy33jp9R5wmxe3fIj4whBw9n3sWhVdkek8zmTkGh
         7161et/k2aw+qFwgKcC+CrtZuJLC7JUjN6EVQEgG8zfvHB4c8zhhpmEb2/UkUoCd89s16yCmi2B/
         EEM/VWRQCCzyeEQGtCR6eiNFkmC9i5l/anYpjXwRYScbNUJHNgvyhL6QPE8vQ1Db0s+duhSxtcWm
         7rSeQ5rMaYf9TVOKqn8vWZMbgr2eQ8bVPlBObQpJL21YAYjB8ZNGNKC4zrgZVG/YF3Xgdf6dVPWq
         ygtDdosANSJtKfbPoXSEZC/vBSkfi66OLir1XITD64ZTQ/6QXZ5n7E84ZU3tieWA==
From:   xkernel.wang@foxmail.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] selinux: check the return value of audit_log_start()
Date:   Tue, 14 Dec 2021 14:19:51 +0800
X-OQ-MSGID: <20211214061951.2158-1-xkernel.wang@foxmail.com>
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
