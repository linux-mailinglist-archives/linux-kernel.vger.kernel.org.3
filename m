Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2FC52744E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiENVyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiENVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796B2CE32
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:34 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so10697224pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GswRETFJidMZVxHaNKTcPQzDNgyZO4ho0I1hUMCR+HY=;
        b=amQmKg+s2Y4OKXzam2xANiIVRiRd75yDGH7WCFAtow8+LtWrfrkmSnV38kv9Tj11zY
         F0N7dniayEY3OZXPk1a+aHo2pV1jAJvgIKSwtl1yZRuCAMyEuEgjk6kN/DQeHnEOycCp
         xSAf1gAEZSKy6pj+0AlQYwXHVFH94A/uP7oyCRmxGcdKoXclIsW1Ry6MBBMV4IQqWkPO
         cXd97PcPY1OVS1nD9nqDRuAZ/eDD1thEMji+r1dX6nPOtF4soJQbLOkKPsH2xVxSCwwx
         lR7c3L3XIu4JScgBX9q26LREn/oLaCfumjjkEXqzFVn8P4VsAoxKVTYpohg8+BJ4zv8h
         Z0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GswRETFJidMZVxHaNKTcPQzDNgyZO4ho0I1hUMCR+HY=;
        b=nkdBDJL6rv/vslCDxY+1HI7uMpHc3Ri4oemqOnINp7FbSVLMV1mhX/fgtXGSLnbEY3
         p4WVXkM2n0ik8D84a+oq1FhBozUbb8uiBsBhPq+QARvyct6NfScUbw11TS6ksQlZyosM
         oe2GhwbOzaYjFSxxg0Na9uMenlhi2Jo6EO+9shvdR/ej50bSR7V0PAJXT8kS9jn79On4
         V9I9Cm2Tlhj57ZRBiGhYzKH2MdEP/2j7R2I+Qs+56oEkmqz/QuHEw95vytnhhOS45yY4
         s6TtSUT6dPLYzsQvbhqtAYYkLkIVet+2VhrMph89i6POx+tVYsLVt37f0l8VHFDyPv4L
         tk8A==
X-Gm-Message-State: AOAM530HBwO21kKwF3hWJHBRrEKUfSOvz+kVoJxsgQRY76kuTPxmHWB+
        +WQC7VoZJkXVPPLzc4WJ66oEfA==
X-Google-Smtp-Source: ABdhPJzuL2B+qXfF4Ci1HF4gJXWuuseaViLiqMJ9Wis9wyfnUzOy3NQsdyYPLbCqGA1nL9wrLe5TlA==
X-Received: by 2002:a63:7247:0:b0:3c1:a8ab:fc6 with SMTP id c7-20020a637247000000b003c1a8ab0fc6mr9599969pgn.602.1652565273784;
        Sat, 14 May 2022 14:54:33 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0015e8d4eb2d2sm4189522plx.284.2022.05.14.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:33 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org
Subject: [PATCH v2 0/6] arm64: dts: qcom: Fix 'sdhci' nodes for 'make dtbs_check'
Date:   Sun, 15 May 2022 03:24:18 +0530
Message-Id: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
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

Changes since v1:
----------------
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20220429214420.854335-1-bhupesh.sharma@linaro.org/
- Fixed Bjorn's comments received on v1.
- Added 3 more dts fix-up patches [PATCH 1/6], [PATCH 5/6]
  and [PATCH 6/6] in v2.

Since the change to convert the Qualcomm 'sdhci-msm' device-tree binding
to yaml format has been accepted in linux-next and a fix for the same
was sent as per Rob's review comments, 'make dtbs_check' now
reports several issues with sdhci nodes used across qcom dts files.

This patchset fixes the same.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>

Bhupesh Sharma (6):
  arm64: dts: qcom: Fix sdhci node names - use 'mmc@'
  arm64: dts: qcom: sdm630: Fix 'interconnect-names' for sdhci nodes
  arm64: dts: qcom: Fix node names for sdhci 'opp-table' nodes (across
    dts files)
  arm64: dts: qcom: Fix ordering of 'clocks' & 'clock-names' for sdhci
    nodes
  arm64: dts: qcom: Fix 'reg-names' for sdhci nodes
  arm64: dts: qcom: ipq8074: Fix 'max-frequency' value for sdhci node

 arch/arm/boot/dts/qcom-apq8084.dtsi   |  4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi   |  2 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi   |  6 +++---
 arch/arm/boot/dts/qcom-msm8974.dtsi   |  6 +++---
 arch/arm/boot/dts/qcom-sdx55.dtsi     |  2 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi     |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 12 ++++++------
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/qcom/msm8953.dtsi |  4 ++--
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 18 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8996.dtsi |  4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 18 +++++++++---------
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 25 ++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sdm845.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi  |  8 ++++----
 arch/arm64/boot/dts/qcom/sm6350.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/qcom/sm8150.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi  |  4 ++--
 21 files changed, 92 insertions(+), 89 deletions(-)

-- 
2.35.3

