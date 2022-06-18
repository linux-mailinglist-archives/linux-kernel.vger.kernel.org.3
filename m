Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0971A5505D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiFRPoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiFRPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:44:03 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09703DFD7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mi2Nm
        vzDQUqWePpQIn7Ium4/THNKJoKJgcMDRtTn+/E=; b=K3snKAjC70YDAvcrrlhdO
        PN+cLgfhVLml+vBiBbHqoo/xChIGuZBKXYpCOzmnNwHCAUdl3QhuDcMh6P1sNpGy
        WKP4prUb362WxBgSyNlJik90+tnxlcRO2TE0FTd4mvoW+asxG5iPJ/ADnLXG9aHF
        kbhB8HrApB/iP+Tuwys7yk=
Received: from localhost.localdomain (unknown [1.203.65.185])
        by smtp13 (Coremail) with SMTP id EcCowACHfpFx8q1iGcIkIw--.33326S4;
        Sat, 18 Jun 2022 23:43:04 +0800 (CST)
From:   jingyuwang <jingyuwang_vip@163.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, jingyuwang <jingyuwang_vip@163.com>
Subject: [PATCH] Fix error_exit to error_return.
Date:   Sat, 18 Jun 2022 23:42:38 +0800
Message-Id: <20220618154238.27749-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACHfpFx8q1iGcIkIw--.33326S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF48ZrWrJFW3GF13Jr4fXwb_yoWxCFc_XF
        s2yw48Cr43XF9rWrWjkF45CFySk345CrWrGrn7J3WDtF9Fgw18XF4DWw18XrWfJry8WrWf
        ZrZIkrW7AwsFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiAwxtUUUUU==
X-Originating-IP: [1.203.65.185]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBaQgkF1XlyPaYgAAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: jingyuwang <jingyuwang_vip@163.com>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4300ba49b5ee..b1195e4de45a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -991,7 +991,7 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
-	 * exceptions go through error_exit instead.
+	 * exceptions go through error_return instead.
 	 */
 	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
 
-- 
2.34.1

