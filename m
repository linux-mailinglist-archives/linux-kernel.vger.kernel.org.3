Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F338859CC12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiHVXVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiHVXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:21:05 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8D5508C;
        Mon, 22 Aug 2022 16:21:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27MNKl2j078398;
        Mon, 22 Aug 2022 18:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661210447;
        bh=cVwpBSQCIkk2fW+4ju4eb56iR3EkVUjqfp0YNPcsECU=;
        h=From:To:CC:Subject:Date;
        b=g53z1u9lS7hq49/dAhAMkqFylZQZzudXRSceHt144+dAKyFMf0oB/kQgY5lxjc+fd
         oFmp0aYIyo30lmCNVJsW0AnhZ1IqW4R3c3sk/TKwaA1SSP6DFr8o+zGEatT0nKuWyX
         /c7EWaJplTT9P48g3plfTyGvMQil/Fv7/JG8ZFDQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27MNKlSv021071
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 18:20:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 18:20:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 18:20:46 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27MNKkkQ122207;
        Mon, 22 Aug 2022 18:20:46 -0500
From:   Andrew Davis <afd@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 0/2] TI-Nspire cleanups
Date:   Mon, 22 Aug 2022 18:20:44 -0500
Message-ID: <20220822232046.1230-1-afd@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I don't have the hardware to test this (yes I know who my current
employer is), but it does look right and this lets us remove the rest
of mach-nspire/ without losing any functionality.
Does anyone have one of these to test with?

The second patch removes a couple defines that do not seem to have ever
been used, but if one want to implement it, then it should be a simple
generic syscon DT node.

Thanks,
Andrew

Andrew Davis (2):
  ARM: nspire: Use syscon-reboot to handle restart
  ARM: nspire: Remove unused header file mmio.h

 arch/arm/boot/dts/nspire.dtsi |  7 ++++
 arch/arm/mach-nspire/Kconfig  |  2 ++
 arch/arm/mach-nspire/mmio.h   | 16 ----------
 arch/arm/mach-nspire/nspire.c | 60 +++++++++++------------------------
 4 files changed, 27 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/mach-nspire/mmio.h
 rewrite arch/arm/mach-nspire/nspire.c (61%)

-- 
2.36.1

