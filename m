Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECCD5643EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiGCD53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiGCD5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:57:18 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D47B4A5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:15 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 7-20020a9d0107000000b00616935dd045so5093150otu.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snrkagiaFToMeBr21bRTKrlxkSQCSpQ0cEg/PIZ5uzg=;
        b=sbNGynFJ2A5lFstzLqmnKsW42KDi0T5cKUFRDzCq0gSy5JoWiVbbMr8GZPSr1+RFft
         gJcSdjGGoQH9cuhXlskuANKXGfsmiVIvCk1G/EqjcwAYrRONO0QeG8eb1//GGou92y3/
         M5pypInc3rhbCFxIZ0oYq2LCVwjh+36OLO8U/mo7EINMHluuw0+HmM2G1ULRV2GD7von
         lC+DkC5Pg5cJR4DRq9A5pBeq0GRq6cyb5th1GnzompnEBkDSc2ppZOg52YoFH2cCeIhr
         aMdgTTrzu/qIaJB+5S3Dc+t0EILZ7IFyEzaGBUA+MqMfoX+iGZRWpKYWI9Q7IKX/Yutq
         I1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snrkagiaFToMeBr21bRTKrlxkSQCSpQ0cEg/PIZ5uzg=;
        b=H4zOiqssySAQo3ZowEpSdM/3Cj0wG/NWUt5m5PWqHV409BLx6HXrC3fIx+kh8nCtVw
         eJ37k2A7TiErCGECCxfxwZvl5FLpNn3jkBuHfclsWA4/IbM4kHq61WYL6GvxeQgm5Gsp
         /4lRwUkbks1f1NiASXawevLqBdW5/QoyhTf9YXcPkuB4/5b6si0i8kvg2LV9/kHYTDJy
         joNeYgP8ADzQ1E2UyhGlM5CVHrz//1TCAmBx2MXFeaN25ud2M0pS1xCEbQgncT/s2KjN
         6FgJFfhEjnDkY8+CLf1wYt7oAzjDZBI6Xd1Uj3nQCNTpjY+VfcEVJwDi3Bf9MbkjEAXy
         lYWQ==
X-Gm-Message-State: AJIora9Sa9C/o97hXWhpyKTMrkT42GYX7vFxDY4x/6aRwA/YLhuMV3wt
        ARaCV+qnmFJQzJAEHv5UZooCvGtJ4McN+w==
X-Google-Smtp-Source: AGRyM1t1I8kEohKlTetLwdGOiavAXGpm7R+g2pn5Lf2IzhF1ai0bjPiRsH2/awunAn0tfbeorjypwQ==
X-Received: by 2002:a9d:6e1:0:b0:616:9489:b047 with SMTP id 88-20020a9d06e1000000b006169489b047mr9796600otx.21.1656820635104;
        Sat, 02 Jul 2022 20:57:15 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v14 0/5] arm64: dts: qcom: sc7180: Add five new trogdor-based boards
Date:   Sat,  2 Jul 2022 22:56:11 -0500
Message-Id: <165682055968.445910.12021988440000679786.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220626013906.885523-1-joebar@chromium.org>
References: <20220626013906.885523-1-joebar@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 18:39:01 -0700, Joseph S. Barrera III wrote:
> This series adds five new trogdor-based boards to upstream.
> The patches should be applied *after* applying
> https://lore.kernel.org/all/20220602190621.1646679-1-swboyd@chromium.org/
> (arm64: dts: qcom: Remove duplicate sc7180-trogdor include on lazor/homestar)
> 
> The patches do *not* expect
> https://lore.kernel.org/all/20220518172525.3319993-1-swboyd@chromium.org/
> (sc7180-trogdor: Split out keyboard node and describe detachables)
> to be applied.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sc7180: Add wormdingler dts files
      commit: e0ff30b23de99f55197692fcb11bee9ba4f2c559
[2/5] arm64: dts: qcom: sc7180: Add quackingstick dts files
      commit: c77a3d4a2bfa0957121ec7050e68bfcc73932a52
[3/5] arm64: dts: qcom: sc7180: Add mrbland dts files
      commit: 9520fef900494dd202fda5d2b3cfc2cfcb674ad9
[4/5] arm64: dts: qcom: sc7180: Add pazquel dts files
      commit: fb69f6adaf88a70beb671852bc2842cb79c31059
[5/5] arm64: dts: qcom: sc7180: Add kingoftown dts files
      commit: 6afcee78b4a495ed970ef3c5104f91ed649d478a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
