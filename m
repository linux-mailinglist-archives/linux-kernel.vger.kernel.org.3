Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCCF57C8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiGUKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiGUKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:24:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C075631DF4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:24:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e15so1588733edj.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnjcUJZ0kP3zLVkI00AAytAat4+SP0QD4gn/D4v+BD0=;
        b=EM1FkaouTqByZK/MLu7Gh8P+yVBOtMGiUCl9XnlpiY9BYdL9D17dk4fgt7jHA689FC
         8hVvNiHElxWiFBkrxZzxr9j9Ew6eqS1+dnIVwKz0ZfUMsxbTtRFLKO4oJJT9TRHHQFEd
         U8woqsMio5/pgULp2gqs1Fx+AdA1lIY/XpheRDCa6QoYQu3xSnTLtnGz8PV2o4hidVLK
         15fQsJNR4BB9Xclu74BJfA6J3sUeLwss1SNkEbwhx5CxxC6nogpBzn0wJzt4leORq0lX
         4/QL69AQXYk2QIDCZnxx37rnItIvp1T+jnQSFfgFc8if27fyjzxa/1pO/7jqjxsdjn6j
         vFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnjcUJZ0kP3zLVkI00AAytAat4+SP0QD4gn/D4v+BD0=;
        b=iBNo2K3QFQvX2M2Oz5MdOF7/AvDxiIUaFuu6qlom8kReNeEL/zahLhR36v05/BrWVD
         8mhSrmRWHJrVlycKkNKK+uJBI06xyV+GxPtrbhm6ziD/GpFzRDXB9ozuYUOszHv1+sua
         0DzQMb6le7z842lDBlUtnVEdVMFXDU9ZO++l+qGvFZ3XbYWx8EYiw3HjvXGZiEL6gwGI
         VqRQQdz3J3XCL1kv8efSGc63s1Qizze4XjQ3LVnP0OUDU8Ollbz05LbfBQFMPZAVC5zT
         VQwWwGUuaWGJADSBnVFsRyEFYpTgRhrkQozlyLZkhbF7OqHVdIsLAqCmLUPQtg3jLdU+
         jhKA==
X-Gm-Message-State: AJIora8Cb0zE72E5+YeRFIrXa0JFsxwEK3U971ftM6M3vrNc0dEYhVVR
        tfkYMShp7npPTNuHdMjreww=
X-Google-Smtp-Source: AGRyM1sjm77tFldslhTTtKG6r/nB5ftOMbBvPBn0I5SNviJAxfO6zmsuOVFu8GtH/lDpkb2LWoMdlg==
X-Received: by 2002:a05:6402:11c9:b0:43b:b905:cb88 with SMTP id j9-20020a05640211c900b0043bb905cb88mr8429851edw.102.1658399092334;
        Thu, 21 Jul 2022 03:24:52 -0700 (PDT)
Received: from localhost (92.40.202.7.threembb.co.uk. [92.40.202.7])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b0072aa1313f5csm652000ejb.201.2022.07.21.03.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:24:51 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 1/2] sound: soc: codecs: wcd9335: Convert irq chip to config regs
Date:   Thu, 21 Jul 2022 11:25:57 +0100
Message-Id: <20220721102558.25457-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
References: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type registers in regmap-irq have been deprecated in favor of config
registers, which are more general. Chips using type_base can switch
over to a single config base register and a standard ->set_irq_type()
callback provided by regmap-irq, which uses the type info associated
with each 'struct regmap_irq' to update type registers in the same
way as the old code did.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 3cb7a3eab8c7..81678c85ff7b 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5031,16 +5031,22 @@ static const struct regmap_irq wcd9335_codec_irqs[] = {
 	},
 };
 
+static const unsigned int wcd9335_config_regs[] = {
+	WCD9335_INTR_LEVEL0,
+};
+
 static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
 	.name = "wcd9335_pin1_irq",
 	.status_base = WCD9335_INTR_PIN1_STATUS0,
 	.mask_base = WCD9335_INTR_PIN1_MASK0,
 	.ack_base = WCD9335_INTR_PIN1_CLEAR0,
-	.type_base = WCD9335_INTR_LEVEL0,
-	.num_type_reg = 4,
 	.num_regs = 4,
 	.irqs = wcd9335_codec_irqs,
 	.num_irqs = ARRAY_SIZE(wcd9335_codec_irqs),
+	.config_base = wcd9335_config_regs,
+	.num_config_bases = ARRAY_SIZE(wcd9335_config_regs),
+	.num_config_regs = 4,
+	.set_type_config = regmap_irq_set_type_config_simple,
 };
 
 static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
-- 
2.35.1

