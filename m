Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAD4DEAAD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbiCSUj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiCSUjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:39:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BFF197F8E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:38:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r22so2959289ejs.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yDAY6CmvNAdYPiLE5j66Po7nzSgQMLanAVyEQyO52M=;
        b=Qu56kVuio6f+jRUuV5b5iTfhX4+BP/y8VAB3iBJbvzGTJkSkWOaBi6MmKnH/3Eu7Ji
         6uuRG7NHsyjLcBHYL5er6sB0bTszm/Id7or1yQJpZLzZkLkbWGhkUBcWLT+TMfEMrtgA
         0qJm3uBPkU274N93jmsjq9uwNhW86WlKOxRu+LABinitxkicnz2GtY1pHSLoyxGD2+3a
         REtWo4UzOFXQ666cr3X7c0osYeKRYrpsuG+OgBefrSuN2B/l3qhLjB8ue6HuX0z2vxX8
         ZtiKZluvAy29mF51s5MNUoPt5lecK2ZB2zUIHEFUpmVc4E44TPX20XYkWfF2HCo+KHlf
         1nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yDAY6CmvNAdYPiLE5j66Po7nzSgQMLanAVyEQyO52M=;
        b=hnEBHav6Am/iiHFsRzBesGiaInnip0fKPpIvyMt9qEdJ6oek55v8DpWENy9L66S+/J
         TyKVQTWo9TyWPYL0hpdBIUR/ydqPe0KUZUEUCAzeiRAQCm1H6H98ikuwOtRGihATjPJT
         QStT2yBiaBvsG4VGztz6Jztp61yP+Oasy+YD1NRgqQB0uzAjnzz1kZt04y1JRkfjAhLV
         5ax0QbZtZK//H5yz1l5SSSSe3nsdVNGERkhrDJPP/6+4r0b3epp/mxDEnmM6zsd+4lF/
         TCKcGF9vXyI/0DzfWdfltUbXAVps4K3V6LbH0NsYatcZ2v2M3kUsYWJk/WwCw8Nr8QWi
         gSQg==
X-Gm-Message-State: AOAM531qYzFkjs/cNcs+luy4Srqe9yCiG7hbfpH3lz5eKgsmLIfUI1Me
        57jZazpLXXRqKDGox6wTikM=
X-Google-Smtp-Source: ABdhPJyWxAEUuOiZy6bVW4XMk+eVooJFyZH21j3Xd/9Gl2LbqV14uONHRevzcjGBWYX2qj7v3G+8ww==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr14432056ejc.334.1647722309966;
        Sat, 19 Mar 2022 13:38:29 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id k7-20020aa7c047000000b004132d3b60aasm5888884edo.78.2022.03.19.13.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:38:29 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Fei Li <fei1.li@intel.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] virt: acrn: fix invalid check past list iterator
Date:   Sat, 19 Mar 2022 21:38:19 +0100
Message-Id: <20220319203819.2559993-1-jakobkoschel@gmail.com>
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

The condition retry == 0 is theoretically possible even if 'client'
does not point to a valid element because no break was hit.

To only execute the dev_warn if actually a break within the loop was
hit, a separate variable is used that is only set if it is ensured to
point to a valid client struct.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/virt/acrn/ioreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 5ff1c53740c0..bdf7cedce926 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -211,7 +211,7 @@ static int ioreq_task(void *data)
  */
 void acrn_ioreq_request_clear(struct acrn_vm *vm)
 {
-	struct acrn_ioreq_client *client;
+	struct acrn_ioreq_client *client, *iter;
 	bool has_pending = false;
 	unsigned long vcpu;
 	int retry = 10;
@@ -228,17 +228,20 @@ void acrn_ioreq_request_clear(struct acrn_vm *vm)
 	 */
 	do {
 		spin_lock_bh(&vm->ioreq_clients_lock);
-		list_for_each_entry(client, &vm->ioreq_clients, list) {
-			has_pending = has_pending_request(client);
-			if (has_pending)
+		client = NULL;
+		list_for_each_entry(iter, &vm->ioreq_clients, list) {
+			has_pending = has_pending_request(iter);
+			if (has_pending) {
+				client = iter;
 				break;
+			}
 		}
 		spin_unlock_bh(&vm->ioreq_clients_lock);

 		if (has_pending)
 			schedule_timeout_interruptible(HZ / 100);
 	} while (has_pending && --retry > 0);
-	if (retry == 0)
+	if (client)
 		dev_warn(acrn_dev.this_device,
 			 "%s cannot flush pending request!\n", client->name);


base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--
2.25.1

