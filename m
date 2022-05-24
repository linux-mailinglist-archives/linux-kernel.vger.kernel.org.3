Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED6E532A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiEXMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiEXMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:30:58 -0400
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com [221.176.66.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80F98941BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:30:55 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.87])
        by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4628ccffe99c-f110b;
        Tue, 24 May 2022 20:30:54 +0800 (CST)
X-RM-TRANSID: 2ee4628ccffe99c-f110b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvrnew04-12029 (RichMail) with SMTP id 2efd628ccffa4f6-ad1ba;
        Tue, 24 May 2022 20:30:53 +0800 (CST)
X-RM-TRANSID: 2efd628ccffa4f6-ad1ba
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] opp: Fix error check in dev_pm_opp_attach_genpd()
Date:   Tue, 24 May 2022 20:31:51 +0800
Message-Id: <20220524123151.1416-1-tangbin@cmss.chinamobile.com>
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

Fixes: 6319aee10e53 ("opp: Attach genpds to devices from within OPP core")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/opp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2945f3c1c..56cae6ee2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2409,8 +2409,8 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 		}
 
 		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
-		if (IS_ERR(virt_dev)) {
-			ret = PTR_ERR(virt_dev);
+		if (IS_ERR_OR_NULL(virt_dev)) {
+			ret = PTR_ERR(virt_dev) ? : -ENODATA;
 			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
 			goto err;
 		}
-- 
2.20.1.windows.1



