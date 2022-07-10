Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176956CE80
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGJKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 06:12:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADF11164
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 03:12:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id l26so2029021qkl.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAlSk7Pwg1A0jgMjx6Gc85gg7YZgeeJFLs4/wGmrtU0=;
        b=apU6Xxmd6VYWDxSi7FbBrt0RtcA6TJ4FbUzy5NrCylIc0gzoQyOLq81mjqBc43zqDV
         7yxFQwmKA64USn1YHMyDAuTV/AI2t25DawbywpKo2VUlKYjcZb2hhW/URjklBb+R/Apv
         3lZIj+UV2ndybnthxShz105u91opc3DfUi6X8akG8T8K+jIeCunSnPuyzf69ebwu+Wcy
         r0gZnS6WxjCNZ9U8z+i2eodEZKHRsYyxfRYMyIANxxOVJ5byuef9UZS4L6jSUTkqB6aK
         /veyR5RpnNgP3HP7ZIdcKHBfd8hRr09gNuoXlT2cL8iUi+SxrI0GtDgIO4GndEAiTxUi
         9iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAlSk7Pwg1A0jgMjx6Gc85gg7YZgeeJFLs4/wGmrtU0=;
        b=RJMeCNGOOCYiPrHPHYQpi9VVuy6JusHRJJdMLf1RyMClivPHUnEhigKyHGauJKy+x2
         WPRtE6ycQJnxOheP21SC4pv7gogWiLZnyDBSlTv6lKiKDDgfNGtPUJns1cu9DMRSk+F1
         LrA+QyPUT6TnC9DKRN72YLKWa/jYqqJ2YH03Z/qF12sCuXcUIKpxA5PJPD8YLnutCF6R
         wSviC/lBY9e3Bdw97+OcJpzc3T8eh9XCBIh5ULwJiMnTYsXoFdshp3T9OTf1cDoBNyL+
         tmCLEyQrUN/I4YK+ga4Y+/pjlc8MztWxDB0k8udBul43Q+Q2Uo+C+EB2XJDVl9fEdmwX
         5YEw==
X-Gm-Message-State: AJIora+0Ww83jHow6HmF20oGfw/BhqisXzqHtgVzXYHU5qHpuP3KwbyL
        98H/uUSN1iXqgcZPfhVWpRg=
X-Google-Smtp-Source: AGRyM1tS2AVT/JAVWxWn+q97o/js98jVzUFMZVduc7weH/lQw+L006BwbMlfKzclBY7KOBIBDwRiSQ==
X-Received: by 2002:a05:620a:4399:b0:6b5:8672:8111 with SMTP id a25-20020a05620a439900b006b586728111mr136966qkp.324.1657447923623;
        Sun, 10 Jul 2022 03:12:03 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id cb25-20020a05622a1f9900b0031b7441b02asm3136496qtb.89.2022.07.10.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 03:12:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Date:   Sun, 10 Jul 2022 12:11:56 +0200
Message-Id: <20220710101156.26139-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The use of kmap() is being deprecated in favor of kmap_local_page().

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).

Call kmap_local_page() in firmware_loader wherever kmap() is currently
used. In firmware_rw() use the copy_{from,to}_page() helpers instead of
open coding the local mappings plus memcpy().

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/base/firmware_loader/main.c  | 4 ++--
 drivers/base/firmware_loader/sysfs.c | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ac3f34e80194..7c3590fd97c2 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -435,11 +435,11 @@ static int fw_decompress_xz_pages(struct device *dev, struct fw_priv *fw_priv,
 
 		/* decompress onto the new allocated page */
 		page = fw_priv->pages[fw_priv->nr_pages - 1];
-		xz_buf.out = kmap(page);
+		xz_buf.out = kmap_local_page(page);
 		xz_buf.out_pos = 0;
 		xz_buf.out_size = PAGE_SIZE;
 		xz_ret = xz_dec_run(xz_dec, &xz_buf);
-		kunmap(page);
+		kunmap_local(xz_buf.out);
 		fw_priv->size += xz_buf.out_pos;
 		/* partial decompression means either end or error */
 		if (xz_buf.out_pos != PAGE_SIZE)
diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index 5b0b85b70b6f..10ae9c8fb6cf 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -247,14 +247,13 @@ static void firmware_rw(struct fw_priv *fw_priv, char *buffer,
 		int page_ofs = offset & (PAGE_SIZE - 1);
 		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
 
-		page_data = kmap(fw_priv->pages[page_nr]);
-
 		if (read)
-			memcpy(buffer, page_data + page_ofs, page_cnt);
+			memcpy_from_page(buffer, fw_priv->pages[page_nr],
+					 page_ofs, page_cnt);
 		else
-			memcpy(page_data + page_ofs, buffer, page_cnt);
+			memcpy_to_page(fw_priv->pages[page_nr], page_ofs,
+				       buffer, page_cnt);
 
-		kunmap(fw_priv->pages[page_nr]);
 		buffer += page_cnt;
 		offset += page_cnt;
 		count -= page_cnt;
-- 
2.36.1

