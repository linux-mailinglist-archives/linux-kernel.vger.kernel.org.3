Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13B485B51
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiAEWID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiAEWHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5DC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f8so372538pgf.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hXPYLXq1MtkTPGXtqCysJ+W+nq8t1JiCUfo0gaBJlw=;
        b=nGrTARLs4+3cfsjLMlzz7N94nnJDVba3ZJ6CdB7Q4JsdxuwPNQXBSQcxqUn7eCb0L+
         TOaHfaw51UDxR5nmPAsv+OZMAjBrhNkhiBsCfHgFYPMSAVS0tCW0aCJdwd1mpYR3DMAj
         xeXL/TRBH98PogIYFP604DPMzaIm+dC0xeRtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hXPYLXq1MtkTPGXtqCysJ+W+nq8t1JiCUfo0gaBJlw=;
        b=I7XqbGzyo6KLuBp5tnuVL0yR+9jZltlrargTlvFU3LH9h1Wk/wEayRAbyA6bnkIOkG
         nXK3xmZqllrmnADzM6WPC9+DnmvJLXCCYRCpw/lLBPLCG/2uP6zPXcvZZro87P650cyb
         jWh9Avbr22bRJ1K2XJDD3eeTuTPVSQZzt9Uc4UTQQfPuJxoJAHlsoyuhbx92c5ot97kq
         g4yLsWuXmH/Vt/JW+c7Grcf3C5AMJm7RPgil2npkPdJupdE4Ee7i2FIOdsScavd0wwCO
         D0okdoGltEX17SU2/edX7cNZYeLOjVjrfy30kGiDW2ViWJrHeMa63s/HODYCM+q/yVcF
         Xhgw==
X-Gm-Message-State: AOAM530LWhKIwc4UJCNAirGKtaxqgpLh6wU+xo5QUfzoch1agb26+0PF
        a5NQPhqTbAhtsi4GGtWZNQOkcg==
X-Google-Smtp-Source: ABdhPJxvhfa1Ex/LHw/C2D6yVqA6xUKyno4gWswS2bJozmLynbgvNw0OohyaJXbxMv8crooAeWZ/bw==
X-Received: by 2002:aa7:9f09:0:b0:4bc:683b:439 with SMTP id g9-20020aa79f09000000b004bc683b0439mr27414049pfr.86.1641420440843;
        Wed, 05 Jan 2022 14:07:20 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id w4sm3577505pjq.7.2022.01.05.14.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:20 -0800 (PST)
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
Subject: [PATCH 09/17] extcon: cros_ec: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:45 -0800
Message-Id: <20220105220653.122451-10-gwendal@chromium.org>
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
 drivers/extcon/extcon-usbc-cros-ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index 5290cc2d19d953..53f5a568d86716 100644
--- a/drivers/extcon/extcon-usbc-cros-ec.c
+++ b/drivers/extcon/extcon-usbc-cros-ec.c
@@ -540,3 +540,4 @@ module_platform_driver(extcon_cros_ec_driver);
 MODULE_DESCRIPTION("ChromeOS Embedded Controller extcon driver");
 MODULE_AUTHOR("Benson Leung <bleung@chromium.org>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
-- 
2.34.1.448.ga2b2bfdf31-goog

