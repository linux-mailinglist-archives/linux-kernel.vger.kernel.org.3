Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483815964FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiHPVwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiHPVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:52:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CB8E0F4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:51:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso118179pjl.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZUDKiJcy/NR4RiCY5xiO+505IhInHi372I8JGaQYasY=;
        b=huvYyD9DsHp8RsAMq8umXLvqy3zdfey2HAeowr1WoEseaI+1cHIhtxaBWSPSrjiexw
         y6MQpFZJIoz2Oj2y1p+nbkxgrOfIJpttGB/lBK3ExogrNhH6b6S0jKD9jxLfp6Vwmuq7
         1T0idtLboE4jZ4dpu+YtT6Lcd8R2EGilEXfY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZUDKiJcy/NR4RiCY5xiO+505IhInHi372I8JGaQYasY=;
        b=7d65eNxA+K/6g6ndjKvt/xOnoGfjasbeL82iGCdk4lvGEfBv0UoFTm5K0w+k2JRBMI
         b6PytDdEsW8STtRQjAziRFFjCpi+Ogn4XWUhTDZIA+qsTBWsiXT0KpwGluf/dPQ6v79R
         IBjCKIs7StFx6g5+Tif9VRga0BK1j4Q9xugYfs5KSsCa1H8w/e9HMbl4VP1YymMT8U9z
         XhBHn8JGHBlDI7E/wqWlYV45axpw7+FQfKidqcnjbbj/Rzf17BVIVjE37YeH8s/v5Mgz
         n+rFYIq5pywbmrL0joHipW+cKfOWxvR6OVocSZAs+4qwZZYtzn9RkfXba1YqZg3DBTdQ
         HRnQ==
X-Gm-Message-State: ACgBeo2ep6fo6Y2fDYpsYK9y65Edxw3puUT2HBbmblkpnF63/VqXIPgi
        IRO9HFRjy+iHJ9EPknADkElMCZKQdu85Kg==
X-Google-Smtp-Source: AA6agR4aSEdxsFuYhrYD+dK3r6Qv8LSY+0sTjAp4rl7A3rC6pwExZBKSQEAsNcsMXVpOct3lVsJ57g==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:1df2:1fff with SMTP id pc10-20020a17090b3b8a00b001f51df21fffmr578753pjb.169.1660686715695;
        Tue, 16 Aug 2022 14:51:55 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b005323a1a9fecsm8916650pfz.101.2022.08.16.14.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:51:55 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v6 6/7] platform/chrome: cros_ec_typec: Cleanup switch handle return paths
Date:   Tue, 16 Aug 2022 21:48:34 +0000
Message-Id: <20220816214857.2088914-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220816214857.2088914-1-pmalani@chromium.org>
References: <20220816214857.2088914-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the return paths for the cros_typec_get_switch_handles()
aren't necessary. Clean up the return paths to only undo the handle
get's which succeeded.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---

Changes since v5:
- Picked up Reviewed-by tags.

Changes since v4:
- No changes.

Changes since v3:
- No changes.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index de6ee0f926a6..ee54add992db 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -158,12 +158,10 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 	return 0;
 
 role_sw_err:
-	usb_role_switch_put(port->role_sw);
-ori_sw_err:
 	typec_switch_put(port->ori_sw);
-mux_err:
+ori_sw_err:
 	typec_mux_put(port->mux);
-
+mux_err:
 	return -ENODEV;
 }
 
-- 
2.37.1.595.g718a3a8f04-goog

