Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9751A3F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352373AbiEDP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351814AbiEDP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:28:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE344A04;
        Wed,  4 May 2022 08:24:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x18so2549191wrc.0;
        Wed, 04 May 2022 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQbqkKFVhO0oYTCViggW509ZlaV6AfefEm9f3k12+eg=;
        b=I3V5xwc9mmJq9PbDd0vvDdHFo49dVPjTOVRWlp22XUQElQp0zzIOBiGS7b0ynHNI5Y
         BwjGbVvkEMSmalnyMryP7nneYZhAcm6vHowvvYE6n0fJ8K5HDt88esL6adDs7OOPw7sG
         mPK767DkFjwK1lK6DRPOiY3bhlBTG5l37G7dA2OEPfK3sDrnMU5t0fLAkItQ8teLwhqC
         ZpR67GAX9dKU16IKNP6/2WUsB2aVJ7ehlNOP9/mLj4rtzv6YyEBRMnJ4dVrwDZwmz4JZ
         OU1iw8EeAu+71o96y9De7kEeWsNyQO/1bKKe1eYPzZAQJSxDDex47/QpG8NvZKDFKD44
         R7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQbqkKFVhO0oYTCViggW509ZlaV6AfefEm9f3k12+eg=;
        b=CD/IJWzJRkPNEMfr6ordz1MGtUZbalOSjOjuEv9StPFu2httFxzS7DsDAdUunN7Gg9
         y9JJqhGi5mPPyVBJqwppKjxoIhwMHI5rheIe0KCoQLs4LSGGuUKckN27Rx5CUi0SeGSo
         T8nAndGpuqu3S78jbJ8cxWTocdm4G0ClKwBdm8U7JDCn4YcQ9DzM/pRZeeRSuROdUybt
         CmoRWQflb7RENcpVP5VI8Z4Ca1g3fLNThcG/OVPhSwNFp5MA/TR0qRnf+Y8BX++EZ028
         PAZvxy5sCfrKl1W2Fi9OPJXm8tw4B9F+KiyOgQiLMUWnbcgQoykNfEZWXpOxvVdO6WiK
         JCFg==
X-Gm-Message-State: AOAM5321hHb71tKIgWIHwlolmwVa5L8Sn56Kw9OIytBVAZ5kXDdQwzfh
        yIUmPp/jaLWctMrkvRtWxYmOv3gUqZM=
X-Google-Smtp-Source: ABdhPJx1+G9RDiWmcUyMeC6S39k0ed5r/nxqS1nrwlLkRDOPOUOrL74l7Ui9N2K4sanMxhRsUk7IQA==
X-Received: by 2002:a5d:6dac:0:b0:20c:5fbf:5c4d with SMTP id u12-20020a5d6dac000000b0020c5fbf5c4dmr12489091wrs.548.1651677884735;
        Wed, 04 May 2022 08:24:44 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id s14-20020adfa28e000000b0020c5253d91csm11541041wra.104.2022.05.04.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:24:44 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lin Meng-Bo <linmengbo0689@protonmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] input/touchscreen: imagis: Correct the maximum touch area value
Date:   Wed,  4 May 2022 18:24:03 +0300
Message-Id: <20220504152406.8730-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504152406.8730-1-markuss.broks@gmail.com>
References: <20220504152406.8730-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As specified in downstream IST3038B driver and proved by testing,
the correct maximum reported value of touch area is 16.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/input/touchscreen/imagis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e2697e6c6d2a..b667914a44f1 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -210,7 +210,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
-- 
2.35.1

