Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3254C465
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiFOJPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiFOJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:13:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B4396B2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:13:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h192so10845808pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cApAEWtZBNz7UY2lzjb00JFgiaDz9EH6nqt1F0MvTwA=;
        b=11Ue/j2OxtkuGufH5THsd7RTX2PhW44eGxiMlp4kuhaX8NAQdxItmm+qVby1yX9/8f
         xZMPptt1Jr6zbWnucp4Fo7rNYJ/L7h2w+wae2kSxNgcmRS8AttRSRZ8lyU83JMK/B102
         4VMGvf4jL/ArVxVb4jzUp6zWQg9guosQo+RzXFMu66qJbDYLSHnkEH+W5jt7Y4Myw8LO
         CbtaMOCJ+K3tv4nmU4qqVHBGP3q1/+9KQWB/ZpbY5TZ2W16kTxACGsGFhX3PEfUlfSas
         EKF5JkwCrW7uo7ia/Ttgm3fVHUYaUxeDAQH/fwz9aqMjEJmMEGeGnph4MLnjfiD1OHng
         Tstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cApAEWtZBNz7UY2lzjb00JFgiaDz9EH6nqt1F0MvTwA=;
        b=6VzcGXpotgQDr/ZW3BPgnGgKi+LUt6pg7xO6hyff+aJsBG4cYHY5zt0OEhR5NC3MX2
         3/qZhqs5A1pSRjrcuAltMfMOlMqg4AaeTbC3YAaev+emWaIqHEu5k9uxcLdDdi5bFEjl
         AqPqcatB0umneNaosIu4nNzDI4D7RWpjwxypj7vlij2yGdmFP6hgQ7tyELTQzCQOvVAf
         iUF1lhJ+dr9+dfhs8dWMMxBNqy/RDfwbjnidg8V3pFNv6kOZU6EepuPM8DPuUJT/pCa6
         +XJvfzt38J940nC+U1XyCYlT7/sNOZnU557mTVu0EfcCkZxLEqf9nOGvBtVbqdoFxyrm
         mpkw==
X-Gm-Message-State: AOAM532829kwLiROSgtOQ0hi9RpZBE1WX+aBHtTvyOqpW/+gnho2d5xJ
        aDpBEqNsOpui9OAywJJ1b3uFjQ==
X-Google-Smtp-Source: ABdhPJyXl/iDCJSUxoekdovzpxElEeTc1BQ8vIzuFNVfDzaNgyjhQF6dUsiLz4DbC7uBma8Unp9R6g==
X-Received: by 2002:a63:cf51:0:b0:408:85f4:fb33 with SMTP id b17-20020a63cf51000000b0040885f4fb33mr8084169pgj.589.1655284427786;
        Wed, 15 Jun 2022 02:13:47 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090aaa8300b001e08461ceaesm1188414pjq.37.2022.06.15.02.13.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:13:47 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     helei.sig11@bytedance.com, pizhenwei@bytedance.com
Subject: [PATCH] crypto: testmgr - fix version number of RSA tests
Date:   Wed, 15 Jun 2022 17:13:17 +0800
Message-Id: <20220615091317.36995-1-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

According to PKCS#1 standard, the 'otherPrimeInfos' field contains
the information for the additional primes r_3, ..., r_u, in order.
It shall be omitted if the version is 0 and shall contain at least
one instance of OtherPrimeInfo if the version is 1, see:
	https://www.rfc-editor.org/rfc/rfc3447#page-44

Replace the version number '1' with 0, otherwise, some drivers may
not pass the run-time tests.

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/testmgr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 4d7449fc6a65..d57f24b906f1 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -186,7 +186,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 #ifndef CONFIG_CRYPTO_FIPS
 	.key =
 	"\x30\x81\x9A" /* sequence of 154 bytes */
-	"\x02\x01\x01" /* version - integer of 1 byte */
+	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x41" /* modulus - integer of 65 bytes */
 	"\x00\xAA\x36\xAB\xCE\x88\xAC\xFD\xFF\x55\x52\x3C\x7F\xC4\x52\x3F"
 	"\x90\xEF\xA0\x0D\xF3\x77\x4A\x25\x9F\x2E\x62\xB4\xC5\xD9\x9C\xB5"
@@ -216,7 +216,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	}, {
 	.key =
 	"\x30\x82\x01\x1D" /* sequence of 285 bytes */
-	"\x02\x01\x01" /* version - integer of 1 byte */
+	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x81\x81" /* modulus - integer of 129 bytes */
 	"\x00\xBB\xF8\x2F\x09\x06\x82\xCE\x9C\x23\x38\xAC\x2B\x9D\xA8\x71"
 	"\xF7\x36\x8D\x07\xEE\xD4\x10\x43\xA4\x40\xD6\xB6\xF0\x74\x54\xF5"
@@ -260,7 +260,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 #endif
 	.key =
 	"\x30\x82\x02\x20" /* sequence of 544 bytes */
-	"\x02\x01\x01" /* version - integer of 1 byte */
+	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x82\x01\x01\x00" /* modulus - integer of 256 bytes */
 	"\xDB\x10\x1A\xC2\xA3\xF1\xDC\xFF\x13\x6B\xED\x44\xDF\xF0\x02\x6D"
 	"\x13\xC7\x88\xDA\x70\x6B\x54\xF1\xE8\x27\xDC\xC3\x0F\x99\x6A\xFA"
-- 
2.20.1

