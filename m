Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E770453EC24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiFFOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiFFOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:15:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F92D1C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:15:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k4so3814611qth.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wh/GNYrTUWQwS2LY1J4/sKG7u3eGX16BxrYgrkihQrQ=;
        b=QlWo3+198cSiHHs+hq+/W8YxainPD4zxjEMFT1ARc2tIYSNGvNt3Czp56VcDcE7xXE
         Mg9hV9nupxeWMeN8L15uWBA49GKTqKuODxtAKZ8ls1sWXnw8gRfOijNfjGpikRw3zFG3
         OtO3GEyuWJRJ0OZow3PTL5Icch4gcYIgkS7kagTPOxjkzm/c7tf++I7UrCKi0gxztNHd
         uxToyHm2I2Olw6nL38SZkEMvRxaaWq9rxJkAQy29RlTRhsk9DKxdQI1YNqLC7tyxm8v2
         9C3aQ3mf0EJr/U32mY9jmhbAWIEISh09sGC7+4Aso3hgirf3UcNkpZtUfttrrVvDyclv
         hZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wh/GNYrTUWQwS2LY1J4/sKG7u3eGX16BxrYgrkihQrQ=;
        b=y1K93ksi2yoFwZbGWfZSyi+vftEhyvg9OL8JstMkX84B1E7MSaCAXsfhL4IivRqBKs
         fHA2nT+iJuVfwbIgt0h1fjaFLETRMKkYYKXiY6bA+gUulPYivR1BEN1MIm7EtpOh2fKm
         /tl9OTGlDbZSJ17h0ntae8K/A97GRW10lza/TK5zibivKoLvqbTNveJiwJQmSP9CsEx2
         S47GtPQiW2ZRO0W7YrH/GXE4/8ONjX6ziEF49gmFMBP4WZEVB12w/4s3MNl51XCMUwkl
         yFRnVZYJI9FmXEBDdghrmaEfNiTZc1+CqawzGFpgm2j9HTTJwxpPhkMCjuvxjHeJiQdd
         Iepg==
X-Gm-Message-State: AOAM531pHexa9+cmI5C6IGIIMIveGI9CD5Q2HguEDeOYU9LIu3O9siBE
        YScNNr+YhnhAYluDFhogmpxiVg==
X-Google-Smtp-Source: ABdhPJxQRDEeEokM9Fo2uYlhzVajgwwVOYqYmd5G8pZo9R7X+FPuurNmOePJdMhP9bv+SVtjr62Ymw==
X-Received: by 2002:ac8:4e54:0:b0:304:bf64:1356 with SMTP id e20-20020ac84e54000000b00304bf641356mr18126504qtw.547.1654524929070;
        Mon, 06 Jun 2022 07:15:29 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c15-20020a05620a268f00b006a3af1bd183sm10335086qkp.127.2022.06.06.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:15:28 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/2] iio: dac: cio-dac: Implement and utilize register structures
Date:   Mon,  6 Jun 2022 10:15:18 -0400
Message-Id: <44aec703753f930cceff448babd1c8e2959eebb0.1654118389.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654118389.git.william.gray@linaro.org>
References: <cover.1654118389.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/dac/cio-dac.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 8080984dcb03..7860450ceaf3 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -16,6 +16,7 @@
 #include <linux/isa.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/types.h>
 
 #define CIO_DAC_NUM_CHAN 16
 
@@ -34,14 +35,22 @@ static unsigned int num_cio_dac;
 module_param_hw_array(base, uint, ioport, &num_cio_dac, 0);
 MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
 
+/**
+ * struct cio_dac_reg - device register structure
+ * @da:	D/A data
+ */
+struct cio_dac_reg {
+	u16 da[CIO_DAC_NUM_CHAN];
+};
+
 /**
  * struct cio_dac_iio - IIO device private data structure
  * @chan_out_states:	channels' output states
- * @base:		base port address of the IIO device
+ * @reg:		I/O address offset for the device registers
  */
 struct cio_dac_iio {
 	int chan_out_states[CIO_DAC_NUM_CHAN];
-	void __iomem *base;
+	struct cio_dac_reg __iomem *reg;
 };
 
 static int cio_dac_read_raw(struct iio_dev *indio_dev,
@@ -61,7 +70,6 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
 	struct cio_dac_iio *const priv = iio_priv(indio_dev);
-	const unsigned int chan_addr_offset = 2 * chan->channel;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
@@ -71,7 +79,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	priv->chan_out_states[chan->channel] = val;
-	iowrite16(val, priv->base + chan_addr_offset);
+	iowrite16(val, priv->reg->da + chan->channel);
 
 	return 0;
 }
@@ -106,8 +114,8 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 	}
 
 	priv = iio_priv(indio_dev);
-	priv->base = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
-	if (!priv->base)
+	priv->reg = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
+	if (!priv->reg)
 		return -ENOMEM;
 
 	indio_dev->info = &cio_dac_info;
@@ -117,8 +125,8 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 
 	/* initialize DAC outputs to 0V */
-	for (i = 0; i < 32; i += 2)
-		iowrite16(0, priv->base + i);
+	for (i = 0; i < CIO_DAC_NUM_CHAN; i++)
+		iowrite16(0, priv->reg->da + i);
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.36.1

