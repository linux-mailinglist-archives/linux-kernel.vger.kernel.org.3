Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754DE485B59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbiAEWK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244952AbiAEWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:08:22 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A608DC0611FF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v11so576473pfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnF/PMMXPgqrzjGZxNd1Cfi5pPniRXa/jw39Jq8eJUY=;
        b=dteM1IkhUOToqUOluSnJ0ckjadPywtJbsK3R27MYd6/MnsSEU5fkedN+x1bGs0nbJk
         4mOh1R64TgRxG6iNWHCXCIXB+2pLR2cn7628eLrlC1/XCK2+JRfMw88l+QUOlA5BpETK
         TVPVe4UKeR8Dv5ZNa8f15L9Df4kFcTP/JVRqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnF/PMMXPgqrzjGZxNd1Cfi5pPniRXa/jw39Jq8eJUY=;
        b=BKbErhQk+nmCkBv1Vn5myqjvwof+8MEjA12AqhVTf4HmVfMRBwJd/lmxsLqna3jS2L
         eQEAyELklwo8hwRAnxftoF5zS7YsZSHXbQ1kZrJ5NZjkHw0EuIozVFt6zSCsCBnzFQUe
         tC4cRTDpm5KZ/rfZzqIEoZ5aAbg3LfsOu3pMnFaGSS4kgoiRgdg3rkkyf8GEitQ4W0/Q
         ukyGOShQAILtNB1n6L+R2A1l8Bm+4cCJScFji1i4WrnE1vCkgtt+pNWhgcpY3r0o9q5R
         I1IxPLCixAWubfLWdxAm5xdgPDasSXFe9maiz5eZ5j/j2jN6UJtONwHXMQs/NizRIfP7
         ZzOg==
X-Gm-Message-State: AOAM531gcLQgEFzD4zEPwo8uxEU7XnxY0mTsVcI/4UTXQ391YFkEhVqZ
        TmKeoZQplsN2wnrLCYcUwCZSjA==
X-Google-Smtp-Source: ABdhPJzA6rNMxTpCHBpNVAk+T8oWyyI1sooyCvffmIDPRC9SvASw6Unguv/Tm6Ao1sVb/NItxiOB9Q==
X-Received: by 2002:a63:754c:: with SMTP id f12mr43111552pgn.117.1641420451126;
        Wed, 05 Jan 2022 14:07:31 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id c9sm92012pfb.126.2022.01.05.14.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:30 -0800 (PST)
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
Subject: [PATCH 14/17] power: supply: PCHG: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:50 -0800
Message-Id: <20220105220653.122451-15-gwendal@chromium.org>
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
 drivers/power/supply/cros_peripheral_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 305f10dfc06d1b..cb0d63c9a2bd80 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -382,5 +382,6 @@ static struct platform_driver cros_pchg_driver = {
 module_platform_driver(cros_pchg_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC peripheral device charger");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1.448.ga2b2bfdf31-goog

