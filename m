Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4A5B09E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIGQP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiIGQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:15:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C16D8048B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1673DB81E15
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC979C4347C;
        Wed,  7 Sep 2022 16:15:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oVxik-00CsXi-22;
        Wed, 07 Sep 2022 12:16:10 -0400
Message-ID: <20220907161610.465598539@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Sep 2022 12:15:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 7/7] rv/reactor: add __init/__exit annotations to module init/exit funcs
References: <20220907161511.694486342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Add missing __init/__exit annotations to module init/exit funcs.

Link: https://lkml.kernel.org/r/20220906141210.132607-1-xiujianfeng@huawei.com

Fixes: 135b881ea885 ("rv/reactor: Add the printk reactor")
Fixes: e88043c0ac16 ("rv/reactor: Add the panic reactor")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/reactor_panic.c  | 4 ++--
 kernel/trace/rv/reactor_printk.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index b698d05dd069..d65f6c25a87c 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -24,13 +24,13 @@ static struct rv_reactor rv_panic = {
 	.react = rv_panic_reaction
 };
 
-static int register_react_panic(void)
+static int __init register_react_panic(void)
 {
 	rv_register_reactor(&rv_panic);
 	return 0;
 }
 
-static void unregister_react_panic(void)
+static void __exit unregister_react_panic(void)
 {
 	rv_unregister_reactor(&rv_panic);
 }
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 31899f953af4..4b6b7106a477 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -23,13 +23,13 @@ static struct rv_reactor rv_printk = {
 	.react = rv_printk_reaction
 };
 
-static int register_react_printk(void)
+static int __init register_react_printk(void)
 {
 	rv_register_reactor(&rv_printk);
 	return 0;
 }
 
-static void unregister_react_printk(void)
+static void __exit unregister_react_printk(void)
 {
 	rv_unregister_reactor(&rv_printk);
 }
-- 
2.35.1
