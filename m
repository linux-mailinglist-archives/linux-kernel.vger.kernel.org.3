Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8B4C578E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiBZSl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiBZSlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:41:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662A31E64F6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:40:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so9498618pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIF6UAlZFRz6CcmK0c/prHkHHtjI2Q86YKElLvocVO8=;
        b=xTGtjyG6s/i0yLUNvqRqayykUOAItFhlCadv69XPBgfya01BjC0zDvu2wgXJQt8hFD
         VfnyRKHwy4zcok8W2UyA5CyxTwA3IkLb9EQ7vmaUOX4S3xoU4Rkf0DSmYf8odhQCNlue
         h78Vm80xewBipO05IGlgfce7+3GArqYCcszk65hH12WHjSw5Ahi2QnuzDhK/YgcANxTw
         lY4a+Vkd5umrM3VUwDKZ3UXSAXpt5Bu1rlWofmrkB702y22fsitSJ1NKqa8rhHC0z7oF
         iFdsmywsU7d3Umg4MhYSHSH4S1c0kY2eHx/iiSmc+2NlOl4GhhgeaadHDPb05m9osC4E
         /BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIF6UAlZFRz6CcmK0c/prHkHHtjI2Q86YKElLvocVO8=;
        b=VtFfXb7Bd5BGt9KR2xapq2wbU/EgazlSIJ3saIuYTQQ7Q3Bx5HEVT8eYNQVFh7/H8z
         7KpMNZF81B3bipUHFIJgQ/9QqQLzPGJlaKLEDoDwarZLpm0b0nPJHOvukCyK+FpZeti3
         dqU5KqwVBgP/5kQ0KA+qiQf6pG+6ovRWMRjKU8QCV+hzmeeV2g4HlHBbVN5OGD1KkIAU
         ZE6ei46qrV/tEACnv+IlE7xmz7MCQ1MLlUF3+LxTJ9OYVJuMYvxYEwv0Mi8+nMsEYTzn
         y0bppmV53KryHRj5yd+QQIuaeayDf9ZXe0V6wNpWUebpnI1EdYQ+6XDQzEAu1KyV6567
         Llpg==
X-Gm-Message-State: AOAM531KrK8WBhDrQSz2Mze5fhWOC/WDqBVa5KK+eznv39hhlamHMNl5
        MDCC6+bdkCWqrfZIu67D/I7Izg==
X-Google-Smtp-Source: ABdhPJySc/nbUPv/BRzgMlSJltXAYJTXNFuOBjxcT6Gi7JtRc3q1gogEehEoyoKGDBwADnuY+e1ajw==
X-Received: by 2002:a17:902:758f:b0:14f:b5ee:cc5a with SMTP id j15-20020a170902758f00b0014fb5eecc5amr13319231pll.43.1645900848818;
        Sat, 26 Feb 2022 10:40:48 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id b187-20020a621bc4000000b004f3c8f3b560sm7049319pfb.129.2022.02.26.10.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:40:48 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/4] Add support for PDC interrupt controller for sm8150
Date:   Sun, 27 Feb 2022 00:10:24 +0530
Message-Id: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
-----------------
- v1 can be found here: https://lore.kernel.org/linux-arm-msm/20220119203133.467264-1-bhupesh.sharma@linaro.org/
- Collect ACK from Rob on PATCH 1/4.
- Address review comments from Maulik.

This patchset adds the support for PDC interrupt controller found
on sm8150 SoCs from Qualcomm.

Here we add the device-tree bindings, pinctrl driver support
and the dts support for the same.

Cc: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

Bhupesh Sharma (4):
  dt-bindings: qcom,pdc: Add compatible for SM8150
  pinctrl: qcom: sm8150: Specify PDC map
  arm64: dts: qcom: sm8150: Add pdc interrupt controller node
  arm64: dts: qcom: sm8150: Add PDC as the interrupt parent for tlmm

 .../interrupt-controller/qcom,pdc.txt         |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 11 ++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8150.c         | 22 +++++++++++++++++++
 3 files changed, 34 insertions(+)

-- 
2.35.1

