Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88591558961
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiFWToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFWToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:44:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2620EBF6B;
        Thu, 23 Jun 2022 12:37:09 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28B3066017E1;
        Thu, 23 Jun 2022 20:37:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656013027;
        bh=SszYF29Xfhiq12kJBG1G1/y6Ph0MBRLy+lseB3tR5Bg=;
        h=From:To:Cc:Subject:Date:From;
        b=Z6O3cmIT9MDb6i9dCp+YmBKAakgPjcwqeZydaCw41M/aIXlJJyJLkODehzc4YAp2n
         s0bxjA4iwc5oPI9PWj+HeVyKl8OWuoV+l0GVbG3qyE6PLThQ3RojLsTqXaX2SRPwjX
         hUvA09udlN+lGjovbWQFFVCtM4sUhPswe+cf74h6BrQuBAzjz3rlu1Is4f6H12iAEj
         NztBdH6+dJk3ULFsNwkCwF01I94Ej9Vk+1iLb4Yx+2kSwV4Uphl9HvjHiVjXXow2uv
         73NdxlDNtzC0NVFHhGZAsiHA+h2J2IxQ4y29zvv9vEGdw/Mqi/P+xhf+coYoa5QbxD
         8ovNqnRooD8eg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 0/4] Fixes for dtbs_check warnings on Mediatek XHCI nodes
Date:   Thu, 23 Jun 2022 15:36:58 -0400
Message-Id: <20220623193702.817996-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The two first patches fix inconsistencies in the mtk-xhci dt-binding,
while the last two tweak the Mediatek devicetrees to fill in the missing
XHCI fixed clocks.

This series gets rid of a couple dtbs_check warnings on mt8192.dtsi and
another on mt8195.dtsi.

v1: https://lore.kernel.org/all/20220617222916.2435618-1-nfraprado@collabora.com

Changes in v2:
- Made all clocks required in the binding
- Instead of simply reordering the clocks on mt8192, added missing fixed
  clocks for all arm64 dts
- Added missing fixed clocks for all arm dts

Nícolas F. R. A. Prado (4):
  dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be
    optional
  dt-bindings: usb: mtk-xhci: Make all clocks required
  arm64: dts: mediatek: Set fixed-clock for missing XHCI clocks
  arm: dts: mediatek: Set fixed-clock for missing XHCI clocks

 .../bindings/usb/mediatek,mtk-xhci.yaml        |  5 ++---
 arch/arm/boot/dts/mt2701.dtsi                  | 14 ++++++++++----
 arch/arm/boot/dts/mt7623.dtsi                  | 14 ++++++++++----
 arch/arm/boot/dts/mt7629.dtsi                  |  6 ++++--
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi      | 18 ++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt7622.dtsi       |  5 +++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi       |  9 +++++++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi       |  8 ++++++--
 arch/arm64/boot/dts/mediatek/mt8192.dtsi       |  9 ++++++---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi       | 18 ++++++++++++++----
 10 files changed, 76 insertions(+), 30 deletions(-)

-- 
2.36.1

