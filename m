Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB29598526
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbiHROBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbiHROAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:00:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7356D540;
        Thu, 18 Aug 2022 07:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64C62B82197;
        Thu, 18 Aug 2022 14:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1BCC433C1;
        Thu, 18 Aug 2022 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831199;
        bh=GXZIItypEHjQWFs8f6Waz69s/m0DTcToAM/9CwRqUN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVXozCtzXhgUvTEJmptj3ciD8Y3SvvJPtLtFjqJrlWq+NEDwuaNBfuLEayPrc42CN
         yyCJibjvmPhDzJ05Jun4jCorRHUE3+mhdzJD2z1p4ZLQAKM6w2EaUwumVBoAAD370q
         6PI5Hgal/UJZIvctJuuhDH2p7c7Kun3gkrdewZX9ZSsgK76a/lfPbL6s4JuPB5OlVT
         Rh0OdOHBBo2jLas0MLN5j37p61NXafVpYLQ+Xf2F7qBv44m/lQMX9z34hHfIripXPq
         WdbHZySdEhh5IijqL8mGmd5mLoGmqFlIwCumbIJwGUE40qIH5bkpfbJY8pDG/WcIr1
         TYK5uVG5htO2g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] musb: fix USB_MUSB_TUSB6010 dependency
Date:   Thu, 18 Aug 2022 15:57:20 +0200
Message-Id: <20220818135737.3143895-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135737.3143895-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Turning on NOP_USB_XCEIV as builtin broke the TUSB6010 driver because
of an older issue with the depencency.

It is not necessary to forbid NOP_USB_XCEIV=y in combination with
USB_MUSB_HDRC=m, but only the reverse, which causes the link failure
from the original Kconfig change.

Use the correct dependency to still allow NOP_USB_XCEIV=n or
NOP_USB_XCEIV=y but forbid NOP_USB_XCEIV=m when USB_MUSB_HDRC=m
to fix the multi_v7_defconfig for tusb.

Fixes: ab37a7a890c1 ("ARM: multi_v7_defconfig: Make NOP_USB_XCEIV driver built-in")
Fixes: c0442479652b ("usb: musb: Fix randconfig build issues for Kconfig options")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/musb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index f906dfd360d3..6c8f7763e75e 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -86,7 +86,7 @@ config USB_MUSB_TUSB6010
 	tristate "TUSB6010"
 	depends on HAS_IOMEM
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
-	depends on NOP_USB_XCEIV = USB_MUSB_HDRC # both built-in or both modules
+	depends on NOP_USB_XCEIV!=m || USB_MUSB_HDRC=m
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-- 
2.29.2

