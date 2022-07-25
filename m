Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12457FB03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiGYINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGYINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:13:02 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D73313CEC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:13:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 9C8431E80D0F;
        Mon, 25 Jul 2022 16:08:00 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gGgk4OeEg4Bp; Mon, 25 Jul 2022 16:07:58 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 71D7B1E80D05;
        Mon, 25 Jul 2022 16:07:57 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     liqiong@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: [PATCH 2/3] lkdtm/perms: Check possible NULL pointer returned by kmalloc(),vmalloc()
Date:   Mon, 25 Jul 2022 16:11:53 +0800
Message-Id: <20220725081153.20228-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible alloc failure of the kmalloc() and vmalloc(),the
return pointer could be NULL.therefore it should be better to check it.

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 drivers/misc/lkdtm/perms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index b93404d65650..34b43b9ea1f1 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -180,6 +180,9 @@ static void lkdtm_EXEC_STACK(void)
 static void lkdtm_EXEC_KMALLOC(void)
 {
 	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
+	if (!kmalloc_area)
+		return;
+
 	execute_location(kmalloc_area, CODE_WRITE);
 	kfree(kmalloc_area);
 }
@@ -187,6 +190,9 @@ static void lkdtm_EXEC_KMALLOC(void)
 static void lkdtm_EXEC_VMALLOC(void)
 {
 	u32 *vmalloc_area = vmalloc(EXEC_SIZE);
+	if (!vmalloc_area)
+		return;
+
 	execute_location(vmalloc_area, CODE_WRITE);
 	vfree(vmalloc_area);
 }
-- 
2.11.0

