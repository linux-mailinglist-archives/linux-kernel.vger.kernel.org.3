Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADEB4E8A4A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 23:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiC0Vs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0VsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:48:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C2338784
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 14:46:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y10so14905487edv.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20Qku66Un0STcQwrUDTvMrfzVHtMmdMF1TmmER8SnJY=;
        b=FoDAg4e/PGIria8vzwCAxOEuxrwDQwIGCluc3GEnGj2GDpvVZ4ev3cIUA2TR95+O0U
         xj5eN+Xnb/+qfKAxicpgNenLbFQXgXLS52Hk9Xgh+NIJsRWOHi4MROOnNOaUbj3YVqhB
         3TTELcQiZGEDGETLkESdWH7bRkCXGA3GFxQUkcuaEsZCWilDayZ5TGcM8k2bif8gbEwC
         YNVwYlehu/iOf341tPXfYRi9JvRxFAFjjFJjaTs+rX0uAi5Js7cNV0KrLr3InlKBMjvV
         779l5tGkOGuHKgqHVpNfOZY7id6ZXaQnk+JSMB2LCCVEg3lw1HZkcNHkxm3emqW9Fs/v
         aGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20Qku66Un0STcQwrUDTvMrfzVHtMmdMF1TmmER8SnJY=;
        b=AviDNN3feQbyrCPDgGrSd4FQlcxg5Pj1yunhtUeJGwaUR1vjmvpQXk1jZiDo4pfZij
         T5oKC75ZNxPZB6jWoSNrZUcJ2SFnYbvmC4WS94xNbvZb2vPc9qsY/hNwQcHers80CJTZ
         CCvdbJTjBRe82l4uB/eDgqZl1FeHLXvFass5ewVZHRfCSQC/CcEOCQA+nY8yxSrL4nMH
         VG0r3imKhRMDHJdug2SN/TFuaRH+vFCVn8VbIHtS2nShIwByWUR8SPF/89w80c0UpNLC
         dVH59SWpOotUrPnDlh6JrazJVCePw34OuKwbjPyvTOETdXcJKkoeK9gBH+RCmg5+i83O
         HwNQ==
X-Gm-Message-State: AOAM532WLzIYtA9A7i+p3toizaTql+R+snWSXOcfgm7eVClm2lS9aYah
        APtf5cQCJAIKAouhcLwIOfIN+E1x4Omefw==
X-Google-Smtp-Source: ABdhPJxidSXi4561yYZTlm3oJpeiNN7duuJ5IEqqVWfm9zZ3RDMLaV/Ae6SosezsxMVmNDsL9jXcVg==
X-Received: by 2002:a50:9d49:0:b0:418:681b:f6d with SMTP id j9-20020a509d49000000b00418681b0f6dmr12358612edk.160.1648417605044;
        Sun, 27 Mar 2022 14:46:45 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id js24-20020a170906ca9800b006c8aeca8fe8sm4990367ejb.58.2022.03.27.14.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 14:46:44 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] misc: bcm-vk: replace usage of found with dedicated list iterator variable
Date:   Sun, 27 Mar 2022 23:45:51 +0200
Message-Id: <20220327214551.2188544-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/misc/bcm-vk/bcm_vk_msg.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 066b9ef7fcd7..3c081504f38c 100644
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
@@ -1010,16 +1009,14 @@ ssize_t bcm_vk_read(struct file *p_file,
 					 miscdev);
 	struct device *dev = &vk->pdev->dev;
 	struct bcm_vk_msg_chan *chan = &vk->to_h_msg_chan;
-	struct bcm_vk_wkent *entry = NULL;
+	struct bcm_vk_wkent *entry = NULL, *iter;
 	u32 q_num;
 	u32 rsp_length;
-	bool found = false;
 
 	if (!bcm_vk_drv_access_ok(vk))
 		return -EPERM;
 
 	dev_dbg(dev, "Buf count %zu\n", count);
-	found = false;
 
 	/*
 	 * search through the pendq on the to_h chan, and return only those
@@ -1028,13 +1025,13 @@ ssize_t bcm_vk_read(struct file *p_file,
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
-					found = true;
+					entry = iter;
 				} else {
 					/* buffer not big enough */
 					rc = -EMSGSIZE;
@@ -1046,7 +1043,7 @@ ssize_t bcm_vk_read(struct file *p_file,
 read_loop_exit:
 	spin_unlock(&chan->pendq_lock);
 
-	if (found) {
+	if (entry) {
 		/* retrieve the passed down msg_id */
 		set_msg_id(&entry->to_h_msg[0], entry->usr_msg_id);
 		rsp_length = entry->to_h_blks * VK_MSGQ_BLK_SIZE;

base-commit: b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be
-- 
2.25.1

