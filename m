Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AD4DD296
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiCRB4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiCRB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:56:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A421C049
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:54:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p5so2189792pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yclMSQyOdfMOQoKpzUaRMtJg5TrGLXT/don6YL5wL2c=;
        b=d2lwOh30lYLmGIksygfZa83/YPhubrVDgBVn0fNS04CVQG9Tclhpai24uavY85z+0J
         Iu7l9uz+mGGWxjO+FK235uTwQZAgNCd88OJaVGQhXiarlj5laEa8IiJWDMiU8wgj4IWG
         6YlOzrKY21jKVAnvlEtJ83EZ9wrW3o4esVGL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yclMSQyOdfMOQoKpzUaRMtJg5TrGLXT/don6YL5wL2c=;
        b=5q7HxCEAiPfJpXGoXkVbBLxL+KX3GDYuH+9gWLsr+SSWf0NYHbXkYtBu9VYL+U0qAS
         34bd5FBKlScJ2enDbbu25yS6SFmmssPgYq55mJQT+WOlhvaYgOHoqU0nliobB7phrq7x
         rjWNZ8UBf4JBK+4tFcIki+wYwq84lO6dKxGTQzkV50Nsvh0TdVBJoyy9ZBPkKWNZbmU9
         Byn+BxgqE0Fw5t1ZVmRfdzQ7D9BmKZ6vTgQ7UJZN1b0uErMltxPCMrJDKFGUUksr5KHt
         ULpdnnIejeQd+Bw9GkJ882mtxmEs+GekLAJpt/VKHRfSf+2NhaPmnj4iVfuGaX/G3l9j
         cJCQ==
X-Gm-Message-State: AOAM533nJe3vQ1QVF1bjB8PTW5g+rEqu6hCN0zOUsyI/P/KybmOnUkCE
        pauqDgaBzoJKXimavkY75sn/qA==
X-Google-Smtp-Source: ABdhPJy3Ad1i05NYrMrhjpdEuaAZPN9G/qb30grnL6HPiiVjTdRz0jeLpRhropCPVAl3vnQ+yWwAHg==
X-Received: by 2002:a65:4789:0:b0:374:8b11:fb47 with SMTP id e9-20020a654789000000b003748b11fb47mr5909016pgs.325.1647568495413;
        Thu, 17 Mar 2022 18:54:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:49cf:7701:359e:b28f])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00124a00b004f783abfa0esm8050201pfi.28.2022.03.17.18.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:54:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 2/3] platform/chrome: cros_ec_spi: Match cros-ec-fp compatible
Date:   Thu, 17 Mar 2022 18:54:49 -0700
Message-Id: <20220318015451.2869388-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220318015451.2869388-1-swboyd@chromium.org>
References: <20220318015451.2869388-1-swboyd@chromium.org>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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

