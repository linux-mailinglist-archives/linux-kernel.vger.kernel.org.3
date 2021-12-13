Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1871747235D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhLMI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:58:40 -0500
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252]:33131 "EHLO
        out162-62-57-252.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbhLMI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639385916;
        bh=aNoOjjdQKWDcluwGfOWHknMIdrECM2N+PBXqroqN9Wc=;
        h=From:To:Cc:Subject:Date;
        b=UzYQICTRk/t5L8lfmlG1c3qFAYYeXxZxdi/oZPnICiplbIn0Vwwq4K4R/h44PXeiR
         W7nPrXvPTyx4+8dkcWNQXDMdXj4sQSRMpjXoJUcUkakASbZBQ4F3KEnJZrIe6qPA72
         dHyivT4liwYVFGQbBVfaZ04SUUk1IenKrLY8SE/U=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza28.qq.com (NewEsmtp) with SMTP
        id EA1A1807; Mon, 13 Dec 2021 16:58:33 +0800
X-QQ-mid: xmsmtpt1639385913toj6an854
Message-ID: <tencent_B8A4989923779B6381A23A5C4209FD7F1E05@qq.com>
X-QQ-XMAILINFO: OW4JKxETGMY2Kw1Q9WumReN+uKyoXUa1X6iWjUwTKvhMx06rUQ2OmtIPAVYLfo
         k91TpCKWxG44K9Iy1x+NicEiip/2+78A3r7JTzkhCRPyjDYJ2+ZYBoGiDop5QgBi89/B/BJc99ZZ
         4YlwQZuNBbEG1S51FeIpUZ1cm5ouo9lDKulZ5cuVKFUeE2lgfnB2jeX4dVpnXfbmIAPlRq81FNrw
         7fQhA4hnZO1TvZjZY1vF27gCajzw4ZEu45T6GYhmfvGNQhZzWdPOyPeixnG39JcKDbYUW6oAt+W9
         ENm7qQcET3TwotunD5tbAFQ2wBPItK2g9nKEcyj6fzjzXLMGa/1+pEOIX7qzdISKKqI0rRx4cldw
         Sgscik1ebqek1bQcX1GZjYSpFUdUWqK9exsGyzi8gXuthK1ZwiIX98SOIVvU8u/jU+dIkLAO2k9f
         6j9fKne58lfqDnuDtDq98m4a0eIuCnv5hERnQwLN3plFF6Iwhxsvekg5JTpnlXhT5WFD1bYC4P9c
         qmsNdyLkgLOZaKZg8uuCOrrrsfTzhDnWXbHC1BhvZVLI/k5PF1OL8/vYnQyH1sX5S1B4EC69ud7g
         K76nSoLqUIYnngRbi77GY4r/YmV+UzAHGHIN7AxFnFnWPf/jXfvuPwBaa6PLTYvaYL85KCXMQwOV
         NsKyCPji6oBieEOJlf3hAjjXRvL7UzHZa1MSjbk4WxKR5ZXjnfu+sL0s6JDPJtcoAfdywm1yuMOB
         DH+zP+Wjv85ll6DJU16OypBERJPmuk3YfZFDjGdN5fDL5pqY1mZxmzjAYD87U59puaqdjqeZi900
         gJ9NHoGFLJmZFP+VEOoLLvktfarAfPl6AGuchHoPWJxLbpllUuZE9b6UBPtjL1mR9jhMoKiXQSLd
         faRqVF7YBWq6EdXE78oYsHACN5lbG38nMxwsKKqDzpIx1kb3sAXeJ/iUFZHCXl+3q7X8ndz2It
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] init/initramfs.c: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 16:58:16 +0800
X-OQ-MSGID: <20211213085816.4639-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() is also a memory allocation function and it is similar
with kmalloc() in some way. Once some internal memory errors
happen, it will return NULL. It is better to check the return
value of it so to catch the memory error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 init/initramfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index a842c05..49deffb 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -139,8 +139,12 @@ static void __init dir_add(const char *name, time64_t mtime)
 	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
 	if (!de)
 		panic_show_mem("can't allocate dir_entry buffer");
-	INIT_LIST_HEAD(&de->list);
 	de->name = kstrdup(name, GFP_KERNEL);
+	if (!de->name) {
+		kfree(de);
+		panic_show_mem("can't duplicate dir name");
+	}
+	INIT_LIST_HEAD(&de->list);
 	de->mtime = mtime;
 	list_add(&de->list, &dir_list);
 }
-- 
