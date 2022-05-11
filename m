Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639B523663
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiEKO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245272AbiEKO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73074689BE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m23so3011461ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=V/31BKjOnBuESidovgo43nJAiR5JKlgrJQNGaqAU7dLJYVdepjBNzq/lWLJ3slYo26
         U4eIVgIrMQdYdFTd8FdkEY5FpiBtaZHls/kyWiY4fDVb0JxB7NO7CQFVZ3rPJ8NhoknG
         6G2aHdMCUOccjL6eDyV6ug/xMELBa7zfwKIBY5Wd43/rILca53Mgbr+rswKI1vrZZoJ8
         ZhICBFSbfyTRBMUbPxQPbyXM1xULVhx0BLriddMn2PKiS314ftTcApyCJO/ifMVpT+pK
         dT9d4+Y2h6DSBMQocdEQwMsVeWYsiPgXsENadyV/vcD9SUISHpTHg+EY80rl+Yerf+n3
         RH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=kuIXlTH7t591leyWMowHhNqtc1IYVduWwYUTQaY80GVc48Nm0IOsPejpsUvV2tUCPb
         FChyAh9nMRIClij9kbqTzOevG2aeIxX6gt1rAm17vilcU/Hq74demlUVsltoC/wRSQY3
         xgLNnTlfMMeFIlhiytS+svjr+RWYtPy8T6W8Ur9GjG+Zy63FxDIHnc9oAkfpXZAePZou
         IZbpGTOG+RoO0ACnsKnLQP4LoIPOL4WXqdwXpX7w3dCR/4brOkb/Ahc7XFnReqX1KuGT
         4TWNDWmwkmbtttEyTqEzy0/nvD/2Td+rj6OkPyJykT0ICndNox9ftpEl9zJRRVZydj5v
         o9kw==
X-Gm-Message-State: AOAM532knmHypdfqOI0WIJWKg1XIchkijyzO96wNc9EzB3sbbJR3AZMv
        dYx1JeKLVOALUbSJ85AsskctTocjWXZjZg==
X-Google-Smtp-Source: ABdhPJz1+tPV+8eDT+kPK5sJaKCDGNqX6EPItVfc9C6kKk4dAZILCFEIkrqbrtFC5Dyum/eekyW7+w==
X-Received: by 2002:a2e:a30a:0:b0:24f:8e8:76a1 with SMTP id l10-20020a2ea30a000000b0024f08e876a1mr16880346lje.14.1652281043856;
        Wed, 11 May 2022 07:57:23 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:22 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] PM: domains: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
Date:   Wed, 11 May 2022 16:56:53 +0200
Message-Id: <20220511145704.698189-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in the days when genpd supported intermediate power states of its
devices, it made sense to check the PM_QOS_FLAG_NO_POWER_OFF in
genpd_power_off(). This because the attached devices were all being put
into low power state together when the PM domain was also being powered
off.

At this point, the flag PM_QOS_FLAG_NO_POWER_OFF is better checked by
drivers from their ->runtime_suspend() callbacks, like in the
usb_port_runtime_suspend(), for example. Or perhaps an even better option
is to set the QoS resume latency constraint for the device to zero, which
informs the runtime PM core to prevent the device from being runtime
suspended.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 262bda9b56ef..5059c5d2e64a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -648,12 +648,6 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	}
 
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
-		enum pm_qos_flags_status stat;
-
-		stat = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_NO_POWER_OFF);
-		if (stat > PM_QOS_FLAGS_NONE)
-			return -EBUSY;
-
 		/*
 		 * Do not allow PM domain to be powered off, when an IRQ safe
 		 * device is part of a non-IRQ safe domain.
-- 
2.25.1

