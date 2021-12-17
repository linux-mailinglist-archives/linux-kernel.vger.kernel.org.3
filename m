Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC544783C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhLQDst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:48:49 -0500
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87]:37923 "EHLO
        out162-62-57-87.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhLQDst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639712921;
        bh=Y5C1Oy7HePuCeUWI/JcEuK7VYUM29jY2xRbaqqIBPm0=;
        h=From:To:Cc:Subject:Date;
        b=GoB/Gu/jSWukhlJKFg390TLJaLxzX9OGj2qHKjV2Sa7nJNtb6iniCjpBJK4E7zxQ1
         Kma0dF7x+JDvSxbhc1zIi8vLlHw4KUhb7kEUixzAeUgONN5aSVrgTYDf2YfKjX/U6U
         Jb6tZ4mEe7T9eh2AHiDLq2VDRExRthfQMAWQjmck=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id C2620A0F; Fri, 17 Dec 2021 11:48:38 +0800
X-QQ-mid: xmsmtpt1639712918ta5cvz6iy
Message-ID: <tencent_E14226FC5CC9EF3F18C480D9249783C39B05@qq.com>
X-QQ-XMAILINFO: NzOHSugmTg7X+KikSiSMQqO7lq77jNkYNHD4glxE9ZdxJfaHwTrT7x8UGlDw2u
         znYh3oj/QzagAtLkxeIVwiiMJDb8Uy3DnBTHDuE1xirEQkIi0161weBNJN2UMELvNeXEskDK0CGK
         lbcktlrSHwNpb0AK/NccjSu0m4KFV6+0sWIlFlgWYz5MOHqhA+XRQYP+yEFsCKNviIb/rjGhUx6A
         t644z5attidOmdqBaH4HxXqRRMoXT04/8jVTMJONStMVPkpdkanztoInAGO7ipsXYMBpm14SSwEh
         SQEFXJlb/5aga632co2mO2W34c9aJQOWzG+d6/ag/3k7zMWaI8csbclY25coPFO+eqK2H+8M6emT
         3S0JLbXQX6HIu7sT3zTeqFN2udPdlZzWA47R9aJY+1zWRhu81oFcmtbD2NPjfvqvZuR9EroSd1t1
         AJsEmGhrlFwPImY226Um96MBIRdR/7ckkfX0TbTNTdgvD3tLK7pfK7aaYjuZtLlxJNC5kZi7EoUr
         H5YtylfajZYJ1qlpXUSyiFTJU1J1jD43poR3t2L8fPj5m9RDSidVRe7AOj7KJ0NqFUnccd4yF2a1
         CbN4tM28XBrPJ1kZUHsYy9jnDL8ah44/bgyqLUHZZINO1TBYbNeHknBxEy7FAeEMX+R2DMYEOAML
         pZ/6WWB8OSDmPv2Eqt54WGfsO/hmbKlterP9v13QuFCia5Jp6cz2x2bnbMAlGNo+X2m7MCoTuMWk
         41KWQFBmpOY1HnguKoBjqzLIbq1Iqiou9OnPxWd/+4Kb2DWQ9HHrpCOkCAGMM/uJw8AnOmc87yXw
         UZVUS7/KzyZOnUX3+ScoI5nIBh/pRD8j9iJQHatluPp5cqmUaSJVZjvsinD3g6QNNQIjD0283QuY
         V63WMlOa4AZz9wj6WwZ/c=
From:   xkernel.wang@foxmail.com
To:     jic23@kernel.org, jic23@jic23.retrosnub.co.uk
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] iio: dummy: iio_simple_dummy: check the return value of kstrdup()
Date:   Fri, 17 Dec 2021 11:48:28 +0800
X-OQ-MSGID: <20211217034828.494-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() is also a memory allocation-related function, it return NULL
when some memory errors happen. So it is better to check the return
value of it so to catch the memory error in time. Besides, there should
have a kfree() to clear up the allocation if we get a failure later in
this function to prevent memory leak.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelog:
1. Clean up some error labels(error_ret & error_kzalloc), directly make
them reflect what they are clearing up and return.
2. Clear up indio_dev->name on error path. I put that under label 
`error_free_device`, as kfree(NULL) is safe. Or I may need to add an
another label as the traget of `goto`.
Note: Suggestions are from Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
---
 drivers/iio/dummy/iio_simple_dummy.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index c0b7ef9..430c12a 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -577,7 +577,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
 	if (!swd) {
 		ret = -ENOMEM;
-		goto error_kzalloc;
+		return ERR_PTR(ret);
 	}
 	/*
 	 * Allocate an IIO device.
@@ -589,8 +589,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 */
 	indio_dev = iio_device_alloc(parent, sizeof(*st));
 	if (!indio_dev) {
+		kfree(swd);
 		ret = -ENOMEM;
-		goto error_ret;
+		return ERR_PTR(ret);
 	}
 
 	st = iio_priv(indio_dev);
@@ -616,6 +617,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 *    indio_dev->name = spi_get_device_id(spi)->name;
 	 */
 	indio_dev->name = kstrdup(name, GFP_KERNEL);
+	if (!indio_dev->name) {
+		ret = -ENOMEM;
+		goto error_free_device;
+	}
 
 	/* Provide description of available channels */
 	indio_dev->channels = iio_dummy_channels;
@@ -650,10 +655,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
 error_free_device:
+	kfree(indio_dev->name);
 	iio_device_free(indio_dev);
-error_ret:
 	kfree(swd);
-error_kzalloc:
 	return ERR_PTR(ret);
 }
 
-- 
