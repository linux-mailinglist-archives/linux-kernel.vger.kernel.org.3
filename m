Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0364A465E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbiAaLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378850AbiAaLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:52:46 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13AC0797A1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:38:06 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id c7so18476970ljr.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8c20o6vm+QehnaH5SGz0nEPnQS7Uvpo1uJWmbdFZlc=;
        b=TBoqWZUVCECQVtQsmAoVuSv+8zXX5npwQzMT/o7dAdNDzUXMGpnR7gdfY0Qc+cV519
         DiMH8bfdYRd7qr2zaAy0/wwBxhIw0RZvqfmwviAjJgsXdFySxShr6sN6RsptFTN962o7
         65YJ0XJmI70G0PcoXT5IMxq86oClWUgzvIuafSL2K2UjGKhkGFS0RJ5usVIPs/HRPhnm
         r/cKHF+Nw7n5qe+Yw+34qwlAyP5vX/PKL+mTe+K+2wCL2yklRn83o2kFXCeFCbEW9t5O
         7BX4O+9Coot60HOEmq9nxcy9c7at/ZjIkDq/QhHfCW+Xj5KuJlSHAEU9kIQz0Bi8lRNz
         MKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8c20o6vm+QehnaH5SGz0nEPnQS7Uvpo1uJWmbdFZlc=;
        b=IzjLlZxZ2D8Ihjs39JNbQ6NkIdEykDcTquwFxfEjBNBJGZfREBMt41RPnzo0yW1Mj7
         9WPQns2dS1SoP++ad1n233et/+nVnzF8hHKl03g6fRWPsNHyYtbf4CaWH1kNeyAcPahz
         m2GlkgkIo7Q49JJc30XmdiWSfwfoyH4rJ1hy1a25GEYO1XLl+4WQUEK7eSPLAJZaLK1D
         LaeGV2h7DxYw6TFfkcWbFQ/zTasrefOFldb/MwY95+3VZYd0+5e+XHFpxJJ+eFpWOydi
         HmbvcREZBItY+KOZ8ZImW/U0p2+KW6gJwVTmLzfpnjcUM71pI2ZKyygA328WRMGz7OD0
         gH5g==
X-Gm-Message-State: AOAM532I1AMnkAkH3+R2Qi0WXcZGbfmTpyPRoY2MIYRnkXqU5GdtUiND
        3TmUKcEYn45/WHdSXvrsC7TXFg==
X-Google-Smtp-Source: ABdhPJy8MOQDAw//y5jxcHDGs1rFLfsXGOtR/s7UPuFneVxw+5BAwdjjbS/0n0t0JHKdNGYX6XNjpA==
X-Received: by 2002:a2e:a4bb:: with SMTP id g27mr13623432ljm.469.1643629083336;
        Mon, 31 Jan 2022 03:38:03 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id b8sm597682lfp.34.2022.01.31.03.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 03:38:02 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM: domains: Prevent power off for parent unless child is in deepest state
Date:   Mon, 31 Jan 2022 12:37:43 +0100
Message-Id: <20220131113743.52265-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PM domain managed by genpd may support multiple idlestates. During
genpd_power_off() a genpd governor may be asked to select one of the
idlestates based upon the dev PM QoS constraints, for example.

However, there is a problem with the behaviour around this in genpd. More
precisely, a parent-domain is allowed to be powered off, no matter of what
idlestate that has been selected for the child-domain.

So far, we have not received any reports about errors, possibly because
there might not be platform with this hierarchical configuration, yet.
Nevertheless, it seems reasonable to change the behaviour into preventing
the parent-domain from being powered off, unless the deepest idlestate has
been selected for the child-domain, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e71..7f97c5cabdc2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -636,6 +636,17 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
+	/*
+	 * The children must be in their deepest states to allow the parent to
+	 * be powered off. Note that, there's no need for additional locking, as
+	 * powering on a child, requires the parent's lock to be acquired first.
+	 */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child = link->child;
+		if (child->state_idx < child->state_count - 1)
+			return -EBUSY;
+	}
+
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
 		enum pm_qos_flags_status stat;
 
@@ -1073,6 +1084,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	    || atomic_read(&genpd->sd_count) > 0)
 		return;
 
+	/* Check that the children are in their deepest state. */
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

