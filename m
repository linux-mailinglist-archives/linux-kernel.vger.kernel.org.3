Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC259508144
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiDTGji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiDTGjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:39:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11C8167C3;
        Tue, 19 Apr 2022 23:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JBXsl+mIATRCufdITmGTK7ymrd2L37dxDsu//jC6hbo=; b=1ugSkmXxYniz3j3eOGVH62DtMn
        ID7m2g6IITyaYw6VLRbde7ww6RM6JW7W5QHgyxFQP95RMQFzaNv/kGLl2nxWEDjlwjxP2YQuPy74J
        6IyY5SuNqUi7nZrYGUv+MuZWzw1vOEA1+Iiw+Vbp8X3KmKm1O3yEV8GlXiS2aQQxRug+pCPu0XkAz
        1VghU01vBl1TL/VrZAkbwSoaMYDrS9IA+dmNXEm3D0BA4kWp5zVzMDO5pTkt1xZMwmBAqj77ZV48d
        OlVB6ZuinUm9Rj00Hd/2snHZ9efjMB30v/MAEtN9wroEK7wsRXC/MH/juGJ2rXFD8Ygm6ZYIbzh0z
        3ogvOZxA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh3xF-007a6R-CB; Wed, 20 Apr 2022 06:36:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: make RADIO_ADAPTERS tristate
Date:   Tue, 19 Apr 2022 23:36:44 -0700
Message-Id: <20220420063644.17758-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors when RADIO_TEA575X=y, VIDEO_BT848=m, and VIDEO_DEV=m.

The build errors occur due to [in drivers/media/Makefile]:
obj-$(CONFIG_VIDEO_DEV) += radio/
so the (would be) builtin tea575x.o is not being built.

This is also due to drivers/media/radio/Kconfig declaring a bool
Kconfig symbol (RADIO_ADAPTERS) that depends on a tristate (VIDEO_DEV),
so when VIDEO_DEV=m, RADIO_ADAPTERS becomes =y, and then the drivers
that depend on RADIO_ADPATERS can be configured as builtin (=y) or
as loadable modules (=m).

Fix this by converting RADIO_ADAPTERS to a tristate symbol instead
of a bool symbol.

Fixes these build errors:

ERROR: modpost: "snd_tea575x_hw_init" [drivers/media/pci/bt8xx/bttv.ko] undefined!
ERROR: modpost: "snd_tea575x_set_freq" [drivers/media/pci/bt8xx/bttv.ko] undefined!
ERROR: modpost: "snd_tea575x_s_hw_freq_seek" [drivers/media/pci/bt8xx/bttv.ko] undefined!
ERROR: modpost: "snd_tea575x_enum_freq_bands" [drivers/media/pci/bt8xx/bttv.ko] undefined!
ERROR: modpost: "snd_tea575x_g_tuner" [drivers/media/pci/bt8xx/bttv.ko] undefined!

Fixes: 9958d30f38b9 ("media: Kconfig: cleanup VIDEO_DEV dependencies")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202204191711.IKJJFjgU-lkp@intel.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo@jmondi.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-media@vger.kernel.org
---
Just for fun I tested a change to drivers/media/Makefile:

-obj-y += common/ platform/ pci/ usb/ mmc/ firewire/ spi/ test-drivers/
-obj-$(CONFIG_VIDEO_DEV) += radio/
+obj-y += common/ platform/ pci/ usb/ mmc/ firewire/ spi/ test-drivers/ radio/

but that leaves a slew of other build errors (undefined symbols).

 drivers/media/radio/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -4,10 +4,10 @@
 #
 
 menuconfig RADIO_ADAPTERS
-	bool "Radio Adapters"
+	tristate "Radio Adapters"
 	depends on VIDEO_DEV
 	depends on MEDIA_RADIO_SUPPORT
-	default y
+	default VIDEO_DEV
 	help
 	  Say Y here to enable selecting AM/FM radio adapters.
 
