Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA79A4A2CB4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbiA2IDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiA2IDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:03:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C2C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uT8PyTIhejTjbbxtqjsIo808PdBg2dLwdd29VGRzAk4=; b=LFwa8TFsszhEAAhe0wcrUQiRVZ
        WwP4zLHtzc9ZPhArmTQx343d2kHR2Hm49YL8poC1hNrn5yQptvRVXvh7iDrwtHdw+YclV1nXqU1gO
        e6XPeTzNqsWugT4Y/l3E8Op+DJE74a02V99pMOIYw+JooCjKighkvzxDmc7HzwXVZI2h4Ty7UzkE0
        BTyDEj7Ux8a14DeU2WjB7K+5sCqK7OOxMPHeYWZ4zJLLVHO7go3eYhmD1PljGNBUbWz8t6ybrmg7D
        dR8sYzFd43eEQDVGYL/B4NGQwfqdV+CMieRhCyrBVgPkeGX4l3dXpuzEEnjKF3MpUUk307YsS1N2r
        nrnTPTNQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDihK-004Inr-1C; Sat, 29 Jan 2022 08:03:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: max98927: add missing header file
Date:   Sat, 29 Jan 2022 00:02:59 -0800
Message-Id: <20220129080259.19964-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header file that provides the missing function prototypes
and macro to fix these build errors (seen on arch/alpha/):

../sound/soc/codecs/max98927.c: In function 'max98927_i2c_probe':
../sound/soc/codecs/max98927.c:902:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
  902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
      |                   ^~~~~~~~~~~~~~~~~~~~~~~
../sound/soc/codecs/max98927.c:902:63: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
  902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
      |                                                               ^~~~~~~~~~~~~~
../sound/soc/codecs/max98927.c:909:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
  909 |                 gpiod_set_value_cansleep(max98927->reset_gpio, 0);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 4d67dc1998f1 ("ASoC: max98927: Handle reset gpio when probing i2c")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Alejandro Tafalla <atafalla@dnyon.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/max98927.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220128.orig/sound/soc/codecs/max98927.c
+++ linux-next-20220128/sound/soc/codecs/max98927.c
@@ -16,6 +16,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98927.h"
