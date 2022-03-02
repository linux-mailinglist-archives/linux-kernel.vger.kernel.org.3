Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7DA4CA2B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbiCBLGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiCBLGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:06:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31164A3F4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:05:30 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u16so1602849pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iM4tqoBNZnRDhHlhJv4qaUp41vM2/itvqk+JO0plpzU=;
        b=eUCFUBtB8g0HcK0Dm6lzd43xTsjUZvZy+n8LQ7kZQiOs8hWrHoopwzWWggNY93Kth/
         d+yg12rDsIzVf25SP9oTp5FxUy9c7NkqTmGgGLdn7tyqW/nDr780P+yvFBiU5EQousk4
         8sF3aEpksyhIccyC3cM2mH4iDzP3NwL0I57CYqkOZCBILQKhuvZJVPOLGySLYvx/yXwh
         I6elZu4Ycv6/m7nev9kSR83Qi7GDI/FnMQVrrxDTYB5k+y8RspG3E10tHtL55dXk1NuM
         A8+SxU51PuLkX6Sw3L2WJ6uX0gpfMDEV2TZLS49hJbLwt/YRIWVY6txZDZQwPMwPUTSu
         0amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iM4tqoBNZnRDhHlhJv4qaUp41vM2/itvqk+JO0plpzU=;
        b=uBQDCZRihXDyhoiPIbaPof/8sMudqphOHypiA+ZCsY1dfMHpsTvIonjt6R239J0mwI
         DGQQX+HhK8NBgvhwNAQypW4Mq/47b6FZXCWwN5VtsMUbh27usMHzENZioWy/ujGNQHFX
         BJzvAXvTbWRgFhwbHm1e7Il+EH20bVoSpXfGC79t8C8h2qBKpdWflop6i1oI00Uz1O6X
         ZLTra8hPVqQQ8yapKq0hQBi6xjofB/W/FHeMgMGzE3IIWhQnN3QPVfsrZroTEdxheWey
         ztdoydPpUXoRp+hhE3E+f8YosnaUC2/+xr6kbYq4vYGDcwzjC7FhqdLh2lAWSCg8scMc
         0IGg==
X-Gm-Message-State: AOAM531QIX0XOk0bbNmEaU3hDVCorFNxmfUb5cPkW99XbMHgp+9xjhWD
        mcJw5bR8GKqPHkdexe195xXSTg==
X-Google-Smtp-Source: ABdhPJxeyMaemFdosUe7a1Nz/OmLGcqy/zp1HyS7opVeuNuR2PmDhFIdpuZN0hRH0U2QcVKyK817Qg==
X-Received: by 2002:a63:2a45:0:b0:373:1850:d5b with SMTP id q66-20020a632a45000000b0037318500d5bmr24767273pgq.563.1646219130121;
        Wed, 02 Mar 2022 03:05:30 -0800 (PST)
Received: from localhost.localdomain ([171.50.175.145])
        by smtp.gmail.com with ESMTPSA id hk1-20020a17090b224100b001b8cff17f89sm5049186pjb.12.2022.03.02.03.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 03:05:29 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 0/5] Add ethernet support for Qualcomm SA8155p-ADP board
Date:   Wed,  2 Mar 2022 16:35:03 +0530
Message-Id: <20220302110508.69053-1-bhupesh.sharma@linaro.org>
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

Changes since v1:
-----------------
- v1 can be seen here: https://lore.kernel.org/netdev/20220126221725.710167-1-bhupesh.sharma@linaro.org/t/
- Fixed review comments from Bjorn - broke the v1 series into two
  separate series - one each for 'net' tree and 'arm clock/dts' tree
  - so as to ease review of the same from the respective maintainers.
- This series is intended for the 'arm msm clock/dts' tree.
- Other changes:
  - Dropped [PATCH 7/8] from v1.
  - Added more background on the emac gdsc issue, requiring it to be in
    ALWAYS_ON state in [PATCH 5/5].
  - Collected Ack from Rob for [PATCH 1/5].
  - Broke down v1's [PATCH 3/8] into 3 separate patches (one each for emac,
    pci and ufs gdsc defines) - one of which is carried as [PATCH 2/5]
    in this series, which is used to enable emac GDSC.

The SA8155p-ADP board supports on-board ethernet (Gibabit Interface),
with support for both RGMII and RMII buses.

This patchset adds the support for the same.

Note that this patchset is based on an earlier sent patchset
for adding PDC controller support on SM8150 (see [1]).

[1]. https://lore.kernel.org/linux-arm-msm/20220226184028.111566-1-bhupesh.sharma@linaro.org/T/

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Bhupesh Sharma (2):
  clk: qcom: gcc: Add emac GDSC support for SM8150
  clk: qcom: gcc-sm8150: Use ALWAYS_ON flag as a workaround for emac
    gdsc

Vinod Koul (3):
  dt-bindings: net: qcom,ethqos: Document SM8150 SoC compatible
  arm64: dts: qcom: sm8150: add ethernet node
  arm64: dts: qcom: sa8155p-adp: Enable ethernet node

 .../devicetree/bindings/net/qcom,ethqos.txt   |   4 +-
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      | 144 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  27 ++++
 drivers/clk/qcom/gcc-sm8150.c                 |  40 +++--
 include/dt-bindings/clock/qcom,gcc-sm8150.h   |   1 +
 5 files changed, 203 insertions(+), 13 deletions(-)

-- 
2.35.1

