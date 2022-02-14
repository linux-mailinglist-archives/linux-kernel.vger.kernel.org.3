Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DD4B5944
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357323AbiBNSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:00:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiBNSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:00:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47C65171;
        Mon, 14 Feb 2022 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HygV3XynhCWrLpKM8VJKHu9+X1H4p6aYXQjio6QBpNQ=; b=deznadcEnTnsRwCjyeG/X5REA4
        Sgx4C3jljYLtS61dg9r+fGYuXtq8p6i9+KXM0N6IL1bMS0FaoCAKHMQAWnwEqpjPiIpt9aeBVGeTL
        KeXlfV3RyYlvf2DdAmP6PJ7LNttLivHoy975w2qUAJkj6mAhOg1RLpAQ4U5HWDadMON3d9/FunguZ
        OaIYF3Uqfhf4/mM3kzPxVns5Jq7rzM6f8vPu4H7AfXlE4l8+JzUNVzIP2gkxvNYcD89uaBiiipsfv
        svS/72ZEM+SqWlbjl3YhVYs7SlPa7CgGKpSR9IT2nBwL5L0kl+FWspdZUBnQOgS/Y5mpdiw9I6nK5
        24A+t8sA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJfe8-00GSyp-2F; Mon, 14 Feb 2022 18:00:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] serial: parisc: GSC: fix build when IOSAPIC is not set
Date:   Mon, 14 Feb 2022 10:00:19 -0800
Message-Id: <20220214180019.20384-1-rdunlap@infradead.org>
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

There is a build error when using a kernel .config file from
'kernel test robot' for a different build problem:

hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
(.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'

when:
  CONFIG_GSC=y
  CONFIG_SERIO_GSCPS2=y
  CONFIG_SERIAL_8250_GSC=y
  CONFIG_PCI is not set
    and hence PCI_LBA is not set.
  IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.

Make the use of iosapic_serial_irq() conditional to fix the build error.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Suggested-by: Helge Deller <deller@gmx.de>
---
v2: make the call to iosapic_serial_irq() conditional based on
    CONFIG_ settings (thanks, Helge)

 drivers/tty/serial/8250/8250_gsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220211.orig/drivers/tty/serial/8250/8250_gsc.c
+++ linux-next-20220211/drivers/tty/serial/8250/8250_gsc.c
@@ -26,7 +26,7 @@ static int __init serial_init_chip(struc
 	unsigned long address;
 	int err;
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)
 	if (!dev->irq && (dev->id.sversion == 0xad))
 		dev->irq = iosapic_serial_irq(dev);
 #endif
