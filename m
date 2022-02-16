Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D164B7F11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbiBPEA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:00:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245697AbiBPEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:00:52 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0BCFFF86;
        Tue, 15 Feb 2022 20:00:40 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EE1325C009B;
        Tue, 15 Feb 2022 23:00:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 15 Feb 2022 23:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=SiszW+x9m/mJnfPkAgUXZG/Zve/dxDiJBwdKRTErKP4=; b=MXyzz
        DEo/sDWN98koq85tTb650JjUXtvWONyaeELk7PU1O3zmRepAaQQBONI9QNv1iLKw
        Lb6yc5piUfyB0a93/SD2Id+7rY4XCJTDK2UOWUYZJlvgaNHj97UzRh4UnZHOUw+J
        fys5PSgUjls/zhh4SLsq6Hl0G4ExN1/VeV/lNRIT/DOYuROXhMhuAyxRih6M7rYC
        5YkzOAj4xAg+8lPGbtH+lYCnMaamKEXtElxPng8hByr8vy9/zdK9yaayNskE7RJo
        Htl+d0C0EMtcfApZDtPJYKlYOAusushP38bv/T5hRs7WPE6l8btB105VW41mBobP
        C5hpx4yyDbV8uR49A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=SiszW+x9m/mJnfPkAgUXZG/Zve/dx
        DiJBwdKRTErKP4=; b=nQ/JPulW8bYZaRjU93QoPy76Kr7ACTKazlcc0it4ab5tt
        85LqfBALzoGR7DCFEwRaPsDBAppHQI6qaxq/7JUR26f+VWvludBbDDJc5BOfZbDF
        4mQNsbgEsrxv3ZPNv++r3srbu/NW92GsPiRziMyEJKAZSzkil0omswpENtygOEMW
        KWx5HBZx8qnsU1hHNUxjrxm4PJjm/EuwwFPsvBImL1oSXJ323MzHucYfWjXTb1qe
        dRzc+ll8EmYjFgGmAgEFc6iNtjwb7fGdCydlZRX3LsdqIcJa0stu9Lk6L98PyMs+
        m570ClmA3L89SWmUCJ2JGihiL/921vc2IzK7/WVJA==
X-ME-Sender: <xms:5nYMYssshuikj44pspxWI8f18v7qvQzW6Poxl-3DUwFg2ktdZxlBsw>
    <xme:5nYMYpeQeSoM60gmw_0WYF48ZlfqNOn6pdNd9FqOYzr12RYS9G2jlpwd0f8El7QVg
    WEB7aUoIWmrJIwJ5w>
X-ME-Received: <xmr:5nYMYnySPoI9exRkfGoHjg6_ktPnSYjm8jW2YhPwqWmPX7QWKQ7SBsYlByPewUdBOjRXAISPJruCQ_spV35qbxPqBkxuM0tpI3N4GHGviGpozUTFNGYmrhbXrKknpGZiKj09MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeehgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5nYMYvMyc4MgbxgnV8n_yr_BXK7-4tyyeOF-VP1gf3l3KspEvhB_ww>
    <xmx:5nYMYs_HGmZWmYzi2Gze56vi9maxRSHE7lH89M-gE7-JoARx6MJ4Fg>
    <xmx:5nYMYnWppb4rNCPSpy5ssQWKmZEbKqfgHW-VrbgCeq2Bp1TZyqMG-A>
    <xmx:53YMYpNu1NIQyA4TTJ6QOFxvXGQ2ac76zrnp4F8Cax86eaQu8rsFWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Feb 2022 23:00:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] pinctrl: sunxi: Use unique lockdep classes for IRQs
Date:   Tue, 15 Feb 2022 22:00:36 -0600
Message-Id: <20220216040037.22730-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver, like several others, uses a chained IRQ for each GPIO bank,
and forwards .irq_set_wake to the GPIO bank's upstream IRQ. As a result,
a call to irq_set_irq_wake() needs to lock both the upstream and
downstream irq_desc's. Lockdep considers this to be a possible deadlock
when the irq_desc's share lockdep classes, which they do by default:

 ============================================
 WARNING: possible recursive locking detected
 5.17.0-rc3-00394-gc849047c2473 #1 Not tainted
 --------------------------------------------
 init/307 is trying to acquire lock:
 c2dfe27c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0

 but task is already holding lock:
 c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&irq_desc_lock_class);
   lock(&irq_desc_lock_class);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 4 locks held by init/307:
  #0: c1f29f18 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x23c
  #1: c20f7760 (&dev->mutex){....}-{3:3}, at: device_shutdown+0xf4/0x224
  #2: c2e804d8 (&dev->mutex){....}-{3:3}, at: device_shutdown+0x104/0x224
  #3: c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0

 stack backtrace:
 CPU: 0 PID: 307 Comm: init Not tainted 5.17.0-rc3-00394-gc849047c2473 #1
 Hardware name: Allwinner sun8i Family
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x90
  dump_stack_lvl from __lock_acquire+0x1680/0x31a0
  __lock_acquire from lock_acquire+0x148/0x3dc
  lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
  _raw_spin_lock_irqsave from __irq_get_desc_lock+0x58/0xa0
  __irq_get_desc_lock from irq_set_irq_wake+0x2c/0x19c
  irq_set_irq_wake from irq_set_irq_wake+0x13c/0x19c
    [tail call from sunxi_pinctrl_irq_set_wake]
  irq_set_irq_wake from gpio_keys_suspend+0x80/0x1a4
  gpio_keys_suspend from gpio_keys_shutdown+0x10/0x2c
  gpio_keys_shutdown from device_shutdown+0x180/0x224
  device_shutdown from __do_sys_reboot+0x134/0x23c
  __do_sys_reboot from ret_fast_syscall+0x0/0x1c

However, this can never deadlock because the upstream and downstream
IRQs are never the same (nor do they even involve the same irqchip).

Silence this erroneous lockdep splat by applying what appears to be the
usual fix of moving the GPIO IRQs to separate lockdep classes.

Fixes: a59c99d9eaf9 ("pinctrl: sunxi: Forward calls to irq_set_irq_wake")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 80d6750c74a6..9e6ed1175db3 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -36,6 +36,13 @@
 #include "../core.h"
 #include "pinctrl-sunxi.h"
 
+/*
+ * These lock classes tell lockdep that GPIO IRQs are in a different
+ * category than their parents, so it won't report false recursion.
+ */
+static struct lock_class_key sunxi_pinctrl_irq_lock_class;
+static struct lock_class_key sunxi_pinctrl_irq_request_class;
+
 static struct irq_chip sunxi_pinctrl_edge_irq_chip;
 static struct irq_chip sunxi_pinctrl_level_irq_chip;
 
@@ -1555,6 +1562,8 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
 		int irqno = irq_create_mapping(pctl->domain, i);
 
+		irq_set_lockdep_class(irqno, &sunxi_pinctrl_irq_lock_class,
+				      &sunxi_pinctrl_irq_request_class);
 		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_edge_irq_chip,
 					 handle_edge_irq);
 		irq_set_chip_data(irqno, pctl);
-- 
2.33.1

