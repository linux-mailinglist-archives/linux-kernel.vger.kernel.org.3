Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192F850ACC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442936AbiDVA0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbiDVA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:26:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8B4968F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:23:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so6448346pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6isM9rPgnmUdLXF2PlckUisnk3OJXyXTwV1qms8h1g=;
        b=JkjgNHqRJy5KbgBIvYEyVrAQfuO80ZGbKWjGP0AAoCINZl3bLn8bhvXCOJDpJlBEg8
         NxDF/tX5kFkyv2So8OCMnsp6byZmGV0iLZyjfq2lySItBZdUFok0gz4ls+HHzO9x4G+V
         HbJ1JqlETnEvoxCJLE4CudRot06gz5NBzz6Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6isM9rPgnmUdLXF2PlckUisnk3OJXyXTwV1qms8h1g=;
        b=cjkDcMArFjwY3zKBRUHjB/DHtoovOrtFPkdrevcZmHyE583K77w2IXTNiiV91Sxsna
         7TKeIadRHnRFJWU29NMHy/qnwWiUAL88DoBLxfsWif7YDOsFXqiUEZjhuuuusM7HGBCK
         DrkITR+2K6kKBHKrBe/zlf2TIIZ9PSgf7OtGH15rwQOOjbNBahDTJyUNyv0JTUuEdcL/
         NJ3l7Ne4osWJQi+E8p6Zu23bWfVMvpcECTfWVD/n3qwkzxRDJ7tHsIFzEvza5rUvQryf
         zyBwTOEycEs72/RMuFUDwu6H/tPfLeZ7lo1UUZ9Y/70tobIC3iydsBLyWZJB+Ncwp2hZ
         FA5Q==
X-Gm-Message-State: AOAM53053DkXfAY2zrDMVsHKdsXh3MIaCuohenSrEy6yzhJUWVwW/wmt
        7nVBdOAak6iU96s0ELnQ0ef13A==
X-Google-Smtp-Source: ABdhPJw9YS3CeCmSKEpGAhl/Z0uvcagcMQFn4lDU0jx2RRatzbW24NDaC/4y5Ff9r979x7OD/4s6Zw==
X-Received: by 2002:a05:6a02:116:b0:39c:c779:b480 with SMTP id bg22-20020a056a02011600b0039cc779b480mr1655951pgb.311.1650587018436;
        Thu, 21 Apr 2022 17:23:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e283:652b:fb2e:829f])
        by smtp.gmail.com with UTF8SMTPSA id k198-20020a633dcf000000b003aa9116ba17sm294393pga.35.2022.04.21.17.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 17:23:37 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] mmc: core: Don't set HS200 clock rate prematurely
Date:   Thu, 21 Apr 2022 17:23:18 -0700
Message-Id: <20220422002318.3587413-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c7ec586fe55 ("mmc: core: Set HS clock speed before sending HS
CMD13") fixes problems with certain eMMC, but introduced new ones with
others:

  qcom-msm8974-fairphone-fp2:

  [    1.868608] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA 64-bit
  [    1.925220] mmc0: mmc_select_hs200 failed, error -110
  [    1.925285] mmc0: error -110 whilst initialising MMC card

It appears we've overshot the acceptable clock rate here; while JESD84
suggests that we can bump to 52 MHz before switching (CMD6) to HS400, it
does *not* say we can switch to 200 MHz before switching to HS200 (see
page 45 / table 28). Use the HS bounds (typically 52 MHz) instead of the
HS200 bounds (which are only applicable after we successfully switch).

Link: https://lore.kernel.org/lkml/11962455.O9o76ZdvQC@g550jk/
Fixes: 1c7ec586fe55 ("mmc: core: Set HS clock speed before sending HS CMD13")
Reported-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Apologies for the quick resend; I fumbled the commit/send, even though I
had already updated the comments...

Changes in v2:
 * Updated comments

 drivers/mmc/core/mmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9ab915b5737a..82ca62c8669c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1485,13 +1485,15 @@ static int mmc_select_hs200(struct mmc_card *card)
 			goto err;
 
 		/*
-		 * Bump to HS200 timing and frequency. Some cards don't
-		 * handle SEND_STATUS reliably at the initial frequency.
+		 * Bump to HS timing and frequency. Some cards don't handle
+		 * SEND_STATUS reliably at the initial frequency.
+		 * NB: We can't move to full (HS200) speeds until after we've
+		 * successfully switched over.
 		 */
 		old_timing = host->ios.timing;
 		old_clock = host->ios.clock;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
-		mmc_set_bus_speed(card);
+		mmc_set_clock(card->host, card->ext_csd.hs_max_dtr);
 
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

