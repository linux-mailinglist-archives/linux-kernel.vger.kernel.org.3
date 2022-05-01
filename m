Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DDF5166AA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353311AbiEARiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiEARiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:38:05 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63009FD29;
        Sun,  1 May 2022 10:34:39 -0700 (PDT)
From:   "Marty E. Plummer" <hanetzer@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651426477;
        bh=tPKqcMoeXO7fbOhD7EzqxPB0j0wCmwR22hp6X3JxcpQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=XfylJujgPDxhUPj14UR8eI/v2OYDosnRFRlwFgWdUjup1ZjOFs/ek+bOCrJwmDBSv
         KQo1nZ+aFpCDRHjXi4ayrHD17AAj//FYewB1g9Gn+R6hL8YFeb0yqsRdYfPAsykx7y
         1Rj2dXbCwllftTpA5WvDxLn5cTvbKxpm5B5X5Gw+o4HqqhKJHKl2aUYNt2hGTxHD85
         o6ktWQ1eKt4RSdH/H0IkAEsdQRh+0fHXmyfJmNG1qZ+rh+jRJcaceeYDNWV41ZR1Cp
         ZrrZAV0Ny8xeJg42Jia7CGrT+es+URAKWRSeD+dKzsZ+xzQZj17zBsZaP8HqPv6qiv
         wJRGcYFCPyKXA==
To:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        hanetzer@startmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
Subject: [RFC v2 0/2] Hi3521a support.
Date:   Sun,  1 May 2022 12:34:21 -0500
Message-Id: <20220501173423.2473093-1-hanetzer@startmail.com>
In-Reply-To: <20220501054440.2434247-1-hanetzer@startmail.com>
References: <20220501054440.2434247-1-hanetzer@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend RFC.

Changes in v2:
- Actually include the dts files.
- DT Bindings still missing, as the the driver is not quite complete
  (need to add the reset controller bindings, have't quite figured that
  out yet.)

Marty E. Plummer (2):
  clk: hisilicon: add CRG driver Hi3521a SoC
  arm: hisi: enable Hi3521a soc

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/hi3521a-rs-dm290e.dts   | 134 +++++++
 arch/arm/boot/dts/hi3521a.dtsi            | 423 ++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig                |   9 +
 drivers/clk/hisilicon/Kconfig             |   8 +
 drivers/clk/hisilicon/Makefile            |   1 +
 drivers/clk/hisilicon/crg-hi3521a.c       | 141 ++++++++
 include/dt-bindings/clock/hi3521a-clock.h |  34 ++
 8 files changed, 752 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3521a-rs-dm290e.dts
 create mode 100644 arch/arm/boot/dts/hi3521a.dtsi
 create mode 100644 drivers/clk/hisilicon/crg-hi3521a.c
 create mode 100644 include/dt-bindings/clock/hi3521a-clock.h

-- 
2.35.1

