Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC215669E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiGELlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiGELk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB115FEC;
        Tue,  5 Jul 2022 04:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA41F6160B;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C49C341C7;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=VZF93OYGtOaGPIHiLLXsnydvfAw5xjGC/4aqKGXNIKQ=;
        h=From:To:Cc:Subject:Date:From;
        b=C5CEyyOUsvyEnhPpjrFgIwQrdObCvHns2QnPRfSWz5DnX4qOvbPdQIgfWYqTgInZ9
         EEuOqWwU9448T0WjTLC+N4JJ14Awo6wl8aVJGVniELzmh3XdBT3fEgMvKn6lMJE+w/
         LK8S6cKZDAPAT+oheLbcQJLswFgWbQ2lW/8QDrXEGAUGCqXe9iqAoINiD9OxpY2eXL
         skrtswwU9XbJvrthvS1JOuVV9GH25d4AZhNkO2kd1JUKTT7N+a7F6438xrqON1X+8n
         AcU+GaH6lYBYVEzDRvmuzGKbXL+J9WqBvny+v6tRvCPg8sDU/6u73KSaYsFukH6GVH
         KPKCEB5pEyccw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvI-0005xQ-B8; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 00/14] arm64: dts: qcom: QMP PHY fixes
Date:   Tue,  5 Jul 2022 13:40:18 +0200
Message-Id: <20220705114032.22787-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a bunch of fixes for PHY related DT issues found while amending
the current QMP PHY schema:

	https://lore.kernel.org/r/20220705094239.17174-1-johan+linaro@kernel.org

Included are also some cleanups of the MS8996 PCIe PHY node which make
the node match the new binding example.

Note that none of these depend on any additions to the binding (e.g. the
deprecation of the lane suffix) even if some of issues would not be
found when validating against the current schema.

Johan


Johan Hovold (14):
  arm64: dts: qcom: sc7280: drop PCIe PHY clock index
  arm64: dts: qcom: sm8250: add missing PCIe PHY clock-cells
  arm64: dts: qcom: ipq6018: drop USB PHY clock index
  arm64: dts: qcom: ipq8074: drop USB PHY clock index
  arm64: dts: qcom: msm8996: drop USB PHY clock index
  arm64: dts: qcom: msm8998: drop USB PHY clock index
  arm64: dts: qcom: sm8350: drop USB PHY clock index
  arm64: dts: qcom: sm8450: drop USB PHY clock index
  arm64: dts: qcom: sc8280xp: drop UFS PHY clock-cells
  arm64: dts: qcom: sm8250: drop UFS PHY clock-cells
  arm64: dts: qcom: sm8450: drop UFS PHY clock-cells
  arm64: dts: qcom: msm8996: add missing PCIe PHY clock-cells
  arm64: dts: qcom: msm8996: use non-empty ranges for PCIe PHYs
  arm64: dts: qcom: msm8996: clean up PCIe PHY node

 arch/arm64/boot/dts/qcom/ipq6018.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi  |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi  | 53 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/msm8998.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi   |  4 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  2 -
 arch/arm64/boot/dts/qcom/sm8250.dtsi   |  6 +++
 arch/arm64/boot/dts/qcom/sm8350.dtsi   |  5 +--
 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  3 +-
 9 files changed, 46 insertions(+), 35 deletions(-)

-- 
2.35.1

