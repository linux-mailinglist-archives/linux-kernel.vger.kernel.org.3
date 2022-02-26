Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62234C57B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiBZSmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiBZSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:30 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A91E694F;
        Sat, 26 Feb 2022 10:41:55 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id b23so5532520qtt.6;
        Sat, 26 Feb 2022 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0citrcoCzIs3IvogW91FdAVSRvwdAd+hgl6yrJCnog=;
        b=bYjmei/DsFjSIPX2KcChKNdSIy4gwCC5i9cOEdIuvqY5agdeAsPI3g3/v9jpOnrY2X
         EZkJY61m+zDEw6Si1gnjWj3tmJxelhGBAdTN8DDb838E/HRw1ETLWM1TeNmashu3sO03
         VtV+UbwQffo7at91YrbttQYxix9i0lCV1B94MVAqH1CQyrGV4+paKxp7yZMDB6APEJEj
         YmNf1GQSWxDQy+gvVMJaCsHwxAq/JSBDyciw4hzHoml6sVUAlpPohp1MY9cWXX2eE3H9
         oIDpUvt17Iqs4vlxSrgMxZWxgdE5bTOEiE0kdId0yS9zQroIiUxuhRfyFdQzvGfo/WTG
         tqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0citrcoCzIs3IvogW91FdAVSRvwdAd+hgl6yrJCnog=;
        b=PlYFq7d6CTAmhXdxUku8BYby+wIu7Vsr6YVgjTFLym6IKUjvTX2IS6ZaSJkX3NFJqQ
         G8tQl00BWQaeum+7x9v723d89YfEMWjwYrGh2FXobV+xJ4Uwu2qS1A+lmqdCr8ugglGk
         E6alcDTw7umrdutkB9pr5wUwNMjpJ9n+u+RdHAWqS3s6UKVv+gO4eJpiguxhzxHnYoiN
         AYnStzNii5pV0KpHMS/dSbZhcwIFza6LW0oToECROFo0rpSs+zNBCLt8uOeEbw09x9RD
         1RFlszraak7buxSrwk5IXp7kZ1nI2bxWYMCoLxmGTqrq+T8yxBQ2obEqpd2XUxbqmDSt
         YdqQ==
X-Gm-Message-State: AOAM530Q+EhXz6ZTQw19zH61ZrHH9KyGUhPaCRQMvHtEbNokEx67uPNG
        CLz9UMenVUdy9KNJVcuTvzI=
X-Google-Smtp-Source: ABdhPJyrCcHvaOeTvdpiFgXQoRiQBFvqkzvzacG7mNvNeZVD/h9fI04PIt92bSpBy+kbOyPOJ4jYHw==
X-Received: by 2002:a05:622a:14d4:b0:2de:735:68 with SMTP id u20-20020a05622a14d400b002de07350068mr11381215qtx.45.1645900914593;
        Sat, 26 Feb 2022 10:41:54 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:41:54 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 00/11] enable usb support on rk356x
Date:   Sat, 26 Feb 2022 13:41:36 -0500
Message-Id: <20220226184147.769964-1-pgwipeout@gmail.com>
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
Patches 2 and 3 add the dt bindings for the grf changes necessary for
this series.
Patch 4 adds support to the grf driver to set the rk3566 otg clock
source.
Patch 5 is a downstream patch ported forward to shut down the usb3 clock
when the controller is operating in usb2 mode.
Patches 6, 7, and 8 clean up the dwc3-of-simple driver, allow the use of
of-match-data, and add the compatible for the rk3568.
Patch 9 adds the dwc3 nodes to the rk356x device tree includes.
Patch 10 enables the dwc3 nodes on the Quartz64 Model A.
Patch 11 enables the dwc3 nodes on the rk3568-evb.

Please review and apply.

Very Respectfully,
Peter Geis

Changelog:
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

Peter Geis (9):
  dt-bindings: soc: grf: fix rk3568 usb definitions
  dt-bindings: soc: grf: add rk3566-pipe-grf compatible
  dt-bindings: usb: dwc3: add description for rk3568
  soc: rockchip: set dwc3 clock for rk3566
  usb: dwc3: reorder dwc-of-simple compatibles
  usb: dwc3: convert dwc3-of-simple to use match-data
  usb: dwc3: add rk3568 dwc3 support
  arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
  arm64: dts: rockchip: enable dwc3 on quartz64-a

 .../devicetree/bindings/soc/rockchip/grf.yaml |  5 +-
 .../bindings/usb/rockchip,dwc3.yaml           |  2 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 12 +++++
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  9 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 45 +++++++++++++++++-
 drivers/soc/rockchip/grf.c                    | 17 +++++++
 drivers/usb/dwc3/core.c                       |  5 ++
 drivers/usb/dwc3/core.h                       |  1 +
 drivers/usb/dwc3/dwc3-of-simple.c             | 43 +++++++++++++----
 11 files changed, 210 insertions(+), 12 deletions(-)

-- 
2.25.1

