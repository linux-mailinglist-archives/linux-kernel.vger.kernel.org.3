Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B90505F05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 22:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347837AbiDRU6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 16:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243733AbiDRU6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 16:58:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC515706
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 13:55:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q19so21015676pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwdHbI+gWr2kmO8oEf6EWMg+aRRNzFtsHXg6Ha4SC3c=;
        b=A9jx7UXl6zDK1LCgkYAt80Edgyydum7V4aNbBembSJJYjRHv1DtODpn/2CV+aG9dDG
         d8f5Tj95SAIyNWRjcOvW8R5e4FBRh5GzwzH1ljxGgMoKuWRTYEMHoFmTNw77kH87LmhU
         roSIyZd6rJ13uMswmXWUru4WEW8A+Hx2RjW0bBjTWDDQ604XHpIJRu/tEC/4stLEeETj
         BqwClnkRWU4NY7I6N+s2s1ezuKLPiLbFJKH7F8E28KOemWiv8RNAFBQCRU3OdWWeDX7D
         +9bLSESOQmr0xv3OLuSaZNUv+X6Bjc0OEJ8whUjgLxHyGMXL3OvRtBO1FHL/5NKBKJwR
         ur8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwdHbI+gWr2kmO8oEf6EWMg+aRRNzFtsHXg6Ha4SC3c=;
        b=X+d+h+TnhTdIvSPxKFactExE66xpss7AMjrMq7DC2MPFwlAqFg0gYAAaCR+3kXRupl
         UVRXHjkym8OgJ/yUUM1yp0Be5zyd9kXpKXw1asaKJoKfMu7gOz+nJoswUHzhSipuvc0m
         78ygWiLQDApQ4fQpTV0VijD7LcaNr0DNZNqSJt8qtcR+Ac9ovpZKuHZ19j4l823I6UEo
         1WgJf+nnlSlpqTpc1FA3LFoax8DnVQ4qIgydSaCmlCA38GvsgTj488CjwraxH1fU/Bl5
         izOc5ey8kme6eNl5ajiZn005jI7yAZ/s+koP6Y6JvW39wze9TLDfPEwLSyl++a2AvOVW
         yg3g==
X-Gm-Message-State: AOAM533xqkNh1+DSXM5G8Yx7NY18ym92fcfo93kGpe1ocEGsrsdX1d4z
        CqU6YADnPazvbpyo93WQmvgfNh7OKTdWWQ==
X-Google-Smtp-Source: ABdhPJyQZdPawrK73wiDulg+k+oaaLLE5yDW1YuFAoP7VE1sQd6zLtPQoQYkLwO2yowwMnwzAJ9rsw==
X-Received: by 2002:a65:6216:0:b0:39d:5e6c:7578 with SMTP id d22-20020a656216000000b0039d5e6c7578mr11367085pgv.114.1650315319568;
        Mon, 18 Apr 2022 13:55:19 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a17c200b001cd567fecaesm13498859pja.26.2022.04.18.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 13:55:19 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, vkoul@kernel.org,
        bjorn.andersson@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/4] Fix  dtbs_check warning(s) for Qualcomm QMP PHY
Date:   Tue, 19 Apr 2022 02:25:05 +0530
Message-Id: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Changes since v2:
-----------------
- v2 can be found here: https://lore.kernel.org/linux-arm-msm/20220228123019.382037-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Rob and Shawn.
- Collected ACK from Rob on [PATCH 2/4].
- Since, Bjorn accepted 4 patches from v2 already, drop them for this series.
- This series is rebased on linux-next/master.

Changes since v1:
-----------------
- v1 can be found here: https://www.spinics.net/lists/linux-arm-msm/msg104871.html
- Addressed review comments from Dmitry.
- Addressed the remaining dtbs_check warnings rasied by Rob's bot on v1.

Shawn Guo recently fixed a large number of 'dtbs_check' warnings
on Qualcomm DTS files for qmp phys. However a few warnings are still left
(possibly due to new dts files being added over time).

So, I decided to clean them up.
After this series, '$ make dtbs_check' leads to no warning for QCOM
QMP PHY.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>

Bhupesh Sharma (4):
  dt-bindings: phy: qcom,qmp: Mark '#clock-cells' as a 'optional'
    property
  dt-bindings: phy: qcom,qmp: Describe 'vdda-max-microamp' &
    'vdda-pll-max-microamp' properties
  dt-bindings: phy: qcom,qmp: Describe phy@ subnode properly
  arm64: dts: qcom: sm8450: Fix qmp phy node (use phy@ instead of
    lanes@)

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 29 +++++++++++++++----
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  4 +--
 2 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.35.1

