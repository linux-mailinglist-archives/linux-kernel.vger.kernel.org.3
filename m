Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2FC4C5886
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiBZWZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBZWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:25:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8127208337
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5p/YPWMCn5kchMlAEAoRn7rSjWDsO1V+22sdIn//plU=; b=oGcJNTovnzAIL1qn8AXDqs2dJu
        9twjS9o9vcEKr/YC3oSy1+u/INQ6AZ7G5eaYs3QSVlOHjxb/Rbbmic35FThgRmC/pAU+J4vU3BhkR
        QBJvCN1c4R6UvfktTpd+d8Mu/QWt7N9LQdx8IIJUFDGF4JjQ3c6REUG7VIdhhjEdpcb9XMXYWnG2x
        9+ZMlKCKzrfNbrcuhD3/peIEiQwtI3EuYiNaIQV+CaKNAooUxIsaGzUunvuhbbHTkewxHSlu7GpkP
        Lut1d56eqwo08BYy/Fy/YIAHywcgrifVaXzaLcAgbNnsIC3njs5Mm9sgsGKzLEf7k82y6sOG9DmtP
        Sc8hvuYw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO5Uo-008ble-QN; Sat, 26 Feb 2022 22:24:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
Date:   Sat, 26 Feb 2022 14:24:57 -0800
Message-Id: <20220226222457.13668-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When CONFG_WERROR=y and CONFIG_PM is not set, there are fatal build
errors, so surround these functions in an #ifdef CONFIG_PM block.

../drivers/misc/cardreader/rtsx_pcr.c:1057:13: error: ‘rtsx_enable_aspm’ defined but not used [-Werror=unused-function]
 static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
miscread001.out:../drivers/misc/cardreader/rtsx_pcr.c:1065:13: error: ‘rtsx_comm_pm_power_saving’ defined but not used [-Werror=unused-function]
miscread001.out: static void rtsx_comm_pm_power_saving(struct rtsx_pcr *pcr)
../drivers/misc/cardreader/rtsx_pcr.c:1084:13: error: ‘rtsx_pm_power_saving’ defined but not used [-Werror=unused-function]
 static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)

Fixes: 597568e8df04 ("misc: rtsx: Rework runtime power management flow")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wei WANG <wei_wang@realsil.com.cn>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/cardreader/rtsx_pcr.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20220225.orig/drivers/misc/cardreader/rtsx_pcr.c
+++ linux-next-20220225/drivers/misc/cardreader/rtsx_pcr.c
@@ -1054,6 +1054,7 @@ static int rtsx_pci_acquire_irq(struct r
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
 {
 	if (pcr->ops->set_aspm)
@@ -1085,6 +1086,7 @@ static void rtsx_pm_power_saving(struct
 {
 	rtsx_comm_pm_power_saving(pcr);
 }
+#endif
 
 static void rtsx_base_force_power_down(struct rtsx_pcr *pcr)
 {
