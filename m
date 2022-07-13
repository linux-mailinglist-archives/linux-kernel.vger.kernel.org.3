Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AB657372D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiGMNS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiGMNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:18:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253EE9590;
        Wed, 13 Jul 2022 06:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFB6BB81F46;
        Wed, 13 Jul 2022 13:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D96EC341C0;
        Wed, 13 Jul 2022 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657718277;
        bh=ypT31tttdamVrW0wkBqfoCyXu3GpzfgCFgVZIeiit8M=;
        h=From:To:Cc:Subject:Date:From;
        b=sxjuT2RL8eWwPUUFkwcXBR6iPW+CXYxuTb8phCmAG/XWIEVVoU3NTdK/DmjxEcxjS
         FZz88TSiXMfu6V9TYo8a0cZyoprp/+wkNyr1obzJdUrH7mEhDEttQN1VprcV9S3lFF
         rIx63oSHN31Ra4GcRy45kgHRQOgglobVo3Cbp0IGXrV10/5loBeGnPc09ozLJDW+gl
         3VGDKV6ErJ7C12Ig5ilEeTQ+ruuAtpg/gxPrDlRUltavIMDnzbt3tmKjkNWuyqbStx
         nrmodDv0GLfvS8vCCS2/ywHkQSKblyRti+pkWE5gV02JiNBZaoA3FWxJnhYwmEM9+X
         hfVZun/u63Z4g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBcFc-0007gE-V5; Wed, 13 Jul 2022 15:18:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/7] usb: dwc3: add support for SC8280XP
Date:   Wed, 13 Jul 2022 15:13:33 +0200
Message-Id: <20220713131340.29401-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the missing devicetree binding for SC8280XP, clean up
the current bindings somewhat and fixes a related driver warning when an
optional wakeup interrupt is missing.

The last four patches fix up the SC8280XP devicetree that's currently in
Bjorn's tree and addresses some DT schema warnings in other Qualcomm
devicetrees and are only included here for completeness.

The binding and driver updates are expected to go though the USB tree,
while the devicetree updates can be picked up by Bjorn once the binding
updates have been merged.

Johan


Johan Hovold (7):
  dt-bindings: usb: qcom,dwc3: add SC8280XP binding
  dt-bindings: usb: qcom,dwc3: refine interrupt requirements
  usb: dwc3: qcom: fix missing optional irq warnings
  arm64: dts: qcom: sc8280xp: fix USB clock order
  arm64: dts: qcom: sc8280xp: fix USB interrupts
  arm64: dts: qcom: sc7280: reorder USB interrupts
  arm64: dts: qcom: reorder USB interrupts

 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 152 ++++++++++++++++--
 arch/arm/boot/dts/qcom-sdx65.dtsi             |  10 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  15 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  28 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  20 ++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  20 ++-
 drivers/usb/dwc3/dwc3-qcom.c                  |   4 +-
 7 files changed, 194 insertions(+), 55 deletions(-)

-- 
2.35.1

