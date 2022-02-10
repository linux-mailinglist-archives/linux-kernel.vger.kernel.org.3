Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29E54B18F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiBJXAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:00:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbiBJXAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:00:42 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB21105;
        Thu, 10 Feb 2022 15:00:43 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e8so5588189ilm.13;
        Thu, 10 Feb 2022 15:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r7B1u3StVmNn+cEV4ztOlK7kYJWbJkFyeLauH29gYM8=;
        b=dzLBz2h9W3+P1fTFVwJCXjMzkDS/do2ayswvINxgwRV6LLNSkbDxlUQcxdk+LJZ5Gx
         vwqdX6D12rc1Yvd9fQaPcwN9sVvGOovH2iqr9zxZY7dauw3jnWm/j6Ep0mU30c80bSMn
         x0XJB822IsAmPLlczCETi3PVgDyd0smheFP2USkn/XObVyW1NxHYcT0aTPxrxtrBTRYb
         xBuWoEUXkdw3rPyD+c8jdwY2BMCXVdxzxFDgblYiKQjVEL6J813R1xNRtcpVL4OQ0a7u
         fhfqQFn9ElMVCLQ6Sq8p4ZBLU1HYI1JL0a8nEn94OxrS6Mh7CubSmLYNEUawMDPT+DL4
         V42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7B1u3StVmNn+cEV4ztOlK7kYJWbJkFyeLauH29gYM8=;
        b=JYbrZX5/FO5si8lHPf+AzsAUwkBUJgaAl7Yn7PRPyZwtMwA2kk32CdCwLLyhEsMUf0
         Eqmw3Hu03yJdf1M/HEaFivr7GdNAUETVnIB+CAYZEu/O6zPbrUOciCEw0gVhBH/6Hd14
         wFoF5BWBvWIy6LJdNR0xK8leWG0d6ACLurnIjYNVog7lzu7086875h7k1fkRTsOC8nnR
         ZUTyViEiI3AT01R/lquqMVdPlUdKHPs1782F06GtYcv6Q8ZkzwKCGtK200lrtupWy08d
         fyL+WKJHW579cJKRT+ufO217XxkiyEGyT9IThPtbdUx6u7Hjt38JC+gnjMqKeg6t+l+g
         V4sw==
X-Gm-Message-State: AOAM532gfznWk9reF0lj1jgrtS69IiyJ0w8O+vDQvAooN4w3QCTZM9sY
        andOPrXBKsmPxHFx4UV4CNI=
X-Google-Smtp-Source: ABdhPJyDaHsNtIqicj2d5g0OLH9mju+tDwyc+D9hx93ef0eytT5AHJVFdIVfEcBuRUZkUUoFK32Fgg==
X-Received: by 2002:a05:6e02:1d12:: with SMTP id i18mr4925637ila.323.1644534042346;
        Thu, 10 Feb 2022 15:00:42 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id y9sm7235385ilg.58.2022.02.10.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:00:41 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH 04/49] iio: fix opencoded for_each_set_bit()
Date:   Thu, 10 Feb 2022 14:48:48 -0800
Message-Id: <20220210224933.379149-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

iio_simple_dummy_trigger_h() is mostly an opencoded for_each_set_bit().
Using for_each_set_bit() make code much cleaner, and more effective.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 48 ++++++++-------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index d81c2b2dad82..3bc1b7529e2a 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -45,41 +45,31 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	int i = 0, j;
 	u16 *data;
 
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data)
 		goto done;
 
-	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
-		/*
-		 * Three common options here:
-		 * hardware scans: certain combinations of channels make
-		 *   up a fast read.  The capture will consist of all of them.
-		 *   Hence we just call the grab data function and fill the
-		 *   buffer without processing.
-		 * software scans: can be considered to be random access
-		 *   so efficient reading is just a case of minimal bus
-		 *   transactions.
-		 * software culled hardware scans:
-		 *   occasionally a driver may process the nearest hardware
-		 *   scan to avoid storing elements that are not desired. This
-		 *   is the fiddliest option by far.
-		 * Here let's pretend we have random access. And the values are
-		 * in the constant table fakedata.
-		 */
-		int i, j;
-
-		for (i = 0, j = 0;
-		     i < bitmap_weight(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
-		     i++, j++) {
-			j = find_next_bit(indio_dev->active_scan_mask,
-					  indio_dev->masklength, j);
-			/* random access read from the 'device' */
-			data[i] = fakedata[j];
-		}
-	}
+	/*
+	 * Three common options here:
+	 * hardware scans: certain combinations of channels make
+	 *   up a fast read.  The capture will consist of all of them.
+	 *   Hence we just call the grab data function and fill the
+	 *   buffer without processing.
+	 * software scans: can be considered to be random access
+	 *   so efficient reading is just a case of minimal bus
+	 *   transactions.
+	 * software culled hardware scans:
+	 *   occasionally a driver may process the nearest hardware
+	 *   scan to avoid storing elements that are not desired. This
+	 *   is the fiddliest option by far.
+	 * Here let's pretend we have random access. And the values are
+	 * in the constant table fakedata.
+	 */
+	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklength)
+		data[i++] = fakedata[j];
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data,
 					   iio_get_time_ns(indio_dev));
-- 
2.32.0

