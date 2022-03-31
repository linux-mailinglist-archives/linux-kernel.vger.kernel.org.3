Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D554EE432
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbiCaWiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbiCaWig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:38:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C32013E7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:36:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c62so940768edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRq4/uptx89Q5dmt54exn9uvNfFHwJcIQ3/3peS2CLQ=;
        b=A3TTwbL2mbf52k1uMntKOT0GqhYED7GliqL6lrajQvLNr4hOrCye+dTh2ed7JT0aG6
         vrTMT2OQ1C0VCOYtZE/cHdXjuJUpgPCYjfiVi6lSEh0hKBsVNhF49nT5L6mr6ZP6t7mt
         9xd7jDeg/O/tuYWvqQPMYNLrqZIeSBq17DfOGLVIkR6a3G48WrMdMn/R43P6dAPWhy4c
         kul9emkG3sd/2B4zYYU+kpczP968aWHyKE2jH7yCwgrrOqFW4YA9rkOmVYQ12KAKsuFo
         KjvgTrcmPhfQBD0xx1Nasekq0/U5MXc8rYarSqvGxGEyZEwjCkT+PTKxfy0SpRO55shZ
         oFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRq4/uptx89Q5dmt54exn9uvNfFHwJcIQ3/3peS2CLQ=;
        b=5inZTRSSTp9bajjn/E6YEhD0Xz4RqjS5ayW01mx7F0WVcFadiCMmFhTDdjRrfidZU5
         og/168rlwH5c4urT3HhDnoEUf9zHJcGonxNJE1x/+yIwrHmqpR+GipxL4nkSQsRt2VDD
         I7FvQwnXlkrhj2GVJKXkzcB9WGLQFzrLJr4BuQTb4gttTN2ejSphiQB52SlxXlK3N4M4
         X7G/YyCdVXmNIZgKNrFN6ESI7CaQ88u9uIo7JRrHSDuqh1UhCJ5sXM3Niepq4EVPVjc7
         TtDDi3baVp6GS9sLL/rrcNbN0eDh/jYVfIuLZKgEJ/mim62cvhUncA/utAsodngCvC+W
         wWtg==
X-Gm-Message-State: AOAM533P0EWVEd/ESM4rxYUP38laq6tihWM9GvGq5RHg7BKsAhI8YAOJ
        IxKp3j4AY+1taApjszitIcigvr3elgx+WxN4
X-Google-Smtp-Source: ABdhPJyzp13/L7RKQKymoX51n4Tgo8NLL/jJ1JPDMkSvf9NAhw7IY9gMOJxfb1BRi9hvEP4BKvOyyw==
X-Received: by 2002:a05:6402:27d0:b0:419:5184:58ae with SMTP id c16-20020a05640227d000b00419518458aemr18600878ede.314.1648766203762;
        Thu, 31 Mar 2022 15:36:43 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id k19-20020a1709062a5300b006c75a94c587sm282872eje.65.2022.03.31.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:36:43 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] firewire: remove check of list iterator against head past the loop body
Date:   Fri,  1 Apr 2022 00:36:01 +0200
Message-Id: <20220331223601.902329-1-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/firewire/core-transaction.c | 30 +++++++++++++++--------------
 drivers/firewire/sbp2.c             | 13 +++++++------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index ac487c96bb71..6c20815cc8d1 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -73,24 +73,25 @@ static int try_cancel_split_timeout(struct fw_transaction *t)
 static int close_transaction(struct fw_transaction *transaction,
 			     struct fw_card *card, int rcode)
 {
-	struct fw_transaction *t;
+	struct fw_transaction *t = NULL, *iter;
 	unsigned long flags;
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(t, &card->transaction_list, link) {
-		if (t == transaction) {
-			if (!try_cancel_split_timeout(t)) {
+	list_for_each_entry(iter, &card->transaction_list, link) {
+		if (iter == transaction) {
+			if (!try_cancel_split_timeout(iter)) {
 				spin_unlock_irqrestore(&card->lock, flags);
 				goto timed_out;
 			}
-			list_del_init(&t->link);
-			card->tlabel_mask &= ~(1ULL << t->tlabel);
+			list_del_init(&iter->link);
+			card->tlabel_mask &= ~(1ULL << iter->tlabel);
+			t = iter;
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
 
-	if (&t->link != &card->transaction_list) {
+	if (t) {
 		t->callback(card, rcode, NULL, 0, t->callback_data);
 		return 0;
 	}
@@ -935,7 +936,7 @@ EXPORT_SYMBOL(fw_core_handle_request);
 
 void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 {
-	struct fw_transaction *t;
+	struct fw_transaction *t = NULL, *iter;
 	unsigned long flags;
 	u32 *data;
 	size_t data_length;
@@ -947,20 +948,21 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	rcode	= HEADER_GET_RCODE(p->header[1]);
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(t, &card->transaction_list, link) {
-		if (t->node_id == source && t->tlabel == tlabel) {
-			if (!try_cancel_split_timeout(t)) {
+	list_for_each_entry(iter, &card->transaction_list, link) {
+		if (iter->node_id == source && iter->tlabel == tlabel) {
+			if (!try_cancel_split_timeout(iter)) {
 				spin_unlock_irqrestore(&card->lock, flags);
 				goto timed_out;
 			}
-			list_del_init(&t->link);
-			card->tlabel_mask &= ~(1ULL << t->tlabel);
+			list_del_init(&iter->link);
+			card->tlabel_mask &= ~(1ULL << iter->tlabel);
+			t = iter;
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
 
-	if (&t->link == &card->transaction_list) {
+	if (!t) {
  timed_out:
 		fw_notice(card, "unsolicited response (source %x, tlabel %x)\n",
 			  source, tlabel);
diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 85cd379fd383..60051c0cabea 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -408,7 +408,7 @@ static void sbp2_status_write(struct fw_card *card, struct fw_request *request,
 			      void *payload, size_t length, void *callback_data)
 {
 	struct sbp2_logical_unit *lu = callback_data;
-	struct sbp2_orb *orb;
+	struct sbp2_orb *orb = NULL, *iter;
 	struct sbp2_status status;
 	unsigned long flags;
 
@@ -433,17 +433,18 @@ static void sbp2_status_write(struct fw_card *card, struct fw_request *request,
 
 	/* Lookup the orb corresponding to this status write. */
 	spin_lock_irqsave(&lu->tgt->lock, flags);
-	list_for_each_entry(orb, &lu->orb_list, link) {
+	list_for_each_entry(iter, &lu->orb_list, link) {
 		if (STATUS_GET_ORB_HIGH(status) == 0 &&
-		    STATUS_GET_ORB_LOW(status) == orb->request_bus) {
-			orb->rcode = RCODE_COMPLETE;
-			list_del(&orb->link);
+		    STATUS_GET_ORB_LOW(status) == iter->request_bus) {
+			iter->rcode = RCODE_COMPLETE;
+			list_del(&iter->link);
+			orb = iter;
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&lu->tgt->lock, flags);
 
-	if (&orb->link != &lu->orb_list) {
+	if (orb) {
 		orb->callback(orb, &status);
 		kref_put(&orb->kref, free_orb); /* orb callback reference */
 	} else {

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

