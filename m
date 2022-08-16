Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0B5960F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiHPRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHPRVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:21:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301B69F43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:21:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p10so13420596wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SU9HU/twTCXcJTd7ck0zrD4m7AIhxImHvNiP9mDJEbM=;
        b=t2SXXNvgfMAaScr6LFd0QGC84Wrz+OW/1lL+WKuKVWAFPKypvubFq2uZ48weDNwqT4
         BeBH9NwO8eYLwiCckD5yd+SUR5Bi5x+O2FYtPC4wvSyf7tSFD3zQEZM9RVDerALLxzT2
         4YnXIRqORbOKjReqDoFlxjUmhDt5bTitaYykQCyMS2QJ0vL+Ssc8Z0iLS6DBZJU0hmXI
         KPHhJi+po3z9feyB398g6qRRAVywnYEmwJ7a6oy44m9tHZ++073/IlFqWIsEgKjt/F9D
         jcmwqG23MCXNi+rohMzYWHxjkNZMFfDIGXPksHAk9D1VIKyiM9zf038L0l6rEZUHBRb9
         p2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SU9HU/twTCXcJTd7ck0zrD4m7AIhxImHvNiP9mDJEbM=;
        b=qSxxrmS1fHHwRnwL8gWMB1UQYdYoj5aAbSinVKCfCNN10AjaxIsaCeNbKzRx7YDqpp
         sPHstsYYnva0sSTmgtnzvs7DXaglwRIvXZ6MPVt8um0vfCrVIJcINZdCgtSAPL4/I9aJ
         7DrI0Uq73xqAqfeaUb1RqRDsryU9XBZHb4SRljn4yXiZmXqANdGDxJ45j4goz83n8wD2
         HAsRTPqoetjDt1nMGWVdHksUtzCPkAA3BQx/KK9GlaICA4wj68NR0SJMocRBBMMhy5oV
         SkK0GlZQ5sXQ3rO1j5oEU4i9CkxZHl9lf+ys060fsvoNWaxoylupvI5PTlIMy20Wfe4X
         ISHg==
X-Gm-Message-State: ACgBeo0qVkqtj7d/RhxZNULgIqIK9vTaKwTUE3L4BLZKOssR4gxQJKc/
        cpjADU0mz5Hj7UaN47JhDjvdtw==
X-Google-Smtp-Source: AA6agR7qe+cUlpj7gPKezUg2A7pZJcTZrYSFfZWR8+V03GMxZynO/3Qn8X+hHQbowZ8nCwqlampIow==
X-Received: by 2002:a5d:6690:0:b0:21f:fa6:2962 with SMTP id l16-20020a5d6690000000b0021f0fa62962mr13211810wru.358.1660670492492;
        Tue, 16 Aug 2022 10:21:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003a5f812635asm2326190wms.39.2022.08.16.10.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:21:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: core: remove setting platform_max in kcontrol macros
Date:   Tue, 16 Aug 2022 18:21:29 +0100
Message-Id: <20220816172129.6661-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_max should not be set by the driver, its intended for machine drivers
or DT to override the max value for platform specific reasons.

So remove setting this from Kcontrol macros.

Setting this to max in these macros would limit the range when min
value is less then zero.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

This patch is result of disussion at https://www.spinics.net/lists/alsa-devel/msg146134.html

 include/sound/soc.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index aad24a1d3276..4351d86eedf6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -31,31 +31,31 @@
 #define SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, xmax, xinvert, xautodisable) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
-	.rshift = shift_right, .max = xmax, .platform_max = xmax, \
+	.rshift = shift_right, .max = xmax, \
 	.invert = xinvert, .autodisable = xautodisable})
 #define SOC_DOUBLE_S_VALUE(xreg, shift_left, shift_right, xmin, xmax, xsign_bit, xinvert, xautodisable) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
-	.rshift = shift_right, .min = xmin, .max = xmax, .platform_max = xmax, \
+	.rshift = shift_right, .min = xmin, .max = xmax, \
 	.sign_bit = xsign_bit, .invert = xinvert, .autodisable = xautodisable})
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, xautodisable) \
 	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert, xautodisable)
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .max = xmax, .platform_max = xmax, .invert = xinvert})
+	{.reg = xreg, .max = xmax, .invert = xinvert})
 #define SOC_DOUBLE_R_VALUE(xlreg, xrreg, xshift, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
-	.max = xmax, .platform_max = xmax, .invert = xinvert})
+	.max = xmax, .invert = xinvert})
 #define SOC_DOUBLE_R_S_VALUE(xlreg, xrreg, xshift, xmin, xmax, xsign_bit, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
-	.max = xmax, .min = xmin, .platform_max = xmax, .sign_bit = xsign_bit, \
+	.max = xmax, .min = xmin, .sign_bit = xsign_bit, \
 	.invert = xinvert})
 #define SOC_DOUBLE_R_RANGE_VALUE(xlreg, xrreg, xshift, xmin, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
-	.min = xmin, .max = xmax, .platform_max = xmax, .invert = xinvert})
+	.min = xmin, .max = xmax, .invert = xinvert})
 #define SOC_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
@@ -68,7 +68,7 @@
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .rreg = xreg, .shift = xshift, \
 		 .rshift = xshift,  .min = xmin, .max = xmax, \
-		 .platform_max = xmax, .invert = xinvert} }
+		 .invert = xinvert} }
 #define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -99,7 +99,7 @@
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .rreg = xreg, .shift = xshift, \
 		 .rshift = xshift, .min = xmin, .max = xmax, \
-		 .platform_max = xmax, .invert = xinvert} }
+		 .invert = xinvert} }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
@@ -199,7 +199,7 @@
 	.put = snd_soc_put_volsw, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .rreg = xreg,  \
-	 .min = xmin, .max = xmax, .platform_max = xmax, \
+	 .min = xmin, .max = xmax, \
 	.sign_bit = 7,} }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -273,7 +273,7 @@
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .rreg = xreg, .shift = xshift, \
 		 .rshift = xshift, .min = xmin, .max = xmax, \
-		 .platform_max = xmax, .invert = xinvert} }
+		 .invert = xinvert} }
 #define SOC_DOUBLE_EXT_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-- 
2.21.0

