Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408F2486096
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiAFGX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiAFGX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:23:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8345C061245;
        Wed,  5 Jan 2022 22:23:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bm14so5613872edb.5;
        Wed, 05 Jan 2022 22:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIHuyJokQwYohJ2Ygvw5vXpDRn88ZneGaWCmSAP+ubg=;
        b=PrnF0YxbrqUNvqjeK2ecnKKMHIbVfRj6CErKpbQoSBy8TE/2m+33H8kHlCN5DP8EDH
         /Ic9cAZlLrUkw+xNOpu1ygoQ5MTDf1Tq7xue/Im5qHTTns6+qvvHuNUBG5UNOQ4dcQTu
         XXA+2xiPU0B6qtlA4JiBE2b1NUokswxLQwQt6A+ncIQW4hSI39eONnPTHPSiD8/bEH8F
         QFMnubHtE7AMHWtN9TDu6kfmU0Lkn8xcwPRvyuRR0WdpNf9mVVnOVB1n4o1gtl70Eh6Q
         t348gt63rMy48FH5iMUz4OlYUl0ZKdahj6PqUNwcerusGoI/THt2EjAUwyKo5RLn8V+I
         9l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIHuyJokQwYohJ2Ygvw5vXpDRn88ZneGaWCmSAP+ubg=;
        b=XGrs2Ub5eQhJzDr+SeHfeccl6YAhFyHUwa/emhjZg/NzMb97/kXO03KW6kCWj7PKky
         M9rMKeBIFgcVlpKjNSV+o1iBdnIsU1nRPE0PiQ/Koy06yE26zssjwbu9tEcxHmK+VwZw
         o51nA7rMDSLLdirpA0CmptahifP2qCKjQY8UZfwjwVTT2UFjxx4ioLz4v6BpOdLOER+7
         sHRRgoqCuWDSIT7Oq4yge/FgTKa110Gs2Q7BFi2lr19PCdmcXWkLlo2HeuHN4sUXYUOT
         q9B1G14Obz1SbpNe+BfBOq8QL/jDNwyD77WZwjCQbeBV7u1D7RBfxNmJcm2bKYaJkjCp
         Cl3g==
X-Gm-Message-State: AOAM530tfTHNYrQ0rXUjq4b2Ec5VWyAVg4LE9Fi0D3PGkjgc4I/nrhn7
        rUYsLb7+yFuwtilHjZ91/To=
X-Google-Smtp-Source: ABdhPJwD2LFOdWwcZFDyDSj1xnLH0vWeFp4KTvkaZKT9mRPwosqH4XZc4QqrzlngFwrCKMoBsADbVA==
X-Received: by 2002:aa7:de82:: with SMTP id j2mr37236972edv.389.1641450204597;
        Wed, 05 Jan 2022 22:23:24 -0800 (PST)
Received: from demon-pc.localdomain ([2a02:2f0e:f707:7c00:2820:56a6:a8aa:5135])
        by smtp.gmail.com with ESMTPSA id qb30sm242697ejc.119.2022.01.05.22.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 22:23:24 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH 1/3] iio: addac: ad74413r: use ngpio size when iterating over mask
Date:   Thu,  6 Jan 2022 08:22:53 +0200
Message-Id: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ngpio is the actual number of GPIOs handled by the GPIO chip,
as opposed to the max number of GPIOs.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/addac/ad74413r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 5271073bb74e..6ea3cd933d05 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -288,7 +288,7 @@ static void ad74413r_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned int offset = 0;
 	int ret;
 
-	for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
+	for_each_set_bit_from(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->gpo_gpio_offsets[offset];
 
 		ret = ad74413r_set_gpo_config(st, real_offset,
@@ -334,7 +334,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 	if (ret)
 		return ret;
 
-	for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
+	for_each_set_bit_from(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->comp_gpio_offsets[offset];
 
 		if (val & BIT(real_offset))
-- 
2.34.1

