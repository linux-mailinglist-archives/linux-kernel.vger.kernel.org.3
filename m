Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC647D029
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbhLVKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhLVKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:42:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4693C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 02:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1780B817BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64164C36AE5;
        Wed, 22 Dec 2021 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640169757;
        bh=/bAps4iOLxjmlyohcArUrEAeqwNRo7rQxGduqp/7SAg=;
        h=From:To:Cc:Subject:Date:From;
        b=Mi3binEaOhQICoXtt2NZQopDYJa4/B9sD+Oa9d2gitjMj7nYF5ZRhsvWC9FDfpizI
         awB7T/EIcFu5xuyILOOg7fVAJJOcozyvuT/OiO7ZPR9mbJCSq41Vv0UO9GM/aDKj/8
         uINURyEMBDmBovRgdpWTTzSnlosnt0qZKnq1LbElQTfnpOppmUzmGKO0/3YZDdlmRt
         tbpj66/Gbx1Eh4rFpn6N8SqAr+KFOqEgaVTDq9cXZjhp2OzTyXqRQzLMp7745IngbS
         NDoRrHS+qruhPWjM9ZtqRsR0/3qAzF6pDcXXom5TZZhobeD1NRNCljIi+ltUSrMr5h
         ELV/0RKCHY5eQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzz4m-0001UI-Om; Wed, 22 Dec 2021 11:42:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] driver core: platform: document registration-failure requirement
Date:   Wed, 22 Dec 2021 11:42:13 +0100
Message-Id: <20211222104213.5673-1-johan@kernel.org>
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

Greg,

I took a quick look at driver code registering non-static platform
devices and only found four drivers getting this wrong.

I've fixed up two of them and of the remaining two, one media driver is
using devres (hurray!) and the other ignores registration failures
completely anyway:

	- vpif_probe()
	- sm501_register_device()

It seems to me that the right thing to do here, at least short term, is
to add a comment clarifying this behaviour and fix up the few driver
that got it wrong.

Johan


Changes in v2
 - s/platform_put_device/platform_device_put/


 drivers/base/platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 598acf93a360..5dad6edb1d55 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -762,6 +762,10 @@ EXPORT_SYMBOL_GPL(platform_device_del);
 /**
  * platform_device_register - add a platform-level device
  * @pdev: platform device we're adding
+ *
+ * NOTE: _Never_ directly free @pdev after calling this function, even if it
+ * returned an error! Always use platform_device_put() to give up the
+ * reference initialised in this function instead.
  */
 int platform_device_register(struct platform_device *pdev)
 {
-- 
2.32.0

