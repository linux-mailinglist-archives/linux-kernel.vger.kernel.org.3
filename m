Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F189A54F167
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380375AbiFQHIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380395AbiFQHIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:08:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689286351E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso3843317pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cApAEWtZBNz7UY2lzjb00JFgiaDz9EH6nqt1F0MvTwA=;
        b=dR9rWk3waDmeKxQcyL8H0k64uqciC8n0wtkRXIZxFhuK2nVsmOkbK6xOoiGhpHSJyw
         WLIkpsrdUUJVIV9bKUPgx3Qzq5YEPZOFTq1kJ1lGppP5YDCSiJoqzJzKw+TLrPCsMDGQ
         1nQbKEVRuNmjys9xN1xWtJsfN6+ukvj3WxfLIg2rtYrdDH9Oppe37V68QYA4t2l6wlCi
         InL4SP1zVFATQHq/6qDpdv2z2UnzwsjSDIkjbFJYV82BxTnotaHH80gY4XgIg4jM06Zw
         EXVra94ehrosHdxx5zBJL3O3jOGfDi3rs8v3rrwvqEvEIGQ5vn8fT844DhQDqBiiBT5O
         4/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cApAEWtZBNz7UY2lzjb00JFgiaDz9EH6nqt1F0MvTwA=;
        b=ehX2Ge8xX41tTQ1Gg2yePJnqQ0wT+2H7Wx2Rk5QTMFzp/KJ5KiASq2ZIDSYoLWYsUC
         Wd3e70i8xY1+DIkk3NtxCcfqT1rANopiGF1upaZXHGOXxnz3VHLtsBKlr+NHpl24Eq+g
         dJlHyE58Zc1uYlSnoYvRJ8ZYrMVDoiOtafdKkKy352zuqB9cmk2napM9G6yV4RirsPCS
         jWgKMTrK0KP9j21MRpO8uPt2uf0xUubBGiW27+m1Z08KwKEpBc4QtfFEubdYB3JZCgDN
         ZV5X2RvPGZd3kHNPXTT15yikorTMufEFIWb5xXASLirVxeHXFY/zicK9CC2oypfMvAcT
         aV+A==
X-Gm-Message-State: AJIora9vHfr0TKTZaNkeF7/AOFq4pl8h6V5zN0M0YoVU4HAE6vzNYmYF
        iO8fwuD9xTbvc3u4TBPFTP3TAg==
X-Google-Smtp-Source: AGRyM1uc6BuGBJYpgcs6b3WTSw7pXBPAi/H5+9kHNGCgpTbVpq2ef8kHRnF44eQ6TeWExmA5Q8wz5w==
X-Received: by 2002:a17:902:e751:b0:163:d8d9:8440 with SMTP id p17-20020a170902e75100b00163d8d98440mr8417293plf.12.1655449702093;
        Fri, 17 Jun 2022 00:08:22 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00163d4c3ffabsm2757868plr.304.2022.06.17.00.08.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:08:21 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mst@redhat.com
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, helei.sig11@bytedance.com,
        f4bug@amsat.org, berrange@redhat.com
Subject: [PATCH] crypto: testmgr - fix version number of RSA tests
Date:   Fri, 17 Jun 2022 15:07:51 +0800
Message-Id: <20220617070754.73667-3-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220617070754.73667-1-helei.sig11@bytedance.com>
References: <20220617070754.73667-1-helei.sig11@bytedance.com>
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

