Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087C553DAE1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350856AbiFEImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:41:59 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA8F22F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dgTai
        pyhTS3VeOs8/cT4Gxe8QzvPZ0lNBUbKXaDbHyE=; b=hlgcnbMUxsoXXj7mMaeE9
        5VHFi7IOEdNLeFs5Tc51rmDZLREulvQJ+g7GtHKk53Qikxl6C4+oaZxD1ZBTr88O
        IgOkG3Z+koj51nb2PRGOu2lX8g9jy7gqz3zw3jUTcvxKH7e5RolDkeTIxOaXuTI/
        7nLOh71N+EnSX+UI4tFAUI=
Received: from localhost.localdomain (unknown [1.203.64.79])
        by smtp7 (Coremail) with SMTP id C8CowABXxZUcbJxirFxWGQ--.2150S4;
        Sun, 05 Jun 2022 16:41:18 +0800 (CST)
From:   jingyuwang <jingyuwang_vip@163.com>
To:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jingyuwang <jingyuwang_vip@163.com>
Subject: [PATCH] printk: change type of cpu_possible_bits to __cpu_possible_mask
Date:   Sun,  5 Jun 2022 16:40:58 +0800
Message-Id: <20220605084058.17708-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABXxZUcbJxirFxWGQ--.2150S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF43trWUJrWkKw15KrWxJFb_yoWfCFbEvF
        9avrnrKF17G3s2gr17AF43Jr9xta97JFn7K3sakF9Iyr1DJr13tanrJFnxZrn5GrZagFy8
        ZFW3uw1qkFsxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZGYl3UUUUU==
X-Originating-IP: [1.203.64.79]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCbgYXF2BbENzw1wAAs4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.type of cpu_possible_bits is changed,refer to commit c4c54dd1caf1
 ("kernel/cpu.c: change type of cpu_possible_bits and friends").
2.set_cpu_possible() before setup_arch().

Signed-off-by: jingyuwang <jingyuwang_vip@163.com>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea3dd55709e7..25670186d12e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1144,8 +1144,8 @@ static void __init log_buf_add_cpu(void)
 	unsigned int cpu_extra;
 
 	/*
-	 * archs should set up cpu_possible_bits properly with
-	 * set_cpu_possible() after setup_arch() but just in
+	 * archs should set up __cpu_possible_mask properly with
+	 * set_cpu_possible() before setup_arch() but just in
 	 * case lets ensure this is valid.
 	 */
 	if (num_possible_cpus() == 1)
-- 
2.34.1

