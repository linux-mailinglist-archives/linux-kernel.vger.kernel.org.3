Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B788C47ED5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352072AbhLXInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352081AbhLXIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:43:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B1C06175A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:43:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a23so7146433pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVYg6vqK0bkjeQRhVKIbYAOnwHGxgaBimTUyzl5wfWU=;
        b=DSi9fT87X/aQ8j99LRzb46Wq1GH2EqAtDCrJVsAMspshyX9URQfBz6K+q5fJwVCHCb
         e46+U5RO2/BSYx742BVsAROr8Xn3nEPAx0d+GnFEf7cu5S+E+qbRxAEIaGb9HMSi/CPU
         3W2UEziHeqoFpnqAvvSCfeYnqfr1K91xIZC/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVYg6vqK0bkjeQRhVKIbYAOnwHGxgaBimTUyzl5wfWU=;
        b=kUPRb0Mk0yrP5LEsAIWRt/YapI2V8/wzTLK5SjJ/Z9hZMTo9Bm4UWkwhkq9QOIGN9e
         XaJICkDBIG+At7LepDXwrpQvLvJh9c4D3heBekx7tC6KZuGIEVuQMWwYzIN8JqknPV5R
         DCFy/E0ExFiwxdCqBPeGlQJv4tlapkF+FW2K5wmAd4FEFy3/xTtwJTAhTlsl2s8yIHzT
         aWHww0LeYH/b+hjmbCtGemAQnMCQovXja361+ci1ho5jJGAbZGio1xnp5pn3Wh/gOhoX
         1/imLizBYUqdbwq1/7PIbLXDFz7F8g8KnDDPgHgbJqguHyrxQj9mxKNrnDkLUMaCU9o9
         Xh5Q==
X-Gm-Message-State: AOAM533qJRw+T/mDr6fo983R71GrmjUR9ZoOSCeSczr8a1j21ng/1T/d
        OGwmvcE3HijMCYZ2F06PTnn0Uw==
X-Google-Smtp-Source: ABdhPJxZbbX4Ne8SBwTui1zct2EjoGavD3KorLUC07IOY5SGzG1gbt9det+g1w/jEAaZ0gxMh+oSgQ==
X-Received: by 2002:a05:6a00:15cb:b0:4ba:edb1:c03c with SMTP id o11-20020a056a0015cb00b004baedb1c03cmr5970245pfu.54.1640335408697;
        Fri, 24 Dec 2021 00:43:28 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fd40:cbd0:c42a:3c26])
        by smtp.gmail.com with ESMTPSA id p13sm436369pgl.23.2021.12.24.00.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 00:43:28 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT 5/7] media: hantro: jpeg: Add COM segment to JPEG header to align image scan
Date:   Fri, 24 Dec 2021 16:42:46 +0800
Message-Id: <20211224084248.3070568-6-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211224084248.3070568-1-wenst@chromium.org>
References: <20211224084248.3070568-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JPEG header size is not 64-bit aligned. This makes the driver
require a bounce buffer for the encoded JPEG image scan output.

Add a COM (comment) segment to the JPEG header so that the header size
is a multiple of 64 bits. This will then allow dropping the use of the
bounce buffer, and instead have the hardware write out to the capture
buffer directly.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/staging/media/hantro/hantro_jpeg.c | 3 +++
 drivers/staging/media/hantro/hantro_jpeg.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_jpeg.c b/drivers/staging/media/hantro/hantro_jpeg.c
index 7d4018bd6876..51e67e5cf86f 100644
--- a/drivers/staging/media/hantro/hantro_jpeg.c
+++ b/drivers/staging/media/hantro/hantro_jpeg.c
@@ -247,6 +247,9 @@ static const unsigned char hantro_jpeg_header[JPEG_HEADER_SIZE] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 
+	/* COM */
+	0xff, 0xfe, 0x00, 0x03, 0x00,
+
 	/* SOS */
 	0xff, 0xda, 0x00, 0x0c, 0x03, 0x01, 0x00, 0x02,
 	0x11, 0x03, 0x11, 0x00, 0x3f, 0x00,
diff --git a/drivers/staging/media/hantro/hantro_jpeg.h b/drivers/staging/media/hantro/hantro_jpeg.h
index f33c492134e4..0b49d0b82caa 100644
--- a/drivers/staging/media/hantro/hantro_jpeg.h
+++ b/drivers/staging/media/hantro/hantro_jpeg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 
-#define JPEG_HEADER_SIZE	619
+#define JPEG_HEADER_SIZE	624
 #define JPEG_QUANT_SIZE		64
 
 struct hantro_jpeg_ctx {
-- 
2.34.1.448.ga2b2bfdf31-goog

