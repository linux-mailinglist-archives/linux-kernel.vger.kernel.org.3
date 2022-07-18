Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B161578CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiGRVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGRVhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:37:11 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 14:37:07 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24140326E2;
        Mon, 18 Jul 2022 14:37:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [81.178.197.238])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 85B24140197;
        Mon, 18 Jul 2022 21:31:06 +0000 (UTC)
From:   Caleb Connolly <caleb@connolly.tech>
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
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 0/4] Initial support for the Pixel 3
Date:   Mon, 18 Jul 2022 22:30:47 +0100
Message-Id: <20220718213051.1475108-1-caleb@connolly.tech>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
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
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,43408.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43408.c

-- 
2.36.1

