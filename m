Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F853DD04
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbiFEQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiFEQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:31:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1C11826
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dI3rf3edy3Kft6mBrBSiDKYbeeS3F5z2oeWA1gb5ziU=; b=PN0Bi1pmYIrCr/u2Syoq6r98BX
        nf9F8H92bvNpjQGQ/5aeGRZljvrQUaqjJF1iLsyTqwJLSLQSQ0TVDVdhP0bDtTa7etHE2qRWRZUG+
        5V1RXDFoyMD/mUcy7w5SMQhsKCXGnHXYI6Becaqpe/x1tWY0+Fc1zIOTcVQYwLvmmHFbsEnjTWpWw
        v3croie01C2H3c8BpGI9H+RmKEMsBANLlQ+33HqTGgpuyNuyYBPel0CeGRFJxi8gvCnTfdMLad6XP
        RQUFWVxnfifHTxz44Oxy1eH0Gtp3lnJMjwVPABpM0RRdfwH0p5W2ubDEVUDAWQQy2hYEpDoiFCv5G
        MPBNZ9UA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxtA1-009qFA-TT; Sun, 05 Jun 2022 16:31:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Steve Lee <steve.lee.analog@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: max98390: use linux/gpio/consumer.h to fix build
Date:   Sun,  5 Jun 2022 09:31:23 -0700
Message-Id: <20220605163123.23537-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the header file to fix build errors in max98390.c:

../sound/soc/codecs/max98390.c: In function 'max98390_i2c_probe':
../sound/soc/codecs/max98390.c:1076:22: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
 1076 |         reset_gpio = devm_gpiod_get_optional(&i2c->dev,
../sound/soc/codecs/max98390.c:1077:55: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
 1077 |                                              "reset", GPIOD_OUT_HIGH);
../sound/soc/codecs/max98390.c:1077:55: note: each undeclared identifier is reported only once for each function it appears in
../sound/soc/codecs/max98390.c:1083:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
 1083 |                 gpiod_set_value_cansleep(reset_gpio, 0);

Fixes: 397ff0249606 ("ASoC: max98390: Add reset gpio control")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Steve Lee <steve.lee.analog@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/max98390.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -10,7 +10,7 @@
 #include <linux/cdev.h>
 #include <linux/dmi.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
