Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E101595C62
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiHPMyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiHPMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:54:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FE167C96
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:54:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c28so10735432lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vLleWyKkc8+dRuojA9STfvQ+s2PUO4s/QZeAcLoXm/w=;
        b=khfPnd4/1a217S2gFX6VmsRS139kt76fTvrIsK4JxL4bXiQdIUBgm5pqrBE8KVU7PL
         XH5CGRh0SwL/yDThQniQmTTobptdoI7zcHlMw3Uisc551/rTw5W7lfxCdV2wy8wgBGOQ
         Y0wgsUbr5qVhcHi60hqyzqH3v02rkLkdtvaVSWK9Gz5OZjlQ02PdUVr2Zuj7Azg+FkNz
         oMpMmyf9gLX7+ssjbhiX7hXodw+/W/CiL5cPGbHQI8KD8sayXOAb1f6qaoQu5q4X8vGN
         U6QbV2Dgn6WKs0ffdcYbMg6NsIeoy9MtzBCb8A33YfoEso/gozuZ8rGVUpfFeAoLhgvi
         bjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vLleWyKkc8+dRuojA9STfvQ+s2PUO4s/QZeAcLoXm/w=;
        b=tPytqHHFvL1/DxsurawciIiQGIvCr6nUIQOpvNs4Vs+aiUatiiKsuEic0SSSyD/tz5
         /UNRTEY9tl1i/B4/Zt0mZfYrm7+2LUDxBu3olhqwsZ9SxBmfLgfHqraH9msNzHr2Kg5h
         y0Wv/mS/Ve1bOxUxNn6koI3Sp8Tj4ERhy2p9s1KRL2qHR/LSFThxh8wBgSHhN52BpW69
         MTyFCGNMikfcbomDoD+hJwqAINS9LwY8fKLAHbmbAzZlrSMRQZcajr93o9q0Fky9KRG2
         FUJ998UJBRY9KmLo3Uaqh38rPouRmXdi5TLnO7TeuzQFso+vH5XhLDsMcOq7MeK+e0IM
         WswQ==
X-Gm-Message-State: ACgBeo2tMJJ0SO4WpE1TM1myF/OXy7wji9ieNIZ3xbDVz7GdbEhpncJi
        NgdSyrHVAB1x7C/dMZd1RMNFag==
X-Google-Smtp-Source: AA6agR6GhKLm8VLIdMxBAg/e0iqb1Y8gElUoTN/4/lCUii8RQWjlghCF5vcgziyffJpYXwELeYHL8Q==
X-Received: by 2002:a05:6512:3a8e:b0:48b:b6a:e670 with SMTP id q14-20020a0565123a8e00b0048b0b6ae670mr6797014lfu.40.1660654448629;
        Tue, 16 Aug 2022 05:54:08 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id q11-20020a056512210b00b0048a7d33e0f0sm1379144lfr.261.2022.08.16.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:54:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: iio: adc: Drop Patrick Vasseur
Date:   Tue, 16 Aug 2022 15:54:01 +0300
Message-Id: <20220816125401.70317-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816125401.70317-1-krzysztof.kozlowski@linaro.org>
References: <20220816125401.70317-1-krzysztof.kozlowski@linaro.org>
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

Emails to Patrick Vasseur bounce ("Unknown To address").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
index e82194974eea..82168b1495eb 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
@@ -8,7 +8,6 @@ title: Analog Devices AD7923 and similars with 4 and 8 Channel ADCs.
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
-  - Patrick Vasseur <patrick.vasseur@c-s.fr>
 
 description: |
   Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
-- 
2.34.1

