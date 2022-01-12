Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC65748CCCA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357898AbiALUD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiALUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:00:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4778C061756;
        Wed, 12 Jan 2022 12:00:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 30so14469312edv.3;
        Wed, 12 Jan 2022 12:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4aJvth/j/tURi7i+5z+htKe8ISAimHDCbWnrVNR53g=;
        b=q5oQSKJc6vaYkwN+B4EjLF+BLRWuIK9Fad6ZhT816+rVjbaZrwADtHhR/nJPtHKw/K
         xwUypYEqqARevPtfgMan5U3d6b1EcVY2wiaIf/ORlub+N+9tg3VK4xFCUizaWWmx0mxF
         673wyAfRzl7KZPCw1sp24Jvq4UVdzlAb0+5/VCfZ/VHCbKI53KMBChItm0NUpdGCcY7g
         C8XRO+xUXGqKtoYuGA/t9gDIUioohabLGraJzZHxEhxv+tcz54Gvd1q8MzvHLNcymX7t
         VmbiCOLtfCAySHyR0uxwXOx+s4P8U7Dygo/4iXCdiL8ke+AukzRBnWTKMVtInGGol33Y
         KVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4aJvth/j/tURi7i+5z+htKe8ISAimHDCbWnrVNR53g=;
        b=0wkNyOAuYAB7Neeu7f/dELdhciGOdBuFed3gGxOK2j+X+tGnCK4sMWl1cPzGr9Tsc6
         +YS6zCAPSkrmDWLlREttyUBsiTO53GfIF3jiz81FyUqghfAKSW97ZfU/b/Xv4e93hKg3
         QUM/+cMX2pv4uxRnBejRcxzpSk6DNY3rWf1xvO2z32F8xZBdK25L5oI6QHhF97Pxzjks
         GqzkhHenNNXo1r8/aNCeGT+8rmmORNjHixNDbrIeukx4O56UxLhPq85NRLC9Vl8O6Ppg
         sdVziMTpkRFU0g9X6lcznFGPP62zZfwuUb+9nv3Eyo1g0v8Koq3sNi5EfoaqLgMgzk6K
         lUPA==
X-Gm-Message-State: AOAM532kSWQCjlE6BfmKWFrVJjK5mECFTZTJMRfRsftPcXusbYwYq2qK
        r0OHx+3YOf0jF7/+IdoHpwM=
X-Google-Smtp-Source: ABdhPJy71x22M8XAPtO8aFRlNcNzSxs1A97LUar9f5vBhM1REJmMTQLe30+TJ6VtN3yWdauDrL+5+w==
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr1045303ejc.59.1642017644566;
        Wed, 12 Jan 2022 12:00:44 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id rp17sm169566ejb.113.2022.01.12.12.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:00:44 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7124: fix mask used for setting AIN_BUFP & AIN_BUFM bits
Date:   Wed, 12 Jan 2022 22:00:36 +0200
Message-Id: <20220112200036.694490-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to page 90 of the datasheet [1], AIN_BUFP is bit 6 and
AIN_BUFM is bit 5 of the CONFIG_0 -> CONFIG_7 registers.

Fix the mask used for setting these bits.

[1]: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7124-8.pdf

Fixes: 0eaecea6e487 ("iio: adc: ad7124: Add buffered input support")
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/adc/ad7124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index e45c600fccc0..18c154afbd7a 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -76,7 +76,7 @@
 #define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
 #define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
 #define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
-#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(7, 6)
+#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(6, 5)
 #define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
 
 /* AD7124_FILTER_X */
-- 
2.34.1

