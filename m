Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB54F46EA47
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhLIOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:51:30 -0500
Received: from xmbgsz5.mail.qq.com ([113.108.92.123]:41863 "EHLO
        xmbgsz5.mail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhLIOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:51:29 -0500
X-Greylist: delayed 7210 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 09:51:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639061273;
        bh=r8pL3HOUT5nde+cPdS+/FooXWt/j5uMCW0dK8eikE5g=;
        h=From:To:Cc:Subject:Date;
        b=c8rS7Dv9vAu/dncazvD8caXWn+b4VdJffaIfLdnAq4ALgzqJrABtkO5/BYBt3Ak7s
         NK+FVmQr3FopvTjAIyLiBiIU8X5cQz6Lw2gWu8T/xbcrDh1E7a82WQqXGgQlVX9FrB
         aKtO7vHFWzdZV1LuR2LdnMvXg0qbcQAKl1fM0b1M=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id A7207C82; Thu, 09 Dec 2021 17:41:50 +0800
X-QQ-mid: xmsmtpt1639042910tdxyfderb
Message-ID: <tencent_A14550789892F6FF07481AB3762E0D470E06@qq.com>
X-QQ-XMAILINFO: MbkhVtI1PGVkuuHqxbY8UwvBlM5CmdwFdRw/1lFM5de+/cEuhMxX/qd7ZpuQRq
         H5WGvmQ2k8AGnQagcn+CYyac97dpUOYw+viN8dS1CUHG4J3wj6TElYx8dGBta19me211Plz1+ZG+
         y9OTocWHZf33ix9NYXUIAAYogtiMFQ9pNVbQkSGyVoRtwcF4XQO84umxqmSObQFoVE5TvlrJJBFd
         niwv49JAIz1dPqvAYId75NJWMKPvuva942RSSPYy/dymWRxK75OSd9mD9DJaKWH3lgR4HIXcL6oQ
         Qn61Vggvf/o/TAgLzmoqQ/4MvzrFHKiJNCqVVYgZtYAPl/EETGIYXP6PVPz3u92GkzW9y4cCu3zA
         cj+Og2Rqc8Zv63Hgon9MS3XplceVezAH6mg6BDJckxvYIpkUDfEH3Uu9XmzHlNUZd7D4YPmFpUyv
         Z9gLNlDQQtm+Cfa5mPnimHMx2UlaVji+BiHTncc7HoyoIhqGp6B/69iuf4oqfJLms3iwr07C9NSn
         teGNObIzHY0RotsIpdavljDCpkDBGwbrwSnPnC96Gb7WYPXCD8VJYauDgxOyPlRk69l/EhlfqwFW
         wMN5UrKzHlTRt6f9A6W9Z5yKbyXmdvR6a0T9tKzPwgyBhK+3PBxObdoIIZ4Laxw8/ZuvX0qhhqXl
         tP0B2pIHSDVstV1s/ZZDnQghKnH+GDnt6T7XvIUYjHTWOmCo6BQmd6mYjJcoUIYN18rC4HhZSRuY
         1AEXQBD+wx/vlDEiMyzExArBaCTPFCSb/LG1+IvcjT2E6zADsk3rNRBmrSFs6wJJts+A27kMqF8K
         LdGLO1Vmc386dG56ySozO4vjUbVDYlqZVJyrS5ghsBaWulbdrjTOCydc7sWz7yRkOBl+gw4MKi6g
         iYxqo37hfZBYmvDZY7iA9yKUq+2tYh/qphH5adlReYpWyvsKmgCzg=
From:   x2018 <xkernel.wang@foxmail.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        xkernel.wang@foxmail.com
Subject: [PATCH] afs: fix a potential dead cycle and add a check for the return value of memchr()
Date:   Thu,  9 Dec 2021 17:39:31 +0800
X-OQ-MSGID: <20211209093931.3998-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xkernel <xkernel.wang@foxmail.com>

We should make the address pointed by p plus 1, otherwise, it will fall
into a dead circle. And memchr() can return NULL if the target character
is not found, so it is better to check the return value of it.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 fs/afs/addr_list.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index de1ae0b..83e6171 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -90,8 +90,10 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 			problem = "nul";
 			goto inval;
 		}
-		if (*p == delim)
+		if (*p == delim) {
+			p++;
 			continue;
+		}
 		nr++;
 		if (*p == '[') {
 			p++;
@@ -146,6 +148,10 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 		if (*p == '[') {
 			p++;
 			q = memchr(p, ']', end - p);
+			if (!q) {
+				problem = "brace2";
+				goto bad_address;
+			}
 		} else {
 			for (q = p; q < end; q++)
 				if (*q == '+' || *q == delim)
-- 
2.25.1

