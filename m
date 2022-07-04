Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C5565CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiGDRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiGDRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68314C10;
        Mon,  4 Jul 2022 10:19:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j21so16827591lfe.1;
        Mon, 04 Jul 2022 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dGiAySADJtdpNfaNk5czDU+zGxujA+xtyshoy0uOj4=;
        b=YGaNspCkh42qYBUAe1smIUHSD5+/5+V/CSRBievEv11ejq8y/Kx+FIK8a8ioxJysOt
         byADy2L4kmCo8hFjfouqMXZfueVzrzo8AxTHDz/ozcgI8kxotLiKjbHXpEyH0uxP+trS
         SMWeEcjz0QmRjgai9TYZNxxzo0ouCn/JglFqrGmgsRecoKXD2fWRgHEp88bsdKl1eyye
         8DY5NjBQmUSUd5p8J+TFDa2619NewSPJJc5wGIhRsotp9IW9t1AYg3PCWaFZAyY8chVo
         yqmtBjWVk5K7Pip/ncgEygdbdkysrymC4buuqlGKMKGr8QqjFotGJLXf1I5L2joStcjX
         OrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dGiAySADJtdpNfaNk5czDU+zGxujA+xtyshoy0uOj4=;
        b=3UDQp2FNfHZW5Iy6TWIemuPb/4hsplbDOsG83xCvUJ8W5e/1j0ogG6+EZsiZ3YP2KF
         zGuuOjbk+0/024Agu7IHLbK34jBxiEpATl03dbZ7at19/NtjSFwyCIHeyLqtYdY484om
         AJLV8QOhUNZyy1KAg+vD4gJb9UJsRyvzfXpfYymF1634iRx638GhLjNiJGYLEJSDY9tM
         EJ0KkfY5+JefyAmOhyI6bEAQn8R60hKy0AR2CbtF8iPKqu+wrsKmZt7+6IBpQJfFs3gb
         4g3awul9LIfNOdw9vfKqNQG8LWRE1jGDwim9BVWZVUeQgAVopD7cE6+H04xHr+sxims8
         Z6vw==
X-Gm-Message-State: AJIora/sXSL+cFr4aW6JHVdSLxA6gtXXyk2cJhbiR7NzPJHUxx/MqC57
        aCelaALMqNcrvVLUlTX17GA=
X-Google-Smtp-Source: AGRyM1v/3+cc+tWPlvkc/x+ppkLi0CNDASgDkMsPTDG2HwoizZolD8U5wCtOVBcQStB8fSJRJn7ZMQ==
X-Received: by 2002:a05:6512:22c3:b0:47f:9396:861a with SMTP id g3-20020a05651222c300b0047f9396861amr20574581lfu.230.1656955150819;
        Mon, 04 Jul 2022 10:19:10 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:10 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] iio: adc: mcp3911: correct "microchip,device-addr" property
Date:   Mon,  4 Jul 2022 19:21:09 +0200
Message-Id: <20220704172116.195841-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704172116.195841-1-marcus.folkesson@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
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

Go for the right property name that is documented in the bindings.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f581cefb6719..f8875076ae80 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -210,7 +210,14 @@ static int mcp3911_config(struct mcp3911 *adc)
 	u32 configreg;
 	int ret;
 
-	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
+	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
+
+	/*
+	 * Fallback to "device-addr" due to historical mismatch between
+	 * dt-bindings and implementation
+	 */
+	if (ret)
+		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
 		dev_err(&adc->spi->dev,
 			"invalid device address (%i). Must be in range 0-3.\n",
-- 
2.36.1

