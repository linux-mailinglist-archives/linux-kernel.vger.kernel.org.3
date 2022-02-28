Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E836B4C6EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiB1N5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiB1N5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:47 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6757D016;
        Mon, 28 Feb 2022 05:57:08 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b13so10281920qkj.12;
        Mon, 28 Feb 2022 05:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q8rfAYWCPuCFZWUbMwuXl1w3LX/ZhxGllWhtuSRFCM=;
        b=XmcfNyiUVum9tKD+wGJadl/B39imKzB11lORzzu1JLqYGEzZHtwIIKRS/L/robEZIk
         Hedvm0IK0YoyRKLbu88OSmwQyvvkhqHFQ52EnVbNS4dY0cfI6CYRZ1YABxWCL3nCD/gU
         c5BWQYU1MU3GBWP432jcEGTsaEToAC+QVQ+z/38DO4fdvdZfGBsgZ/XXbk86VXoZD7Ni
         fCwxZPJvetv+wltkdg5bgcjM1w7Tah5ncE36d6cI0YggqJJ6mton4CwaviQFkuHl/dYQ
         oQfGERMn/wWUAHXVn06CiMEQuEpPwGSEb1ymvAUrMKAmrZFwDNdJsH+ddIKPqQ0lcqs8
         J9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q8rfAYWCPuCFZWUbMwuXl1w3LX/ZhxGllWhtuSRFCM=;
        b=3vkerWnsl72mXFwixZsm4JPI9pCYmw0ZqhtAb79s/MxMcniAM6/dLsh8VrNhSqokKr
         7ahxJSXbxmCPaMfQTuttf5AavASD9whWtbLZPGJ+aNYetwS3GgGiz5FwaO3CPVJKLdje
         pwCRgg306hSRvfmbNv5yzhPYCT4H2FcUrN1Z+LCD4f4QZe4CHwdRtNsClTE9UCkNRsO0
         cJblCN9m0rIaCUlSm7/s07Qm1FwB2CSBoZKc9rDo5Sx0+zSXYJAhZtWvVs1IMG/QJbNe
         iRL3CRwiswIaDHug9cto+khkcm4AYgnLqwSYOSY7VgY5LK858kCL5QP6XPqTZG4IAGRz
         KZdQ==
X-Gm-Message-State: AOAM532WBcyWqlYCrxPhv8Og/3yYIwQdMFAuioYntT5Jh/KjlWpMZSUY
        qc6ZJ2kj1LBPS9gKvj/hG1c=
X-Google-Smtp-Source: ABdhPJyTz57PuiLNW+lonT9pwGs9q/VaYGWFFnMuoqKJha0FF8v+OMU7hAd+MXRLdyY3f+G2SdDyPQ==
X-Received: by 2002:a05:620a:2404:b0:508:b101:6f97 with SMTP id d4-20020a05620a240400b00508b1016f97mr2618410qkn.369.1646056627394;
        Mon, 28 Feb 2022 05:57:07 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:07 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, jbx6244@gmail.com,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v4 0/8]  enable usb support on rk356x
Date:   Mon, 28 Feb 2022 08:56:51 -0500
Message-Id: <20220228135700.1089526-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

This is my patch series that I have maintained out of tree until the
combophy driver landed.

Patch 1 fixes the grf dt binding from the combophy merge.
Patch 2 adds the dt bindings for the grf changes necessary.
Patch 3 adds the SoC specific binding.
Patch 4 adds support to the grf driver to set the rk3566 otg clock
source.
Patch 5 is a downstream patch ported forward to shut down the usb3 clock
when the controller is operating in usb2 mode.
Patch 6 adds the dwc3 nodes to the rk356x device tree includes.
Patch 7 enables the dwc3 nodes on the Quartz64 Model A.
Patch 8 enables the dwc3 nodes on the rk3568-evb.

Note, there are functional changes from previous versions.

Please review and apply.

Very Respectfully,
Peter Geis

Changelog:
v4:
- Add SoC specific binding, fall back to core.
 
v3:
- Drop the dwc-of-simple method in favor of using dwc core.
- Drop all quirks except snps,dis_u2_susphy_quirk, which is necessary to
  prevent device detection failures in some states.
- Drop the reset-names.

v2:
- Add a dt-bindings fix for grf.yaml
- Unify the reset names.
- Constrain the force usb2 clock dwc3 patch to only supported variants of
the ip.
- Change dwc3-of-simple to support of-match-data.
- Drop the PCLK-PIPE clk.
- Rename the usb nodes to be more friendly.
- Add the rk3568-evb enable patch.

Bin Yang (1):
  usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode

Michael Riesch (2):
  dt-bindings: usb: add rk3568 compatible to rockchip, dwc3
  arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10

Peter Geis (5):
  dt-bindings: soc: grf: fix rk3568 usb definitions
  dt-bindings: soc: grf: add rk3566-pipe-grf compatible
  soc: rockchip: set dwc3 clock for rk3566
  arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
  arm64: dts: rockchip: enable dwc3 on quartz64-a

 .../devicetree/bindings/soc/rockchip/grf.yaml |  5 +-
 .../bindings/usb/rockchip,dwc3.yaml           |  2 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 11 +++++
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  9 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 35 +++++++++++++-
 drivers/soc/rockchip/grf.c                    | 17 +++++++
 drivers/usb/dwc3/core.c                       |  5 ++
 drivers/usb/dwc3/core.h                       |  1 +
 10 files changed, 165 insertions(+), 3 deletions(-)

-- 
2.25.1

