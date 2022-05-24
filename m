Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278A532195
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiEXD3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiEXD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:29:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15996996AA;
        Mon, 23 May 2022 20:29:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so61544pjb.1;
        Mon, 23 May 2022 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=chsCh2ddSCkGriuAaT3W/gLAbDBmBFGcAXjDbZAAsck=;
        b=LU4+uYppoarzT9XpfW7N7FXaVEaojsCjxslu+M+SUHazDjSsdhQLudmOwft7H+Spon
         3MA83hS0WgLQ0HyqIY8pRVEiksGL4HTjl6WKW0SZ/NV9eY2DM6BLqfdTdk71ZgeGvyQb
         twvN9cuFqC27bUjk7qZWHyE/1/qT0w6JMo/UIiCnuc4eQLG91/M7cooGJdvvA0X2iBzb
         ZK68GrCSmKvefTNupclOyU6fRaQ1irzxSagsoVFjwpGLvUWsgLTi+/AslLsozuvyEGRY
         SHloMhol+pVksqr+8MpkSsiI0toW80ooOTw9cfMgZD7hjdUt1+me5yqVHGhD0Os9101m
         Sx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=chsCh2ddSCkGriuAaT3W/gLAbDBmBFGcAXjDbZAAsck=;
        b=kCzmDod4pUNJqBKH74G0y69i3lczmKSswTA8lIbPv0Ys9jc8IbEysE69ur+R/n7icV
         QSHkWFEYWzGJfumeqkMJZsvInNC+a7Kyn9TqWGGw/+EoiaDuGU3/8dl4twGW6LHSsIkv
         76D0j64tKoT1/w9CO5iCQH0+HnT/VGXn9TkHUqP+CcoRqIpdoibAPDaZRyt7rLhsAieD
         XLFz5Em/cVwXGMSCp0UcLUyFSt2vNGSHE25REiD7CGEaOxSX+kp0SkrZZuqx8FAMlfK6
         mVqSGrct8DW90QB++uck4fuhrtbfgE6Rsc6Nhch4Tl364kTxfuRc99SgXRRT0J3DiZq4
         GhzQ==
X-Gm-Message-State: AOAM530yQ7Wwdt3amFScHcsy46HXV6IMurwIklc3SZrEz3aLyhTYAuB2
        gFAY/mfX/YgNwL7tbu+nNzY=
X-Google-Smtp-Source: ABdhPJy+/+ZYbSjad/VNd4WxI0IAynwMTTJXgre/Mk7BfEWoNi7kJkVmyaJnnz5qxXi4Hw2YKEk7hg==
X-Received: by 2002:a17:90a:b295:b0:1df:8462:b96e with SMTP id c21-20020a17090ab29500b001df8462b96emr2430989pjr.162.1653362954590;
        Mon, 23 May 2022 20:29:14 -0700 (PDT)
Received: from localhost.localdomain ([103.167.134.51])
        by smtp.gmail.com with ESMTPSA id c123-20020a621c81000000b0050dc7628202sm7840573pfc.220.2022.05.23.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 20:29:13 -0700 (PDT)
From:   Genjian Zhang <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian Zhang <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de, maz@kernel.org, keescook@chromium.org,
        mark.rutland@arm.com, nathan@kernel.org, siyanteng01@gmail.com,
        yyuasa@linux.com, ralf@linux-mips.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        huhai@kylinos.cn, zhanggenjian123@gmail.com,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] gpio: vr41xx: Use spurious_interrupt() and export it to modules
Date:   Tue, 24 May 2022 11:28:47 +0800
Message-Id: <20220524032847.3244853-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huhai <huhai@kylinos.cn>

modpost complains once these drivers become modules.
  ERROR: modpost: "irq_err_count" [drivers/gpio/gpio-vr41xx.ko] undefined!

Fix it by use spurious_interrupt() and export spurious_interrupt() when
that symbol is =m.

Fixes: 27fdd325dace ("MIPS: Update VR41xx GPIO driver to use gpiolib")
Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: huhai <huhai@kylinos.cn>
---
 arch/mips/kernel/irq.c     | 3 +++
 drivers/gpio/gpio-vr41xx.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 5e11582fe308..69f9a46bf9e5 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -49,6 +49,9 @@ asmlinkage void spurious_interrupt(void)
 {
 	atomic_inc(&irq_err_count);
 }
+#ifdef CONFIG_GPIO_VR41XX_MODULE
+EXPORT_SYMBOL_GPL(spurious_interrupt);
+#endif
 
 void __init init_IRQ(void)
 {
diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index 98cd715ccc33..8f27a0e0ad99 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -217,7 +217,7 @@ static int giu_get_irq(unsigned int irq)
 	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
 	       maskl, pendl, maskh, pendh);
 
-	atomic_inc(&irq_err_count);
+	spurious_interrupt();
 
 	return -EINVAL;
 }
-- 
2.27.0

