Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404014723A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhLMJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:20:03 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:38801 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhLMJUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639387194;
        bh=iXySGmvIpQzWI4D8XoRDI/HDa44G0b/wjLssIbrND2Y=;
        h=From:To:Cc:Subject:Date;
        b=qpUlXSYXLcz5/J2A26NozvxVvWCYTkpFIrGwjPDU23XmYyZB7Pr79ToNpR2VnEptG
         PmSrDW2LuARc5cTa926nI2OrRCgM5Xt+MuynjgLEYCmIGuyGC2xGfUcBvhzW73uAiK
         AFkC5NXmGoN/bLL9xgTx1NqGa1cPh8jwOQC3lfH8=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 4A50DAE9; Mon, 13 Dec 2021 17:18:37 +0800
X-QQ-mid: xmsmtpt1639387117tv1l2czg7
Message-ID: <tencent_4014A4E1394AA4FF7620EBCC47B9701C9D08@qq.com>
X-QQ-XMAILINFO: N+Pibzc9GW0I8UZfkKkQBKlPoY+0TlzoUtocKK4tFyfEBMoXbI50fZyFESnScU
         0aZQXXywfx3UuluRRhwsxmniB3jT72eazqKn7h53K5MGfR/Xf2QRIj3PuBqt2T01rANVrNlseQOJ
         90+g5vDpL2lo37cPH/hDpkEDTYd5SSjIZCCV1K/akp83YR9MmylU3yp5T/1ezmfGq1IkEzwUJ3CS
         UK+73Ng2VmvzgXeSnwH22yoDeFxijoe4gr+YjGKseBZXYGd2ds8aXvMbFS6vxLAEvCZlNLA6cmz9
         0vGRo5/CfApBqlNb4rQmtl8at8/YUIU1zo1qDFOHcQFxrlxYnBAUABv1MXZ6dBDJPG/bFJUJxFH3
         a3SXdNAykTuixGyeQgeYB6jwjnwuVeUk8fHLrJ+Z0gX6MTneN+ZHsP723+EbV8lUsw+CQDVPoB68
         pqDmDcoZLKTlCOaom9cwNnOvh5PFQdGVGtoVaUuABSSyDSVNjg+xHOMNLwmn9fyuXwATPDz77kaJ
         d0RDOOY2CH6RFm7Y8EJjeqOagDmVe8BmiXnSFUezGGKZCnOet4R+pPTvfMdNTsgGmN1wkCuuh9G0
         ZI4SbWV/W/cL80nNcf8evTbzWd1Dh7ue3NAIUzMqbsDZb2lWtPcVl8wi5bIC+3zgMIJoB4gyk5Ug
         E7PaCUOsSptxZHry2YU0FC96Eh2axet6d3NWWMGjaD0cqDWeWzE6QzAyzWg0suAgCEtfzGS/Ma7P
         MFiFIS3a1m+gil/MkXeu0xUme91y/XsAhVl/CiUfE4qGIPXHKVWRsDLbOsBhJ2j6fw3LeB03v0IG
         4ornMto8LJ3EAnwTxPIK+6YUN6DbSmQaJdJxHMhY2ON+6BCSITO8B9dvlfu5T6AOqvEoiovI/+bq
         +elOrbYZwbdRLJOoD6nc0+vzRSTfbvaSpPCBjC0JAddwL+Ih4fPBWX6//G4ZpPPg==
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] iio: dummy: iio_simple_dummy: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 17:18:21 +0800
X-OQ-MSGID: <20211213091821.4803-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() is also a memory allocation-related function, it return NULL
when some memory errors happen. So it is better to check the return
value of it so to catch the memory error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index c0b7ef9..a5e8071 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -616,6 +616,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 *    indio_dev->name = spi_get_device_id(spi)->name;
 	 */
 	indio_dev->name = kstrdup(name, GFP_KERNEL);
+	if (!indio_dev->name) {
+		ret = -ENOMEM;
+		goto error_free_device;
+	}
 
 	/* Provide description of available channels */
 	indio_dev->channels = iio_dummy_channels;
-- 
