Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323854AD3EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350668AbiBHIsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbiBHIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:48:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B247C03FEC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:48:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f17so18832654edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtcVTbnikm5TjYlnqfzuROBrnAfn839wYMshT0LlrlY=;
        b=BpDBSmg1Jr9VfdOJRYF+j1/JajvAr9L2nHHpeeu8yKE34gYmvzVusPZ39v+VidsSxH
         WwyMlroOn1jCKn7lHEfGXvjkaUFmAsYmcrg5bYG8wNG4w7XEF6mc1E7xpYCh7D+CskRL
         Eyr+j+nGdFF9nOYMj2ys9Vvi6FF3U0vc1l3PvcpvmeHFaKh4hPW06gCTL6Qqe5bMa0aJ
         QC6trgRBfDt+LnUVGrHfiecghjxWSW1v7q6yjYIRJeL0yv+cZdKEli8Gj4es9Go/f81D
         QpHHANGWvZ+bMmZahaGWypV7HwH7oBDFSElEZ/KVqUh2T28R8Xp5mtAReVRSxu2VHMIU
         LR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtcVTbnikm5TjYlnqfzuROBrnAfn839wYMshT0LlrlY=;
        b=6qrHRq9oB4mGWsO0BJGdCIx1bbSSafR6/xNmtUwrXp9ComfvH78vVl9xBVFYyS1O4D
         cMi9F9CxrcBc1MvO8/lrt7+pecdgMZBpuOKURwA5SQZEddlpmRnH8i/rT8hbqGbTQ76+
         HZ2WOj+eCzTXSUFPdqr6otwVq1ld2Od4+pQ3f/WjgePBPfnGAZkKx17hP6o59BQ5G4uJ
         AMBYRVVYoBN9LMMJs2D0AiRVQYRtwUoRL47OTs0Vzwk2Seom5zcd7yssPQLWYqYBSbEs
         0ovNQAnl7pEG0oi02CMc+uijndnY94Qfv2ym0WjEqtOoTj7P64zU3AX+WWoX3/SNfpPy
         GzWQ==
X-Gm-Message-State: AOAM532Z2Sz7LLGzRlNkNUt2dUt2cHa3G/4p9kRP3GXvmYCPcb20qJnQ
        z63wLUPwKVqxQCQG56xSwPY=
X-Google-Smtp-Source: ABdhPJyByuNRI7Mzyoo8jprDI+E30rIgkRibWrqLN8NcWyDd7NB2Q1QfPfrBOBPguQquidXLTy1Z4A==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr3372067edd.290.1644310108749;
        Tue, 08 Feb 2022 00:48:28 -0800 (PST)
Received: from xyz-Precision-5820.fritz.box (dynamic-077-010-169-004.77.10.pool.telefonica.de. [77.10.169.4])
        by smtp.gmail.com with ESMTPSA id z2sm2771758ejr.68.2022.02.08.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:48:28 -0800 (PST)
From:   Oliver Barta <o.barta89@gmail.com>
X-Google-Original-From: Oliver Barta <oliver.barta@aptiv.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Rolf Evers-Fischer <Rolf.Evers.Fischer@aptiv.com>,
        Oliver Barta <oliver.barta@aptiv.com>
Subject: [PATCH] regulator: core: fix false positive in regulator_late_cleanup()
Date:   Tue,  8 Feb 2022 09:46:45 +0100
Message-Id: <20220208084645.8686-1-oliver.barta@aptiv.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Barta <oliver.barta@aptiv.com>

The check done by regulator_late_cleanup() to detect whether a regulator
is on was inconsistent with the check done by _regulator_is_enabled().
While _regulator_is_enabled() takes the enable GPIO into account,
regulator_late_cleanup() was not doing that.

This resulted in a false positive, e.g. when a GPIO-controlled fixed
regulator was used, which was not enabled at boot time, e.g.

reg_disp_1v2: reg_disp_1v2 {
	compatible = "regulator-fixed";
	regulator-name = "display_1v2";
	regulator-min-microvolt = <1200000>;
	regulator-max-microvolt = <1200000>;
	gpio = <&tlmm 148 0>;
	enable-active-high;
};

Such regulator doesn't have an is_enabled() operation. Nevertheless
it's state can be determined based on the enable GPIO. The check in
regulator_late_cleanup() wrongly assumed that the regulator is on and
tried to disable it.

Signed-off-by: Oliver Barta <oliver.barta@aptiv.com>
---
 drivers/regulator/core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 86aa4141efa9..d2553970a67b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6014,9 +6014,8 @@ core_initcall(regulator_init);
 static int regulator_late_cleanup(struct device *dev, void *data)
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
-	const struct regulator_ops *ops = rdev->desc->ops;
 	struct regulation_constraints *c = rdev->constraints;
-	int enabled, ret;
+	int ret;
 
 	if (c && c->always_on)
 		return 0;
@@ -6029,14 +6028,8 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 	if (rdev->use_count)
 		goto unlock;
 
-	/* If we can't read the status assume it's always on. */
-	if (ops->is_enabled)
-		enabled = ops->is_enabled(rdev);
-	else
-		enabled = 1;
-
-	/* But if reading the status failed, assume that it's off. */
-	if (enabled <= 0)
+	/* If reading the status failed, assume that it's off. */
+	if (_regulator_is_enabled(rdev) <= 0)
 		goto unlock;
 
 	if (have_full_constraints()) {
-- 
2.25.1

