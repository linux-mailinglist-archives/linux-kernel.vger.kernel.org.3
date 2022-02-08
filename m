Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E704AE23D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386035AbiBHT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbiBHT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:28:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B5C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B3D6B81D1C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88776C004E1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644348535;
        bh=VMSknEIfxSbX3tRwp+KwIrJcLUesBpLa6Ad5UvGTqN8=;
        h=From:To:Subject:Date:From;
        b=ThKIFjRVDc/n0/1wRqhEaQrWHvbNQwBosRGQ5TcTmJZrwjR4UdMbwmIW67JTBwH6l
         L8jgD355l9dWJhMkyjus1xReEBA/Tu4IvEkiMReHto/B96dx8+GlV5Q/5udVfICmo9
         BX+NEVWl4t2J9e8GzM9fwN8KX3IsxQgEB2xK2ocxlDRKozXFD6n/uTwIhnCx9zxqQK
         grbDMX2aqKaPutzZg6dv+MBu4trDEP9ME3atXoLbFKojSca6aTFuD3V43t43vVUsqX
         dX0J9gPAQbVrtbhPjBoTTq8juy0QUBih10unCkHuWNdJs46CrspyRrPzGRrz9I4O0D
         PaW3DP9FZqLMg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] habanalabs: change function to static
Date:   Tue,  8 Feb 2022 21:28:47 +0200
Message-Id: <20220208192850.3526511-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_registration_node() is called directly from the irq handler
in irq.c, so it can be static.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index c28f3a1c7a03..e2bc128f2291 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -175,7 +175,7 @@ static void hl_ts_free_objects(struct work_struct *work)
  * so here we'll be filling a list with nodes of "put" jobs and then will send this
  * list to a dedicated workqueue to do the actual put.
  */
-int handle_registration_node(struct hl_device *hdev, struct hl_user_pending_interrupt *pend,
+static int handle_registration_node(struct hl_device *hdev, struct hl_user_pending_interrupt *pend,
 						struct list_head **free_list)
 {
 	struct timestamp_reg_free_node *free_node;
-- 
2.25.1

