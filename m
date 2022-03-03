Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDEE4CC323
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiCCQqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCCQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:46:24 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EFF186231
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:45:38 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r20so7567833ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNxRYTIRTdQS3Uk9HyapuEBzHV0re5gEtPBuITbOmLE=;
        b=OlYbmFgoIembJb4dmEloufc5AfyBYVGPfmzlTwr5p7q7flliNVRQM537ql2whgUxtq
         Y3KEtdcNlgbNOWFA2bGrM2GpPBdkRMU8M6Zc2f1SQgq9rQUlfdQmKP0um08J8XCHpPhH
         UDBooI5JTEO0/0UsnK49ju+1NzlgNBX76ntqATFON+DS6iV5u0yQMuek+cR4B11zLXJy
         BVl/RdDhglYcAUzV/QIDkU2JsgFymvKq1aYSMyhNuG1bx1jshhSVonkka2smIBkqUuGk
         BuEI5Md9kBxWJzi/Dy1uITku8zHD/SeXfHXNjjZMIBOWQaTmccSxX76Rjn2CqvSK72P9
         teGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNxRYTIRTdQS3Uk9HyapuEBzHV0re5gEtPBuITbOmLE=;
        b=uRBOGavJov3hF5glxcmqFuvyz0dsNZuZbAInunn6neEIPMLneqa+oKHXQhe9UC79O0
         ljfA5PY7Qa7Xy2ExaITbyaPQ+dlQw23hN72JN9Mn/67wnCLH7fhTvN3/pxUfDdbHmmlF
         YBX8TC2TPrsCB3F8Pd/PG6AZ9ZcWvVYL25RCTmFUNWJC0zBmkLDW8TKq9TA+vZYnQHgO
         z3riCLds2vIJt9pZ2hOPN8VqWvTrqUDR4mf3PLyfgp8386B82x7hWHqL9/tcoW9e11g9
         6bGfftE3z3P7AWdqZ+PwgxdjD8iPtYqaKINfkO+RVBXkuAicLXyeGDZwt+dRBYza9l7F
         o4tQ==
X-Gm-Message-State: AOAM533+dEREqGo7WHIxHIRhtKe9J9JE3baJhYXNVmfz3AIokdJ1n+Zd
        YNeUCJff7cnKUtJxVcbz7dcRQA==
X-Google-Smtp-Source: ABdhPJxOwlvU5gxrkpTL1hFnpcjmRHKMXlCq+qH5fthfL/CXLL3ygqYvRCHb8orOcTmErR9AFkUOuw==
X-Received: by 2002:a05:651c:a07:b0:247:b7fe:8a35 with SMTP id k7-20020a05651c0a0700b00247b7fe8a35mr3165974ljq.433.1646325935207;
        Thu, 03 Mar 2022 08:45:35 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id r25-20020ac25a59000000b0044394f8a312sm521102lfn.75.2022.03.03.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:45:34 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Improve fallback to speed modes if eMMC HS200 fails
Date:   Thu,  3 Mar 2022 17:45:22 +0100
Message-Id: <20220303164522.129583-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error path of mmc_select_hs200() we are trying our best to restore
the card/host into a valid state. This makes sense, especially if we
encounter a simple switch error (-EBADMSG). However, rather than then
continue with using the legacy speed mode, let's try the other better speed
modes first. Additionally, let's update the card->mmc_avail_type to avoid
us from trying a broken HS200 mode again.

In an Amlogic S905W based TV box where the switch to HS200 mode fails for
the eMMC, this allows us to use the eMMC in DDR mode in favor of the legacy
mode, which greatly improves the performance.

Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 141f851c9f58..6e7db45cb8e0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1518,13 +1518,23 @@ static int mmc_select_timing(struct mmc_card *card)
 	if (!mmc_can_ext_csd(card))
 		goto bus_speed;
 
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
 		err = mmc_select_hs400es(card);
-	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
+		goto out;
+	}
+
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200) {
 		err = mmc_select_hs200(card);
-	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
+		if (err == -EBADMSG)
+			card->mmc_avail_type &= ~EXT_CSD_CARD_TYPE_HS200;
+		else
+			goto out;
+	}
+
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
 		err = mmc_select_hs(card);
 
+out:
 	if (err && err != -EBADMSG)
 		return err;
 
-- 
2.25.1

