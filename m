Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC857EB1F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 03:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiGWBxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 21:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGWBxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5E73587
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 18:53:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b10so5710569pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zOMb5JQq7oT4D4mCscu+rB2TXNo1OHAZ5Z1k9q2pmg4=;
        b=X+SR+9JQxGmSIJAuRLWqRvFNr5sA17kNdIeoczXoQ5GthCHW9R9pFITkKnj/F4xkXM
         yefY20WDhjHl4plOW8VKsgv1v0NfBRFxfICKLMeO84AL5jLjvq5IVU78BX/yUZkdJ5MS
         s4dVKN7/InHy2mI3kkOkVecKXQfoTOUwoOwKl76TWUxCMUpvX2YeId5rfKquxPB56G1g
         iBW7fWtS5yFYWGukovhANWHm7GLm6Cn7AlvF/jLA1QWPimoiB8a+4sYKEXNGsqqtDwW4
         o61R8ABDkUl0iFzvS1lh5HlNHh6ORnmmsbWx8l8u64W1UBhPmlgtwSPbK5jW4m53bk21
         7koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zOMb5JQq7oT4D4mCscu+rB2TXNo1OHAZ5Z1k9q2pmg4=;
        b=WyQEHsBNg5secZuZVJjKQZBCcSW7OtWQO+fFfyAy9JxD0piMCqRLmBXhzOCKuykUjW
         5p4471ZxwMTLSUsh3uAuTIL3RP6MGGpF/Qer48c00ybRmbXM1pNcaJHaRcseXFabhSGs
         OVXJS+N8MdXhS52cCJ6j8z/FUfc/347xU2Z4i+sozTaZKZTwgjFBssiXv+ptd/j9AoAK
         nwf87G3wmkAXHcshWwzYeHgN02dDrwxaLuDjuFZrXxb14f9fpM3R6X6xPiKUAKzUWHJy
         QWuJhEXVBTlRvIN3NYRaPjQMBEfUGtQAVfrNfCn22SLuknPnwuErBubEg5kQh1cR5Riq
         jTLw==
X-Gm-Message-State: AJIora8L9U1gef/zM6iZ6AvNqc6rQBuTc1ox2G7To1qQw1K6eqcg3jM/
        4ePC1kt5mkjxTk3H+IeKJwc=
X-Google-Smtp-Source: AGRyM1tHEYoT3ayrsB98JEcmHXHTdU2hX7cPvrnxPbmiiFeGAt3ch8zSdaXZ50rY0p1NjwmsZKpSQg==
X-Received: by 2002:a17:902:a418:b0:16c:9ee2:8a02 with SMTP id p24-20020a170902a41800b0016c9ee28a02mr2249570plq.46.1658541188582;
        Fri, 22 Jul 2022 18:53:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-241-94-58.hsd1.ca.comcast.net. [73.241.94.58])
        by smtp.gmail.com with ESMTPSA id f64-20020a17090a28c600b001ef7c7564fdsm6250855pjd.21.2022.07.22.18.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:08 -0700 (PDT)
From:   Ryan Lee <ryan.lee.analog@gmail.com>
X-Google-Original-From: Ryan Lee <ryans.lee@analog.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, steve@sk2.org, ryans.lee@analog.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     ryan.lee.analog@gmail.com
Subject: [PATCH] ASoC: max98373: Removing 0x203E from the volatile reg
Date:   Fri, 22 Jul 2022 18:52:20 -0700
Message-Id: <20220723015220.4169-1-ryans.lee@analog.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 0x203E speaker gain register should be non-volatile.
This register value was not able to be synced because it was marked as
volatile.

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
 sound/soc/codecs/max98373-i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
index 4fe065ece17c..3e04c7f0cce4 100644
--- a/sound/soc/codecs/max98373-i2c.c
+++ b/sound/soc/codecs/max98373-i2c.c
@@ -442,7 +442,6 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX98373_R2000_SW_RESET ... MAX98373_R2009_INT_FLAG3:
-	case MAX98373_R203E_AMP_PATH_GAIN:
 	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
 	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
 	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
-- 
2.37.0

