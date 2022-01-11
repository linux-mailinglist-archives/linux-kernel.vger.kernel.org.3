Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26748BA79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbiAKWFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbiAKWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:05:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02689C061756
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:05:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e19so893556plc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pZg0j1z31z4dOAHR0v7nBDp7zlxEyAkVFUFENElCB8=;
        b=Q3Q9cgZpVUzHIhd8PSRDyNaoFL8ZmwZHfUxTsrOb9uxSVnZI5UKeJR/MwT9108Sh5+
         4npaWvqPeHxFmu3SHD4Ik/RxhBstWlDlvUvR1owC+KAxT2MDhAxvPudsVb7FqI7CqCKL
         geizo3KsG55e5q3+XbRecjvUKtorpRtOxYaTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pZg0j1z31z4dOAHR0v7nBDp7zlxEyAkVFUFENElCB8=;
        b=TSGpRBuarG3GF7YcwE1B4ObvtgOAEEOb8UPQErL08lRDcij/cTFTHz/ObGTrGo7etT
         ULNKNAM2m9A4WcR27rquz6eUZwgTfKrTFVzTYA5agDi3CRcml3oAIFifqoxaViC8x9Jk
         PHqRQhpMsxLm6OzTtVFnckD/mGs0cXRqM386NWXXskfRj3wC7N+YycHMIM5UqPafG7nZ
         f59gYcRy0DMTERpjn80tAclJRVzVQA57UGN4xn0JRuz0sVOG/H5g5Ugb/yURRWpe92Zb
         iTSpGqz2eWMJNTPbt01BYZkcN5yNQo3jxTAmz9wkEVEThKALpwaNzpWH2g7jAY1Q2rc0
         6ChA==
X-Gm-Message-State: AOAM530JjqjDA+jdnY48Uk98YTzAAB/WpvtNDhTDIdu17WFAJquOz4ad
        DDqxcfJkgXxHVSp/RwAFwj+gtA==
X-Google-Smtp-Source: ABdhPJxyOF4Tw0NiPrnu7TMfn/9n7P7Kn8lS425Di9hUjXcgZkzQf3zhSVj1wX3Rnpks5wsTSJq/Fg==
X-Received: by 2002:a05:6a00:2442:b0:4bc:e7ac:b5aa with SMTP id d2-20020a056a00244200b004bce7acb5aamr6529915pfj.56.1641938743547;
        Tue, 11 Jan 2022 14:05:43 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:ce5:9cab:3523:b066])
        by smtp.gmail.com with ESMTPSA id t207sm10700413pfc.205.2022.01.11.14.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:05:43 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: drive-strength doesn't default to 2 if unspecified
Date:   Tue, 11 Jan 2022 14:05:21 -0800
Message-Id: <20220111140519.1.Ie2662d6289af1e9758b14b37149703c846d5f509@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the drive-strength isn't specified in the device tree then it
doesn't actually default to 2. Instead, it defaults to whatever the
heck the BIOS left it at. If the BIOS doesn't touch it then that means
it's whatever the heck the initial state of the pin was when the SoC
booted.

Reported-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index 3b37cf102d41..dac788bc9320 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -70,7 +70,6 @@ $defs:
     properties:
       drive-strength:
         enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
         description:
           Selects the drive strength for the specified pins, in mA.
 
-- 
2.34.1.575.g55b058a8bb-goog

