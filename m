Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD754F61E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiDFOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiDFO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:29:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BAA5504BCB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:48:10 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxusyWa01iAhAZAA--.30206S3;
        Wed, 06 Apr 2022 18:29:42 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ptrace: Remove redudant check of #ifdef PTRACE_SINGLESTEP
Date:   Wed,  6 Apr 2022 18:29:39 +0800
Message-Id: <1649240981-11024-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1649240981-11024-1-git-send-email-yangtiezhu@loongson.cn>
References: <1649240981-11024-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9AxusyWa01iAhAZAA--.30206S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1rury8Ar13tw4fJr1rCrg_yoWDGrc_uF
        1a9wnrGryUWr1I9a1Ygr4kG3yUtw4aqF40v3WUCFWUJ3WDKr45J3WjgasxWFZxWw40vFy5
        Xws7GF93K3WYkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbf8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY
        1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8twCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8pHq7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_SINGLESTEP is always defined as 9 in include/uapi/linux/ptrace.h,
remove redudant check of #ifdef PTRACE_SINGLESTEP.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/ptrace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index ccc4b46..49c29ba 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -829,11 +829,7 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
 }
 #endif
 
-#ifdef PTRACE_SINGLESTEP
 #define is_singlestep(request)		((request) == PTRACE_SINGLESTEP)
-#else
-#define is_singlestep(request)		0
-#endif
 
 #ifdef PTRACE_SINGLEBLOCK
 #define is_singleblock(request)		((request) == PTRACE_SINGLEBLOCK)
@@ -1221,9 +1217,7 @@ int ptrace_request(struct task_struct *child, long request,
 	}
 #endif
 
-#ifdef PTRACE_SINGLESTEP
 	case PTRACE_SINGLESTEP:
-#endif
 #ifdef PTRACE_SINGLEBLOCK
 	case PTRACE_SINGLEBLOCK:
 #endif
-- 
2.1.0

