Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE674C59DD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 08:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiB0HNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 02:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiB0HNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 02:13:46 -0500
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F95F62
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 23:13:10 -0800 (PST)
X-QQ-mid: bizesmtp70t1645945985tco67mqj
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Feb 2022 15:13:03 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000B00A0000000
X-QQ-FEAT: 3uawQE1sH+2lICw+ZedXyXmezZ02nfmW2VAb3WTGJhCcG/Sjh/B+KE7HY3msG
        zJVyJ6z4h/heNy95zLfEGLrB+d7aX6Q1KpSvyvNtdrE4fA4aX41ImHD96Yn8TIxIZqlc5fT
        yOj8Iwfz0J+fLU/IuGWXIy8FpJqSx9AqxGkyynfXwMJZkIL2+WENoLDLlKKUjLSl/O4bmtH
        f5ZZjC+sqri9ZZtCuerJph3EIetiOlWM9YFCAeP/8T0CpoWzDUW52H42D/ugcllaJOAlDUK
        cvo5Tkze721SNajnnpy6iRhG03jnermB6wm5xxA1UAVM78/IjWI4hrdKnry4Ipxk2fQMZUc
        YUycIqFyilaHy7DnKQ+fr5C33CPXByE9dkE4zf3
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH 2/2] ALSA: core: Remove redundant 'err' variable
Date:   Sun, 27 Feb 2022 15:12:53 +0800
Message-Id: <20220227071253.28193-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220227071253.28193-1-tangmeng@uniontech.com>
References: <20220227071253.28193-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the result from file->f_op->open() directly instead of
taking this in another redundant variable.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/sound_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 2ee54070b2b5..e7fa820b08be 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -586,13 +586,12 @@ static int soundcore_open(struct inode *inode, struct file *file)
 		 * We rely upon the fact that we can't be unloaded while the
 		 * subdriver is there.
 		 */
-		int err = 0;
 		replace_fops(file, new_fops);
 
 		if (file->f_op->open)
-			err = file->f_op->open(inode,file);
+			return file->f_op->open(inode, file);
 
-		return err;
+		return 0;
 	}
 	return -ENODEV;
 }
-- 
2.20.1



