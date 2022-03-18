Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B114DE2C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiCRUtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiCRUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:49:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB33E2D1D5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:48:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n2so7944232plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlaK0t4nYOfCA2Y4/D2tkqvIvLXiGsDErm7SK3XkjdI=;
        b=YW1UFGORv7nwfPoJeSq8/bAy761PKFzY4o8x/ukhrrdfAd70YcmqykzD1dDlmfrqOx
         +hNruCzt2jjDuT12pTcLxfQIJmBPl8CZYNC6YcBkR/FQYj5Dc6/hRc2IgLZxbYT+KBZz
         ZK4cYe8tIwZ/2K2aL/cvTxR+3qefHeWWdGKTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlaK0t4nYOfCA2Y4/D2tkqvIvLXiGsDErm7SK3XkjdI=;
        b=jFp8IS9I5L/MPObUuSZ2pKo0UbM98qh6bNCMRjNo4Zzh/T8uz7vd2I882DvWVZXYc8
         Io+dJEeZsne+Lk8Iu6DiXDc80vfolMs8ZJPWeYlAOf92MYKvt1LuobQYpqYQIvmI9CiM
         TShQi5dRFbcAMAmllsb695FutteUN6CHySS7GgwDzBAmaasbAqv0SgZxHOHaVdNPvK9V
         Z5XEv8K1JqDpv1LrcZMaoOUQkyDUJ1z8E533/JbBH0eZ9zjXKgr9H0FkxVAkw7eC8wBW
         YQwybgenn86B0KT7ONZk/6V4ye3ZC7wZVQA3x0QXh/M1ee3pPXbL95wrLPSO1LwMygo1
         mMlw==
X-Gm-Message-State: AOAM531BDNb0mEmTxXmb5+7d/o2vMe6pq4ucBUhnSaMmQfxQ1HdXGHqv
        WVMcdLDf9kyxzcYBBagmlo/PH1gYM9qmaQ==
X-Google-Smtp-Source: ABdhPJxFovuPfosyUgI0jjp9lhIxEbfgu299pf7CRORC35vuTw+7XiOoMPiByruJt2GKSaATsmfYPg==
X-Received: by 2002:a17:90a:e7cc:b0:1bf:5ab5:f481 with SMTP id kb12-20020a17090ae7cc00b001bf5ab5f481mr23539576pjb.215.1647636490249;
        Fri, 18 Mar 2022 13:48:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:8a24:4160:f3b6:42dd])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00170b00b004f7a83058d5sm11151891pfc.16.2022.03.18.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 13:48:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
Date:   Fri, 18 Mar 2022 13:48:08 -0700
Message-Id: <20220318204808.3404542-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four possible gain values according to sx9324_gain_vals[]: 1,
2, 4, and 8. When writing and reading the register the values are off by
one. The bits should be set according to this equation:

	ilog2(<gain>) + 1

so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
in the register field, etc. Fix up the functions.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Cc: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 0d9bbbb50cb4..a3c8e02f5a56 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -379,7 +379,10 @@ static int sx9324_read_gain(struct sx_common_data *data,
 	if (ret)
 		return ret;
 
-	*val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
+	regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
+	if (regval)
+		regval--;
+	*val = 1 << regval;
 
 	return IIO_VAL_INT;
 }
@@ -725,7 +728,7 @@ static int sx9324_write_gain(struct sx_common_data *data,
 	unsigned int gain, reg;
 	int ret;
 
-	gain = ilog2(val);
+	gain = ilog2(val) + 1;
 	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
 	gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
 

base-commit: a8ee3b32f5da6c77a5ccc0e42c2250d61ba54fe0
-- 
https://chromeos.dev

