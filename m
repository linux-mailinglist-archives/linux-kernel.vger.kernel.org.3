Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD758AFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiHESTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbiHESTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:19:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C777A522
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:19:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q16so3309196pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYOkIrEG4g3M8ASJ/AkJU++WSzZYHBjTCiF1SDQ0Xwg=;
        b=hsDItFQ8JI2Ajh/KW1aDraLSGSmzEyyjj3uFuCs6QzUSD/hINbEkbzQE7aQEAlQ/7B
         1jUjObYZSBYHn1qrjz4yhlPR3dYTR7PgLbyqjgZQ+Y91BNu8xL4c9RpObg1fIRPHuj93
         JzTAh/yDaNmuiXkgHCo77gO1aI92zBPgsEu5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYOkIrEG4g3M8ASJ/AkJU++WSzZYHBjTCiF1SDQ0Xwg=;
        b=JUWE96fqTeXP9l91amU8OA+NnwjfyHk9adbDLILMWYeU3aCYK0pEdOXEabe82MU9w2
         C3rnu9lHf9fIGR7PigCef8tWvuMqJtgaS0U+lR9B68asCqUA29VUH+WgtRFUHeJ2+lKs
         Msz8eiQOk6EHRAZndah9m6vbZUPbjRrzazxWfuxEr2qAU3iebarNvaBfVvg0FEyeEEIG
         CXE8NlRvrJWdcrz2qIk1taGjLO+i7sT644Qs0G3ptbjL3T6qFdL7W+cScNSwmJzSocIX
         yZ0ucTx2CmWTs1CqWR+7tQJ+iGYYfJ6FmdjMQsfNf5Ot3Oe7qBY7QARrSd4/PDdpZ221
         4QoA==
X-Gm-Message-State: ACgBeo0181p3Acmipe/AOwYLygQIBf2VOswMYX/EcsCPWxjvRL6Uh7ru
        +0AaaRTZ3Z8N6qSscyLKaiQGDQ==
X-Google-Smtp-Source: AA6agR4PxBgVNu7V+AxKnd3QssNLwbdagkw5Kzz4X6dy2B0ylDd/zfFijHFlhXJ91TzjDO+6efXcxQ==
X-Received: by 2002:a63:d0:0:b0:411:f92b:8e6c with SMTP id 199-20020a6300d0000000b00411f92b8e6cmr6644953pga.108.1659723574373;
        Fri, 05 Aug 2022 11:19:34 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c59c:1680:614c:3338])
        by smtp.gmail.com with UTF8SMTPSA id d3-20020a170903230300b0016d8d277c02sm3471886plh.25.2022.08.05.11.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:19:34 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] usb: misc: onboard_usb_hub: Drop reset delay in onboard_hub_power_off()
Date:   Fri,  5 Aug 2022 11:19:31 -0700
Message-Id: <20220805111836.1.Id5a4dc0a2c046236116693aa55672295513a0f2a@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

onboard_hub_power_off() currently has a delay after asserting the
reset of the hub. There is already a delay in onboard_hub_power_on()
before de-asserting the reset, which ensures that the reset is
asserted for the required time, so the delay in _power_off() is not
needed.

Skip the reset GPIO check before calling gpiod_set_value_cansleep(),
the function returns early when the GPIO descriptor is NULL.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/usb/misc/onboard_usb_hub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index d1df153e7f5a..d63c63942af1 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -71,10 +71,7 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
 {
 	int err;
 
-	if (hub->reset_gpio) {
-		gpiod_set_value_cansleep(hub->reset_gpio, 1);
-		fsleep(hub->pdata->reset_us);
-	}
+	gpiod_set_value_cansleep(hub->reset_gpio, 1);
 
 	err = regulator_disable(hub->vdd);
 	if (err) {
-- 
2.37.1.559.g78731f0fdb-goog

