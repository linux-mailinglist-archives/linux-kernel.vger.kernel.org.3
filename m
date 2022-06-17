Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6254EFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379820AbiFQD4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiFQD4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:56:22 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7B5565408
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FK3+6
        hlQB3HGXoQhyC6dprNvmAP51TusZx/O2PywBRE=; b=UWafGE1UiUdqxOtFRJ1tx
        PJYNaoA6tu9+k2wp6y2wvijB1R4W67Xni+Miw+8cbNisIho0StWZxTqdfiNQKrho
        0iI56/xxFwV3vjZ57TA7mvHiCGwwkLNAVEDTptvfHbjxiEDanJdZ+ADl0quZVKex
        arCWJuFt98w3/H3Z1YikgQ=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgAHu49F+6tiYaBRFw--.26457S2;
        Fri, 17 Jun 2022 11:55:57 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tony@atomide.com, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-omap2: omap4-common: Fix refcount leak bug
Date:   Fri, 17 Jun 2022 11:55:48 +0800
Message-Id: <20220617035548.4003393-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAHu49F+6tiYaBRFw--.26457S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfGr18WFyxAryfuF4DJwb_yoWfJFgEqw
        n2g395Jrsag3Z3Ka47Ca15Gr4jgw1rWrs7W3s7ZF15Ka1UJr43ArZ2vas2yryDX3yrKrW3
        ZFZFyw4Fkw1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUVWlJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7Q0jF1pEANzlIQAAsS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In omap4_sram_init(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-omap2/omap4-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6d1eb4eefefe..e981bf57e64f 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -135,6 +135,7 @@ static int __init omap4_sram_init(void)
 		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
 			__func__);
 	sram_pool = of_gen_pool_get(np, "sram", 0);
+	of_node_put(np);
 	if (!sram_pool)
 		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
 			__func__);
-- 
2.25.1

