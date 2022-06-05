Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614EA53DB43
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351046AbiFEKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347671AbiFEKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:33:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F7205FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EBEEB80CB1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C270C385A5;
        Sun,  5 Jun 2022 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654425207;
        bh=nJtlFK4+nEL//62GhVnPMcX7A25SA2AYpOqBXZFPkfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccULnXpZmLvEDaX0KNWfzlwMIqWHhjylkkuxXF402u4QeXz+x47UbHvM6dcCse2R0
         cJqzYixgNGOg9BGx3VzunZdrwsxtzExHhXpHFZVL2TeQnMD7DtRehiaNMTh9pEln42
         Y9Wk+aRIbOYBmLTEDgLKi+hDMcba0psuQFNBlLlSHwwDe5wBZweD1cmTReL4xKuLCS
         8FV8meeUH0NoNSG/zmTcugkTUPWsczQ1vvOGIhIFaXVzFYB2w+4oWPiDbV2DOO97Ac
         l3/oDBSca0f/BIGuBokMh7EZhJCsWXr+eoQsvDrBPxCtvxqf/CGYmBLTOf4Mty6EaH
         wziIRxj9mU9dQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 5/7] habanalabs/gaudi: fix comment to reflect current code
Date:   Sun,  5 Jun 2022 13:33:14 +0300
Message-Id: <20220605103316.3414541-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605103316.3414541-1-ogabbay@kernel.org>
References: <20220605103316.3414541-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to code changes in the past few years, the original comment of
how parser->user_cb_size is checked was not correct anymore.

Fix it to reflect current code and add more explanation as the code
is more complex now.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c16c0f9fe202..72b0d145e853 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5562,8 +5562,14 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	}
 
 	/*
-	 * The check that parser->user_cb_size <= parser->user_cb->size was done
-	 * in validate_queue_index().
+	 * We are protected from overflow because the check
+	 * "parser->user_cb_size <= parser->user_cb->size" was done in get_cb_from_cs_chunk()
+	 * in the common code. That check is done only if is_kernel_allocated_cb is true.
+	 *
+	 * There is no option to reach here without going through that check because:
+	 * 1. validate_queue_index() assigns true to is_kernel_allocated_cb for any submission to
+	 *    an external queue.
+	 * 2. For Gaudi, we only parse CBs that were submitted to the external queues.
 	 */
 	memcpy(parser->patched_cb->kernel_address,
 		parser->user_cb->kernel_address,
-- 
2.25.1

