Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AF5157F6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381294AbiD2WMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359048AbiD2WMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:12:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B0DBD3A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:08:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so9728309pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D54R3v8qrC79ryl/mhxkEgeY06O/JiHOgAyPmualCaw=;
        b=eEFNo4YjRj1yxsE6ddjKrurDLQUQWzfvaBRiV+FKS0XAHv1dHnzd6VgWUO3DxFENIn
         ecot4bJzHoc87F5MyD2wn1W7rBOmLRYJ4rs8dKMLzHoW+ofuNmuSjmeE5Ea6oXudQeWJ
         h3d33+9Rj8SH0Y/3a7HK2ZkPHJfwyDsUsHdju+SLgwxvO2tqZp0fA5MOT13IhEZrRhkF
         KR8uUFULbq5HirjjKiAiZD86ns3nJwjJFYmi9L9J6KOkSZxyRNHzLs8bUhzqQENpgSHY
         bJxI3ilUxtiRMRbmlwQ+k2dUGISAlvD1o/gkWitVHlBf42fzMx8yExdr/4dTYUlLSlu2
         Sveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D54R3v8qrC79ryl/mhxkEgeY06O/JiHOgAyPmualCaw=;
        b=nwuQVmCBXhofOyCBOSmzsL3KmHR8bWGsYMFafihBrlFSNpMzBxNtTEUSGIAyXQkJDF
         q1IGXgniNgQ9Tv6gsuHyB30t37rMrLJJCzEFS9xCr0dQ9gCKSb4Atu9ySA5dAmXap6Wj
         haEhJq80eiESJ1dw8ux9+BChxkKRhuxS046x4MwJkkjTwDw6CqI9y3lnX2iWlQAWOJOB
         KsqyykD5/VaoNjF6pyQLtzCqyQ366guY5W6n6FIcrMFnWxJ6ilYYKOW7hrAXMihwK0bE
         IM17sLyCmvcl09wFw3FkTOqSTnajLv4mlrgohWWRFMDXWPGP9hRV48IXyPn5KmdxWfYU
         Xm3A==
X-Gm-Message-State: AOAM532tGx/qX6gaNQpc7DQXK0qUYuBmFEmqv/JaiHQydUgQfmKgJEmU
        ngFuWIp2QgMwc2acfKiu9I/zMA==
X-Google-Smtp-Source: ABdhPJyBs4Fl1lrLv4rmB0L8SjqTRG5Dp5kXtgSplWDdGL3d2LOejNweZTiyOnlEK34kOyXaLAKF8g==
X-Received: by 2002:a17:90a:e7c7:b0:1d9:6a37:9f5e with SMTP id kb7-20020a17090ae7c700b001d96a379f5emr1227113pjb.156.1651270127280;
        Fri, 29 Apr 2022 15:08:47 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:08:47 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 0/4] mmc: sdhci-msm: Convert dt-binding to yaml & add support for sm8150
Date:   Sat, 30 Apr 2022 03:38:29 +0530
Message-Id: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
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

This patchset converts the Qualcomm 'sdhci-msm' device-tree binding
to yaml format and also adds support for sm8150 Qualcomm Soc.

This patchset is dependent on the qcom dts fixes sent via a separate
patchset (see [1]), to make sure that the 'make dtbs_check' and
'make dt_binding_check' work well and Rob's bot is happy as well.

[1]. https://lore.kernel.org/linux-arm-msm/20220429214420.854335-1-bhupesh.sharma@linaro.org/

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Bhupesh Sharma (4):
  dt-bindings: mmc/sdhci-msm: Convert bindings to yaml
  mmc: host/sdhci-msm: Add SoC specific compatibles
  dt-bindings: mmc: sdhci-msm: Add compatible string for sm8150
  mmc: host/sdhci-msm: Add compatible string check for sm8150

 .../devicetree/bindings/mmc/sdhci-msm.txt     | 123 -----------
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 193 ++++++++++++++++++
 drivers/mmc/host/sdhci-msm.c                  |  24 +++
 3 files changed, 217 insertions(+), 123 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml

-- 
2.35.1

