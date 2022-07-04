Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F61A5653E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiGDLls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiGDLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:41:45 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471391
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:41:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VILd0lZ_1656934899;
Received: from localhost(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VILd0lZ_1656934899)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 19:41:42 +0800
From:   Kaihao Bai <carlo.bai@linux.alibaba.com>
To:     ebiederm@xmission.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, carlo.bai@linux.alibaba.com
Subject: [PATCH 1/2] kexec: accumulate kexec_crash_size if crashk_low_res defined
Date:   Mon,  4 Jul 2022 19:41:34 +0800
Message-Id: <1656934895-12334-2-git-send-email-carlo.bai@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently x86 and arm64 support to reserve low memory range for
crashkernel. When crashkernel=Y,low is defined, the main kernel would
reserve another memblock (instead of crashkernel=X,high, which stored
in crashk_res) for crashkernel and store it in crashk_low_res. But
the value of /sys/kernel/kexec_crash_size only calculates the size of
crashk_res size is not calculated.

To ensure the consistency of /sys/kernel/kexec_crash_size, when
crashk_low_res is defined, its size needs to be accumulated to
kexec_crash_size.

Signed-off-by: Kaihao Bai <carlo.bai@linux.alibaba.com>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78..137f6eb 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1016,6 +1016,8 @@ size_t crash_get_memory_size(void)
 	mutex_lock(&kexec_mutex);
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
+	if (crashk_low_res.end != crashk_low_res.start)
+		size += resource_size(&crashk_low_res);
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
-- 
1.8.3.1

