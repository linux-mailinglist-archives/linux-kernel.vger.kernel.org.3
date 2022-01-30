Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0254A3845
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 19:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354597AbiA3Suh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 13:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA3Suf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 13:50:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D3AC061714;
        Sun, 30 Jan 2022 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=B1suBtW3lHIZdcZqiYA9O6jJfZ6qe3rMGVXedeEUrXQ=; b=k3DfgPnT6T+BrhRoOdpuwmKASc
        mNUFoJjSnLPPoE4SZdiMG02cDoVKFBNs+5JY1iUQBy8gFv94BANGGjzSWhnivL8cjtV9ihPc7S5pb
        +ITu43uaZJqyE5jTGSVM7+rsTflSWxQp7xYSWuZQ4T++AFKwP257i/IjdseXu+CDvzzzJ8axBBdZG
        d11IUIAnXTT3BKq9dw4S+X85JvKC48T2E1QS82/990yj5HGbtU6m/ceIjjRdsU6B1JkJX9WwMwk5d
        TGrznM6a4wdfRTHbAReLU3UXGD8Dh9xClkZ92vCT5k9/hO6RpmkzcIqdGGQt2ZkgOCI8ibYPdczo4
        HrD/WdWg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEFHV-007Eak-Lj; Sun, 30 Jan 2022 18:50:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] usb: typec: mux: select not-visible INTEL_SCU_IPC
Date:   Sun, 30 Jan 2022 10:50:32 -0800
Message-Id: <20220130185032.29298-1-rdunlap@infradead.org>
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
Cc: kernel test robot <lkp@intel.com>
---
v2: add dependency on X86_PLATFORM_DEVICES to fix build error that was
    Reported_by: kernel test robot <lkp@intel.com>

 drivers/usb/typec/mux/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220128.orig/drivers/usb/typec/mux/Kconfig
+++ linux-next-20220128/drivers/usb/typec/mux/Kconfig
@@ -11,8 +11,8 @@ config TYPEC_MUX_PI3USB30532
 
 config TYPEC_MUX_INTEL_PMC
 	tristate "Intel PMC mux control"
-	depends on ACPI
-	depends on INTEL_SCU_IPC
+	depends on ACPI && X86_PLATFORM_DEVICES
+	select INTEL_SCU_IPC
 	select USB_ROLE_SWITCH
 	help
 	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
