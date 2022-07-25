Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEE57FAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiGYILK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGYILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:11:08 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 359D513D7B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:11:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 1D4D51E80D8E;
        Mon, 25 Jul 2022 16:06:06 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DCc9ceQMea6A; Mon, 25 Jul 2022 16:06:03 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E282C1E80D89;
        Mon, 25 Jul 2022 16:06:02 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     liqiong@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: [PATCH 1/3] lkdtm/fortify: Check possible NULL pointer returned by kmalloc()
Date:   Mon, 25 Jul 2022 16:10:00 +0800
Message-Id: <20220725081000.19407-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible alloc failure of the kmalloc(),the return pointer
could be NULL,therefore it should be better to check it.

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 drivers/misc/lkdtm/fortify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 080293fa3c52..5d70c5ef918b 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -41,6 +41,9 @@ static void lkdtm_FORTIFIED_SUBOBJECT(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
-- 
2.11.0

