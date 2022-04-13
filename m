Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210A94FED99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiDMDgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiDMDgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:36:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D762603
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:33:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p10so830370plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5+17MwOfKkjlV7qFQ2T4jzjQQOl3tsJ8bcwnmeF1zs=;
        b=gbH9pYSjrXenr+hUMeYXKSMyWCpkwKnnto8bFtn/g1IZ1uI7kom4DXNkPWQSgFGQW5
         by9E/tmsfTyEpyLgDkMsxkw6GAQJztqGH2edbwAAlvi2eU3wbhyZNwd+kfbQS3o9X146
         tKxmkPIQ349/AiN2qc2+epD7kPXKjd8rsErwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5+17MwOfKkjlV7qFQ2T4jzjQQOl3tsJ8bcwnmeF1zs=;
        b=2Zog+A8MJLKhojdrlM3gGTbDj9jC1CVr372bLap91EQ4smthCo6MGL4FbeAK71C5LL
         p30iALe0hd0YWNr9fOEbo+fbqu4YKoKHoR18QY5ZCSjf5GBF1XqCbmQYTGBpdUxnwiwA
         4hyvkZvF0p1ybCK736dATrCYwpXhD+/JhUkmcQE/LWUrTwjF3xaOWLLwdUyFmWhToG34
         LLAqSXq+Wnq/8RfahXCaA9yA+Cp6S7ZPKs06zT1Z6BknZ79268flFtUlQdK8aow8Ds9e
         Y3WQqL5ns7uirMUk8RfLt7n3gDbBz/CpmqpPFceNhYohzCHGuPU0AGAJT3Sn5govIImm
         lh6w==
X-Gm-Message-State: AOAM531RdQvwwH9YQS35u288vS3nHkPYCZcManZD8Xk4iR4K+pcqC7D7
        kL+h2Zoc+8utXUFQ9Vn65jo3/w==
X-Google-Smtp-Source: ABdhPJw9jZo+lRdE1iLDIO0NPPq39p5vIfxagy7X9ANc7aXbHjJGphu1yS8zKqRb4HpQTnlksnxo4Q==
X-Received: by 2002:a17:90a:8581:b0:1b2:7541:af6c with SMTP id m1-20020a17090a858100b001b27541af6cmr8534884pjn.48.1649820818315;
        Tue, 12 Apr 2022 20:33:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:87b3:e0ea:c924:6d1f])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00230a00b004faa0f67c3esm39788276pfh.23.2022.04.12.20.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 20:33:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 1/2] Input: cros-ec-keyb: Only register keyboard if rows/columns exist
Date:   Tue, 12 Apr 2022 20:33:33 -0700
Message-Id: <20220413033334.1514008-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220413033334.1514008-1-swboyd@chromium.org>
References: <20220413033334.1514008-1-swboyd@chromium.org>
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

If the device is a detachable, we may still probe this device because
there are some button switches, e.g. volume buttons and power buttons,
registered by this driver. Let's allow the device node to be missing row
and column device properties to indicate that the keyboard matrix
shouldn't be registered. This removes an input device on Trogdor devices
such as Wormdingler that don't have a matrix keyboard, but still have
power and volume buttons. That helps userspace understand there isn't
a keyboard present when the detachable keyboard is disconnected.

Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I tried to use mkbp info to query the number of rows and columns, but my
EC firmware doesn't have commit 8505881ed0b9 ("mkbp: Separate MKBP_INFO
host command from the keyboard driver") so it always returns 8 and 13
for the rows and columns. Sigh. With updated firmware we could query it,
or we could rely on DT like we do already.

Originally I was setting the properties to 0, but
matrix_keypad_parse_properties() spits out an error message in that case
and so it seems better to delete the properties and check for their
existence instead. Another alternative would be to change the compatible
to be "google,cros-ec-keyb-switches" or something that indicates there
are only switches and no matrix keyboard.

 drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 6534dfca60b4..ac9a953bff02 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -537,6 +537,15 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	u32 key_pos;
 	unsigned int row, col, scancode, n_physmap;
 
+	/*
+	 * No rows and columns? There isn't a matrix but maybe there are
+	 * switches to register in cros_ec_keyb_register_bs() because this is a
+	 * detachable device.
+	 */
+	if (!device_property_read_bool(dev, "keypad,num-rows") &&
+	    !device_property_read_bool(dev, "keypad,num-cols"))
+		return 0;
+
 	err = matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev->cols);
 	if (err)
 		return err;
-- 
https://chromeos.dev

