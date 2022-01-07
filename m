Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50F64871DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbiAGEqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:46:30 -0500
Received: from mail.loongson.cn ([114.242.206.163]:57962 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230171AbiAGEq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:46:29 -0500
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz8uHxddhaFsAAA--.1704S2;
        Fri, 07 Jan 2022 12:46:16 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ye Guojin <ye.guojin@zte.com.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] signal: strict valid signal check
Date:   Fri,  7 Jan 2022 12:45:57 +0800
Message-Id: <1641530757-3835-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dxz8uHxddhaFsAAA--.1704S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryrZFWDCryrGFW5GF1kuFg_yoWDZFb_uF
        1rtF4IgF4xZ3Z7u34jqrZIvF4fGa4UJ3WrWas3KrWjq3s8ArWjqas7KFyDXFWUWayvyFyD
        Wan3W34xWr1YgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVCm-wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2JKsUUUUU
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max usable signal number is limited by both _NSIG and task's
exit_code, and the max valid signal number encoded in task's
exit_code is 127. On the other hand _NSIG is normally power of 2,
so limit the rule in valid_signal to check a valid signal number.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 include/linux/signal.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index a6db6f2..9f1972e 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -270,7 +270,11 @@ static inline void init_sigpending(struct sigpending *sig)
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
 {
-	return sig <= _NSIG ? 1 : 0;
+	/* max usable signal number is limited by both _NSIG and task's
+	 * exit_code, and the max available signal number encoded in
+	 * task's exit_code is 127.
+	 */
+	return sig <= min(_NSIG, 127) ? 1 : 0;
 }
 
 struct timespec;
-- 
1.8.3.1

