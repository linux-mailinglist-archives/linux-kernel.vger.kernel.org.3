Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B551533E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbiEYNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEYNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:52:38 -0400
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com [221.176.66.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17A8F880D9;
        Wed, 25 May 2022 06:52:35 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.93])
        by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4628e34a2a03-0c238;
        Wed, 25 May 2022 21:52:34 +0800 (CST)
X-RM-TRANSID: 2ee4628e34a2a03-0c238
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.216])
        by rmsmtp-syy-appsvrnew07-12032 (RichMail) with SMTP id 2f00628e349e57c-d3251;
        Wed, 25 May 2022 21:52:33 +0800 (CST)
X-RM-TRANSID: 2f00628e349e57c-d3251
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()
Date:   Wed, 25 May 2022 21:53:32 +0800
Message-Id: <20220525135332.23144-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_domain_attach_by_name() may return NULL in some cases,
so IS_ERR() doesn't meet the requirements. Thus fix it.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index d9c406bdb..c25765628 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3691,15 +3691,15 @@ static int tegra_xudc_powerdomain_init(struct tegra_xudc *xudc)
 	int err;
 
 	xudc->genpd_dev_device = dev_pm_domain_attach_by_name(dev, "dev");
-	if (IS_ERR(xudc->genpd_dev_device)) {
-		err = PTR_ERR(xudc->genpd_dev_device);
+	if (IS_ERR_OR_NULL(xudc->genpd_dev_device)) {
+		err = PTR_ERR(xudc->genpd_dev_device) ? : -ENODATA;
 		dev_err(dev, "failed to get device power domain: %d\n", err);
 		return err;
 	}
 
 	xudc->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "ss");
-	if (IS_ERR(xudc->genpd_dev_ss)) {
-		err = PTR_ERR(xudc->genpd_dev_ss);
+	if (IS_ERR_OR_NULL(xudc->genpd_dev_ss)) {
+		err = PTR_ERR(xudc->genpd_dev_ss) ? : -ENODATA;
 		dev_err(dev, "failed to get SuperSpeed power domain: %d\n", err);
 		return err;
 	}
-- 
2.20.1.windows.1



