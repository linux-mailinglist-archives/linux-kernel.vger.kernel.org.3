Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AED5883E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiHBWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiHBWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208A286DC;
        Tue,  2 Aug 2022 15:11:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kb8so13730491ejc.4;
        Tue, 02 Aug 2022 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=HHiVzz56fzfDth3bW/WcgM5Qc1HIfz8NCIqzrBsVAqA=;
        b=Ep2scTW+1V+PPP51UKUrN/QcsHJFvcufwTIrXWw53crGOzKX0lGl9zG98wdoAn0v60
         ZFPNCdnxeYQ4PMoOVhCD4HYuQzQ1JbxicXYg97IzVtPgGWEZQC6rRdgesoK0CyB8kw98
         1xx1VH4Zp+QzQ1K/Fne6HePh9wA/AuhHpYQ11TtfP6TBcNK07lbuA0RJ4d2n4frolIiC
         8DugPNCvRESj8EtrPpHy2ZUX3DqcXTvTPuTuRYBwjstArjoZAD3PwU/pJ9Huzk3IUm64
         xbqACAI2zyXvFw1evnqtnQNQIrUXCyiq/8gS2UeLGyowMOdh1GX0y5TRlzEp8O3zsqs4
         bL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HHiVzz56fzfDth3bW/WcgM5Qc1HIfz8NCIqzrBsVAqA=;
        b=DsvgE7ugZSfMoWIOsX8xStMGjGCY1xKB9io7DVFzoQFfUns5MJYJYiLV6rHhGs1BN5
         Z7jTGuWxR75cq852netMiQeW69PmBtsNE61iBUmD9bjmHCWSu8RtnZcvK4x7MWBPpvyn
         pusWxCRhcKS0cVUTckczzeSEasFPh3yjjU9OjYxz/H0Qg7tRcNXPT05EzQF77MKOJlHG
         oWzXsa8yxLrQ9DO4Z4I2gXwYQM0Rs+jUfJ9SauRCyFo0QUnh57+UjStDxM0EQNfKlVzz
         O9FlJoVD6MNoRgQa+uTJNu6uFXUVj1S/Q+8GkxBJ9CVQsicQHtfmMCqPcnu7arjYDet+
         7DRw==
X-Gm-Message-State: ACgBeo0BnRa68DKwlWlJAZuqThk/80LNnI2avOPn07RcYTvJw7vj8+KJ
        FjKplrTIf/onbOCm76VkrFQ=
X-Google-Smtp-Source: AA6agR4uy8jogXMuvE9MxR3ZPhOX/nwv7hlTjSbAYm8NBwcVR59Ubxdo7aRW9vlsLU7ZJkb1sACdxA==
X-Received: by 2002:a17:907:9726:b0:730:9e04:f738 with SMTP id jg38-20020a170907972600b007309e04f738mr4851247ejc.631.1659478289863;
        Tue, 02 Aug 2022 15:11:29 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906292900b0071cbc7487e1sm6589271ejd.69.2022.08.02.15.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:28 -0700 (PDT)
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
Subject: [PATCH v4 00/13] PM6125 regulator support
Date:   Wed,  3 Aug 2022 01:10:59 +0300
Message-Id: <20220802221112.2280686-1-iskren.chernev@gmail.com>
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

v3: https://lkml.org/lkml/2022/7/31/303
v2: https://lkml.org/lkml/2022/7/26/885
v1: https://lkml.org/lkml/2021/8/28/144

Changes from v3:
- fix compilation issue reported by kernel test robot
- reorder HFSMPS/LDO+FTSMPS patches
- add new slew-rate computation for HFSMPS
- add proper pull-down support for new regs
- name new regs/vals after HFSMPS instead of FTSMPS
- address indentation/newline issues reported by Krzysztof
- improve commit messages on SPMI/RPM related patches
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
  regulator: qcom_spmi: Add support for HFSMPS regulator type
  regulator: qcom_spmi: Add support for LDO_510 and FTSMPS
  regulator: qcom_spmi: Sort pmics alphabetically (part 1)
  regulator: qcom_spmi: Sort pmics alphabetically (part 2)
  regulator: qcom_spmi: Add PM6125 PMIC support
  regulator: qcom_smd: Sort pmics alphabetically (part 1)
  regulator: qcom_smd: Sort pmics alphabetically (part 2)
  regulator: qcom_smd: Sort pmics alphabetically (part 3)
  regulator: qcom_smd: Add PM6125 RPM regulators

 .../regulator/qcom,smd-rpm-regulator.yaml     |  26 +-
 .../regulator/qcom,spmi-regulator.yaml        |  32 ++
 drivers/regulator/qcom_smd-regulator.c        | 400 ++++++++++--------
 drivers/regulator/qcom_spmi-regulator.c       | 378 ++++++++++++-----
 4 files changed, 551 insertions(+), 285 deletions(-)

-- 
2.37.1

