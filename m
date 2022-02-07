Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285A54ACAB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiBGUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiBGUsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:48:39 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EB5C043182
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:48:27 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id HAvvnm18huvBOHAvwn6qGe; Mon, 07 Feb 2022 21:48:25 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 07 Feb 2022 21:48:25 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH v2] block/rnbd: Remove a useless mutex
Date:   Mon,  7 Feb 2022 21:48:19 +0100
Message-Id: <7f9eccd8b1fce1bac45ac9b01a78cf72f54c0a61.1644266862.git.christophe.jaillet@wanadoo.fr>
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

While at it, switch to ida_alloc_XXX()/ida_free() instead to
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/rnbd/rnbd-clt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 9a880d559ab8..1f63f308eb39 100644
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
-	ida_simple_remove(&index_ida, dev->clt_device_id);
-	mutex_unlock(&ida_lock);
+	ida_free(&index_ida, dev->clt_device_id);
 	kfree(dev->hw_queues);
 	kfree(dev->pathname);
 	rnbd_clt_put_sess(dev->sess);
@@ -1460,10 +1457,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_alloc;
 	}
 
-	mutex_lock(&ida_lock);
-	ret = ida_simple_get(&index_ida, 0, 1 << (MINORBITS - RNBD_PART_BITS),
-			     GFP_KERNEL);
-	mutex_unlock(&ida_lock);
+	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
+			    GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
 		       pathname, sess->sessname, ret);
-- 
2.32.0

