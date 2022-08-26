Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37575A1E17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiHZBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbiHZBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:22:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37FDC6E81
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:22:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so91570pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gY3tlF3vENa5itYuSBx/pa6KL0Udf7AS/e/RUrrnffM=;
        b=H3igN1/yHvXXMjmVn4kWJ8Doatb6ptuxzFkFWpXbIRJUBy2um69V57WqimgHiLgkqm
         +Iysp9DuFgCDu1pfdZnUJYGJg0/XCZV+ubCs7nBX4fG8hRcbdzVaqRSl17ULmpE366aC
         UIjGOygGlVeIc0gNPqyQ2zAYPRXg4/npFzmAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gY3tlF3vENa5itYuSBx/pa6KL0Udf7AS/e/RUrrnffM=;
        b=nuxDMXcngGdS3+UgVcnQ8Btvjah6OnKEOrX7arwDBrLvH/KgKApkGei0byrYXWkyr2
         uv9CSQi0lXRIPL2iBX7GV7SooYXndY/q4LZJ1wYbvXmuYHteG+x6vybheChNvQ/cX1RE
         uPjFl7djGhG9f8tjxHwnxstgEYQAFJydschnKYTpVicBtdDiJ4NUSolAPMvUXHs/CdM3
         zmMEoacoeYrusIY1bldKyn2DjB849dsJo8C9ipWz7hplXBMLyyQkzIMk3U+1zu4hLUny
         BRs/9N0NPep89Lrpbw+NfOiS0NfZEYUukrsEFfX/wjrpD0wOM0Ljha8kkuYlczPrNJ0s
         ZOXw==
X-Gm-Message-State: ACgBeo0fYNgB/J2AZ4+bja5A/AZjV/npx3tDGVnPHDMkCEex8rCi4BaY
        1gy3y+1tv1C7bOKIBfMbz0yTzw==
X-Google-Smtp-Source: AA6agR5Tq03n2LBQdmBzk9YoR2dPliY0RNs3VGu0MMT6FJlzVsdMYfhy5YqbQISsMs4sqNR7md9nEg==
X-Received: by 2002:a65:6d13:0:b0:41d:7380:e9cc with SMTP id bf19-20020a656d13000000b0041d7380e9ccmr1375243pgb.153.1661476925137;
        Thu, 25 Aug 2022 18:22:05 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d529:f79d:2a1a:4e61])
        by smtp.gmail.com with UTF8SMTPSA id q17-20020a170902dad100b0017315b11bb8sm192415plx.213.2022.08.25.18.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 18:22:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, linux-clk@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 2/2] clk: qcom: gcc-sc7280: Keep the USB GDSCs always on
Date:   Thu, 25 Aug 2022 18:21:59 -0700
Message-Id: <20220825182152.v2.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
References: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the GDSC is disabled during system suspend USB is broken on
sc7280 when the system resumes. Mark the GDSC as always on to
make sure USB still works after system suspend.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- set the flags of the GDSC not of the GDSC power domain
- updated commit message

 drivers/clk/qcom/gcc-sc7280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 7ff64d4d5920..adef68d2cb0b 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3127,7 +3127,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
 		.name = "gcc_usb30_prim_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
+	.flags = VOTABLE | ALWAYS_ON,
 };
 
 static struct gdsc gcc_usb30_sec_gdsc = {
-- 
2.37.2.672.g94769d06f0-goog

