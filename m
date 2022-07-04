Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85DC565CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiGDRTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiGDRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E10C3A;
        Mon,  4 Jul 2022 10:19:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i18so16753460lfu.8;
        Mon, 04 Jul 2022 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uz1r1MYBHCUxjx9kX5YfhmuLjAg4kDpzXkE88JpxOxc=;
        b=H1+BqzxpxrdAsvw7O/ibopA4RXDHhXoyTrxCKl8gIG+d8vspZmWQVD5Z5ga41UU4Os
         5CaC/o5EaVwY9PSGHYeQC6s47492vdlS1FyvjDl/D2AITQ8FxRi8WhxbPi3GvU25Vd5d
         U9T026pUZ5CxXhF/S//F8jJYOwTmsuyoPRJfnjVkzAzqVar/t7PtXHgzRidA04X9cH52
         lMRrJWlat7j1UTtnkO2P1gmVrcbH4lxvdFzjdig8zO8Qk6SeVJpIC28AHK6PqLVe97/6
         211D7QrCE9maJTV3Ohhd68agEWIsMcXTeRpz7gIt7r4FVew585pRGCp7Hv8lyi1fNyIL
         UycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uz1r1MYBHCUxjx9kX5YfhmuLjAg4kDpzXkE88JpxOxc=;
        b=4WKyT/ar1Bgd3XypieTbj6gHLEu4I2YLiuRiMLGUHiBjf8O1Tlr4pnXOBnOiwWdRE2
         rkkKjUHjluqNeDL4stSb/e5kBeqOQLSuPYPjtxaydAXnQidX2zeCYvmebB+iQMWNRn9d
         VTZc6NqZDrXgc/eVgXzsIaWmBaNtthRPp+6FdFnADbV46MZAws1uzpBHgEwxEuVeGVK7
         79O9iEDE36IM3PILurdSyfQe0xVn3ylVDaWpXC9pAIcBQ1jJ8rPVk2ju70bEtQxMpzOE
         tVVeu/UYM7I+h9y9+q7s10USKjfTgU3FV92ma+w+vF9OwD/U7Lx6+IKUX8AV8ihMonEP
         3OqA==
X-Gm-Message-State: AJIora9znac+bHimnZWXDWXCsCySl2gtBiby5chOIEaj6p/G88p4WLF7
        Jk8a7XcnKPdhxGccPTCnnU0=
X-Google-Smtp-Source: AGRyM1vMndnS/8hs28jgccJsv8T0iI4Zh0odFQZqziQpNHxSwflURHrGChgGiQ+grNUMVMw87Rp4LA==
X-Received: by 2002:ac2:4896:0:b0:47f:773e:242c with SMTP id x22-20020ac24896000000b0047f773e242cmr20697024lfc.79.1656955149560;
        Mon, 04 Jul 2022 10:19:09 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:08 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] iio: adc: mcp3911: make use of the sign bit
Date:   Mon,  4 Jul 2022 19:21:08 +0200
Message-Id: <20220704172116.195841-2-marcus.folkesson@gmail.com>
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

The device supports negative values as well.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
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
2.36.1

