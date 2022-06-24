Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9198555974F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiFXKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiFXKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:06:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2007A1BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:06:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r1so1684761plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzjfNYKrqhxMk1VlBLe96xLY69I5gRU2mkadogGFCrg=;
        b=OzviWgi3D4BmXgdNyxDqNp8wdki7LTNyu3yYxle8BEe3w71ardsjbbrclGRMuM/m/7
         2r/AbJQUOgMqd8A4Tag765+P+gThOQ9fPbjaAHaO/RYqf0yBCoeaJRJM1ZjJQMuPFeDd
         m/SArk3X1y8TgqfmK96SRrMbrMwCCxcmAb2VqyLsgQmO9v/Sl2rzcn2fP6R3WQVomgqy
         3Uqpe4jdMRjf2j+RQZwftcg/UEctsx5+MaR9VUs001xJeduTsdXslSEiQVYiZn+Zl8RI
         +mRC0PRoMNwZcA8CrXxDoHQYN+fdlrZqTUnDIQg2dTUP2w1D41eAEQKGlHOMz5O2/M7A
         U3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzjfNYKrqhxMk1VlBLe96xLY69I5gRU2mkadogGFCrg=;
        b=BXnRg1cv0LA//aO6laPwNDvkcNQtGnjKq9jSN+M8eAeKKln74I0GRj1yEyM6cvEoo3
         UtPy2Dj/mNQfT5znbAqB/KN07fKIjO69UclhPYTENaEqM8fVzp6wbZbAS/SZIujXGJVj
         y0E+WNGH/sG2reZDbXVq9njPJ6ZLEgjfsLO4R0hPorPopoTDjmuhTTSbS5FqokeK+cbL
         ivLrceW4Qa+/ArGSF2s6t52gq/mFxxVGZObAB/VArrcBelsg87fCCkUvdxa7a9O99Ibw
         6SGi0WuXHuv+6b7y/bY97m85hhOSke3w4KbgfnzQSrtH/xAHnodXaABvRC9MCy1zWWyD
         Yqwg==
X-Gm-Message-State: AJIora+FpjDFslTchWi8qC/SyKZu/oNtXDZFthTwqSzgX9az5NGC9SPV
        4ATWdzQVJQTfgfeIQV9V2YBrJByJ/txF0Q==
X-Google-Smtp-Source: AGRyM1uySwk12x2mLWZbElv72CElvZkfYQ6iIOcOv5LdUrY1Og+VC6WHLWukYFQNKSRZdNH6X1NHbw==
X-Received: by 2002:a17:902:bb95:b0:169:4d7:fee with SMTP id m21-20020a170902bb9500b0016904d70feemr41038819pls.80.1656065198159;
        Fri, 24 Jun 2022 03:06:38 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b0015e8d4eb2b4sm1366397plb.254.2022.06.24.03.06.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:06:37 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH] crypto: testmgr - fix version number of RSA tests
Date:   Fri, 24 Jun 2022 18:06:25 +0800
Message-Id: <20220624100625.47844-1-helei.sig11@bytedance.com>
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

base-commit: 92f20ff72066d8d7e2ffb655c2236259ac9d1c5d
-- 
2.20.1

