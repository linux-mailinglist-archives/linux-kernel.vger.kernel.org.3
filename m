Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45481485B55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbiAEWIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbiAEWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69843C034003
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u20so533055pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwHCgu3nA5zqvhpihq1aWR3KXP3h6zIlCwkSG2KH8PM=;
        b=fe0q7N9+J4wnhicw8nDDKBLnkvlLKWmNPsic/8nCu4lCwXrFopROPpadW7IifA3RUG
         Ro9hdFOpyNpkj0WGcHthyDAYKRMS8jxm7xZ6An3LkUzmO0OqeSq2+kmN6AJcY1Dgw7DF
         8J4+FUacr37W6uthJvIBu1KNX0yNdmyuxtSt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwHCgu3nA5zqvhpihq1aWR3KXP3h6zIlCwkSG2KH8PM=;
        b=tMAGHqq8SU1myWR4IrXyuFforTAJnvcuOtzaMgI0q1yqC6bp9LdaBwrVNzyPKzQq6x
         oRKQwS0vTMtRYkLT9yOTv287gySGNz/bHDYXInRehneBRHsSGse4MIaY6eQtKIf18bWL
         1JQeBhdM1m8Ln7xsmizxJpnRpxkuAEsjb7cpDBICEDeC7mlT6rjSnQPl5RixgFkmBtt2
         3hwQi/zT47GhRd9YRaOFK2zuDSJB3Yt/uSz8JDLG2fU80h0ZJ8jfdi3HliaoTG3vTPYN
         zKegjgUtC0T3O/JHlFCB0C0R77sdjuFkm/aN+0nPzyJr/iHkhKsDLM0Zh2BxBUpWGdUF
         C/Bw==
X-Gm-Message-State: AOAM533HOUf9jWvED+ydPLx+OceKlcYPwIADW+HTGWH187HYVuNczhzL
        FJ8ST8/2ZmwE6SHU55IVbLvfhw==
X-Google-Smtp-Source: ABdhPJzOUqm5qMuC9x9PT+ByRJI6fZDbopiBi9xYB4vqKDGpoCtqEyRt7WDvJ9HrHjU8NWr2Ee4agA==
X-Received: by 2002:a63:7a05:: with SMTP id v5mr49603763pgc.83.1641420444972;
        Wed, 05 Jan 2022 14:07:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id g5sm95108pfj.143.2022.01.05.14.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:24 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, dtor@chromium.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, lee.jones@linaro.org, pmalani@chromium.org,
        sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 11/17] i2c: cros-ec-tunnel: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:47 -0800
Message-Id: <20220105220653.122451-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220105220653.122451-1-gwendal@chromium.org>
References: <20220105220653.122451-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'make nsdeps' to add missing dependencies.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 790ea3fda693b4..05a4eeae362100 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -317,5 +317,6 @@ static struct platform_driver ec_i2c_tunnel_driver = {
 module_platform_driver(ec_i2c_tunnel_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("EC I2C tunnel driver");
 MODULE_ALIAS("platform:cros-ec-i2c-tunnel");
-- 
2.34.1.448.ga2b2bfdf31-goog

