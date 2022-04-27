Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625F651212D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiD0QBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiD0QBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:01:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF49FE57
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:57:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j6so4253219ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQyVzOmGatsZDLFbRiXRI7p7nx8HhGSNjwBVV4f1UN0=;
        b=Jj5SO7/rzR56yETiNi55V8DAnD92RBiYkXpet7MmYT4cqG9fMnX+x2/+EYwH++3MOI
         BXDoshiA+AaT/Pc/dUk3kEKuwTIDSVtZwJP4CgAuRmtQti1nfPnDdV5hAO0gZbR8bga/
         TxYNDWTF1X3Qt0tMz9qDCzfZ6BNMfOOI4ryPHiVEN5WLg1KqiVGtcJSxr5IF+3aoRbZQ
         UVmfzz3Z03m9d+RF0TYIqasPGJYncNDno4BogXRi6sDVVI8Yc8rrRXsI9dgTBiSieWU7
         bpWDInL5TM9L1GGjskpimZZt56yMT84Rb3qeMUHB99EW7bxYc/ONhx6sMCjKRj2mhE/J
         E8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQyVzOmGatsZDLFbRiXRI7p7nx8HhGSNjwBVV4f1UN0=;
        b=RpIdsvSJe3aKjEC1/EQs9Mp5PL8QLr7xq6d7yLd8F4eGD8rS5U8m6an1NlxZPkWTvF
         R59GV/JHYkwN/4pYsLVLIoFklXM2Un2hKMTpNtKbofCQxXYvwAp8v2ix8uru1xCCkMGf
         w5748Cl+dJeWu98vMiIJbq/nAcMLQ8gN3+j2ZiMSkAxTmwpyDwcWHDOX+gHevTOLkrl+
         Phcs+NA+8ai5635eFsDTTwor9zkqOXlj6uZ6qEUNs6J7TId+/hEu1dOIXAU+iFpYY/uD
         wvUiDmzVmoT9/ZECxRptifbxGJCex36YEj6BUJTKmyn64/WmlirAibD69akTPn6CPh2R
         7iYQ==
X-Gm-Message-State: AOAM5321HBwnZ9EigxkCibeD5hJMD6B3bkYAaVmanp/fbphd5yDUPP3Z
        vbFra6WfIb5VgPhtDjCfh8g=
X-Google-Smtp-Source: ABdhPJzyLkCrVGiHI6ir5kFCuEjAddlMylcLBFpxoXq2hb5v419AuqXoMDrkRpgbEK9dhEJMQ2pQjw==
X-Received: by 2002:a17:907:3e21:b0:6f3:bd59:1aa0 with SMTP id hp33-20020a1709073e2100b006f3bd591aa0mr6422903ejc.682.1651075056590;
        Wed, 27 Apr 2022 08:57:36 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z14-20020a170906944e00b006f38c33b6e3sm5091155ejx.68.2022.04.27.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:57:35 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2] misc: bcm-vk: use dedicated list iterator variable
Date:   Wed, 27 Apr 2022 17:57:27 +0200
Message-Id: <20220427155727.412069-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---

v1: https://lore.kernel.org/lkml/20220327214551.2188544-1-jakobkoschel@gmail.com/

Changelog:
v1->v2:
* remove possible NULL ptr dereference bug in bcm_vk_read (Dan Carpenter)

 drivers/misc/bcm-vk/bcm_vk_msg.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 066b9ef7fcd7..923fbcb73f2a 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -757,20 +757,19 @@ static struct bcm_vk_wkent *bcm_vk_dequeue_pending(struct bcm_vk *vk,
 						   u16 q_num,
 						   u16 msg_id)
 {
-	bool found = false;
-	struct bcm_vk_wkent *entry;
+	struct bcm_vk_wkent *entry = NULL, *iter;

 	spin_lock(&chan->pendq_lock);
-	list_for_each_entry(entry, &chan->pendq[q_num], node) {
-		if (get_msg_id(&entry->to_v_msg[0]) == msg_id) {
-			list_del(&entry->node);
-			found = true;
+	list_for_each_entry(iter, &chan->pendq[q_num], node) {
+		if (get_msg_id(&iter->to_v_msg[0]) == msg_id) {
+			list_del(&iter->node);
+			entry = iter;
 			bcm_vk_msgid_bitmap_clear(vk, msg_id, 1);
 			break;
 		}
 	}
 	spin_unlock(&chan->pendq_lock);
-	return ((found) ? entry : NULL);
+	return entry;
 }

 s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk)
@@ -1010,7 +1009,7 @@ ssize_t bcm_vk_read(struct file *p_file,
 					 miscdev);
 	struct device *dev = &vk->pdev->dev;
 	struct bcm_vk_msg_chan *chan = &vk->to_h_msg_chan;
-	struct bcm_vk_wkent *entry = NULL;
+	struct bcm_vk_wkent *entry = NULL, *iter;
 	u32 q_num;
 	u32 rsp_length;
 	bool found = false;
@@ -1019,7 +1018,6 @@ ssize_t bcm_vk_read(struct file *p_file,
 		return -EPERM;

 	dev_dbg(dev, "Buf count %zu\n", count);
-	found = false;

 	/*
 	 * search through the pendq on the to_h chan, and return only those
@@ -1028,17 +1026,18 @@ ssize_t bcm_vk_read(struct file *p_file,
 	 */
 	spin_lock(&chan->pendq_lock);
 	for (q_num = 0; q_num < chan->q_nr; q_num++) {
-		list_for_each_entry(entry, &chan->pendq[q_num], node) {
-			if (entry->ctx->idx == ctx->idx) {
+		list_for_each_entry(iter, &chan->pendq[q_num], node) {
+			if (iter->ctx->idx == ctx->idx) {
 				if (count >=
-				    (entry->to_h_blks * VK_MSGQ_BLK_SIZE)) {
-					list_del(&entry->node);
+				    (iter->to_h_blks * VK_MSGQ_BLK_SIZE)) {
+					list_del(&iter->node);
 					atomic_dec(&ctx->pend_cnt);
 					found = true;
 				} else {
 					/* buffer not big enough */
 					rc = -EMSGSIZE;
 				}
+				entry = iter;
 				goto read_loop_exit;
 			}
 		}

base-commit: 46cf2c613f4b10eb12f749207b0fd2c1bfae3088
--
2.25.1

