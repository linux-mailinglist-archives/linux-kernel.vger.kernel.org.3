Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81594E8754
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 13:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiC0LIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiC0LIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 07:08:24 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649D337BC1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 04:06:44 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id YQj9no0PLvjW4YQj9nukfS; Sun, 27 Mar 2022 13:06:41 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 27 Mar 2022 13:06:41 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org
Subject: [PATCH] block/rnbd: Fix the maximum clt_device_id value in init_dev()
Date:   Sun, 27 Mar 2022 13:06:30 +0200
Message-Id: <42165d3f9dfc7abb54542d34a4e33ea8e83b101c.1648379172.git.christophe.jaillet@wanadoo.fr>
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

ida_alloc_range(..., min, max, ...) returns values from min to max,
inclusive.

So, '1 << (MINORBITS - RNBD_PART_BITS)' is a valid value for ret, which is
then saved in 'dev->clt_device_id'.

This value is used in rnbd_client_setup_device() and passed to
rnbd_clt_setup_gen_disk().
There we have:
    dev->gd->first_minor	= idx << RNBD_PART_BITS

So a possible value for 'gd->first_minor' is '1 << MINORBITS'

This is an issue because:
    rnbd_clt_setup_gen_disk()
    --> add_disk(dev->gd)
      --> device_add_disk(NULL, disk, NULL)

And there we have:
   ddev->devt = MKDEV(disk->major, disk->first_minor);

So, should 'gd->first_minor' be '1 << MINORBITS', MKDEV() would overflow.

Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))

This patch is completely speculative.

I think that:
	if (disk->first_minor + disk->minors > MINORMASK + 1)
		return -EINVAL;
in device_add_disk() handles this corner case.
Anyway, if I'm correct, handling the error earlier can't hurt (at least I
guess so :)).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b66e8840b94b..db900c3786a3 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1454,7 +1454,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_alloc;
 	}
 
-	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
+	ret = ida_alloc_max(&index_ida, (1 << (MINORBITS - RNBD_PART_BITS)) - 1,
 			    GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
-- 
2.32.0

