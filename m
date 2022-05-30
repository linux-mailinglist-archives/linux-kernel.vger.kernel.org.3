Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A45A537664
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiE3IJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiE3IJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:09:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972037522B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:09:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe5-20020a17090b4f8500b001e26126abccso6784533pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FScl+UqRUK2zjAGIdnpLvBJ2sZzcfjY6lr/T8iYlos=;
        b=dYormkjv9tBgqAMnTu37VmgqDlxDGlFXue/fz3cho42K/yVjCGbD8zxALhzpMBMgwl
         JZXJMANAES1GQI8B30K4cIMon6oo/4Duoho54Uec6WlqFfxLWq1yXOKhNaehzFIcu/6d
         D4RgACl+MDeGro5q94U4/EolUn4H0qAv6uQaea59Py4tqm5AWkh54C69YQjlQdHnTIBA
         vnPMooKNk/Uw98pna09Ymi8JN5EOzQIb5poDZ8SSG4YkGoaDZOSflOXpS46U+2upC9aN
         bL2tuShijKJnklTSelKPV/vys6638aKnPUmAYPys83WQjcPUpBsjfIp0m7eXdBfCc7YK
         EHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FScl+UqRUK2zjAGIdnpLvBJ2sZzcfjY6lr/T8iYlos=;
        b=O25mNTqQUZaaqAb7WDuisDSEF6kDM37yUGy5wU5+0NYkO8txb+p5XZ0wLnPegCwzqa
         ffo5l6uye5FG5H8lVuCLPQPbjKhYFgJkr7MytHsE+yV4N/FdxVXuo2XOVMxcABeaHrZG
         RYJRuwCW2XspqVemYYufTcNRBDWO0Vj4xxxWJK4SJX1ARdAfEYeHrtPvrk61cm9BbD6Z
         ger0B4lVI90eKpcTE7Ua7A0qw+Izeutf+t1uBk3klu4ZPbGH0NqRqKJdumaD8R55DHOi
         9jWBssVZ+9+O4CcSxwY4zydWv21tqP02gnXRNXNAQa8xNg/MpnKQGyT8f5BKoELT8hmF
         Hctg==
X-Gm-Message-State: AOAM5312eVBPjgtVyBcnSECG+cnxmBDbn+FHoFpgOwsP4NTNvCx9TNcb
        9ZgGMzcxT8vrf9nOQngBmqXWoGkdO3Nt
X-Google-Smtp-Source: ABdhPJzgQqCsBR3izTUVdM/YjZC4G0IubuAotr/OnzoFZGctfNMTJcbl4DyQ5Y2vXr9SY40Un1R+ag==
X-Received: by 2002:a17:903:11c7:b0:151:9769:3505 with SMTP id q7-20020a17090311c700b0015197693505mr54926412plh.72.1653898141679;
        Mon, 30 May 2022 01:09:01 -0700 (PDT)
Received: from localhost.localdomain ([220.158.159.114])
        by smtp.gmail.com with ESMTPSA id io17-20020a17090312d100b0015e8d4eb285sm8450345plb.207.2022.05.30.01.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:09:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     tglx@linutronix.de, maz@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] genirq: Check for trigger type mismatch in __setup_irq()
Date:   Mon, 30 May 2022 13:38:42 +0530
Message-Id: <20220530080842.37024-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
References: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the trigger type defined by the platform like DT does not
match the driver requested trigger type, the below warning is shown
during platform_get_irq() but only during the second time of the drive
probe (due to probe deferral or module unload/load).

irq: type mismatch, failed to map hwirq-9 for interrupt-controller@b220000!

Consider a typical usecase of requesting an IRQ in a driver:

```
	/* Assume DT has set the trigger type to IRQF_TYPE_LEVEL_HIGH */

	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
	if (q6v5->wdog_irq <= 0)
		return q6v5->wdog_irq;

	ret = devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
					NULL, q6v5_wdog_interrupt,
					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
					"q6v5 wdog", q6v5);
	if (ret) {
		dev_err(&pdev->dev, "failed to acquire wdog IRQ\n");
		return ret;
	}
```

For the first time probe of a driver, platform_get_irq_byname() does not
return an error and it sets the platform requested trigger type. Then,
request_irq() also does not check for the trigger type mismatch and sets
the driver requested trigger type. Later if the driver gets probed again,
platform_get_irq() throws the "type mismatch" warning and fails.

Ideally, request_irq() should throw the error during the first time itself,
when it detects the trigger type mismatch. So let's add a check in
__setup_irq() for checking the trigger type mismatch.

It should be noted that the platform trigger type could be IRQ_TYPE_NONE
in some cases like IRQ controller inside the GPIOCHIP. For those cases,
the check should be skipped.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 kernel/irq/manage.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c03f71d5ec10..dd28c4944172 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1480,8 +1480,18 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * If the trigger type is not specified by the caller,
 	 * then use the default for this interrupt.
 	 */
-	if (!(new->flags & IRQF_TRIGGER_MASK))
-		new->flags |= irqd_get_trigger_type(&desc->irq_data);
+	flags = irqd_get_trigger_type(&desc->irq_data);
+	if (!(new->flags & IRQF_TRIGGER_MASK)) {
+		new->flags |= flags;
+	} else if (flags && ((new->flags & IRQF_TRIGGER_MASK) != flags)) {
+		/*
+		 * Bail out if the default trigger is not IRQ_TYPE_NONE and the
+		 * caller specified trigger does not match the default trigger type.
+		 */
+		pr_err("Trigger type %u does not match default type %lu for %s (irq %d)\n",
+		       new->flags & IRQF_TRIGGER_MASK, flags, new->name, irq);
+		return -EINVAL;
+	}
 
 	/*
 	 * Check whether the interrupt nests into another interrupt
-- 
2.25.1

