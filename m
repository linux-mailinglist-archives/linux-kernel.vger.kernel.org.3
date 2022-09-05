Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF45AD49F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiIEOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiIEOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:19:14 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C2B564D2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Wlj2+
        degXH+iEC0bffOo5ceIWENK7IpGnLJ5xjDb3JI=; b=n9vkRqF8UuCxLCetJsYXO
        uDccjUofUwUVfrJvltvAZDqrDFkmZuuSBflRJP5gSNlEffzC3px/K2oidnSDbNw3
        y8yaCHpovxqbzmyrmZFPYtoUwCPtmT6xj0Bwll3YXhedyPXF15Qf3e7e7aWPik8c
        7GsD2SH3agguLVTMI4Vkgw=
Received: from localhost.localdomain (unknown [180.113.78.212])
        by smtp2 (Coremail) with SMTP id DMmowABntbE+BRZjKFbBAw--.25777S2;
        Mon, 05 Sep 2022 22:18:39 +0800 (CST)
From:   wonder_rock@126.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     frederic@kernel.org, ardb@kernel.org, wonder_rock@126.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: preempt: Add NEED_RESCHED to the preempt_count()
Date:   Mon,  5 Sep 2022 22:18:29 +0800
Message-Id: <20220905141829.28605-1-wonder_rock@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowABntbE+BRZjKFbBAw--.25777S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry5JF18WryxArW8Xry3twb_yoW3AFgEyw
        1fXr409F40yFnFq3Z0ya4UJr1jkw18XayDWF1rAF97Aw1DCr17Gry3Xry8Kw1fZrs5Grs3
        Xa97GrWUAwsFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRArc-3UUUUU==
X-Originating-IP: [180.113.78.212]
X-CM-SenderInfo: xzrqvv5ubu0ubn6rjloofrz/1tbiJABzgVpEFi3VUwAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deyan Wang <wonder_rock@126.com>

preempt_count() will be checked in preempt_schedule_irq(),
we need check if NEED_RESCHED in preempt point.

Signed-off-by: Deyan Wang <wonder_rock@126.com>
---
 arch/arm64/include/asm/preempt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 0159b625cc7f..083b0fd3c52a 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -10,7 +10,7 @@
 
 static inline int preempt_count(void)
 {
-	return READ_ONCE(current_thread_info()->preempt.count);
+	return READ_ONCE(current_thread_info()->preempt_count);
 }
 
 static inline void preempt_count_set(u64 pc)
-- 
2.25.1

