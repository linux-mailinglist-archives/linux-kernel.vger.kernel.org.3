Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F42570A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiGKTO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGKTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:14:55 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E26170C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:14:53 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AyrqoouphN260AyrqoBJrn; Mon, 11 Jul 2022 21:14:52 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 11 Jul 2022 21:14:52 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] cxl: Fix a memory leak in an error handling path
Date:   Mon, 11 Jul 2022 21:14:48 +0200
Message-Id: <ce5869418f5838187946eb6b11a52715a93ece3d.1657566849.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <59010cc7c62443030c69cb1ce0b2b62c5d47e064.1657566849.git.christophe.jaillet@wanadoo.fr>
References: <59010cc7c62443030c69cb1ce0b2b62c5d47e064.1657566849.git.christophe.jaillet@wanadoo.fr>
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

A bitmap_zalloc() must be balanced by a corresponding bitmap_free() in the
error handling path of afu_allocate_irqs().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The error handling path should be done in the reversed order but it should
work as-is.
---
 drivers/misc/cxl/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 0ce91d99aead..b730e022a48e 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -349,6 +349,7 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 
 out:
 	cxl_ops->release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
+	bitmap_free(ctx->irq_bitmap);
 	afu_irq_name_free(ctx);
 	return -ENOMEM;
 }
-- 
2.34.1

