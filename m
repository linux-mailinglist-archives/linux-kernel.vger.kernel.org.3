Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE7584E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiG2JgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiG2JgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:36:00 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17D558B6B;
        Fri, 29 Jul 2022 02:35:56 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oHMP5-005nJz-LG; Fri, 29 Jul 2022 19:35:33 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Jul 2022 17:35:31 +0800
Date:   Fri, 29 Jul 2022 17:35:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: qcom-rng - Fix qcom_rng_of_match unused warning
Message-ID: <YuOp49dCARTVQ+c+@gondor.apana.org.au>
References: <202207240830.NxaVYPVM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207240830.NxaVYPVM-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 08:12:39AM +0800, kernel test robot wrote:
>
> >> drivers/crypto/qcom-rng.c:190:34: warning: 'qcom_rng_of_match' defined but not used [-Wunused-const-variable=]
>      190 | static const struct of_device_id qcom_rng_of_match[] = {
>          |                                  ^~~~~~~~~~~~~~~~~

---8<---
Module device tables need to be declared as maybe_unused because
they will be unused when built-in and the corresponding option is
also disabled.

This patch adds the maybe_unused attributes to OF and ACPI.  This
also allows us to remove the ifdef around the ACPI data structure.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 031b5f701a0a..72dd1a4ebac4 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -9,6 +9,7 @@
 #include <linux/crypto.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -201,15 +202,13 @@ static int qcom_rng_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
-static const struct acpi_device_id qcom_rng_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 	{ .id = "QCOM8160", .driver_data = 1 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
-#endif
 
-static const struct of_device_id qcom_rng_of_match[] = {
+static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
 	{ .compatible = "qcom,prng", .data = (void *)0},
 	{ .compatible = "qcom,prng-ee", .data = (void *)1},
 	{}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
