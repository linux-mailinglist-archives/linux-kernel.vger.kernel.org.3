Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC08A4E3095
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352491AbiCUTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351807AbiCUTMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:12:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A316F050
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:11:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o13so10963435pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2S7ShVJAy626NONsIWJsSJwwvja+2+hPi/cA9JVaGwU=;
        b=JMQZL+JUW/xaIOLRzFSLEcIywoAUAsY8Aq/8MMUP9fftDpOAFp/Od63YzymBQUSdT3
         n22HZYl5klKcsAHxTxTrqneEak2tOvU5t5ZaHGBuTBXl3QrR4cBekNm4chhO7g9+AkqV
         oewbc/4DhQbpvRaMT5oZMFBEka4PyQPQ01FEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2S7ShVJAy626NONsIWJsSJwwvja+2+hPi/cA9JVaGwU=;
        b=VAZEFm3Mh7Nlk3VD93bUzbhJvEBzS+gbQshTEcD6o5lMFIWAfiqyruXeUp/gqSE/m4
         gfMUkmiCorxunwcI+Q8CMAMCTAg1HT7THxQKnUQ9aZOJ5IJVgxJ1e1ZUpCxeC2K3UmGd
         F00WJ7Bp2q7A2ISk2v3TCezi8jpUJP7evTFocsLFNQIUg65S20ZnKWDBkONZdq8dXugs
         GNXciU9IOu1ZP7o7Vdhu37P8nTmj+eZEIYbh/zUgLrAkH9NXDLpowCfbWt8Qqej8GzIh
         dtOSRZ4OgcbRoDL/nYLreUkJmYFrmBzhfeuhPm5D81pVPkiAha/wiej705jelmBemaHb
         DJxw==
X-Gm-Message-State: AOAM531A1MrIH3x+EToFDoDwwULDONsCX5zbI+HW816LxVjjrtC4Rxq1
        MtwfOJ0fMqKU+zc0AbwnA0NKwQ==
X-Google-Smtp-Source: ABdhPJwYrurevKmMK2GwtHliuAAWk+ENh/FntvetNgQnFy1BsgAoj7JXWTJdYoDQzHCFN+QXqI1vvA==
X-Received: by 2002:a63:4d15:0:b0:37f:f622:fe0f with SMTP id a21-20020a634d15000000b0037ff622fe0fmr19084086pgb.68.1647889864572;
        Mon, 21 Mar 2022 12:11:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:2ffa:f7a0:c7f5:8171])
        by smtp.gmail.com with ESMTPSA id y14-20020a056a001c8e00b004fa829db45csm3384022pfw.218.2022.03.21.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 12:11:04 -0700 (PDT)
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
Subject: [PATCH v4 2/3] platform/chrome: cros_ec_spi: Match cros-ec-fp compatible
Date:   Mon, 21 Mar 2022 12:10:58 -0700
Message-Id: <20220321191100.1993-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321191100.1993-1-swboyd@chromium.org>
References: <20220321191100.1993-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the fingerprint cros-ec compatible so that we can probe fingerprint
devices using the cros-ec-fp binding.

Cc: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 14c4046fa04d..51b64b392c51 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -813,6 +813,7 @@ static SIMPLE_DEV_PM_OPS(cros_ec_spi_pm_ops, cros_ec_spi_suspend,
 			 cros_ec_spi_resume);
 
 static const struct of_device_id cros_ec_spi_of_match[] = {
+	{ .compatible = "google,cros-ec-fp", },
 	{ .compatible = "google,cros-ec-spi", },
 	{ /* sentinel */ },
 };
-- 
https://chromeos.dev

