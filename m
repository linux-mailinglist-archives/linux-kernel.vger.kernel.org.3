Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4C47CE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbhLVIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:53:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59146 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhLVIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:53:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 294D661941
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 08:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89188C36AE8;
        Wed, 22 Dec 2021 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640163199;
        bh=Q1R7fRiwdbGuIdr6wvoZSInWT8oJw2GMCIZW5Cql7bo=;
        h=From:To:Cc:Subject:Date:From;
        b=g2Zjl4f0fpd6+/6ddB8z6gGPLQRcKW7+UqScWxL+W/MRDFzAUa79zuwmLnTAB+wQ5
         iRmI0jEPsStR/vps+z0OAhpqZ4gINjDFWecZJrDv0qyZCRvtjYmfMZxIMEDnrXY2C9
         cGMdqgbMa9tZLMQcpSDgLr1D7nJjq3brcBVZtQTdYCgDn0/pZTVW/jaFDPottZ4kBk
         iBdtznEvjzVWv27QIJc+sEHGwDmi4Gs9UKWJlOjuX1XVJ+9xn12MRBeyPT9et6vzPN
         SLukSoy4YJF15SaRa1QO1zQ7ilQyjwktbsLGUI9jcCvnHOuMQYchz2YHZ/ZSX1PCPr
         5gbMOIS8ueIQw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzxN0-000335-G5; Wed, 22 Dec 2021 09:53:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] driver core: platform: document registration-failure requirement
Date:   Wed, 22 Dec 2021 09:52:29 +0100
Message-Id: <20211222085229.11657-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explicit comment to document that the reference initialised by
platform_device_register() needs to be released by a call to
platform_device_put() also when registration fails (cf.
device_register()).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 598acf93a360..38fdcbdba4a4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -762,6 +762,10 @@ EXPORT_SYMBOL_GPL(platform_device_del);
 /**
  * platform_device_register - add a platform-level device
  * @pdev: platform device we're adding
+ *
+ * NOTE: _Never_ directly free @pdev after calling this function, even if it
+ * returned an error! Always use platform_put_device() to give up the
+ * reference initialised in this function instead.
  */
 int platform_device_register(struct platform_device *pdev)
 {
-- 
2.32.0

