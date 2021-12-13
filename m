Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC394722A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhLMI17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:27:59 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:39853 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233056AbhLMI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639384049;
        bh=7p4pPkafyJNJzmuyBPsnw4iYFGfavqT7QuzVHimInhc=;
        h=From:To:Cc:Subject:Date;
        b=yv0zL2AMS4eNoSc0g4KXLSqRii6yDmynORwzb40Tv55Nw4SIm08CMdmq5PvXt53EO
         FPq/z80xaLgiphAlDRLbP+/m/nJt5PrTzx9Tmo94dpkDMbYipTx5Wkc8qNe2pjmjnT
         nk2rdtdoIGjl2y8Ag6h8Ciyxu+5yU2BrJGW9xHQw=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 6D99888C; Mon, 13 Dec 2021 16:27:25 +0800
X-QQ-mid: xmsmtpt1639384045t7h8w8b4o
Message-ID: <tencent_8268B88CD2F7BF04083AF35D6E2C87158506@qq.com>
X-QQ-XMAILINFO: OLsBWtCIHsg6NQzGcg/jTkwQ0BUGSpARZTesnJlN3Dhb1AWg5kNt8qW6/DTr5V
         EGNcHLOqoPjC/B5oGHKDb2F7MqSyZ7BxyDBl1aLrUofxtmsgiecnPe5FDHr7FszA655UcCBHQJtW
         xFXKoqjGQt6XyI4aOwtnxPwhxBCDm0NZK1ZO5cIovOLcrBjOY3Zyj4k7jJt6E5cdAul+5W8whi4X
         j1zQA6/aRKHwJWbnKe+lpQdMbwP3IgYfdiKb1GRBk1rrV/JK8CyxNy0Xu1biKrkHzMuq1N9wqB5s
         WF5PGeAYtFu65QI6w5YxXHy3f2bJRbLXAWs6Q+d4A4Kp8wj3vofrN7NIMFHTgyjFkCMGfTHT+XUe
         JPZP4AaGPUeFLnb1JGfl7+lgn+Sp9y1AXdUkz6rH8LWOnZlH6xw6UjSWReZO3Os0Qo3HhHHO1HMi
         aaJakzMPYyxK0kl+uJc/HOxJ8mCGEF6F+1VEE3ZOXcieCbnbEAXvexSwIF9OAKNl50/0DhIS64hr
         R8XSiTTEaMTxeqg42i4BVu+gb+RQOt32ZNqNybmu/w6Z5I7jomqBgogXCvgQfnufgo8Y/KA5om8v
         85U9DkUftl4sVhHBORn8KIaF1G9Adru5+e12YBGLc9rrVQjGEEA40J9liceySYKor06586xY2Nd3
         I7QP+beMOO3Rbx89yX46PJJdEKpWlORTCVZkKqQbUWAkaer7P9p65MQ6kzBSZ27uK3IKjJzPeWLJ
         mxB7BH4Q/R6e71PvZxZ1exOH9spCT0sSX+9ijY9sfstblbPyPHwg64BXY/rc7K7fHQCewmixCaQb
         M6gqyahUTKaWpxjtNj3Q1+iooF2eJzKsODhO3kA6DWI9r7IQJvVpNL46bdSWuL+cANHC29q/WXl2
         lbXOQK3IqWG7SyU4hvBhCJlAD3Cx4IhYxLxT2QL/2ETLa6CfODj33o1FFKyfRrzQ==
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: Re: [PATCH] thunderbolt: check the return value of kmemdup()
Date:   Mon, 13 Dec 2021 16:27:15 +0800
X-OQ-MSGID: <20211213082715.4448-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: Compare with the last email, this one is using my full name.
kmemdup() return NULL when some internal memory errors happen, it is
better to check the return value of it. Otherwise, some memory errors
will not be catched in time and may further result in wrong memory
access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/thunderbolt/icm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6255f1e..fff0c74 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1741,8 +1741,13 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 	if (!n)
 		return;
 
-	INIT_WORK(&n->work, icm_handle_notification);
 	n->pkg = kmemdup(buf, size, GFP_KERNEL);
+	if (!n->pkg) {
+		kfree(n);
+		return;
+	}
+
+	INIT_WORK(&n->work, icm_handle_notification);
 	n->tb = tb;
 
 	queue_work(tb->wq, &n->work);
-- 
