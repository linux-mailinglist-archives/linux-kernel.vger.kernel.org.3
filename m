Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61814E875D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiC0LUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 07:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiC0LUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 07:20:00 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973735A96
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 04:18:22 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id YQuZno4PVvjW4YQuZnulRo; Sun, 27 Mar 2022 13:18:20 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 27 Mar 2022 13:18:20 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH] binderfs: Fix the maximum minor value in binderfs_binder_device_create() and binderfs_binder_ctl_create()
Date:   Sun, 27 Mar 2022 13:18:17 +0200
Message-Id: <ba880255b91b4682c21c62ae0bc5673e34a119aa.1648379891.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc_max(..., max, ...) returns values from 0 to max, inclusive.

So, BINDERFS_MAX_MINOR is a valid value for 'minor'.

BINDERFS_MAX_MINOR is '1U << MINORBITS' and we have:
	#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))

So, When this value is used in MKDEV() and it will overflow.

Fixes: 3ad20fe393b3 ("binder: implement binderfs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely speculative.

The 'BINDERFS_MAX_MINOR_CAPPED - 1' is here only for symmetry with the
BINDERFS_MAX_MINOR case. I'm not sure at all that is is needed and, more
importantly, that it is correct.
---
 drivers/android/binderfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e3605cdd4335..47df1f381150 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -130,8 +130,8 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	mutex_lock(&binderfs_minors_mutex);
 	if (++info->device_count <= info->mount_opts.max)
 		minor = ida_alloc_max(&binderfs_minors,
-				      use_reserve ? BINDERFS_MAX_MINOR :
-						    BINDERFS_MAX_MINOR_CAPPED,
+				      use_reserve ? BINDERFS_MAX_MINOR - 1:
+						    BINDERFS_MAX_MINOR_CAPPED - 1,
 				      GFP_KERNEL);
 	else
 		minor = -ENOSPC;
@@ -433,8 +433,8 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	/* Reserve a new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
 	minor = ida_alloc_max(&binderfs_minors,
-			      use_reserve ? BINDERFS_MAX_MINOR :
-					    BINDERFS_MAX_MINOR_CAPPED,
+			      use_reserve ? BINDERFS_MAX_MINOR - 1 :
+					    BINDERFS_MAX_MINOR_CAPPED - 1,
 			      GFP_KERNEL);
 	mutex_unlock(&binderfs_minors_mutex);
 	if (minor < 0) {
-- 
2.32.0

