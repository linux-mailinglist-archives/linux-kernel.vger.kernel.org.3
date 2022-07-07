Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBC56AE72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiGGWa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbiGGWaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:30:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53E65D6C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:30:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id p17so2272788qkj.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0huPK9KiXPSzKRvofQEoWP6lAVCb1L8ZpIn1irvpaA=;
        b=cuxEEJ9uKCVcmMW3kl6SLihJr0SFCrAjwla+Uo7x/U6u4p2J4VifxF77scHlGYxtwe
         YX8xIFRq2GzFoBdqMlsQF7B+dziAliLavNwWDCwtTb6RzbH907henIcTA/PnmNBUx5y/
         1dJHPcHhiwhQAEsTi7kArqc+eSYEeuTxJp4Hr4SsDQDapNBIEX6jEH0xnEdtB1mkvIap
         b++lnisujfJnPTTlMTIZN/QMl/Zgx32wkaWLCGFTq8aRY66PQ9Pqd7HbX9JwzNXssU7j
         yNQS5ioDNo5UAZ+9yQl8ejQc/ON0rf8WZu97d9ZdEiueUQHr1k8Bk1JxWP7BeAjlo0ix
         MW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0huPK9KiXPSzKRvofQEoWP6lAVCb1L8ZpIn1irvpaA=;
        b=XRsu1u0lgfeSKHzObwOuEbywtxFsb+Gl4ZoyPsGgPmtDOQlgMHOZH5dF+fqr0mWdlK
         UVUvwbnBNmvDYRkH7snjgywoRElFQ9oRqM38kqNb3RbgHEWlRQpn0eLQ/bb0m8G+5Y6u
         AGF3sWFuUYx5z74OF34gNOrbFAP5g3NNfeX57MaLkPPy7lZfxr2E7Rr0qT3HtGA12KSv
         kytb6bAlqz7mdlshTJV6ZSL2YzR7f6k+Veb6IOmrGjJ3QVZoJZr0nwGEPHeT/aNdS+WG
         999W2Cv5NaUczElSVx+V7rdfvlj1zv2pqeuoLEQXZ27gQIUc4p+znM+wXD3yQeXirfDq
         iQSw==
X-Gm-Message-State: AJIora/DLJyOry1/ipq3/OY2A2k46qQ69IOpEUBX2ZK5kQV7J+FQ0MKI
        45L19zGFbYCoFupNVHbFKqWZXw==
X-Google-Smtp-Source: AGRyM1vFVx06LAXB2Ym9DnYEKLlpHi2LYmNjtiQMQgryzVtfSwj0E1SRl7ximirhjWgsXPF1NidtrA==
X-Received: by 2002:a05:620a:2907:b0:6b1:17a5:a326 with SMTP id m7-20020a05620a290700b006b117a5a326mr180249qkp.373.1657233021636;
        Thu, 07 Jul 2022 15:30:21 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e22-20020ac84b56000000b0031e9bd3586esm1527747qts.79.2022.07.07.15.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:30:21 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 2/2] iio: dac: cio-dac: Cleanup indexing for DAC writes
Date:   Thu,  7 Jul 2022 13:21:25 -0400
Message-Id: <d9dab6696af7eabb2d46f5cbc7871329f499c1c9.1657213745.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657213745.git.william.gray@linaro.org>
References: <cover.1657213745.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify DAC write code by defining base member as u16 __iomem *; DAC
registers are 16-bit so this allows us to index each DAC channel
directly in a loop rather than calculating the offsets by multipling by
2 each time.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/dac/cio-dac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 8080984dcb03..791dd999cf29 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -16,6 +16,7 @@
 #include <linux/isa.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/types.h>
 
 #define CIO_DAC_NUM_CHAN 16
 
@@ -37,11 +38,11 @@ MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
 /**
  * struct cio_dac_iio - IIO device private data structure
  * @chan_out_states:	channels' output states
- * @base:		base port address of the IIO device
+ * @base:		base memory address of the DAC device
  */
 struct cio_dac_iio {
 	int chan_out_states[CIO_DAC_NUM_CHAN];
-	void __iomem *base;
+	u16 __iomem *base;
 };
 
 static int cio_dac_read_raw(struct iio_dev *indio_dev,
@@ -61,7 +62,6 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
 	struct cio_dac_iio *const priv = iio_priv(indio_dev);
-	const unsigned int chan_addr_offset = 2 * chan->channel;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
@@ -71,7 +71,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	priv->chan_out_states[chan->channel] = val;
-	iowrite16(val, priv->base + chan_addr_offset);
+	iowrite16(val, priv->base + chan->channel);
 
 	return 0;
 }
@@ -117,7 +117,7 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 
 	/* initialize DAC outputs to 0V */
-	for (i = 0; i < 32; i += 2)
+	for (i = 0; i < CIO_DAC_NUM_CHAN; i++)
 		iowrite16(0, priv->base + i);
 
 	return devm_iio_device_register(dev, indio_dev);
-- 
2.36.1

