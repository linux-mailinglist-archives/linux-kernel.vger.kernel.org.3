Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62548500C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiAEJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiAEJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:31:04 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BC7C061761;
        Wed,  5 Jan 2022 01:31:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s15so1527227plg.12;
        Wed, 05 Jan 2022 01:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZBmxyewWms1KrYXztFWih7Er/l+XYzQ8+fEqfU9XnI=;
        b=Jd/sFXrRSZM7sCm/HU+M3AHtbLq7urUc61XVvF5FQzUzeClU0FCRb/E6ONLGmEj5yn
         XRGn/raoL860bBMwPP+L0zhrr+mPF8rUm4Fl91CEO0IBbaEHjX+YrqnWvP4mHbkg1UiZ
         t9QP/2DupmJ21I8A67/1AGzYN1ZQHMgFp81RvYo/Yay6bcg+1YOIFXL6SygNwE1UUxbK
         nRJTgLwq0bCKGIERIyi+1xKNgW9TY45Xux3pz9W8v3BpAFD5m30jjP3cOWE/l/IPWeDC
         x2M5DoKfVdd5nhlrxpL4UA3xC2OhtA2ozmLwpuQrWWeNEwzo03JT5ac+UPvmdGLG/5su
         hyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZBmxyewWms1KrYXztFWih7Er/l+XYzQ8+fEqfU9XnI=;
        b=YPxEQHuva/5haTggr/Oi+YNzG4Y2vSLGZs8mz/sO9IR+u4k3wb7STZlG4S0QOAcKXr
         GTTbL+4OfTmlnedlcfwoURc0V5YtyEek5C8TAaQlEbrqCxGKla0sX5voeBQpuMlMB8oJ
         pdiQMWc139xQcN4muR4epgJwxYOsqhWw+MeFSKhXjkHd6mT0IV+M7mZLBgpqtZ9uRAjL
         KjvZR6j+rRTOv7GhFvNS7zKWy+9PCxSp+catIJL2+GjB8/71E7HaQiOYVuIbVEGN3cdK
         6e8/uO9yQhit0kUAAe7Shva5Tyx83YisguCVBrIVrLP/8u/3Oi0kTiwkv2nf55sc6RTB
         i5pw==
X-Gm-Message-State: AOAM531ksxmPdIVsXdm7Hbr6jOPQWGF7OpnbpgW/cNeLY3kMCA8FvFoJ
        azJr502pWz5gE5YhnhSarCyDLGJOptU=
X-Google-Smtp-Source: ABdhPJwLMj8HzTiqJ/H3B/YWk8vGRaHRE/jmnbTA4rbRka4RwcWANV+08EefYLv9sbLRp9LiZcAV/w==
X-Received: by 2002:a17:90b:118f:: with SMTP id gk15mr3068928pjb.90.1641375063527;
        Wed, 05 Jan 2022 01:31:03 -0800 (PST)
Received: from localhost.localdomain (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id f22sm41375986pfc.183.2022.01.05.01.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:31:02 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH] counter: 104-quad-8: Fix use-after-free by quad8_irq_handler
Date:   Wed,  5 Jan 2022 18:30:52 +0900
Message-Id: <20220105093052.258791-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On unbind an irq might be pending which results in quad8_irq_handler()
calling counter_push_event() for a counter that is already unregistered.
This patch fixes that situation by passing the struct counter_device dev
to devm_request_irq() rather than the parent's so that the irq handler
is cleaned before the counter is unregistered.

Fixes: 7aa2ba0df651 ("counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8")
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1fbb3923797c..a17e51d65aca 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1188,8 +1188,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Enable all counters and enable interrupt function */
 	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
 
-	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
-			       counter->name, counter);
+	err = devm_request_irq(&counter->dev, irq[id], quad8_irq_handler,
+			       IRQF_SHARED, counter->name, counter);
 	if (err)
 		return err;
 

base-commit: 8f2cade5da97713e77ca5be576438f194b8873d7
-- 
2.33.1

