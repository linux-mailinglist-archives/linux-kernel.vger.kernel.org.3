Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B625AA5B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiIBCX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiIBCXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:23:02 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 19:22:12 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47128AD9A7;
        Thu,  1 Sep 2022 19:22:11 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 2E0BE10029E5D;
        Fri,  2 Sep 2022 04:15:54 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C678D60EB3DC;
        Fri,  2 Sep 2022 04:15:53 +0200 (CEST)
X-Mailbox-Line: From a6030c5943ccd2965261a92320b1ae1adb909116 Mon Sep 17 00:00:00 2001
Message-Id: <a6030c5943ccd2965261a92320b1ae1adb909116.1662084833.git.lukas@wunner.de>
In-Reply-To: <202209020412.Ts31BZrs-lkp@intel.com>
References: <202209020412.Ts31BZrs-lkp@intel.com>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 2 Sep 2022 04:15:55 +0200
Subject: [PATCH] ACPI / property: Silence missing-declarations warning in
 apple.c
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence an annoying message emitted for W=1 builds:

drivers/acpi/x86/apple.c:30:6: warning: no previous declaration for 'acpi_extract_apple_properties' [-Wmissing-declarations]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/x86/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
index c285c91a5e9c..8812ecd03d55 100644
--- a/drivers/acpi/x86/apple.c
+++ b/drivers/acpi/x86/apple.c
@@ -8,6 +8,7 @@
 #include <linux/bitmap.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/uuid.h>
+#include "../internal.h"
 
 /* Apple _DSM device properties GUID */
 static const guid_t apple_prp_guid =
-- 
2.36.1

