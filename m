Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D46485B5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbiAEWKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244958AbiAEWIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:08:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9DC03400C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so5810829pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmflEUCABoTnqSal+13bydfVJCiYM57dU2wUKeszOro=;
        b=S0iM2Eb9eeZ4uodEvsx1ZzYro4D67VugK7x1y+7lL8Yb6v5/umTny8VbonkfEwa+fn
         Efe6WQEv3wTyBJKjO/+fu7IQjbLeJhLBwLe/qRdEkqIJ57TOYREhjnDCSvDlo1h0Y+nQ
         MxBTP3awV/mfw7WbqOx20yGxuXFLIUlMFVe64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmflEUCABoTnqSal+13bydfVJCiYM57dU2wUKeszOro=;
        b=Q7NoeT5OVZx4hcMTt3YiRZY26J9G/lp4RP/o7am20/lua3Bzt3z1TEzAlrLwTio20O
         NKi14I4Vq45g44SNpA3g+xTSash0EjrlrUhxjPf5cRBeJ1S5V6FculGHfuGZkOSNOzbk
         mYf7T2qlrPJAEx8kZr1PbF4b7zE3MSWBlrUEq/Gv22y33wet7dWo0tIFmghtCYp+mGlS
         ADbvmQIUWViLlelfPvtaBF7pRwfKf0NIurtW7unfJ97AkJvLeD/xNiR1pNc061woQUmJ
         Pn6u4DaOn7g4oYa23XcpUZjQnL+rBt11Go+2gYhSGAMjuolbVH5GiWqjakfFYVv6Ay4Z
         PoBw==
X-Gm-Message-State: AOAM532WPnB2WtohATJwjXJkq9e2zO1EEKRZrEvi1x5Fg1u5/1OpMm8h
        +06WXvSG2ypyNnk+nLa0vtRcPQ==
X-Google-Smtp-Source: ABdhPJwzH/3tQdQC2Sv6Bk7VQB+IAc3Au/Zbt/bCCMq1EzO1tY0Lnpywu9HdO9JO+LpGFkWL0dWGzg==
X-Received: by 2002:a17:90b:1e0d:: with SMTP id pg13mr6571119pjb.140.1641420455133;
        Wed, 05 Jan 2022 14:07:35 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id j190sm26428pge.70.2022.01.05.14.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:34 -0800 (PST)
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
Subject: [PATCH 16/17] regulator: cros-ec-regulator: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:52 -0800
Message-Id: <20220105220653.122451-17-gwendal@chromium.org>
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
 drivers/regulator/cros-ec-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index c4754f3cf23377..4bdd6a90700831 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -252,5 +252,6 @@ static struct platform_driver cros_ec_regulator_driver = {
 module_platform_driver(cros_ec_regulator_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC controlled regulator");
 MODULE_AUTHOR("Pi-Hsun Shih <pihsun@chromium.org>");
-- 
2.34.1.448.ga2b2bfdf31-goog

