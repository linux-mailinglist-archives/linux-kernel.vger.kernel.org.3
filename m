Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6C48609E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiAFGXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiAFGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:23:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E5C0611FD;
        Wed,  5 Jan 2022 22:23:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j6so5489940edw.12;
        Wed, 05 Jan 2022 22:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LT2llpcDDeuGqkPr2EdkkzFcdUblB6WvE7dQ51tddw=;
        b=aFUMATVGgffrfLTKkfbRmvz4Wzd2KJjMWqI6hrY9ZruxltQ/303uX7lkscq2J3rESi
         dFa8ZnKu54d+pgLYYdK2sIxjK2Cxbb709WPzRo/zJd1FF6UbqhsMzytLvGItA20f0dJg
         UHfiTcqV3TPBcshEc1l6Ey7kykv9xmbpZDaNEanQLQVsbblVV/5m3xU72EAFWndqVplv
         YIIfBKH+jhwZ/IIm3cE7BSpPzCysD1s6dD6hLLgkZosDbYfT6qfBQpCTTKhK9Y+aO2HF
         IZ5Z1xgiGMnzj+1V2IjwXwk016R+z1eaUqvYCvW9Nzrp0RHP9+U0p1GYMKeUZXl1T06e
         uSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LT2llpcDDeuGqkPr2EdkkzFcdUblB6WvE7dQ51tddw=;
        b=Zdub0GTMGtfg1U1ooIVSUZashCHoVBXynP2OM6BqnxuaOvThWiqXQEtDwYqpzy/fTx
         Jc3kcuMf9EZYhtMr+25jcXt/uw+LdGwlVQKO7xrVdLatEZ41k0FMkLyEzoxvHxdZi/96
         LcVJToYt2pgINXl3kOEjQANc37la8Tc1QObPidCzPo0p6/abavg7iyiMolVJG8kerz9w
         wHPFJtHGuDFgCSvuQl1l42rw2Ay9nDgUVra7BJIKd/FgvHpxBm2xXXlVDIwunObxeEiW
         7i6Myx3gMcnaq3k+lEFkw3O8eSA9o5AG6TryPItHYscVYLqoaq3YmIfiqGDqikMsJwFQ
         fZ6A==
X-Gm-Message-State: AOAM5302i8jQdNWA00G9Y7g/rlMWNxJfjRvvwWihUkM4M2wFXboYPAos
        ors/q8mjYQ5Kla7UG+kzLlU=
X-Google-Smtp-Source: ABdhPJzbUr8u3mFt6u8YVmtB/BfPX/6S9Ad53fSeTqu654hBcyra90WEa86k+K+y9qKai01k0+7InQ==
X-Received: by 2002:a17:907:8a07:: with SMTP id sc7mr48742617ejc.738.1641450208033;
        Wed, 05 Jan 2022 22:23:28 -0800 (PST)
Received: from demon-pc.localdomain ([2a02:2f0e:f707:7c00:2820:56a6:a8aa:5135])
        by smtp.gmail.com with ESMTPSA id qb30sm242697ejc.119.2022.01.05.22.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 22:23:27 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH 3/3] iio: addac: ad74413r: correct comparator gpio getters mask usage
Date:   Thu,  6 Jan 2022 08:22:55 +0200
Message-Id: <20220106062255.3208817-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
References: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of the GPIOs is currently altered using offsets rather
than masks. Make use the BIT macro to turn the offsets into masks.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/addac/ad74413r.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 3d089c0b6f7a..a69dee667441 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -134,7 +134,6 @@ struct ad74413r_state {
 #define AD74413R_CH_EN_MASK(x)		BIT(x)
 
 #define AD74413R_REG_DIN_COMP_OUT		0x25
-#define AD74413R_DIN_COMP_OUT_SHIFT_X(x)	x
 
 #define AD74413R_REG_ADC_RESULT_X(x)	(0x26 + (x))
 #define AD74413R_ADC_RESULT_MAX		GENMASK(15, 0)
@@ -316,7 +315,7 @@ static int ad74413r_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
+	status &= BIT(real_offset);
 
 	return status ? 1 : 0;
 }
@@ -334,11 +333,13 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 	if (ret)
 		return ret;
 
+	bitmap_zero(bits, chip->ngpio);
+
 	for_each_set_bit(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->comp_gpio_offsets[offset];
 
 		if (val & BIT(real_offset))
-			*bits |= offset;
+			*bits |= BIT(offset);
 	}
 
 	return ret;
-- 
2.34.1

