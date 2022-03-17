Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5686E4DBBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbiCQA7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiCQA7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:59:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856513E81
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id o23so1447201pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozEwxbhS5CJ9GBcAAvnujKd841/J1GSZd5stO5HqEjg=;
        b=lo0d5tF/rK43t4wYULaadPTcwiYjzT503duKa/wadkni0wAlDUtkjc3hBPNwZ651jb
         pylYMJmLs0li6nZfG46yutukJ5dpRILnAC/cCyy9fDEBTGaCwRuI7uV2QeM2xKP61NlS
         Ls3/+5hGfssJMzw2v0cYQE7gzcQ3KR50+CbbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozEwxbhS5CJ9GBcAAvnujKd841/J1GSZd5stO5HqEjg=;
        b=Pt+M5CBDsQCOXgs0akrrd8aP4hdcHYyUHWfYkno/rp3Ljkk6+sT3smsxvXggTr4zXX
         99z71L5efUthFy+BHAAXpwKNb9xwdk2Ttse4g7QYlFIRY5gj8XNVOLlmvBPsbbsj01p9
         oGHvYQv1C0zinc2AKglFVJafbLQJt8DSmuAA3f2Qsl0j2aKAzVJkI/wlKM8ro5Ve5Q//
         IQAwaiAVOCPoqAdhZrOgquLv414a0FvS5UlezBryrePjkyQigD8gQonC9EdTdOkhw2mW
         7UrCziLhr1yTcFpyLy8aR+vEd9Cye8IZrSUlZKe9vJPJ9IARMQqrbVFvyRQNVv/Ful+t
         rpJw==
X-Gm-Message-State: AOAM532PCVlYhuTlkYaslOzB/BR9hthJa5vTt+kWzNVJyzIW4wCCzWF0
        UsY3mG84Jdov2NXIhuUBkQbLkQ==
X-Google-Smtp-Source: ABdhPJzkyu8es5VniOnUk80gazU+n+K2q/wh9W4obuf9K7sJsU0VfFzQ6S1sX/59tsvUJfjVj8kQ4g==
X-Received: by 2002:aa7:9ac5:0:b0:4f6:a2e1:6073 with SMTP id x5-20020aa79ac5000000b004f6a2e16073mr2534018pfp.52.1647478699424;
        Wed, 16 Mar 2022 17:58:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dec5:e3f8:cbd7:f5a7])
        by smtp.gmail.com with ESMTPSA id l20-20020a056a00141400b004f65cedfb09sm4433445pfu.48.2022.03.16.17.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:58:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 2/3] platform/chrome: cros_ec_spi: Match cros-ec-fp compatible
Date:   Wed, 16 Mar 2022 17:58:13 -0700
Message-Id: <20220317005814.2496302-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220317005814.2496302-1-swboyd@chromium.org>
References: <20220317005814.2496302-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the fingerprint cros-ec compatible and spi_device_id so that we can probe
fingerprint devices.

Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 14c4046fa04d..d0f9496076d6 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -813,12 +813,14 @@ static SIMPLE_DEV_PM_OPS(cros_ec_spi_pm_ops, cros_ec_spi_suspend,
 			 cros_ec_spi_resume);
 
 static const struct of_device_id cros_ec_spi_of_match[] = {
+	{ .compatible = "google,cros-ec-fp", },
 	{ .compatible = "google,cros-ec-spi", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cros_ec_spi_of_match);
 
 static const struct spi_device_id cros_ec_spi_id[] = {
+	{ "cros-ec-fp", 0 },
 	{ "cros-ec-spi", 0 },
 	{ }
 };
-- 
https://chromeos.dev

