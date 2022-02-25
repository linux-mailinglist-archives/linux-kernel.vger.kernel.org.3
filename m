Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792874C4806
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiBYOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiBYOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:10 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E092272CB;
        Fri, 25 Feb 2022 06:54:37 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id s15so2597939qtk.10;
        Fri, 25 Feb 2022 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idLLe3Bg4LF24zcJUztJfruP9rviMV/MQdx2SKITisA=;
        b=X/9D7SgoZNXpKyJMlKxUSgUhPWyk42fgywEhpPUw2z/BV4DQZEhDIf/LdrFHvsmSJP
         3DwLYkYmGQZYgqOJpiQOgnIQIRt8S5SXRdSM9Fk7oPHfHLxlJ5JalSvU3YVN9X9lsco1
         lGyithf96rqpB0VcuXiWt4aH3n4ioClC4OqqD6H1UAKpI8kcaLs/DRNQiKQg7XG4WFgr
         2pxt8M06llBuAJ4aF1dhU5ogBgZpXetM1dYoYCETQivLFGcecF9b2NKloXC/xnDDh62S
         slVwXvL7vxjB/X8JISta8L5fFuWWa+P6e16MWYRj+MNnpiKpF2kf/jly10XrV/cLlE6b
         wUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idLLe3Bg4LF24zcJUztJfruP9rviMV/MQdx2SKITisA=;
        b=UWYbXKqvNG/p8VmOl/H4I1/z633/3l3zmh30podCEv4tsFiNgz2f59fLHimdXevEZO
         j5AJ08OAUeiJb2BA0+X28GjDmvpwiWLRdTLxiCLwtXwRP8n3pEnUgY5/8KPy0rZnYHY5
         RNB4qB0H+ZIV/VAG+Mc+624qfcNooYW6oPiMwKRxOIf5YA2Br13O7H3yZ448JZ6qaB1K
         6+1BPjTbKeQ6oJ+Ns3p8jmZ+h3ZF1EQhVt6E/jK0yGI2KivodgNLaaNQ3+bxfM4aaTO+
         FKqCXWi/coz1qxsw2HVn4tLledPiXJJDAt3LfbNEUlEHNnKdM/+0VW+aVp+cj0dGATuB
         qQnA==
X-Gm-Message-State: AOAM532qG6qK+E3q9Md9ybTRvBi2xuPeiymm82yuYBxGxM4TvsLzZaaL
        nJKwQDHuML/nqsYOG4ElOOE=
X-Google-Smtp-Source: ABdhPJx2IrHsuBjXNGhta/57OefPON6bBNrtjhLrpp1XeJqtxWR4g6LR+eX7Q7H2ZindKVCs0St8SA==
X-Received: by 2002:ac8:5e48:0:b0:2dd:aae2:9163 with SMTP id i8-20020ac85e48000000b002ddaae29163mr7054520qtx.95.1645800875662;
        Fri, 25 Feb 2022 06:54:35 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:35 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 0/8] enable usb support on rk356x
Date:   Fri, 25 Feb 2022 09:54:23 -0500
Message-Id: <20220225145432.422130-1-pgwipeout@gmail.com>
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
combophy driver landed. Note, it is dependent on this series to function
(aside from the rk3566 dwc3-otg port, which will work currently).

This series is still dependent on Patch 4 of the combophy series, which
has yet to be accepted.

Patches 1 and 2 add the dt bindings for the grf changes necessary for
this series.
Patch 3 adds support to the grf driver to set the rk3566 otg clock
source.
Patch 4 is a downstream patch ported forward to shut down the usb3 clock
when the controller is operating in usb2 mode.
Patches 5 and 6 clean up the dwc3-of-simple driver and add the
compatible for the rk3568.
Patch 7 adds the dwc3 nodes to the rk356x device tree includes.
Patch 8 enables the dwc3 nodes on the Quartz64 Model A.

Please review and apply.

Very Respectfully,
Peter Geis

Bin Yang (1):
  usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode

Peter Geis (7):
  dt-bindings: soc: grf: add rk3566-pipe-grf compatible
  dt-bindings: usb: dwc3: add description for rk3568
  soc: rockchip: set dwc3 clock for rk3566
  usb: dwc3: reorder dwc-of-simple compatibles
  usb: dwc3: add rk3568 dwc3 support
  arm64: dts: rockchip: add the dwc3 usb3 nodes to rk356x
  arm64: dts: rockchip: enable the dwc3 nodes on quartz64-a

 .../devicetree/bindings/soc/rockchip/grf.yaml |  1 +
 .../bindings/usb/rockchip,dwc3.yaml           |  7 ++-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 12 +++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  9 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 45 ++++++++++++++++++-
 drivers/soc/rockchip/grf.c                    | 17 +++++++
 drivers/usb/dwc3/core.c                       |  4 ++
 drivers/usb/dwc3/core.h                       |  1 +
 drivers/usb/dwc3/dwc3-of-simple.c             | 10 +++--
 10 files changed, 137 insertions(+), 6 deletions(-)

-- 
2.25.1

