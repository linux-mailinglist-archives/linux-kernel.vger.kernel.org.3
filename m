Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0E249BE74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiAYW2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:28:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37110 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiAYW15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:27:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EF566184A;
        Tue, 25 Jan 2022 22:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7F5C340E0;
        Tue, 25 Jan 2022 22:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643149676;
        bh=21Wcgn1j9relNyi3Uz6u2QsAkpxOeBhxGiQVPqE19R4=;
        h=Date:From:To:Cc:Subject:From;
        b=Gj0nd8JJzBg2ACxpoOnKSAcoEBiYNetMzpqhFkBlB8pUui+yl2xZdzXiV5bfg2hAI
         +5U2cQKH2/DUpwIyfrjcJN1c03InGAJ1p9eHpF0s/Xr0bhM4maFEqYz0jlWHSg03cG
         VYwqPX9XEImDw0ojzIzhtfsULg80yFT5FVCsneauZoKgyXw2vJDngxmgbSyUJxZL6m
         iaKD10QhK4Ua9NCiZdZzw4dvh31PsatVTyw3Lre0S9lVL8OB2MHjq+6MqjSG8ra0iq
         n0k1NuRBz2HY0bJQ3savB8v6LJuRnFOSl8JJMXooLF+2enassriW2Q91Vvx8FtP3nW
         Q1tLdEbmK/kxw==
Date:   Tue, 25 Jan 2022 16:34:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: unisys: visorinput: Use struct_size() helper
 in kzalloc()
Message-ID: <20220125223443.GA76937@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/staging/unisys/visorinput/visorinput.c:409:27: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/unisys/visorinput/visorinput.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/unisys/visorinput/visorinput.c b/drivers/staging/unisys/visorinput/visorinput.c
index 426deab22d62..dffa71ac3cc5 100644
--- a/drivers/staging/unisys/visorinput/visorinput.c
+++ b/drivers/staging/unisys/visorinput/visorinput.c
@@ -406,7 +406,8 @@ static struct visorinput_devdata *devdata_create(struct visor_device *dev,
 	if (dtype == visorinput_keyboard)
 		/* allocate room for devdata->keycode_table, filled in below */
 		extra_bytes = KEYCODE_TABLE_BYTES * 2;
-	devdata = kzalloc(sizeof(*devdata) + extra_bytes, GFP_KERNEL);
+	devdata = kzalloc(struct_size(devdata, keycode_table, extra_bytes),
+			  GFP_KERNEL);
 	if (!devdata)
 		return NULL;
 	mutex_init(&devdata->lock_visor_dev);
-- 
2.27.0

