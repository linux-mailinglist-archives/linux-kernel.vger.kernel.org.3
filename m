Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0654F7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382394AbiFQMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiFQMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:42:20 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FE206622C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TU2B9
        l3UgYA6rfXiP8LSC5IMRVHoUDGy3g/V+/PidVk=; b=VHIIQ7hmoYv8Cd80eUAvj
        4K/6vJW4qa/N7Nd6aHk2gH75i9iKFqFtA3l1IwqmRTsvggeSGIdEV8jaKpDxja0H
        u3QiqSf3INUpAGru3BzteqItFA1djU7NUWuw6CKL6A55Jbhz6WaaCVpWYrmSe9h/
        KO0dhs6Z4vByn3HKmzcYkw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAAnKiY6bqxiHzkiEw--.31307S2;
        Fri, 17 Jun 2022 20:06:19 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     dinguyen@kernel.org, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-socfpga: Fix refcount leak bug in socfpga
Date:   Fri, 17 Jun 2022 20:06:18 +0800
Message-Id: <20220617120618.4047441-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAAnKiY6bqxiHzkiEw--.31307S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfGr18WFyxAryfuF4DJwb_yoWDWFc_XF
        9agay7XryrAa9YgrW7ua1agan7C393Cwn0qr10vr1qkw4YqF47Ar9IkF92qryUWr4akFWf
        XanrJF1Yv392yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUIztUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hwjF1uwMOTj7gAAsA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In socfpga_sysmgr_init(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-socfpga/socfpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 9e4cb2ffd580..c561b3b7a9ee 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -36,12 +36,15 @@ static void __init socfpga_sysmgr_init(void)
 	sync_cache_w(&socfpga_cpu1start_addr);
 
 	sys_manager_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
 	rst_manager_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
 	sdr_ctl_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 }
 
 static void __init socfpga_init_irq(void)
-- 
2.25.1

