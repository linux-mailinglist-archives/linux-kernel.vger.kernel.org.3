Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CEA55845B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiFWRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiFWRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1396596;
        Thu, 23 Jun 2022 10:07:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q9so6043090ljp.4;
        Thu, 23 Jun 2022 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrAwCaa8SFiIkRGl0IlNr/Pb/vSSatSRIxkJ5qLkgXc=;
        b=i++raDe8RRGy6Sw3E46ns65wlY7v8Dg1dmpy4K3YEj/MWulBKVFbQsIoEikswDPTF7
         c4yIwH3nf++NRTAvPMFurf4Xv6XRJ8zMJ+SvMc49Oho2N6Fc//GqjZUNPItywGJLGGo3
         y6IvNSO/moXJOa2dp6y315l4E0NRDSZTJyL00ak1GWaJShCYWFrPG1J3aFvksh3CBUQZ
         8MUkOI/QDLa+Y7fbtqSQ+Ms0MRcfQIISs47YLmToWcQSv4FMXy5ll/Xamz6m847Lagng
         1QqV4alCpp+iyGrQDKjiGnlAO0FaXwKI/kzYtIjeF11quQLME8BkyFUmzAYqG9J/wBcM
         AxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrAwCaa8SFiIkRGl0IlNr/Pb/vSSatSRIxkJ5qLkgXc=;
        b=fY1S5zpxhWfLl1sVUZlevEDFmzyq+J4m9wLudYefIx83Ipn2Zum7tNML4sfF5fWBQK
         XvcjH3yFZqWAM8kVJEU/pensoVtmSMh6r9mcjAX29P0Fd+zKL3Kyyfv1eSFWvhxpzRB+
         Snnoq96NpnP4l4KVI5f9PmRlcu0mcDaWQYutuuPmVWbbdYRV+vMzldbzg7RXjK07pQeh
         fRkVasuKGhopcP9oVgfN0daFSg2A9sp92qdqCGjxD67nkRh+MQSLwOXGlS4HRvNCqflm
         NetcDnKkeYfWvCN4YvKQ6RGSDiTJjCkymfN77GYEVNl0Sp/ljAN0ExhlU/etPU5nItdu
         dbRQ==
X-Gm-Message-State: AJIora8zGcDI99gXtn5aSBXpVsx6rjXr/CbcVKYcW1UdK5pBUufdu5m9
        XFXfz7LoUZrnbU/p7Hbsupw=
X-Google-Smtp-Source: AGRyM1sdZMmftr/KkG0O9vbX2TeMeEgbKE13w7eLi0Z4jVWOmOqnnMVR0aKuAFmyIwLzn68++I6Nzw==
X-Received: by 2002:a2e:6f03:0:b0:25a:74b7:3a59 with SMTP id k3-20020a2e6f03000000b0025a74b73a59mr5288610ljc.390.1656004036857;
        Thu, 23 Jun 2022 10:07:16 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:16 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] iio: adc: mcp3911: make use of the sign bit
Date:   Thu, 23 Jun 2022 19:08:43 +0200
Message-Id: <20220623170844.2189814-9-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
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

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index aefc5eac874c..084f6d1aa6d1 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -144,6 +144,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			goto out;
 
+		*val = sign_extend32(*val, 23);
+
 		ret = IIO_VAL_INT;
 		break;
 
-- 
2.36.1

