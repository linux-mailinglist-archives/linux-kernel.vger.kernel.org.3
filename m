Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1284E8FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiC1IGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiC1IGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:06:18 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ACB4532D0;
        Mon, 28 Mar 2022 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=KPx/rmNE2IqkPwzgVv
        OSkXH+L0hTETFepkUJ7cvU4kA=; b=eXjmv/dOeGRYzXwaV1+6jPIiC1AdmlUzs4
        Xrw6XVqy/V6P2zm0D/hVIjfTKxbsh//YpYV2HXJeJM+/XbvWq/QQ0Ikuhd8euAfP
        rHqrY8xi5w/4SGTOoGvaOhcu96mYlDBmNAhDN7pJRuzabt2kR3TWGfUaJNPIE4Wl
        5PLg4t4Kg=
Received: from localhost (unknown [159.226.95.33])
        by smtp13 (Coremail) with SMTP id EcCowAAnwdIAbEFiPwqmJA--.61675S2;
        Mon, 28 Mar 2022 16:04:16 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        ralf@linux-mips.org, QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] MIPS: ip22-gio: Add check for the return value of kzalloc()
Date:   Mon, 28 Mar 2022 16:04:14 +0800
Message-Id: <1648454654-27200-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowAAnwdIAbEFiPwqmJA--.61675S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy5KrWDWFW5CrWkuFWUtwb_yoWfZFbE9a
        yvvF1Dua98Jw17Aw13Xw4rJFy3A347uF4I93Z3tF1SkFyrArZ8WrWkXw15Jry7Wry2vF45
        Crs0kF15uw4xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRE1xR3UUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/1tbiNADRH1aD-Qb+DwAAsl
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the memory allocation function kzalloc() may return a NULL pointer,
the use of 'gio_dev' may lead to NULL pointer dereference.

So it is better to check the return value of kzalloc().

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index dfc52f6..df7ca21 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -363,7 +363,11 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
 		       slotno, name, id);
 		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
-		gio_dev->name = name;
+		
+        if (!gio_dev)
+            return ;
+
+        gio_dev->name = name;
 		gio_dev->slotno = slotno;
 		gio_dev->id.id = id;
 		gio_dev->resource.start = addr;
-- 
2.7.4

