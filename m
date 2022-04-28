Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6EF513139
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiD1K0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiD1K0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:26:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA1220C4;
        Thu, 28 Apr 2022 03:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EED98B82ADD;
        Thu, 28 Apr 2022 10:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B16C385A9;
        Thu, 28 Apr 2022 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651141399;
        bh=eGq+Qy5coA1eiupDJohON71z3nxTpsGZWZmLWIPy7Ls=;
        h=From:To:Cc:Subject:Date:From;
        b=t5okDDTkd4qUrowvavmE94jQ05DGUDdcjuHpgLYTfkNzVvG8U7t/ii6RZgsCK4Ekm
         9nfC2LVtbzjaWcNGF/sNtHEd7dk5peocOPsYoyUrDoSK0HOIRgcvWUfytCyeiW5OC3
         Li5tofqAOYEAe88wzZ5beQDsLc659hQojAHNJ/aOtPqkuE39imWWfXi4AFLfykl/Et
         1JTq3Pvquf1+n83xduuvSAYHqnox3vTs4VthV8okERrtQai8ykzip+9Ua8BxEjL95d
         OsQ6E0kOJNnPQJlBRDJIHsS+Gm6Bb9oViXgnL9Oser3LkpTsQm35f5fDn219YCjlsL
         Fl98pxTzeHXeQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ehci-omap: drop unused ehci_read() function
Date:   Thu, 28 Apr 2022 12:22:58 +0200
Message-Id: <20220428102314.950323-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After moving the omap1 platform into generalized multiplatform
support on ARM, the kernel test robot points out a W=1 warning that
now shows up in more configurations:

drivers/usb/host/ehci-omap.c:64:19: warning: unused function 'ehci_read'

The function was last used 9 years ago and can just be removed.

Fixes: 87425ad36330 ("USB: ehci-omap: Remove PHY reset handling code")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ehci-omap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7f4a03e8647a..8c45bc17a580 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -61,11 +61,6 @@ static inline void ehci_write(void __iomem *base, u32 reg, u32 val)
 	__raw_writel(val, base + reg);
 }
 
-static inline u32 ehci_read(void __iomem *base, u32 reg)
-{
-	return __raw_readl(base + reg);
-}
-
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
 
-- 
2.29.2

