Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652B4FEF51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiDMGLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiDMGK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:10:59 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44535A8E;
        Tue, 12 Apr 2022 23:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649830101; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=liMgNpg33SS2OvOZYdZBKHZPqfXvTi8pe2mXkUOC1YNNNsD53CjcTEtzhm7ywRh/q4vEifwykX5M+gZlsbUk7wQYdGKiROSyFlCdF6nAic/YMp8okO+ynkThGQpUQy4m5y0SoeKocv/BeL+A5c9WoIy7SoRnEvf3YTCG+F9NLxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649830101; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=878kXtEdAnfBMNKIaxNjcqBB89T7RAeyy8yeVqqZFHA=; 
        b=UGyTXtknCEaz98x2XVAGNPd0FMmwfz3sU4DfzcLM+2dViqxqH0hvChK0Pjj5/eizqn3i7SXqB5WvnI8Jm71Rk+ffY8daCF1eSB7ru51PhH24mOFnG17xuNsXJok0/HxgAZnMXB1MocrlRyoI7a1aCpJZn501KqnwJbWfYEgjm7Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649830101;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=878kXtEdAnfBMNKIaxNjcqBB89T7RAeyy8yeVqqZFHA=;
        b=XHLpY3f5Wlpeu1WOHea63Cmyugy13JUveEvwQmzPjDFvsh8xlry0jpxJlS/bQ5qU
        nxVQgrdZ8lJ6zTIWzE5V3xxhSz2IvoX1sNbhCM9ehp0W5EpKqLRdhJi6gCbSp6TTrJg
        Ro/zzMAz9e7ph8hjjEDS5nRcnaLtwkpkTcHaUYPo=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649830100132544.2723875253341; Tue, 12 Apr 2022 23:08:20 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 06/14] pinctrl: ralink: rename driver names to subdrivers
Date:   Wed, 13 Apr 2022 09:07:21 +0300
Message-Id: <20220413060729.27639-7-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413060729.27639-1-arinc.unal@arinc9.com>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7620, MT7621, RT2880, RT305X and RT3883 pinctrl are subdrivers of the
Ralink pinctrl driver. Change the bool for these subdrivers accordingly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/ralink/Kconfig b/drivers/pinctrl/ralink/Kconfig
index aa82acfae827..1e4c5e43d69b 100644
--- a/drivers/pinctrl/ralink/Kconfig
+++ b/drivers/pinctrl/ralink/Kconfig
@@ -8,27 +8,27 @@ config PINCTRL_RALINK
         select GENERIC_PINCONF
 
 config PINCTRL_MT7620
-        bool "mt7620 pinctrl driver for RALINK/Mediatek SOCs"
+        bool "MT7620 pinctrl subdriver"
         depends on RALINK && SOC_MT7620
         select PINCTRL_RALINK
 
 config PINCTRL_MT7621
-        bool "mt7621 pinctrl driver for RALINK/Mediatek SOCs"
+        bool "MT7621 pinctrl subdriver"
         depends on RALINK && SOC_MT7621
         select PINCTRL_RALINK
 
 config PINCTRL_RT2880
-        bool "RT2880 pinctrl driver for RALINK/Mediatek SOCs"
+        bool "RT2880 pinctrl subdriver"
         depends on RALINK && SOC_RT288X
         select PINCTRL_RALINK
 
 config PINCTRL_RT305X
-        bool "RT305X pinctrl driver for RALINK/Mediatek SOCs"
+        bool "RT305X pinctrl subdriver"
         depends on RALINK && SOC_RT305X
         select PINCTRL_RALINK
 
 config PINCTRL_RT3883
-        bool "RT3883 pinctrl driver for RALINK/Mediatek SOCs"
+        bool "RT3883 pinctrl subdriver"
         depends on RALINK && SOC_RT3883
         select PINCTRL_RALINK
 
-- 
2.25.1

