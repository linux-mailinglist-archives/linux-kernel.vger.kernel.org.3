Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED866588C03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbiHCM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiHCM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:26:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC3AFD1A;
        Wed,  3 Aug 2022 05:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02371B8225F;
        Wed,  3 Aug 2022 12:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1894C433D6;
        Wed,  3 Aug 2022 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659529554;
        bh=IhsExMpYViOyK375aCLuejCYvDJYTp4oBJ9OAbzRAsI=;
        h=From:To:Cc:Subject:Date:From;
        b=kliyjSF4YACoxh020GGf/Wb/lu9jH14CG0P8iH3iWyJYxXbjjcoXy3z+PqSD+9VmU
         +xNjoJDKaq05wG1b+xv/IAYTDvKZAtMUgDlnh/e4r+ZA92ooNltbniQOe+N5sm4Fjx
         ifiucqpUjzmF7UXTVATqb8nni2+Sw1CEIT0/spg5SC7iWoR1nlBvEDlYLqHxrVhR9E
         rgZCWF3LcRha+DCIR4B9YmE6Cb0yU2xQKzxBS5UTBT9aMoG6Fd9c2HhseG07+9ZojU
         vJP3wR2OQjkabGTvIRLdIzNBBX3nLwn+pZDo2OSFbuxXD+cOoz3IM93U3aaaAO61p/
         PjgJJlhMmH3Bw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJDS1-00021a-GI; Wed, 03 Aug 2022 14:26:13 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sc8280xp: disallow regulator mode switches
Date:   Wed,  3 Aug 2022 14:19:39 +0200
Message-Id: <20220803121942.30236-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change in a USB/DP PHY driver that started specifying regulator
loads caused the regulators that were also shared with the PCIe and USB
PHYs to be put in low-power mode, something which broke PCIe and USB on
sa8295p-adp.

As was discussed in the following thread:

	https://lore.kernel.org/all/YtkrDcjTGhpaU1e0@hovoldconsulting.com

regulators should generally not be allowed to switch to low-power mode
unless some of the consumers can actually support an idle mode.

This series disables mode-switching for all regulators on sc8280xp-crd,
sc8280xp-lenovo-thinkpad-x13s and sa8295p-adp except for the ones used
by the UFS controllers which do support an idle mode.

Johan


Johan Hovold (3):
  arm64: dts: qcom: sc8280xp-crd: disallow regulator mode switches
  arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: disallow regulator
    mode switches
  arm64: dts: qcom: sa8295p-adp: disallow regulator mode switches

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts              | 11 -----------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts             |  9 ---------
 .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 10 ----------
 3 files changed, 30 deletions(-)

-- 
2.35.1

