Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2580537701
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiE3Icl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiE3Ici (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:32:38 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 01:32:36 PDT
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D515DDEE3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:32:36 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E12522DFA5B;
        Mon, 30 May 2022 10:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1653899158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mQ5x6WkuEG+6GLSIYtwc4TC8mRiQkyEgf6MNZMYOlsg=;
        b=sbeTfPW+z5RPJQ72qnnUDrMlZnszEY9Pn0Y5hHEfoPLoL9ytX/NxjuT8ZudE36UilWTQXv
        /NAnNFp0gdpph+TJ1zy34zXuar+jMtu5+hCxY3VZh4mWeIsRt59d6IW0lZeXcZBOowOr7O
        Hofkjtia5AKsWiOVm7F1ToO1hn234Fw7FA93kTF1LBm/GcgWOxJpw1HjNtPZDOPO0exAKA
        oNMOwnEDmvp/hTTjJZ40aNYOYGPjv7HXCJzNhHFeaTsOSby+/lG9gZzvcAbmtvDTy1EpQ6
        wJMrXP1bnuG9gue4gRsL7MiyrNJr4RPQwuiGJFDD2HcWxiiUEFiN42iCjhj9JA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        INAGAKI Hiroshi <musashino.open@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v1] gpio: realtek-otto: always honor empty CPU masks
Date:   Mon, 30 May 2022 10:25:52 +0200
Message-Id: <20220530082552.46113-1-sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On uniprocessor builds, for_each_cpu(cpu, mask) will assume 'mask'
always contains exactly one CPU, and ignore the actual mask contents.
This causes the loop to run, even when it shouldn't on an empty mask,
and tries to access an uninitialised pointer.

    CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 802967bc, ra == 802e2f4c
    Oops[#1]:
    CPU: 0 PID: 1 Comm: swapper Not tainted 5.10.115 #0
    $ 0   : 00000000 00000001 00000000 00000018
    $ 4   : 000000ff 00000000 00000000 00000000
    $ 8   : 00000024 802cbb58 00000018 6f2d636f
    $12   : 00000000 00006382 00000000 fffffffc
    $16   : 82272c80 00000000 82272c80 00000000
    $20   : 82272e08 00000000 80750000 00000000
    $24   : 00000008 00000020                  
    $28   : 8201a000 8201bc28 80750000 802e2f4c
    Hi    : 000044fc
    Lo    : 0000227e
    epc   : 802967bc iowrite8+0x4/0x10
    ra    : 802e2f4c realtek_gpio_irq_init+0xac/0xe0
    Status: 1010fc03 KERNEL EXL IE 
    Cause : 1080000c (ExcCode 03)
    BadVA : 00000000
    PrId  : 00019070 (MIPS 4KEc)
    Modules linked in:
    Process swapper (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=00000000)
    Stack : 82272c80 82272e00 80fc6e7c 802dee90 82272c80 82272c80 82272e00 8074d7d8
            8074d7d8 802dce50 8201bc5c 806d0000 00000000 00000cc0 80f90000 82272c80
            802ddb74 80650000 82084410 82272e08 82275b80 82272c80 82272c80 82084410
            00000000 82272d78 00000000 8075d094 80f90000 802ddb00 80fc0000 80320364
            00000000 803ac928 82272c80 00000017 00000000 82084410 82084400 802e2d88
            ...
    Call Trace:
    [<802967bc>] iowrite8+0x4/0x10
    [<802dce50>] gpiochip_add_data_with_key+0x508/0xb14
    [<802ddb00>] devm_gpiochip_add_data_with_key+0x60/0xd4
    [<802e2d88>] realtek_gpio_probe+0x1e0/0x2f8
    [<8031e214>] platform_drv_probe+0x40/0x94
    [<8031bf1c>] really_probe+0x108/0x4d8
    [<8031c99c>] device_driver_attach+0x120/0x130
    [<8031ca28>] __driver_attach+0x7c/0x13c
    [<80319a70>] bus_for_each_dev+0x68/0xa4
    [<8031b16c>] bus_add_driver+0x1c8/0x210
    [<8031d1f0>] driver_register+0x98/0x154
    [<80000638>] do_one_initcall+0x50/0x1ac
    [<8075de8c>] do_initcalls+0x100/0x14c
    [<8075e044>] kernel_init_freeable+0xfc/0x138
    [<80586ed0>] kernel_init+0x10/0xf8
    [<80001a18>] ret_from_kernel_thread+0x14/0x1c
    
    Code: 03e00008  00000000  0000000f <a0a40000> 03e00008  00000000  0000000f  a4a40000  03e00008 
    
    ---[ end trace 438028f3ae26080b ]---
    Kernel panic - not syncing: Fatal exception


Fixes: 95fa6dbe58f2 ("gpio: realtek-otto: Support per-cpu interrupts")
Reported-by: INAGAKI Hiroshi <musashino.open@gmail.com>
Reported-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
This patch is more of a work-around than a real fix, and ensures the
driver runs properly on uniprocessor builds. My tests were done using an
SMP-enabled build on a single-core system, which is why is missed this
erroneous behaviour.

The real fix would be a modification of include/linux/cpumask.h, which
may take longer to finalise, but I would rather have the issue in this
driver fixed in the 5.19 release.

Best,
Sander

 drivers/gpio/gpio-realtek-otto.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index c52b2cb1acae..5391ebcd5bce 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -301,6 +301,7 @@ static int realtek_gpio_irq_set_affinity(struct irq_data *data,
 static int realtek_gpio_irq_init(struct gpio_chip *gc)
 {
 	struct realtek_gpio_ctrl *ctrl = gpiochip_get_data(gc);
+	void __iomem *irq_cpu_mask;
 	unsigned int port;
 	int cpu;
 
@@ -308,8 +309,16 @@ static int realtek_gpio_irq_init(struct gpio_chip *gc)
 		realtek_gpio_write_imr(ctrl, port, 0, 0);
 		realtek_gpio_clear_isr(ctrl, port, GENMASK(7, 0));
 
-		for_each_cpu(cpu, &ctrl->cpu_irq_maskable)
-			iowrite8(GENMASK(7, 0), realtek_gpio_irq_cpu_mask(ctrl, port, cpu));
+		/*
+		 * Uniprocessor builds assume a mask always contains one CPU,
+		 * so only start the loop if we have at least one maskable CPU.
+		 */
+		if (!cpumask_empty(&ctrl->cpu_irq_maskable)) {
+			for_each_cpu(cpu, &ctrl->cpu_irq_maskable) {
+				irq_cpu_mask = realtek_gpio_irq_cpu_mask(ctrl, port, cpu);
+				iowrite8(GENMASK(7, 0), irq_cpu_mask);
+			}
+		}
 	}
 
 	return 0;
-- 
2.36.1

