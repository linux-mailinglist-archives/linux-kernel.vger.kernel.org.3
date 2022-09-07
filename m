Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7025B0147
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIGKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIGKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:05:54 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21337B7B5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662545148;
  x=1694081148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oNTEly+VN1w0GXZfx3c8iIp7/UMbftmaEYgIr51BAs0=;
  b=HKPmsEYCpaUn9oI2GMpJqyrPIu0LtaTR1VDRnKRxSmBtm65V9H+XXfce
   T11BI5TrGd4m4TVZ/cXxNlTETWQomJFt81lkSmTVMvZPGQOvGWa1jfFBN
   7sfe7KZ4ozOwApJx12gX+35Ll4qF5Da+JmsU294KrmyAsh4UA/uakOnlC
   cx2+30AlurjXjohjgoQruYkDP0ICRLFpbIRyGmaWR0o+xNf2vmwKlCVS9
   MlifoTHDqIzHiUMkF7GhB0E/AYnxddy25WMg8RyAOoq2lS/xjn3q/7Z4q
   eTtBIao2OSXQvIpGPOQsqxxvvIRhX36LGRZa58FayKBAwl+Uio6TnqXBb
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: Prevent KASAN splats in dump_stack()
Date:   Wed, 7 Sep 2022 12:05:33 +0200
Message-ID: <20220907100533.1719128-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use READ_ONCE_NOCHECK() when reading the stack to prevent KASAN splats
when dump_stack() is used.

Fixes: 5b301409e8bc5d7fad ("UML: add support for KASAN under x86_64")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/kernel/sysrq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 7452f70d50d0..746715379f12 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -48,7 +48,8 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 			break;
 		if (i && ((i % STACKSLOTS_PER_LINE) == 0))
 			pr_cont("\n");
-		pr_cont(" %08lx", *stack++);
+		pr_cont(" %08lx", READ_ONCE_NOCHECK(*stack));
+		stack++;
 	}
 
 	printk("%sCall Trace:\n", loglvl);
-- 
2.34.1

