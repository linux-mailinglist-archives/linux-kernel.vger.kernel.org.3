Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC4571603
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiGLJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiGLJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:45:03 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D418AAA75B;
        Tue, 12 Jul 2022 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9HVer
        fBt+Non2O0XiWT1ENnNQ3VPbM2dwQNWx6VdMKg=; b=EN3pH8pn5iLjcD4s8hxdX
        Rrc9cVT7s/SHBxF7cehrDdgOe7KZ1OsCXBqyxjBFkM8ekKGK9ezo7D95HVtoey5U
        Jj1tyDLeba9H3VGZ+wRy4vKj1h1Br1xieLAuDpDZmOrJ8B/knFlR4RjIkOQXCX5z
        XVOA4q3zXmwpkZyY28kLIw=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp14 (Coremail) with SMTP id EsCowAC3IPd6Qs1iG8QrMg--.48916S2;
        Tue, 12 Jul 2022 17:44:29 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] mtip32xx: replace ternary operator with min_t()
Date:   Tue, 12 Jul 2022 17:43:50 +0800
Message-Id: <20220712094350.1379942-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAC3IPd6Qs1iG8QrMg--.48916S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW3Wry7ur4xuFyktryUGFg_yoW8AF4kpF
        n5Xay8Ar12kF17XF4jkw4DKa4fWwn8Jry8Wa4093WUuF9Yyrs2gFZ8Ca45GF4fJr4jqFZr
        JFn2krn8JF48uw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhJ5rUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBAh08+2B0IizjagAAsL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

drivers/block/mtip32xx/mtip32xx.c:2264: WARNING opportunity for min().
drivers/block/mtip32xx/mtip32xx.c:2328: WARNING opportunity for min().
drivers/block/mtip32xx/mtip32xx.c:2357: WARNING opportunity for min().

min_t() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/block/mtip32xx/mtip32xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 27386a572ba4..ef6bc68f86a3 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2261,7 +2261,7 @@ static ssize_t mtip_hw_read_device_status(struct file *f, char __user *ubuf,
 
 	size += show_device_status(NULL, buf);
 
-	*offset = size <= len ? size : len;
+	*offset = min_t(size_t, size, len);
 	size = copy_to_user(ubuf, buf, *offset);
 	if (size)
 		rv = -EFAULT;
@@ -2325,7 +2325,7 @@ static ssize_t mtip_hw_read_registers(struct file *f, char __user *ubuf,
 	}
 	size += sprintf(&buf[size], "]\n");
 
-	*offset = size <= len ? size : len;
+	*offset = min_t(size_t, size, len);
 	size = copy_to_user(ubuf, buf, *offset);
 	if (size)
 		rv = -EFAULT;
@@ -2354,7 +2354,7 @@ static ssize_t mtip_hw_read_flags(struct file *f, char __user *ubuf,
 	size += sprintf(&buf[size], "Flag-dd   : [ %08lX ]\n",
 							dd->dd_flag);
 
-	*offset = size <= len ? size : len;
+	*offset = min_t(size_t, size, len);
 	size = copy_to_user(ubuf, buf, *offset);
 	if (size)
 		rv = -EFAULT;
-- 
2.25.1

