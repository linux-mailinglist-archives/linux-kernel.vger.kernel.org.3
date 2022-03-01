Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334334C8A50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiCALL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiCALLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:11:23 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE3357492
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:10:40 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d19a:1d86:8408:fe96])
        by laurent.telenet-ops.be with bizsmtp
        id 0zAd2704K2dyv6m01zAdTt; Tue, 01 Mar 2022 12:10:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nP0Or-002KSx-BH; Tue, 01 Mar 2022 12:10:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nP0Oq-006QpQ-Kp; Tue, 01 Mar 2022 12:10:36 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] base: soc: Make soc_device_match() simpler and easier to read
Date:   Tue,  1 Mar 2022 12:10:35 +0100
Message-Id: <9f9107c06f7d065ae6581e5290ef5d72f7298fd1.1646132835.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function soc_device_match() is difficult to read for various
reasons:
  - There are two loop conditions using different styles: "while (...)"
    (which is BTW always true) vs. "if ... break",
  - The are two return condition using different logic: "if ... return
    foo" vs. "if ... else return bar".

Make the code easier to read by:
  1. Removing the always-true "!ret" loop condition, and dropping the
     now unneeded pre-initialization of "ret",
  2. Converting "if ... break" to a proper "while (...)" loop condition,
  3. Inverting the logic of the second return condition.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/soc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 0af5363a582c36dd..22130b5f789d9d7e 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -241,15 +241,13 @@ static int soc_device_match_one(struct device *dev, void *arg)
 const struct soc_device_attribute *soc_device_match(
 	const struct soc_device_attribute *matches)
 {
-	int ret = 0;
+	int ret;
 
 	if (!matches)
 		return NULL;
 
-	while (!ret) {
-		if (!(matches->machine || matches->family ||
-		      matches->revision || matches->soc_id))
-			break;
+	while (matches->machine || matches->family || matches->revision ||
+	       matches->soc_id) {
 		ret = bus_for_each_dev(&soc_bus_type, NULL, (void *)matches,
 				       soc_device_match_one);
 		if (ret < 0 && early_soc_dev_attr)
@@ -257,10 +255,10 @@ const struct soc_device_attribute *soc_device_match(
 						    matches);
 		if (ret < 0)
 			return NULL;
-		if (!ret)
-			matches++;
-		else
+		if (ret)
 			return matches;
+
+		matches++;
 	}
 	return NULL;
 }
-- 
2.25.1

