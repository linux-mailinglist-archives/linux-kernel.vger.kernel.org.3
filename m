Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA94A33A8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 05:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354148AbiA3EM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 23:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353820AbiA3EMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 23:12:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110CC061714;
        Sat, 29 Jan 2022 20:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dNnTgGunISh6IkejeLTnvBS8rg0J0+ka5G45qlCqRVI=; b=aR+SGtya0LgPBO1+v6Rmz/gGiW
        plaHy7iOoVw+9kt2Hkwji930xwcb6O1J7BojatR2Jmm6ZTc5+aHnmm1lz09Ty7a68OLbJKYHAXRO+
        fFvfC/+UPcM4Hxi4y/8KBnJYeE721bqFvu/KceHfDGoCGxxPPgalO5s1Oe31RBSPwzUGtT4BgAn46
        JltjowvNtUdd/y4rq+6luS3KhjAWPbkFythIKNHaC514Mq4h0+jlSAeyn68uQdTG3bPcNuQCDKHF3
        CIpsOvJVksIuiFZjnRnhkZGL73XAJZ9mVPre6E4JcQCszD+MI93/FQteY0fPfP1QL+UtXKjNLNp8v
        mowtgqSQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nE1Zd-005sK9-N6; Sun, 30 Jan 2022 04:12:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: typec: mux: select not-visible INTEL_SCU_IPC
Date:   Sat, 29 Jan 2022 20:12:20 -0800
Message-Id: <20220130041220.9968-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "select INTEL_SCU_IPC" instead of depending on it since it is
not a visible Kconfig symbol and it may not otherwise be set/enabled.

Fixes: b62851491a55 ("usb: typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/mux/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220128.orig/drivers/usb/typec/mux/Kconfig
+++ linux-next-20220128/drivers/usb/typec/mux/Kconfig
@@ -12,7 +12,7 @@ config TYPEC_MUX_PI3USB30532
 config TYPEC_MUX_INTEL_PMC
 	tristate "Intel PMC mux control"
 	depends on ACPI
-	depends on INTEL_SCU_IPC
+	select INTEL_SCU_IPC
 	select USB_ROLE_SWITCH
 	help
 	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
