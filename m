Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70A454C9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352022AbiFONZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbiFONZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:25:13 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D86C93EF29
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BSjNd
        hAt272YwjFRfopkZ2NN8WwqGhD8jHVz0zzDo8A=; b=kHWHRDkvyjfel1NbT55RI
        Yxvl0+ocpSWFie6yh/BqFEO5qodJysFlkNUkkARTscqI/M9zgIMbZ+xH5FHioYmp
        Nf10BufC47eOEAs/S1pMKJC2xMM672vSbkfldABLRJly3IJesbPE9EmcfDtFsx9X
        C4yqUHVR/+Q65z9ko7mF/s=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgBX7nOJ3aliArIwEw--.53252S2;
        Wed, 15 Jun 2022 21:24:26 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tsahee@annapurnalabs.com, atenart@kernel.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-alpine: Add missing of_node_put() in alphine_cpu_pm.c
Date:   Wed, 15 Jun 2022 21:24:24 +0800
Message-Id: <20220615132424.3967142-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgBX7nOJ3aliArIwEw--.53252S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfGr18WFyxAryfuF4DJwb_yoWfJrcEqw
        1ft3yxXryS9an2qrnrCa15WrnIywn29r10q34xZ3sYkw42vrsrArnrJryIyw1rWFWfKFW3
        Aw4DZF1Y9345KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_3x6UUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gohF1uwMNWcaQAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In alpine_cpu_pm_init(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when it
is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-alpine/alpine_cpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.c b/arch/arm/mach-alpine/alpine_cpu_pm.c
index 13ae8412e9ce..cc201a90d23c 100644
--- a/arch/arm/mach-alpine/alpine_cpu_pm.c
+++ b/arch/arm/mach-alpine/alpine_cpu_pm.c
@@ -51,6 +51,8 @@ void __init alpine_cpu_pm_init(void)
 	np = of_find_compatible_node(NULL, NULL, "al,alpine-cpu-resume");
 	al_cpu_resume_regs = of_iomap(np, 0);
 
+	of_node_put(np);
+
 	wakeup_supported = !IS_ERR(al_sysfabric) && al_cpu_resume_regs;
 
 	if (wakeup_supported) {
-- 
2.25.1

