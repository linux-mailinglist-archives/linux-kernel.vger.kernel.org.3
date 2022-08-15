Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA96592962
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbiHOGML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiHOGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:11:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943CB18E08;
        Sun, 14 Aug 2022 23:11:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so9368100lfm.12;
        Sun, 14 Aug 2022 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FbGrIGAHhJp/faYmz82qs7Q5FS2VF0GR2GJ1cl1M5UM=;
        b=D1+OfmD5GO0fpiE6Lg9OK7DkGEUiFx3zRisIdjz+INm0JGQTec0sZw8GmX2TmQtqeU
         /RdjvlmAV2HoCAcHvKspftXHohupEZUp6R16QV3zixbcWO6NWDshzUIYO2MQzVVwVbQp
         19E3HH8bAWFqNOMccDRkeURejCYMTRGrvxy/4ToYckCdL2s7D/YvK7BvPMqZ6FtdQpu6
         EqosJZ3UIK0NlqbA+bmH1EB02h+3qHkFcDUgjoLe6gqmHolqivuIjZCa9K+QrPc+koVa
         vvYvpb3fDiN6icLjwkQviNFSXG4VNGQ6hSv7RbHySkH7mMDBqelmMhQLo/DmXi1K+WxU
         xyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FbGrIGAHhJp/faYmz82qs7Q5FS2VF0GR2GJ1cl1M5UM=;
        b=l6zPFElmyvYelXdzsfPpVMqXqs6YL+ltyd5k1fu8/JpSFGkL+hcP3jacQf44Kbs5ak
         ywGcBkFB0/yA4DiSpXuBqmJcqtEvVqtA9eglq8ZXU1Z7hEbwZ611+eyM0lptOf1/CruD
         U5Kf9BqkxetTp1So8Gb4DnlQreZ+8ppnX2iItGZO8WLFoTkXXtNiyXNwEsU012UhAgUN
         m1TLUNFyO8ra5Wu7tRSi1R8yebun963Ycw5VdPbyJ6KCLRfGK19rGq7/GgoOfDUUpL6+
         9gR0faJVFWq4up1+r7n8QidvNzKHqDRDjqg5+vm7wiBo4JLuz/hnUZdbRRr+a+SmjuVr
         0pEA==
X-Gm-Message-State: ACgBeo20qgbL5W+Z0nMnDdcmEu2u0QPsBp9AAFnZhIjSnV7Sb/uvAMr4
        Qn6CDNEuOTWmG6YpmcjAzio=
X-Google-Smtp-Source: AA6agR7twZGn5lbQI9YIb5xA2ZLMQ63l2OF8VH3d4tCkAz4l0ySOJ9Na/V8BrK7X72O/OGrVbIwfxw==
X-Received: by 2002:a05:6512:13a4:b0:477:a28a:2280 with SMTP id p36-20020a05651213a400b00477a28a2280mr4640624lfa.689.1660543908834;
        Sun, 14 Aug 2022 23:11:48 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:48 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/9] iio: adc: mcp3911: make use of the sign bit
Date:   Mon, 15 Aug 2022 08:16:17 +0200
Message-Id: <20220815061625.35568-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
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

The device supports negative values as well.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 1cb4590fe412..f581cefb6719 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -113,6 +113,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			goto out;
 
+		*val = sign_extend32(*val, 23);
+
 		ret = IIO_VAL_INT;
 		break;
 
-- 
2.37.1

