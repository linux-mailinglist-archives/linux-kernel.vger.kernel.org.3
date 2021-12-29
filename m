Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB2480E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhL2AF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhL2AFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:05:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622CC061574;
        Tue, 28 Dec 2021 16:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=p+8t8GMXlh3yCxmWJKyVKZavUzB1s6mehdcQbUgFZJw=; b=CYihfF7tg9nCiccnNGQ9HrdKvM
        PNTBIDaOf2pAYw3CawqlelF7GTAbwhNfI2ZdQAICFn4uzGUor9sKQgncfTfd9O0bVqfKjlVohyfM4
        fJESCZIEpqXbVJcRfwnjzwVWKuLg7YXp0s3yhhhaH1Bd3g9uv5bjMA1VAoy/4CK2jkPmUXCLO6LeY
        gtd5ZVchH2rgsmjAn+gchHpPZb6nhNjMTNm4bSzkQjd1woACpi2uOdD4MHxi5mIcR2ehLDDlrAqvX
        lnn1V7BiB8JoJVnMfc8Kzd+hEU0HnBmJqNdEMQFcI+uiCIlXXn8mXocRMsN0dm3vNQ3eObENGGyld
        nJ6FQ8Nw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2MTa-001zrq-HO; Wed, 29 Dec 2021 00:05:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com, alsa-devel@alsa-project.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mips: bcm63xx: add support for clk_set_parent()
Date:   Tue, 28 Dec 2021 16:05:53 -0800
Message-Id: <20211229000553.32240-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS BMC63XX subarch does not provide/support clk_set_parent().
This causes build errors in a few drivers, so add a simple implementation
of that function so that callers of it will build without errors.

Fixes these build errors:

ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!

Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs." )
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/mips/bcm63xx/clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20211224.orig/arch/mips/bcm63xx/clk.c
+++ linux-next-20211224/arch/mips/bcm63xx/clk.c
@@ -387,6 +387,12 @@ struct clk *clk_get_parent(struct clk *c
 }
 EXPORT_SYMBOL(clk_get_parent);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
 unsigned long clk_get_rate(struct clk *clk)
 {
 	if (!clk)
