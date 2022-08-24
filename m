Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3258F5A0340
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiHXVXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbiHXVXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:23:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E041AD9A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:23:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y127so14754714pfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=O8J+aRusf0vNSpyQnmEfPgTAvHg6H/KrJETEg87gmiI=;
        b=MXaLbZ+2HUFWTAFYtFfAR8tleYpmXNtX8WzCU7mTlsMZDW4VnT0HN8SbHMHeyjuVtn
         hhOCI4Yd4svP+933UgbPlTPU4mzWbsG5D9PUhO+PobwB5SDh3DWpt1gJlgOGbVC7aS0C
         1pN5E9GHqvpVLvZdr13jf6WVirxI3R9HekU7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O8J+aRusf0vNSpyQnmEfPgTAvHg6H/KrJETEg87gmiI=;
        b=b9MwVTdmD5K59icIPycbGhyQv0dolImPn22/RZR9xSKbGdjcBEkRfi1lxvzljRniDn
         jnp1LFGbOmcH2sPOkKKbELESLvfmx1XtPgvMafvl1PizkOu2p45Y1cUZLCRtJKp4/aBR
         1GuddkbULMXtUjqVERpuyonMLkH/fatv5A0ARbYP2sgptbuvQzVa6UqBRo4u54uw4B4v
         wc3gmmg2XTZqdB9y+sKuN0NRDYh4xEBMc21h27XAf1bg+WwjfPH6m4fA7pEpedCkpW0e
         qxeSx46zXfNxJARYi+robesf1Zkr4TNXvTN/1iFSjtE52956Vy+g8PWgi6Uy56MnxXL4
         GZVQ==
X-Gm-Message-State: ACgBeo3RfkXQuyNofYShPd8+dhUcUzqFgvBmgJPi7iQiegCXy+ItFeUt
        FmylZMD8PXg3xGu48lZEQV+i/g==
X-Google-Smtp-Source: AA6agR6vPHfyrMXbItMKjP2oNSLNVTfKT4fHP0QQmRgImhGgHDtLA0/WWGNRSmEWaYXs9o430/SmqQ==
X-Received: by 2002:a05:6a00:1a93:b0:536:5dca:a685 with SMTP id e19-20020a056a001a9300b005365dcaa685mr992583pfv.13.1661376202869;
        Wed, 24 Aug 2022 14:23:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c671:5829:2fab:9fe4])
        by smtp.gmail.com with ESMTPSA id z124-20020a626582000000b00536531536adsm9494699pfb.47.2022.08.24.14.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:23:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 2/2] regulator: core: Don't err if allow-set-load but no allowed-modes
Date:   Wed, 24 Aug 2022 14:22:57 -0700
Message-Id: <20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
References: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
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

Apparently the device trees of some boards have the property
"regulator-allow-set-load" for some of their regulators but then they
don't specify anything for "regulator-allowed-modes". That's not
really legit, but...

...before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()") they used to get away with it, at
least on boards using RPMH regulators. That's because when a regulator
driver implements set_load() then the core doesn't look at
"regulator-allowed-modes" when trying to automatically adjust things
in response to the regulator's load. The core doesn't know what mode
we'll end up in, so how could it validate it?

Said another way: before commit efb0cb50c427 ("regulator: qcom-rpmh:
Implement get_optimum_mode(), not set_load()") some boards _were_
having the regulator mode adjusted despite listing no allowed
modes. After commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()") these same boards were now
getting an error returned when trying to use their regulators, since
simply enabling a regulator tries to update its load and that was
failing.

We don't really want to go back to the behavior from before commit
efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not
set_load()"). Boards shouldn't have been changing modes if no allowed
modes were listed. However, the behavior after commit efb0cb50c427
("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
isn't the best because now boards can't even turn their regulators on.

Let's choose to detect this case and return "no error" from
drms_uA_update(). The net-result will be _different_ behavior than we
had before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()"), but this new behavior seems more
correct. If a board truly needed the mode switched then its device
tree should be updated to list the allowed modes.

Reported-by: Andrew Halaney <ahalaney@redhat.com>
Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Added ("Don't err if allow-set-load but no allowed-modes").

 drivers/regulator/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0bc4b9b0a885..1d030831aeae 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -977,6 +977,18 @@ static int drms_uA_update(struct regulator_dev *rdev)
 			rdev_err(rdev, "failed to set load %d: %pe\n",
 				 current_uA, ERR_PTR(err));
 	} else {
+		/*
+		 * Unfortunately in some cases the constraints->valid_ops has
+		 * REGULATOR_CHANGE_DRMS but there are no valid modes listed.
+		 * That's not really legit but we won't consider it a fatal
+		 * error here. We'll treat it as if REGULATOR_CHANGE_DRMS
+		 * wasn't set.
+		 */
+		if (!rdev->constraints->valid_modes_mask) {
+			rdev_dbg(rdev, "Can change modes; but no valid mode\n");
+			return 0;
+		}
+
 		/* get output voltage */
 		output_uV = regulator_get_voltage_rdev(rdev);
 
-- 
2.37.2.672.g94769d06f0-goog

