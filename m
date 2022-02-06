Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7A4AAE84
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 10:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiBFJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 04:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiBFJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 04:19:44 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA20C0612A4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 01:19:42 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id GdhrnoSYM41cbGdhsnhYtn; Sun, 06 Feb 2022 10:19:40 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 06 Feb 2022 10:19:40 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH] block/rnbd: Remove a useless mutex
Date:   Sun,  6 Feb 2022 10:19:38 +0100
Message-Id: <a1b05cd5bee83778812c70e115e31b2e49cbad2a.1644139163.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to lib/idr.c,
   The IDA handles its own locking.  It is safe to call any of the IDA
   functions without synchronisation in your code.

so the 'ida_lock' mutex can just be removed.
It is here only to protect some ida_simple_get()/ida_simple_remove() calls.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/rnbd/rnbd-clt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 9a880d559ab8..eaff369eff36 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -23,7 +23,6 @@ MODULE_LICENSE("GPL");
 
 static int rnbd_client_major;
 static DEFINE_IDA(index_ida);
-static DEFINE_MUTEX(ida_lock);
 static DEFINE_MUTEX(sess_lock);
 static LIST_HEAD(sess_list);
 
@@ -55,9 +54,7 @@ static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
 	if (!refcount_dec_and_test(&dev->refcount))
 		return;
 
-	mutex_lock(&ida_lock);
 	ida_simple_remove(&index_ida, dev->clt_device_id);
-	mutex_unlock(&ida_lock);
 	kfree(dev->hw_queues);
 	kfree(dev->pathname);
 	rnbd_clt_put_sess(dev->sess);
@@ -1460,10 +1457,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_alloc;
 	}
 
-	mutex_lock(&ida_lock);
 	ret = ida_simple_get(&index_ida, 0, 1 << (MINORBITS - RNBD_PART_BITS),
 			     GFP_KERNEL);
-	mutex_unlock(&ida_lock);
 	if (ret < 0) {
 		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
 		       pathname, sess->sessname, ret);
-- 
2.32.0

