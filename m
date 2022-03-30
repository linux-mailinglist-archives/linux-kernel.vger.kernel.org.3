Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154894EC69C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346912AbiC3Of1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346893AbiC3OfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:35:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71724161D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:33:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dr20so41889633ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYeSRhL4EJ9kSjRef+3ZDgUv5eRzmfmbrcZOn+mT5cQ=;
        b=ByVj0awv3/ZKRFds4TIlXaEjOC213gnC/dsMTaTQtZw+cwLgR1OMv4LtfQ26nkhV/n
         L62vIfDajYdNXaNr2oHb9LUPwLg32m7+HnZLmdcRd4o7JLE6+ijC8SPd1UQ3bYJYPh93
         KgKm+iijnBLydGJgg9AclIlxR1Ikhoy9GcaGwqup0FwT6At4zii4UapWKJ3VUIVZe73M
         8RGmv6XGmszVo0X1oyUWpdCApg5JAmZbRd0O1CgaKPdTG9BvLkDm86irEMrrNIBrl3aP
         8o8kBwBz2ByYhnvtzrB3QN5BhEmjzNfCevBW9hcYZb3rXXKpH2fcD9xd5vE+vfZMIfWe
         DVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYeSRhL4EJ9kSjRef+3ZDgUv5eRzmfmbrcZOn+mT5cQ=;
        b=mkDsRDrFM8Mj83ui+hKkfqU19FHTstfFFWd7oPvDb1pYQn62wQHV5rwVa2aAII2+cN
         HaGwWKXHW4nblozW5GIsMTdef3l9PDnHPe9HD1CYHegNkyzAZtWeTyB72A3DN4kfnsLp
         uvtf7NmkgS2R5FC8EiWKVFHlJnZzIsqg3Viqowx+dP9xZjGDYzilUiH3J62/89qvRH/p
         y+DiQe/hBD1SW/M5N0nrdScvrInIww6X1iz6Hq0x1a3rA9s81lJrfpiG5WYSD0kgT394
         mdDWfqso62XTR00Twl41bgMjNh+hdNnxdK40EE8Zk0QtDF6HIblRv9IUZdMtkBXxpDXa
         8SWQ==
X-Gm-Message-State: AOAM533+oDeNn3/fizFJ+5BirkMuMzrLSxh8lOytek0BXcukns6hkQyh
        Qo0cpQ4zrsyEeTV7fz5HBbc=
X-Google-Smtp-Source: ABdhPJwgs/G9LRh561o9F93/Of7ZKFv9d4D65V/c+PfKjEaQdtjtvqaZ2eEvROGfRAYDtVOvsttR1w==
X-Received: by 2002:a17:907:6da6:b0:6e0:bb24:f731 with SMTP id sb38-20020a1709076da600b006e0bb24f731mr29818767ejc.25.1648650816253;
        Wed, 30 Mar 2022 07:33:36 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090674c200b006e13403964asm2069249ejl.77.2022.03.30.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:33:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Colin Ian King <colin.king@intel.com>,
        =?UTF-8?q?Samuel=20Sj=C3=B6berg?= <info@samuelsjoberg.se>,
        Charlie Sands <sandsch@northvilleschools.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>, ira.weiny@intel.com,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4] staging: rts5208: Convert kmap() to kmap_local_page()
Date:   Wed, 30 Mar 2022 16:33:31 +0200
Message-Id: <20220330143331.8306-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Therefore rtsx_stor_access_xfer_buf() is a function
where the use of kmap_local_page() in place of kmap() is correctly
suited.

Convert to kmap_local_page() but, instead of open coding it, use the
helpers memcpy_to_page() and memcpy_from_page().

Make a minor change to a comment related to scatter-gather.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 -> v2: Rework the commit message and use the appropriate helpers
instead of open coding the use of kmap_local_page()/kunmap_local_page().
(Thanks to Ira Weiny <ira.weiny@intel.com>).

v2 -> v3: Use memcpy_{to,from}_page() arguments correctly.
(Thanks to Dan Carpenter <dan.carpenter@oracle.com>).

v3 -> v4: According to a suggestion by Ira Weiny, change the test
of a comment related to the use of scatter-gather.

 drivers/staging/rts5208/rtsx_transport.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 805dc18fac0a..d5ad49de4c56 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -55,9 +55,9 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 		*offset += cnt;
 
 	/*
-	 * Using scatter-gather.  We have to go through the list one entry
-	 * at a time.  Each s-g entry contains some number of pages, and
-	 * each page has to be kmap()'ed separately.
+	 * Using scatter-gather. We have to go through the list one entry
+	 * at a time. Each s-g entry contains some number of pages which
+	 * have to be copied one at a time.
 	 */
 	} else {
 		struct scatterlist *sg =
@@ -92,13 +92,11 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			while (sglen > 0) {
 				unsigned int plen = min(sglen, (unsigned int)
 						PAGE_SIZE - poff);
-				unsigned char *ptr = kmap(page);
 
 				if (dir == TO_XFER_BUF)
-					memcpy(ptr + poff, buffer + cnt, plen);
+					memcpy_to_page(page, poff, buffer + cnt, plen);
 				else
-					memcpy(buffer + cnt, ptr + poff, plen);
-				kunmap(page);
+					memcpy_from_page(buffer + cnt, page, poff, plen);
 
 				/* Start at the beginning of the next page */
 				poff = 0;
-- 
2.34.1

