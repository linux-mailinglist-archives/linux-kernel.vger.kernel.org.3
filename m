Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A274D5BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346826AbiCKGpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCKGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:45:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7DC19D624
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:44:16 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z16so7137631pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=MDO98zfNryitJLRORLTZ+LkzoKAWivGOSBuxXfv/2ck=;
        b=B4CZ8EgN6uMCbIn+6jLTUOtMnFKQJlPVHxUEB1anNFRkeAQU7D1pR48cU1x1FAOW4+
         LttwPdInXm84Pf6P7jBFjQSBuYRHVb77bqAMcQMe1tEc0aDJnQuC70dShY99dwNCkhMG
         pgVq6IV2APHTyS0ZaxXPDPFphbfyT65OPlE3U9wgJAO5ghf9h6FWVCY9cAWB/SlZ+kjK
         uqGhZuMZdhot7FvO+SwR6BOOiyXs8+GZZkz5Yj6OCDWcf0yu9Ss1A3/cb31T3SeSIVtp
         goaoW9pE995+CXDXCXiN0qwmeC4CT8IFK+xXiynAArlaQ/LgI/qUTIyHr0EhwpJ8ti2O
         jH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MDO98zfNryitJLRORLTZ+LkzoKAWivGOSBuxXfv/2ck=;
        b=3U6yr/0m1Q1WsgpI7WIGHmF08t9lShsVKZRYwwZxR5AGgukxCOJuWGXnitSsYTvk8P
         nML+vnzA2y/dS7XODyCkWVqYGPFNH5FIt4P0RNe+BAEqaZdHVfJGNKE1FmwquMTzw1kn
         sGAmna6Gqe2vLxvj+JLHnpH1I4GUH9VHRxnl/4FHOTqHr/BZ1QGsTlrTPTChnQZU55L2
         qF7rMlFYrRk56H+BNAWKpibwmtxdupmaV3Gs4eOtz09VruvfDiFz+wL5xzrqevPpyZDN
         QGdQqqA+4CFroXzzTLuSTTPaknCWP2xwjOcmnYMaqVDv6zM8dlKGPL8bu3ck7nfYaZs7
         bKNg==
X-Gm-Message-State: AOAM5310HvGAWRsZtZn6N262ZvOyYSY1VluRpb6GEG3NDwQjchV+simU
        //j+oQ5raQmncunsV3y0jA==
X-Google-Smtp-Source: ABdhPJyfTh88vZxDUKCRK1ck4KCNksRSrEqUQXlAmzBSd8cak9OJnx/xpAs+LUAQNBUNRUeIZPmKYA==
X-Received: by 2002:a63:d642:0:b0:378:a4c2:7b94 with SMTP id d2-20020a63d642000000b00378a4c27b94mr7202499pgj.218.1646981055642;
        Thu, 10 Mar 2022 22:44:15 -0800 (PST)
Received: from sh08423pcu1.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j13-20020a63594d000000b003639cf2f9c7sm7328628pgm.71.2022.03.10.22.44.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2022 22:44:15 -0800 (PST)
From:   Bruce Chen <brucechen251@gmail.com>
To:     bruce.chen@unisoc.com, rogerq@kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, gengcixi@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
Subject: [PATCH RESEND V2] extcon: usb-gpio: Remove disable irq operation in system sleep.
Date:   Fri, 11 Mar 2022 14:42:18 +0800
Message-Id: <1646980938-29982-1-git-send-email-brucechen251@gmail.com>
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

