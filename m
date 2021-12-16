Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F5F477C35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbhLPTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbhLPTIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:08:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23274C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF246B825EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680F3C36AE6;
        Thu, 16 Dec 2021 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639681693;
        bh=oOWpsJ184rFuMViMHhox1NszuJVDPjg0FtGTcJDH/l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDS3MMIBj+TIlHCaGkwC22LcMr/9DYQKI4dxyADT5pMTFUF/brJ9WjgExMF4XlGlg
         H69QJHw6QW39CU2tgC89KzHKpFPFx3HwJqSgjobsz79vaMyOXcJ3j89CXwmjntqoLT
         0vGSN+C4cgDi9d4HJa9g0TZa+eYnL0WhrfKTZx//+YlD+/Hz170Drf6e0iL7CapPvh
         AMDShrM8JqWsecmOyJd+Yz+baMmIwwyU1TKzSO3XL0YoEWVjYYVN3CxLK7Nc76G4Pz
         HB73HD9fZcbMbCkUWp44yWX+pBR40xnq6vhThhKJl4/i3YlE48/GFFvgLiVmZdtrct
         JMwfbGniRBU9w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH 1/6] spmi: pmic-arb: Add sid and address to error messages
Date:   Thu, 16 Dec 2021 11:08:07 -0800
Message-Id: <20211216190812.1574801-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211216190812.1574801-1-sboyd@kernel.org>
References: <20211216190812.1574801-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

It's useful to know what particular device/component is having trouble
accessing the bus. Add the sid and address to error messages here so
that debugging is a little simpler.

Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc: satya priya <skakit@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20210920234849.3614036-1-swboyd@chromium.org
Reviewed-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Reviewed-by: Satya Priya <skakit@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index bbbd311eda03..e397c2532c8d 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -261,20 +261,21 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 
 		if (status & PMIC_ARB_STATUS_DONE) {
 			if (status & PMIC_ARB_STATUS_DENIED) {
-				dev_err(&ctrl->dev, "%s: transaction denied (0x%x)\n",
-					__func__, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction denied (%#x)\n",
+					__func__, sid, addr, status);
 				return -EPERM;
 			}
 
 			if (status & PMIC_ARB_STATUS_FAILURE) {
-				dev_err(&ctrl->dev, "%s: transaction failed (0x%x)\n",
-					__func__, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
+					__func__, sid, addr, status);
+				WARN_ON(1);
 				return -EIO;
 			}
 
 			if (status & PMIC_ARB_STATUS_DROPPED) {
-				dev_err(&ctrl->dev, "%s: transaction dropped (0x%x)\n",
-					__func__, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction dropped (%#x)\n",
+					__func__, sid, addr, status);
 				return -EIO;
 			}
 
@@ -283,8 +284,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 		udelay(1);
 	}
 
-	dev_err(&ctrl->dev, "%s: timeout, status 0x%x\n",
-		__func__, status);
+	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
+		__func__, sid, addr, status);
 	return -ETIMEDOUT;
 }
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

