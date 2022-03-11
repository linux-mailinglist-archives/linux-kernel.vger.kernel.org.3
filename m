Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE964D5AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbiCKFqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiCKFqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:46:38 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0681AAFC9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:45:36 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a5so7053823pfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=jLeXq2Ixl82u3kJhj+cevfsbwGuZVEVBDM1v8RCMk/k=;
        b=SEZ164dfOblso9Z7mrK/NZD1o5BMCvzlKpCpQyKjbaVtBe9Q0iXnXi8UkoLjlbMzB5
         a7b6NT1BwO90fxyhRS/Ew7RfOEgrQjQu2xpEOeHJ7N6SzP5lVu1GFnzFHTATMr7Gik35
         IbFAIdVb8WIQ2ttLNqhWWSXia5NqZxt/XfyjeZoAm/Tswyo2YJVRa/l6RbMpSyOJWdi4
         bGKP1a3peU8Qss2XeEuVUEjVstj3si6IgSBGJqK/JhrpTMOOlgXXLleKBs0n8oCkhnUa
         qz5TIsp1d71YkghwrT9moLWlWsbvgeZ/ItpDT1bzkrTU6pM5YrbDIiA7EBYm9OtWQY+q
         bhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jLeXq2Ixl82u3kJhj+cevfsbwGuZVEVBDM1v8RCMk/k=;
        b=L7Rs5gS400LC+y3xcqZ10ZqNhhOtJ93NuO4Zan902Qrs9PB3zS2GiY79tZplz/4T8x
         N+VqUDjb+1VIhy5X+AqLJHi90BoJa+SEux6LO7P/Au8SAq7101qVPn+FZQIRumwPQAfn
         Xtx05g3xErMGT4VtjTsmdxJq41h9HmBp95mohWh+1kSn9hqlXu2VF1p9zu9qKg2Lzar8
         VD5+OtOSCbIDWI9ndw4zdx70Ci3fa/JMbZxY3YPyCyuZosXdsmVZfFjfC8TgOkbhFtxT
         xFP/pXth4xkPdv95pwOzoQ33Te4SxeeS/OtBJNsRKg1kMY4JNOyw0wtAxTv96LkR2mZ8
         nt9Q==
X-Gm-Message-State: AOAM532qe1TiB9d5+mkTarVynzWHZF6YlAa3SdHihBY75ZoyRqH+UDtu
        yob24Vsd7+HvgHcAf0e0/g==
X-Google-Smtp-Source: ABdhPJwPDIe0g7pk3UVu2o34WL7sYDs4/dNMi96D6by4g0wYa0lbzNavWIaMW4P7PgWvfVWSbF0FqQ==
X-Received: by 2002:a05:6a00:3011:b0:4f6:dca6:ece1 with SMTP id ay17-20020a056a00301100b004f6dca6ece1mr8588830pfb.75.1646977536008;
        Thu, 10 Mar 2022 21:45:36 -0800 (PST)
Received: from sh08423pcu1.spreadtrum.com ([101.230.211.98])
        by smtp.gmail.com with ESMTPSA id o5-20020a056a00214500b004bd7036b50asm8962653pfk.172.2022.03.10.21.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2022 21:45:35 -0800 (PST)
From:   Bruce Chen <brucechen251@gmail.com>
To:     bruce.chen@unisoc.com, rogerq@kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, gengcixi@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
Subject: [PATCH V2 2/2] extcon: usb-gpio: Remove disable irq operation in system sleep.
Date:   Fri, 11 Mar 2022 13:44:07 +0800
Message-Id: <1646977447-29598-1-git-send-email-brucechen251@gmail.com>
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
Acked-by: Bruce Chen <bruce.chen@unisoc.com>
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

