Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21901472165
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhLMHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:12:51 -0500
Received: from out203-205-221-235.mail.qq.com ([203.205.221.235]:52234 "EHLO
        out203-205-221-235.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhLMHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639379568;
        bh=uSWOe0qowklfCUjBzXbSbmjv1ohNvQfQVwS/GKRmzDw=;
        h=From:To:Cc:Subject:Date;
        b=KJPbRpylIq78MR8mB7sQqVe2pn4oHVT1F4t+29MI1wPrmhQ0VnA9QItYFtCkBsWUh
         d75OJ+/gNwOHTBCWyUPGtS1Tz+Eht6+bEGbxMEdrpGA+qQDhUb+bEoXEJTrjH8Y0HY
         uWs7HLaGIOa/QyC8eMdYntGNIQkXTDuvN4ipeUD8=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 32D32AC9; Mon, 13 Dec 2021 15:12:45 +0800
X-QQ-mid: xmsmtpt1639379565t3jidducb
Message-ID: <tencent_E48212C43F3D8814735B6E12871B455A7806@qq.com>
X-QQ-XMAILINFO: ObFHHlrAm440efegq1tiB+eWss5mA465RGtnt1kdXadtREivm2dJgW4jVVbeDB
         BpqT8G6ru83XtK9/2H7zIM0vmjJe+ddcypSK8YiFka6i8+fYcHMz2+IAdQGSD2ZctTYZ8y1c7lUT
         p5Royp4DjOc8ir+ODpUx2j7ZyF7MOrhKZltWL0FAsvHc3qiv39WFnaxKvTCztvuujpQaQbicw1h5
         fDWoWU5xlg/dlzKZn6HJeWKHP1xyloftqu5zFkde6D4q7h3OMZJtn/ORN3gEQaPg0SvA7HYMvUf6
         f+rYPjXLpv6zcoQfxn/dqwbdu+u6KwgLHdUj2ovWLneYwpjXd9c3N9Dk9XJx+lhVbgqdl3fMQGwN
         trqFnd9EaEm4I4f4zFysg5QgDVyKDFpEdgTKuvmJYKgE3V5Gaxn/eFuo504MBxrC6bClau+jgMGf
         COcKGqSgm0emcE5YZxfaxR4UWSpr7XiMbbXK2UQ1wccoBuuH5xpNxPo3nwuJFda7A7vy1z0MtN+u
         Sivbok1DsF4IcQMTx4M5SeUUnqV9vuXt5hy82HUSNJVCaxCCUObniThigJJl9lwXcPtHF4O9c4+P
         0qpUYIR0HBCvlbOaV910ECGCupiKYa/jyTDrQ5Po8eVA7aRTbIwH92SKpETo5OAyckvQ0BHcZAXG
         g5qhJG6LwDu4OznRSa94vhg/EMqe4rjz+Yui3ACTgT54haU4am4RGBCr64WUSmgsdGwoarJ/E5oB
         oa5HpTDsTj87Aa5Bf1yLFcDki9lcYlyJ/WRjZjOn3291HhsTQR/9wREZsFl2lSoJD8ibZu+fWPqh
         Z08WRkERG1WYEaCugoTqbcFQrmBajgTsnpq23Lnq9WBjwNxO5X8hg57SKoig0/zEdVXSJNRqbNiR
         ULtO+nvY7oPdZJXm5zS59kO2NvHs5cfPWjXIOPLvY+Oe7TJEwsnvI=
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] afs: fix a potential dead cycle and add a check for the return value of memchr()
Date:   Mon, 13 Dec 2021 15:12:17 +0800
X-OQ-MSGID: <20211213071217.3880-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this email is using full name
We should make the address pointed by p plus 1, otherwise, it will fall
into a dead circle. And memchr() can return NULL if the target character
is not found, so it is better to check the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
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
