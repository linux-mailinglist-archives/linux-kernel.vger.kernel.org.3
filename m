Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6A578CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiGRVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiGRVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:21:02 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985A728721;
        Mon, 18 Jul 2022 14:21:00 -0700 (PDT)
Date:   Mon, 18 Jul 2022 21:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1658179258; x=1658438458;
        bh=3U/67mf57ng96VibBXJjsH4xTmCc+lifj3sh+mu8+qQ=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=f509/OtZQV8qgu8L2bThJO7xkYspuMsAslYjkiNLrNEJc9ToBJKpRa0mMYqkSCJGG
         HnEASTkG2oaciDHOA0pSKzn0mtI993FNjrHj6aOSAV3DRHtrHS9jXYiltzHd9rsHJz
         COYMZoK0iWfRGgLGalOnC1MRaAVl4ZBxKXCyHvqo=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Amit Pundir <amit.pundir@linaro.org>
From:   Caleb Connolly <caleb@connolly.tech>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 0/4] Initial support for the Pixel 3
Message-ID: <20220718212019.1471265-1-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an initial DTS and display panel driver
for the Pixel 3. The Pixel 3 display uses DSC (Display
Stream Compression) which has been supported in mainline
for some time now.

Functionality includes:
 - Display, GPU, venus video transcoder
 - Modem/WiFi/Bluetooth - ModemManager seems to fail

The touchscreen uses some HEFTY downstream driver, hopefully
we'll come up with an upstreamable solution for it soon and
make this a bit more usable.

Amit Pundir (1):
  arm64: dts: qcom: add sdm845-google-blueline (Pixel 3)

Caleb Connolly (1):
  Documentation: dt-bindings: arm: qcom: add google,blueline

Sumit Semwal (2):
  dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
  drm: panel: Add lg sw43408 panel driver

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/display/panel/lg,43408.yaml      |  41 ++
 .../display/panel/panel-simple-dsi.yaml       |   2 +
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sdm845-google-blueline.dts  | 652 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43408.c      | 586 ++++++++++++++++
 9 files changed, 1303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,4340=
8.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43408.c

--
2.36.1


