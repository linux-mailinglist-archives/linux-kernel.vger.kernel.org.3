Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295957FB10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGYIOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:14:24 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBBD213EAD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:14:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id ECBC31E80D0F;
        Mon, 25 Jul 2022 16:09:22 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Smo7lWQaXMIL; Mon, 25 Jul 2022 16:09:20 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id BFA151E80D05;
        Mon, 25 Jul 2022 16:09:19 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     liqiong@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: [PATCH 3/3] lkdtm/heap: Check possible NULL pointer returned by vzalloc()
Date:   Mon, 25 Jul 2022 16:13:31 +0800
Message-Id: <20220725081331.21014-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible alloc failure of the vzalloc(),the
return pointer could be NULL.therefore it should be better to check it.

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 drivers/misc/lkdtm/heap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 62516078a619..399cdbbfd5b7 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -33,9 +33,13 @@ static void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
 	one = vzalloc(PAGE_SIZE);
 	two = vzalloc(PAGE_SIZE);
 
+	if (!one || !two)
+		goto free_kernel;
+
 	pr_info("Attempting vmalloc linear overflow ...\n");
 	memset(one, 0xAA, PAGE_SIZE + __offset);
 
+free_kernel:
 	vfree(two);
 	vfree(one);
 }
-- 
2.11.0

