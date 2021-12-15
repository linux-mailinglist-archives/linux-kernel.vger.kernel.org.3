Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B022947666F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhLOXXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhLOXXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:23:24 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03639C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:23:23 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r138so21349523pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUP5pV4LbjbL6ChpTJEV6t+0KAeGUNhk4yeQuFtZ/xA=;
        b=Ws+rXqdD6928Ay/PkMMSzT9wQHS0j5pi/XTU6+k+VIqcxZBLkmWpp5S+Y9esKdsNkk
         W7ehpnlaeyFNppGMujWC0hLvjEZHmI7k8iO6sce67sw+hJ0VikA0/af6PIjqMYWfIqm9
         6TO+YBPwY5vWJ+CV60DZX2tXReWXtwDvUz5jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUP5pV4LbjbL6ChpTJEV6t+0KAeGUNhk4yeQuFtZ/xA=;
        b=UOMmiYtgtAze41IEHV6jCnta4X01/U4NlRpjSVW4SShz7UKEPzyqE1TijgX0N/Ji9q
         PPueAnWt2ggdQtd6S6wwW2TyAno8dhEXVmUT/Ouj1IYOEBSFHs6G8v3cY7koLp2A0+qa
         EITxSCcEsh7Sru+cv/Mv4DHifd9zDNA46S5F0z9LOGg3ZvEm/vPlh8KwYUzxWlXYVyal
         /Q1GDgEAV7wVZ/YAtaYRb/wiP7zktev0apvrMjJZ/W7dOeMUrZxt36G1gQX8RD5af9IN
         /GmLHGjGBOshqav5MeBZ4HzjWaQTjK4e4Rcb6XMx/9AzpktRP9ly9cRfkz4BAB1TI79r
         O9hQ==
X-Gm-Message-State: AOAM53085Zx39EmRyumVCPhfFdpD2uQwazX2xK/f5qybrho9YVVBAx9n
        dHFMg9DATeUwRZaZKIrNAmnCNhlQUzFIlA==
X-Google-Smtp-Source: ABdhPJzqO0/IPXNwz2AlY7ytkYuVi/RaN7Jxgnt3LGSyOxd9ozEXsC2NQNtE2BU7fgql2RtkN7zJfA==
X-Received: by 2002:a63:db14:: with SMTP id e20mr9656006pgg.177.1639610603355;
        Wed, 15 Dec 2021 15:23:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l14sm3166142pgj.16.2021.12.15.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:23:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] iio: addac: Do not reference negative array offsets
Date:   Wed, 15 Dec 2021 15:23:20 -0800
Message-Id: <20211215232321.2069314-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; h=from:subject; bh=Ug++7VdcHQcDDwReQr4ZZ2ULLBwyzvNrHrJYpH65vb8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhunjokBc4G+Gp61s8YXcf4TMtGIMymQWs9kymrw0s eVyhA6SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbp46AAKCRCJcvTf3G3AJoGwD/ 9Hyty00effkGKmBLJYH8X7GwBl/3KmCr8nA4gf+PRO19CR/YrVhsIitp4v+RuqxsMvuRk2h+ZEYfSR +O46ycFY77Adcs1fTLdmHvNrl+swH0cfnnubMkQmc4TFVJQtyrrG8PWi7rIy4Qyj8RNuKiZQljDu8m VJC+uKkRd6oaayIJYWGjNJrlN73qASgk82bdFMo0YtvOPvNZYXngctZ545RpWGf/jh1hLV+mMsM41d CRE7iegJUpPEOHEamFn/pVRAs/aZ6YW1hdo9W/qGY8aYIJu45Dgy+f+Dcg9UU//QCy+HYmukHX9017 yhKssf9r5WQAM0TYWCMhqb3NaRERQBPZ17C+PO1IkSv2GZG6Eg+r/iFa2Ixsi5f6u+KpX2X29K2M+e PlzC92z9DpXHVdeOQ954dP5nVmn12JlrWwC4hieW+y3tibw76MbSBEjiqWBHjf5NtuH2GMG2wtnAa2 kCQe7GCmcUUc5PZFWlcJy5CK4S39C/pgWb5v+n/dHjMBjpnZmqrvz83zkNeNwfyKMxBY/iVIcOjhOx VlJ/zUYaem2f85axHsfd0octFuSXyWTrfrtDql/qror9JBtwoS8A30Zf5t5xvN9+oEkjKFftYeJSyJ m3rUzjl75PgfjPGWt+Qj5BlVWado8vMvbh2X6MYhwdBeboXXOr8H+c7kuCsA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of aiming rx_buf at an invalid array-boundary-crossing location,
just skip the first assignment. Seen when building with -Warray-bounds:

drivers/iio/addac/ad74413r.c: In function 'ad74413r_update_scan_mode':
drivers/iio/addac/ad74413r.c:843:22: warning: array subscript -4 is below array bounds of 'u8[16]' { aka 'unsigned char[16]'} [-Warray-bounds]
  843 |         u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/addac/ad74413r.c:84:20: note: while referencing 'rx_buf'
   84 |                 u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
      |                    ^~~~~~

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iio/addac/ad74413r.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index cbd9aa9b399a..b0a6d8ee5133 100644
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
 	int ret;
@@ -877,9 +877,8 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 		if (ret)
 			goto out;
 
-		st->adc_active_channels++;
 
-		if (xfer == st->adc_samples_xfer)
+		if (xfer == st->adc_samples_xfer || st->adc_active_channels == 0)
 			xfer->rx_buf = NULL;
 		else
 			xfer->rx_buf = rx_buf;
@@ -896,7 +895,10 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 
 		xfer++;
 		tx_buf += AD74413R_FRAME_SIZE;
-		rx_buf += AD74413R_FRAME_SIZE;
+		if (st->adc_active_channels)
+			rx_buf += AD74413R_FRAME_SIZE;
+
+		st->adc_active_channels++;
 	}
 
 	xfer->rx_buf = rx_buf;
-- 
2.30.2

