Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A65A080D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiHYEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHYEjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:39:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCF9D8D4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:39:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jm11so17484680plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ldbgClxWpBKCxrj/3uY8okm4inrFKKo2WFHVJ+auIJk=;
        b=CtTuRctWjf2/XPmjrVbrZBArOydoMIZp1kOBD1LrXSmm8HdHbsREOWPfsOKNOwDjHJ
         ZlCicaFg6T4R52gPgxUDhu8UhSIfgq6sveH6/i1fTYAsh8hT66wsNYoOik2zccelUmUd
         ft6OMyOFLX7A1XVpvaES15Frket8clPMuYrumPf1vEUY5DkZ5Mug865DkrxEvl6R49zX
         lau03cpGeBuOeivyFwCuCVYyGjcxP3ssAtocW6yLv0T7pbhsrni4zvdbt/cyM91yqF5t
         r32lXUNruwYNFO4WJu7bxQduhO/EBY8ZUijRIRtNUAIErUxJoKVzJYgfMtmtrfXDA5l9
         +zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ldbgClxWpBKCxrj/3uY8okm4inrFKKo2WFHVJ+auIJk=;
        b=OkVhe6DrCNPu8cG2DNvVEC776+yVut8rVhaYpZzGb0rJWC8FLaS5HsmdY2fNvpd8Lx
         l7F+zD6KCcoFy/ZrZRZfjitlWkxofKixME17XWtLmxkFgWqYKkFAt89gvvK+Ii/DnwpZ
         HTb9ZuS4R/6aFANUbbLLYlUdHBa+ZJKQEoB+dPNplHytr437UD8s8cPuvm6ogQYZ+OxY
         Wp89fq3Wk/xGsC1Jl5Aa62NCWvlqb1sbajE1X+cT7oDK7+5+86VwPvOs3YvS/ZH5+c+s
         JstWjc7UUug1UeSWfnC5E7fWWeNVuOKqG0EScm1pptpJVI8VI0NAouzpHebFeA3tbflE
         1xSQ==
X-Gm-Message-State: ACgBeo0UnC2iRcHcdqEwsu1d9NdK157HNo8Wy1cw69XqsQlWEfHt5Hw5
        q14oc9tZWMrHb1bSuIl7xLzO
X-Google-Smtp-Source: AA6agR6L/CoXwcNdzHE7iPjj1QT2iTSZx0q1SxfAR9jvumocUqTE6ObIcWqqzB4OgB0lO1JWvQ2EPw==
X-Received: by 2002:a17:902:7404:b0:172:951f:bf with SMTP id g4-20020a170902740400b00172951f00bfmr2053556pll.33.1661402349356;
        Wed, 24 Aug 2022 21:39:09 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a64cb00b001fa9f86f20csm2294296pjm.49.2022.08.24.21.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 21:39:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/5] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Thu, 25 Aug 2022 10:08:54 +0530
Message-Id: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series fixes the crash seen on the Qualcomm SM8450 chipset with the
LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
fixed LLCC register offsets for detecting the LLCC errors.

This seems to have worked for SoCs till SM8450. But in SM8450, the LLCC
register offsets were changed. So accessing the fixed offsets causes the
crash on this platform.

So for fixing this issue, and also to make it work on future SoCs, let's
pass the LLCC offsets from the Qcom LLCC driver based on the individual
SoCs and let the EDAC driver make use of them.

This series has been tested on SM8450 based dev board.

Thanks,
Mani

Changes in v3:

* Instead of using SoC specific register offset naming convention, used
  LLCC version based as suggested by Sai
* Fixed the existing reg_offset naming convention to clearly represent
  the LLCC version from which the offsets were changed
* Added Sai's Acked-by to MAINTAINERS patch
* Added a new patch that removes an extra error no assignment

Changes in v2:

* Volunteered myself as a maintainer for the EDAC driver since the current
  maintainers have left Qualcomm and I couldn't get hold of them.

Manivannan Sadhasivam (5):
  soc: qcom: llcc: Rename reg_offset structs to reflect LLCC version
  soc: qcom: llcc: Pass LLCC version based register offsets to EDAC
    driver
  EDAC/qcom: Get rid of hardcoded register offsets
  EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
  MAINTAINERS: Add myself as the maintainer for qcom_edac driver

 MAINTAINERS                        |   3 +-
 drivers/edac/qcom_edac.c           | 119 ++++++++++++++---------------
 drivers/soc/qcom/llcc-qcom.c       |  92 +++++++++++++++++++---
 include/linux/soc/qcom/llcc-qcom.h |  36 +++++++--
 4 files changed, 170 insertions(+), 80 deletions(-)

-- 
2.25.1

