Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3B5A1705
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiHYQnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbiHYQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:42:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD5BB905
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 142so1220735pfu.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1RT2iBx43NFnjKdHIG/TzkNxgoE8HvvMK/6A5nGIZY8=;
        b=mgSd+WoXDWNWU0XwWzElQKlmWtID7KaY+b+/WeMIkVePriS+QaXgUQm4is+ZAH4EID
         3sX8UGeLlpZqV+H48zhiX5nbKwVU2mEHKd985xZ0t4Z5+Xf6AsvMXSTgt7ygtfsCCuob
         sABCZmpD6MLcY9ShL6GmALPKF4LK+fN+/A8SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1RT2iBx43NFnjKdHIG/TzkNxgoE8HvvMK/6A5nGIZY8=;
        b=Z+T6a+XHYGWYJznA6XQPSKS05sOMZWNuXeOXRwRnp/l1yteY8uIioVhOJ9vFhzWXa4
         jXPJoeH1JpuxJfnypGkR2TZfEicEcmYiJWx0tmZTMdUTSaAr5aomrUu7DBq7xcAIOqdo
         bFJg/guLojJcbtosGWHTCwdlYJO2JetkvAUK7re2fj/i+J/kbJSZFRCbxXUkFssa71+W
         FdVpHFbsY5OIIR0aKg4nSkFYxvCOmMpEDdyFVISfM+NqunoZdYmRyKhe3ahN/e4UX2mY
         ngmi1xfUR/YFLdRIoa680761EP8vtSIjGRUiISpt+rw9mu+QCIiWwuLJGmC+hfrkuViK
         Wbgg==
X-Gm-Message-State: ACgBeo2t4hAH3hDRNsIjeeG63mzAmtv24QavzvYP1CT4IBiHMeYtUI8U
        sX/LklA8A7oLWK4Ejy15v0m8ZA==
X-Google-Smtp-Source: AA6agR406ztk6+TEctlehR5sbJcg72II+iivP+WveLx1DRge8yz0O+tAvdkI3RzGAAfLeaoHgO2yEw==
X-Received: by 2002:a65:6755:0:b0:41d:70c1:be0 with SMTP id c21-20020a656755000000b0041d70c10be0mr4043646pgu.99.1661445750998;
        Thu, 25 Aug 2022 09:42:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:b7f2:d739:e847:6e53])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a154d00b001f2ef3c7956sm3775799pja.25.2022.08.25.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:42:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] arm64: dts: qcom: Fix broken regulator spec on RPMH boards
Date:   Thu, 25 Aug 2022 09:41:58 -0700
Message-Id: <20220825164205.4060647-1-dianders@chromium.org>
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

Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()") several boards were able to
change their regulator mode even though they had nothing listed in
"regulator-allowed-modes". After that commit (and fixes [1]) we'll be
stuck at the initial mode. Discussion of this (again, see [1]) has
resulted in the decision that the old dts files were wrong and should
be fixed to fully restore old functionality.

This series attempts to fix everyone. I've kept each board in a
separate patch to make stable / backports work easier.

Affected boards were found with:
  rpmh_users=$(git grep -l -i rpmh -- arch/arm*/boot/dts/qcom)
  set_modes=$(grep -l regulator-allow-set-load ${rpmh_users})
  but_no_allowed_modes=$(grep -l -v regulator-allowed-modes ${set_modes})

Fix was applied with:
  for f in ${but_no_allowed_modes}; do
    sed -i~ -e \
      's/^\(\s*\)regulator-allow-set-load;/\1regulator-allow-set-load;\n\1regulator-allowed-modes =\n\1    <RPMH_REGULATOR_MODE_LPM\n\1     RPMH_REGULATOR_MODE_HPM>;/'\
      $f
  done

Then results were manually inspected. In one board I removed a
"regulator-allow-set-load" from a fixed regulator since that was
clearly wrong.

[1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid


Douglas Anderson (7):
  arm64: dts: qcom: sa8155p-adp: Specify which LDO modes are allowed
  arm64: dts: qcom: sa8295p-adp: Specify which LDO modes are allowed
  arm64: dts: qcom: sc8280xp-crd: Specify which LDO modes are allowed
  arm64: dts: qcom: sc8280xp-thinkpad-x13s: Specify which LDO modes are
    allowed
  arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes are
    allowed
  arm64: dts: qcom: sm8250-xperia-edo: Specify which LDO modes are
    allowed
  arm64: dts: qcom: sm8350-hdk: Specify which LDO modes are allowed

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      | 13 +++++-
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 45 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 33 ++++++++++++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 30 +++++++++++++
 .../dts/qcom/sm8150-sony-xperia-kumano.dtsi   |  6 +++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi |  6 +++
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       | 12 +++++
 7 files changed, 144 insertions(+), 1 deletion(-)

-- 
2.37.2.672.g94769d06f0-goog

