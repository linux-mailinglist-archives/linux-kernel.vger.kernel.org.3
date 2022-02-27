Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501FC4C5E59
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 20:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiB0TDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 14:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiB0TDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 14:03:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C1A5FA3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YfQbssbJA1/QK0xiwfMG4SCzxBs35964gNoSR30NeXQ=; b=JczdytqmndjlTMd/bVQ5nSTOiP
        OMAYQx++3w03oJLNvZNBZzFSJA6N7eDVuQa/nhfACbj0kZ9RcBChuBEVyudafsQv/BrzR8pfuATm5
        iesHKo7YSe24ONtbh92AnSX7twu2JnuHk8LcyNK+1Yvnh+C97PNDnOdJiAdF5XzSnqvq8QyJN1UsN
        eKHoBqfq9PkHtM2XhyesIGNiD4dzj9u52ASwHqzjLAfmJtMGUNjwiRD4g8oqXojJxDS59YcDJfr9E
        55Du+wCSJHxDCR5h2Y/Uu4DxYHS5AGO5nktGCn0lSQFiDyav4ipKtvLEq2NKAY1Iox5mIWmyXcNYv
        BRV84GwQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOOoK-00A1Mx-Bh; Sun, 27 Feb 2022 19:02:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH -next v3] misc: rtsx: fix build for CONFIG_PM not set
Date:   Sun, 27 Feb 2022 11:02:23 -0800
Message-Id: <20220227190223.28789-1-rdunlap@infradead.org>
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
errors, so use appropriate macros for SYSTEM_SLEEP and RUNTIME_SLEEP
PM_OPS to prevent these. The #ifdef CONFIG_PM / #endif blocks
can also be removed since any dead code will be dropped by them.

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
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Paul Cercueil <paul@crapouillou.net>
---
v3: Use SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS() to avoid the build
    errors. This eliminates the need for #ifdef CONFIG_PM/#endif
    blocks of code and of __maybe_unused.

 drivers/misc/cardreader/rtsx_pcr.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- linux-next-20220225.orig/drivers/misc/cardreader/rtsx_pcr.c
+++ linux-next-20220225/drivers/misc/cardreader/rtsx_pcr.c
@@ -1699,7 +1699,6 @@ out:
 	return ret;
 }
 
-#ifdef CONFIG_PM
 
 static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 {
@@ -1784,17 +1783,10 @@ static int rtsx_pci_runtime_resume(struc
 	return 0;
 }
 
-#else /* CONFIG_PM */
-
-#define rtsx_pci_shutdown NULL
-#define rtsx_pci_runtime_suspend NULL
-#define rtsx_pic_runtime_resume NULL
-
-#endif /* CONFIG_PM */
-
 static const struct dev_pm_ops rtsx_pci_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend, rtsx_pci_resume)
-	SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend, rtsx_pci_runtime_resume, rtsx_pci_runtime_idle)
+	SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend, rtsx_pci_resume)
+	RUNTIME_PM_OPS(rtsx_pci_runtime_suspend, rtsx_pci_runtime_resume,
+		       rtsx_pci_runtime_idle)
 };
 
 static struct pci_driver rtsx_pci_driver = {
