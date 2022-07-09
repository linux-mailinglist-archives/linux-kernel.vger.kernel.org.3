Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE456C5C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiGIBgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGIBgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:36:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84278DF6;
        Fri,  8 Jul 2022 18:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hW7nQKDzc3vgKXoSY8nGWWqrIwovtmO7Gv/oo4fpWOE=; b=QFvOKdQItNvjTl1tw1WsBhwGJ0
        KHZsF5Bg2uHHojaWxU0QiPWsCz6JrC62tRcyOq5vk3/0zAz6GuZxU04ZANuzQe2IMd7LZUQFk6evS
        M2hX3znry4JjMYfzYv2g5xTuirw+LPbMfc23a14MqNyNOJCinJcetP0/EaynKypLcktUG5YU/aXo7
        WBZWttJKYYZpTmM06pfH9ly0pGaQZooz63J+Dv3dMwS1t/JKXcCNCr/32HQTmg2mwjOepg9q9gSM7
        DY33zD+6KAD6LFofeq3V4MttOXyn/6gbnwyKcT34aaXOnnj6gkXDYvWhmeSkmjuDF/SOu7nvCu0IN
        wLs6tang==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9zOB-00419A-BM; Sat, 09 Jul 2022 01:36:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Raviteja Garimella <raviteja.garimella@broadcom.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: gadget: udc: amd5536 depends on HAS_DMA
Date:   Fri,  8 Jul 2022 18:36:01 -0700
Message-Id: <20220709013601.7536-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.36.1
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

USB_AMD5536UDC should depend on HAS_DMA since it selects USB_SNP_CORE,
which depends on HAS_DMA and since 'select' does not follow any
dependency chains.

Fixes this kconfig warning:

WARNING: unmet direct dependencies detected for USB_SNP_CORE
  Depends on [n]: USB_SUPPORT [=y] && USB_GADGET [=y] && (USB_AMD5536UDC [=y] || USB_SNP_UDC_PLAT [=n]) && HAS_DMA [=n]
  Selected by [y]:
  - USB_AMD5536UDC [=y] && USB_SUPPORT [=y] && USB_GADGET [=y] && USB_PCI [=y]

Fixes: 97b3ffa233b9 ("usb: gadget: udc: amd5536: split core and PCI layer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Raviteja Garimella <raviteja.garimella@broadcom.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -311,7 +311,7 @@ source "drivers/usb/gadget/udc/bdc/Kconf
 
 config USB_AMD5536UDC
 	tristate "AMD5536 UDC"
-	depends on USB_PCI
+	depends on USB_PCI && HAS_DMA
 	select USB_SNP_CORE
 	help
 	   The AMD5536 UDC is part of the AMD Geode CS5536, an x86 southbridge.
