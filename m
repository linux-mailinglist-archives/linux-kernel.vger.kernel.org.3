Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53937501A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbiDNRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbiDNRmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:44 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75AE2F5C;
        Thu, 14 Apr 2022 10:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649958005; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BM15ImIYlN3d8CHSWmYH8cPVwojD283p5be1s3TSPyyHhKnRVacFahwucqiJhXvM9sellc8nKwOCd1qextffBnW56TuGAS7wcWnel3BfhPXgPh8alChRyfGPVsdZDAi24f6P3kjslhT0lr9XtVRxAQ8k5MCVECWRa0k4RIIzF9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649958005; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=s1LmDSijsmBE7FvhkLWY0uay9Ozv4AzabDKN3IG8EHc=; 
        b=ksnfp6GJNp0G1CBpZ3MVlIv9XhJMGhOQxQwdKVGlslnEUjUBj2K6tYot6s6BcK2Iz8NkfLKX4kSJqqA35ijWMVUDzAyOW2I8PYXTYBiv7SRrIG63/CAe4GPWS4LS3zqocotOEhY9b+DAyhphyIxZrNZu6gVoWkQsSun6cfb83Po=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649958005;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=s1LmDSijsmBE7FvhkLWY0uay9Ozv4AzabDKN3IG8EHc=;
        b=LQR735vDndLpERduTO7MJi8Y+pixpSVoEVk9jcT6yz8AZjY2bzwcmMvWHKMHjJ2y
        SF3mn5WybNPXnfJdBh5ttVpwyllR9MkUZB7SsUYTN9Z5fPP/45MoSVe7i0HR785TM8R
        gQeKIQWaJ3JJwL+l6JGvDHPN+a0l2IkarnUEdh9Q=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649958003995788.4239165981783; Thu, 14 Apr 2022 10:40:03 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 06/14] pinctrl: ralink: rename driver names to subdrivers
Date:   Thu, 14 Apr 2022 20:39:08 +0300
Message-Id: <20220414173916.5552-7-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
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

