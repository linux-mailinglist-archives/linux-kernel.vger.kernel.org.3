Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8B5A4355
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiH2Gfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiH2Gfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:35:33 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E5A91402A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:35:32 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:58254.465013519
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 47BFB1002C5;
        Mon, 29 Aug 2022 14:35:30 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-84fc4d489d-2xtjd with ESMTP id d5b1e1b832374690908240b4c2875a1c for karolinadrobnik@gmail.com;
        Mon, 29 Aug 2022 14:35:31 CST
X-Transaction-ID: d5b1e1b832374690908240b4c2875a1c
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     karolinadrobnik@gmail.com, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/2] tools/testing/memblock: define pr_warn_ratelimited
Date:   Mon, 29 Aug 2022 14:39:00 +0800
Message-Id: <1661755140-3331-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 14d9a675fd0d("mm: Ratelimited mirrored memory related warning
messages") introduced pr_warn_ratelimited in memblock.c, which breaks
tools/test/memblock, below is the message:

/usr/bin/ld: memblock.o: in function `memblock_find_in_range.constprop.0':
memblock.c:(.text+0x4603): undefined reference to `pr_warn_ratelimited'
/usr/bin/ld: memblock.o: in function `memblock_alloc_range_nid':
memblock.c:(.text+0x786a): undefined reference to `pr_warn_ratelimited'
collect2: error: ld returned 1 exit status

A fake pr_warn_ratelimited needs to be defined in printk.h like other
prink functions.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 tools/testing/memblock/linux/printk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/memblock/linux/printk.h b/tools/testing/memblock/linux/printk.h
index 61af424d8c6c..bdca5eedbe4c 100644
--- a/tools/testing/memblock/linux/printk.h
+++ b/tools/testing/memblock/linux/printk.h
@@ -21,5 +21,6 @@
 #define pr_cont printk
 #define pr_err printk
 #define pr_warn printk
+#define pr_warn_ratelimited printf
 
 #endif
-- 
2.25.1

