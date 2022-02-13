Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BEF4B3919
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiBMC6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:58:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiBMC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:58:02 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61A60A85;
        Sat, 12 Feb 2022 18:57:54 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y8so12556146qtn.8;
        Sat, 12 Feb 2022 18:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2LN3zUyRyqP9/9t5yNh3Y930skR3pEag7TQgwhm6Iw=;
        b=ZUz4uSa3DBQiK/dvEeGdgINAhPEaGSYVrSWbQ/Z82VzrfGItsnfWGO5O/DUP5gIKRN
         Z0Jm7bRazuODeTmf4+PMV6alGXdP11aPaCk2Ouo04FYdqm9GX3mniycZ3Iu/bo/8i9Gp
         v5GTZlGTXRmR3Ta40nWnRpae0D3X3Ed9+gSUH+ouFW618wSOUh+igYrBDh9j7Qs+lneN
         F3fJ8ily3RiKYkABj7DZB+iuSLr4kmbh3CsiBNCAnkwDmv0oNM4jwKbeiRqyz1dn5ucm
         K1xl2eLqO15UGRQonDBodRmj9cRUEYraxeldm9brkQ5P6GqHFZ/5S14EED+ph9Oq/vGq
         g2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2LN3zUyRyqP9/9t5yNh3Y930skR3pEag7TQgwhm6Iw=;
        b=a6OcaETvdmADE65xzwwCNSZOMDL0iUsf5K4Go5V9LC2MsGRViDw9dS8E4xKO3jR4pL
         177C8QYOPuAtKs85ILKab5nbN3r+BBnj9Hr1CwvCJMlkkala0dBuB74u/ZT2ztU+dSir
         J5UgpyA2WO5oP9N2Fj26B/21JHb0okOv1D5bb1q5gApi8jDaJAwgBi6QcaYGGXJE9rj1
         352+DH0bAF7dpWLsnRGLHbA966r6HLbTT+swHsMMUfaYfPPwPiW7pyiM1DNBGXUYW4Gf
         SbUT4KjWTPc7gz566o0lioCtUQgu40xDl+3KFayyfqupAX3U1PGDU2PfQ3BND+gkefNy
         B4ZA==
X-Gm-Message-State: AOAM533EMZPe9ONk102GKSeTv9kV2HahW9q1BZaQsN/feJsnm0jK8VKv
        EjD9KaTkuVUQWpeLBd1tWCg6fkzA8fw=
X-Google-Smtp-Source: ABdhPJwSYZoqkdp3JcVSX562dahG9a3fley7kPvah6OZ4kWvWCkbooQhvLc7MTrXQqdSN7Pk8uapJA==
X-Received: by 2002:ac8:74cc:: with SMTP id j12mr5686415qtr.374.1644721073064;
        Sat, 12 Feb 2022 18:57:53 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:52 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 08/10] iio: afe: rescale: add temperature transducers
Date:   Sat, 12 Feb 2022 21:57:37 -0500
Message-Id: <20220213025739.2561834-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220213025739.2561834-1-liambeguin@gmail.com>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A temperature transducer is a device that converts a thermal quantity
into any other physical quantity. This patch adds support for
temperature to voltage (like the LTC2997) and temperature to current
(like the AD590) linear transducers.
In both cases these are assumed to be connected to a voltage ADC.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e31a93435536..7e511293d6d1 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -435,11 +435,37 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_transducer_props(struct device *dev,
+					 struct rescale *rescale)
+{
+	s32 offset = 0;
+	s32 sense = 1;
+	s32 alpha;
+	int ret;
+
+	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
+	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
+		return ret;
+	}
+
+	rescale->numerator = 1000000;
+	rescale->denominator = alpha * sense;
+
+	rescale->offset = div_s64((s64)offset * rescale->denominator,
+				  rescale->numerator);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 	TEMP_SENSE_RTD,
+	TEMP_TRANSDUCER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -459,6 +485,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -470,6 +500,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
 	{ .compatible = "temperature-sense-rtd",
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-transducer",
+	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.35.1.4.g5d01301f2b86

