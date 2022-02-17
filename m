Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF14BA05E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiBQMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:50:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbiBQMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:50:15 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25162A82E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:50:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j15so9709656lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlbNkhTQ+JSJKTYaDJQdA6zDHlk4vRYEdRPsoVx8JIQ=;
        b=RJRTgcanFd+eYKC4PMy5E0XR6182Cq2/81omogO1Ye2RHCRnwZhXxRU7nmB+QcQ7Yo
         KfDKHK0lAjHiQycNkeabsFl/Twov5I/ktbWPBDANLnS2zOStQaOpEbd1O1TU9COmbXP1
         GreyjpJc0J56h41Ykhk0K17BOXfRUAFQT2eAA5KdBUfs05QT1B2HQ1ygKyVbJ9/9y/U7
         cxl/5tVYCIv6XV3jAPHJAU/EW5dnON50ZLMM1c4uNehw71p7GbRh3jI1rEUUDoAYiH8Y
         LXnMC9YzHrHSaC7la+CqDN020i78xjUsHBndmk9xfiU2TxHglUOliqwSoJsRlvD2gZF2
         6ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlbNkhTQ+JSJKTYaDJQdA6zDHlk4vRYEdRPsoVx8JIQ=;
        b=gQvfc8U1KP+htCVoCgUQS+xqS6iPZdTNDL3jZVA7pBlgV0+jOvX+9ErEgQuwZGW02x
         8PkBFH6U3UDmefcI2FNMxhD4L9ATStMDbQ9I6ct6lFu8WEXHffOX1Lgv2seA4Ct6O43j
         n1vYVX3JCm/bEZl0gwy2E75Z3kEYXCUMjWgj5lVO3+7WJ5jabJfLazMEryOweQILbvqJ
         kGE6wFK0ocTru7RHyt43Vg6GfaAtXTytbMiJhT42SJwajt/yNBkAJ1EEhC6aqrtrCjNm
         5whEUVtRctekyIj1z//hlfe/VXv9j7Lfm3YISBOi6WCzJCtBtZOI5w4JqLGzk4ldth5k
         4KmA==
X-Gm-Message-State: AOAM533Y/L6cDXyv4MOmRXXjPQwI0eiMpm7i0eoOgbymwTma+9YDjP6q
        NC2QU/Qas5joa6ovMw0qwAR9dw==
X-Google-Smtp-Source: ABdhPJzcmJ+l4mFBjZY1/rS9B+sgadxfC1rTyFWFVI0vf+IQ2g6MOXACNGdIQZNWEOgWTuA9h0OMPQ==
X-Received: by 2002:a05:6512:400c:b0:442:c12d:7755 with SMTP id br12-20020a056512400c00b00442c12d7755mr1875995lfb.403.1645102199245;
        Thu, 17 Feb 2022 04:49:59 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id p21sm5167094lja.32.2022.02.17.04.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 04:49:58 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: domains: Prevent power off for parent unless child is in deepest state
Date:   Thu, 17 Feb 2022 13:49:50 +0100
Message-Id: <20220217124950.211354-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

A PM domain managed by genpd may support multiple idlestates (power-off
states). During genpd_power_off() a genpd governor may be asked to select
one of the idlestates based upon the dev PM QoS constraints, for example.

However, there is a problem with the behaviour around this in genpd. More
precisely, a parent-domain is allowed to be powered off, no matter of what
idlestate that has been selected for the child-domain.

For the stm32mp1 platform from STMicro, this behaviour doesn't play well.
Instead, the parent-domain must not be powered off, unless the deepest
idlestate has been selected for the child-domain. As the current behaviour
in genpd is quite questionable anyway, let's simply change it into what is
needed by the stm32mp1 platform.

If it surprisingly turns out that other platforms may need a different
behaviour from genpd, then we will have to revisit this to find a way to
make it configurable.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Clarified commit message - based upon discussions with Dmitry.
	- Updated a comment in the code, suggested by Dmitry.

---
 drivers/base/power/domain.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e71..c87588c21700 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -636,6 +636,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
+	/*
+	 * The children must be in their deepest (powered-off) states to allow
+	 * the parent to be powered off. Note that, there's no need for
+	 * additional locking, as powering on a child, requires the parent's
+	 * lock to be acquired first.
+	 */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child = link->child;
+		if (child->state_idx < child->state_count - 1)
+			return -EBUSY;
+	}
+
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
 		enum pm_qos_flags_status stat;
 
@@ -1073,6 +1085,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	    || atomic_read(&genpd->sd_count) > 0)
 		return;
 
+	/* Check that the children are in their deepest (powered-off) state. */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child = link->child;
+		if (child->state_idx < child->state_count - 1)
+			return;
+	}
+
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
 	if (_genpd_power_off(genpd, false))
-- 
2.25.1

