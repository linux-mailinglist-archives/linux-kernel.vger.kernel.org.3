Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2873155AA29
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiFYM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiFYM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:56:01 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D6E12D09
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:56:01 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 55KQonppmZfs855KQoIbv6; Sat, 25 Jun 2022 14:55:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 14:55:59 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/3] memstick/ms_block: Fix a memory leak
Date:   Sat, 25 Jun 2022 14:55:56 +0200
Message-Id: <b3b78926569445962ea5c3b6e9102418a9effb88.1656155715.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
References: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'erased_blocks_bitmap' is never freed. As it is allocated at the same time
as 'used_blocks_bitmap', it is likely that it should be freed also at the
same time.

Add the corresponding bitmap_free() in msb_data_clear().

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative.
---
 drivers/memstick/core/ms_block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index f8f151163667..f8fdf88fb240 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1947,6 +1947,7 @@ static void msb_data_clear(struct msb_data *msb)
 {
 	kfree(msb->boot_page);
 	bitmap_free(msb->used_blocks_bitmap);
+	bitmap_free(msb->erased_blocks_bitmap);
 	kfree(msb->lba_to_pba_table);
 	kfree(msb->cache);
 	msb->card = NULL;
-- 
2.34.1

