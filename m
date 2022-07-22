Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1994357E1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiGVNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiGVNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F860AF87C;
        Fri, 22 Jul 2022 06:04:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z22so7540410lfu.7;
        Fri, 22 Jul 2022 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqpNQIvQ4UFsQ79e0nCaBDrArkXcARxy0hgxZyWDOKM=;
        b=QK5I9K0SkBTkC+qKkrxU9HL4SH5j2qXYf2qTNB0XJzYdsjeKH7XTHxHlXwj0OGTy54
         Zp0T8PuSmzKrbmSlcNPKqS6UMMhwrvGl8Rtv6Hcp8y22eG1W7X9WLLVeeDOGjKte2U5L
         StEdDx1Kff+jR3zHtm9MPfIrNeHUNVx7DOzvYkOfr6TCkHhznNe31A+fHEzLdpzsyZCp
         +Z/azhxW10Z3iVIK+t93xYm+ERFoMmqVaYywp0IDoBgZlbqNflC6YuPcnjZaAs9/fKNO
         i4/xgTWRpb7ZBkN7xuYsFoc0h51c6qDj/8Tsc1dfIa1jRo+U8vEcZ1kpYBx4xRXo0Lw/
         gtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqpNQIvQ4UFsQ79e0nCaBDrArkXcARxy0hgxZyWDOKM=;
        b=JShJi02c/M6v8EOrX/4ZoViwsqCjMkXudUu1HgIlXBNff1be9nGKybmpRb38uVw3+r
         qCidUYjEhHZEXnbvPngUEsNq4mShZOqzmHf1eyJYP0eQoGrnxVCf5q7SvCjzKPqldDtZ
         FxVvzhaibwfbQp/ZVCLbnLI5Zv0YYWKaNHpTxzcsPEWd0hk77Lo4O3tG1JFuChNdPD5F
         ZwowEC20FFSH3sjYz3T8IWQgHYdQYumEmY3WFp1pImhPiyJD86LBoiqK2qVr143+8wqi
         rlFVh7BRV0y1jDjuqoK4CtPEWWDwX0jqC/nUHfEOhwibJE2NRwtVQdGngY9LhJz+3MfM
         jSKQ==
X-Gm-Message-State: AJIora8ZWES4C/TIcVE8koX8ayY5R7dwax5fhE3LqyBKPxtutImiQEM1
        uI2/O/TlnQ5q99Be/+nx/3A=
X-Google-Smtp-Source: AGRyM1tadi/g4Nz573WLxQA6eU9xz8pa1F6BWQQQkXtEK0Pye2b3OdmE6QcQN9a9rBtJvkfCzIpKfQ==
X-Received: by 2002:a05:6512:22c2:b0:485:8c7a:530d with SMTP id g2-20020a05651222c200b004858c7a530dmr170384lfu.459.1658495040364;
        Fri, 22 Jul 2022 06:04:00 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:03:59 -0700 (PDT)
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
Subject: [PATCH v4 1/9] iio: adc: mcp3911: make use of the sign bit
Date:   Fri, 22 Jul 2022 15:07:18 +0200
Message-Id: <20220722130726.7627-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722130726.7627-1-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
2.36.1

