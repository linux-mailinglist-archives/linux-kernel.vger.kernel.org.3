Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20D5A9D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiIAQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiIAQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:37:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4540548
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 744EDB82844
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0E5C433D6;
        Thu,  1 Sep 2022 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662050259;
        bh=hWmDmJING+9T7zsOMq3dR3oSc/Vy0IQXWEe0ccIh/Qo=;
        h=From:To:Cc:Subject:Date:From;
        b=H8f0YMRbKKllSmbL37gE5CRYwQZIa8a8p7m39evOGWW8Lfw3XgpvWh244aHY4kCJI
         nYbSgU7YqDquEtLmJzon3c8LIwX1SzRpSMET3ugAjbN/adOPczlMzBsrv6ffz8BINW
         CJ5tTqtqF+y4E/DJbtSdNz9uzuwucfMjQrHmr+EI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        stable <stable@kernel.org>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH] driver core: fix driver_set_override() issue with empty strings
Date:   Thu,  1 Sep 2022 18:37:34 +0200
Message-Id: <20220901163734.3583106-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=gregkh@linuxfoundation.org; h=from:subject; bh=hWmDmJING+9T7zsOMq3dR3oSc/Vy0IQXWEe0ccIh/Qo=; b=owGbwMvMwCRo6H6F97bub03G02pJDMkC908fXrFiPmubv/fh6GnSxSc0g4zZ/6S2NnbreVtxx5/+ blTYEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOx8mBYsHO16rwnr2v26zBfixN1Ot VYO4vrFsNcQalOP8ulr3MeP8pqujXTuEtpq6I3AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Python likes to send an empty string for some sysfs files, including the
driver_override field.  When commit 23d99baf9d72 ("PCI: Use
driver_set_override() instead of open-coding") moved the PCI core to use
the driver core function instead of hand-rolling their own handler, this
showed up as a regression from some userspace tools, like DPDK.

Fix this up by actually looking at the length of the string first
instead of trusting that userspace got it correct.

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Fixes: 23d99baf9d72 ("PCI: Use driver_set_override() instead of open-coding")
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable <stable@kernel.org>
Tested-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 15a75afe6b84..676b6275d5b5 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -63,6 +63,12 @@ int driver_set_override(struct device *dev, const char **override,
 	if (len >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
+	/*
+	 * Compute the real length of the string in case userspace sends us a
+	 * bunch of \0 characters like python likes to do.
+	 */
+	len = strlen(s);
+
 	if (!len) {
 		/* Empty string passed - clear override */
 		device_lock(dev);
-- 
2.37.3

