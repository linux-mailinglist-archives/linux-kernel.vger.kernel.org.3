Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CAB47CBCC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbhLVDq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbhLVDq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:46:56 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5825C061574;
        Tue, 21 Dec 2021 19:46:55 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t83so1088661qke.8;
        Tue, 21 Dec 2021 19:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OL7A5ukBxkoMWkSsnhIoSLHCTIoM15iUGM/H1c4aWqU=;
        b=jEao2wLQcyGxGuoTIL6ubPNypFcKGQlhlhG5JbD8bO30iob5ynRdrel6kpXfOWkyVg
         rL1Y1WVhJMXCfAhreGdSCP50NmzXOQ9hdi5w0RfLdDojGKggJYLCBW7T0n7KUVWfSD1C
         3fafJcexIYADzC1qFd90wLoyTOgE3Jh8QEYJy5RW6Y/9Tye059QNBgBsze2wnbxTqZxv
         l66nJAHAdxQyxHtQIWMZBAXaSr8QIpqN4gStaXnp4Ma4KwtfbwEIhl9uMs+1uf2dRtFe
         Wa1fyUJUWsv/DH6SHt29qq9NpziwpldE1yhCME5uHJhaUO2TxGpbUo1jSU5wAWmHa7o2
         eIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OL7A5ukBxkoMWkSsnhIoSLHCTIoM15iUGM/H1c4aWqU=;
        b=g9waPYB44Homdy8DjDI5nFC3U/fY9tevSsMAc15AOABxYYVH2EZeFEHdVmnG0/c8zX
         v4EUQLfoZWS8z9y1qeksX7k0FgObeTFbzgh+xb96WseyZtvEsre+rjJbqhCZVobro2be
         MOwyXnvVbF/pSzuyQLAlzwZo8UnU8vKwHwxYgjSI618C2yPaSBqkJ57EpkN9COJJqwXO
         PZN/2IZB2J750+i/pq7sLQRoqwpERkhH1O5yUkUaKuf0NYLNThM6ZcH75atz5TDk7auE
         S5k3bnsOsBNI9+5eS99Visg7Gipc6RN/7IDxHpnNMcE7ObCsFrGbJrqUoc6cmsh/ucc0
         6vZA==
X-Gm-Message-State: AOAM531G4plcTcyOq/6HQ4fnKSXkH4Ah9nMIfvbaURjOkFSgRb2Uwuek
        4W1/wyQel2ISjcnr6rpIE2M=
X-Google-Smtp-Source: ABdhPJwHOMoUEWhiTTlowbbnhQF4B5e9DBvNC+Iqt/biwtXFDBaEMvZn4PTU+edhTy91ziycWsRPhA==
X-Received: by 2002:a05:620a:459f:: with SMTP id bp31mr962107qkb.108.1640144815114;
        Tue, 21 Dec 2021 19:46:55 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:46:54 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 01/15] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Tue, 21 Dec 2021 22:46:32 -0500
Message-Id: <20211222034646.222189-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and the channel has
an integer scale, the scale channel scale is applied and the processed
value is returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0222885b334c..021e1397ffc5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -616,7 +616,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-		*processed = raw64 * scale_val;
+		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-- 
2.34.0

