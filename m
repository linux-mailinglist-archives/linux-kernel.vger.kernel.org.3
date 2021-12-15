Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D347641B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhLOVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhLOVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:02:58 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E151C061574;
        Wed, 15 Dec 2021 13:02:58 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z9so23231299qtj.9;
        Wed, 15 Dec 2021 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rg/3hN0e0TCpLvswI7fQ10BFOQtPWlta0LiifXq1NbI=;
        b=m4vnhxHPtB66eBAgJXgtLtT1LXEt8GiBufJHnBQbk/kyJwztY7pNerexrZ8bvsfRTn
         sZDCZzgeeP+tARmrEhqM7xtYKA25U0DyxIezpPGkudj48aLWgFD/6+ycrY5HjS+9BKK1
         Dqek4Vlbw+ID3u0AhVx47wHOIlSJh+z7DC5EALE1qZu2Fy7v3vEJ5U1GU+MyfhTjQr4V
         3ZFoYgQvcucjF+wl6JhPVO4AvQKcaGq3mZMyv2G2mC8rAr5lqM/8CTxIPH+0Q9BGfmzl
         Hf+fMVrKwnjoFpGasxy+dnKBMhLvX0a2rCdw04xKGsSfNPQUMqwyugeruZzORTw7t+Ot
         2bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rg/3hN0e0TCpLvswI7fQ10BFOQtPWlta0LiifXq1NbI=;
        b=Qhps5+WjHhCf3dPDg8LF+TWrPAsJUu5aD/AMRiyN0csGo1LrkRRsIIJIs8ilwL5TBR
         uxdwrJH9d9/NIrL+sDpbIEdDsS9hp7UN4LvfcwQYxLWbtL6t7RJmcozgilUigMnGUwkZ
         Xoxj7XCwjAUTjWPcpgTZeZwXxkvohE8WI1wAsUnPNuJbdG4ugSwRZH+N+3u9CwHihPmM
         JEcIe1OAlVALmxnGUX/ymkHXytL7YVmTzzUjC5cOX9MJa2+2UkFlBLTARIo/ykW0dGH/
         yk4CpTcZ6FIZvzcWb9QsXpWK1PXbONU/m0e6oLkvxA9Gza1CAuVAdnuN7P9lqz/Cxq8A
         viMw==
X-Gm-Message-State: AOAM5328j6OTeDgo5WoZHznSQGffztUzEpJTiD/WtDT1FQnka9biNVqv
        cDcszM/AHgQapgLPfzYtq+P/vtt6QMu9WQ==
X-Google-Smtp-Source: ABdhPJwAzzADLtXZ0TSEB0cgsuZRavn1+kgANRdz7FqzEtZGT0zjUeqO3qZbwWB7F0PQWd6Y5qbdYQ==
X-Received: by 2002:a05:622a:15ca:: with SMTP id d10mr14054429qty.81.1639602177604;
        Wed, 15 Dec 2021 13:02:57 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:02:57 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH v3 0/8] phy-rockchip-inno-usb2: support rk356x usb2phy
Date:   Wed, 15 Dec 2021 16:02:44 -0500
Message-Id: <20211215210252.120923-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,

This is my series to support the usb2 phy devices on the rk356x.
The rk356x phy has a single muxed interrupt and has moved the usb2phy
nodes out of the grf and into their own nodes.
The phy needs to tie back into the grf for register control, similar to
the rv1108.
By moving the phys into their own nodes, they now have full
#address_cells = 2 register addresses, but they still reside below the 32bit
mmio range.

This driver series only supports the host configuration for the rk356x.
I have have tested it on the following:
rk3566 - Pine64 Quartz64 Model A
rk3399 - Pine64 Rockpro64

Please provide feedback and comments as you see fit.

Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

Changelog:
v3:
- adjust usb2phy dt-bindings to filter correctly, thanks Rob and Johan
- adjust usb2phy dts names to fix alphetical ordering, thanks Michael
- squash "phy: rockchip-inno-usb2: Don't print useless error" thanks
  Ondrej

v2:
- correct the order of the usb2phy-grf dt-bindings patch, thanks Johan
- correct the conditional requirements of phy-rockchip-inno-usb2, thanks
  Johan
- drop increase generic-ohci clocks patch, thanks Heiko
- correct rk356x.dtsi ordering
- fix a dtbs-check callout

Peter Geis (8):
  dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
  dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
  phy: phy-rockchip-inno-usb2: support #address_cells = 2
  phy: phy-rockchip-inno-usb2: support standalone phy nodes
  phy: phy-rockchip-inno-usb2: support muxed interrupts
  phy: phy-rockchip-inno-usb2: add rk3568 support
  arm64: dts: rockchip: add usb2 nodes to rk3568 device tree
  arm64: dts: rockchip: add Quartz64-A usb2 support

 .../bindings/phy/phy-rockchip-inno-usb2.yaml  |  44 ++-
 .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  52 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  98 +++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 259 ++++++++++++++----
 5 files changed, 396 insertions(+), 58 deletions(-)

-- 
2.25.1

