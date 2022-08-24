Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69D5A0341
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbiHXVXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbiHXVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:23:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34656167D6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:23:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 20so16779045plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KxOSnlWivZC4Xyc1JzkfKNDDCWrgBpOIIJZGRMa+Dik=;
        b=cpFo3Npxs6PvD3tRNPoUQR2StdEsP2IZI07mJJzVWCQX6YGipQB32KrrWzactYIl8+
         2ZCyXIx5Q1DMH6iaV6oVKN+7bqXHQKk1hkZ3aJeBgOnZ1VgdFWuI5KVgGgkgyd3Xsb0R
         Bh+9dZaFZTwvd5DDchG7wqkX9gxhC5LJ/4u/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KxOSnlWivZC4Xyc1JzkfKNDDCWrgBpOIIJZGRMa+Dik=;
        b=bxFdbQFlKE/uzGNmSiyLqOB1nfRy1pv0Hymd8/G4GB/AAQvnnyo6mLg5It3s56Lw+O
         nl9noZplCFNgTRG6RwcD2V0WiVnXmqi4jnO3gsM8daNsRqsK9O9jAQ8xc6tkPLhBTTgw
         bcWmqHtcYRf25YHyXMYzbv/rVirfrsKIVrED4jF5wzC3NJBs5uIe6m2EAXr5FMDKm4IG
         yUj1j0drRmzYXS/AxVNATq4sUotCTFepUC5JANLnntG0yklp/umhq+oIWejmAQVsutb+
         QNDlpH+M7rvdrCEpAz2zl6haUSoGZHEmbCkDkhhfDcDAa+SLUi8hbo6y9BWrPsVqE9Nc
         F7Vw==
X-Gm-Message-State: ACgBeo0nFW9CUCshTY7H2PhQV+YlYXo049rCfL2z9hljn+84Vd9BXEGG
        O5moRuyv3dAn9+WG06FTLdYIPA==
X-Google-Smtp-Source: AA6agR4aP6PA2LLUb+W3hp79qG12JDkkOHtARIpA4FyYL5v5zS0RFVrVFicHbSbrK/MjaUiZXdguTg==
X-Received: by 2002:a17:902:7e45:b0:172:8c47:ff2e with SMTP id a5-20020a1709027e4500b001728c47ff2emr830443pln.24.1661376201583;
        Wed, 24 Aug 2022 14:23:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c671:5829:2fab:9fe4])
        by smtp.gmail.com with ESMTPSA id z124-20020a626582000000b00536531536adsm9494699pfb.47.2022.08.24.14.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:23:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 1/2] regulator: core: Require regulator drivers to check uV for get_optimum_mode()
Date:   Wed, 24 Aug 2022 14:22:56 -0700
Message-Id: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_optimum_mode() for regulator drivers is passed the input
voltage and output voltage as well as the current. This is because, in
theory, the optimum mode can depend on all three things.

It turns out that for all regulator drivers in mainline only the
current is looked at when implementing get_optimum_mode(). None of the
drivers take the input or output voltage into account. Despite the
fact that none of the drivers take the input or output voltage into
account, though, the regulator framework will error out before calling
into get_optimum_mode() if it doesn't know the input or output
voltage.

The above behavior turned out to be a probelm for some boards when we
landed commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()"). Before that change we'd have no
problems running drms_uA_update() for RPMH regulators even if a
regulator's input or output voltage was unknown. After that change
drms_uA_update() started to fail. This is because typically boards
using RPMH regulators don't model the input supplies of RPMH
regulators. Input supplies for RPMH regulators nearly always come from
the output of other RPMH regulators (or always-on regulators) and RPMH
firmware is initialized with this knowledge and handles enabling (and
adjusting the voltage of) input supplies. While we could model the
parent/child relationship of the regulators in Linux, many boards
don't bother since it adds extra overhead.

Let's change the regulator core to make things work again. Now if we
fail to get the input or output voltage we'll still call into
get_optimum_mode() and we'll just pass error codes in for input_uV
and/or output_uV parameters.

Since no existing regulator drivers even look at input_uV and
output_uV we don't need to add this error handling anywhere right
now. We'll add some comments in the core so that it's obvious that (if
regulator drivers care) it's up to them to add the checks.

Reported-by: Andrew Halaney <ahalaney@redhat.com>
Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/regulator/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5b5da14976c2..0bc4b9b0a885 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -979,10 +979,13 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	} else {
 		/* get output voltage */
 		output_uV = regulator_get_voltage_rdev(rdev);
-		if (output_uV <= 0) {
-			rdev_err(rdev, "invalid output voltage found\n");
-			return -EINVAL;
-		}
+
+		/*
+		 * Don't return an error; if regulator driver cares about
+		 * output_uV then it's up to the driver to validate.
+		 */
+		if (output_uV <= 0)
+			rdev_dbg(rdev, "invalid output voltage found\n");
 
 		/* get input voltage */
 		input_uV = 0;
@@ -990,10 +993,13 @@ static int drms_uA_update(struct regulator_dev *rdev)
 			input_uV = regulator_get_voltage(rdev->supply);
 		if (input_uV <= 0)
 			input_uV = rdev->constraints->input_uV;
-		if (input_uV <= 0) {
-			rdev_err(rdev, "invalid input voltage found\n");
-			return -EINVAL;
-		}
+
+		/*
+		 * Don't return an error; if regulator driver cares about
+		 * input_uV then it's up to the driver to validate.
+		 */
+		if (input_uV <= 0)
+			rdev_dbg(rdev, "invalid input voltage found\n");
 
 		/* now get the optimum mode for our new total regulator load */
 		mode = rdev->desc->ops->get_optimum_mode(rdev, input_uV,
-- 
2.37.2.672.g94769d06f0-goog

