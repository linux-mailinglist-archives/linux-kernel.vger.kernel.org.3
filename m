Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9270F54F878
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382307AbiFQNqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382020AbiFQNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:46:12 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 326762D1EA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uRczj
        i7vVBr5C6IMWKTGdkS+1yFJHw9SsMBe6bOGpPU=; b=Q7Uyb7FK/90S3vHWiumFt
        308Ya7vwn7r4iFPnnLvlCS1tRoIHBQfUOil7ngS/6OlO8FleoJ+rYpf57GkFISuR
        493X0o258qgfXfcaHXTHlkbxH1tymqbOhaeGk5/o/CV73OxE27uhbJmc/YA4ru9g
        QZyDWF7ebglhF2+xqDLWb4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBX4X2Shaxi6fxyFw--.39736S2;
        Fri, 17 Jun 2022 21:45:54 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-versatile: Fix refcount leak bug in versatile
Date:   Fri, 17 Jun 2022 21:45:52 +0800
Message-Id: <20220617134552.4050008-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBX4X2Shaxi6fxyFw--.39736S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyxAF1xZw1fZF1xKr1DAwb_yoW3trX_Jr
        1xX34xAF1rJ3WYqr4DCr45Cry7uw17Wr15J348Ar12y3ySqrZrAr4vqryIkw1v9rsxKrZx
        uws7Xr15Ka17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUID7DUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BIjF1pEDvasLAAAsc
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In versatile_dt_init(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-versatile/versatile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/versatile.c b/arch/arm/mach-versatile/versatile.c
index 02ba68abe533..97da874b5d4b 100644
--- a/arch/arm/mach-versatile/versatile.c
+++ b/arch/arm/mach-versatile/versatile.c
@@ -164,6 +164,7 @@ static void __init versatile_dt_init(void)
 	np = of_find_compatible_node(NULL, NULL, "arm,core-module-versatile");
 	if (np)
 		versatile_sys_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!versatile_sys_base);
 
 	versatile_dt_pci_init();
-- 
2.25.1

