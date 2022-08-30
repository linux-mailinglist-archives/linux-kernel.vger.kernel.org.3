Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F155A5C43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiH3G57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH3G5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:57:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA16FBFE8C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:57:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so14239257lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=gCwpNLDMpXQSS7AiyBMzYy6/b6a5lM4AHUWEyRxEheE=;
        b=RwL+hWZspNoAeIKIIerlBy1vzvjnmuMqwt4V941FymEbufeHzTvJsDNrL8ufJosAzO
         aSVYjZx46D2WWv90IkfOtpI66OMcpn0YHcYR1SV4Xr/2ZEIJ9SxXJoRjGC8gHYFTnTvp
         djMIT1ZjB+hp8djE/DoNznsnZ+cnes3cdyOtZfLso35ekQUOdyeMoi+l3PFbfSPzQOzO
         aXMx6i4yRwL7Ou3gspuW9dT7EnLhmxOjBfgmo1WJnrTXqqDpLepXLI978+mC7ciZhzXA
         MybZ04pLKbt1ukYLXIOW9Mv8n+1IBTa3npReU5oEGQ/bD6Ioy7lpfFeYvSrF2M1N7uz/
         woWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=gCwpNLDMpXQSS7AiyBMzYy6/b6a5lM4AHUWEyRxEheE=;
        b=QSA8Eedlfpeju54Im/n8nh0XpqBL7i1kR0M+eymdoFYpdDwDwQA9UBiN+A+Z7rdxXY
         TwCfHiggnoVuFuDShXcoknr5ToIBoJRaEHw9KL5AdVedTadqrMe6h/RCipYf/+pdexzr
         vuh6C8Wy5OTDGo+jJlFT4xnSUKYjji11rcwtKfqTTwGyFGUQMNssdBYjnnPte+r00oH+
         dJ/L+UE0BM5GR+9K6mMeP/Qopykr/TrjTVdddvv9gLy3f5SYZxAdNrSF+ABusMXMbLS9
         uDYqVJRimi0VQcoPFLDI8oa6OU6Ut3we638ZaaZXN7l/VcfHxVnKzsbK9IIXzNp2yFcj
         Y1qw==
X-Gm-Message-State: ACgBeo3vpNQolq0+pLcGZqKcKjtcjldqnkFsgGFovq7e2/bzq8S8OoO5
        lYrgxfvkQ4/Bxe9w7rotpv4hXA==
X-Google-Smtp-Source: AA6agR69nf0m+V8bp0uiBDVV8RuGuHrMT3v6x68EhNLM5xkk0p6YYDN5UHkGu4q0oHLjoHaT0bzzog==
X-Received: by 2002:a19:6b03:0:b0:492:c560:b733 with SMTP id d3-20020a196b03000000b00492c560b733mr7483504lfa.320.1661842667095;
        Mon, 29 Aug 2022 23:57:47 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512074100b00492cdba2903sm1515420lfs.97.2022.08.29.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 23:57:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 0/3] dt-bindings: arm: qcom: qcom,board-id and qcom,msm-id
Date:   Tue, 30 Aug 2022 09:57:41 +0300
Message-Id: <20220830065744.161163-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v6
================
1. Rebase (new IDs).
2. qcom_board_id2 -> qcom_board_id_named (Bjorn).
3. Add Rb tags.

Changes since v5
================
1. Dual-license qcom,ids.h (Rob).
2. Minor corrections in comments.

Changes since v4
================
1. Change the qcom,board-id oneOf (oneOf at higher level) so newer dtschema is happy.

Changes since v3
================
1. Patch #1: Define all SoC IDs, based on Qualcomm socid driver (Konrad). Keep
   Dmitry Rb tag, even though it is quite a change.
2. New patch #2: use bindings in the socid driver.  The patch fails on checkpatch:
   "Macros with complex values should be enclosed in parentheses"
   but that's expected considering the macro contents.

Changes since v2
================
1. Adjust description of new fields after review (Dmitry).
2. Change name of msm8996 define (Dmitry).
3. Add Rb tags.

Changes since v1
================
1. Make the qcom,board-id and qcom,msm-id properties deprecated and limited to
   certain SoCs (Rob).
2. Extend the qcom,board-id schema to match OnePlus variant - four elements -
   and drop DTS patches splitting four into two touples (Stephan).

Description
===========
The discussion [1] brought several arguments for keeping the qcom,board-id and
qcom,msm-id properties.  Keeping means we should document them, so the DT
schema checks pass.

I revived old patch [2] with several changes and improvements.  The commit msg
hopefully collects feedback from the discussion.

Best regards,
Krzysztof

[1] https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
[2] https://lore.kernel.org/all/1425503602-24916-1-git-send-email-galak@codeaurora.org/

Krzysztof Kozlowski (3):
  dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
  soc: qcom: socinfo: create soc_id table from bindings
  arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples

 .../devicetree/bindings/arm/qcom.yaml         | 120 ++++++++
 .../boot/dts/qcom/msm8992-xiaomi-libra.dts    |   2 +-
 drivers/soc/qcom/socinfo.c                    | 265 +++++++++---------
 include/dt-bindings/arm/qcom,ids.h            | 155 ++++++++++
 4 files changed, 412 insertions(+), 130 deletions(-)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

-- 
2.34.1

