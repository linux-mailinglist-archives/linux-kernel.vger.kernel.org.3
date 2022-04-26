Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A3510038
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351549AbiDZOSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351543AbiDZOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:18:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B5E140FA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w19so32175690lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=ej4+Bx6xsGOH1fAYVCANQZk2dOz8IPnGV43ikFNr5907fDFzF+LC4hNSwjs0yUKphb
         LlQcAqu6SYB9cIITtCLUcl14KCtEhMawPgVduTYHzdTyrwCcgKnmedX1eQzkzjB37JHO
         zGCMPlgOhE55LQG7hJQHMcjjXWkik63SJIlvlZ6KMauZTOGgCVkgZ+yba7liNdFvAG1l
         i139SGagphUzRBobjJet6dT0uNxatiQJ096u8Pql+KL2VIFCp9abO9Y+Lwb22wbZfyhp
         EgtzT/D/fSyXw7+PFyCHJAWKS72toMh8bBDR7dlI2y+aoy7j2gcl8MPM8ADmiqwFN2iE
         vXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uWDDfHKgK8+yoOD+Pzrd9WOCbfsrsht1ynrIKudfso=;
        b=HisimikvREgmVegwNXqcv0DuMw6V+pQ2ndRz3xP5U2nMVCixcEBpxsp660CeOpeN9K
         usg48hlGlPlAbyNpSB2cD2ufEmg9psgqPAopL8xegOtGXjxyq706eed2fcutlcC7B6CW
         YQZK2H4XVxKfpClTlhp2Jhp9BKG9qg/UFe2VhIGvapN64vqJv4G0w88DTTuXIZK5U9YQ
         CKL5rZenAtpKbpFjxC5L09ts9r89TMR8OveQgvFca94Vfcvki0dCanWJ9fU3ncjDOd/q
         +1RQ24TgjbyZxMB5O7PqcV2p3+Fj/X/6Xr/Jg9AyNrY2xhhFqiXr6M1MceMF7Ti+H7Wd
         VPkg==
X-Gm-Message-State: AOAM533phrwXG+IP3BqB3/iCHAmI0G9Ny3WVabdGaZYQN0687oWCIc7S
        eoo3h/rVZHNYzmIkWMhCqSY7KQ==
X-Google-Smtp-Source: ABdhPJzVJYvpLNFNnLneCLs3awIMzJab4hFZqee6Y1nyrzQD/yDf8uZ2syfAyE7PbC6lRc5j5FlZkA==
X-Received: by 2002:a19:4f53:0:b0:472:1714:61f1 with SMTP id a19-20020a194f53000000b00472171461f1mr2746170lfk.473.1650982533737;
        Tue, 26 Apr 2022 07:15:33 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id g23-20020a2ea4b7000000b0024f096abebdsm1043360ljm.78.2022.04.26.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:15:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PM: domain: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
Date:   Tue, 26 Apr 2022 16:15:07 +0200
Message-Id: <20220426141507.89868-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426141507.89868-1-ulf.hansson@linaro.org>
References: <20220426141507.89868-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

