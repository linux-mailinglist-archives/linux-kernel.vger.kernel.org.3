Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138794E5F50
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348515AbiCXH1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiCXH06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:26:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3382986F4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:25:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qa43so7283438ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouqixWTewNUXByCDOAWSWsgjahXSnZ2j4PO6S0OVSBc=;
        b=cFugzm9zbfF2ycvf5BO0ObBa7AQEVHzluHn+MgplO8ys+X0ReVhk3ZOkfYRfFH4yH6
         YKk3XkBP3jZQIDY3wu5m9xl/XGIwMgjbeSsZznDQ6FDQMdc8mDvHDKrUx6RRvDYu0UYX
         Xjn7GgPG/xKghClCJY6FIUAoq6WusLrrVglke8puMsBnaudwanX8vFEkvBChz2Wjj4+X
         7Zjj795X79I8/brB6mIYiRu84KYvW0+2I1R8cSMFUiETvoPkRAt1RTMxxuUObnP0rAIk
         QnoChzCHgwQzx9b4eMHbkDxvQ4/00+NTAsuCzdI4N75XyCfbJdAh7cTQgns+0lOgS2JX
         GTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouqixWTewNUXByCDOAWSWsgjahXSnZ2j4PO6S0OVSBc=;
        b=pd4WwQyJg5bpFNIS02fzytHfKdeULueiSsUOXFD8nR1i345kc6EnJb3RGMPLfRZZ8D
         G3oiq6MwROPVhNynOHFnsBYBLXj0Kzhgr+ZT7dSSSvNLXKPx56IlmbtMLUZBkPXbbiY+
         1gKCjcXNUoEqhf3PL1LQRKa9xwqb6mhlW7eyY+xbc8Tfpjzx7mXaOYbPOpPCrGOG/1Db
         IB1PiBnj7xiDSwYoyxY5MMkytIyI1pQOC9qfNsC7EavZ4Od8XuZz60FCZRr4VX6u22C2
         8NLEApO9Bkvyt4d3+MvFHmhoKvnX2rbosMCqLkXqTvDHMdttqYOY8k2MAmrzuDp1fWuz
         SSbg==
X-Gm-Message-State: AOAM533TLMTyccAxXCqf8lfkBcqWGrVgqLOSmdo192xQ7sO+ARUS0M5d
        P2NWvvTFMMK3BCPtYzij8vA=
X-Google-Smtp-Source: ABdhPJymiAUK06LZKJny7ktqc+xqUskTkOYeuSIDIZ3/CIN69MSr8832ZMuYZAJUQCPnZU2QfZwgDg==
X-Received: by 2002:a17:907:1dc8:b0:6df:f5fc:f4f9 with SMTP id og8-20020a1709071dc800b006dff5fcf4f9mr4169480ejc.739.1648106725293;
        Thu, 24 Mar 2022 00:25:25 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id l9-20020a1709060cc900b006ce04bb8668sm765382ejh.184.2022.03.24.00.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:25:24 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] soc: ti: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:25:03 +0100
Message-Id: <20220324072503.63244-1-jakobkoschel@gmail.com>
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
 drivers/soc/ti/knav_dma.c        | 26 ++++++++++++--------------
 drivers/soc/ti/knav_qmss_queue.c | 16 +++++++---------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 700d8eecd8c4..7e126a73e56e 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -415,9 +415,8 @@ static int of_channel_match_helper(struct device_node *np, const char *name,
 void *knav_dma_open_channel(struct device *dev, const char *name,
 					struct knav_dma_cfg *config)
 {
-	struct knav_dma_chan *chan;
-	struct knav_dma_device *dma;
-	bool found = false;
+	struct knav_dma_device *dma = NULL, *iter1;
+	struct knav_dma_chan *chan = NULL, *iter2;
 	int chan_num = -1;
 	const char *instance;
 
@@ -444,33 +443,32 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	}
 
 	/* Look for correct dma instance */
-	list_for_each_entry(dma, &kdev->list, list) {
-		if (!strcmp(dma->name, instance)) {
-			found = true;
+	list_for_each_entry(iter1, &kdev->list, list) {
+		if (!strcmp(iter1->name, instance)) {
+			dma = iter1;
 			break;
 		}
 	}
-	if (!found) {
+	if (!dma) {
 		dev_err(kdev->dev, "No DMA instance with name %s\n", instance);
 		return (void *)-EINVAL;
 	}
 
 	/* Look for correct dma channel from dma instance */
-	found = false;
-	list_for_each_entry(chan, &dma->chan_list, list) {
+	list_for_each_entry(iter2, &dma->chan_list, list) {
 		if (config->direction == DMA_MEM_TO_DEV) {
-			if (chan->channel == chan_num) {
-				found = true;
+			if (iter2->channel == chan_num) {
+				chan = iter2;
 				break;
 			}
 		} else {
-			if (chan->flow == chan_num) {
-				found = true;
+			if (iter2->flow == chan_num) {
+				chan = iter2;
 				break;
 			}
 		}
 	}
-	if (!found) {
+	if (!chan) {
 		dev_err(kdev->dev, "channel %d is not in DMA %s\n",
 				chan_num, instance);
 		return (void *)-EINVAL;
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 2ac3856b8d42..4dbaa8c3636c 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -758,10 +758,9 @@ void *knav_pool_create(const char *name,
 					int num_desc, int region_id)
 {
 	struct knav_region *reg_itr, *region = NULL;
-	struct knav_pool *pool, *pi;
+	struct knav_pool *pool, *pi = NULL, *iter;
 	struct list_head *node;
 	unsigned last_offset;
-	bool slot_found;
 	int ret;
 
 	if (!kdev)
@@ -816,18 +815,17 @@ void *knav_pool_create(const char *name,
 	 * the request
 	 */
 	last_offset = 0;
-	slot_found = false;
 	node = &region->pools;
-	list_for_each_entry(pi, &region->pools, region_inst) {
-		if ((pi->region_offset - last_offset) >= num_desc) {
-			slot_found = true;
+	list_for_each_entry(iter, &region->pools, region_inst) {
+		if ((iter->region_offset - last_offset) >= num_desc) {
+			pi = iter;
 			break;
 		}
-		last_offset = pi->region_offset + pi->num_desc;
+		last_offset = iter->region_offset + iter->num_desc;
 	}
-	node = &pi->region_inst;
 
-	if (slot_found) {
+	if (pi) {
+		node = &pi->region_inst;
 		pool->region = region;
 		pool->num_desc = num_desc;
 		pool->region_offset = last_offset;

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

