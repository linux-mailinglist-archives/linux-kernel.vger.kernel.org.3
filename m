Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A2654297D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiFHIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiFHIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:31:04 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD516536C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654671910; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FuAga62THTO8ISOHCPEFx/rhhtKMuB05AcAXULNCumRh16cX59Nznutz0IZNG+QN9LvQSgInBnIkal7oAUQY+JmMObgPEAdlUqtTnn8BdFhq3W3JT0Ok4osIa4INEKYj/dbrtlG5cp1zCAyaZQEkQgDfP07U0yGlcCgR+b5B8JM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654671910; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=KsA2pzq+U0bqSmgHyiHZ74OILTwlfJuxl1oir9jP7EM=; 
        b=W0xNk+4dUt2+PPrS71dVzLn2FlnNO0gOxavPtTqfEtecIkzGi03hhIGKpJycLtcYXrExd3n/Xft3xDBN6xEr/rGidRu6bbKYMR1LVHWsxLllwTVlF30hhlZg9lGDVkGZEp1AuCvkF/kMWY4v+8NEGiNh8wkwoED01RpTE5h7MvE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654671910;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=KsA2pzq+U0bqSmgHyiHZ74OILTwlfJuxl1oir9jP7EM=;
        b=JhI3tpeeXoWedikGO4Yh42G6DinriqRxBWRAiA6O/BAj/gcUTC8LCO297j8bH6JB
        kk8OF2NLO9mPDZ45Yp+EmnwBaHcW+q3QQju2yXdKxX1zj3yQQLdyciN7hoqn21V+q89
        YePvZxQLlC6BhodOBQ8QHUEExpQZNzmefIKc8dXM=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 1654671908459625.697781160352; Wed, 8 Jun 2022 00:05:08 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/7] SUNIV USB support (and updating mailmap)
Date:   Wed,  8 Jun 2022 15:04:45 +0800
Message-Id: <20220608070452.338006-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for F1C100s' USB.

As I switched to a new mail address, and this patchset contains patches
authored before this change, a mailmap update is added.

The DT binding and driver support for SUNIV USB PHY/MUSB are added, in
addition to DT changes to the DTSI and Lichee Nano DT.

Icenowy Zheng (7):
  mailmap: update Icenowy Zheng's mail address
  dt-bindings: phy: add binding document for Allwinner F1C100s USB PHY
  dt-bindings: usb: sunxi-musb: add F1C100s MUSB compatible string
  phy: sun4i-usb: add support for the USB PHY on F1C100s SoC
  musb: sunxi: add support for the F1C100s MUSB controller
  ARM: suniv: add USB-related device nodes
  ARM: suniv: f1c100s: enable USB on Lichee Pi Nano

 .mailmap                                      |  3 +
 .../phy/allwinner,suniv-f1c100s-usb-phy.yaml  | 83 +++++++++++++++++++
 .../usb/allwinner,sun4i-a10-musb.yaml         |  1 +
 .../boot/dts/suniv-f1c100s-licheepi-nano.dts  | 16 ++++
 arch/arm/boot/dts/suniv-f1c100s.dtsi          | 26 ++++++
 drivers/phy/allwinner/phy-sun4i-usb.c         | 11 +++
 drivers/usb/musb/sunxi.c                      |  8 +-
 7 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml

-- 
2.36.0

