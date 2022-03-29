Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43574EA78F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiC2F5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiC2F53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:57:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0423D588
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:55:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h23so23179174wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lp6iFcVQQfN6RB1G5twPiDqbYeVPiefY9x2TyOoT1Lo=;
        b=ViQll1CKhjxzTW1n2Vrc7m+gaQSejBQC5RnFdieKXLkHgNnyfCsP1zIt7sxaOWvzji
         CdfS8mTV8gM9Iedi2NKvCWF9urVA+EqAiJpqyMXXAssDgWrC1ZdaWi3qA0lQCGvI5Vdk
         45MDiLFKmDNQSKp9Zw4NW/oDDd4y8QsLmT8/zSRnNPb9P2wkG6Tlo31rBQlpbKXHSHV9
         RBgfOTaFq7LHsl8h3DqDtVi2NqIjrRBchDAd4U+PJeRjCifYVDI7iHlwUHAQ8cUseVAL
         Rs/EVZ2fmAFEkkwx6hgpxKS51VjBKUSVCFL/ga9NjDBqqTlFX99ayUdxbei9laS3cyuv
         tFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lp6iFcVQQfN6RB1G5twPiDqbYeVPiefY9x2TyOoT1Lo=;
        b=uPWMUBB3L3Ojl8J6MJCxiVhdTZNAReN9HPBgVVC/HFlAGcsl3EGhd1Oby+NsNJxMM8
         Xwj4Y8dKd5hzOzxlf58dQTNY+Z+166Gcnc7B8kXpXLeB2ZcRrWer9SJe8zQVJozsbU7G
         HQASQMINp/jL52gnfU06SoGgEFOAnAwsHLm7m1uz1vHHD2d5lfH/+SGz5zox51N8VKJC
         HfxxvTV+g+Yujp5UfjSyXwbNm4nc5OlYAY0KXPB0DexgCHNQ3ZsFK9m0Cf2RVF1JTlAg
         /o6im7hGwtaWKFmXxTWRpDt0kV69JM69wOF6q4sU18DmgxSBbEn1uPizn423l9yLxsTk
         n+Ew==
X-Gm-Message-State: AOAM531mR2+QUsn2RcxaGSZ9Ew17wG2H5g02SKz8AA4TS3wJiJQmVp/Z
        QuL0im3duMakUmUDPSfwcQE=
X-Google-Smtp-Source: ABdhPJxWGBSOJPkXKd7AjnRno9Xor5TPQgfWQJbe5VcF9z0USi9NW7m8DhKdyuDe3ssVKrP4H7qY0g==
X-Received: by 2002:a5d:584f:0:b0:204:1749:2ce7 with SMTP id i15-20020a5d584f000000b0020417492ce7mr28885199wrf.584.1648533344729;
        Mon, 28 Mar 2022 22:55:44 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b00203f2828075sm13865382wrr.19.2022.03.28.22.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 22:55:43 -0700 (PDT)
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
        outreachy@lists.linux.dev, ira.weiny@intel.com
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: rts5208: Convert kmap() to kmap_local_page()
Date:   Tue, 29 Mar 2022 07:55:39 +0200
Message-Id: <20220329055539.29299-1-fmdefrancesco@gmail.com>
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

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 -> v2: Rework the commit message and use the appropriate helpers
instead of open coding the use of kmap_local_page()/kunmap_local_page().
(Many thanks to Ira Weiny <ira.weiny@intel.com>).

 drivers/staging/rts5208/rtsx_transport.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 805dc18fac0a..56b6cc845619 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -92,13 +92,11 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			while (sglen > 0) {
 				unsigned int plen = min(sglen, (unsigned int)
 						PAGE_SIZE - poff);
-				unsigned char *ptr = kmap(page);
 
 				if (dir == TO_XFER_BUF)
-					memcpy(ptr + poff, buffer + cnt, plen);
+					memcpy_to_page(page + poff, 0, buffer + cnt, plen);
 				else
-					memcpy(buffer + cnt, ptr + poff, plen);
-				kunmap(page);
+					memcpy_from_page(buffer + cnt, page + poff, 0, plen);
 
 				/* Start at the beginning of the next page */
 				poff = 0;
-- 
2.34.1

