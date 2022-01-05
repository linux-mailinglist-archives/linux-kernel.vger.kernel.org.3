Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E071485B56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbiAEWIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbiAEWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:29 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822FBC061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:27 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m1so547882pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQE9MDJl5e2nPWoNEB2gmXlg+zxcLoMhW/A5d/D5a1A=;
        b=jHKiv6psrentA29elXWvFx+M6U+Jvg3fjZvhkgpsde+3kIzOUrVHp6+XoTiNzeEA37
         oahvuEXqpeB9Ao9pV3HCusgrI5Tb1c+OJJ8GosL+5syaUcvg9sSvpvtzuJJrGJ2o1+N6
         STWpUPQBShjmk4oXyEg+JtFnUwNA4IUoO/EjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQE9MDJl5e2nPWoNEB2gmXlg+zxcLoMhW/A5d/D5a1A=;
        b=F0d3Oy8so/ICFGO3cazwruDJZvOWQbKXt+1/G69CPJ+5RC1gqsamtBX1/QNYdHilrh
         KQk8b6+R5iWUQawoJP9fcq6AZk7p4tXOQiiH7Uku53QAtTw3lDR5v8bdE4KoeEG7/VST
         yuw1bBnoraujk/j/aWv3BTR3PhwyWlJoZuNa7p3cs+GQ08TyItDHx9bCVtfzcvc3vb3d
         bBZm+c6bGWeWfR6DUvfziTIxDa7KyNyEZGFNRCYn26OxF6LG1GANMy+2Vx3xErmyDqiy
         2O/LJ0TuaZEsTlzYJUFEBf91s8rf+eu8xacg2W3QXIwng50lUaP+/OgqFkhsNCC2oHZu
         J0NA==
X-Gm-Message-State: AOAM531gS0T5qVStDW3ad2UXJeO4hxmNeThSURE0dCT91kIZj41G76Dt
        +X1Ktyzq42iS/K+DEWOiFpKafg==
X-Google-Smtp-Source: ABdhPJz4Faw5ibzV9ER+YKN7FCaZEFKwyAzwSQoXZYIDM/y0asWmUbw4k2YpT4sEPkKn/1cQvQGNAg==
X-Received: by 2002:a62:2f07:0:b0:4bc:9f9e:b404 with SMTP id v7-20020a622f07000000b004bc9f9eb404mr17738922pfv.75.1641420447092;
        Wed, 05 Jan 2022 14:07:27 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id o11sm93452pfu.150.2022.01.05.14.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:26 -0800 (PST)
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
Subject: [PATCH 12/17] Input: cros_ec_keyb - Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:48 -0800
Message-Id: <20220105220653.122451-13-gwendal@chromium.org>
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
 drivers/input/keyboard/cros_ec_keyb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index fc02c540636e72..b8c54c411822cf 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -741,5 +741,6 @@ static struct platform_driver cros_ec_keyb_driver = {
 module_platform_driver(cros_ec_keyb_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC keyboard driver");
 MODULE_ALIAS("platform:cros-ec-keyb");
-- 
2.34.1.448.ga2b2bfdf31-goog

