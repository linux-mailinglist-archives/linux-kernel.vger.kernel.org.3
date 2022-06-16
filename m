Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7796154D90C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350186AbiFPD7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346632AbiFPD7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:59:31 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09F0956B3E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EUX+l
        ZoQmxHElgxRjPXdLpfsVCTA6nfuDvewE+ascZ0=; b=UmHp2FykYaCVKCFNes5bF
        hKToj3Gjw8ciA3S1v4yXNXVedeWZ4XPY5MaMvKUBIpm+cBTXpgGNKLOBiMeRBpGz
        Eed7b1H7mqnOUMTqzqsiDDS0ihuhf8SFtGfcn7Po5HASI/HVgaJ082vItkPOAYya
        s+yplpXirWFaLcaa2hAy3A=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowAAnHAePqqpif+lnDQ--.64909S2;
        Thu, 16 Jun 2022 11:59:11 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] mach-versatile: (platsmp-vexpress) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 11:59:11 +0800
Message-Id: <20220616035911.3976600-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAAnHAePqqpif+lnDQ--.64909S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF13Ar13GFy3Xr1DCF4UArb_yoWfZrg_t3
        WftayxCw4rJFySgrykCF4fGrW7Z34IgF4UJry8tr98AryUArnrArWvq34kt3yrXFW2krW3
        Wrs7GrWF9asF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_znQ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgAiF1-HZTsqFgAAsV
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vexpress_smp_dt_prepare_cpus(), of_find_matching_node() will
return a node pointer with refcount incremented. We should use
of_node_put() when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use real name for Sob
 v1: fix missing bug

 arch/arm/mach-versatile/platsmp-vexpress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/platsmp-vexpress.c b/arch/arm/mach-versatile/platsmp-vexpress.c
index 1ee3c45e71c9..d9a7394a00bf 100644
--- a/arch/arm/mach-versatile/platsmp-vexpress.c
+++ b/arch/arm/mach-versatile/platsmp-vexpress.c
@@ -67,6 +67,7 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
 	if (scu)
 		scu_enable(of_iomap(scu, 0));
 
+	of_node_put(scu);
 	/*
 	 * Write the address of secondary startup into the
 	 * system-wide flags register. The boot monitor waits
-- 
2.25.1

