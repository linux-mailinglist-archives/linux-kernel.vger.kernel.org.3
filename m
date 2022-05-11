Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E024A52366F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbiEKO6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245329AbiEKO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087AB67D3D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g16so2976553lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4Cgf9CCBKn83g7/KBEuaNwcj4g0FN5Zjd21HT3ZAg8=;
        b=hARKzpbiibT8wZ6cRWUlNHAwxXB5ahdvlALYyO4z7iYJ/yCSbhsYiJtQI0b061QvaB
         T0z3ZQBb4q5fHOnw2qdaT6iHhDbxL9q+Mfdv+7f5P3zo0BnrSW2LBdN/g4WTJCgC44qA
         JxLCfL9Ul1vPV6g2KIum0DMTwuxO+LzCHqvfATvnDhMZ92PnVR3U++ebLHY+eVrpB9zO
         /zmiXe6AH03O6DIUVtjYFgtNkPSZw0Pg1/L402McRSqNE3wzsKg1O81tG+7rDoCKFny9
         DEMiwBxLQTU5nZEqNitXnECE0negcXRGO3zmI6Rd0kjVRyl/l4fGxzoQRl2xZAXdhlM6
         30pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4Cgf9CCBKn83g7/KBEuaNwcj4g0FN5Zjd21HT3ZAg8=;
        b=Mfs/KStHXrkN8YFv8r8mrGMEdRdwtobZUEGhKs2UPSLggXKzWCYFEVl/yk4YokgKtu
         dUKL8G22q/7CBNs9NNh57Qg83vOLvroMdyPbu8dtXgJLKvsBmkTSJ/OoLPUtISQhZGP9
         4hk1Y4UhCeNCXGQJyc4IMqRGVLoby63BVPZ+eBcActZSLxmt22VomVBbmoVjsEzgqXyw
         gBUycZ9rkEZDs9Z2323g4BBWnlhcA+RIEqPkxK0D3zR9r78v+F1xNI5XrLVbnwkNTonK
         zMn788+EzkgVPDHVhzSTmuRGAODKmgmiDRIz3myAqe7ojxouE9LDfIFb3tztD33V72cM
         7PTw==
X-Gm-Message-State: AOAM532SSeqDuqKKKfoAFDPRylJMJVtOpun2F2Ojhlf19+5a9Edut4uo
        fSaKSh8pKct40QniGuAxJu+cVw==
X-Google-Smtp-Source: ABdhPJySa48Kx14B5FTFLVO2CgILH59wgRXZtob6dJ+mULnBA+aIcSCJKYUHN/PjPYbiMNiuK1hb+A==
X-Received: by 2002:a2e:9ad2:0:b0:24f:435:19c5 with SMTP id p18-20020a2e9ad2000000b0024f043519c5mr16893662ljj.281.1652281054470;
        Wed, 11 May 2022 07:57:34 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:33 -0700 (PDT)
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
Subject: [PATCH 09/14] PM: domains: Fixup QoS latency measurements for IRQ safe devices in genpd
Date:   Wed, 11 May 2022 16:56:59 +0200
Message-Id: <20220511145704.698189-10-ulf.hansson@linaro.org>
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

When an IRQ safe device is attached to a non-IRQ safe PM domain, genpd
needs to prevent the PM domain from being powered off. However, genpd still
allows the device to be runtime suspended/resumed, hence it's also
reasonable to think that a governor may be used to validate the QoS latency
constraints.

Unfortunately, genpd_runtime_resume() treats the configuration above, as a
reason to skip measuring the QoS resume latency for the device. This is a
legacy behaviour that was earlier correct, but should have been changed
when genpd was transformed into its current behaviour around how it manages
IRQ safe devices. Luckily, there's no report about problems, so let's just
fixup the behaviour.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cdfbe48dde0..48101232fcb9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -970,10 +970,8 @@ static int genpd_runtime_resume(struct device *dev)
 	 * As we don't power off a non IRQ safe domain, which holds
 	 * an IRQ safe device, we don't need to restore power to it.
 	 */
-	if (irq_safe_dev_in_sleep_domain(dev, genpd)) {
-		timed = false;
+	if (irq_safe_dev_in_sleep_domain(dev, genpd))
 		goto out;
-	}
 
 	genpd_lock(genpd);
 	ret = genpd_power_on(genpd, 0);
-- 
2.25.1

