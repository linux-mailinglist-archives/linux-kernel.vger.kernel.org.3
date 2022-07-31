Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696725861B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiGaWht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaWhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:37:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DAF11156;
        Sun, 31 Jul 2022 15:37:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so4203877edd.4;
        Sun, 31 Jul 2022 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sUg3mbi85wkC20O/owxGcBmnSUP/JalL+pPQsthwix4=;
        b=bB75wBM9YfHXfB9SaWTPbVuoO0448vuhmS1nuYb+3RvRKk5o/oYE28YZm6MhYwehJh
         jsDQzsO5dmGRbz1HXmJb96WtbnyoE2aWPb2IgFHZ8AW3ryR9g4QsgotgQbmD/LB0Zs6G
         izsHUSYjfxNY2Oei46E6qbw9SxkhJqrYwq4ZsPCWqYhYspcAqMXqW6oxdYmwcE8NbjEv
         4rVPiZkmhLe6LvmlMYG/HUv66EIdz0LQbi27fn5YmeeMNwqQFh2IDMsEIqF4Pnw2pLr5
         c7AI6XnVI+73Ms+lXHNXakQmkuinXCa/TEEvMNcg7Oxky+NRDt3uuLAvyJ0J7jw6cJlH
         iSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sUg3mbi85wkC20O/owxGcBmnSUP/JalL+pPQsthwix4=;
        b=DR2SZ4DenoOHHiydT5dJhAaH+HcwYDGzS1TkjqsTrv2ea4uQuXytPyYSE02jiFaC41
         KCTQQYZyqNgwVHMyHMLsqyBYMoGpoDom5TQf/EG3L+yU0m4pXLi3kJ3hpGSkb882PO+y
         QZ2I+Ad8dVNWnTDkjhoBeNOjSiP3cl/iBR9qjF4uv9nF0BxileZK1Vp0J8BIPx55/W9q
         nHUYDawHuEV771JpbrBETr175JcpF8MA4MrUXZEHJEJKNZTnHfdYR2MhJ8jKOvMkGcns
         Bn7UG+Q1oZjfu+qE/opuFsn69FBLIS6oQ84oCyqcEJXFO56Be5MwHHgzU5otPjmaXVne
         GmTw==
X-Gm-Message-State: AJIora+nsYa4Sd4KgSot+bnxwSLD2sHzjjLknCpN05hDXKKnmdl3Dom3
        Y/3cl199FB8hvTfqmMqwN2I=
X-Google-Smtp-Source: AGRyM1vW7wD9jdt0hSkZT/Dae8z4eop9k1bk1UppwK+nPRdwezYV3XUJZdN9PLobODHeJRjHPno8zg==
X-Received: by 2002:a05:6402:4144:b0:431:6ef0:bef7 with SMTP id x4-20020a056402414400b004316ef0bef7mr12640724eda.151.1659307063871;
        Sun, 31 Jul 2022 15:37:43 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id gw6-20020a170906f14600b0072b2cc08c48sm4485591ejb.63.2022.07.31.15.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:37:42 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 00/13] PM6125 regulator support
Date:   Mon,  1 Aug 2022 01:37:23 +0300
Message-Id: <20220731223736.1036286-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds SPMI and SMD regulator support for the PM6125 found on
SM4250/SM6115 SoCs from QCom.

This code has been tested on:
* OnePlus Nord N100 (oneplus,billie2, SoC sm4250)
* Redmi 9T (redmi,lemon, SoC sm6115)

The main source used for this change is qpnp pm6125 support patch from caf [1]:

[1]: https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=kernel.lnx.5.4.r1-rel&id=d1220daeffaa440ffff0a8c47322eb0033bf54f5

v2: https://lkml.org/lkml/2022/7/26/885
v1: https://lkml.org/lkml/2021/8/28/144

Changes from v2:
- split spmi new regulator support in 2 patches
- FTS and LDOs now have set_load and set_pull_down ops
- add better commit messages on spmi patches
- fix sob header order
- fix tested device info (Redmi 9T, NOT Xiaomi 9T)
- improve formatting in spmi binding docs
- sort alphabetically in smd binding docs
- sort alphabetically spmi pmics
- sort alphabetically smd pmics
Changes from v1:
- add dt-bindings
- split SPMI patch into new reg types and the new PMIC
- add correct supply mapping

Iskren Chernev (13):
  dt-bindings: regulator: qcom_spmi: Improve formatting of if-then
    blocks
  dt-bindings: regulator: qcom_spmi: Document PM6125 PMIC
  dt-bindings: regulator: qcom_smd: Sort compatibles alphabetically
  dt-bindings: regulator: qcom_smd: Document PM6125 PMIC
  regulator: qcom_spmi: Add support for new regulator types
  regulator: qcom_spmi: Add support for HFSMPS regulator type
  regulator: qcom_spmi: Sort pmics alphabetically (part 1)
  regulator: qcom_spmi: Sort pmics alphabetically (part 2)
  regulator: qcom_spmi: Add PM6125 PMIC support
  regulator: qcom_smd: Sort pmics alphabetically (part 1)
  regulator: qcom_smd: Sort pmics alphabetically (part 2)
  regulator: qcom_smd: Sort pmics alphabetically (part 3)
  regulator: qcom_smd: Add PM6125 regulators support

 .../regulator/qcom,smd-rpm-regulator.yaml     |  26 +-
 .../regulator/qcom,spmi-regulator.yaml        |  32 ++
 drivers/regulator/qcom_smd-regulator.c        | 400 ++++++++++--------
 drivers/regulator/qcom_spmi-regulator.c       | 383 ++++++++++++-----
 4 files changed, 556 insertions(+), 285 deletions(-)

-- 
2.37.1

