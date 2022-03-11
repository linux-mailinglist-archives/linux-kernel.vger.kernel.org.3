Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652DE4D5BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbiCKGrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCKGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:47:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33A19D617
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:46:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q13so6928505plk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=MDO98zfNryitJLRORLTZ+LkzoKAWivGOSBuxXfv/2ck=;
        b=Locg1LNIe+YyIJbh8hZviuYWEecJYbAU8GbggY1FbPSptu4HwbL6H9enLJNtiy4O9y
         qsKWLexxG9XFotNKrLDpP4FIvP9bpGLdb3ceaBzDXRzLqD7DLbV4nvcXVlYIVEUc+84m
         OZL6vugdjH3FQ4dJaDxLDHfsZW24d/K4aHOE24FKIJqK8RKKotfPSB/D8ygA7ULReAr3
         h2Y0xrOTYCf0otNALKf7umXd0+uGP6ws7LIenhkFLTLMxiyO++hSwrXPRSKuuwfLAogD
         B2u1/BQfCkeCXIfIqqRrZ0/bEz9hlIqaGgTZjyUZrB4Z/OAc+0+YewT5zVgjRgtCVOH3
         ZODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MDO98zfNryitJLRORLTZ+LkzoKAWivGOSBuxXfv/2ck=;
        b=ssMaPhmPqNX8VXQuE74TCCb/O8BNqH9YUI25GTzTYhu+IVwF+dnv05bUl2xcX1a/jU
         OmyLkxFFqD0FHz+BLaG/3OMvUUdmJsXZOgKBx1baNIExvjKrwoPrQY8oRxSP+3veCmJK
         O6bk8god27e7OU62L7/m2S9NJk85s9BVPoGdd2kAJZ2n9CUSsBMh/aQRhcgUyd3BKUzU
         NJvRKFh9zMb62SZplZF6dt7yTz/Bd32cdhCPmcclo2zaV4fb6jKUnIGR3hFH9yLr/0SJ
         dAXB1gOw920di2B1BVxjcQHWDuGmx1zZvwdWACN5QUjDFKVJjMeksClRiFsN7ZimtgEF
         YSNg==
X-Gm-Message-State: AOAM533UIRMrcebWQmWImmZ+QLNwD4pNXhZOshbdY+T1JFoAeJvnzj6N
        MZtyhPadtPuRm97PfbMMqxWPSy3HsQ==
X-Google-Smtp-Source: ABdhPJzOqAUc50SCwJ9tg96bi/j3yvTpUoNqVLebYB0d5O3nzLVV4Eewfk/P4/q+NKO2fbpcs22R7w==
X-Received: by 2002:a17:903:291:b0:150:4197:7cf2 with SMTP id j17-20020a170903029100b0015041977cf2mr8726281plr.173.1646981192234;
        Thu, 10 Mar 2022 22:46:32 -0800 (PST)
Received: from sh08423pcu1.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78c50000000b004f76c255e92sm5085738pfd.101.2022.03.10.22.46.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2022 22:46:31 -0800 (PST)
From:   Bruce Chen <brucechen251@gmail.com>
To:     bruce.chen@unisoc.com, rogerq@kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, gengcixi@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
Subject: [PATCH RESEND V2] extcon: usb-gpio: Remove disable irq operation in system sleep.
Date:   Fri, 11 Mar 2022 14:45:03 +0800
Message-Id: <1646981103-30050-1-git-send-email-brucechen251@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Chen <bruce.chen@unisoc.com>

If disable vbus/id irq, it will lead to wakeup system fail
in unisoc platform. In unisoc platform, Irq enable and irq
wakeup are the same interrupt line. So remove disable vbus/id
irq operation is a way to solve the issue.

Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
Acked-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/extcon/extcon-usb-gpio.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index f2b65d9..40d967a 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -226,16 +226,6 @@ static int usb_extcon_suspend(struct device *dev)
 		}
 	}
 
-	/*
-	 * We don't want to process any IRQs after this point
-	 * as GPIOs used behind I2C subsystem might not be
-	 * accessible until resume completes. So disable IRQ.
-	 */
-	if (info->id_gpiod)
-		disable_irq(info->id_irq);
-	if (info->vbus_gpiod)
-		disable_irq(info->vbus_irq);
-
 	if (!device_may_wakeup(dev))
 		pinctrl_pm_select_sleep_state(dev);
 
@@ -267,11 +257,6 @@ static int usb_extcon_resume(struct device *dev)
 		}
 	}
 
-	if (info->id_gpiod)
-		enable_irq(info->id_irq);
-	if (info->vbus_gpiod)
-		enable_irq(info->vbus_irq);
-
 	queue_delayed_work(system_power_efficient_wq,
 			   &info->wq_detcable, 0);
 
-- 
1.9.1

