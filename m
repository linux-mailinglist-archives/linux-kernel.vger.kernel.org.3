Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE74EE3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiCaWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiCaWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:07:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B232102AA;
        Thu, 31 Mar 2022 15:05:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z92so829808ede.13;
        Thu, 31 Mar 2022 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ho9jg4pQwI43mh2smbjNNYfVQlK85ymR2bcGPQmzEU=;
        b=TGeR34J+02kbkPsHkSSgqp7sHsJXw5OIEwemL78K4n/ObMV856TJBti1bvbKgUeKQg
         mnlVUl6utz5rdQjEoK7zAt8Ul/3fBsOyMmW4aAnvXAnWMw2DIPyj62tKAAIBoV0kOiCT
         FZfMn8Bue+cYPnBEpr5adaZWrYoZNJn49A711nVvaLcKjbpNbZo6ybimlyH6l4UBJIUP
         08kWipvb4yNxZFsB3c4BI8A1a1Wnw389tVd/BfjiAHUfC1UERENV5KtWX4jy0Yhh9okW
         9lpZhHNPMERB5zgnJEWmQBLEms4eZwf4pFxlyg53mvPPHxFgPsFXyzol9NBmhWPdFEDg
         s1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ho9jg4pQwI43mh2smbjNNYfVQlK85ymR2bcGPQmzEU=;
        b=0aRNEheo6snnB7QtgswM8gqZxitdzVItrYHHe+wlRCqgFjJuCriLvLHxc54hUF/7zL
         tsYkhC/NK7J7nyih0N0pYbWQQ1c1Awuvh85Co2KXjryam3t5dicPFavx5YjmNBpNVh+J
         K07+lZG3Zrqq99Gcd48JjnKtC9WQJmsQGZmkr9Jzr0xYuXWko55TjQ+vK3bdm5P8cUot
         ZJD904YMiLSC9te113r8ExnhQUdFIC7Bv0C220YzlPaaIZ+3ablp1AaNd6UlEqcLF0Ty
         4smnrH4biovM4GdAEXWArWwjVrg2uMHg1XsI4+h6/JHKiVjWu2ltoteSQS7YFP1SikW+
         RbwA==
X-Gm-Message-State: AOAM530WsKMk2moQ3tQi2P/bjg+He+6L1j2Q6PorPXSOWgVQT95Xwyql
        l+s2oQKsoYxXhj+VOvJoELs=
X-Google-Smtp-Source: ABdhPJxShOKbJ4iBsD8bocoidzsE4n6V+HgZS/4jKAfFsKZmUCc4WqDot638Q5DB+rvQu04qJm8tsQ==
X-Received: by 2002:a05:6402:1107:b0:416:439a:6a9e with SMTP id u7-20020a056402110700b00416439a6a9emr18117030edv.382.1648764354432;
        Thu, 31 Mar 2022 15:05:54 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id o2-20020a50d802000000b00410d7f0c52csm321110edj.8.2022.03.31.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:05:54 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] drbd: remove usage of list iterator variable after loop for list_for_each_entry_safe_from()
Date:   Fri,  1 Apr 2022 00:03:48 +0200
Message-Id: <20220331220349.885126-1-jakobkoschel@gmail.com>
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

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to iterate through the list [1].

Since that variable should not be used past the loop iteration, a
separate variable is used to 'remember the current location within the
loop'.

To either continue iterating from that position or skip the iteration
(if the previous iteration was complete) list_prepare_entry() is used.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 96881d5babd9..9676a1d214bc 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -171,7 +171,7 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 		unsigned int set_size)
 {
 	struct drbd_request *r;
-	struct drbd_request *req = NULL;
+	struct drbd_request *req = NULL, *tmp = NULL;
 	int expect_epoch = 0;
 	int expect_size = 0;
 
@@ -225,8 +225,11 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 	 * to catch requests being barrier-acked "unexpectedly".
 	 * It usually should find the same req again, or some READ preceding it. */
 	list_for_each_entry(req, &connection->transfer_log, tl_requests)
-		if (req->epoch == expect_epoch)
+		if (req->epoch == expect_epoch) {
+			tmp = req;
 			break;
+		}
+	req = list_prepare_entry(tmp, &connection->transfer_log, tl_requests);
 	list_for_each_entry_safe_from(req, r, &connection->transfer_log, tl_requests) {
 		if (req->epoch != expect_epoch)
 			break;

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

