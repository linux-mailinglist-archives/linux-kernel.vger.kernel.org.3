Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA04C5C85
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiB0Pa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiB0Pa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:30:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169253F30F;
        Sun, 27 Feb 2022 07:30:20 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w1so6952844qtj.2;
        Sun, 27 Feb 2022 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TEGCkRqpaHfUe0Va3lineYBUjZGOmcm0IcjSbaRtdA=;
        b=KiM3Xnw7SOE+OtXgZRFN18B4TcD4Tfdvn/cB+wEvZsnQa+qA1bqfDK1LKA6pRECGYF
         2OiYFso3H6YtcjfP1EW4umvIb4UOIgjc6vTILTVCbQMe9yjGiOaQUN2TOoRCHsNi7BtJ
         fTPlWAR+hW7dkl0maPKNZtDOUk8Nj9zMU4HK6q0QHDnBo4VF3JBotvOsTORnjRJ7OXX1
         vdKb0KrtMM/xqVeQDKdrq9ETngR3mdTgBqL/WkWdzE5DPSw/jplTmcy/K28LcH1N/oFf
         SIs5oVY5FVCP4xVjxrODW189/Eu4pbOztaksIwtrvNOqLBl11WI+xrK3sJM55oqksTYh
         X92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TEGCkRqpaHfUe0Va3lineYBUjZGOmcm0IcjSbaRtdA=;
        b=xmXyD4ASnC6kZs/z2BFogyDWbaIgiFfoC1N7MAQkiZsEHqrnZoPUsOhj/QsMiSn65d
         Bh33BEHHXdEHMtIURAhf4mcM81eVn9GZje/TV7RZ391AwSuj+7WYdwD/RNjMXSnjKuW2
         r/ZcQZ5Ws8wyYCLC2hPW4rb4UqHzguWS8iI7VYh+o+WxGrkRUQCmB8EwGxnJpC4idPh4
         8pALTFEGAbJ3JIQaJYdiq80ii1c/E1ZZJozhSgPr7eZGLXUoz/ibYAPYDa4m35nnyo1I
         eI1AYHCzO5UM/FLCRxhf+jCA7prcWVa/oHv2jC4gATwLnJQR/oWj3wzFwRg+EzmpRGYQ
         seuQ==
X-Gm-Message-State: AOAM532ap5QBeasWVR1UMir4L/eOzZBzk5fuZ2Z+9ey/6m/sDs3anJPX
        ipxlwtV/RtHdjj//iqaL1yk=
X-Google-Smtp-Source: ABdhPJxdSkPSXhT6LalNn4z7oCximUdTIqvXNTTKjd9ZvCBIH3GNHkKOHSp3xJC+M2fqvDzLlKYc7Q==
X-Received: by 2002:a05:622a:1a81:b0:2ce:7959:d9a2 with SMTP id s1-20020a05622a1a8100b002ce7959d9a2mr13293685qtc.135.1645975818820;
        Sun, 27 Feb 2022 07:30:18 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:18 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, jbx6244@gmail.com,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 0/7] enable usb support on rk356x
Date:   Sun, 27 Feb 2022 10:30:09 -0500
Message-Id: <20220227153016.950473-1-pgwipeout@gmail.com>
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
Patch 3 adds support to the grf driver to set the rk3566 otg clock
source.
Patch 4 is a downstream patch ported forward to shut down the usb3 clock
when the controller is operating in usb2 mode.
Patch 5 adds the dwc3 nodes to the rk356x device tree includes.
Patch 6 enables the dwc3 nodes on the Quartz64 Model A.
Patch 7 enables the dwc3 nodes on the rk3568-evb.

Note, there are functional changes from previous versions.

Please review and apply.

Very Respectfully,
Peter Geis

Changelog:
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

Michael Riesch (1):
  arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10

Peter Geis (5):
  dt-bindings: soc: grf: fix rk3568 usb definitions
  dt-bindings: soc: grf: add rk3566-pipe-grf compatible
  soc: rockchip: set dwc3 clock for rk3566
  arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
  arm64: dts: rockchip: enable dwc3 on quartz64-a

 .../devicetree/bindings/soc/rockchip/grf.yaml |  5 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 11 +++++
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  9 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 35 +++++++++++++-
 drivers/soc/rockchip/grf.c                    | 17 +++++++
 drivers/usb/dwc3/core.c                       |  5 ++
 drivers/usb/dwc3/core.h                       |  1 +
 9 files changed, 163 insertions(+), 3 deletions(-)

-- 
2.25.1

