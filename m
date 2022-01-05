Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479444857DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiAESCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbiAESCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:02:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E1C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:02:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v11so68510pfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4xBlIXwe6Ivsos8VDAdi5+QbDpQQkpq7vuCWanUwHM=;
        b=DKpykNKzFqpD6wtU0kd3SCoVApdmj+8Wn9hZhJEynVJTQrApPdzCUzY9RdRRhPQcTJ
         Jmu2AjPiza5T60QeIidYoh6wiQb+SzvyIf8eMj2yYz/b1fTtjeWpZrG0zy1yBI5xtH9o
         J1UsO9XHjtSONDmqzVt3dchS5BCZ/sZvxQ9ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4xBlIXwe6Ivsos8VDAdi5+QbDpQQkpq7vuCWanUwHM=;
        b=fqMDGsWI4byLTmPp2z/raXlBK41Xlc9kZOKCPpzPe0ykpAwhq3e7a0bRnxPsX69Nav
         c4IoIat3Y/mlKro2AfXBsUalv32ia6RWUwFLxFBIaMGRiefvhnGfujV25jblTm008469
         puIT4DRalerAFd7oFDsmBqg86cpEPGpsrOfk6LR9ju3RmDC2xd0as5kDL9LvKk13GPoa
         0vmhuf/ClRIRKZXiBSRm2qwdcetFouUNT1FXembSZfTkjJJEuw0ZVowqmbte9J97Y5rv
         WVEWiQjKLrLITkj1MnS1OdkjhngtnInwlbCnef/8IbE5X73qvU4FS/9XXH+d3x3CN/5E
         2dEQ==
X-Gm-Message-State: AOAM533Fu2c6BYkDe4MyyuLa3lubDpYlbgzDsS+n+BQqTM2O1YsQQIPX
        yMeAp7NptOvwDFMKqlZXci4e0g==
X-Google-Smtp-Source: ABdhPJxKtkiY2qS8/bDmJwa91au0gi21nej2Y/DnGQWFiHtISxkCmRgUbXb7Cb3ILaJKV3U+pFy7WQ==
X-Received: by 2002:a63:8042:: with SMTP id j63mr50086308pgd.292.1641405736461;
        Wed, 05 Jan 2022 10:02:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm28499040pgj.57.2022.01.05.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:02:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] iio: addac: Do not reference negative array offsets
Date:   Wed,  5 Jan 2022 10:02:14 -0800
Message-Id: <20220105180214.2435001-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254; h=from:subject; bh=sGHoQxGNcT2Kv4+f7h+VZ51sTNIi0mtsXNE1v+t3ApI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh1d0lM+4aPs0jyUT1zIY3p2331EZ11B0G+kBU0nyj Jcsj1AWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYdXdJQAKCRCJcvTf3G3AJvGfD/ 0Ut8I5/wxM912CDP+SrbegTwNbdz3eNsh2P4jKCPXaOmJ8sY8BBFtUAqEnWjGwWq2CVRKstBsYiAZl /+NwcXCNPt5VrLaEUI+GtZOGiTN8qml6bh0/LN+VF1iFGqTmXr8MgT0/dK///ubvK2gcVZfecWhoX8 7L3vHNHmSb3pwcbHyrMQMvoHa3jGjj8sjNr6v/F12SOfGFB7boVa87MVcNIDcng14m4bGQY0LamHlO ecKlMRMMBJSCDMFk0CzFWIWqg4yBT0ggv+n52uKlMBvCNHMoudn0gv3ld3EWuUSNV4kOHVJfLY+He+ vbiRN3Wy+AOIT5taUrYH50SqGp9Rk4Nx5Tz+HAHU+67CsBNmBLcRytkkujt7v2/9UZ/IQ3nW7vLvOf 2GlaGJ5eLCwCwKCnPnIyfSjyoeHgLeSbGRwzaQkjjU8uURk6eEP0oRgbUS0CUs1EIBPB7ODEI5AKW6 zs1E5JseyeKBsjVi8S6AwyYDoH6XWQrwqTqh/1p1FKbyRNIBKe7ykQjxfH/xTtx1H5GAaQU104tY3u eEDzC0AR6WV/sSRw8nIQWbHhb6tURMGErU6hqRKXFM0dY6x5Pcs5XgROqRe66RGmmzGpz6LWK3Kdn1 +pAtH455SfdNcYuFLILhyAWfNiRpYKAuKMV4kX0Uy5UozDVsUe4uyllFkLoA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of aiming rx_buf at an invalid array-boundary-crossing location,
just skip the first increment. Fixes this warning seen when building
with -Warray-bounds:

drivers/iio/addac/ad74413r.c: In function 'ad74413r_update_scan_mode':
drivers/iio/addac/ad74413r.c:843:22: warning: array subscript -4 is below array bounds of 'u8[16]' { aka 'unsigned char[16]'} [-Warray-bounds]
  843 |         u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/addac/ad74413r.c:84:20: note: while referencing 'rx_buf'
   84 |                 u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
      |                    ^~~~~~

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20211215232321.2069314-1-keescook@chromium.org/
v2:
 - use "xfer" for checking "first through the loop"
---
 drivers/iio/addac/ad74413r.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 5271073bb74e..aba9a643a4ca 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -840,7 +840,7 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
 	struct spi_transfer *xfer = st->adc_samples_xfer;
-	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
+	u8 *rx_buf = st->adc_samples_buf.rx_buf;
 	u8 *tx_buf = st->adc_samples_tx_buf;
 	unsigned int channel;
 	int ret = -EINVAL;
@@ -894,9 +894,10 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 
 		spi_message_add_tail(xfer, &st->adc_samples_msg);
 
-		xfer++;
 		tx_buf += AD74413R_FRAME_SIZE;
-		rx_buf += AD74413R_FRAME_SIZE;
+		if (xfer != st->adc_samples_xfer)
+			rx_buf += AD74413R_FRAME_SIZE;
+		xfer++;
 	}
 
 	xfer->rx_buf = rx_buf;
-- 
2.30.2

