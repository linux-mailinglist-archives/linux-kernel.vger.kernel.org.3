Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4693A485B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbiAEWKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244800AbiAEWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:08:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC1C034009
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s15so568458plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmPwj1yOwBd+EF1I85zf+qGSCnfmjN7sFhS5puTzvsc=;
        b=DZU48yXC+Vp+e2vfoEhwJWDgv6iQe0pd6dQhHsSEDQMv9baDCyNxyrS+0rc6Ol6JFA
         xVMZN6yszLH3zkcO4OOEAwSihEVVB9RdM5gtHIeybPI0k426uRyTqmZwPbTrlfvm0DRm
         cSCpY7aGjLncp9j2EhuOjsBujZZWkn/TYRIw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmPwj1yOwBd+EF1I85zf+qGSCnfmjN7sFhS5puTzvsc=;
        b=P+wAB21a7fzhGydoVpfZZHeBfoFhGtgd8zW5D3ZEx6QxADbM6/3b4vyWuA9ye4RdFY
         9aomYkm2R6sT2mj8Md7kRhvLj2JaRCSWvXXFsLUhxqEE3nYiCokRDv05GE1FYHVFxJPX
         rt43BLA/jbKecfQu9jn8t3ClzcI3GUxKDi8v8iQyEctj11M5tMK3q2X1MnRS1pepd63z
         AGskBuPJcHZ0PwOhzAt3EAJgYXl/CKnkvXoCNCRMUVXQtqB5r5MUJXZGy9a4VSeW/kuG
         IJlNnvtWxubumCSDnMqEHI80iMlik5XyrizpvnsLBP0pK/pd80izHEA6T09EAxT/vZnJ
         9Tcw==
X-Gm-Message-State: AOAM533rPXhbEJgVOGEAvSjLkmAlnFmoHb00tNDf3SsIwpXY6tEFl/pw
        HtOhtV3hn24f/xg8D25pWDnoPA==
X-Google-Smtp-Source: ABdhPJyFOfkEcOaXf3yLbeUGCYHalarllypGV3+2iGk2L2yowg6C/my2JG/zdleoJ2vQ44OnnCJR0Q==
X-Received: by 2002:a17:902:8d8d:b0:149:2d7c:da6c with SMTP id v13-20020a1709028d8d00b001492d7cda6cmr56449582plo.134.1641420453232;
        Wed, 05 Jan 2022 14:07:33 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id 145sm25309pgf.88.2022.01.05.14.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:33 -0800 (PST)
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
Subject: [PATCH 15/17] pwm: cros-ec: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:51 -0800
Message-Id: <20220105220653.122451-16-gwendal@chromium.org>
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
 drivers/pwm/pwm-cros-ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 5e29d9c682c34f..c180c5bab2a4b0 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -306,3 +306,4 @@ module_platform_driver(cros_ec_pwm_driver);
 MODULE_ALIAS("platform:cros-ec-pwm");
 MODULE_DESCRIPTION("ChromeOS EC PWM driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
-- 
2.34.1.448.ga2b2bfdf31-goog

