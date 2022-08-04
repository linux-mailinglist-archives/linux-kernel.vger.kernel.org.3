Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6F589E58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiHDPKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiHDPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:10:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB65FAD4;
        Thu,  4 Aug 2022 08:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 072ADB8258C;
        Thu,  4 Aug 2022 15:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A8CC43140;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659625795;
        bh=Vy8BQdsOUtNpJFrloOqqbFFtv2vLCn4aaq5+a1H9MzE=;
        h=From:To:Cc:Subject:Date:From;
        b=tjQG295LZIwMUltwEaIpbkjsKTmq0E/k3l+ivcqehrmS0sLBYv6VEla/GasdxPHRj
         rOs/IIt3MaHwzEWyhpmGEEuu33gtTvLOPbE8mprH0K22RPFL3UEeuEuVh2kmYsPMYQ
         OJbGa5/Y9qhkcZU1kkW9Ged+2vqnjGdTuVqI7mAOR2pqkKkjngMINfWgurt1xYwd8/
         GY1ypD+XkQ11kGry9eHeTDxk8hOuQTyKr2gUfDSnvuDE+n04t8Yn2/GXo33zMOE8ts
         07QhhQ884SFaMmiMujOy9GvQRFG10eKws6vklhQWw4/kwU5dfMMkL1t2Oib9floWen
         QH3CWjDNL78qg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJcUK-00069N-34; Thu, 04 Aug 2022 17:10:16 +0200
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
Subject: [PATCH v2 0/9] usb: dwc3: qcom: fix wakeup implementation
Date:   Thu,  4 Aug 2022 17:09:52 +0200
Message-Id: <20220804151001.23612-1-johan+linaro@kernel.org>
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

The third patch fixes a build breakage caused by the same series. (new
in v2)

The fourth patch fixes another long-standing bug which could lead to a
use-after-free when using runtime PM. (new in v2)

The next patch fixes another issue in the Qualcomm dwc3 implementation
that has been added a while back and which breaks runtime PM.

The sixt patch fixes a NULL-pointer dereference or use-after-free when
suspending controllers in peripheral or OTG mode due to a hack that was
added to suspend path. Unfortunately, it seems the hack needs to stay
for now if we want functioning suspend on some Qualcomm platforms.

The remaining patches moves the wakeup-source property over from the
core node to the glue node in the binding and instead propagates the
wakeup capability to the former during probe.

Note that this incidentally also avoids adding probe-deferral hacks to
the driver as was recently proposed to deal with another problem with
the current implementation:

	https://lore.kernel.org/all/1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com/

With this series I have functioning USB system suspend and wakeup as
well as somewhat functioning runtime PM in host mode on sc8280xp. Note
that the PHYs apparently do not not to be left enabled for wakeup on
this platform.

Some issues remain such as that root-hub connect/disconnect events
cannot selectively be disabled.

And of course, the suspend speed hack needs to be replaced at some
point but that likely requires some more heavy lifting in the dwc3
implementation.

Johan

Changes in v2
 - add review and ack tags
 - fix a gadget-only build breakage (new patch)
 - fix a use-after-free on wakeup from runtime suspend (new patch)
 - disable wakeup completely instead of falling back to the
   "disconnected" host configuration when not acting as host
 - disallow 'wakeup-source' in child node in the binding


Johan Hovold (9):
  usb: dwc3: fix PHY disable sequence
  Revert "usb: dwc3: qcom: Keep power domain on to retain controller
    status"
  usb: dwc3: qcom: fix gadget-only builds
  usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup
  usb: dwc3: qcom: fix runtime PM wakeup
  usb: dwc3: qcom: fix peripheral and OTG suspend
  dt-bindings: usb: qcom,dwc3: add wakeup-source property
  usb: dwc3: qcom: fix wakeup implementation
  usb: dwc3: qcom: clean up suspend callbacks

 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  5 +
 drivers/usb/dwc3/core.c                       | 24 ++---
 drivers/usb/dwc3/dwc3-qcom.c                  | 96 +++++++++++--------
 drivers/usb/dwc3/host.c                       |  1 +
 4 files changed, 76 insertions(+), 50 deletions(-)

-- 
2.35.1

