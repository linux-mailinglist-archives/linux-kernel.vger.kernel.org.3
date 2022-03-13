Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98374D75B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiCMOLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiCMOLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4258213F72
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647180622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MMcgGN1d46ct1NbvGOl+Qm+VZTfIF+7Jk+6dqdt2QoE=;
        b=XSlBmL3LhgBXS2zADSahDT7o6MN0IBuuxyv+b3iAix0hVPI178w1EYsAFYmZa/g40NsglM
        UDPVf+9dWeg5wSxrwbntEhEZRaib58GxTThvyP5YPfD9ehNANsKUnF9ys1PhMMy09SIsQx
        yhvmSCF/G87v5dOadjfY/5drmeb0dC8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-uxO8hkgFP8SHFH8_EICX8A-1; Sun, 13 Mar 2022 10:10:21 -0400
X-MC-Unique: uxO8hkgFP8SHFH8_EICX8A-1
Received: by mail-ot1-f70.google.com with SMTP id w7-20020a9d6747000000b005b25c9036fdso9980996otm.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMcgGN1d46ct1NbvGOl+Qm+VZTfIF+7Jk+6dqdt2QoE=;
        b=uaXdXsWK9M5Z+3LXRUik8ZilEYnsasoLCoL8bP7zwLtf0nwwXvHEpcWlweUgVdOvZd
         IvIeoiNCBo5enHjgsiIAenrdqJtEWTvbcx3mcxiyksQs1r1zXVB7muOh02MW4mVJaEn4
         Xw3XyRoB0lP4fGWttU/mKF6xS2eVccaClQDa381RbFZZHJ8nQOizSns+ydQ/9jvt8Eg+
         pEuJlSVcFmscgVNkCF/BCjYMb3Okw98eKCI+bHxERcm+cw8Kd31N1D+CzZ2ZlaD5sgtk
         Im9PaI5UYY07mCXjBDBXdUAhFbj+uWb3KGrfSyEtrJNPjdKD/aEw5aseBOiUxnb+KzyL
         0E6A==
X-Gm-Message-State: AOAM532XX4+jGRd0Y70SxMOX3hJKKXfHZpRZJseYXq1O6Yh4FOYAA9RN
        VFSdtCkAdvesI2eaUzcIZi9duXKpPOPbs4dUAcGyUg9uiIi4W8nx1UbFaK/fJoZ+CsJPdfPJdHa
        VFGeF0dmpH3iBJg5lVH6T7SrR
X-Received: by 2002:a05:6870:4210:b0:da:196d:a1fd with SMTP id u16-20020a056870421000b000da196da1fdmr14983877oac.224.1647180620316;
        Sun, 13 Mar 2022 07:10:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuAJNKiCUf9C/raP//IDNlp0tLxNgl5XjfJIqdIEs+cMF9S5wL9AzvDa1j2HVcO5dQD0AMpA==
X-Received: by 2002:a05:6870:4210:b0:da:196d:a1fd with SMTP id u16-20020a056870421000b000da196da1fdmr14983867oac.224.1647180620019;
        Sun, 13 Mar 2022 07:10:20 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p4-20020a056870a54400b000da07609a6dsm5503105oal.22.2022.03.13.07.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 07:10:19 -0700 (PDT)
From:   trix@redhat.com
To:     noralf@tronnes.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/repaper: combine allocs in repaper_spi_transfer()
Date:   Sun, 13 Mar 2022 07:10:08 -0700
Message-Id: <20220313141008.1503638-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repaper_spi_transfer() allocates a single byte
for the spi header and then another buffer for
the payload.  Combine the allocs into a single
buffer with offsets.  To simplify the offsets
put the header after the payload.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/tiny/repaper.c | 40 ++++++++++------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 37b6bb90e46e1..22a6732f35a01 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -100,50 +100,34 @@ static inline struct repaper_epd *drm_to_epd(struct drm_device *drm)
 static int repaper_spi_transfer(struct spi_device *spi, u8 header,
 				const void *tx, void *rx, size_t len)
 {
-	void *txbuf = NULL, *rxbuf = NULL;
 	struct spi_transfer tr[2] = {};
-	u8 *headerbuf;
+	u8 *buf;
 	int ret;
 
-	headerbuf = kmalloc(1, GFP_KERNEL);
-	if (!headerbuf)
+	buf = kmalloc(1 + len, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	headerbuf[0] = header;
-	tr[0].tx_buf = headerbuf;
+	buf[len] = header;
+	tr[0].tx_buf = &buf[len];
 	tr[0].len = 1;
 
-	/* Stack allocated tx? */
-	if (tx && len <= 32) {
-		txbuf = kmemdup(tx, len, GFP_KERNEL);
-		if (!txbuf) {
-			ret = -ENOMEM;
-			goto out_free;
-		}
+	if (tx) {
+		memcpy(buf, tx, len);
+		tr[1].tx_buf = buf;
 	}
 
-	if (rx) {
-		rxbuf = kmalloc(len, GFP_KERNEL);
-		if (!rxbuf) {
-			ret = -ENOMEM;
-			goto out_free;
-		}
-	}
+	if (rx)
+		tr[1].rx_buf = buf;
 
-	tr[1].tx_buf = txbuf ? txbuf : tx;
-	tr[1].rx_buf = rxbuf;
 	tr[1].len = len;
 
 	ndelay(80);
 	ret = spi_sync_transfer(spi, tr, 2);
 	if (rx && !ret)
-		memcpy(rx, rxbuf, len);
-
-out_free:
-	kfree(headerbuf);
-	kfree(txbuf);
-	kfree(rxbuf);
+		memcpy(rx, buf, len);
 
+	kfree(buf);
 	return ret;
 }
 
-- 
2.26.3

