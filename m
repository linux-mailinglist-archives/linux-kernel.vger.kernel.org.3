Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302A24973C5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiAWRkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiAWRkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:40:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD9C06173B;
        Sun, 23 Jan 2022 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DGKiPi5akBMuoplIkl0mUGNJKDwOspsRE8AW46Bb654=; b=pUkZwGn4D13IFlPeXuPy+oXY7O
        AEYvbWj6EEizsuNe9coBAHL2WBtCYY7eDUkKxpaZZHuvmkztVsKq1Q7bxtwPhPXzh/fmzrSzuLjp8
        K2EPdv+5BzcGTYNgXrJilsaT6MH09/aIsxaZp7Ve2w6KbA9Ug6FZJ89qUHETRpyASUVa2nrBodFrI
        qv4wRrxetygmov6bnxq9L+NpLERVg2fa2rRi6LwBt+wGrtsmcc0YdXUEdGNPoT4SUJMj2dQtlS0Kj
        UCWqiW4H60Lt+MeMXlf/qKXyBZXgbO3iPS0HzYXxmi6GEIAITTtBZEIZpwD1DgsHinMgZrPuXZzI4
        5wVmQyIQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBgqu-001VRa-Ox; Sun, 23 Jan 2022 17:40:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH] pcmcia: db1xxx_ss: restrict to MIPS_DB1XXX boards
Date:   Sun, 23 Jan 2022 09:40:31 -0800
Message-Id: <20220123174031.3109-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the MIPS_ALCHEMY board selection is MIPS_XXS1500 instead of
MIPS_DB1XXX, the PCMCIA driver 'db1xxx_ss' has build errors due
to missing DB1XXX symbols. The PCMCIA driver should be restricted
to MIPS_DB1XXX instead of MIPS_ALCHEMY to fix this build error.

ERROR: modpost: "bcsr_read" [drivers/pcmcia/db1xxx_ss.ko] undefined!
ERROR: modpost: "bcsr_mod" [drivers/pcmcia/db1xxx_ss.ko] undefined!

Fixes: 42a4f17dc356 ("MIPS: Alchemy: remove SOC_AU1X00 in favor of MIPS_ALCHEMY")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Kees Cook <keescook@chromium.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 drivers/pcmcia/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220121.orig/drivers/pcmcia/Kconfig
+++ linux-next-20220121/drivers/pcmcia/Kconfig
@@ -151,7 +151,7 @@ config TCIC
 
 config PCMCIA_ALCHEMY_DEVBOARD
 	tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
-	depends on MIPS_ALCHEMY && PCMCIA
+	depends on MIPS_DB1XXX && PCMCIA
 	help
 	  Enable this driver of you want PCMCIA support on your Alchemy
 	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300
