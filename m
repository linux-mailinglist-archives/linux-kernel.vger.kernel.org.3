Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF90F56B79C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiGHKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiGHKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129A804BD;
        Fri,  8 Jul 2022 03:42:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so813060wmb.5;
        Fri, 08 Jul 2022 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKAr7Zhr30ZOTzRFaGydt4W45eJqo7Xj+adqxcVbPC8=;
        b=TdvZUrAZ7iPBcbcGl10EzviS/QbPAoSltWfw7avU6ocFQxj3bQRPln/oObuz4CSClv
         Z40GxaaFI8/bAE75b8zxFJEitqRv6GmkBlBRkbrK18XU1o6SUeUTF+Fbd6v3X7OyQYVc
         a19Ac+946JUMIwfHpM8zxagrr1qcQGVR+s2/cudGClSAvBVtG2i6eFRhsF+9nPdMVchp
         fFgORJlPXO5wLtWV5KK4KiFReGVx7jajzCYbUN6+oFl/xZ4Ev3e/pd2sdsTByEEiqAMb
         V4LPY87V92z3VgQjA4xtMJqzFitgQZpEJedGoLjF9HyqvUlwDvC4M0lbWhkc3JhVWJiG
         tiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKAr7Zhr30ZOTzRFaGydt4W45eJqo7Xj+adqxcVbPC8=;
        b=PI7CqQSSESsQjIuC/sy41Re35umif6tZcz5kO7gsb8t3QL/Qql93DiOSisVkDJO5SB
         gHeFZYEmfwA5je1Mjkv+0ycjx3Gk07dGg/LY7iZTXldLML44tIerCjVOtOLEys2I4Lk9
         WZpP/UAUA9IP+dgG+AK537Q8GtzlVQ6gkrW2t2Ipqt61s3nZZnez2f+qfW00AcPSG31t
         UKrjp/6/mvstQWC19xgOcuZ8u2jKUzXLxj+3dl0HjqVEKJjGkQ5sjwmB38YDiKgkvEM0
         t7wwifiPubgKPWSSpVwGwLJ+WS/nnGKyFUHaCl6pTp1veGJJPRfC7A7C0a3FyR20/+st
         CG0Q==
X-Gm-Message-State: AJIora+YHt/WmXgPMGN77hxLY15Aq/Yikz9ZySfy94c3jUEknD32dfVg
        9ChPEuHtxm6sbFEkoZ7DkvOYPBCas8A=
X-Google-Smtp-Source: AGRyM1v19ynb891XDScV5Yri3l9rOzv1q/V8+qPM6QsBC6z8ho+o/Wp44msIrUBV582kJASdErSiYA==
X-Received: by 2002:a05:600c:40d5:b0:3a1:8d0f:db47 with SMTP id m21-20020a05600c40d500b003a18d0fdb47mr2964822wmh.138.1657276939110;
        Fri, 08 Jul 2022 03:42:19 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm39952053wrr.101.2022.07.08.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:18 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] ASoC: cleanups and improvements for jz4740-i2s
Date:   Fri,  8 Jul 2022 11:42:53 +0100
Message-Id: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a preparatory cleanup of the jz4740-i2s driver before
adding support for a new SoC. The last two patches lift unnecessary
restrictions on sample rates and formats -- the existing ones appear
to be derived from the limitations of the JZ4740's internal codec and
don't reflect the actual capabilities of the I2S controller.

I'm unable to test the series on any JZ47xx SoCs, but I have tested
on an X1000 (which is the SoC I'll be adding in a followup series).

Changes in v2:

* Drop two patches already in sound for-next.
* Squash two removal patches into the regmap fields patch.
* Remove the unused 'mem' resource in the driver private struct.
* Use regmap_set_bits() and regmap_clear_bits() to improve readability.
* Add fix for SoCs with independent FIFO flush bits (ie. most of them).
* Update sample formats patch with a more informative commit message.
* Add two new patches to refactor DAI/component probing.

Changes in v3:

* Fix missing 'ret' in patch 11 (yes, that was pretty silly of me)

Aidan MacDonald (11):
  ASoC: jz4740-i2s: Remove unused 'mem' resource
  ASoC: jz4740-i2s: Convert to regmap API
  ASoC: jz4740-i2s: Simplify using regmap fields
  ASoC: jz4740-i2s: Handle independent FIFO flush bits
  ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
  ASoC: jz4740-i2s: Align macro values and sort includes
  ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
  ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
  ASoC: jz4740-i2s: Support continuous sample rate
  ASoC: jz4740-i2s: Move component functions near the component driver
  ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops

 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c | 461 ++++++++++++++++++----------------
 2 files changed, 248 insertions(+), 214 deletions(-)

-- 
2.35.1

