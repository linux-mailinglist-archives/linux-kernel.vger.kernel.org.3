Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CAA547254
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiFKGSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFKGS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:18:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B19234
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:18:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so4171021pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjSO35OW5CDyi5f0VovxlwBR50P/ZvPzlljHQHI8So0=;
        b=ZPAiaJFvNbYdlJoRy4T8pSPsPpq/FRlPdSQfmDA5IEGB15SEODi9bn3BE18cEysmFt
         BOUoC+/Axw6q+d9JOFh2AC6eZ39mfVa8i3bIA+jxC1z259lqn/i6HarZlqxVLUrltRTf
         DgjZDNAkDDcHpD9qY/aggBsWayTAQWM2iXQUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjSO35OW5CDyi5f0VovxlwBR50P/ZvPzlljHQHI8So0=;
        b=d+iGJac1aWdvdo9Wd78um7PuQugr7AmnAdMMP2sf1Ps54/4v+ajchTbCLn46LWV2NH
         pWZEKmGClzARf0f82BB93JHgTExgQog9/vE12RmpqeS0CNk6YQWMmr5SI9WUgXatyOiG
         KOV9uUa+ojYMEv02rJ2qD1CR8/OScJ43nlamD8/M5+JOmaLLc8+Rgy/rTaRdvtp4GZ3j
         q2lRNafOBegRFfMfUjJeh+9ckQk469Dw/cM9qp8uBtJiRE8B6zvTM03dTndlkwvb/c0T
         1ZDRVASNucB2Lx0WgKSyaKahZISiuSKZSN0v00wxtkxqV3LDQshAWJQpmXUQK9gPS9WJ
         UbbA==
X-Gm-Message-State: AOAM531WnrWTNGh6UaWNAXuEUwvurotFyV5vdgEN7HlBQ2g68NMovc7X
        E4nYaaaKLvOhO6ADZiCl43Z5jQ==
X-Google-Smtp-Source: ABdhPJyJ7PXl3jPaHrDrOXLCuufFhhVFFeO5wLSbUu5ZQzB+zSUBmZZZ2gl0gCCqR/rK42pNBQGtQA==
X-Received: by 2002:a17:90a:bf02:b0:1e2:fadf:3f15 with SMTP id c2-20020a17090abf0200b001e2fadf3f15mr3554441pjs.91.1654928307162;
        Fri, 10 Jun 2022 23:18:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:290:ebca:2e9e:1570])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b0050dc76281aasm634824pfe.132.2022.06.10.23.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 23:18:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2] platform/chrome: cros_ec: Always expose last resume result
Date:   Fri, 10 Jun 2022 23:18:25 -0700
Message-Id: <20220611061825.4119270-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

The last resume result exposing logic in cros_ec_sleep_event()
incorrectly requires S0ix support, which doesn't work on ARM based
systems where S0ix doesn't exist. That's because cros_ec_sleep_event()
only reports the last resume result when the EC indicates the last sleep
event was an S0ix resume. On ARM systems, the last sleep event is always
S3 resume, but the EC can still detect sleep hang events in case some
other part of the AP is blocking sleep.

Always expose the last resume result if the EC supports it so that this
works on all devices regardless of S0ix support. This fixes sleep hang
detection on ARM based chromebooks like Trogdor.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rajat Jain <rajatja@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Fixes: 7235560ac77a ("platform/chrome: Add support for v1 of host sleep event")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20220610223703.3387691-1-swboyd@chromium.org):
 * Fixed typo

 drivers/platform/chrome/cros_ec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index b3e94cdf7d1a..3abef9747482 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
 
 	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
-
-	/* For now, report failure to transition to S0ix with a warning. */
+	/* Report failure to transition to system wide suspend with a warning. */
 	if (ret >= 0 && ec_dev->host_sleep_v1 &&
-	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
+	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME ||
+	     sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
 		ec_dev->last_resume_result =
 			buf.u.resp1.resume_response.sleep_transitions;
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
https://chromeos.dev

