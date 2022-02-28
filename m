Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811DB4C6181
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiB1DHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiB1DHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:07:17 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E20E220CA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 19:06:35 -0800 (PST)
X-QQ-mid: bizesmtp71t1646017585tf1kv1pq
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 28 Feb 2022 11:06:23 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000000A0000000
X-QQ-FEAT: F3yR32iATbhMswa43cCXQHfEbNdpcZJqhgsZXmS4JMIo72f+8AuPrT0TAHQCl
        3y5g5/xie4JEhHs+aoXSf+l8rQkoNAHdopjLIhi+BgCH6KvsLyXQb/tzCZ62OYo9mBH8riq
        t6UVCHTCbr4TZ+PZCGDHjfMW6GNWeEL7wTtXA5kPHnCR3uWIFncMVDkpXJ2jmNZFOmAEcpf
        ar+WJgpSKDo3mtKdB1+LxC+pGIuF3JXcpT6dA8EU1aW7sesbM3cIq6pPe6fGGK9lJz14kga
        xze6NaDfaendO/f5YXVbCkVwLW+XQHMgASwqi3oi/8VoHPz3FoLhnwfMCejmiuP6qWDSBGu
        3D6Qx4A5UjiALhhE/ItXBhN68JhKCltWb90MD5I
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v2 2/2] ALSA: core: Remove redundant 'err' variable
Date:   Mon, 28 Feb 2022 11:06:14 +0800
Message-Id: <20220228030614.10606-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220228030614.10606-1-tangmeng@uniontech.com>
References: <20220228030614.10606-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index aa4a57e488e5..3ac679ea31c7 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -582,13 +582,12 @@ static int soundcore_open(struct inode *inode, struct file *file)
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



