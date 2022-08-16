Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DAD596453
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiHPVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbiHPVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9203579A55
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e27so9338122wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=K+0T7eMnG9viH95X8ZDAFfAxPVbDcFvb4w8kFF6bgj4=;
        b=g3/pLiY7c4wVtmnZ76G9FV0R9hlwFRQW0Pla5jQl6kNNkwbWldSnhVaeivjNwCPNCT
         xVzF3Ebgz7IzBp8X4RO8foOLbyi5WX87QGwIIt9U306als7lAskZDrYBQ8iOkBTLmmHa
         z63NJItmGdga42drDCqV5xKjVTyp7zc+G+bXa/DNsJoccOxV15L33Y3h5A9hdOddcVKE
         aWqjBjavYtOa3Z0W1oGybM0j+AtQ96ZRMaTADLP6cblMvRmtYLQbaNGWKiM1UaKLERRD
         u49rrzKHv4pSESi2uVSV8TzhLKgXQkDVgYl0aAPvwcZ03xfLhbk06TSd+6PHU7UD0MsL
         CuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=K+0T7eMnG9viH95X8ZDAFfAxPVbDcFvb4w8kFF6bgj4=;
        b=CRdkd6OfJPkJMS+CO0nwSkNU0EOzQMBu7wK+q17tah3upkI3WA4pV6QMC62m0QZ8H0
         98iDmsQL//HNI6VmPVjq8/2HnXnTL4JLPO2rd6FRnWAmxz00oMwnP6Yudf9iJcZu0SbL
         6//QX8dfuD4qP1oxz39XKk4ZH5y83wIuBpVxPv/L2Ii+UhHZ2eAZ6J8MH8+aT2fLnbgM
         U8aCfFL5fJuEcpCFCJNwPuBINUhkIh3l+tmbah6Hh4ve8jczeWgeoNXH7V1muBfSu2yi
         S5AgvQ+vxRgBvH308JL4i0sG1VnkTDbehuJfu1yMev8MnrGUNNMOpPQPxrucG9SBkf5N
         /J5g==
X-Gm-Message-State: ACgBeo35SKKuujYDFVPLZ5d2jOhrtU+dUQnVkWNkI4Ui5N72h+4gEQka
        GFs6W4WWdnb+bX+cwiaKvuBswQ==
X-Google-Smtp-Source: AA6agR66IDGpcoJmlcZn04Ud0H7wCd2kl/mx2pHl7iw36roYxeJwHuY8Zq5uBiH/Gl2JDBCBKijTJw==
X-Received: by 2002:a05:6000:1e19:b0:21f:c32:f45b with SMTP id bj25-20020a0560001e1900b0021f0c32f45bmr12876665wrb.657.1660684502192;
        Tue, 16 Aug 2022 14:15:02 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:15:01 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 07/10] pwm: dwc: make timer clock configurable
Date:   Tue, 16 Aug 2022 22:14:51 +0100
Message-Id: <20220816211454.237751-8-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configurable clock base rate for the pwm as when being built
for non-PCI the block may be sourced from an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - moved earlier before the of changes to make the of changes one patch
v2:
  - removed the ifdef and merged the other clock patch in here
---
 drivers/pwm/pwm-dwc-pci.c |  1 +
 drivers/pwm/pwm-dwc.c     | 10 ++++++----
 drivers/pwm/pwm-dwc.h     |  2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
index 2213d0e7f3c8..949423e368f9 100644
--- a/drivers/pwm/pwm-dwc-pci.c
+++ b/drivers/pwm/pwm-dwc-pci.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
+#include <linux/clk.h>
 
 #include "pwm-dwc.h"
 
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 90a8ae1252a1..1251620ab771 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
@@ -47,13 +48,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
 	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    DWC_CLK_PERIOD_NS);
+				    dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -128,12 +129,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	duty += 1;
-	duty *= DWC_CLK_PERIOD_NS;
+	duty *= dwc->clk_ns;
 	state->duty_cycle = duty;
 
 	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 	period += 1;
-	period *= DWC_CLK_PERIOD_NS;
+	period *= dwc->clk_ns;
 	period += duty;
 	state->period = period;
 
@@ -156,6 +157,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
+	dwc->clk_ns = 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 68f98eb76152..e5a1f7be7bc8 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -41,6 +41,8 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	struct clk *clk;
+	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-- 
2.35.1

