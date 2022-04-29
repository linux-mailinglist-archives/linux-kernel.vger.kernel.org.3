Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5F515726
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbiD2Vrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiD2Vrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:47:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4396FD8936
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:44:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so11603750pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPKs9GVKGDSLOQL2zQiD6oZiNSnA4Ko5SyLdG3pcspE=;
        b=AQeKf5X42YQmvfUJhMz5xEM+z1so3kgd8cgzlQRhphzfmIkWk5CbVzdl6shGEqD4yJ
         aHGeeKKT1kQvEZtcsPARhWXSC67sEXZ0c3pBD4E+1gxvKXgIiZH0RcAb525/oGg96Oue
         h1CDWGzlKDp42/eFcr4lSF0HX3+B1LO7gWa94VIbUcm9IXd88/80DuRsOtmGHLnZxzic
         Ci99uxxgEq7uURLkMtF0JIUHuIUQHfnbadpaPaB7ASfGdT2yguHuAiijrCEm9A5fcV0N
         Tuz9u1Iw3BmADrBBnw2ZNpPJ9uM0dguAn4I9UXj0Z2jE49yfoDnKUZgexnnnwVrKS4OQ
         ggTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPKs9GVKGDSLOQL2zQiD6oZiNSnA4Ko5SyLdG3pcspE=;
        b=f6bPqSrMf27p8tR+MzHh0pjNNslQ7sqtpXbIuoKW6P1PkcXz2EDxqksxPzXarw+JBW
         EprkshvzMfXht2qxx3C27SQBwcMBWfiIt0+ggXfGuYereaZBudeXWkTWm4Hv3zHVAZ+S
         BznkYrN+fJ3ig/sDZxXXUErghkx6TuF52gd09PD4pfuFG61Jnxr8+X1CPvC9t7ygjf/R
         oGNQoANcq5KahcFdWwwiu91xxEzP1zdUd9HaESkpr20DCwZGGZjAdAjM7/eZISMGbEFT
         mL9lPLHA8ZyeDAXAe3kGvV6EpOpVcbzos+bIBFTBN5wC5q1ShnH4o8RYI5lQGfISVBZs
         sgYw==
X-Gm-Message-State: AOAM531euTJ1r5sr9J92VIijxmdM4yh5zCfCOqkku8nHg3F+zzmNNeCn
        ong1O175RO+jOfuyIBsaDGAPkuSfJYaFEg==
X-Google-Smtp-Source: ABdhPJyD5nledjZldpVBkUeIHwtkPn86Y8kWM9/OKUm3v0yMu1s2avwykyzK1dXTyzhQDRDdazX/3w==
X-Received: by 2002:a17:90b:304:b0:1d9:752b:437f with SMTP id ay4-20020a17090b030400b001d9752b437fmr5964663pjb.242.1651268667658;
        Fri, 29 Apr 2022 14:44:27 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id fv12-20020a17090b0e8c00b001cd4989fed0sm15271086pjb.28.2022.04.29.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:44:27 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH 0/3] arm64: dts: qcom: Fix 'sdhci' nodes for 'make dtbs_check'
Date:   Sat, 30 Apr 2022 03:14:17 +0530
Message-Id: <20220429214420.854335-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I sent a separate patchset to convert the Qualcomm 'sdhci-msm'
device-tree binding to yaml format, 'make dtbs_check' now reports several
issues with sdhci nodes used across qcom dts files.

This patchset fixes the same.

Bhupesh Sharma (3):
  arm64: dts: qcom: sdm630: Fix 'interconnect-names' for sdhci nodes
  arm64: dts: qcom: Fix node names for sdhci 'opp-table' nodes (across
    dts files)
  arm64: dts: qcom: Fix ordering of 'clocks' & 'clock-names' for sdhci
    nodes

 arch/arm64/boot/dts/qcom/ipq8074.dtsi |  8 ++++----
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 12 ++++++------
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/qcom/qcs404.dtsi  |  6 +++---
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 16 ++++++++--------
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 12 ++++++------
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 17 ++++++++++-------
 arch/arm64/boot/dts/qcom/sm6350.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi  |  2 +-
 10 files changed, 48 insertions(+), 45 deletions(-)

-- 
2.35.1

