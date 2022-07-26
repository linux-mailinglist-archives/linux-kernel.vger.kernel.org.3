Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADC581977
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbiGZSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiGZSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:11:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DB1F613;
        Tue, 26 Jul 2022 11:11:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so27544205eju.10;
        Tue, 26 Jul 2022 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SzyaL+YFgsWmKTqZ24upHaBMmdMUtz48LRdqS95T3OE=;
        b=NyVTDGWxvAdikaWNVk9np4Okz9MrqPd1fueSvko6rCKdv9lebe2W7m13u6sGVyU1ST
         yl/y7kSJxkSt0rA7jo55HLvOsLMSaKxjexigkLLzrhEFvvb+SNn3r8kTMK3iySN8Ex8q
         caLm7bKeOFhr9xRxTtOYQ0h2dPAHmnjA+dvQ1R7dNXjJyxZvSamW3/CgqFw6IGawKupP
         aYKrRUdJtuT9gkEpaze7/+sFCORzdjey2Zf/kXzrCExaZ7ErFG3f8GhdKA8W79m3MCD1
         OrV2Beb+evqzD80nt1slinPgOIZXOJicKFYO9Qy1kobKsDMmTvuIgDE4ZJJALnxlxZqg
         gWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SzyaL+YFgsWmKTqZ24upHaBMmdMUtz48LRdqS95T3OE=;
        b=QYKjscnbNrbgXlEGkUeIpiIz2UaTmGvRdaXYlMusF0/++tHpMISQUQ6KyLwjidKtG8
         6Kju0EiErCSDu81jWWCqK9f71AsYbc03UD6uy5IseAw6rz31HtvcX8OiT6K97UvFDUzg
         xiHlQK+mvSH5Sn+826iTx83SyhDWRBsjZQKg6iWQ5keiP3qJuD5W7MvnwHwGM4GcQxqU
         x2P65FhBmYTtBfdH86pdJrlMYHnW0E6yQ/Hkrr59QsTGXL54jOnJSRZxQDoVp9Bwapnz
         nZvX2TttUh1kcr4w/zGVVNTty9z3Rd2YUhNSRW2/tM4zyjvd9zFVcbPkPsx8h6d+jIt/
         04Dw==
X-Gm-Message-State: AJIora9f0aBU+fyMKt61x7keBxMIHya5IjwhR8pg2mJsddl7m0xsiaVR
        M+fvlcuFF3gQU6sd7C8vsBU=
X-Google-Smtp-Source: AGRyM1sGyGeihPMOBlclBHv7fDNWC4Y8ZiGgcSugmbB4OUrMjziIAKD2Hi/zk7EhwF0CNJLOPfj4JA==
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id 29-20020a170906029d00b006f018d87be0mr14229734ejf.561.1658859096908;
        Tue, 26 Jul 2022 11:11:36 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id ti4-20020a170907c20400b0072faba59dd1sm5290081ejc.165.2022.07.26.11.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:11:36 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 0/5] PM6125 regulator support
Date:   Tue, 26 Jul 2022 21:11:28 +0300
Message-Id: <20220726181133.3262695-1-iskren.chernev@gmail.com>
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
* OnePlus Nord N100 (oneplus,billie2)
* Xiaomi 9T (xiaomi,lemon)

The main source used for this change is qpnp pm6125 support patch from caf [1]:

[1]: https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=kernel.lnx.5.4.r1-rel&id=d1220daeffaa440ffff0a8c47322eb0033bf54f5

v1: https://lkml.org/lkml/2021/8/28/144

Changes from v1:
- add dt-bindings
- split SPMI patch into new reg types and the new PMIC
- add correct supply mapping

Iskren Chernev (5):
  dt-bindings: regulator: Document the PM6125 SPMI PMIC
  dt-bindings: regulator: Document the PM6125 RPM regulators
  regulator: qcom_spmi: Add support for new regulator types
  regulator: qcom_spmi: Add PM6125 PMIC support
  regulator: qcom_smd: Add PM6125 regulators support

 .../regulator/qcom,smd-rpm-regulator.yaml     |   4 +
 .../regulator/qcom,spmi-regulator.yaml        |  19 +++
 drivers/regulator/qcom_smd-regulator.c        |  46 +++++
 drivers/regulator/qcom_spmi-regulator.c       | 160 +++++++++++++++++-
 4 files changed, 227 insertions(+), 2 deletions(-)

--
2.37.1

