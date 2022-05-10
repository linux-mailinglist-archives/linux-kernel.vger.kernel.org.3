Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7411652128F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbiEJKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiEJKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:51:05 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F483467B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:47:08 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 53ED91B7;
        Tue, 10 May 2022 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1652179627;
        bh=Gx4ds1ilIp/aF38ehzLhnSrlsu9Qp/XZEbsutGChFng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o40hQ1XlPrRYkp6cWQJTIZV2ofLmA0EXUPnKG3CEirNxXxy1B4zGXPtypDpY8Dpk1
         QqJqUcbLoMdN09+jqmPcJ5TjzhGq05trbGUfM275t1kqggXYwl91jjGgnPlYpyiJpe
         3VliwuRbdGV+Ah3BRRKVsmwhbjvHQFzP+EqAo6Wk=
Date:   Tue, 10 May 2022 03:47:06 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <YnpCqh9+koMal9sD@hatter.bewilderbeest.net>
References: <20220510201104.06eead74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510201104.06eead74@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 03:11:04AM PDT, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hwmon-staging tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
> 
> WARNING: unmet direct dependencies detected for SENSORS_NCT6775
>   Depends on [n]: HWMON [=y] && !PPC [=y] && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
>   Selected by [y]:
>   - SENSORS_NCT6775_I2C [=y] && HWMON [=y] && I2C [=y]
> 
> Probably introduced by commit
> 
>   58f1d9ebfce6 ("hwmon: (nct6775) Add i2c driver")
> 

Ah -- yes, thanks.  The Kconfig symbols in that patch series underwent 
some changes between revisions during review and I missed a couple of 
places that should have been updated.  I believe the patch below should 
fix it.

Thanks,
Zev


From 817067c631ca7c7537be4bd18b0c9b5d2b735e54 Mon Sep 17 00:00:00 2001
From: Zev Weiss <zev@bewilderbeest.net>
Date: Tue, 10 May 2022 03:22:20 -0700
Subject: [PATCH] hwmon: (nct6775) Fix Kconfig references in
 SENSORS_NCT6775_I2C

In the process of renaming some Kconfig symbols during the review
process a couple of updates got omitted.  Make the i2c driver select
the correct dependency (the core module, not the platform driver), and
refer to the intended symbol for the platform driver in its help text.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index fe49dccf16bf..590d3d550acb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1506,7 +1506,7 @@ config SENSORS_NCT6775_I2C
 	tristate "I2C driver for Nuvoton NCT6775F and compatibles"
 	depends on I2C
 	select REGMAP_I2C
-	select SENSORS_NCT6775
+	select SENSORS_NCT6775_CORE
 	help
 	  If you say yes here you get support for the hardware monitoring
 	  functionality of the Nuvoton NCT6106D, NCT6775F, NCT6776F, NCT6779D,
@@ -1514,7 +1514,7 @@ config SENSORS_NCT6775_I2C
 	  Super-I/O chips via their I2C interface.
 
 	  If you're not building a kernel for a BMC, this is probably
-	  not the driver you want (see CONFIG_SENSORS_NCT6775_PLATFORM).
+	  not the driver you want (see CONFIG_SENSORS_NCT6775).
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nct6775-i2c.
-- 
2.36.0

