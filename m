Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D986587ED8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiHBPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiHBPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:14:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BDA18377;
        Tue,  2 Aug 2022 08:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C832B81F28;
        Tue,  2 Aug 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F67EC433B5;
        Tue,  2 Aug 2022 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659453256;
        bh=cSnYDdbYYVYdVsk3aJiMwJvB5rQjfNvI8+yuGIb4rRU=;
        h=From:To:Cc:Subject:Date:From;
        b=AJ3gtmLWjQqdU4RHtf7Bc6sdpfr/+l7ocKCelqbGWo2WtnSZRpLI5cDBdLILMLomE
         TSMME2eaKZgiR3pFtlVOwKBegj/Qh8efQyf7qOkd/xRwpXIkvaYbN8TOcKys9YMIpq
         GpbLo/QBhQheVXZhTPD0HdRix+hVtTI9FjUb7ei5E9bZyX5s0gHHL+H+e0W3Etra64
         j8i7iT/bJ2kFDFMo8csmAMaw+1cH4OCMnq6jvBeMGQmEWsJfsoYKdLz7oglxZ7ZwxZ
         FbINpR/1bj09R57cOPBGDpBHNGz83aE3QPGtwxdAtLiXZM9USQrupFH1Cx+9WChlIT
         +UURyypvlqY1A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oItbL-0000TS-Vg; Tue, 02 Aug 2022 17:14:32 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/8] usb: dwc3: qcom: fix wakeup implementation
Date:   Tue,  2 Aug 2022 17:13:56 +0200
Message-Id: <20220802151404.1797-1-johan+linaro@kernel.org>
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

This series fixes some of the fallout after the recently merged series
that added wakeup support to the Qualcomm dwc3 driver:

	https://lore.kernel.org/all/1655094654-24052-1-git-send-email-quic_kriskura@quicinc.com/

The first patch fixes a long standing PHY power sequencing issue in dwc3
core.

The second patch reverts a power-domain hack that was added by the above
series. There are other ways to implement this which doesn't violate the
genpd interface, and if for some reason those are not sufficient, the
genpd implementation needs to be extended, not hacked around.

The third patch fixes a couple of NULL-pointer dereferences when
suspending controllers in peripheral or OTG mode due to a hack that was
added to suspend path. Unfortunately, it seems the hack needs to stay
for now if we want functioning suspend on some Qualcomm platforms.

The fourth patch fixes another issue in the Qualcomm dwc3 implementation
that has been added a while back and which breaks runtime PM.

The remaining patches moves the wakeup-source property over from the
core node to the glue node in the binding and instead propagates the
wakeup capability to the former during probe.

Note that this incidentally also avoids adding probe-deferral hacks to
the driver as was recently proposed to deal with another problem with
the current implementation:

	https://lore.kernel.org/all/1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com/

With this series I have functioning USB system suspend and wakeup as
well as somewhat functioning runtime PM in host mode on sc8280xp. Note
that the PHYs apparently do not need to be shutdown for wakeup on this
platform.

Some issues remain such as that the controller needs to be suspended to
handle remote wakeup during runtime PM (the wakeup interrupts probably
needs to be enabled whenever there's a wakeup-capable device connected
to the bus) and that root hub connect/disconnect events cannot
selectively be disabled.

And of course, the suspend speed hack needs to be replaced at some
point but that likely requires some more heavy lifting in the dwc3
implementation.

Johan


Johan Hovold (8):
  usb: dwc3: fix PHY disable sequence
  Revert "usb: dwc3: qcom: Keep power domain on to retain controller
    status"
  usb: dwc3: qcom: fix broken non-host-mode suspend
  usb: dwc3: qcom: fix runtime PM wakeup
  Revert "dt-bindings: usb: dwc3: Add wakeup-source property support"
  dt-bindings: usb: qcom,dwc3: add wakeup-source property
  usb: dwc3: qcom: fix wakeup implementation
  usb: dwc3: qcom: clean up suspend callbacks

 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  2 +
 .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 --
 drivers/usb/dwc3/core.c                       | 24 +++---
 drivers/usb/dwc3/dwc3-qcom.c                  | 77 ++++++++++---------
 4 files changed, 55 insertions(+), 53 deletions(-)

-- 
2.35.1

