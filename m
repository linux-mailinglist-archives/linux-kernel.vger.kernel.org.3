Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA70F54AB55
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355836AbiFNH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355547AbiFNH6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:58:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD743FBDD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:57:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w21so7962963pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=im11BmF4AkSvI7LJUG+0S/RpqxIynxFnf8uu1Qq4PqM=;
        b=GJ8dYa+L62FlKJzQknArn9TueEREN6ETCdbHZQ9MPWYSnjRDuAGF6amAEBpjMkLsiL
         SsX1neP70H5zQSNi5Q5KayZ4BmEa8GWvbm7a0EvJWWO4NdXQQsN7JY1CFC+jkV/8zgpB
         k2chA8jmFIjuhwVCj9KhshwL+swUA5ZAWYWVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=im11BmF4AkSvI7LJUG+0S/RpqxIynxFnf8uu1Qq4PqM=;
        b=vsY5O8UWZfqNKtHx7zE1QIOGtb09dzZJtMKU+1I082IRlFHQfOeZioCnkq15Q2CmQW
         zwA9LaIu6jCxelUSsP3nywOy84DqcN4UsxGGcKUJe6+KllYqJdVKuxiS1Wi8NthKH9Fh
         Ec3i+cvyc4UC/+0eWtPRpAYwKLuDobHlOUv2uIHRED6dLw8elEppMP7UBpL60Gs/SjMt
         Yl6HijIgl975J68EHhOACeASo2z/gophedsSdY6SQ9RhQNdq97E9H5cHckXjGJsm7G2e
         kioMR4ZyioeyNREPwR72XFhlM7VAO3d5hwOEcMlF9+DjnlH+JSHFaeVgdYeRYGx09Kdg
         M83w==
X-Gm-Message-State: AOAM5305+722KBQyZ0um4NCKSK1gXYKgiMLk+79xywFjRVyM2WLQShzX
        0iWPMAoY18GaYpzg8s7Jn2kaZaNyFDbKkA==
X-Google-Smtp-Source: ABdhPJx4qyRJRg61YqX8d1DAvEWFptjZwj/AzMDAj3ZLksoBXcfc7inBeQBia7yv748SSeIjyJXg2Q==
X-Received: by 2002:a63:e946:0:b0:401:b982:38a7 with SMTP id q6-20020a63e946000000b00401b98238a7mr3405759pgj.327.1655193447932;
        Tue, 14 Jun 2022 00:57:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:82ae:1136:b202:95da])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b00165105518f6sm6469759plo.287.2022.06.14.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 00:57:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3] platform/chrome: cros_ec: Always expose last resume result
Date:   Tue, 14 Jun 2022 00:57:26 -0700
Message-Id: <20220614075726.2729987-1-swboyd@chromium.org>
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

Cc: Rajat Jain <rajatja@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Fixes: 7235560ac77a ("platform/chrome: Add support for v1 of host sleep event")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2 (https://lore.kernel.org/r/20220611061825.4119270-1-swboyd@chromium.org):
 * Change slp_s0 to sleep in warning message

Changes from v1 (https://lore.kernel.org/r/20220610223703.3387691-1-swboyd@chromium.org):
 * Fixed typo

 drivers/platform/chrome/cros_ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index b3e94cdf7d1a..00381490dd3e 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -135,16 +135,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
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
 
 		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TIMEOUT,
-			  "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
+			  "EC detected sleep transition timeout. Total sleep transitions: %d",
 			  buf.u.resp1.resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
 	}

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
https://chromeos.dev

