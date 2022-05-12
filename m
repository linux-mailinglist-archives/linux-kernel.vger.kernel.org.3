Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2565244EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349923AbiELFal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiELFad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:30:33 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D650C2229EB;
        Wed, 11 May 2022 22:30:29 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D6E958027;
        Thu, 12 May 2022 05:26:52 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Romain Naour <romain.naour@smile.fr>
Subject: [PATCH] bus: ti-sysc: Fix warnings for unbind for serial
Date:   Thu, 12 May 2022 08:30:21 +0300
Message-Id: <20220512053021.61650-1-tony@atomide.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can get "failed to disable" clock_unprepare warnings on unbind at least
for the serial console device if the unbind is done before the device has
been idled.

As some devices are using deferred idle, we must check the status for
pending idle work to idle the device.

Cc: Romain Naour <romain.naour@smile.fr>
Fixes: 76f0f772e469 ("bus: ti-sysc: Improve handling for no-reset-on-init and no-idle-on-init")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3395,7 +3395,9 @@ static int sysc_remove(struct platform_device *pdev)
 	struct sysc *ddata = platform_get_drvdata(pdev);
 	int error;
 
-	cancel_delayed_work_sync(&ddata->idle_work);
+	/* Device can still be enabled, see deferred idle quirk in probe */
+	if (cancel_delayed_work_sync(&ddata->idle_work))
+		ti_sysc_idle(&ddata->idle_work.work);
 
 	error = pm_runtime_resume_and_get(ddata->dev);
 	if (error < 0) {
-- 
2.36.1
