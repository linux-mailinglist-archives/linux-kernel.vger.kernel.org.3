Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C87581DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiG0CkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiG0CkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:40:04 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2DD2AE13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:40:03 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:58884.1399291843
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 3C4E42800C7;
        Wed, 27 Jul 2022 10:40:00 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 2b7d904dc65145129e784465f3b5ed12 for rppt@kernel.org;
        Wed, 27 Jul 2022 10:40:03 CST
X-Transaction-ID: 2b7d904dc65145129e784465f3b5ed12
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     rppt@kernel.org, mawupeng1@huawei.com, jrdr.linux@gmail.com,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v3] memblock tests: compiling error
Date:   Wed, 27 Jul 2022 10:39:45 +0800
Message-Id: <1658889585-20778-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock.o: In function `memblock_find_in_range.constprop.9':
memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
memblock.o: In function `memblock_mark_mirror':
memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'

Fixes: 902c2d91582c ("memblock: Disable mirror feature if kernelcore is not specified")
Fixes: 14d9a675fd0d ("mm: Ratelimited mirrored memory related warning messages")

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
Tested-by: Ma Wupeng <mawupeng1@huawei.com>
---
 tools/testing/memblock/internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index c2a492c05e0c..fdb7f5db7308 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -9,6 +9,10 @@
 static int memblock_debug = 1;
 #endif
 
+#define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__)
+
+bool mirrored_kernelcore = false;
+
 struct page {};
 
 void memblock_free_pages(struct page *page, unsigned long pfn,
-- 
1.8.3.1

